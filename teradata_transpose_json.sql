-- Example how to read json into teradata table

SELECT * FROM JSON_Table 
(ON (SELECT 0 as id, NEW JSON('{"menu": {
  "id": "file",
  "value": "File",
  "popup": {
    "menuitem": [
      {"value": "New", "onclick": "CreateNewDoc()"},
      {"value": "Open", "onclick": "OpenDoc()"},
      {"value": "Close", "onclick": "CloseDoc()"}
    ]
  }
}}') as jsonCol )
USING rowexpr('$.menu.popup.menuitem[*]')
               colexpr('[ {"jsonpath" : "$.value",
                           "type" : "VARCHAR(5)"},
                          {"jsonpath" : "$.onclick",
                           "type" : "VARCHAR(20)"}]')
) AS JT(id, "Value", "OnClick");
