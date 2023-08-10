# Assigment 1

## Description

The task was to create a script called `script.sh` that will extract content of this archive and parse those log, so a number of request per IP can be shown. Script also has additional options `--user-agent` and `--method` to restrict parsing to provided user agent or request method.
Additionally I've added the -h|--help option, wchich print help message with usage examples.

## Running script

```bash
cd ./assigment-1
./script.sh OPTIONS
```

The output from the script can be to long, to see it all in the console, so you can pass the output to the file:

```bash
cd ./assigment-1
./script.sh OPTIONS > script.log
```

Example:

```bash
cd ./assigment-1
./script.sh --user-agent Mozilla --method GET
```
