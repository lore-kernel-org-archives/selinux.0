Message-ID: <1497975590.12069.11.camel@tycho.nsa.gov>
Subject: Re: [PATCH] Makefiles: override *FLAGS and *LIBS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
Date: Tue, 20 Jun 2017 12:19:50 -0400
In-Reply-To: <20170620151641.19421-1-jason@perfinion.com>
References: <20170620151641.19421-1-jason@perfinion.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-06-20 at 23:16 +0800, Jason Zaman wrote:
> There were several places in the makefiles where LDLIBS or CFLAGS
> were
> supposed to include options to build. They were missing the override
> keyword so would be skipped if these vars were set on the make
> cmdline.
> Add the override directive to fix this.

Thanks, applied.

> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>  libsemanage/tests/Makefile               | 13 ++++---------
>  libsepol/utils/Makefile                  |  2 +-
>  mcstrans/utils/Makefile                  |  2 +-
>  policycoreutils/hll/pp/Makefile          |  2 +-
>  policycoreutils/load_policy/Makefile     |  2 +-
>  policycoreutils/newrole/Makefile         | 10 +++++-----
>  policycoreutils/run_init/Makefile        |  8 ++++----
>  policycoreutils/secon/Makefile           |  2 +-
>  policycoreutils/semodule/Makefile        |  3 +--
>  policycoreutils/sestatus/Makefile        |  6 +++---
>  policycoreutils/setfiles/Makefile        |  8 ++++----
>  policycoreutils/setsebool/Makefile       |  2 +-
>  restorecond/Makefile                     |  2 +-
>  sandbox/Makefile                         |  2 +-
>  secilc/Makefile                          |  3 +--
>  semodule-utils/semodule_expand/Makefile  |  2 +-
>  semodule-utils/semodule_link/Makefile    |  2 +-
>  semodule-utils/semodule_package/Makefile |  2 +-
>  18 files changed, 33 insertions(+), 40 deletions(-)
> 
> diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
> index 9ccb5b23..fcd616fa 100644
> --- a/libsemanage/tests/Makefile
> +++ b/libsemanage/tests/Makefile
> @@ -4,24 +4,19 @@ LIBDIR ?= $(PREFIX)/lib
>  # Add your test source files here:
>  SOURCES = $(sort $(wildcard *.c))
>  
> -# Add the required external object files here:
> -LIBS = ../src/libsemanage.a -lselinux -lsepol
> -
>  ####################################################################
> #######
>  
>  EXECUTABLE = libsemanage-tests
>  CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-
> format-attribute -Wno-unused-parameter
> -INCLUDE = -I../src -I../include
> -LDLIBS += -lcunit -lbz2 -laudit
> +override CFLAGS += -I../src -I../include
> +override LDLIBS += -lcunit -lbz2 -laudit ../src/libsemanage.a
> -lselinux -lsepol
> +
>  OBJECTS = $(SOURCES:.c=.o) 
>  
>  all: $(EXECUTABLE) 
>  
>  $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
> -	$(CC) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $@ $(LDLIBS)
> -
> -%.o: %.c
> -	$(CC) $(CFLAGS) $(INCLUDE) -c $*.c -o $*.o
> +	$(CC) $(OBJECTS) $(LDFLAGS) -o $@ $(LDLIBS)
>  
>  clean distclean: 
>  	rm -rf $(OBJECTS) $(EXECUTABLE)
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index 467aff27..fba1d8a0 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
>  CFLAGS ?= -Wall -Werror
>  override CFLAGS += -I../include
>  override LDFLAGS += -L../src
> -LDLIBS += -lsepol
> +override LDLIBS += -lsepol
>  
>  TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  
> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> index 7e596413..e35cfc2f 100644
> --- a/mcstrans/utils/Makefile
> +++ b/mcstrans/utils/Makefile
> @@ -6,7 +6,7 @@ LIBSEPOLA ?= $(LIBDIR)/libsepol.a
>  
>  CFLAGS ?= -Wall
>  override CFLAGS += -I../src -D_GNU_SOURCE
> -LDLIBS += -lselinux -lpcre
> +override LDLIBS += -lselinux -lpcre
>  
>  TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  
> diff --git a/policycoreutils/hll/pp/Makefile
> b/policycoreutils/hll/pp/Makefile
> index 813c9c6c..82813498 100644
> --- a/policycoreutils/hll/pp/Makefile
> +++ b/policycoreutils/hll/pp/Makefile
> @@ -8,7 +8,7 @@ LIBEXECDIR ?= $(PREFIX)/libexec
>  HLLDIR ?= $(LIBEXECDIR)/selinux/hll
>  
>  CFLAGS ?= -Werror -Wall -W
> -LDLIBS = -lsepol
> +override LDLIBS += -lsepol
>  
>  PP_SRCS = $(sort $(wildcard *.c))
>  PP_OBJS = $(patsubst %.c,%.o,$(PP_SRCS))
> diff --git a/policycoreutils/load_policy/Makefile
> b/policycoreutils/load_policy/Makefile
> index 256d95af..8ee1fb16 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -7,7 +7,7 @@ LOCALEDIR ?= /usr/share/locale
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += $(LDFLAGS) -DUSE_NLS
> -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lsepol -lselinux
> +override LDLIBS += -lsepol -lselinux
>  
>  TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  
> diff --git a/policycoreutils/newrole/Makefile
> b/policycoreutils/newrole/Makefile
> index bdefbb83..196af926 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -23,18 +23,18 @@ VERSION = $(shell cat ../VERSION)
>  CFLAGS ?= -Werror -Wall -W
>  EXTRA_OBJS =
>  override CFLAGS += -DVERSION=\"$(VERSION)\" -DUSE_NLS
> -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lselinux
> +override LDLIBS += -lselinux
>  ifeq ($(PAMH), y)
>  	override CFLAGS += -DUSE_PAM
>  	EXTRA_OBJS += hashtab.o
> -	LDLIBS += -lpam -lpam_misc
> +	override LDLIBS += -lpam -lpam_misc
>  else
>  	override CFLAGS += -D_XOPEN_SOURCE=500
> -	LDLIBS += -lcrypt
> +	override LDLIBS += -lcrypt
>  endif
>  ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
> -	LDLIBS += -laudit
> +	override LDLIBS += -laudit
>  endif
>  ifeq ($(LSPP_PRIV),y)
>  	override AUDIT_LOG_PRIV=y
> @@ -50,7 +50,7 @@ ifeq ($(NAMESPACE_PRIV),y)
>  endif
>  ifeq ($(IS_SUID),y)
>  	MODE := 4555
> -	LDLIBS += -lcap-ng
> +	override LDLIBS += -lcap-ng
>  else
>  	MODE := 0555
>  endif
> diff --git a/policycoreutils/run_init/Makefile
> b/policycoreutils/run_init/Makefile
> index 7b259525..921f0b07 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -10,17 +10,17 @@ AUDITH ?= $(shell test -f /usr/include/libaudit.h
> && echo y)
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\""
> -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lselinux
> +override LDLIBS += -lselinux
>  ifeq ($(PAMH), y)
>  	override CFLAGS += -DUSE_PAM
> -	LDLIBS += -lpam -lpam_misc
> +	override LDLIBS += -lpam -lpam_misc
>  else
>  	override CFLAGS += -D_XOPEN_SOURCE=500
> -	LDLIBS += -lcrypt
> +	override LDLIBS += -lcrypt
>  endif
>  ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
> -	LDLIBS += -laudit
> +	override LDLIBS += -laudit
>  endif
>  
>  TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
> diff --git a/policycoreutils/secon/Makefile
> b/policycoreutils/secon/Makefile
> index 1f074ff1..8e491d74 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -9,7 +9,7 @@ WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-
> arith -Wbad-function-cast -Wca
>  VERSION = $(shell cat ../VERSION)
>  CFLAGS ?= $(WARNS) -O1
>  override CFLAGS += -DVERSION=\"$(VERSION)\"
> -LDLIBS = -lselinux
> +override LDLIBS += -lselinux
>  
>  all: secon
>  
> diff --git a/policycoreutils/semodule/Makefile
> b/policycoreutils/semodule/Makefile
> index 39ff6a93..fffb43ac 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -6,13 +6,12 @@ MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
> -LDLIBS = -lsepol -lselinux -lsemanage
> +override LDLIBS += -lsepol -lselinux -lsemanage
>  SEMODULE_OBJS = semodule.o
>  
>  all: semodule genhomedircon
>  
>  semodule: $(SEMODULE_OBJS)
> -	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>  
>  genhomedircon:
>  	ln -sf semodule genhomedircon
> diff --git a/policycoreutils/sestatus/Makefile
> b/policycoreutils/sestatus/Makefile
> index 8dbbc011..41ca6832 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -7,11 +7,11 @@ LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -D_FILE_OFFSET_BITS=64
> -LDLIBS = -lselinux
> +override LDLIBS += -lselinux
>  
>  all: sestatus
>  
> -sestatus:  sestatus.o 
> +sestatus: sestatus.o
>  
>  install: all
>  	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> @@ -24,7 +24,7 @@ install: all
>  	install -m 644 sestatus.conf $(ETCDIR)
>  
>  clean:
> -	rm -f sestatus *.o 
> +	rm -f sestatus *.o
>  
>  indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/setfiles/Makefile
> b/policycoreutils/setfiles/Makefile
> index 4b8cd815..c08e2dd1 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -8,21 +8,21 @@ AUDITH ?= $(shell test -f /usr/include/libaudit.h
> && echo y)
>  ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c
> | awk -S '{ print $$3 }')
>  
>  CFLAGS ?= -g -Werror -Wall -W
> -LDLIBS = -lselinux -lsepol
> +override LDLIBS += -lselinux -lsepol
>  
>  ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
> -	LDLIBS += -laudit
> +	override LDLIBS += -laudit
>  endif
>  
>  all: setfiles restorecon restorecon_xattr man
>  
> -setfiles:  setfiles.o restore.o
> +setfiles: setfiles.o restore.o
>  
>  restorecon: setfiles
>  	ln -sf setfiles restorecon
>  
> -restorecon_xattr:  restorecon_xattr.o restore.o
> +restorecon_xattr: restorecon_xattr.o restore.o
>  
>  man:
>  	@cp -af setfiles.8 setfiles.8.man
> diff --git a/policycoreutils/setsebool/Makefile
> b/policycoreutils/setsebool/Makefile
> index 32959635..bc254dab 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -7,7 +7,7 @@ LIBDIR ?= $(PREFIX)/lib
>  BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-
> completion/completions
>  
>  CFLAGS ?= -Werror -Wall -W
> -LDLIBS = -lsepol -lselinux -lsemanage
> +override LDLIBS += -lsepol -lselinux -lsemanage
>  SETSEBOOL_OBJS = setsebool.o
>  
>  BASHCOMPLETIONS=setsebool-bash-completion.sh 
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index b1df89f7..ada94aeb 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -29,7 +29,7 @@ else
>  endif
>  export PCRE_CFLAGS PCRE_LDLIBS
>  
> -LDLIBS += -lselinux $(PCRE_LDLIBS) $(DBUSLIB)
> +override LDLIBS += -lselinux $(PCRE_LDLIBS) $(DBUSLIB)
>  
>  all: restorecond
>  
> diff --git a/sandbox/Makefile b/sandbox/Makefile
> index b12fb774..05c3d658 100644
> --- a/sandbox/Makefile
> +++ b/sandbox/Makefile
> @@ -10,7 +10,7 @@ MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= /usr/share/locale
>  SHAREDIR ?= $(PREFIX)/share/sandbox
>  override CFLAGS += -DPACKAGE="\"policycoreutils\"" -Wall -Werror
> -Wextra -W
> -LDLIBS += -lselinux -lcap-ng
> +override LDLIBS += -lselinux -lcap-ng
>  SEUNSHARE_OBJS = seunshare.o
>  
>  all: sandbox seunshare sandboxX.sh start
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 1e36c6e0..1cac53e4 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -4,8 +4,6 @@ MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  
> -LDLIBS = -lsepol
> -
>  SECILC = secilc
>  SECILC_SRCS := secilc.c
>  SECILC_OBJS := $(patsubst %.c,%.o,$(SECILC_SRCS))
> @@ -21,6 +19,7 @@ XMLTO = xmlto
>  CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute
> -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
>  
>  override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> +override LDLIBS += -lsepol
>  
>  all: $(SECILC) $(SECIL2CONF) man
>  
> diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-
> utils/semodule_expand/Makefile
> index 22e3579c..072f2137 100644
> --- a/semodule-utils/semodule_expand/Makefile
> +++ b/semodule-utils/semodule_expand/Makefile
> @@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  
>  CFLAGS ?= -Werror -Wall -W
> -LDLIBS = -lsepol
> +override LDLIBS += -lsepol
>  
>  all: semodule_expand
>  
> diff --git a/semodule-utils/semodule_link/Makefile b/semodule-
> utils/semodule_link/Makefile
> index 1e4e2788..cc4687bd 100644
> --- a/semodule-utils/semodule_link/Makefile
> +++ b/semodule-utils/semodule_link/Makefile
> @@ -6,7 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
> -LDLIBS = -lsepol
> +override LDLIBS += -lsepol
>  
>  all: semodule_link
>  
> diff --git a/semodule-utils/semodule_package/Makefile b/semodule-
> utils/semodule_package/Makefile
> index 5b0d2cc9..96dd7c4f 100644
> --- a/semodule-utils/semodule_package/Makefile
> +++ b/semodule-utils/semodule_package/Makefile
> @@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  
>  CFLAGS ?= -Werror -Wall -W
> -LDLIBS = -lsepol
> +override LDLIBS += -lsepol
>  
>  all: semodule_package semodule_unpackage
>  
