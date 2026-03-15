; Classes
(class_definition) @fold

; Functions and methods
(function_definition) @fold

; Docstrings
(expression_statement
  (string)) @fold

; Import blocks
((import_statement)+) @fold
((import_from_statement)+) @fold

; Fold __main__ entrypoint
(
  (if_statement
    condition: (_) @cond
  ) @fold
  (#match? @cond "__name__")
  (#match? @cond "__main__")
)
