-- s({trig=";mint", snippetType="autosnippet"}

local get_visual = require("utils.snippets").get_visual

return {
    s({ trig = ";v", snippetType = "autosnippet", desc = "vert" },
        fmta( [[ \verb|<>| ]],
            { d(1, get_visual) }
        )
    ),
    s({ trig = ";env", snippetType = "autosnippet", desc = "general environment" },
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            { i(1), i(0), rep(1) }
        )
    ),
    s({ trig = ";mint", snippetType = "autosnippet", desc = "minted environment" },
        fmta(
            [[
                \begin{minted}{<>}
                    <>
                \end{minted}
            ]],
            { i(1), i(0) }
        )
    ),
    s({ trig = ";hr", snippetType = "autosnippet", dscr = "Hyperref (for url links)" },
        fmta(
            [[\href{<>}{<>}]],
            { i(1, "url"), i(2, "display name"), }
        )
    ),
}
