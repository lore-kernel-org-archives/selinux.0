Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o46FvSBZ013316
	for <selinux@tycho.nsa.gov>; Thu, 6 May 2010 11:57:28 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o46Fupse007725
	for <selinux@tycho.nsa.gov>; Thu, 6 May 2010 15:56:52 GMT
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o46FvQbI019856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 6 May 2010 11:57:26 -0400
Message-ID: <4BE2E6E4.90400@redhat.com>
Date: Thu, 06 May 2010 11:57:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: David Malcolm <dmalcolm@redhat.com>
Subject: libsemanage python3 support.
Content-Type: multipart/mixed;
 boundary="------------000701070607060304040801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000701070607060304040801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Malcolm has been working on adding python3 support to libsemanage
(and libselinux).

Change to Makefile to:

# Support building the Python bindings multiple times, against various
Python
# runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
# targets with "PYPREFIX":

Should build python2 version by default, without the user doing any changes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvi5uQACgkQrlYvE4MpobPT4gCfZjtxs171+6HsQNx/cDZTMWp9
VzYAn03cycetc+M3MnJMzAz88zyAYK/I
=JxHy
-----END PGP SIGNATURE-----

--------------000701070607060304040801
Content-Type: text/plain;
 name="libsemanage-python3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-python3.patch"

diff --git a/src/Makefile b/src/Makefile
index 7acf63d..cdd8388 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,9 +1,15 @@
+# Support building the Python bindings multiple times, against various Python
+# runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
+# targets with "PYPREFIX":
+PYTHON ?= python
+PYPREFIX ?= 
+
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
-PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
+PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYINC ?= /usr/include/${PYLIBVER}
 PYLIBDIR ?= $(LIBDIR)/${PYLIBVER}
 RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
@@ -34,9 +40,9 @@ SWIGIF= semanageswig_python.i
 SWIGRUBYIF= semanageswig_ruby.i
 SWIGCOUT= semanageswig_wrap.c
 SWIGRUBYCOUT= semanageswig_ruby_wrap.c
-SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
+SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT)) 
 SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
-SWIGSO=_semanage.so
+SWIGSO=$(PYPREFIX)_semanage.so
 SWIGFILES=$(SWIGSO) semanage.py 
 SWIGRUBYSO=_rubysemanage.so
 LIBSO=$(TARGET).$(LIBVERSION)
@@ -132,7 +138,9 @@ install: all
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
-	install -m 755 $(SWIGFILES) $(PYLIBDIR)/site-packages
+	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/_semanage.so
+	install -m 755 semanage.py $(PYLIBDIR)/site-packages
+
 
 install-rubywrap: rubywrap
 	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 

--------------000701070607060304040801
Content-Type: application/pgp-signature;
 name="libsemanage-python3.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-python3.patch.sig"

iEYEABECAAYFAkvi5uQACgkQrlYvE4MpobMGcACglAvuiHE7VVTsmA7EqH1aW41eqvMAoN3T
b67BOP7O9iu3ZSKlJbKiajfe
--------------000701070607060304040801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
