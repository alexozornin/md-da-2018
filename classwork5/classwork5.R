#Модифицируйте код из предыдущей лекции (функцию estimate.scaling.exponent), чтобы он возвращал список a и y0
data <- read.table("https://raw.githubusercontent.com/SergeyMirvoda/MD-DA-2018/master/data/gmp.dat", header = TRUE)
gmp <- data.frame(data)
gmp$pop <- gmp$gmp / gmp$pcgmp

estimate.scaling.exponent <- function(a, y0=6611, response=gmp$pcgmp,
    predictor = gmp$pop, maximum.iterations=100, deriv.step = 1/100,
    step.scale = 1e-12, stopping.deriv = 1/100) {
  mse <- function(a) { mean((response - y0*predictor^a)^2) }
  for (iteration in 1:maximum.iterations) {
    deriv <- (mse(a+deriv.step) - mse(a))/deriv.step
    a <- a - step.scale*deriv
    if (abs(deriv) <= stopping.deriv) { break() }
  }
  fit <- list(a=a,iterations=iteration,
    converged=(iteration < maximum.iterations))
  result <- c(a, y0)
  names(result) <- c("a", "y0")
  return(result)
}

estimate.scaling.exponent(0.15)

#Напишите рекурсивные функции факториала и фибоначчи
factorial <- function(n) {
  stopifnot(n > 0)
  if (n == 1) {
    return(1)
  }
  return(n * factorial(n - 1))
}

factorial(10)

fibonacci <- function(n) {
  if (n <= 1) {
    return(n)
  }
  return(fibonacci(n - 1) + fibonacci(n - 2))
}

fibonacci(10)
