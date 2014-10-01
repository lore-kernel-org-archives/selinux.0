Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s91J0nPi008616
 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2014 15:00:49 -0400
Message-ID: <542C4F59.2050408@tresys.com>
Date: Wed, 1 Oct 2014 15:00:41 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 00/20] Compiling userland lib & tools with hardened gcc
 flags
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/14/2014 05:41 PM, Nicolas Iooss wrote:
> Hi,
> 
> After I discovered libsepol/cil happened to use "%n" in printf format
> string, I decided to compile SELinux userland libraries and tools with
> more compilation flags.  I used:
> 
>     CFLAGS = -O2 -pipe -Wall -Wextra -Werror \
>         -D_FORTIFY_SOURCE=2 \
>         -Wfloat-equal \
>         -Wformat -Wformat-security \
>         -Winit-self \
>         -Wmissing-declarations \
>         -Wpointer-arith \
>         -Wshadow \
>         -Wsign-compare \
>         -Wstrict-prototypes \
>         -Wwrite-strings \
>         -Wno-unused-result \
>         -fno-exceptions \
>         -fstack-protector --param=ssp-buffer-size=4
>     LDFLAGS = -Wl,-as-needed,-no-undefined,-z,relro,-z,now \
>          -fstack-protector
> 
> These warning flags are described in
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html.
> 
> The build is broken when using all of these flags and this patchset is
> an attempt to fix some warnings/errors.  Here is what I found:
> 
> * Combining "-O2 -Wall -Werror" made the build fail because of use of
>   unitialized variables.  Patches 1, 2 and 3 fix this.
> * -Wshadow is already enabled when doing "make DEBUG=1" but this did not
>   prevent some programs from shadowing global variables.  Patches 4 and
>   5 fix this.
> * To make "-Wformat -Wformat-security" useful, a format attribute should
>   be added to logging functions.  When doing such a thing, gcc warns
>   about some format string.  Patches 6 and 7 add the attribute and fixes
>   some new warnings.
> * While at it, checkpolicy logging function used "char *message" instead
>   of "const char *message".  Patch 8 modifies this.
> * -Wsign-compare makes gcc complains on some implicit casts.  Patches 9,
>   10 and 11 fix the generated warnings.
> * -Wwrite-strings makes gcc complains when using code like:
> 
>     char *s = "text"
> 
>   Here, s is a pointer to a read-only location and should be made
>   "const char*".  Patches 12 to 17 fix most of these warnings.  Some of
>   them cannot be fixed without changing the API defined in
>   /usr/include/sepol/policydb/hashtab.h (in short: replacing "const
>   hashtab_key_t k" with "const char *k").  As this patchset focuses on
>   fixing internal things, this API has not been changed.
> * -Wstrict-prototypes complained about some functions defined with an
>   empty argument list instead of (void).  Patch 18 adds the missing
>   arguments and marks them with __attribute__ ((unused)) when
>   applicable.
> * -Wunused-variable (from -Wall) made gcc complain about unused
>   parameters in checkpolicy/.  Patch 19 adds some __attribute__
>   ((unused)).
> * -Wmissing-declarations helps finding missing "static" keyword when
>   defining functions and missing headers when the function is willingly
>   non-static.  There are too many warnings caused by this flag to make
>   it useful.
> * Last but not the least, when testing with "make test", gcc complained
>   with -Warray-bounds warning because libsepol/tests/test-linker-roles.c
>   had:
> 
>     unsigned int decls[2]
>     /* ... */
>     decls[2] = ...
> 
>   ... Patch 20 replaces the first "2" by "3" to fix this bug.
> 
> With this patchset, the build succeeds when using the given CFLAGS
> configuration without -Wwrite-strings and -Wmissing-declarations.
> 
> The linker_roles test from libsepol fails because CIL changed the way
> roles in base policy are managed:
> 
>     Suite: linker
>       Test: linker_indexes ...passed
>       Test: linker_types ...passed
>       Test: linker_roles ...
>     role o1_b_role_1 has 0 types, 1 expected
>     [[SNIP]]
>     FAILED
> 
> This failure has not been introduced by this patchset and this patchset
> does not fix the test nor introduces new failures.
> 
> Cheers
> 
> 
> Nicolas Iooss (20):
>   libsepol: fix potential free of uninitialized pointer
>   libsemanage: Fix use of unitialized variable
>   policycoreutils/hll/pp: fix potential use of uninitialized variable
>   policycoreutils/sandbox: fix debug build
>   policycoreutils/semodule_package: fix debug build
>   policycoreutils/hll/pp: add printf format attribute to relevant
>     functions
>   checkpolicy: add printf format attribute to relevant functions
>   checkpolicy: constify the message written by yyerror and yywarn
>   libselinux: fix gcc -Wsign-compare warnings
>   checkpolicy: fix gcc -Wsign-compare warnings
>   libsepol: fix most gcc -Wwrite-strings warnings
>   libsemanage: constify name and ext_lang parameters of
>     semanage_module_install_hll
>   libsepol/cil: fix gcc -Wwrite-strings warnings
>   libsemanage: fix gcc -Wwrite-strings warnings
>   checkpolicy: fix most gcc -Wwrite-strings warnings
>   policycoreutils/hll/pp: fix gcc -Wwrite-strings warnings
>   policycoreutils: fix most gcc -Wwrite-strings warnings
>   Fix gcc -Wstrict-prototypes warnings
>   checkpolicy: fix gcc -Wunused-variable warnings
>   libsepol/tests: fix gcc -Warray-bounds warning
> 
>  checkpolicy/checkmodule.c                          | 10 ++--
>  checkpolicy/checkpolicy.c                          | 15 +++---
>  checkpolicy/module_compiler.c                      | 13 ++---
>  checkpolicy/policy_define.c                        | 33 ++++++------
>  checkpolicy/policy_define.h                        |  2 +-
>  checkpolicy/policy_parse.y                         |  6 +--
>  checkpolicy/policy_scan.l                          |  8 +--
>  checkpolicy/test/dismod.c                          |  6 +--
>  checkpolicy/test/dispol.c                          |  8 +--
>  libselinux/src/label_file.c                        |  9 ++--
>  libselinux/src/label_file.h                        |  2 +-
>  libselinux/utils/sefcontext_compile.c              |  4 +-
>  libsemanage/src/conf-parse.y                       |  6 +--
>  libsemanage/src/direct_api.c                       |  4 +-
>  libsemanage/src/modules.c                          |  2 +-
>  libsemanage/src/modules.h                          |  2 +-
>  libsemanage/src/policy.h                           |  2 +-
>  libsemanage/src/seusers_local.c                    |  3 +-
>  libsemanage/src/utilities.c                        |  6 +--
>  libsemanage/src/utilities.h                        |  6 +--
>  libsepol/cil/src/cil.c                             |  2 +-
>  libsepol/cil/src/cil_mem.c                         |  2 +-
>  libsepol/cil/src/cil_mem.h                         |  2 +-
>  libsepol/cil/src/cil_policy.c                      | 10 ++--
>  libsepol/cil/src/cil_strpool.c                     |  2 +-
>  libsepol/cil/src/cil_strpool.h                     |  2 +-
>  libsepol/include/sepol/policydb/services.h         |  2 +-
>  libsepol/src/link.c                                |  6 +--
>  libsepol/src/policydb.c                            |  2 +-
>  libsepol/src/policydb_internal.h                   |  2 +-
>  libsepol/src/services.c                            | 22 ++++----
>  libsepol/src/write.c                               |  2 +-
>  libsepol/tests/test-linker-roles.c                 |  2 +-
>  policycoreutils/hll/pp/pp.c                        | 61 ++++++++++++----------
>  policycoreutils/newrole/newrole.c                  |  6 +--
>  policycoreutils/restorecond/restorecond.c          |  8 +--
>  policycoreutils/restorecond/restorecond.h          |  2 +-
>  policycoreutils/restorecond/user.c                 |  2 +-
>  policycoreutils/restorecond/utmpwatcher.c          |  2 +-
>  policycoreutils/restorecond/watch.c                |  2 +-
>  policycoreutils/run_init/run_init.c                |  2 +-
>  policycoreutils/sandbox/seunshare.c                | 12 ++---
>  .../semodule_package/semodule_package.c            |  6 +--
>  .../semodule_package/semodule_unpackage.c          |  6 +--
>  policycoreutils/setfiles/restore.h                 |  4 +-
>  policycoreutils/setfiles/setfiles.c                |  6 +--
>  46 files changed, 169 insertions(+), 155 deletions(-)
> 

ACK'ed. All patches will be applied as part of rc3. Note that the CIL
patch will be applied separately to the CIL repo and merged in.

Thanks!
- Steve
