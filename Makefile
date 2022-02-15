OUT_DIR=bin

all: build

build:
	mkdir -p $(OUT_DIR)
	crystal build --release src/repo_combiner.cr -o $(OUT_DIR)/repo_combiner

run:
	$(OUT_DIR)/repo_combiner

clean:
	rm -rf  $(OUT_DIR) .crystal .deps libs
