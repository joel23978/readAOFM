test_that("fixture workbooks are present and have the expected sheets", {
  expect_true(file.exists(fixture_path("tb_issuance.xlsx")))
  expect_true(file.exists(fixture_path("tib_issuance.xlsx")))
  expect_true(file.exists(fixture_path("tb_position_dealt.xlsx")))

  expect_equal(
    readxl::excel_sheets(fixture_path("tb_issuance.xlsx")),
    c("Transactions", "Notes")
  )
  expect_equal(
    readxl::excel_sheets(fixture_path("tib_issuance.xlsx")),
    c("Transactions", "Notes")
  )
  expect_equal(
    readxl::excel_sheets(fixture_path("tb_position_dealt.xlsx")),
    c("Notes", "FaceValue", "MarketValue", "Delta", "Duration", "Tenor")
  )
})
