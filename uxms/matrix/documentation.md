## Components

There is only one component for showing one matrix table for each tables on the frontend.
You just need to add `Matrix Table` Component to a page which you want to show on.


## Codes you will use
- `{% component 'matrixTable' %}` is enough for showing the rendered table.
- Also you can find all data of the same model of the matrix table by `{{ matrixTable.tableData }}` method


## Styling the table

Rendered html template is suitable with Bootstrap's table directives. Here is the scheme for a rendered table:

```
<table class="table table-bordered table-hover uxms-table">
    <thead>
        <tr>
            <th></th>
            <th colspan="4" style="text-align: center;">COLUMNS TOP NAME (DESCRIPTION)</th>
        </tr>
        <tr>
            <th></th>
            <th><span>COLUMN NAME 1</span></th>
            <th><span>COLUMN NAME 2</span></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="list-checkbox">ROW NAME 1</td>
            <td>
                <div>ROW DATA 1</div>
            </td>
            <td>
                <div>ROW DATA 2</div>
            </td>
        </tr>
    </tbody>
</table>
```

As you can see, you can handle elements by selecting ``.uxms-table`` in your CSS codes.

i.e.: ``.uxms-table thead th {text-align: center;}`` 
