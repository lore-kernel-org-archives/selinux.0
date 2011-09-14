Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8E1AJqr006099
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2011 21:10:19 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8E1AHeV000533
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2011 01:10:18 GMT
Subject: [PATCH] Change default make target for some directories in the
 libraries (was Re: [PATCH] Change default make target for sepolgen)
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>
Date: Wed, 14 Sep 2011 03:10:16 +0200
In-Reply-To: <1315961064.2218.103.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost> <1315951507.2218.91.camel@vortex>
	 <1315956807.2218.98.camel@vortex> <1315961064.2218.103.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315962616.2218.109.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

And similarly for the "include" and "man" directories available for the
libraries:

Change the default "make" target for the libraries from "install" to
"all" in *all* makefiles.

--- selinux/libselinux/include/Makefile	2011-09-09 20:12:55.981662183 +0200
+++ selinux-13092011-rebuild/libselinux/include/Makefile	2011-09-14 02:48:03.159322088 +0200
@@ -2,6 +2,8 @@
 PREFIX ?= $(DESTDIR)/usr
 INCDIR ?= $(PREFIX)/include/selinux
 
+all:
+
 install:
 	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
 	install -m 644 $(wildcard selinux/*.h) $(INCDIR)
--- selinux/libsepol/include/Makefile	2011-09-09 20:12:56.018662447 +0200
+++ selinux-13092011-rebuild/libsepol/include/Makefile	2011-09-14 02:48:39.183551143 +0200
@@ -2,6 +2,8 @@
 PREFIX ?= $(DESTDIR)/usr
 INCDIR ?= $(PREFIX)/include/sepol
 
+all:
+
 install:
 	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
 	test -d $(INCDIR)/policydb || install -m 755 -d $(INCDIR)/policydb
--- selinux/libsemanage/include/Makefile	2011-09-09 20:12:56.001662322 +0200
+++ selinux-13092011-rebuild/libsemanage/include/Makefile	2011-09-14 02:48:23.919454058 +0200
@@ -2,6 +2,8 @@
 PREFIX ?= $(DESTDIR)/usr
 INCDIR ?= $(PREFIX)/include/semanage
 
+all:
+
 install:
 	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
 	install -m 644 $(wildcard semanage/*.h) $(INCDIR)
--- selinux-13092011-rebuild2/libselinux/man/Makefile	2011-09-14 03:04:28.573741936 +0200
+++ selinux-13092011-rebuild/libselinux/man/Makefile	2011-09-14 02:56:26.626528998 +0200
@@ -4,6 +4,8 @@ MAN3DIR ?= $(PREFIX)/share/man/man3
 MAN5DIR ?= $(PREFIX)/share/man/man5
 MAN8DIR ?= $(PREFIX)/share/man/man8
 
+all:
+
 install:
 	mkdir -p $(MAN3DIR)
 	mkdir -p $(MAN5DIR)
--- selinux-13092011-rebuild2/libsepol/man/Makefile	2011-09-14 03:04:36.648799423 +0200
+++ selinux-13092011-rebuild/libsepol/man/Makefile	2011-09-14 02:57:38.237986215 +0200
@@ -3,6 +3,8 @@ PREFIX ?= $(DESTDIR)/usr
 MAN3DIR ?= $(PREFIX)/share/man/man3
 MAN8DIR ?= $(PREFIX)/share/man/man8
 
+all:
+
 install:
 	mkdir -p $(MAN3DIR)
 	mkdir -p $(MAN8DIR)
--- selinux-13092011-rebuild2/libsemanage/man/Makefile	2011-09-14 03:04:43.361847205 +0200
+++ selinux-13092011-rebuild/libsemanage/man/Makefile	2011-09-14 02:57:24.475898336 +0200
@@ -3,6 +3,8 @@ PREFIX ?= $(DESTDIR)/usr
 MAN3DIR ?= $(PREFIX)/share/man/man3
 MAN5DIR ?= $(PREFIX)/share/man/man5
 
+all:
+
 install:
 	mkdir -p $(MAN3DIR)
 	mkdir -p $(MAN5DIR)

On Wed, 2011-09-14 at 02:44 +0200, Guido Trentalancia wrote:
> And for the reason mentioned earlier (do not install unless explicitly
> required to do so):
> 
> Change the default "make" target for sepolgen from "install" to "all".
> 
> --- selinux/sepolgen/src/sepolgen/Makefile	2011-09-09 20:12:56.080662897 +0200
> +++ selinux-13092011-rebuild/sepolgen/src/sepolgen/Makefile	2011-09-14 02:30:20.172601736 +0200
> @@ -1,7 +1,9 @@
>  PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
>  PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
>  
> -install:
> +all:
> +
> +install: all
>  	-mkdir -p $(PACKAGEDIR)
>  	install -m 644 *.py $(PACKAGEDIR)
>  
> --- selinux/sepolgen/src/share/Makefile	2011-09-09 20:12:56.082662911 +0200
> +++ selinux-13092011-rebuild/sepolgen/src/share/Makefile	2011-09-14 02:36:02.173755672 +0200
> @@ -1,8 +1,10 @@
>  SHAREDIR ?= $(DESTDIR)/var/lib/sepolgen
>  
> -install:
> +all:
> +
> +install: all
>  	-mkdir -p $(SHAREDIR)
>  	install -m 644 perm_map $(SHAREDIR)
>  
>  clean:
> 
> Regards,
> 
> Guido
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
