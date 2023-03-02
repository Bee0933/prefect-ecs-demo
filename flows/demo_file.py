from prefect import task, flow
import time

@task(name="task1", retries=2, log_prints=True)
def task1(val:int=5):
    print('this is my task')
    time.sleep(val)

@flow(name='main flow')
def demo_flow(param:int):
    task1(param)
    

if __name__ == "__main__":
    prm = 4
    demo_flow(prm)

