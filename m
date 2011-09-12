Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8CKHDBJ016394
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 16:17:14 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8CKHBqY016269
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 20:17:12 GMT
Subject: Re: [RFC] Improve installation of userspace shared libraries (was
 Re: [RFC] Userspace top-level Makefile)
From: Guido Trentalancia <guido@trentalancia.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Mon, 12 Sep 2011 22:17:00 +0200
In-Reply-To: <4E6DFDE5.2070709@manicmethod.com>
References: <1315587716.2170.16.camel@vortex>
		    <1315588656.2170.26.camel@vortex>
		    <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
		    <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
		   <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>
		  <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com>
		 <1315609967.2482.39.camel@vortex> <4E6A9E26.9080806@redhat.com>
		 <4E6D429A.7060403@manicmethod.com> <1315793570.2209.22.camel@vortex>
	 <4E6DFDE5.2070709@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315858620.2223.13.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Joshua,

thanks very much for your comments !

On Mon, 2011-09-12 at 08:41 -0400, Joshua Brindle wrote:
> Guido Trentalancia wrote:
> > On Sun, 2011-09-11 at 19:22 -0400, Joshua Brindle wrote:
> >> Eric Paris wrote:
> >>> On 09/09/2011 07:12 PM, Guido Trentalancia wrote:
> <snip>>>
> >> gcc doesn't care and I swear we use to have ../ directories in the
> >> include path, not sure what happened to those :X
> >
> > Honestly, I don't know, I can't remember. From reading a bit of git log,
> > perhaps I can speculate it wasn't there, but what I am hitting is also
> > cross-dependencies between the objects in the library directories (so
> > for example libsepol symbols being required by objects in the libselinux
> > directory).
> >
> 
> Probably pre-git
> 
> > @@ -126,7 +126,7 @@ install: all
> >   	install -m 755 $(LIBSO) $(SHLIBDIR)
> >   	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
> >   	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> > -	cd $(LIBDIR)&&  ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> > +	cd $(LIBDIR)&&  ln -sf $(LIBSO) $(TARGET)
> >
> >   install-pywrap: pywrap
> >   	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
> 
> What is the purpose of this? It definitely doesn't seem right to me :\

In the first place it was to be coherent with what is being done by
libsemanage. However, it is not entirely correct, as LIBDIR should be
replaced by SHLIBDIR.

Note that apparently libsepol needs to be installed in /lib instead of
$PREFIX/lib (and there is an evident mismatch between the default values
for LIBDIR and SHLIBDIR compared to the other two cases).

diff -pru selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libselinux/src/Makefile selinux-12092011-test/libselinux/src/Makefile
--- selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libselinux/src/Makefile	2011-09-12 03:05:45.349163662 +0200
+++ selinux-12092011-test/libselinux/src/Makefile	2011-09-12 21:54:51.527394433 +0200
@@ -126,7 +126,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
diff -pru selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsemanage/src/Makefile selinux-12092011-test/libsemanage/src/Makefile
--- selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsemanage/src/Makefile	2011-09-12 03:05:45.350163708 +0200
+++ selinux-12092011-test/libsemanage/src/Makefile	2011-09-12 21:54:20.618245062 +0200
@@ -139,7 +139,7 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
diff -pru selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsepol/src/Makefile selinux-12092011-test/libsepol/src/Makefile
--- selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsepol/src/Makefile	2011-09-12 03:05:45.351163751 +0200
+++ selinux-12092011-test/libsepol/src/Makefile	2011-09-12 21:53:56.414127000 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)

Or otherwise, with respect to actual git, it should look like (also
modifies include and link directories):

--- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-12092011-test/libselinux/src/Makefile	2011-09-12 21:54:51.527394433 +0200
@@ -54,7 +54,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENE
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
+override CFLAGS += -I../include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
@@ -102,7 +102,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
@@ -126,7 +126,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
--- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-12092011-test/libsemanage/src/Makefile	2011-09-12 21:54:20.618245062 +0200
@@ -55,7 +55,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-s
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -I../../libselinux/include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 RANLIB=ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
@@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR) -lbz2 -lustr -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in
@@ -139,7 +139,7 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
--- selinux/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-12092011-test/libsepol/src/Makefile	2011-09-12 21:53:56.414127000 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)

Is there anything else that looks odd in it ? Partial description could
be something like this:

Simply use the filename as the target instead of the full path to the
shared libraries when creating the links in SHLIBDIR during
installation.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
