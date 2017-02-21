Subject: Re: [PATCH 1/1] libselinux, libsemanage: make PYPREFIX computation
 more robust
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170219215329.3143-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <9e1d4a1d-3b87-b63c-0a4c-33692604f448@tycho.nsa.gov>
Date: Tue, 21 Feb 2017 13:56:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170219215329.3143-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/19/2017 04:53 PM, Nicolas Iooss wrote:
> On systems where $PYTHON is python3.5 (instead of python2 or python3),
> pkg-config fails to find the Python package because it is named with a
> dash (e.g. python-3.5).
>
> Moreover the build system may have been using the pkg-config
> configuration files for the wrong Python version when several Python
> with the same major version number are installed (e.g. using python-3.5
> on a system with both python-3.4 and python-3.5 and where
> /usr/lib/pkgconfig/python3.pc is a symlink to python-3.5.pc).
>
> In order to fix these two issues, compute $PYPREFIX from $PYTHON by
> using the full major.minor version.
>
> Moreover update Travis-Ci configuration to grab the relevant
> configuration files for pkg-config from /opt/python (for example
> /opt/python/3.5.2/lib/pkgconfig/python-3.5.pc) instead of using
> system-provided files (/usr/lib/x86_64-linux-gnu/pkgconfig/python3.pc
> and /usr/lib/x86_64-linux-gnu/pkgconfig/python2.pc).
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,
Jim

> ---
>  .travis.yml              | 3 ++-
>  libselinux/src/Makefile  | 2 +-
>  libsemanage/src/Makefile | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 6dce35165bd3..7d7424459344 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -76,7 +76,8 @@ before_script:
>    # Configure the variables for Python parts
>    - export VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
>    - export PYTHON="$VIRTUAL_ENV/bin/python"
> -  - export PYPREFIX="$($PYTHON -c 'import sys;print("python%d" % sys.version_info[0])')"
> +  # Use the header files in /opt/python/... for Python because the virtualenvs do not provide Python.h
> +  - export PKG_CONFIG_PATH="/opt/python/$($PYTHON -c 'import sys;print("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
>    # PyPy does not provide a config file for pkg-config nor a pypy-c.so
>    - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
>    # Python virtualenvs do not support "import site; print(site.getsitepackages()[0]"
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 5640a57d2768..a277b8715819 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -2,7 +2,7 @@
>  # runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
>  # targets with "PYPREFIX":
>  PYTHON ?= python
> -PYPREFIX ?= $(notdir $(PYTHON))
> +PYPREFIX ?= $(shell $(PYTHON) -c 'import sys;print("python-%d.%d" % sys.version_info[:2])')
>  RUBY ?= ruby
>  RUBYPREFIX ?= $(notdir $(RUBY))
>  PKG_CONFIG ?= pkg-config
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 92c829be234d..77f6efc86d2d 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -2,7 +2,7 @@
>  # runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
>  # targets with "PYPREFIX":
>  PYTHON ?= python
> -PYPREFIX ?= $(notdir $(PYTHON))
> +PYPREFIX ?= $(shell $(PYTHON) -c 'import sys;print("python-%d.%d" % sys.version_info[:2])')
>  RUBY ?= ruby
>  RUBYPREFIX ?= $(notdir $(RUBY))
>  PKG_CONFIG ?= pkg-config
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
