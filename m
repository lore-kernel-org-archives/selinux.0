Message-ID: <46F7DDBA.3010600@redhat.com>
Date: Mon, 24 Sep 2007 11:54:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch for libselinux to build correctly on Sparc.
Content-Type: multipart/mixed;
 boundary="------------050404000205010307020709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050404000205010307020709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

https://bugzilla.redhat.com/show_bug.cgi?id=199367

sparc64 needs to use CFLAGS with CC to link properly using gcc the
attached patch fixes this issue

Patch submitted originally by Dennis Gilmore.

Further info from bugzilla.


(In reply to comment #7)
> It's ok by me, although I'm wondering what CFLAGS you are supplying
that matter
> here.

For multilib support, sparc needs libselinux (and libsepol) to be built
as sparc
(32bit) and sparc64 (64bit). sparc builds fine (-m32 is assumed by the
compiler), but when building for sparc64, we need all compile and link
operations to have -m64 passed for it, or else gcc will mismatch (it
will make
sparc64 object files, then try to link them as a 32bit library) and the
build fails.

The easiest way to ensure safe and consistent builds is to universally apply
CFLAGS whenever calling CC, which is what this patch does.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG9926rlYvE4MpobMRAuguAKDBxJbz4hV3khmgHFYRiPYCuSS8qACeJUJv
99nyoIM2VK6cbzR/9xlNHwA=
=htQu
-----END PGP SIGNATURE-----

--------------050404000205010307020709
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-2.0.34/src/Makefile
--- nsalibselinux/src/Makefile	2007-08-03 16:02:56.000000000 -0400
+++ libselinux-2.0.34/src/Makefile	2007-09-24 11:51:42.000000000 -0400
@@ -57,10 +57,10 @@
 	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h

--------------050404000205010307020709
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG9926rlYvE4MpobMRAsa1AKDGgkytDyBpGj5O5SrQr9QPqxa6twCghpc+4ZGEpkyN
kvhYSE632BZgAwY=
--------------050404000205010307020709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
