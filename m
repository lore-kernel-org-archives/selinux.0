Subject: Re: Re: [patch 7/7] Use -Werror
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, method@manicmethod.com
In-Reply-To: <200801072047.m07KlXAs026116@cadmus.columbia.tresys.com>
References: <200801072047.m07KlXAs026116@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 08:09:24 -0500
Message-Id: <1199884164.9393.210.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-01-07 at 15:47 -0500, Todd C. Miller wrote:
> Stephen Smalley wrote:
> 
> > A bit overzealous though - some of them already had -Werror in CFLAGS.
> > Also need to make sure that -Werror gets included by make DEBUG=1.
> 
> Updated patch without the duplicated -Werror and adds it for
> the DEBUG=1 cases.

This breaks make pywrap in libselinux, or install-pywrap from top.

> 
>  - todd
> 
> ---
>  Makefile                          |    2 +-
>  checkpolicy/Makefile              |    2 +-
>  libselinux/src/Makefile           |    2 +-
>  libsemanage/src/Makefile          |    2 +-
>  libsepol/src/Makefile             |    2 +-
>  libsepol/utils/Makefile           |    2 +-
>  policycoreutils/secon/Makefile    |    2 +-
>  policycoreutils/setfiles/Makefile |    2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> Index: trunk/Makefile
> ===================================================================
> --- trunk.orig/Makefile
> +++ trunk/Makefile
> @@ -2,7 +2,7 @@ SUBDIRS=libsepol libselinux libsemanage 
>  PYSUBDIRS=libselinux libsemanage
>  
>  ifeq ($(DEBUG),1)
> -	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow
> +	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
>  	export LDFLAGS = -g
>  endif
>  
> Index: trunk/checkpolicy/Makefile
> ===================================================================
> --- trunk.orig/checkpolicy/Makefile
> +++ trunk/checkpolicy/Makefile
> @@ -10,7 +10,7 @@ TARGETS = checkpolicy checkmodule
>  
>  YACC = bison -y
>  
> -CFLAGS ?= -g -Wall -O2 -pipe -fno-strict-aliasing
> +CFLAGS ?= -g -Wall -Werror -O2 -pipe -fno-strict-aliasing
>  
>  override CFLAGS += -I. -I${INCLUDEDIR}
>  
> Index: trunk/libselinux/src/Makefile
> ===================================================================
> --- trunk.orig/libselinux/src/Makefile
> +++ trunk/libselinux/src/Makefile
> @@ -32,7 +32,7 @@ SRCS= $(filter-out $(UNUSED_SRCS), $(fil
>  
>  OBJS= $(patsubst %.c,%.o,$(SRCS))
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS))
> -CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
> +CFLAGS ?= -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
>  override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
>  RANLIB=ranlib
>  
> Index: trunk/libsemanage/src/Makefile
> ===================================================================
> --- trunk.orig/libsemanage/src/Makefile
> +++ trunk/libsemanage/src/Makefile
> @@ -10,7 +10,7 @@ PYLIBDIR ?= $(LIBDIR)/${PYLIBVER}
>  DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
>  
>  ifeq ($(DEBUG),1)
> -	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow
> +	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
>  	export LDFLAGS = -g
>  endif
>  
> Index: trunk/libsepol/src/Makefile
> ===================================================================
> --- trunk.orig/libsepol/src/Makefile
> +++ trunk/libsepol/src/Makefile
> @@ -10,7 +10,7 @@ TARGET=libsepol.so
>  LIBSO=$(TARGET).$(LIBVERSION)
>  OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
>  LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
> -CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
> +CFLAGS ?= -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
>  override CFLAGS += -I. -I../include -D_GNU_SOURCE
>  
>  all: $(LIBA) $(LIBSO)
> Index: trunk/libsepol/utils/Makefile
> ===================================================================
> --- trunk.orig/libsepol/utils/Makefile
> +++ trunk/libsepol/utils/Makefile
> @@ -2,7 +2,7 @@
>  PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  
> -CFLAGS ?= -Wall
> +CFLAGS ?= -Wall -Werror
>  override CFLAGS += -I../include
>  LDLIBS += -L../src -lsepol 
>  
> Index: trunk/policycoreutils/secon/Makefile
> ===================================================================
> --- trunk.orig/policycoreutils/secon/Makefile
> +++ trunk/policycoreutils/secon/Makefile
> @@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= ${PREFIX}/lib
>  
> -WARNS=-W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
> +WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
>  VERSION = $(shell cat ../VERSION)
>  CFLAGS ?= $(WARNS) -O1
>  override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
> Index: trunk/policycoreutils/setfiles/Makefile
> ===================================================================
> --- trunk.orig/policycoreutils/setfiles/Makefile
> +++ trunk/policycoreutils/setfiles/Makefile
> @@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
>  
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  
> -CFLAGS = -Werror -Wall -W 
> +CFLAGS = -Werror -Wall -W
>  override CFLAGS += -D_FILE_OFFSET_BITS=64 -I$(PREFIX)/include
>  LDLIBS = -lselinux -lsepol -L$(LIBDIR)
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
