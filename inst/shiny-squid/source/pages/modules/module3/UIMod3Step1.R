# UI: Module 3 Step 1
span(
  
  h4(Mod3Step1_txt$title),           # Text: title
  
  p(HTML(Mod3Step1_txt$subgoal)),    # Text: subgoal
  p(HTML(Mod3Step1_txt$intro)),      # Text: introduction
  p(HTML(Mod3Step1_txt$exercise)),   # Text: exercise

  p(HTML(Mod3Step1_txt$para1)),      # Text: paragraph 1
  
  # Among-individual variance (Vi)
  getSliderInput("Mod3Step1_Vi", Modules_VAR$Vi),
  # getNumericInput("Mod3Step1_Vi", Modules_VAR$Vi, "Mod3Step1_error_Vi"),
  
  # Measurement error variance
  getSliderInput("Mod3Step1_Ve", Modules_VAR$Ve),

  conditionalPanel(
    condition = "0",
    uiOutput("Mod3Step1_hidden")
  ),
  
  p(HTML(Mod3Step1_txt$para2)),      # Text: paragraph 2
  
  # Variance of Mean Environment effects in the slope (V Beta1 X1)
  getSliderInput("Mod3Step1_Vbx", Modules_VAR$Vb1x1),
        
  p(HTML(Mod3Step1_txt$para3)),       # Text: paragraph 3
  
  # Figure of 2 examples of sampling design when among-individual variance in sampling timing is 0.1 and 0.9
  p(HTML(
    paste('<figure>
          <img src="pictures/Vit_examples.jpg" width="800px" height="296px" alt="Examples of among-individual variance in timing of sampling">
          <figcaption><b>Figure:</b> two examples of 4 individuals that are sampled 5 times each and that among-individual variance in timing of sampling ($',general_VAR$btwIndVarTimSamp,'$) is 0.1 (left) and 0.9 (right).</figcaption>
          </figure>',sep=""))
  ),
  
  p(HTML(Mod3Step1_txt$para4)),       # Text: paragraph 4
  
  # Number of records (NR)
  getSliderInput("Mod3Step1_NR", Modules_VAR$NR),
  getSliderInput("Mod3Step1_Vhsi", Modules_VAR$Vhsi),
  
  p(HTML(Mod3Step1_txt$para5)),       # Text: paragraph 5
  
  actionButton("Mod3Step1_previewPlot", label = Modules_VAR$Refresh$label, icon= Modules_VAR$Refresh$icon),
  # bsButton("Mod3Step1_previewPlot", label = Modules_VAR$Refresh$label, icon= Modules_VAR$Refresh$icon, style = Modules_VAR$Refresh$style),
  p(),
  plotOutput("Mod3Step1_previewPlot", width = Modules_VAR$Plot$width),
  
  
  p(),
  # Simulation run button
  actionButton("Mod3Step1_Run", label = Modules_VAR$Run$label, icon= Modules_VAR$Run$icon, class="runButton"),
  runningIndicator(),
  p(),
  
  p(HTML(Mod3Step1_txt$results)),     # Text: results
  
  p(HTML(Mod3Step1_txt$para6)),       # Text: para6
  
  p(paste0("$$",NOT$trait.1,"_{",NOT$time,NOT$ind,"}=",NOT$devI,"_",NOT$ind,"+",NOT$error,"_{",NOT$time,NOT$ind,"}$$")),
  
  p(HTML(Mod3Step1_txt$para7)),       # Text: para7
  uiOutput("Mod3Step1_summary_table"),
  
  p(HTML(Mod3Step1_txt$para8)),       # Text: para8
  
  p(HTML(Mod3Step1_txt$conclusion)),  # Text: conclusion
  
  p(HTML(Mod3Step1_txt$para9)),       # Text: para9
  p(HTML(Mod3Step1_txt$para10)),      # Text: para10
  p(HTML(Mod3Step1_txt$para11)),      # Text: para11

  div(class="line"),
  
  # Go to next step
  actionLink("Mod3Step1GotoStep2",
           label = "Next Step (2) >>",
           class= "linkToModuleSteps")
)