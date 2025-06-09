import os
import re
glob = os.path

VERSE_DIR = os.path.join(os.path.dirname(__file__), '..', 'Verse')

# Collect all verse files
VERSE_FILES = [f for f in os.listdir(VERSE_DIR) if f.endswith('.verse')]

# ---------------- tests ----------------

import pytest

@pytest.mark.parametrize('filename', VERSE_FILES)
def test_module_declaration(filename):
    path = os.path.join(VERSE_DIR, filename)
    with open(path, 'r') as f:
        content = f.read()
    assert 'module GravityBox' in content

@pytest.mark.parametrize('filename', VERSE_FILES)
def test_class_declaration(filename):
    path = os.path.join(VERSE_DIR, filename)
    expected_class = os.path.splitext(filename)[0]
    with open(path, 'r') as f:
        content = f.read()
    # GravityBox.verse contains GravityBoxGame as the main class
    possible = [expected_class, f"{expected_class}Game"]
    found = any(re.search(r'class\s+' + re.escape(name) + r'\b', content) for name in possible)
    assert found, f"{expected_class} class missing"

def test_readme_references_verse_files():
    readme_path = os.path.join(os.path.dirname(__file__), '..', 'README.md')
    with open(readme_path, 'r') as f:
        readme = f.read()
    for vf in VERSE_FILES:
        assert vf in readme, f"{vf} not referenced in README"
