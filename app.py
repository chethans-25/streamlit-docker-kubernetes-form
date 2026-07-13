import streamlit as st 
from datetime import datetime
 
with st.form('myform'):
 
  st.header('Registration Form')
  c1, c2, c3 = st.columns(3)
  select_box = c1.selectbox('Title',('Mr','Mrs','Miss'))
  first_name = c2.text_input('First Name')
  last_name = c3.text_input('Last Name')
  
  # Role
  role = st.selectbox('Designation',('Entry Level Verification Engineer',
    'Associate Verification Engineer','Technical Lead Engineer',' Verification Architect',
    'Manager','Sr. Manager','Project Manager'))
  
  # Date of Birth
  dob = st.date_input('Date of Birth', min_value=datetime(year=2000,month=1,day=1))
  
  # Gender
  gender = st.radio(
    "Select Gender",
    ('Male','Female','Prefered Not to Say')
  )

  num = st.number_input('Enter a number',0,10,1,2)
  
  # age
  age = st.slider('Age',min_value=26,max_value=80,step=1,value=26)
  submitted = st.form_submit_button('Submit')
  if submitted:
    st.success('Form Submitted Successfully')
    details = {
    'Name': f"{select_box} {first_name} {last_name}",
    'Age': age,
    'Gender':gender,
    'Data of Birth': dob,
    'Designation':role
    }
    st.json(details)
