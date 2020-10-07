#' @name mutate
#' @inherit AcidGenerics::mutate
#' @note Updated 2020-10-07.
#'
#' @inheritParams AcidRoxygen::params
#'
#' @examples
#' data(mtcars, package = "datasets")
#'
#' ## DataFrame ====
#' x <- as(mtcars, "DataFrame")
#' mutateAll(x, fun = log, base = 2L)
#' mutateAt(x, vars = c("mpg", "cyl"), fun = log, base = 2L)
#' mutateIf(x, predicate = is.double, fun = as.integer)
#' transmuteAt(x, vars = c("mpg", "cyl"), fun = log, base = 2L)
#' transmuteIf(x, predicate = is.double, fun = as.integer)
NULL



## List column approach idea (draft)
## > list <- lapply(
## >     X = as.list(object),
## >     FUN = function(row) {
## >         unlist(lapply(X = row, FUN = fun, ...))
## >     }
## > )



## Loop across the columns and then each row internally.
## This will fail on complex list columns unless wrapped by `as_tibble()`.
## See also list to DataFrame coercion method defined in package.
`mutateAll,DataFrame` <-  # nolint
    function(object, fun, ...) {
        assert(allAreAtomic(object))
        list <- lapply(X = object, FUN = fun, ...)
        out <- DataFrame(as_tibble(list), row.names = rownames(object))
        assert(
            identical(dim(out), dim(object)),
            identical(dimnames(out), dimnames(object))
        )
        out
    }



#' @rdname mutate
#' @export
setMethod(
    f = "mutateAll",
    signature = signature(
        object = "DataFrame",
        fun = "function"
    ),
    definition = `mutateAll,DataFrame`
)



`mutateAt,DataFrame` <-  # nolint
    function(object, vars, fun, ...) {
        x <- transmuteAt(object, vars = vars, fun = fun, ...)
        y <- object[, setdiff(colnames(object), colnames(x)), drop = FALSE]
        out <- cbind(x, y)
        out <- out[, colnames(object), drop = FALSE]
        out
    }



#' @rdname mutate
#' @export
setMethod(
    f = "mutateAt",
    signature = signature(
        object = "DataFrame",
        vars = "character",
        fun = "function"
    ),
    definition = `mutateAt,DataFrame`
)



`mutateIf,DataFrame` <-  # nolint
    function(object, predicate, fun, ...) {
        x <- transmuteIf(
            object = object,
            predicate = predicate,
            fun = fun,
            ...
        )
        y <- object[, setdiff(colnames(object), colnames(x)), drop = FALSE]
        out <- cbind(x, y)
        out <- out[, colnames(object), drop = FALSE]
        out
    }



#' @rdname mutate
#' @export
setMethod(
    f = "mutateIf",
    signature = signature(
        object = "DataFrame",
        predicate = "function",
        fun = "function"
    ),
    definition = `mutateIf,DataFrame`
)



`transmuteAt,DataFrame` <-  # nolint
    function(object, vars, fun, ...) {
        x <- object[, vars, drop = FALSE]
        x <- mutateAll(x, fun = fun, ...)
        x
    }



#' @rdname mutate
#' @export
setMethod(
    f = "transmuteAt",
    signature = signature(
        object = "DataFrame",
        vars = "character",
        fun = "function"
    ),
    definition = `transmuteAt,DataFrame`
)



`transmuteIf,DataFrame` <-  # nolint
    function(object, predicate, fun, ...) {
        x <- selectIf(object, predicate = predicate)
        x <- mutateAll(x, fun = fun, ...)
        x
    }



#' @rdname mutate
#' @export
setMethod(
    f = "transmuteIf",
    signature = signature(
        object = "DataFrame",
        predicate = "function",
        fun = "function"
    ),
    definition = `transmuteIf,DataFrame`
)