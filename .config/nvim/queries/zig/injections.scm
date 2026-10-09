; Markdown injections in doc comments
((doc_comment) @injection.content
  (#set! injection.language "markdown")
  (#set! injection.include-children))

((container_doc_comment) @injection.content
  (#set! injection.language "markdown")
  (#set! injection.include-children))
