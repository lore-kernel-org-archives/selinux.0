Subject: Re: Patch for libselinux to build correctly on Sparc.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46F7DDBA.3010600@redhat.com>
References: <46F7DDBA.3010600@redhat.com>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 12:28:13 -0400
Message-Id: <1190651293.487.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-09-24 at 11:54 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=199367
> 
> sparc64 needs to use CFLAGS with CC to link properly using gcc the
> attached patch fixes this issue
> 
> Patch submitted originally by Dennis Gilmore.
> 
> Further info from bugzilla.
> 
> 
> (In reply to comment #7)
> > It's ok by me, although I'm wondering what CFLAGS you are supplying
> that matter
> > here.
> 
> For multilib support, sparc needs libselinux (and libsepol) to be built
> as sparc
> (32bit) and sparc64 (64bit). sparc builds fine (-m32 is assumed by the
> compiler), but when building for sparc64, we need all compile and link
> operations to have -m64 passed for it, or else gcc will mismatch (it
> will make
> sparc64 object files, then try to link them as a 32bit library) and the
> build fails.
> 
> The easiest way to ensure safe and consistent builds is to universally apply
> CFLAGS whenever calling CC, which is what this patch does.

Thanks, also applied patch below to do the same for libsepol and
libsemanage.

Index: libsemanage/src/Makefile
===================================================================
--- libsemanage/src/Makefile	(revision 2575)
+++ libsemanage/src/Makefile	(working copy)
@@ -47,14 +47,14 @@
 	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -l$(PYLIBVER) -L$(LIBDIR) -Wl,-soname,$@,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -l$(PYLIBVER) -L$(LIBDIR) -Wl,-soname,$@,-z,defs
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	ranlib $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 conf-scan.c: conf-scan.l conf-parse.h
Index: libsepol/src/Makefile
===================================================================
--- libsepol/src/Makefile	(revision 2575)
+++ libsepol/src/Makefile	(working copy)
@@ -20,7 +20,7 @@
 	ranlib $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),--version-script=libsepol.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),--version-script=libsepol.map,-z,defs
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
