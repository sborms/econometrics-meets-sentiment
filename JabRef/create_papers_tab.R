
### TODO: don't overwrite non-JabRef collaborative entries if any
### TODO: deal in JabRef parsing with special symbols (e.g. \" in naïve)
### TODO: make links open in new tab!

HEADER <- paste0(
c("
| [Welcome](index.md) | [Papers](papers.md) | [Links](links.md) | [Workflow](workflow.md) | [Glossary](glossary.md) |
    
# Papers
    
The papers listed are ordered chronologically by year. **Last update**: "), 
paste0(format(Sys.Date(), "%B %d, %Y"), "."),
"\n"
)

papersRaw <- readLines("JabRef/papers_in.txt")

periodsAll <- lapply(papersRaw, function(x) substr(x, 3, 6))
periodsAll[which(periodsAll <= "1990")] <- paste0(min(unlist(periodsAll)), "-1990")
periods <- unique(periodsAll)

papers <- lapply(papersRaw, function(x) substr(x, 10, nchar(x)))

out <- NULL
for (i in seq_along(periods)) {
  per <- periods[[i]]
  out <- c(out, paste0("### ", per, "\n"))
  for (paper in papers[which(periodsAll == per)]) {
    out <- c(out, paste0("* ", paper))
  }
  if (i != length(periods)) out <- c(out, "")
}

out <- c(HEADER, out, "")

con <- file("docs/papers.md")
writeLines(out, con, sep = "\n")
close(con)

