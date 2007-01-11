Message-ID: <45A64526.2050701@redhat.com>
Date: Thu, 11 Jan 2007 09:09:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: translation patch for semanage
Content-Type: multipart/mixed;
 boundary="------------060605080804040109060104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060605080804040109060104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch works around a unicode problem in python.

--------------060605080804040109060104
Content-Type: text/x-patch;
 name="policycoreuitls-semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreuitls-semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-1.33.10/semanage/semanage	2007-01-09 11:55:52.000000000 -0500
@@ -23,12 +23,21 @@
 import os, sys, getopt
 import seobject
 import selinux
+PROGNAME="policycoreutils"
+
 import gettext
+gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
+gettext.textdomain(PROGNAME)
+import codecs
+import locale
+sys.stderr = codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__, 'replace')
+sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
 
 try:
-       gettext.install('policycoreutils')
-except:
-       pass
+       gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
+except IOError:
+       import __builtin__
+       __builtin__.__dict__['_'] = unicode
 
 is_mls_enabled=selinux.is_selinux_mls_enabled()
 

--------------060605080804040109060104--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
