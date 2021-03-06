# UI: Module 1 Step 1
span(
    
    h4(Mod1Step1_txt$title),           # Text: title
    
    p(HTML(Mod1Step1_txt$subgoal)),    # Text: subgoal
    p(HTML(Mod1Step1_txt$intro)),      # Text: introduction
    p(HTML(Mod1Step1_txt$exercise)),   # Text: exercise
    
    # Number of individuals
    getSliderInput("Mod1Step1_NI", Modules_VAR$NI),

    p(HTML(Mod1Step1_txt$para1)),      # Text: Paragraph 1
    
    # Measurement error variance
    getSliderInput("Mod1Step1_Ve", Modules_VAR$Ve),
    
    # Hidden variable:
      # Mod1Step1_Vind: Intercepts and slopes (Co)variance matrix
    conditionalPanel(
      condition = "0",
      uiOutput("Mod1Step1_hidden")
    ),
    
    p(),
    # Simulation run button
    actionButton("Mod1Step1_Run", label = Modules_VAR$Run$label, icon= Modules_VAR$Run$icon, class="runButton"),
    runningIndicator(), # Simulation progress bar
    p(),
    
    # Output
      # Graph: density distribution of true and measured phenotypic values
      plotOutput("Mod1Step1_plot", width = Modules_VAR$Plot$width),
      
      # Table : display true and measured values (Vp, Vi and mean)
      uiOutput("Mod1Step1_summary_table"),
      
      p(HTML(Mod1Step1_txt$point)),       # Text: point
      p(HTML(Mod1Step1_txt$solutions)),   # Text: solutions
      
      # display statistical model
      p(HTML(module1_txt$statModTitle)),
      p(paste("$$",NOT$trait.1,"_",NOT$ind,"=",NOT$devI,"_",NOT$ind,"+",NOT$error,"_",NOT$ind,"$$",sep="")),
      p(paste("$$V_p=V_",NOT$devI,"+V_",NOT$error,"$$",sep="")),
    
    div(class="line"),
    
    # Go to next step
#     bsButton("Mod1Step1GotoStep2", 
#              label = "Next Step (2) >>",
#              style = Modules_VAR$StepLink$style)

    actionLink("Mod1Step1GotoStep2", 
             label = "Next Step (2) >>",
             class= "linkToModuleSteps")
)