/*
 * Backup class
 *
 * Dependencies:
 * - Waterfall plugin (waterfall.js)
 */

+function ($) {
    "use strict";

    var BackupProcess = function () {

        // Init
        this.init()
    }

    BackupProcess.prototype.init = function () {
        this.activeStep = null
        this.backupSteps = null
    }

    BackupProcess.prototype.execute = function (steps) {
        this.backupSteps = steps
        this.runBackup()
    }

    BackupProcess.prototype.runBackup = function (fromStep) {
        $.waterfall.apply(this, this.buildEventChain(this.backupSteps, fromStep))
            .fail(function (reason) {
                var
                    template = $('#executeFailed').html(),
                    html = Mustache.to_html(template, {reason: reason})

                $('#executeActivity').hide()
                $('#executeStatus').html(html)
            })
    }

    BackupProcess.prototype.retryBackup = function () {
        $('#executeActivity').show()
        $('#executeStatus').html('')

        this.runBackup(this.activeStep)
    }

    BackupProcess.prototype.buildEventChain = function (steps, fromStep) {
        var self = this,
            eventChain = [],
            skipStep = fromStep ? true : false

        $.each(steps, function (index, step) {

            if (step == fromStep)
                skipStep = false

            if (skipStep)
                return true // Continue

            eventChain.push(function () {
                var deferred = $.Deferred()

                self.activeStep = step
                self.setLoadingBar(true, step.label)

                $.request('onExecuteStep', {
                    data: step,
                    success: function (data) {
                        setTimeout(function () {
                            deferred.resolve()
                        }, 600)

                        if (step.code == 'completeBackup' || step.code == 'completeRestore')
                            this.success(data)
                        else
                            self.setLoadingBar(false)
                    },
                    error: function (data) {
                        self.setLoadingBar(false)
                        deferred.reject(data.responseText)
                    }
                })

                return deferred
            })
        })

        return eventChain
    }

    BackupProcess.prototype.setLoadingBar = function (state, message) {
        var loadingBar = $('#executeLoadingBar'),
            messageDiv = $('#executeMessage')

        if (state)
            loadingBar.removeClass('bar-loaded')
        else
            loadingBar.addClass('bar-loaded')

        if (message)
            messageDiv.text(message)
    }

    if ($.oc === undefined)
        $.oc = {}

    $.oc.backupProcess = new BackupProcess;

}(window.jQuery);