import kivy
from kivymd.app import MDApp
from kivy.uix.screenmanager import ScreenManager

# Import Screens
from Screens.Login.login import LoginPage

kivy.require('2.3.0')

class EatExperts (MDApp):
    def build(self):
        try:
            sm = ScreenManager()

            sm.add_widget(LoginPage(name='login'))
            sm.current = 'login'
            return sm
        except Exception as e:
            print(f"{e}")

        pass

if __name__ == "__main__":
    EatExperts().run()