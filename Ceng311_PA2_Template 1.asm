##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size of array
#   4 Bytes - Size of elements
##############################################################

##############################################################
#Linked List
##############################################################
#   4 Bytes - Address of the First Node
#   4 Bytes - Size of linked list
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Recipe
##############################################################
#   4 Bytes - Name (address of the name)
#	4 Bytes - Ingredients (address of the ingredients array)
#   4 Bytes - Cooking Time
#	4 Bytes - Difficulty
#	4 Bytes - Rating
##############################################################


.data
space: .asciiz " "

newLine: .asciiz "\n"
tab: .asciiz "\t"
lines: .asciiz "------------------------------------------------------------------\n"

listStr: .asciiz "List: \n"
recipeName: .asciiz "Recipe name: "
ingredients: .asciiz "Ingredients: "
cookingTime: .asciiz "Cooking time: "
difficulty: .asciiz "Difficulty: "
rating: .asciiz "Rating: "
listSize: .asciiz "List Size: "
emptyListWarning: .asciiz "List is empty!\n"
indexBoundWarning: .asciiz "Index out of bounds!\n"
recipeNotMatch: .asciiz "Recipe not matched!\n"
recipeMatch: .asciiz "Recipe matched!\n"
recipeAdded: .asciiz "Recipe added.\n"
recipeRemoved: .asciiz "Recipe removed.\n"
noRecipeWarning: .asciiz "No recipe to print!\n"

addressOfRecipeList: .word 0 #the address of the array of recipe list stored here!


# Recipe 1: Pancakes
r1: .asciiz "Pancakes"
r1i1: .asciiz "Flour"
r1i2: .asciiz "Milk"
r1i3: .asciiz "Eggs"
r1i4: .asciiz "Sugar"
r1i5: .asciiz "Baking powder"
r1c: .word 15							# Cooking time in minutes
r1d: .word 2							# Difficulty (scale 1-5)
r1r: .word 4							# Rating (scale 1-5)

# Recipe 2: Spaghetti Bolognese
r2: .asciiz "Spaghetti Bolognese"
r2i1: .asciiz "Spaghetti"
r2i2: .asciiz "Ground beef"
r2i3: .asciiz "Tomato sauce"
r2i4: .asciiz "Garlic"
r2i5: .asciiz "Onion"
r2c: .word 30
r2d: .word 3
r2r: .word 5

# Recipe 3: Chicken Stir-Fry
r3: .asciiz "Chicken Stir-Fry"
r3i1: .asciiz "Chicken breast"
r3i2: .asciiz "Soy sauce"
r3i3: .asciiz "Bell peppers"
r3i4: .asciiz "Broccoli"
r3i5: .asciiz "Garlic"
r3c: .word 20
r3d: .word 3
r3r: .word 4

# Recipe 4: Caesar Salad
r4: .asciiz "Caesar Salad"
r4i1: .asciiz "Romaine lettuce"
r4i2: .asciiz "Caesar dressing"
r4i3: .asciiz "Parmesan cheese"
r4i4: .asciiz "Croutons"
r4i5: .asciiz "Chicken breast (optional)"
r4c: .word 10
r4d: .word 1
r4r: .word 4

# Recipe 5: Chocolate Chip Cookies
r5: .asciiz "Chocolate Chip Cookies"
r5i1: .asciiz "Butter"
r5i2: .asciiz "Sugar"
r5i3: .asciiz "Flour"
r5i4: .asciiz "Eggs"
r5i5: .asciiz "Chocolate chips"
r5c: .word 25
r5d: .word 2
r5r: .word 5


search1: .asciiz "Caesar Salad"
search2: .asciiz "Shepherd's Pie"

