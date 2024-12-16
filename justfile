default:
  @just --choose

compile:
    forge compile --lib-paths .venv/lib/python3.12/site-packages

test: 
    forge test --lib-paths .venv/lib/python3.12/site-packages -vvv

build:
    forge build --lib-paths .venv/lib/python3.12/site-packages

setup:
    bun install
    forge install
    poetry env use 3.12
    poetry install