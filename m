Subject: Installation of policy source
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-I9biEsWPeTGwfbJT59jn"
Message-Id: <1063388343.30627.9.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 12 Sep 2003 13:39:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-I9biEsWPeTGwfbJT59jn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Steve,

With the quickinstall process gone the policy source no longer gets
installed under /etc by default and the README doesn't mention the
install-src target for the policy Makefile. Since some tools (like our
user management tool seuser) and the policy itself depend upon the
source for current policy being available at a standard location, it is
important for the policy source to get installed. Attached are two
patches that address this. The first adds a note to the README about
installing the source and the second adds the install-src target to the
documentation at the beginning of the policy Makefile.

Thanks,

Karl
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134

--=-I9biEsWPeTGwfbJT59jn
Content-Disposition: attachment; filename=policy-makefile-install-src-9-12-2003.patch
Content-Type: text/x-makefile; name=policy-makefile-install-src-9-12-2003.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- policy/Makefile.orig	2003-09-13 02:03:40.669151576 -0400
+++ policy/Makefile	2003-09-13 01:58:14.168787176 -0400
@@ -4,6 +4,7 @@
 # Targets:
 # 
 # install - compile and install the policy configuration.
+# install-src - install the policy source.
 # load    - compile, install, and load the policy configuration.
 # reload  - compile, install, and load/reload the policy configuration.
 # relabel - relabel filesystems based on the file contexts configuration.

--=-I9biEsWPeTGwfbJT59jn
Content-Disposition: attachment; filename=README-install-src-9-12-2003.patch
Content-Type: text/x-readme; name=README-install-src-9-12-2003.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- README.orig	2003-09-13 01:49:52.489054088 -0400
+++ README	2003-09-13 01:50:50.524231400 -0400
@@ -163,7 +163,9 @@
 
 4) Build and install the policy core utilities.
 
-5) Customize your policy configuration, and then build and install the policy.
+5) Customize your policy configuration, and then build and install the policy
+and the policy source (cd policy; make install; make install-src).
+
 Customization of the policy includes:
 
 a) Edit policy/users for your users.  The policy/users file defines

--=-I9biEsWPeTGwfbJT59jn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
