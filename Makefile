# SEE: https://trivialfis.github.io/linux/2018/06/10/Using-guix-for-development.html#fourth-example
# SEE: https://ambrevar.xyz/guix-packaging/

SOURCES_PY:=$(wilcard *.py src/py/*/*.py)
SOURCES_GUIX:=$(wilcard *.scm)
SOURCES:=$(SOURCES_PY) $(SOURCES_GUIX)

package: package.scm $(SOURCES_PY)
	guix package --install-from-file=package.scm

# SEE: https://guix.gnu.org/manual/en/html_node/Invoking-guix-pack.html
# container: package.scm $(SOURCES)
# 	guix pack -f docker -m package.scm

# This builds the package, this is where you
build: package.scm $(SOURCES_PY)
	guix build -f package.scm

run-container: build
	guix environment --container --ad-hoc python-wrapper -l package.scm -- python -m guixpythonapp

# FIXME: This does not seem to work, this should detect changes in the source file
clean:
	guix gc --delete `guix build -f package.scm`

# EOF
