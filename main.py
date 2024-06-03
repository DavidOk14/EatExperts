from kivymd.app import MDApp
from kivymd.uix.screen import MDScreen

KV = '''
MDScreen:

    MDLabel:
        text: "Hello, KivyMD!"
        halign: "center"
'''

class MyApp(MDApp):
    def build(self):
        pass

if __name__ == "__main__":
    MyApp().run()