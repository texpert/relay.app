import hljs from "highlight.js"

import { Controller } from "."

export const ContentController = ({target}) => {
  const syntaxHighlight = (el) => {
    hljs.highlightElement(el)
  }

  const modifyAnchors = (el) => {
    if (el.origin === window.location.origin)
      return
    el.setAttribute("target", "_blank")
    el.setAttribute("rel", "noreferrer noopener")
  }

  const enhance = (root = target) => {
    root.querySelectorAll("pre code").forEach(syntaxHighlight)
    root.querySelectorAll("a").forEach(modifyAnchors)
  }

  return Controller({enhance})
}
