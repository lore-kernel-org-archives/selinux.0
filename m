Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Thu, 15 Sep 2011 03:49:46 +0200
In-Reply-To: <1316031697.2738.37.camel@localhost>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
	 <1316027881.26965.15.camel@moss-pluto> <1316031697.2738.37.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316051387.23290.16.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric,

please see my patch.

You fix it like this:

diff -pruN selinux/libselinux/src/Makefile selinux-13092011/libselinux/src/Makefile
--- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-13092011/libselinux/src/Makefile	2011-09-13 03:30:08.882910143 +0200
@@ -126,7 +126,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)

and then for the other libraries:

diff -pruN selinux/libsemanage/src/Makefile selinux-13092011/libsemanage/src/Makefile
--- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-13092011/libsemanage/src/Makefile	2011-09-13 03:36:55.724150908 +0200
@@ -139,7 +139,7 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
diff -pruN selinux/libsepol/src/Makefile selinux-13092011/libsepol/src/Makefile
--- selinux/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-13092011/libsepol/src/Makefile	2011-09-13 02:57:31.309865469 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)

You really want stuff in the shared library directory (SHLIBDIR) and not
in the library directory (LIBDIR).

Library directory is for storing auxiliary things such as static files
or modules (which could be shared libraries in turn but are not loaded
the normal way), usually in a separate directory tree.

The shared library directory instead is where all libraries executables
are stored (and sourced from). Usually the shared library directory is
in the search path configured for LD and so a symbolic link is also
desirable in the shared library directory and that link should point
from the unversioned library name to the target executable file itself
which is stored under the versioned library name.

Hope it helps.

Regards,

Guido

On Wed, 2011-09-14 at 16:21 -0400, Eric Paris wrote:
> On Wed, 2011-09-14 at 15:18 -0400, Stephen Smalley wrote:
> > On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> > > At the moment we create a symlink:
> > > 
> > > /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> > > 
> > > This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> > > ../../.  Instead create a symlink from
> > > 
> > > $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> > > 
> > > Thus it works no matter what values one might use for LIBDIR and
> > > SHLIBDIR.
> > 
> > I'm not sure this works the way you would want.  Consider rpm build of
> > libselinux - it does:
> > make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
> > SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install
> > 
> > And then rpm collects up the files into the package.
> > But if the symlink encodes the full pathname used at make install time,
> > then it will be wrong on the final system when the rpm is installed.
> > Haven't actually tested that theory, but I think it is true.  Welcome to
> > hell.
> 
> error: Symlink points to BuildRoot: /usr/lib64/libselinux.so
> -> /root/rpmbuild/BUILDROOT/libselinux-2.1.5-4.fc16.1.eparis.x86_64/lib64/libselinux.so.1
> 
> GRRRRRR.   Every other package I see with similar symlinks seems to be
> an autoconf package and I can't understand how they work.  What we have
> isn't right, but I don't know how to fix it....
> 
> -Eric
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
