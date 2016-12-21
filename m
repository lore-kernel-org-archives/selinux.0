Message-ID: <1482347801.16789.4.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 0/7] Remove ustr library dependency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Wed, 21 Dec 2016 14:16:41 -0500
In-Reply-To: <20161221182104.16967-1-nicolas.iooss@m4x.org>
References: <20161221182104.16967-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-12-21 at 19:20 +0100, Nicolas Iooss wrote:
> Hello,
> 
> ustr library uses old (pre-C99) "extern inline" semantic. This makes
> it
> incompatible with recent versions of gcc and clang, which default to
> C99 standard. Distributions have shipped patched versions of this
> library to fix issues [1] but there is no upstream solution to make
> ustr
> compatible with C99 standard. Moreover the git tree of ustr
> (http://www.and.org/ustr/ustr.git) has not been updated since 2008
> and
> the developer of this project did not reply to emails.
> 
> This patchset aims at removing ustr from SELinux userland libraries
> and
> tools. The library is currenlty only used by genhomedircon functions
> in
> libsemanage. Here is how the patches are organised:
> 
> * patches 1 and 2 make libsemanage test infrastructure work properly,
> * patch 3 expands some test cases in order to better check the
>   modifications of the next patch,
> * patch 4 reimplements functions in libsemanage/src/utilities.c
> without
>   ustr,
> * patches 5 and 6 remove ustr from libsemanage/src/genhomedircon.c (I
>   introduced a new function, semanage_str_replace(), to replace
>   ustr_replace_cstr()),
> * patch 7 removes references to ustr in Makefile, README and pkg-
> config
>   files.
> 
> In this second revision:
> * semanage_split() got slightly modified in order to make it even
> more simpler,
>   in patch 4. test_semanage_split() has been modified accordingly in
> patch 3.
> * Some "variable += 1" and "variable -= 1" expression were rewritten
> using ++
>   and -- operations.
> * In fcontext_matches() (patch 6), the stripping of oexpr suffixes
> now uses a
>   locally-defined macro. This fixes a bug which would have been
> introduced by
>   this patchset.
> * In extract_context() (patch 6), using a whitespace variable has
> been replaced
>   with calls to isspace().
> * In write_contexts() (patch 6) a memory leak has been fixed.

Thanks, all seven patches applied.  Thanks for ridding selinux of this
dependency.

> 
> Thanks,
> Nicolas
> 
> [1] for example Gentoo package uses this patch:
> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-libs/ustr/files/us
> tr-1.0.4-gcc_5-
> check.patch?id=7dea6f8820f36bf389e6315044bea7507553bed0
> 
> Nicolas Iooss (7):
>   libsemanage/tests: make "make test" fail when a CUnit test fails
>   libsemanage/tests: make tests standalone
>   libsemanage/tests: test more cases of semanage_split*()
>   libsemanage: simplify string utilities functions
>   libsemanage: add semanage_str_replace() utility function
>   libsemanage: genhomedircon: drop ustr dependency
>   libsemanage: remove ustr library from Makefiles, README and pkg-
> config
> 
>  README                                |   2 +-
>  libsemanage/src/Makefile              |   2 +-
>  libsemanage/src/genhomedircon.c       | 154 +++++++++++++++++-------
> ----------
>  libsemanage/src/libsemanage.pc.in     |   2 +-
>  libsemanage/src/utilities.c           | 114 +++++++++++++++---------
> -
>  libsemanage/src/utilities.h           |  10 +++
>  libsemanage/tests/Makefile            |  14 ++--
>  libsemanage/tests/libsemanage-tests.c |   9 +-
>  libsemanage/tests/test_utilities.c    |  85 +++++++++++++++----
>  9 files changed, 238 insertions(+), 154 deletions(-)
> 
