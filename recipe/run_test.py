import pytest
from pathlib import Path
import subprocess

THIS_FILE_BYTES = Path(__file__).read_bytes()


@pytest.fixture
def the_temp_data(tmp_path: Path) -> Path:
    data = tmp_path / "data"
    data.write_bytes(THIS_FILE_BYTES)
    return data


@pytest.fixture
def the_cli_hash(the_temp_data: Path) -> str:
    return subprocess.check_output(
        ["tlsh", "-f", f"{the_temp_data}"], encoding="utf-8"
    ).strip()


def test_hash(the_cli_hash: str) -> None:
    import tlsh

    the_py_hash = tlsh.hash(THIS_FILE_BYTES)
    assert the_cli_hash == the_py_hash, "`tlsh.hash` did not match `tlsh -f`"


if __name__ == "__main__":
    pytest.main([__file__, "-vv", "--tb=long", "--color=yes"])
