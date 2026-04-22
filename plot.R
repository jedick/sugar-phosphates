# Make T-pH and P-pH diagrams for Gibbs energy of phosphorylation reactions,
# using mosaic() to account for pH-dependent speciation

# Developed by D. LaRowe and J. Dick, 2025-2026

# Code setup
# Use CHNOSZ >= 2.2.0-13 to calculate affinity of phosphorylation reactions 
# with pH-dependent speciation (see ?CHNOSZ::phosphorylate)
library(CHNOSZ)
if (!packageVersion("CHNOSZ") >= "2.2.0-13") stop("CHNOSZ >= 2.2.0-13 is required")

# Data setup
# Add updates for sugars and related species to OBIGT
inew <- add.OBIGT("sugars.csv")

# Wrapper function around phospho_plot() to create a PDF for a given reaction
# number is the reaction number (used as prefix for the plot PDF)
plotfun <- function(reactant, P_source, number = "") {
  # Setup figure
  file <- paste0(gsub(" ", "_", reactant), "+", gsub(" ", "_", P_source), ".pdf")
  if(number != "") file <- paste(number, file, sep = "_")
  pdf(file, width = 9, height = 6)
  # Make plots
  DG <- phospho_plot(reactant, P_source)
  dev.off()
  # Return the reactant, P_source, and standard transformed Gibbs energy (ΔG°') at pH 7
  list(reactant, P_source, DG)
}

# High-level function to make plots for numbered reaction
plotnum <- function(reaction) {
  result <- switch(reaction,
    # Reaction 1: acetic acid + P = acetylphosphate + H2O
    plotfun("acetic acid", "P", "01"),
    # Reaction 2: acetic acid + PP = acetylphosphate + P
    plotfun("acetic acid", "PP", "02"),
    # Reaction 3: ADP + acetylphosphate = ATP + acetate
    plotfun("ADP", "acetylphosphate", "03"),
    # Reaction 4: adenosine + acetylphosphate = AMP + acetate
    plotfun("adenosine_to_AMP", "acetylphosphate", "04"),
    # Reaction 5: AMP + acetylphosphate = ADP + acetate
    plotfun("AMP", "acetylphosphate", "05"),
    # Reaction 6: glycerol + P = 1-glycerolphosphate + H2O
    plotfun("glycerol", "P", "06"),
    # Reaction 7: glycerol + PP = 1-glycerolphosphate + P
    plotfun("glycerol", "PP", "07"),
    # Reaction 8: uridine + PP = UMP + P
    plotfun("uridine", "PP", "08"),
    # Reaction 9: adenosine + P = cAMP + H2O
    plotfun("adenosine_to_cAMP", "P", "09"),
    # Reaction 10: ribose + P = ribose-5-phosphate + H2O
    plotfun("ribose", "P", "10"),
    # Reaction 11: ribose + PP = ribose-5-phosphate + P
    plotfun("ribose", "PP", "11"),
    # Reaction 12: ribose + acetylphosphate + ribose-5-phosphate + acetate
    plotfun("ribose", "acetylphosphate", "12"),
    # Reaction 13: ribose + ATP = ribose-5-phosphate + ADP
    plotfun("ribose", "ATP", "13"),

    # Other reactions (not in the table)
    # Reaction 14: adenosine + H3PO4 = AMP + H2O
    plotfun("adenosine_to_AMP", "P", "14"),
    # Reaction 15: AMP + ATP = ADP + ADP
    plotfun("AMP", "ATP", "15"),
    # Reaction 16: glucose + ATP = glucose-6-phosphate + ADP
    plotfun("glucose", "ATP", "16"),
    # Reaction 17: pyruvic acid + ATP = phosphoenolpyruvate + ADP
    plotfun("pyruvic acid", "ATP", "17"),
    # Reaction 18: ADP + P = ATP + H2O
    plotfun("ADP", "P", "18"),
  )
  if(is.null(result)) stop(paste("Reaction", reaction, "is not defined"))
  # Return the result
  result
}

# Function to make plots for all reactions and save values of ΔG°'
plotall <- function(reaction = 1:17) {
  results <- lapply(reaction, plotnum)
  # Put together results in a data frame
  reactant <- sapply(results, "[[", 1)
  P_source <- sapply(results, "[[", 2)
  DG <- round(sapply(results, "[[", 3), 3)
  out <- data.frame(reaction, reactant, P_source, DG)
  colnames(out)[4] <- "ΔG°'(pH = 7)"
  write.csv(out, "reaction_DG.csv", row.names = FALSE)
}
