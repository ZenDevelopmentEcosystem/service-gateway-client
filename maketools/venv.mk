
poetry: $(POETRY)

$(POETRY):
	$(Q)curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | $(PYTHON)
