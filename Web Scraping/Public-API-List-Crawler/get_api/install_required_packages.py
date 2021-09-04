import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

f = open("requirements.txt", "r")
packages=list(f.read().split('\n'))
for i in packages:
    install(i)