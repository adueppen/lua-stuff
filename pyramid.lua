print('Enter a character to use for the pyramid:')
char = io.read(1)
print('Enter a number of rows for the pyramid:')
rows = io.read('*number')
pyramid = ''
for count = 0, rows do
  for subcount = 1, count do
    pyramid = pyramid .. char
  end
  pyramid = pyramid .. '\n'
end
print(pyramid)