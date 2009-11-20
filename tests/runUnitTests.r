if(require("RUnit", quietly=TRUE)) {

  path <- system.file(package="RUnit", "unitTests")

  testSuite <- defineTestSuite(name="RUnit", dirs=path)
  testData  <- runTestSuite(testSuite)
  
  printTextProtocol(testData, showDetails=FALSE)

  tmp <- getErrors(tests)
  if(tmp$nFail > 0 | tmp$nErr > 0) {
    stop(paste("\n\nunit testing failed (#test failures: ", tmp$nFail,
               ", #R errors: ",  tmp$nErr, ")\n\n", sep=""))
  }
} else {
  warning("RUnit unit tests not run - failed to load package.")
}
