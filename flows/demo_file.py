from prefect import task, flow
from prefect_aws.ecs import ECSTask
import time

@task(name="task1", retries=2, log_prints=True)
def task1(val:int=5):
    print('this is my task')
    time.sleep(val)

@flow(name='main flow')
def demo_flow(param:int):
    task1(param)
    ecs_task_block = ECSTask.load("ecs-fargate-block")
    

if __name__ == "__main__":
    prm = 4
    demo_flow(prm)

