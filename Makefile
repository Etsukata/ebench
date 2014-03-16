.PHONY : all compile clean bench edoc

all: compile

compile:
	@./rebar compile

clean:
	@./rebar clean

bench:
	@./rebar ct

edoc:
	@./rebar doc
