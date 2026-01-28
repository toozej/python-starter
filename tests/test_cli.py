from click.testing import CliRunner

from python_starter.cli import cli


def test_cli_shows_help():
    runner = CliRunner()
    result = runner.invoke(cli, ["--help"])
    assert result.exit_code == 0
    assert "python-starter" in result.output


def test_command_subcommand_runs():
    runner = CliRunner()
    result = runner.invoke(cli, ["command", "example"])
    assert result.exit_code == 0
    assert "Here is some output" in result.output


def test_dry_run_flag():
    """Test that --dry-run / -d flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--dry-run", "--help"])
    assert result.exit_code == 0
    assert "dry-run" in result.output


def test_dry_run_short_flag():
    """Test that -d short flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-d", "--help"])
    assert result.exit_code == 0


def test_force_flag():
    """Test that --force / -f flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--force", "--help"])
    assert result.exit_code == 0
    assert "force" in result.output


def test_force_short_flag():
    """Test that -f short flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-f", "--help"])
    assert result.exit_code == 0


def test_debug_flag():
    """Test that --debug / -D flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--debug", "--help"])
    assert result.exit_code == 0
    assert "debug" in result.output


def test_debug_short_flag():
    """Test that -D short flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-D", "--help"])
    assert result.exit_code == 0


def test_verbose_flag():
    """Test that --verbose / -v flag is recognized (can be used multiple times)"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--verbose", "--help"])
    assert result.exit_code == 0
    assert "verbose" in result.output


def test_verbose_short_flag():
    """Test that -v short flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-v", "--help"])
    assert result.exit_code == 0


def test_verbose_count():
    """Test that -v can be used multiple times"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-vvv", "--help"])
    assert result.exit_code == 0


def test_quiet_flag():
    """Test that --quiet / -q flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--quiet", "--help"])
    assert result.exit_code == 0
    assert "quiet" in result.output


def test_quiet_short_flag():
    """Test that -q short flag is recognized"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-q", "--help"])
    assert result.exit_code == 0


def test_command_with_all_flags():
    """Test that command subcommand works with all common flags"""
    runner = CliRunner()
    result = runner.invoke(
        cli,
        ["-d", "-f", "-D", "-v", "command", "test_example"],
    )
    assert result.exit_code == 0


def test_command_with_option():
    """Test that command subcommand works with -o/--option"""
    runner = CliRunner()
    result = runner.invoke(cli, ["command", "test_example", "--option", "my_value"])
    assert result.exit_code == 0
    assert "option was set to my_value" in result.output


def test_command_with_short_option():
    """Test that command subcommand works with -o short option"""
    runner = CliRunner()
    result = runner.invoke(cli, ["command", "test_example", "-o", "short_value"])
    assert result.exit_code == 0
    assert "option was set to short_value" in result.output


def test_command_help_shows_option():
    """Test that command subcommand help shows -o/--option"""
    runner = CliRunner()
    result = runner.invoke(cli, ["command", "--help"])
    assert result.exit_code == 0
    assert "-o" in result.output
    assert "--option" in result.output


def test_example_argument_echoed():
    """Test that example argument is properly echoed"""
    runner = CliRunner()
    result = runner.invoke(cli, ["command", "my_example"])
    assert result.exit_code == 0
    assert "example argument was set to my_example" in result.output


def test_debug_mode_output():
    """Test that debug mode produces debug output"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--debug", "command", "test"])
    assert result.exit_code == 0
    assert "Debug mode is enabled" in result.output


def test_dry_run_output():
    """Test that dry-run mode produces dry-run output"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--dry-run", "command", "test"])
    assert result.exit_code == 0
    assert "Dry-run mode is enabled" in result.output


def test_force_output():
    """Test that force mode produces force output"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--force", "command", "test"])
    assert result.exit_code == 0
    assert "Force mode is enabled" in result.output


def test_verbose_level_output():
    """Test that verbose mode shows level in output"""
    runner = CliRunner()
    result = runner.invoke(cli, ["-vvv", "command", "test"])
    assert result.exit_code == 0
    assert "Verbose mode is enabled (level 3)" in result.output


def test_quiet_output():
    """Test that quiet mode produces quiet output"""
    runner = CliRunner()
    result = runner.invoke(cli, ["--quiet", "command", "test"])
    assert result.exit_code == 0
    assert "Quiet mode is enabled" in result.output


def test_all_flags_with_command():
    """Test that all flags work together with command subcommand"""
    runner = CliRunner()
    result = runner.invoke(
        cli,
        ["-d", "-f", "-D", "-vv", "-q", "command", "test_example", "-o", "test_option"],
    )
    assert result.exit_code == 0
    assert "example argument was set to test_example" in result.output
    assert "option was set to test_option" in result.output
    assert "Debug mode is enabled" in result.output
    assert "Dry-run mode is enabled" in result.output
    assert "Force mode is enabled" in result.output
    assert "Verbose mode is enabled (level 2)" in result.output
    assert "Quiet mode is enabled" in result.output
