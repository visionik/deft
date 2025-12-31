# OuraCLI Specification

**Project**: CLI tool for accessing Oura Ring data

## Overview

OuraCLI is a command-line interface for retrieving and displaying Oura Ring health data.

## Dependencies

**Oura Ring Python Module**: https://github.com/hedgertronic/oura-ring

## Features

### CLI Commands

Provide CLI commands/options for obtaining and outputting data from each method available in the oura-ring Python module.

CLI should accept flexible date ranges including

- today
- yesterday
- 1 day (today)
- 2 days (today and yesterday)
- n days
- n week(s)
- n month(s)
- range as start date + day/days/weeks/months as above

### Output Formats

**Default**: Tree-style (without lines), English language

**Additional formats**:
- `--json` - JSON output
- `--dataframe` - Pandas DataFrame output
- `--markdown` - Markdown formatted output

## Implementation Notes

- Use typer[all] for CLI framework
- Each oura-ring module method maps to a CLI command/subcommand
- All output formats must be supported for each data retrieval command
- there should also be an option to output ALL of the oura-ring method data
