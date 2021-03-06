context("mapToDataFrame")

IntegerList <- AcidGenerics::IntegerList  # nolint

test_that("Simple column bind of vector list into DataFrame", {
    x <- list(
        "aaa" = seq(from = 1L, to = 3L),
        "bbb" = seq(from = 4L, to = 6L)
    )
    expected <- DataFrame(
        "aaa" = seq(from = 1L, to = 3L),
        "bbb" = seq(from = 4L, to = 6L)
    )
    expect_identical(
        object = mapToDataFrame(x),
        expected = expected
    )
})

test_that("List nested down 2 levels", {
    objects <- list(
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
    expected <- DataFrame(
        "name" = as.factor(rep(c("a", "b", "c"), each = 3L)),
        "aa" = c(
            seq(from = 1L, to = 3L),
            rep(NA, times = 6L)
        ),
        "bb" = c(
            seq(from = 4L, to = 6L),
            rep(NA, times = 6L)
        ),
        "cc" = c(
            rep(NA, times = 3L),
            seq(from = 7L, to = 9L),
            rep(NA, times = 3L)
        ),
        "dd" = c(
            rep(NA, times = 3L),
            seq(from = 10L, to = 12L),
            rep(NA, times = 3L)
        ),
        "ee" = c(
            rep(NA, times = 6L),
            seq(from = 13L, to = 15L)
        ),
        "ff" = c(
            rep(NA, times = 6L),
            seq(from = 16L, to = 18L)
        )
    )
    for (object in objects) {
        expect_identical(
            object = mapToDataFrame(!!object),
            expected = expected
        )
    }
})

test_that("List nested down 3 levels", {
    objects <- list(
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
    expected <- DataFrame(
        "name" = as.factor(rep(c("a", "b"), each = 2L)),
        "aa1" = I(list(
            "aaa1" = seq(from = 1L, to = 3L),
            "aaa2" = seq(from = 4L, to = 6L),
            NULL,
            NULL
        )),
        "aa2" = I(list(
            "aaa3" = seq(from = 7L, to = 9L),
            "aaa4" = seq(from = 10L, to = 12L),
            NULL,
            NULL
        )),
        "bb1" = I(list(
            NULL,
            NULL,
            "bbb1" = seq(from = 13L, to = 15L),
            "bbb2" = seq(from = 16L, to = 18L)
        )),
        "bb2" = I(list(
            NULL,
            NULL,
            "bbb3" = seq(from = 19L, to = 21L),
            "bbb4" = seq(from = 22L, to = 24L)
        ))
    )
    for (object in objects) {
        expect_identical(
            object = mapToDataFrame(!!object),
            expected = expected
        )
    }
})