.text 
main:

	# Write your instructions here!

    jal createLinkedList         
    move $a0, $v0               
    sw $a0, addressOfRecipeList

    # Pancakes
    la $a0, r1                  
    la $a1, r1i1               
    li $a2, 15                 
    li $a3, 2                  
    li $t0, 4                 
    sw $t0, 0($sp)             
    jal createRecipe           
    move $a1, $v0             
    lw $a0, addressOfRecipeList 
    jal enqueue                
    la $a0, recipeAdded        
    li $v0, 4
    syscall

    # Spaghetti Bolognese
    la $a0, r2
    la $a1, r2i1
    li $a2, 30
    li $a3, 3
    li $t0, 5
    sw $t0, 0($sp)
    jal createRecipe
    move $a1, $v0
    lw $a0, addressOfRecipeList
    jal enqueue
    la $a0, recipeAdded
    li $v0, 4
    syscall

    # Queue size
    lw $a0, addressOfRecipeList
    jal queueSize
    la $a0, listSize
    li $v0, 4
    syscall
    move $a0, $v0
    li $v0, 1
    syscall

    # Current recipes
    lw $a0, addressOfRecipeList
    lw $a0, 0($a0)               
    la $a1, printRecipe
    jal traverseLinkedList       

    # Dequeue, print first recipe
    lw $a0, addressOfRecipeList
    jal dequeue
    move $a0, $v0               
    beqz $a0, mainTerminate     
    jal printRecipe            

    # Remaining recipes
    lw $a0, addressOfRecipeList
    lw $a0, 0($a0)              
    la $a1, printRecipe
    jal traverseLinkedList      

    # Chicken Stir-Fry
    la $a0, r3
    la $a1, r3i1
    li $a2, 20
    li $a3, 3
    li $t0, 4
    sw $t0, 0($sp)
    jal createRecipe
    move $a1, $v0
    lw $a0, addressOfRecipeList
    jal enqueue

    # Caesar Salad
    la $a0, r4
    la $a1, r4i1
    li $a2, 10
    li $a3, 1
    li $t0, 4
    sw $t0, 0($sp)
    jal createRecipe
    move $a1, $v0
    lw $a0, addressOfRecipeList
    jal enqueue

    # Chocolate Chip Cookies
    la $a0, r5
    la $a1, r5i1
    li $a2, 25
    li $a3, 2
    li $t0, 5
    sw $t0, 0($sp)
    jal createRecipe
    move $a1, $v0
    lw $a0, addressOfRecipeList
    jal enqueue

    # Final size and recipes
    lw $a0, addressOfRecipeList
    jal queueSize
    la $a0, listSize
    li $v0, 4
    syscall
    move $a0, $v0
    li $v0, 1
    syscall

    # Search recipes with name
    lw $a0, addressOfRecipeList
    lw $a0, 0($a0)              
    la $a1, findRecipe
    la $a2, search1             
    jal traverseLinkedList

    lw $a0, addressOfRecipeList
    lw $a0, 0($a0)              
    la $a1, findRecipe
    la $a2, search2            
    jal traverseLinkedList
	
mainTerminate:
	li $v0, 10
	syscall

createArray:
	# Create an array
	# Inputs: $a0 - max number of elements (size), $a1 - size of elements
	# Outputs: $v0 - address of array
	
	# Write your instructions here!

	
    blt $a0, 0, indexArray     
    blt $a1, 0, indexArray     
    mul $t0, $a0, $a1
    addi $t0, $t0, 12
    li $v0, 9
    move $a2, $t0
    syscall
    move $t1, $v0
    sw $zero, 0($t1)
    sw $a0, 4($t1)
    sw $a1, 8($t1)
    mul $a2, $a0, $a1         # Data size: max elements * element size
    li $v0, 9
    syscall
    sw $v0, 0($t1)            # Store address of data section in metadata

    move $v0, $t1             # Return the array structure address
    jr $ra

indexArray:
    la $a0, indexBoundWarning
    li $v0, 4
    syscall
    li $v0, 10
    syscall

putElementToArray:
	# Store an element (recipe) in an array.
	# Inputs: $a0 - address of array, $a1 - element address, $a2 - index
	
	# Write your instructions here!

	lw $t0, 4($a0)       # Maximum elements in array
    lw $t1, 8($a0)       # Size of each element

    bltz $a2, outOfBounds 
    bge $a2, $t0, outOfBounds 

    # If bounds are valid, proceed to calculate address
    mul $t2, $a2, $t1    # Calculate offset for the index
    lw $t3, 0($a0)       # Base address of data section
    add $t4, $t2, $t3    # Address = Base + Offset
    sw $a1, 0($t4)       # Store the element
    jr $ra

outOfBounds:
    la $a0, indexBoundWarning
    li $v0, 4
    syscall
    jr $ra

createLinkedList:
	# Create a linked list.
	# Outputs: $v0 - address of linked List
	
	# Write your instructions here!
	li $v0, 9                
    li $a0, 8                
    syscall
    move $t0, $v0            

    sw $zero, 0($t0)         
    sw $zero, 4($t0)        

    move $v0, $t0
	jr $ra

enqueue:
	# Inputs: $a0 - address of the linked list structure, $a1 - address of data to add
	
	# Write your instructions here!

	lw $t0, 0($a0)           
    lw $t1, 4($a0)       

    li $v0, 9              
    li $a2, 8             
    syscall
    move $t2, $v0           

    sw $a1, 0($t2)           
    sw $zero, 4($t2)        
    beqz $t0, enqueue_empty  
    move $t3, $t0     
	
enqueue_loop:
    lw $t4, 4($t3)          
    bnez $t4, enqueue_continue
    sw $t2, 4($t3)           
    j enqueue_done

enqueue_continue:
    move $t3, $t4         
    j enqueue_loop

enqueue_empty:
    sw $t2, 0($a0)         

enqueue_done:
    addi $t1, $t1, 1        
    sw $t1, 4($a0)
	
	jr $ra               # Return to caller

