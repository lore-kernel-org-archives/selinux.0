Subject: Re: [PATCH] libselinux: fix PREFIX argument to Makefiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <46B11168.5090309@tycho.nsa.gov>
References: <46B11168.5090309@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 08:06:22 -0400
Message-Id: <1186056382.26901.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 19:04 -0400, Eamon Walsh wrote:
> This makes the PREFIX argument to the library Makefiles actually
> work for installing to e.g. /usr/local.
> 
> It would be a lot cleaner if the default destination for the .so
> file was /usr/lib instead of /lib.  This special case makes the
> conditionals necessary.
>  
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>  libselinux/man/Makefile  |    7 ++++---
>  libselinux/src/Makefile  |    8 ++++++++
>  libsemanage/man/Makefile |    3 ++-
>  libsemanage/src/Makefile |    8 ++++++++
>  libsepol/man/Makefile    |    5 +++--
>  libsepol/src/Makefile    |    8 ++++++++
>  6 files changed, 33 insertions(+), 6 deletions(-)
> 
> 
> Index: libsemanage/src/Makefile
> ===================================================================
> --- libsemanage/src/Makefile    (revision 2506)
> +++ libsemanage/src/Makefile    (working copy)
> @@ -1,7 +1,11 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> +ifeq ($(PREFIX),$(DESTDIR)/usr)
>  SHLIBDIR ?= $(DESTDIR)/lib
> +else
> +SHLIBDIR ?= $(LIBDIR)
> +endif

NAK.  That's too ugly to live.

>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % 
> sys.version_info[0:2]')
>  PYINC ?= /usr/include/${PYLIBVER}
> @@ -83,7 +87,11 @@
>      test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
>      install -m 755 $(LIBSO) $(SHLIBDIR)
>      test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D 
> semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
> +ifeq ($(PREFIX),$(DESTDIR)/usr)
>      cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> +else
> +    cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> +endif
>  
>  install-pywrap: pywrap
>      test -d $(PYLIBDIR)/site-packages || install -m 755 -d 
> $(PYLIBDIR)/site-packages
> Index: libsemanage/man/Makefile
> ===================================================================
> --- libsemanage/man/Makefile    (revision 2506)
> +++ libsemanage/man/Makefile    (working copy)
> @@ -1,5 +1,6 @@
>  # Installation directories.
> -MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
> +PREFIX ?= $(DESTDIR)/usr
> +MAN3DIR ?= $(PREFIX)/share/man/man3
>  
>  install:
>      mkdir -p $(MAN3DIR)
> Index: libsepol/src/Makefile
> ===================================================================
> --- libsepol/src/Makefile    (revision 2506)
> +++ libsepol/src/Makefile    (working copy)
> @@ -1,7 +1,11 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> +ifeq ($(PREFIX),$(DESTDIR)/usr)
>  SHLIBDIR ?= $(DESTDIR)/lib
> +else
> +SHLIBDIR ?= $(LIBDIR)
> +endif
>  
>  LIBVERSION = 1
>  
> @@ -34,7 +38,11 @@
>      install -m 644 $(LIBA) $(LIBDIR)
>      test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
>      install -m 755 $(LIBSO) $(SHLIBDIR)
> +ifeq ($(PREFIX),$(DESTDIR)/usr)
>      cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> +else
> +    cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> +endif
>  
>  relabel:
>      /sbin/restorecon $(SHLIBDIR)/$(LIBSO)
> Index: libsepol/man/Makefile
> ===================================================================
> --- libsepol/man/Makefile    (revision 2506)
> +++ libsepol/man/Makefile    (working copy)
> @@ -1,6 +1,7 @@
>  # Installation directories.
> -MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
> -MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
> +PREFIX ?= $(DESTDIR)/usr
> +MAN8DIR ?= $(PREFIX)/share/man/man8
> +MAN3DIR ?= $(PREFIX)/share/man/man3
>  
>  install:
>      mkdir -p $(MAN3DIR)
> Index: libselinux/src/Makefile
> ===================================================================
> --- libselinux/src/Makefile    (revision 2506)
> +++ libselinux/src/Makefile    (working copy)
> @@ -1,7 +1,11 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> +ifeq ($(PREFIX),$(DESTDIR)/usr)
>  SHLIBDIR ?= $(DESTDIR)/lib
> +else
> +SHLIBDIR ?= $(LIBDIR)
> +endif
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % 
> sys.version_info[0:2]')
>  PYINC ?= /usr/include/$(PYLIBVER)
> @@ -80,7 +84,11 @@
>      install -m 644 $(LIBA) $(LIBDIR)
>      test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
>      install -m 755 $(LIBSO) $(SHLIBDIR)
> +ifeq ($(PREFIX),$(DESTDIR)/usr)
>      cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> +else
> +    cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> +endif
>  
>  install-pywrap: pywrap
>      test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d 
> $(PYTHONLIBDIR)/site-packages
> Index: libselinux/man/Makefile
> ===================================================================
> --- libselinux/man/Makefile    (revision 2506)
> +++ libselinux/man/Makefile    (working copy)
> @@ -1,7 +1,8 @@
>  # Installation directories.
> -MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
> -MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
> -MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
> +PREFIX ?= $(DESTDIR)/usr
> +MAN8DIR ?= $(PREFIX)/share/man/man8
> +MAN5DIR ?= $(PREFIX)/share/man/man5
> +MAN3DIR ?= $(PREFIX)/share/man/man3
>  
>  install:
>      mkdir -p $(MAN3DIR)
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
