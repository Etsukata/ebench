.PHONY : all compile clean eunit edoc

all: compile

compile:
	@./rebar compile

clean:
	@./rebar clean

eunit:
	@./rebar eunit

edoc:
	@./rebar doc
