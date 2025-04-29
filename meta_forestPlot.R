# perform fixed-effect meta-analysis
# Estimate, Standard_Error, Apoe_Genotype are from differential analysis
m = meta::metagen(
    # Estimate of treatment effect
    Estimate,
    # Standard error of treatment estimate
    Standard_Error,
    # data
    data = dft,
    # we meta-analysis by APOE genotype
    studlab = Apoe_Genotype,
    # fixed-effect meta-analysis
    comb.fixed = TRUE,
    # wouldn't use random-effect meta-analysis
    comb.random = FALSE,
    # don't predict
    prediction = FALSE,
    # standardised mean difference
    sm="SMD",
    # total sample size in study
    n.e = N
  )

# forest plot
meta::forest(
    # object from meta
    m, 
    
    ## the measures to display on left side of plot
    # variables to display
    leftcols = c("studlab", "n.e"), 
    # assign the title to display for the variables
    leftlabs = c("APOE Genotype", "N"), 
    # Label to be used in table heading
    lab.e = "Global AD Pathology", 
    # A character specifying the column name where label label.e should be attached to in table heading
    lab.e.attach.to.col = "n.e",
    
    ## the measures to display on right side of plot
    # variables to display
    rightcols = c("w.fixed", "effect.ci"), 
    # assign the title to display for the variables
    rightlabs = c("Weight", "Estimate [95% CI]"),
    
    # specifying gap between columns printed on left side of forest plot
    colgap.left = unit(32, "mm"),
    # minimal number of significant digits for between-study variance
    digits.tau2 = 2, 
    # make the x-axis symmetric
    xlim = "s",
    # A logical indicating whether text for heterogeneity statistics should be considered to calculate width of the column with study labels
    calcwidth.hetstat = TRUE,
    # the title printed at top of figure
    smlab = paste0("Standardised Mean", "\nDifference"),
    # fontface of figure title
    ff.smlab = "bold",
    # additional texts we want to put in figure
    text.addline1 = paste(
      "p-value =", 
      # pvalue from meta-analysis
      format_pvalue(dft$P.value[1], 3, 1), 
      ", FDR p-value =", 
      # fdr pvalue from meta-analysis
      format_pvalue(dft$estimated_local_FDR[1], 3, 1) 
      )
)