#' run SQuID without graphical user interface
#'
#' @description          simulates a world inhabited by individuals whose phenotypes are generated by a user-defined 
#'                       phenotypic equation and then samples from this world according to a user-defined sampling design. 
#'                       If this is your first experience with SQuID, we highly recommend to start with the SQuID app 
#'                       in order to learn and get more familiarized with the SQuID model and its sampling design (use the function \code{\link{squidApp}}).
#' 
#' @param input          A list of the model input parameters (see Details).
#' @param plot           logical; If \code{FALSE} (default), \code{squidR} does not include the simulation plots into the output list (see Value).
#' @param module         A character of the module name. This argument is only used by SQuID app.
#' @param X_previsualization A character of the environment name. This argument is only used by SQuID app.
#'
#' @return
#' \code{squidR} returns a \code{list} that includes a \code{data.frame} of the full data generated, a \code{data.frame} 
#' of the sampled data and six \href{https://cran.r-project.org/web/packages/ggplot2/index.html}{ggplot2} plots of the results (only if \code{plot} is set to \code{TRUE}).
#' 
#' The full and the sampled data could be accessed respectively by \code{output$full_Data} and \code{output$sampled_Data}.
#' A description of the columns of the full and the sampled \code{data.frame} is provided below:
#' 
#'   \itemize{
#'    \item \code{Replicate}. factor; the replicated population identification.
#'    \item \code{Individual}. factor; the individual identification.
#'    \item \code{Trait}. factor; the trait identification.
#'    \item \code{Time}. integer; the time step value.
#'    \item \code{Phenotype}. numeric; the individual phenotype.
#'    \item \code{Beta0}. numeric; the population phenotypic mean.
#'    \item \code{Beta1}. numeric; the population mean response to environmental influences x1.
#'    \item \code{Beta2}. numeric; the population mean response to environmental influences x2.
#'    \item \code{Beta12}. numeric; the population mean response to environmental influences x1x2 (the interaction between the environmental effect x1 and the environmental effect x2).
#'    \item \code{I}. numeric; the individual-specific deviations (random-intercepts) from the population phenotypic mean \code{Beta0}.
#'    \item \code{S1}. numeric; the individual-specific response to the environmental influence x1 (random-slope).
#'    \item \code{S2}. numeric; the individual-specific response to the environmental influence x2 (random-slope).
#'    \item \code{S12}. numeric; the individual-specific response to the environmental influence x1x2 (the interaction between the environmental effect x1 and the environmental effect x2; random-slope).
#'    \item \code{X1}. numeric; the environmental gradient x1.
#'    \item \code{X2}. numeric; the environmental gradient x2.
#'    \item \code{X1X2}. numeric; the environmental gradient x1x2 (the interaction between the environmental effect x1 and the environmental effect x2).
#'    \item \code{G}. numeric; the higher-level grouping value.
#'    \item \code{e}. numeric; the measurement error.
#'   }
#'   
#' \code{squidR} returns a list that also includes a list (\code{$myPlot}) of six \href{https://cran.r-project.org/web/packages/ggplot2/index.html}{ggplot2} plots of the results. Note that the plots display only the data of the first trait, the first replicate and the first 20 individuals of the simulation.
#' 
#' \itemize{
#'    \item \code{$myPlot$plot_X1}. A plot of the environmental gradient x1. 
#'    \item \code{$myPlot$plot_X2}. A plot of the environmental gradient x2. 
#'    \item \code{$myPlot$plot_X1X2}. A plot of the environmental gradient x1x2 (the interaction between the environmental effect x1 and the environmental effect x2). 
#'    \item \code{$myPlot$plot_TotPhen}. A plot of the raw individual phenotype over time.
#'    \item \code{$myPlot$plot_SampPhen}. A plot of the sampled individual phenotype over time.
#'    \item \code{$myPlot$plot_SampTime}. A plot of the sampling time of each individual.
#' }
#'
#' @details 
#' A detailed description of the SQuID model and its sampling design is provided on the SQuID app (run SQuID app with \code{\link{squidApp}}). Reading the SQuID documentation on the SQuID app is prerequisite to use properly the SQuID R function. 
#' 
#' The argument \code{input} is a list that contains the different input parameters to the SQuID model. 
#' All the parameters are listed below including their default value and a short description. 
#' If a parameter is not declared within the \code{input} list, the default value will be used. 
#' 
#' 
#' \tabular{lllll}{
#'  \strong{Parameter name} \tab     \tab \strong{Default value} \tab     \tab \strong{Description} \cr
#'  \tab \tab \tab \tab \cr
#'  \code{Tmax} \tab \tab 1 \tab \tab positive \code{integer}; the duration of the simulation (number of time steps). \cr
#'  \tab \tab \tab \tab \cr
#'  \code{NP}   \tab \tab 1 \tab \tab positive \code{integer}; the number of replicated populations. 
#'                          The replicated populations are generated independently 
#'                          using the same simulation design that has been initially 
#'                          inputted by the user. Note that data from different 
#'                          populations will be saved in the same output file that
#'                          you could later use to run statistical analyses. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{NI}   \tab \tab 1 \tab \tab positive \code{integer}; the number of individuals in each sampled population. 
#'                          \code{NI} must be divisible by the number of higher-level groups (\code{NG}). \cr
#'  \tab \tab \tab \tab \cr                          
#'  \code{NT}   \tab \tab 1 \tab \tab positive \code{integer}; the number of traits for each individual. SQuID allows a maximum of 2 traits. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{NG}   \tab \tab 1 \tab \tab positive \code{integer}; the number of higher-level groups. \code{NG} must be lower than the number of individuals. \cr
#'  \tab \tab \tab \tab \cr
#'  
#'  \code{X1_state}     \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, 
#'                                             an environmental effect x1 will be added to the model equation.  \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_sto_state} \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE},
#'                                             a stochastic environmental effect will be added to the environmental effect x1.
#'                                             The stochastic environmental effect values have a normal distribution around 0 and a variance of \code{X1_sto_V}. \cr
#'  \tab \tab \tab \tab \cr                                             
#'  \code{X1_sto_shared}\tab \tab \code{TRUE}  \tab \tab \code{logical}; if \code{TRUE}, 
#'                                             the stochastic environmental effect included in the environmental effect x1 
#'                                             will be shared between individuals. 
#'                                             If \code{FALSE}, each individual will experience a different stochastic 
#'                                             environmental effect within the environmental effect x1 
#'                                             (i.e. a new stochastic environmental effect is generated for each individual).\cr
#'  \tab \tab \tab \tab \cr                                             
#'  \code{X1_sto_V}     \tab \tab 1            \tab \tab \code{numeric}; the variance used to generate a normal distributed 
#'                                             stochastic environmental effect within the environmental effect x1.\cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_sto_autocor_state} \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, an autocorrelation effect will be 
#'                                                     added to the stochastic environemental effect within the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr                                                     
#'  \code{X1_sto_corr}          \tab \tab 0            \tab \tab \code{numeric}; the correlation value ranging from 0 to 1 
#'                                                     that characterizes the magnitude of the temporal autocorrelation between two consecutive time steps. \cr
#'  \tab \tab \tab \tab \cr                                                     
#'  \code{X1_lin_state}     \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, a linear trend will be added the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_lin_shared}    \tab \tab \code{TRUE}  \tab \tab \code{logical}; if \code{TRUE}, 
#'                                             the linear trend included in the environmental effect x1 
#'                                             will be shared between individuals. 
#'                                             If \code{FALSE}, each individual will experience a different linear trend 
#'                                             within the environmental effect x1. 
#'                                             A new linear trend is generated for each individual by varying the intercept 
#'                                             and the slope of the linear equation fowlling a normal distribution where 
#'                                             the mean is the intercept and the slope value itself and the variance is \code{X1_lin_V}. \cr
#'  \tab \tab \tab \tab \cr                                             
#'  \code{X1_lin_intercept} \tab \tab 0            \tab \tab \code{numeric}; the intercept of the linear trend included into the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_lin_slope}     \tab \tab 1            \tab \tab \code{numeric}; the slope of the linear trend included into the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_lin_V}         \tab \tab 1            \tab \tab \code{numeric}; the variance used to generate different (unshared) linear trend effect for each individual within the environmnetal effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_cyc_state}     \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, a cyclic trend will be added the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_cyc_shared}    \tab \tab \code{TRUE}  \tab \tab \code{logical}; if \code{TRUE}, 
#'                                                 the cyclic trend included in the environmental effect x1 
#'                                                 will be shared between individuals. 
#'                                                 If \code{FALSE}, each individual will experience a different cyclic trend 
#'                                                 within the environmental effect x1.
#'                                                 A new cyclic trend is generated for each individual by varying the amplitude, 
#'                                                 the period, the horizontal shif and the vertical shift 
#'                                                 of the cyclic equation following a normal distribution where 
#'                                                 the mean is the parameter value itself and the variance is \code{X1_cyc_V}. \cr
#'  \tab \tab \tab \tab \cr                                                 
#'  \code{X1_cyc_amplitude} \tab \tab 10           \tab \tab positive \code{numeric}; the amplitude of the cyclic trend included into the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_cyc_period}    \tab \tab 10           \tab \tab positive \code{numeric}; the period of the cyclic trend included into the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_cyc_Hshift}    \tab \tab 0            \tab \tab positive \code{numeric}; the horizontal shift of the cyclic trend included into the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_cyc_Vshift}    \tab \tab 0            \tab \tab positive \code{numeric}; the vertical shift of the cyclic trend included into the environmental effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X1_cyc_V}         \tab \tab 0            \tab \tab \code{numeric}; the variance used to generate different (unshared) cycluc trend effect for each individual within the environmnetal effect x1. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_state}     \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, 
#'                                             an environmental effect x2 will be added to the model equation.  \cr
#'  \tab \tab \tab \tab \cr                                             
#'  \code{X2_sto_state} \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE},
#'                                             a stochastic environmental effect will be added to the environmental effect x2.
#'                                             The stochastic environmental effect values have a normal distribution around 0 and a variance of \code{X2_sto_V}. \cr
#'  \tab \tab \tab \tab \cr                                             
#'  \code{X2_sto_shared}\tab \tab \code{TRUE}  \tab \tab \code{logical}; if \code{TRUE}, 
#'                                             the stochastic environmental effect included in the environmental effect x2 
#'                                             will be shared between individuals. 
#'                                             If \code{FALSE}, each individual will experience a different stochastic 
#'                                             environmental effect within the environmental effect x2 
#'                                             (i.e. a new stochastic environmental effect is generated for each individual).\cr
#'  \tab \tab \tab \tab \cr                                             
#'  \code{X2_sto_V}     \tab \tab 1            \tab \tab \code{numeric}; the variance used to generate a normal distributed 
#'                                             stochastic environmental effect within the environmental effect x2.\cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_sto_autocor_state} \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, an autocorrelation effect will be 
#'                                                     added to the stochastic environemental effect within the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr                                                     
#'  \code{X2_sto_corr}          \tab \tab 0            \tab \tab \code{numeric}; the correlation value ranging from 0 to 1 
#'                                                     that characterizes the magnitude of the temporal autocorrelation between two consecutive time steps. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_lin_state}     \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, a linear trend will be added the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_lin_shared}    \tab \tab \code{TRUE}  \tab \tab \code{logical}; if \code{TRUE}, 
#'                                             the linear trend included in the environmental effect x2 
#'                                             will be shared between individuals. 
#'                                             If \code{FALSE}, each individual will experience a different linear trend 
#'                                             within the environmental effect x2. 
#'                                             A new linear trend is generated for each individual by varying the intercept 
#'                                             and the slope of the linear equation fowlling a normal distribution where 
#'                                             the mean is the intercept and the slope value itself and the variance is \code{X2_lin_V}. \cr
#'  \tab \tab \tab \tab \cr                                              
#'  \code{X2_lin_intercept} \tab \tab 0            \tab \tab \code{numeric}; the intercept of the linear trend included into the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_lin_slope}     \tab \tab 1            \tab \tab \code{numeric}; the slope of the linear trend included into the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_lin_V}         \tab \tab 1            \tab \tab \code{numeric}; the variance used to generate different (unshared) linear trend effect for each individual within the environmnetal effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_cyc_state}     \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, a cyclic trend will be added the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_cyc_shared}    \tab \tab \code{TRUE}  \tab \tab \code{logical}; if \code{TRUE}, 
#'                                                 the cyclic trend included in the environmental effect x2 
#'                                                 will be shared between individuals. 
#'                                                 If \code{FALSE}, each individual will experience a different cyclic trend 
#'                                                 within the environmental effect x2.
#'                                                 A new cyclic trend is generated for each individual by varying the amplitude, 
#'                                                 the period, the horizontal shif and the vertical shift 
#'                                                 of the cyclic equation following a normal distribution where 
#'                                                 the mean is the parameter value itself and the variance is \code{X2_cyc_V}. \cr
#'  \tab \tab \tab \tab \cr                                                 
#'  \code{X2_cyc_amplitude} \tab \tab 10           \tab \tab positive \code{numeric}; the amplitude of the cyclic trend included into the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_cyc_period}    \tab \tab 10           \tab \tab positive \code{numeric}; the period of the cyclic trend included into the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_cyc_Hshift}    \tab \tab 0            \tab \tab positive \code{numeric}; the horizontal shift of the cyclic trend included into the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_cyc_Vshift}    \tab \tab 0            \tab \tab positive \code{numeric}; the vertical shift of the cyclic trend included into the environmental effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X2_cyc_V}         \tab \tab 0            \tab \tab \code{numeric}; the variance used to generate different (unshared) cycluc trend effect for each individual within the environmnetal effect x2. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{X_Interaction}    \tab \tab \code{FALSE} \tab \tab \code{logical}; if \code{TRUE}, 
#'                                                 the environmental effect x1*x2 representing the interaction between the environmental 
#'                                                 effect x1 and the environmental effect x2 will be added to the model equation. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{B} \tab \tab c(0,0,0,0) \tab \tab \code{vector}; the population mean values. When the number of trait is set to 1, the lenght of the vector is 4. 
#'                                          The vector elements are respectively the mean population at the intercept (b0),
#'                                          the population mean response to environmental influences x1 (fixed slope; b1), the population mean response to environmental influences x2 (fixed slope; b2) and 
#'                                          the population mean response interaction to two environmental influences x1x2 (fixed slope; b12). If the number of trait is set to 2, the lenght of the vector 
#'                                          is doubled (len=8) and the second half corresponds to the population mean values associated with the second trait.\cr
#'  \tab \tab \tab \tab \cr
#'  \code{Vind}  \tab \tab matrix(0, nrow=4, ncol=4) \tab \tab square \code{matrix} (lower triangular \code{matrix}); the individual variance/correlation matrix.
#'                                                              Variances are positive \code{numeric} numbers and correlations are \code{numeric} numbers ranged between -1 and 1. 
#'                                                              Variances are along the matrix diagonal and correlation values below the matrix diagonal. 
#'                                                              When the number of trait is set to 1, the dimension of the matrix is 4 rows by 4 columns (4x4) and 
#'                                                              the diagonal elements are respectively the individual-specific deviation (random intercept) variance (VI),
#'                                                              the individual-specific response to an environmental effect x1 (random slope) variance (VS1), 
#'                                                              the individual-specific response to an environmental effect x2 (random slope) variance (VS2)
#'                                                              and the individual-specific response interaction to two environmental effects x1 and x2 (random slopes) variance (VS12).
#'                                                              When the number of trait is set to 2, the dimension of the matric is doubled (8x8) where the second half of the diagonal is 
#'                                                              the individual variances (intercept and slopes) of the second trait. Note that it is possible to set correlation relationships between random effects within and/or among traits.\cr
#'  \tab \tab \tab \tab \cr
#'  \code{Ve}         \tab \tab  0           \tab \tab  positive \code{numeric}; the measurement error variance. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{VG}         \tab \tab  0           \tab \tab  positive \code{numeric}; the high-level grouping variance. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{NR}         \tab \tab  1           \tab  \tab  positive \code{integer}; the number of records sampled in average per individual. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{Vhsi}       \tab \tab  0           \tab \tab  \code{numeric} (between 0 and 0.95); the among-individual variance in timing of sampling. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{NR_ind}     \tab \tab  \code{TRUE} \tab \tab  \code{logical}; if \code{TRUE}, individuals will be sampled the same number of times. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{NR_trait}   \tab \tab  \code{TRUE} \tab \tab  \code{logical}; if \code{TRUE}, traits within individuals will be sampled the same number of times. \cr
#'  \tab \tab \tab \tab \cr
#'  \code{ST_ind}     \tab \tab  \code{TRUE} \tab \tab  \code{logical}; if \code{TRUE}, individuals will be sampled at the same time.\cr
#'  \tab \tab \tab \tab \cr
#'  \code{ST_trait}   \tab \tab  \code{TRUE} \tab \tab  \code{logical}; if \code{TRUE}, traits within individuals will be sampled at the same times. \cr
#'  \tab \tab \tab \tab \cr
#'  \strong{Parameter name} \tab \tab \strong{Default value} \tab \tab \strong{Description}
#' }
#' 
#' @seealso \code{\link{squidApp}} to run the SQuID app which includes detailed documentation on the SQuID model and its sampling design. 
#'         
#' @examples                                                                                                                             
#' ## create the input list ##
#' input <- list()
#' 
#' ## define the model input parameters ##
#' 
#' input$Tmax <- 100 # 100 time steps
#' input$NP   <- 10  # 10 replicated populations
#' input$NI   <- 20  # 20 individuals per replicate population
#' input$NT   <- 1   # 1 trait per individual
#' 
#' # in this simulation model, only one environmental gradient (x1) is added
#' input$X1_state      <- TRUE  # turn on the environmental gradient x1
#' input$X1_sto_state  <- TRUE  # add a stochastic environmental effect to the environmental effect x1
#' input$X1_sto_shared <- FALSE # the stochastic environmental effect included into the environmental effect x1
#'                              # is not shared among individual. 
#'                              # Each individual will experience a  different stochastic environmental effect.                  
#' 
#' input$X1_sto_autocor_state <- FALSE #  add an autocorrelation effect to the stochastic environmental effect within the environmental effect x1.
#' input$X1_sto_corr          <- 0.5 # define the autocorrelation value between two consecutive time steps.
#' 
#' input$X1_lin_state <- TRUE # add a linear trend to the environmental effect x1. 
#'                            # the default parameters for the linear trend will be used 
#'                            # (an intercept of 0, a slope of 1 and the linear trend will be shared among individuals)
#'
#' # define the population mean values vector.
#' # the population mean (fixed intercept) and
#' # the population mean response to environmental influences x1 (fixed slope) 
#' # are set to 0.1.
#' input$B    <- c(0.1, 0.1, 0, 0)
#'                                                   
#' # define the individual variance/correlation matrix (squared matrix; 4x4)
#' # the individual-specific deviation (random intercept; VI) variance is set to 0.7.
#' # the individual-specific response to an environmental effect x1 (random slope; VS1) is set to 0.5.
#' # the correlation between the individual-specific deviation (I) and the individual-specific response 
#' # to an environmental effect x1 (S1) is set to -0.7.                                                     
#' input$Vind <- matrix(c(0.7  , 0   , 0 , 0,
#'                        -0.7 , 0.5 , 0 , 0,
#'                        0    , 0   , 0 , 0,
#'                        0    , 0   , 0 , 0), nrow = 4)
#'                        
#' input$Ve  <- 0.05 # the measurement error variance
#' 
#' ## define the sampling design ##
#' 
#' input$NR     <- 10    # the mean number of records per individual
#' input$Vhsi   <- 0.2   # the among-individual variance in timing of sampling
#' input$NR_ind <- FALSE # individuals are not sampled the same number of times.
#' input$ST_ind <- FALSE # individuals are not sampled at the time
#' 
#' ## run the model ##
#' 
#' output <- squidR(input, plot=TRUE)
#' 
#' # plot the individual phenotype values over time
#' print(output$myPlot$plot_TotPhen) 
#'
#' @import data.table
#' @export
#' 
squidR <- function(input=list(), plot=FALSE, module=NULL, X_previsualization=NULL){ 
  
  # Main function of the full model that simulates individual phenotypes over time
  # and then samples within those phenotypes according to specific sampling design
  #
  # Args:
  #   input: list contains all the inputs used to run the model 
  #          (for more details see setEnvironments and setVariables functions).
  #   module: name of the module.
  
  # Returns:
  #   Return a list with:
  #     full_Data   : continous phenotypic data (raw data)
  #     sampled_Data: sampled phenotypic data
  #     myPlot      : plots of the simulation results
  
  ##############################################################
  #################### INPUT VARIABLES  ########################
  ##############################################################  
  
  # Set seperator character
  sep <- ifelse(is.null(module), "", "_")
  
  # Set up environmental variables
  environments <- setEnvironments(input, module, sep)
  
  # Set up other variables
  variables    <- setVariables(input, module, environments, sep)
  
  Mu        <- variables$Mu
  N         <- variables$N
  B         <- variables$B
  V         <- variables$V
  Time      <- variables$Time
  variables <- variables$Variables
  
  if(is.null(X_previsualization)){
    
    # Initialize output
    output <- list()
    
    #######################################################################################
    ## Generate my phenotype traits
    output[["full_Data"]]    <- getFullData(Mu, N, B, r, V, Time, variables, environments)
    
    ####################################################################################### 
    ## Get Sampling data  
    output[["sampled_Data"]] <- getSampledData(N, Time, output[["full_Data"]])
    
    #######################################################################################
    ## Display results
    if(plot) 
      output[["myPlot"]]     <- displayResults(N, Time, output[["full_Data"]], output[["sampled_Data"]])
    
    #######################################################################################
    
  }else{
    
    if(X_previsualization %in% c("X1", "X2")){
      ### Generate environment for previsualization
      X <- getEnvironment(environments[[X_previsualization]], N, TRUE)
      
      myData   <- data.frame("envData"  = X, 
                             "x"        = rep(1:N$NS, N$NI),
                             "colour"   = as.factor(rep(1:N$NI, each = N$NS)))
      
      output   <- ggplot2::ggplot(myData, ggplot2::aes(y=envData, x=x, colour=colour)) +
                                  ggplot2::geom_point() +
                                  ggplot2::xlab("Time") +
                                  ggplot2::ylab("Environment") + 
                                  ggplot2::theme(legend.position="none")
    }else{
      stop("X_previsualization is not a valid environment tag.")
    }
  }
  
  return(output)
  
}