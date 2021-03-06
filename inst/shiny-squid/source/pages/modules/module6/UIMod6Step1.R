# UI: Module 6 Step 1
span( 
  
    h4(Mod6Step1_txt$title),           # Text: title
    
    p(HTML(Mod6Step1_txt$subgoal)),    # Text: subgoal
    p(HTML(Mod6Step1_txt$intro)),      # Text: introduction
    p(HTML(Mod6Step1_txt$exercise)),    # Text: exercise
    
    p(paste0("$$",NOT$trait.1,"_",NOT$ind,"=
            (",EQ3$mean0,"+
            ",NOT$devI,"_",NOT$ind,")+
            ",EQ3$mean1,NOT$env,"_{",NOT$time, NOT$ind,"}+
            ",NOT$error,"_{",NOT$time, NOT$ind,"}$$")),
    
    p(HTML(Mod6Step1_txt$para1)),    # Text: paragraph 1
    
    p(paste0("$$",NOT$trait.1,"_",NOT$ind,"=
            (",EQ3$mean0,"+
            ",NOT$devI,"_",NOT$ind,")+
            (",EQ3$mean1,"+", NOT$devS,"_", NOT$ind,")", NOT$env,"_{",NOT$time, NOT$ind,"}+
            ",NOT$error,"_{",NOT$time, NOT$ind,"}$$")),
    
    p(HTML(Mod6Step1_txt$para2)),    # Text: paragraph 2
    
    # Number of individuals
    getSliderInput("Mod6Step1_NI", Modules_VAR$NI),
    
    # Number of trait expressions sampled
    getSliderInput("Mod6Step1_NR", Modules_VAR$NR),
    
    # Among-individual variance (Vi)
    getSliderInput("Mod6Step1_Vi", Modules_VAR$Vi),
    
    # Measurement error variance
    getSliderInput("Mod6Step1_Ve", Modules_VAR$Ve),
    
    # Variance of Mean Environment effects in the slope (V Beta1 X1)
    getSliderInput("Mod6Step1_Vbx", Modules_VAR$Vb1x1),
    
    #Individual-specific response to an environmental effect (random slopes) variance (VS) :
    getSliderInput("Mod6Step1_Vs", Modules_VAR$Vs),

    # Hidden variable:
    conditionalPanel(
      condition = "0",
      uiOutput("Mod6Step1_hidden")
    ),
    
    (HTML(Mod6Step1_txt$para3)),    # Text: paragraph 3
    
    p(),
    # Simulation run button
    actionButton("Mod6Step1_Run", label = Modules_VAR$Run$label, icon= Modules_VAR$Run$icon, class="runButton"),
    runningIndicator(),
    p(),
    
    (HTML(Mod6Step1_txt$results)),    # Text: results
    
    # Table : display true and measured values (Vp, Vi and mean)
    uiOutput("Mod6Step1_summary_table"),
    
    (HTML(Mod6Step1_txt$para4)),    # Text: paragraph
    
    # Phenotype against environment figure
    p(plotOutput("Mod6Step1_plot", width = Modules_VAR$Plot$width)),
    
    p(HTML(Mod6Step1_txt$point)),   # Text: point
    
    p(HTML(module1_txt$statModTitle)),
    p(paste0("$$",NOT$trait.1,"_",NOT$ind,"=
            (",EQ3$mean0,"+
             ",NOT$devI,"_",NOT$ind,")+
             (",EQ3$mean1,"+", NOT$devS,"_", NOT$ind,")", NOT$env,"_{",NOT$time, NOT$ind,"}+
             ",NOT$error,"_{",NOT$time, NOT$ind,"}$$")),
    p(paste0("$$V_p=
            V_",NOT$devI,"+
            V_{",EQ3$mean1,NOT$env,"}+
            V_{",NOT$devS,NOT$env,"}+
            V_",NOT$error,"$$")),
    
    p("Where"),
    p(paste0("$$V_{",EQ3$mean1,NOT$env,"}=",EQ3$mean1,"^2V_",NOT$env,"$$")),
    p(paste0("$$V_{",NOT$devS,NOT$env,"}=V_",NOT$devS,"V_",NOT$env,"+E(",NOT$env,")V_",NOT$devS,"$$")),
    p(paste0("Note that $V_",NOT$env,"$ is the true variance in ",NOT$env,", and E(",NOT$env,") is the true mean of ",NOT$env,".")),
    
    div(class="line"),
    
    # Go to next step
    actionLink("Mod6Step1GotoStep2",
             label = "Next Step (2) >>",
             class= "linkToModuleSteps")
)