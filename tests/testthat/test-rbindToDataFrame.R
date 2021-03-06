context("rbindToDataFrame")

IntegerList <- AcidGenerics::IntegerList  # nolint

test_that("Matched and named input", {
    x <- list(
        "aa" = c("a" = 1L, "b" = 2L),
        "bb" = c("a" = 3L, "b" = 4L)
    )
    object <- rbindToDataFrame(x)
    expected <- DataFrame(
        "a" = c(1L, 3L),
        "b" = c(2L, 4L),
        row.names = c("aa", "bb")
    )
    expect_identical(object, expected)
})

test_that("Unnamed and unmatched input", {
    x <- list(
        seq(from = 1L, to = 3L),
        seq(from = 4L, to = 7L)
    )
    object <- rbindToDataFrame(x)
    expected <- DataFrame(
        "x1" = c(1L, 4L),
        "x2" = c(2L, 5L),
        "x3" = c(3L, 6L),
        "x4" = c(NA_integer_, 7L)
    )
    expect_identical(object, expected)
})

test_that("List nested down 2 levels", {
    object <- list(
        "list" = list(
            "a" = list(
                "aa" = seq(from = 1L, to = 3L),
                "bb" = seq(from = 4L, to = 6L)
            ),
            "b" = list(
                "cc" = seq(from = 7L, to = 9L),
                "dd" = seq(from = 10L, to = 12L)
            ),
            "c" = list(
                "ee" = seq(from = 13L, to = 15L),
                "ff" = seq(from = 16L, to = 18L)
            )
        ),
        "IntegerList" = list(
            "a" = IntegerList(
                "aa" = seq(from = 1L, to = 3L),
                "bb" = seq(from = 4L, to = 6L)
            ),
            "b" = IntegerList(
                "cc" = seq(from = 7L, to = 9L),
                "dd" = seq(from = 10L, to = 12L)
            ),
            "c" = IntegerList(
                "ee" = seq(from = 13L, to = 15L),
                "ff" = seq(from = 16L, to = 18L)
            )
        )
    )
    expected <- list(
        "list" = DataFrame(
            "aa" = I(list(
                seq(from = 1L, to = 3L),
                NULL,
                NULL
            )),
            "bb" = I(list(
                seq(from = 4L, to = 6L),
                NULL,
                NULL
            )),
            "cc" = I(list(
                NULL,
                seq(from = 7L, to = 9L),
                NULL
            )),
            "dd" = I(list(
                NULL,
                seq(from = 10L, to = 12L),
                NULL
            )),
            "ee" = I(list(
                NULL,
                NULL,
                seq(from = 13L, to = 15L)
            )),
            "ff" = I(list(
                NULL,
                NULL,
                seq(from = 16L, to = 18L)
            )),
            row.names = c("a", "b", "c")
        ),
        "IntegerList" = DataFrame(
            "x1" = I(list(
                IntegerList(
                    "aa" = seq(from = 1L, to = 3L),
                    "bb" = seq(from = 4L, to = 6L)
                ),
                IntegerList(
                    "cc" = seq(from = 7L, to = 9L),
                    "dd" = seq(from = 10L, to = 12L)
                ),
                IntegerList(
                    "ee" = seq(from = 13L, to = 15L),
                    "ff" = seq(from = 16L, to = 18L)
                )
            )),
            row.names = c("a", "b", "c")
        )
    )
    for (i in seq_along(objects)) {
        expect_identical(
            object = rbindToDataFrame(object[[!!i]]),
            expected = expected[[!!i]]
        )
    }
})

test_that("List nested down 3 levels", {
    object <- list(
        "list" = list(
            "a" = list(
                "aa1" = list(
                    "aaa1" = seq(from = 1L, to = 3L),
                    "aaa2" = seq(from = 4L, to = 6L)
                ),
                "aa2" = list(
                    "aaa3" = seq(from = 7L, to = 9L),
                    "aaa4" = seq(from = 10L, to = 12L)
                )
            ),
            "b" = list(
                "bb1" = list(
                    "bbb1" = seq(from = 13L, to = 15L),
                    "bbb2" = seq(from = 16L, to = 18L)
                ),
                "bb2" = list(
                    "bbb3" = seq(from = 19L, to = 21L),
                    "bbb4" = seq(from = 22L, to = 24L)
                )
            )
        ),
        "IntegerList" = list(
            "a" = list(
                "aa1" = IntegerList(
                    "aaa1" = seq(from = 1L, to = 3L),
                    "aaa2" = seq(from = 4L, to = 6L)
                ),
                "aa2" = IntegerList(
                    "aaa3" = seq(from = 7L, to = 9L),
                    "aaa4" = seq(from = 10L, to = 12L)
                )
            ),
            "b" = list(
                "bb1" = IntegerList(
                    "bbb1" = seq(from = 13L, to = 15L),
                    "bbb2" = seq(from = 16L, to = 18L)
                ),
                "bb2" = IntegerList(
                    "bbb3" = seq(from = 19L, to = 21L),
                    "bbb4" = seq(from = 22L, to = 24L)
                )
            )
        )
    )
    expected <- list(
        "integer" = DataFrame(
            "aa1" = I(list(
                list(
                    "aaa1" = seq(from = 1L, to = 3L),
                    "aaa2" = seq(from = 4L, to = 6L)
                ),
                NULL
            )),
            "aa2" = I(list(
                list(
                    "aaa3" = seq(from = 7L, to = 9L),
                    "aaa4" = seq(from = 10L, to = 12L)
                ),
                NULL
            )),
            "bb1" = I(list(
                NULL,
                list(
                    "bbb1" = seq(from = 13L, to = 15L),
                    "bbb2" = seq(from = 16L, to = 18L)
                )
            )),
            "bb2" = I(list(
                NULL,
                list(
                    "bbb3" = seq(from = 19L, to = 21L),
                    "bbb4" = seq(from = 22L, to = 24L)
                )
            )),
            row.names = c("a", "b")
        ),
        "IntegerList" = DataFrame(
            "aa1" = I(list(
                IntegerList(
                    "aaa1" = seq(from = 1L, to = 3L),
                    "aaa2" = seq(from = 4L, to = 6L)
                ),
                NULL
            )),
            "aa2" = I(list(
                IntegerList(
                    "aaa3" = seq(from = 7L, to = 9L),
                    "aaa4" = seq(from = 10L, to = 12L)
                ),
                NULL
            )),
            "bb1" = I(list(
                NULL,
                IntegerList(
                    "bbb1" = seq(from = 13L, to = 15L),
                    "bbb2" = seq(from = 16L, to = 18L)
                )
            )),
            "bb2" = I(list(
                NULL,
                IntegerList(
                    "bbb3" = seq(from = 19L, to = 21L),
                    "bbb4" = seq(from = 22L, to = 24L)
                )
            )),
            row.names = c("a", "b")
        )
    )
    for (i in seq_along(objects)) {
        expect_identical(
            object = rbindToDataFrame(object[[!!i]]),
            expected = expected[[!!i]]
        )
    }
})
