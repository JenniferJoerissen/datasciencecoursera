#The following code creates takes a matrix (your input for the makeCacheMatrix 
#function), and calculates its inverse. Caching is used in order to allow rapid
#computation in case of repeated calling of the function with an unchanged matrix.
#It allows objects created in one function to be called in another function.

## The function makeCacheMatrix CREATES functions which set and get matrices.
makeCacheMatrix <- function(x = matrix()) {
      # Create empty object one in which inverse matrix can be stored in a later step      
      m <- NULL                                           
      set <- function(y){                              # 1. Set the value of the matrix 'x'
            x <<- y                       
            m <<- NULL
      }
      get <- function() x                              # 2. Get the value of the matrix 'x'                    
      setInverseMatrix <- function(solve) m <<- solve  # 3. Calculate the value of the inversed matrix and store in 'm'
      getInverseMatrix <- function() m                 # 4. Get the value of the inversed matrix 'm'
      # Store all functions in a list to be called by the user
      list(set = set, get = get,                        
           setInverseMatrix = setInverseMatrix, 
           getInverseMatrix = getInverseMatrix )
}

## The function cacheSolve calulate the inverse by using the functions created 
## by the makeCacheMatrix function
cacheSolve <- function(x, ...) {
      m <- x$getInverseMatrix()            #Asks if m has been computed and cached before
      if(!is.null(m)){                     #If a cached inverse matrix is found
            message("getting cached data") #Put out a message and and then the inversed matrix
            return(m)                      #Return stops executing the function and
      }                                    #the next part of cacheSolve is not computed
      data <- x$get()                      #If no cached inverse matrix is fount, get and store the input matrix and
      m <- solve(data, ...)                #Compute inverse matrix
      x$setInverseMatrix(m)                
      m                                    #Print Inverse matrix
}

#TEST CASES FOUND IN THE DISCUSSION FORUM
amatrix = makeCacheMatrix(matrix(c(1,2,3,4), nrow=2, ncol=2))
amatrix$get()                 # Returns original matrix
cacheSolve(amatrix)           # Computes, caches, and returns    matrix inverse
amatrix$getInverseMatrix()    # Returns matrix inverse
cacheSolve(amatrix)           # Returns cached matrix inverse using previously computed matrix inverse

amatrix$set(matrix(c(0,5,99,66), nrow=2, ncol=2)) # Modify existing matrix
cacheSolve(amatrix)           # Computes, caches, and returns new matrix inverse
amatrix$get()                 # Returns matrix
amatrix$getInverseMatrix()    # Returns matrix inverse
