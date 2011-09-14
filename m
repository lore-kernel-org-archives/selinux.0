Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8E0iP84004747
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2011 20:44:26 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8E0iOeV027907
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2011 00:44:24 GMT
Subject: [PATCH] Change default make target for sepolgen (was Re: [PATCH v4]
 Fix includes for userspace tools and libraries)
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>
Date: Wed, 14 Sep 2011 02:44:23 +0200
In-Reply-To: <1315956807.2218.98.camel@vortex>
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
	 <1315956807.2218.98.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315961064.2218.103.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

And for the reason mentioned earlier (do not install unless explicitly
required to do so):

Change the default "make" target for sepolgen from "install" to "all".

--- selinux/sepolgen/src/sepolgen/Makefile	2011-09-09 20:12:56.080662897 +0200
+++ selinux-13092011-rebuild/sepolgen/src/sepolgen/Makefile	2011-09-14 02:30:20.172601736 +0200
@@ -1,7 +1,9 @@
 PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
 
-install:
+all:
+
+install: all
 	-mkdir -p $(PACKAGEDIR)
 	install -m 644 *.py $(PACKAGEDIR)
 
--- selinux/sepolgen/src/share/Makefile	2011-09-09 20:12:56.082662911 +0200
+++ selinux-13092011-rebuild/sepolgen/src/share/Makefile	2011-09-14 02:36:02.173755672 +0200
@@ -1,8 +1,10 @@
 SHAREDIR ?= $(DESTDIR)/var/lib/sepolgen
 
-install:
+all:
+
+install: all
 	-mkdir -p $(SHAREDIR)
 	install -m 644 perm_map $(SHAREDIR)
 
 clean:

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
