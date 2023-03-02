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

build_infra:
	# build terraform code
	terraform apply -auto-approve

prefect_depl:
	# prefect deployment
	prefect deployment build flows/demo_file.py:demo_flow -ib ecs-task/ecs-task -sb github/github -n "demo_ecs_fargate_flow" --cron "*/1 * * * *" --output demo_ecs_out.yaml --skip-upload --apply


