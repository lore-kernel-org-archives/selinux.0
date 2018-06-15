To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20180609200834.9618-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c7dfd43c-7000-e728-ca94-f9db8c008692@tycho.nsa.gov>
Date: Fri, 15 Jun 2018 09:06:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180609200834.9618-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 1/1] scripts: add a helper script to run clang's static
 analyzer
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/09/2018 04:08 PM, Nicolas Iooss wrote:
> Using clang's static analyzer is as simple as running "scan-build make",
> but in order to obtain clean and reproducible results, the build
> environment has to be cleaned beforehand ("make clean distclean").
> 
> Moreover the project requires running "make install" before "make test"
> in order to install the dependencies needed for the tests, and running
> these tests with the newly-built libraries requires a specific
> LD_LIBRARY_PATH. This new script takes care of setting up everything
> which is needed.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  scripts/.gitignore     |  1 +
>  scripts/run-scan-build | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 scripts/.gitignore
>  create mode 100755 scripts/run-scan-build
> 
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> new file mode 100644
> index 000000000000..54882b3b1507
> --- /dev/null
> +++ b/scripts/.gitignore
> @@ -0,0 +1 @@
> +/output-scan-build/
> diff --git a/scripts/run-scan-build b/scripts/run-scan-build
> new file mode 100755
> index 000000000000..8b24a4d04647
> --- /dev/null
> +++ b/scripts/run-scan-build
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +# Run clang's static analyzer (scan-build) and record its output in output-scan-build/
> +
> +# Ensure the current directory is where this script is
> +cd "$(dirname -- "$0")" || exit $?
> +
> +OUTPUTDIR="$(pwd)/output-scan-build"
> +
> +# Display the commands which are run, and make sure they succeed
> +set -x -e
> +
> +# Use a temporary directory as an installation directory, if $DESTDIR is not set
> +if [ -z "$DESTDIR" ] ; then
> +    DESTDIR="$(mktemp --tmpdir -d scan-build-destdir-XXXXXXXXXX)"
> +fi
> +
> +# Make sure to use the newly-installed libraries when running tests
> +export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
> +export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
> +export PYTHONPATH="$DESTDIR$(${PYTHON:-python} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
> +export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
> +
> +# Build and analyze
> +make -C .. CC=clang clean distclean -j"$(nproc)"
> +scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. CC=clang DESTDIR="$DESTDIR" install install-pywrap install-rubywrap all test
> +
> +# Reduce the verbosity in order to keep the message from scan-build saying
> +# "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to examine bug reports.
> +set +x
> +
> +# Remove the destination directory without using "rm -rf"
> +chmod u+w "$DESTDIR/usr/bin/newrole"
> +rm -r "$DESTDIR"
> 
