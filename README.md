# SQUID package



#### Brief description
<img id='logo' src='./inst/shiny-squid/www/pictures/logo_2.png' align='left' alt='SQuID' style='padding-right:20px;'>
**SQuID** is made to help researchers to become familiar with multilevel variation, and to build up sampling designs for their study. SQuID is built up as a series of modules that guide the user into situations of increasing complexity to explore the dynamics between the way records are collected and estimates of parameters of specific interest; The last module is the ***full model simulation package*** that allows the user to generate data sets that can then be used to run analyses in the statistical package of their choice for specific research questions."

**SQuID** is based on a mathematical model that creates a group of individuals (i.e. study population) repeatedly expressing phenotypes, for one or different traits, in uniform time. Phenotypic values of traits are generated following the general principle of the phenotypic equation (Dingemanse & Dochtermann 2013, Journal of Animal Ecology): phenotypic variance (Vp) is assumed to be the sum of a series of components (see the full model). The user has thus the flexibility to add different variance components that will form the phenotype of the individual at each time step, and to set up the relative importance of each component. SQuiD then allows the user to collect a subsample of phenotypes for each simulated individual (i.e. operational data set), according to a specific sampling design. For most of the modules, the operational data set generated is automatically fed into a statistical model in R and the main results of the analysis shown in an output. For the full model the user has the opportunity to download the operational data set for further analyses.

#### Installation

To install from GitHub:

```
# install.packages("devtools")
devtools::install_github("Haycen/SQUID")

# run SQuID
library(SQUID)
squidApp()
```

#### Biological goals
This package is the product of the SQuID group. SQuID stands for **S**tatistical **Qu**antification of **I**ndividual **D**ifferences. We seek to understand patterns of phenotypic variance, which is the material on which natural selection is acting, and thus is a most essential feature of biological investigation. Different sources of variations are at the origin of the phenotype of an individual. Individuals differ in their phenotypes because they have different genes. They also experience different types of environmental effects during their lifetime. Some are imposing a very permanent mark on the phenotype over the whole lifetime. For example, by their parental behaviour individuals can affect their offspring phenotypes permanently, causing among-individual variation. Other environmental sources play more short-term effects on the phenotype, as individuals react in the plastic way to these sources, causing within-individual variation. The patterns of variation can be very complex. For instance individuals differ not only in their average phenotypes but also in how they can change their phenotype according to changes in the environment, which represents an interaction between the among- and the within-individual levels. Selection can act differently on these different components of variance in the phenotypes of a trait, and this is why it is important to estimate them. Mixed models are very flexible statistical tools that provide a way to estimate the variation at these different levels, and represent the general statistical framework for evolutionary biology. Because of the progress in computational capacities mixed models have become increasingly popular among ecologists and evolutionary biologists over the last decade. However, running mixed model is not a straightforward exercise, and the way data are sampled among and within individuals can have strong implications on the outcome of the model. This is why we considered it was necessary to produce a simulation tool that could help new users interested in decomposing phenotypic variance to get more familiar with the concept of hierarchical organisation of traits, with mixed models and to avoid pitfalls caused by inappropriate sampling.


#### History of the project
It all started in Hannover in November 2013 at the occasion of a workshop on personality organised by Susanne Foitzik, Franjo Weissing, and Niels Dingemanse and funded by the Volkswagen Foundation. During this workshop, a group of researchers discussed the potential issues related to sampling designs on the estimation of components of the phenotypic variance and covariance. It became obvious that there was an urgent need to develop a simulation package to help anyone interested in using a mixed model approach at getting familiar with this methods and avoiding the pitfalls related to the interpretation of the results. A first model and a working version of the package were created in January 2014, during a meeting at Université du Québec à Montréal. The current version was produced during a workshop in November 2014, at the Max Plank Institute for Ornithology in Seewiesen. 

#### SQuID team

* Hassen Allegue (University of British Columbia, Canada)
* Yimen Araya (Max Planck Institute for Ornithology, Seewiesen, Germany)
* Niels Dingemanse (Max Planck Institute for Ornithology, Seewiesen & University of Munich, Germany)
* Ned Dochtermann (North Dakota State University, USA)
* Laszlo Garamszegi (Estación Biológica de Doñana-CSIC, Spain)
* Shinichi Nakagawa (University of New South Wales, Kensington, NSW, Australia)
* Denis Réale (Université du Québec À Montréal, Canada)
* Holger Schielzeth (University of Bielefeld, Germany)
* Dave Westneat (University of Kentucky, USA)
