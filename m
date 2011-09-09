Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89NjQob011175
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 19:45:27 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89NjPvK029750
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 23:45:25 GMT
Subject: Re: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Eric Paris
 <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Sat, 10 Sep 2011 01:45:16 +0200
In-Reply-To: <1315610720.2482.42.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
	 <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>
	 <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com>
	 <1315609967.2482.39.camel@vortex> <4E6A9E26.9080806@redhat.com>
	 <1315610720.2482.42.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315611916.2482.44.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2011-09-10 at 01:25 +0200, Guido Trentalancia wrote:
> On Fri, 2011-09-09 at 19:15 -0400, Eric Paris wrote:
> > > But why should libsepol/include be missing from git in the first
> > > place ??
> > 
> > I agree that they must be in one or the other for it to build.  A number
> > of distros build these packages separately, rather than all at once.
> > Thus there would be no ../libsepol/include directory at all, but the
> > headers should be picked up by -I$(INCLUDEDIR).  As long as gcc doesn't
> > care that the directory doesn't exist, I actually like it.
> > 
> > -Eric
> 
> gcc should only care that at least one version of the file can be found
> if #include'd.
> 
> It still needs to be tested though. Can you try building the whole
> userspace git using that patch ?

I have just tested it again and I am still missing the following bit:

--- selinux-09092011-orig2/policycoreutils/semodule/Makefile	2011-09-10 01:40:34.249189544 +0200
+++ selinux-09092011-local-headers/policycoreutils/semodule/Makefile	2011-09-10 01:36:48.420940938 +0200
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I../../libsemanage/include -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -L../../libselinux/src -L../../libsepol/src -L../../libsemanage/src -lsepol -lselinux -lsemanage
 SEMODULE_OBJS = semodule.o
 
 all: semodule
--- selinux-09092011-orig2/policycoreutils/setsebool/Makefile	2011-09-10 01:40:34.252189479 +0200
+++ selinux-09092011-local-headers/policycoreutils/setsebool/Makefile	2011-09-10 01:37:39.281235631 +0200
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I../../libselinux/include -I../../libsemanage/include -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -L../../libselinux/src -L../../libsepol/src -L../../libsemanage/src -lsepol -lselinux -lsemanage
 SETSEBOOL_OBJS = setsebool.o
 
 all: setsebool

> Regards,
> 
> Guido



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
