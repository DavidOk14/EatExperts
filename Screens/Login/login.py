from kivy.lang import Builder
from kivy.uix.screenmanager import Screen

# Load the login.kv file with error handling
try:
    Builder.load_file('Screens/Login/login.kv')
except Exception as e:
    print(f"{e}")

class LoginPage(Screen):
    pass