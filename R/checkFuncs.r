##  RUnit : A unit test framework for the R programming language
##  Copyright (C) 2003, 2004  Thomas Koenig, Matthias Burger, Klaus Juenemann
##
##  This program is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program; if not, write to the Free Software
##  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

##  $Id: checkFuncs.r,v 1.10 2006/01/05 14:09:45 burger Exp $


checkEquals <- function(a, b, msg, tolerance = .Machine$double.eps^0.5, ...)
{
  ##@bdescr
  ## checks if two objects are equal, thin wrapper around 'all.equal'
  ## with tolerance one can adjust to and allow for numerical imprecission

  ##@edescr
  ##@in a         : [ANY] one thing to be compared
  ##@in b         : [ANY] the second object to be compared
  ##@in tolerance : [numeric] directly passed to 'all.equal', see there for further documentation
  ##@in msg : [character|TRUE] an optional message to further identify and document the call
  ##
  ##@codestatus : testing

  if(!is.numeric(tolerance)) {
    stop("tolerance has to be a numeric value")
  }
  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$incrementCheckNum()
  }
  res <- all.equal(a,b, tolerance=tolerance, ...)
  if (!identical(res, TRUE)) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$setFailure()
    }
    stop(paste(res, collapse="\n"))
  }
  else {
    return(TRUE)
  }
}


checkEqualsNumeric <- function(a, b, msg, tolerance = .Machine$double.eps^0.5, ...)
{
  ##@bdescr
  ## checks if two objects are equal, thin wrapper around 'all.equal.numeric'
  ## with tolerance one can adjust to and allow for numerical imprecission

  ##@edescr
  ##@in a         : [ANY] one thing to be compared
  ##@in b         : [ANY] the second object to be compared
  ##@in tolerance : [numeric] directly passed to 'all.equal', see there for further documentation
  ##@in msg : [character|TRUE] an optional message to further identify and document the call
  ##
  ##@ret     : [logical] TRUE, if objects a and b are equal w.r.t. specified numerical tolerance, else a stop signal is issued 
  ##
  ##@codestatus : testing
  
  if(!is.numeric(tolerance)) {
    stop("tolerance has to be a numeric value")
  }

  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$incrementCheckNum()
  }
  ##  R 2.3.0: changed behaviour of all.equal
  ##  strip attributes before comparing current and target
  res <- all.equal.numeric(as.vector(a), as.vector(b), tolerance=tolerance, ...)
  if (!identical(res, TRUE)) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$setFailure()
    }
    stop(paste(res, collapse="\n"))
  }
  else {
    return(TRUE)
  }
}


checkTrue <- function(expr, msg)
{
  ##@bdescr
  ## checks whether or not something is true
  ##@edescr
  ##
  ##@in expr : [expression] the logical expression to be checked to be TRUE
  ##@in msg  : [character|TRUE] optional message to further identify and document the call
  ##
  ##@ret     : [logical] TRUE, if the expression in a evaluates to TRUE, else a stop signal is issued 
  ##
  ##@codestatus : testing
  
  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$incrementCheckNum()
  }

  ##  allow named logical argument expr
  a <- eval(expr)
  names(a) <- NULL
  
  if (!identical(a, TRUE)) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$setFailure()
    }
    stop("Test not TRUE.")
  }
  else {
    return(TRUE)
  }
}


checkException <- function(expr, msg)
{
  ##@bdescr
  ## checks if a function call creates an error. The passed function must be parameterless.
  ## If you want to check a function with arguments, call it like this:
  ## 'checkException(function() func(args...))'
  ##@edescr
  ##@in func : [parameterless function] the function to be checked
  ##@in msg  : [character|TRUE] an optional message to further identify and document the call
  ##
  ##@ret     : [logical] TRUE, if evaluation of the expression results in a 'try-error', else a stop signal is issued 
  ##
  ##@codestatus : testing
  
  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$incrementCheckNum()
  }

  if (!inherits(try(eval(expr, envir = parent.frame())), "try-error")) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$setFailure()
    }
    stop("Error not generated as expected.")
  }
  else {
    return(TRUE)
  }
}


DEACTIVATED <- function(msg="")
{
  ##@bdescr
  ##  Convenience function, for maintaining test suites.
  ##  If placed in an existing test case call
  ##  the test will be executed normally until (so all code will be checked and
  ##  errors or failures reported as usual) occurance of the call
  ##  after which execution will leave the test case.
  ##  An entry for a seperate table in the log will be added
  ##  for this test case.
  ##
  ##@edescr
  ##@in a   : [expression] the logical expression to be checked to be TRUE
  ##@in msg : [character|TRUE] optional message to further identify and document the call
  ##
  ##@codestatus : testing

  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$setDeactivated(paste(msg, "\n", sep=""))
  }
  stop()
}
