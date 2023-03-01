install:
	# install dependencies
	pip install --upgrade pip &&\
		pip install -r requirements.txt 
format:
	# format python code with black
	black flows/*.py 
lint:
	# check code syntaxes
	pylint --disable=R,C flows/*.py 

prefect_depl:
	# prefect deployment
	prefect deployment build flows/demo_file.py:demo_flow -ib ecs-task/ecs-task -sb gitlab-repository/gitlab-demo -n "demo_ecs_fargate_flow" --output test1.yaml --apply
# depl_apply:
# 	# apply prefect deployment
# 	prefect deployment apply demo_flow-deployment.yaml