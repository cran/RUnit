######################################################################
##
## library: RUnit
## =====================================
##
## correctTestCase.r
## =====================================
##  test function definition which by construction executes wo error or failure
##
##
##
## Version
## =====================================
##  $Id: correctTestCase.r,v 1.1 2005/11/14 12:36:41 burger Exp $
##
##
######################################################################

test.correctTestCase <- function() {

  checkTrue( TRUE)
  checkTrue( !isTRUE(FALSE))
}