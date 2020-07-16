---
title: "Introductory Testing Model"
author: "David J. Vanness"
date: "6/11/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

Basic testing model

Prevalence - is probability a person selected at random has disease (D+)
Sensitivity - probability test is positive (T+) given disease positive (D+)
Specificity - probability test is negative (T-) given no disease (D-)

```{r}
p_D1 = 0.02 #2% Prevalence
p_T1_D1 = 0.9 #90% Sensitive
p_T0_D0 = 0.95 #95% Specificity

```

Generate a sample of size N_test from population

```{r}
set.seed(314159)
N_test = 32
S = rbinom(n = N_test,size = 1,prob = p_D1) #Completely homogenous
```

How many positive tests will we get?

```{r}
T1_D1 = rbinom(n = N_test, size = 1, prob = p_T1_D1)
T1_D0 = rbinom(n = N_test, size = 1, prob = (1-p_T0_D0))
T1 = (S==0)*T1_D0 + (S==1)*T1_D1
c_T1 = sum(T1)
```





