import click


@click.group()
@click.version_option()
@click.pass_context
@click.option(
    "--dry-run",
    "-d",
    is_flag=True,
    default=False,
    help="Run in dry-run mode (no changes will be made)",
)
@click.option(
    "--force",
    "-f",
    is_flag=True,
    default=False,
    help="Force execution (skip confirmation prompts)",
)
@click.option(
    "--debug",
    "-D",
    is_flag=True,
    default=False,
    help="Enable debug mode",
)
@click.option(
    "--verbose",
    "-v",
    count=True,
    help="Enable verbose output (use multiple times for more verbosity)",
)
@click.option(
    "--quiet",
    "-q",
    is_flag=True,
    default=False,
    help="Suppress output (quiet mode)",
)
def cli(ctx, dry_run, force, debug, verbose, quiet):
    """python-starter"""
    ctx.obj = {
        "dry_run": dry_run,
        "force": force,
        "debug": debug,
        "verbose": verbose,
        "quiet": quiet,
    }


@cli.command(name="command")
@click.pass_obj
@click.argument("example")
@click.option(
    "-o",
    "--option",
    help="An example option",
)
def first_command(obj, example, option):
    """Command description goes here"""
    click.echo("Here is some output")
    if example:
        click.echo(f"example argument was set to {example}")
    if option:
        click.echo(f"option was set to {option}")
    if obj["debug"]:
        click.echo("Debug mode is enabled")
    if obj["dry_run"]:
        click.echo("Dry-run mode is enabled")
    if obj["force"]:
        click.echo("Force mode is enabled")
    if obj["verbose"]:
        click.echo("Verbose mode is enabled (level {})".format(obj["verbose"]))
    if obj["quiet"]:
        click.echo("Quiet mode is enabled")