dequeue:
	# Inputs: $a0 - address of the linked list structure
	# Outputs: $v0 - removed head node, 0 if empty
	
	# Write your instructions here!

	lw $t0, 0($a0)          
    lw $t1, 4($a0)          

    beqz $t1, dequeue_empty

    lw $t2, 4($t0)           
    sw $t2, 0($a0)          
    addi $t1, $t1, -1    
    sw $t1, 4($a0)          

    lw $v0, 0($t0)

	jr $ra               # Return to caller

dequeue_empty:
    move $v0, $zero
    jr $ra

queueSize:
	# Inputs: $a0 - address of the linked list structure
	
	# Write your instructions here!
	lw $v0, 4($a0)           
    jr $ra 
	
	jr $ra

traverseArray:
	# Traverse and print recipes from array.
	# Inputs: $a0 - address of array, $a1 - called function
	
	# Write your instructions here!

	lw $t0, 0($a0)        
    lw $t1, 4($a0)        
    lw $t2, 8($a0)           

    li $t3, 0      
	
traverseArray_loop:
    beq $t3, $t1, traverseArray_done 

    mul $t4, $t3, $t2        
    add $t4, $t4, $t0       

    move $a0, $t4         
    jalr $a1                

    addi $t3, $t3, 1
    j traverseArray_loop

traverseArray_done:	
	jr $ra

traverseLinkedList:
	# Traverse linked list.
	# Inputs: $a0 - head node of linked list, $a1 - called function, $a2 - extra arguments
	
	# Write your instructions here!
	move $t0, $a0   
	
traverseLinkedList_loop:

    beqz $t0, traverseLinkedList_done
    lw $t1, 0($t0)         

    move $a0, $t1          
    move $a2, $a2          
    jalr $a1                

    lw $t0, 4($t0)          
    j traverseLinkedList_loop

traverseLinkedList_done:	
	jr $ra

compareString:
	# Compare two strings.
	# Inputs: $a0 - string 1 address, $a1 - string 2 address
	# Outputs: $v0 - 0 found, 1 not found
	
	# Write your instructions here!

compareString_loop:
    lb $t0, 0($a0)           
    lb $t1, 0($a1)           
    bne $t0, $t1, compareString_notMatch 
    beqz $t0, compareString_match       

    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j compareString_loop

compareString_match:
    li $v0, 0                
    jr $ra

compareString_notMatch:
    li $v0, 1	
	jr $ra

createRecipe:
	# Create a recipe and store in the recipe struct.
	# Inputs: $a0 - recipe name, $a1 - address of ingredients array,
	#         $a2 - cooking time, $a3 - difficulty, 0($sp) - rating
	# Outputs: $v0 - recipe address
	
	# Write your instructions here!

	li $v0, 9
    li $a2, 20
    syscall
    move $t0, $v0
    sw $a0, 0($t0)
    sw $a1, 4($t0)
    sw $a2, 8($t0)
    sw $a3, 12($t0)
    lw $t1, 0($sp)
    sw $t1, 16($t0)
    move $v0, $t0
	jr $ra

findRecipe:
	# Compare two recipe names.
	# Inputs: $a0 - recipe struct address, $a1 - searched recipe name
	
	# Write your instructions here!
    lw $t0, 0($a0)      

    move $a0, $t0         
    move $a1, $a1         
    jal compareString       
    move $t1, $v0            

    beqz $t1, recipe_match   

    la $a0, recipeNotMatch  
    li $v0, 4                
    syscall
    jr $ra

recipe_match:
    la $a0, recipeMatch     
    li $v0, 4              
    syscall
	jr $ra              # Return

printRecipe:
	# Print recipe details.
	# Inputs: $a0 - address of recipe struct
	
	# Write your instructions here!

    #recipe details
    lw $t1, 0($a0)           
    lw $t2, 4($a0)           
    lw $t3, 8($a0)        
    lw $t4, 12($a0)       
    lw $t5, 16($a0)          

    #recipename
    la $a0, recipeName      
    li $v0, 4            
    syscall
    move $a0, $t1           
    li $v0, 4
    syscall

    #ingredients
    la $a0, ingredients     
    li $v0, 4
    syscall
    move $a0, $t2          
    jal traverseArray       

    #cooking tine
    la $a0, cookingTime   
    li $v0, 4
    syscall
    move $a0, $t3          
    li $v0, 1               
    syscall

    #difficulty
    la $a0, difficulty      
    li $v0, 4
    syscall
    move $a0, $t4          
    li $v0, 1
    syscall

    #rating
    la $a0, rating         
    li $v0, 4
    syscall
    move $a0, $t5       
    li $v0, 1
    syscall
	
	jr $ra

printIngredient:
	# Print ingredient.
	# Inputs: $a0 - address of ingredient
	
	# Write your instructions here!

    move $a0, $a0           
    li $v0, 4              
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
	
	jr $ra
	