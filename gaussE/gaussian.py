import numpy as np



def gauss_elimination(a_matrix,b_matrix):

    #adding some contingencies to prevent future problems 

    if a_matrix.shape[0] != a_matrix.shape[1]:

        print("ERROR: Squarematrix not given!")

        return

    if b_matrix.shape[1] > 1 or b_matrix.shape[0] != a_matrix.shape[0]:

        print("ERROR: Constant vector incorrectly sized")

        return

     

    #initialization of nexessary variables

    n=len(b_matrix)

    m=n-1

    i=0

    j=i-1

    x=np.zeros(n)

    new_line="/n "

    

    #create our augmented matrix throug Numpys concatenate feature

    augmented_matrix = np.concatenate((a_matrix, b_matrix,), axis=1, dtype=float)

    print(f"the initial augmented matrix is: {new_line}{augmented_matrix}")

    print("solving for the upper-triangular matrix:")

    

    

    #applying gauss elimination:

    while i<n:

        if augmented_matrix[i][i]==0.0: #fail-safe to eliminate divide by zero erroor!

            print("Divide by zero error")

            return

        for j in range(i+1,n):

            scaling_factor=augmented_matrix[j][i]/augmented_matrix[i][i]

            augmented_matrix[j]=augmented_matrix[j]-(scaling_factor * augmented_matrix[i])

            print(augmented_matrix) #not needed, but nice to visualize the process

            

        i=i+1

    

        #backwords substitution!

        x[m]=augmented_matrix[m][n]/augmented_matrix[m][m]

  

        for k in range(n-2, -1, -1):
            x[k] = augmented_matrix[k][n]
            
            for j in range(k+1, n):
                x[k] = x[k] - augmented_matrix[k][j] * x[j]
            x[k] = x[k] / augmented_matrix[k][k]

    

    #displaying solution 

    print("The following x vector matrix solves the above augmented matrix:")

    for answer in range(n):

        print(f"x{answer} is {x[answer]}")











variable_matrix = np.array([[1,1,3],[6,1,3],[-1,3,0]])
constant_matrix = np.array([[1],[3],[5]])



gauss_elimination(variable_matrix, constant_matrix)