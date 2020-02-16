
HEADER <- c(
"| [Welcome](index.md) | [Papers](papers.md) | [Links](links.md) | [Workflow](workflow.md) | [Glossary](glossary.md) |
    
# Papers
    
The papers listed are ordered chronologically by year.
"
)

papersRaw <- readLines("JabRef/papers_in.txt")

periodsAll <- lapply(papersRaw, function(x) substr(x, 3, 6))
periodsAll[which(periodsAll <= "1990")] <- paste0(min(unlist(periodsAll)), "-1990")
periods <- unique(periodsAll)

papers <- lapply(papersRaw, function(x) substr(x, 10, nchar(x)))

out <- NULL
for (i in seq_along(periods)) {
  per <- periods[[i]]
  out <- c(out, paste0("**", per, "**", "\n"))
  for (paper in papers[which(periodsAll == per)]) {
    out <- c(out, paste0("* ", paper, "\n"))
  }
  if (i != length(periods)) out <- c(out, "&nbsp;\n")
  # out <- c(out, "\n\n")
}

out <- c(HEADER, out)

con <- file("docs/papers.md")
writeLines(out, con, sep = "\n")
close(con)

