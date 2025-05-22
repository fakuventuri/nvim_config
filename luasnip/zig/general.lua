return {
    s({ trig = "extern", desc = "extern struct" },
        fmta([[
            const <> = extern struct {
                <>
            };
        ]], { i(1), i(0) })
    ),
    s({ trig = "inline", desc = "inline fn" },
        fmta([[
            inline fn <>(<>) <> {
                <>
            };
        ]], { i(1), i(2), i(3), i(0) })
    ),
    s({ trig = "export", desc = "export fn" },
        fmta([[
            export fn <>(<>) <> {
                <>
            };
        ]], { i(1), i(2), i(3), i(0) })
    ),
}
