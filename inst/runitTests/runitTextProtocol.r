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
##
##  $Id: runitTextProtocol.r,v 1.1 2004/06/03 11:47:20 burger Exp $


cat("\n\nRUnit test cases for 'textProtocol' function\n\n")


testRUnit.printTextProtocol <- function()
{
  ##  input argument error handling
  ##  missing 'testData' object
  checkException(printTextProtocol())

  ##  wrong class
  checkException(printTextProtocol("dummy"))

  
  ##  fileName arg errors
  testData <- list()
  class(testData) <- "RUnitTestData"
  ##  wrong type
  checkException(printTextProtocol(testData, fileName=numeric(1)))
  ##  wrong length
  checkException(printTextProtocol(testData, fileName=character(0)))
  checkException(printTextProtocol(testData, fileName=character(2)))

  
  ##  separateFailureList arg errors
  ##  wrong type
  checkException(printTextProtocol(testData, separateFailureList=numeric(0)))
  ##  wrong length
  checkException(printTextProtocol(testData, separateFailureList=logical(0)))
  checkException(printTextProtocol(testData, separateFailureList=logical(2)))

  ##  showDetails arg errors
  ##  wrong type
  checkException(printTextProtocol(testData, showDetails=numeric(0)))
  ##  wrong length
  checkException(printTextProtocol(testData, showDetails=logical(0)))
  checkException(printTextProtocol(testData, showDetails=logical(2)))
}

