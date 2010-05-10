Subject: Re: [PATCH] Fix build error with gcc (GCC) 4.6.0 20100416
 (experimental)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
In-Reply-To: <1273303859-22077-1-git-send-email-justinmattock@gmail.com>
References: <1273303859-22077-1-git-send-email-justinmattock@gmail.com>
Content-Type: text/plain
Date: Mon, 10 May 2010 08:46:06 -0400
Message-Id: <1273495566.4896.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-05-08 at 00:30 -0700, Justin P. Mattock wrote:
> When compiling userspace tools with 
> (GCC) 4.6.0 20100416 I'm getting this error:
> 
> booleans.c: In function 'sepol_bool_count':
> booleans.c:106:39: error: parameter 'handle' set but not used
> cc1: all warnings being treated as errors
> 
> This patch is a temporary fix and/or perminent
> (depending on what you guys decide).

Removing -Werror isn't a "fix".  To fix, add __attribute__((unused)) as
appropriate.

> 
> 
> 
> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> ---
>  checkpolicy/Makefile    |    2 +-
>  libsepol/src/Makefile   |    2 +-
>  libsepol/utils/Makefile |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index e5fae3d..34fa857 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -10,7 +10,7 @@ TARGETS = checkpolicy checkmodule
>  
>  YACC = bison -y
>  
> -CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
> +CFLAGS ?= -g -Wall  -Wshadow -O2 -pipe -fno-strict-aliasing
>  
>  override CFLAGS += -I. -I${INCLUDEDIR}
>  
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 73fdef8..be0d4d8 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -14,7 +14,7 @@ LIBPC=libsepol.pc
>  LIBSO=$(TARGET).$(LIBVERSION)
>  OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
>  LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
> -CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
> +CFLAGS ?=  -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
>  override CFLAGS += -I. -I../include -D_GNU_SOURCE
>  
>  all: $(LIBA) $(LIBSO) $(LIBPC)
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index 6864114..9985cf6 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -2,7 +2,7 @@
>  PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  
> -CFLAGS ?= -Wall -Werror
> +CFLAGS ?= -Wall 
>  override CFLAGS += -I../include
>  LDLIBS += -L../src -lsepol 
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
