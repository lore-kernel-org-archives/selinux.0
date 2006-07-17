Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HJVuH7028218
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 15:31:56 -0400
Received: from ppsw-7.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6HJVt53016700
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 19:31:55 GMT
Date: Mon, 17 Jul 2006 20:40:49 +0100
From: Stephen Bennett <spb@gentoo.org>
To: Stephen Bennett <spb@gentoo.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: semanage and RHPL
Message-ID: <20060717204049.2d6eae10@localhost>
In-Reply-To: <20060712210909.575163ad@localhost>
References: <20060712210909.575163ad@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_UP=TNKF6Y0dTMLdgK3fvd3g"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--MP_UP=TNKF6Y0dTMLdgK3fvd3g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Having investigated this some more and discussed it on IRC, it seems
that rhpl is only being used for one function (_), which it seems can
be replaced by Python's standard gettext interface. A patch to do this
is attached, tested with LC_* both unset and set to en_GB. semanage and
genhomedircon are known to work in these situations; the changes to the
other scripts are identical so they ought to work as well. Please
comment.

On Wed, 12 Jul 2006 21:09:09 +0100
Stephen Bennett <spb@gentoo.org> wrote:

> Hi,
> 
> After encountering some problems with modular policy in the released
> toolchain packages, it was suggested to me that I try the svn
> toolchain. I did this, and found that semanage and genhomedircon both
> traceback when run, failing to import functions from rhpl.translate.
> This package doesn't appear to be available in Gentoo's repository,
> and a quick bit of searching suggests that it's a Red Hat-specific
> library. Is this dependency intentional or desirable? If yes, where
> can we get the sources to package it for other distros?
> 
> Thanks in advance for any input.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.
> 

--MP_UP=TNKF6Y0dTMLdgK3fvd3g
Content-Type: text/x-patch; name=policycoreutils-gettext.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=policycoreutils-gettext.diff

Index: policycoreutils/semanage/semanage
===================================================================
--- policycoreutils/semanage/semanage   (revision 33)
+++ policycoreutils/semanage/semanage   (working copy)
@@ -23,8 +23,13 @@
 import os, sys, getopt
 import seobject
 import selinux
-from rhpl.translate import _, N_
+import gettext

+try:
+       gettext.install('policycoreutils')
+except:
+       pass
+
 is_mls_enabled=selinux.is_selinux_mls_enabled()

 if __name__ == '__main__':
Index: policycoreutils/semanage/seobject.py
===================================================================
--- policycoreutils/semanage/seobject.py        (revision 33)
+++ policycoreutils/semanage/seobject.py        (working copy)
@@ -23,8 +23,14 @@

 import pwd, string, selinux, tempfile, os, re, sys
 from semanage import *;
-from rhpl.translate import _, N_
+import gettext

+try:
+       t = gettext.translation('policycoreutils', '/usr/share/locale')
+       _ = t.ugettext
+except:
+       pass
+
 is_mls_enabled = selinux.is_selinux_mls_enabled()

 import syslog
Index: policycoreutils/audit2allow/audit2allow
===================================================================
--- policycoreutils/audit2allow/audit2allow     (revision 33)
+++ policycoreutils/audit2allow/audit2allow     (working copy)
@@ -27,8 +27,12 @@
 from avc import *

 if __name__ == '__main__':
-       from rhpl.translate import _, N_
        import commands, sys, os, getopt, selinux
+       import gettext
+       try:
+               gettext.install('policycoreutils')
+       except:
+               pass
        def get_mls_flag():
                if selinux.is_selinux_mls_enabled():
                        return "-M"
Index: policycoreutils/scripts/genhomedircon
===================================================================
--- policycoreutils/scripts/genhomedircon       (revision 33)
+++ policycoreutils/scripts/genhomedircon       (working copy)
@@ -26,7 +26,8 @@

 import sys, os, pwd, string, getopt, re
 from semanage import *;
-from rhpl.translate import _, N_
+import gettext
+gettext.install('policycoreutils')

 try:
        fd = open("/etc/shells", 'r')
Index: policycoreutils/scripts/chcat
===================================================================
--- policycoreutils/scripts/chcat       (revision 33)
+++ policycoreutils/scripts/chcat       (working copy)
@@ -24,8 +24,13 @@
 #
 import commands, sys, os, pwd, string, getopt, selinux
 import seobject
-from rhpl.translate import _, N_
+import gettext

+try:
+    gettext.install('policycoreutils')
+except:
+    pass
+
 def verify_users(users):
     for u in users:
         try:

--MP_UP=TNKF6Y0dTMLdgK3fvd3g--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
