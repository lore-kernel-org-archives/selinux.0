Message-ID: <1493123655.12496.5.camel@tycho.nsa.gov>
Subject: Re: [PATCH 7/7] policycoreutils: make audit and pam support
 configurable
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
Date: Tue, 25 Apr 2017 08:34:15 -0400
In-Reply-To: <20170424175959.20998-7-jason@perfinion.com>
References: <20170424175959.20998-1-jason@perfinion.com>
 <20170424175959.20998-7-jason@perfinion.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-25 at 01:59 +0800, Jason Zaman wrote:
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, all seven applied.

> ---
>  policycoreutils/newrole/Makefile  | 10 +++++-----
>  policycoreutils/run_init/Makefile | 10 +++++-----
>  policycoreutils/setfiles/Makefile |  4 ++--
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/policycoreutils/newrole/Makefile
> b/policycoreutils/newrole/Makefile
> index 8bfbd5f..bdefbb8 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -4,8 +4,8 @@ BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  ETCDIR ?= $(DESTDIR)/etc
>  LOCALEDIR = /usr/share/locale
> -PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
> -AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
> +PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
> +AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
>  # Enable capabilities to permit newrole to generate audit records.
>  # This will make newrole a setuid root program.
>  # The capabilities used are: CAP_AUDIT_WRITE.
> @@ -24,7 +24,7 @@ CFLAGS ?= -Werror -Wall -W
>  EXTRA_OBJS =
>  override CFLAGS += -DVERSION=\"$(VERSION)\" -DUSE_NLS
> -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
>  LDLIBS += -lselinux
> -ifeq ($(PAMH), /usr/include/security/pam_appl.h)
> +ifeq ($(PAMH), y)
>  	override CFLAGS += -DUSE_PAM
>  	EXTRA_OBJS += hashtab.o
>  	LDLIBS += -lpam -lpam_misc
> @@ -32,7 +32,7 @@ else
>  	override CFLAGS += -D_XOPEN_SOURCE=500
>  	LDLIBS += -lcrypt
>  endif
> -ifeq ($(AUDITH), /usr/include/libaudit.h)
> +ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
>  	LDLIBS += -laudit
>  endif
> @@ -66,7 +66,7 @@ install: all
>  	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
>  	install -m $(MODE) newrole $(BINDIR)
>  	install -m 644 newrole.1 $(MANDIR)/man1/
> -ifeq ($(PAMH), /usr/include/security/pam_appl.h)
> +ifeq ($(PAMH), y)
>  	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
>  ifeq ($(LSPP_PRIV),y)
>  	install -m 644 newrole-lspp.pamd $(ETCDIR)/pam.d/newrole
> diff --git a/policycoreutils/run_init/Makefile
> b/policycoreutils/run_init/Makefile
> index a3beef7..6f5ee13 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -5,20 +5,20 @@ SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
>  ETCDIR ?= $(DESTDIR)/etc
>  LOCALEDIR ?= /usr/share/locale
> -PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
> -AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
> +PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
> +AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\""
> -DPACKAGE="\"policycoreutils\""
>  LDLIBS += -lselinux
> -ifeq ($(PAMH), /usr/include/security/pam_appl.h)
> +ifeq ($(PAMH), y)
>  	override CFLAGS += -DUSE_PAM
>  	LDLIBS += -lpam -lpam_misc
>  else
>  	override CFLAGS += -D_XOPEN_SOURCE=500
>  	LDLIBS += -lcrypt
>  endif
> -ifeq ($(AUDITH), /usr/include/libaudit.h)
> +ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
>  	LDLIBS += -laudit
>  endif
> @@ -38,7 +38,7 @@ install: all
>  	install -m 755 open_init_pty $(SBINDIR)
>  	install -m 644 run_init.8 $(MANDIR)/man8/
>  	install -m 644 open_init_pty.8 $(MANDIR)/man8/
> -ifeq ($(PAMH), /usr/include/security/pam_appl.h)
> +ifeq ($(PAMH), y)
>  	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
>  endif
>  
> diff --git a/policycoreutils/setfiles/Makefile
> b/policycoreutils/setfiles/Makefile
> index f7089f9..4b8cd81 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -3,14 +3,14 @@ PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(DESTDIR)/sbin
>  MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> -AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
> +AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
>  
>  ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c
> | awk -S '{ print $$3 }')
>  
>  CFLAGS ?= -g -Werror -Wall -W
>  LDLIBS = -lselinux -lsepol
>  
> -ifeq ($(AUDITH), /usr/include/libaudit.h)
> +ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
>  	LDLIBS += -laudit
>  endif
