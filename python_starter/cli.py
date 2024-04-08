import click


@click.group()
@click.version_option()
def cli():
    "python-starter"


@cli.command(name="command")
@click.argument("example")
@click.option(
    "-o",
    "--option",
    help="An example option",
)
def first_command(example, option):
    "Command description goes here"
    click.echo("Here is some output")
    if example:
        click.echo("example argument was set")
    if option:
        click.echo("option was set")
