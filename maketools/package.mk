
VERSION := $(shell poetry version -s)
WHEEL := $(BUILD.dir)/servicegwc-$(VERSION)-py3-none-any.whl
SDIST := $(BUILD.dir)/servicegwc-$(VERSION).tar.gz
PYZ := $(BUILD.dir)/servicegwc.pyz

.PHONY: package

package: $(PYZ) $(WHEEL) $(SDIST) | $(BUILD.dir)

$(PYZ): $(PY_SRC)
	$(Q)$(POETRY) run shiv -e servicegwc.__main__:entrypoint -o $(abspath $(@)) .

$(WHEEL): $(PY_SRC)
	$(Q)$(POETRY) build -f wheel && mv dist/$(notdir $(@)) $(BUILD.dir)

$(SDIST): $(PY_SRC)
	$(Q)$(POETRY) build -f sdist && mv dist/$(notdir $(@)) $(BUILD.dir)
