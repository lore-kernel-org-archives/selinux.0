Message-ID: <45DB0BED.5050205@redhat.com>
Date: Tue, 20 Feb 2007 09:55:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>
Subject: sepolgen fixes.
Content-Type: multipart/mixed;
 boundary="------------050104010700050407000306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050104010700050407000306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    Change to Makefile to get proper python library path even on 64 bit 
platforms.
    Empty or poorly formated interface files cause sepol-ifgen to crash. 


--------------050104010700050407000306
Content-Type: text/x-patch;
 name="policycoreutils-sepolgen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-sepolgen.patch"

diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/Makefile policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/Makefile
--- nsasepolgen/src/sepolgen/Makefile	2007-02-07 12:12:15.000000000 -0500
+++ policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/Makefile	2007-02-15 15:56:05.000000000 -0500
@@ -1,4 +1,4 @@
-PYTHONLIBDIR ?= `python -c "from distutils.sysconfig import *; print get_python_lib()"`
+PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
 
 install:
diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/refparser.py policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/refparser.py
--- nsasepolgen/src/sepolgen/refparser.py	2007-02-07 12:12:15.000000000 -0500
+++ policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/refparser.py	2007-02-15 15:16:09.000000000 -0500
@@ -691,11 +691,13 @@
             output.write(msg)
 
     def parse_file(f, module, spt=None):
-        fd = open(f)
-        txt = fd.read()
-        fd.close()
         try:
+            fd = open(f)
+            txt = fd.read()
+            fd.close()
             parse(txt, module, spt)
+        except IOError, e:
+            return
         except ValueError, e:
             raise ValueError("error parsing file %s: %s" % (f, str(e)))
 

--------------050104010700050407000306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
