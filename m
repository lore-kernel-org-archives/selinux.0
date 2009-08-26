Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7QFYFrP011930
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 11:34:15 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7QFXfAx002260
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 15:33:41 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n7QFVtvD020008
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 11:31:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n7QFVtVU020006
	for selinux@tycho.nsa.gov; Wed, 26 Aug 2009 11:31:55 -0400
Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7QBNYT6005046
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 07:23:34 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7QBMv8c007163
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 11:22:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Manoj Srivastava <srivasta@debian.org>
Subject: Debian policy package
Date: Wed, 26 Aug 2009 21:23:18 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ssRlKkjphCOw5lu"
Message-Id: <200908262123.24527.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_ssRlKkjphCOw5lu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached my current working patch against the latest unstable policy, 
it's not much but it makes it possible to restart hal.

Where did all those reads of /dev/urandom in unstable come from?  Has some 
sort of randomised stack been enabled in many things?

I think that the code which has a mapping of package names to policy modules 
should be in a separate script (not in the postinst).  Then you could have 
scripts like "find-necessary-policy.default" and "find-necessary-policy.mls" 
that take a list of package names on stdin and output a list of policy 
modules on stdout.  Such scripts could be used for initial configuration of 
the policy and for installing new packages.

apt-get has the ability to list all packages that it would install (including 
dependencies and recommends if it's configured to install them).  We need a 
way to have a single command load SE Linux policy modules first and then have 
apt install the packages later.  NB I don't consider it a problem if the 
policy modules remain installed after apt aborts.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--Boundary-00=_ssRlKkjphCOw5lu
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru refpolicy-0.2.20090730-bak/debian/changelog refpolicy-0.2.20090730/debian/changelog
--- refpolicy-0.2.20090730-bak/debian/changelog	2009-08-26 18:43:26.000000000 +1000
+++ refpolicy-0.2.20090730/debian/changelog	2009-08-26 18:57:41.000000000 +1000
@@ -1,3 +1,12 @@
+refpolicy (2:0.2.20090730-2.1) unstable; urgency=low
+
+  * Build policykit policy and default to loading it when the policykit
+    package is installed.
+  * Default to loading the consolekit module when the consolekit package is
+    installed.
+
+ -- Russell Coker <russell@coker.com.au>  Wed, 26 Aug 2009 18:55:23 +1000
+
 refpolicy (2:0.2.20090730-2) unstable; urgency=low
 
   * Bug fix: "selinux policy violation &quot;Unknown&quot; fo rs2ram
diff -ru refpolicy-0.2.20090730-bak/debian/modules.conf.default refpolicy-0.2.20090730/debian/modules.conf.default
--- refpolicy-0.2.20090730-bak/debian/modules.conf.default	2009-08-26 18:43:26.000000000 +1000
+++ refpolicy-0.2.20090730/debian/modules.conf.default	2009-08-26 18:54:29.000000000 +1000
@@ -1334,6 +1334,14 @@
 pingd = module
 
 # Layer: services
+# Module: policykit
+#
+# PolicyKit is an application-level toolkit for defining and handling the policy
+# that allows unprivileged processes to speak to privileged processes.
+# 
+policykit = module
+
+# Layer: services
 # Module: portmap
 #
 # RPC port mapping service.
diff -ru refpolicy-0.2.20090730-bak/debian/modules.conf.mls refpolicy-0.2.20090730/debian/modules.conf.mls
--- refpolicy-0.2.20090730-bak/debian/modules.conf.mls	2009-08-26 18:43:26.000000000 +1000
+++ refpolicy-0.2.20090730/debian/modules.conf.mls	2009-08-26 18:54:36.000000000 +1000
@@ -1334,6 +1334,14 @@
 pingd = module
 
 # Layer: services
+# Module: policykit
+#
+# PolicyKit is an application-level toolkit for defining and handling the policy
+# that allows unprivileged processes to speak to privileged processes.
+#
+policykit = module
+
+# Layer: services
 # Module: portmap
 #
 # RPC port mapping service.
diff -ru refpolicy-0.2.20090730-bak/debian/postinst.policy refpolicy-0.2.20090730/debian/postinst.policy
--- refpolicy-0.2.20090730-bak/debian/postinst.policy	2009-08-26 18:43:26.000000000 +1000
+++ refpolicy-0.2.20090730/debian/postinst.policy	2009-08-26 18:55:12.000000000 +1000
@@ -75,6 +75,7 @@
            'cdrecord'      => [ 'wodim' ],
            'clamav'        => [ 'clamav' ],
            'courier'       => [ 'courier*' ],
+           'consolekit'    => [ 'consolekit' ],
            'cups'          => [ 'cupsys*' ],
            'cyrus'         => [ 'cyrus*' ],
            'dovecot'       => [ 'dovecot-imapd', 'dovecot-pop3d' ],
@@ -103,6 +104,7 @@
            'nagios'        => [ 'nagios*' ],
            'netutils'      => [ 'arping', 'nmap', '*-ping', 'traceroute*' ],
            'pcmcia'        => [ 'pcmciautils' ],
+           'policykit'     => [ 'policykit' ],
            'pythonsupport' => [ 'python-support' ],
            'radius'        => [ 'freeradius*', 'radiusd*' ],
            'raid'          => [ 'mdadm' ],

--Boundary-00=_ssRlKkjphCOw5lu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
