Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUpHd029539
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7949461BA5
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:49 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/19] policycoreutils/sepolicy: Add documentation for MCS
 separated domains
Date: Wed,  3 May 2017 12:30:18 +0200
Message-Id: <20170503103036.17514-2-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 1af4295c..3ebdfeb7 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -504,6 +504,7 @@ class ManPage:
             self._booleans()
 
         self._port_types()
+        self._mcs_types()
         self._writes()
         self._footer()
 
@@ -527,6 +528,7 @@ class ManPage:
         self._header()
         self._entrypoints()
         self._process_types()
+        self._mcs_types()
         self._booleans()
         self._nsswitch_domain()
         self._port_types()
@@ -923,6 +925,17 @@ All executeables with the default executable label, usually stored in /usr/bin a
         self.fd.write("""
 %s""" % ", ".join(paths))
 
+    def _mcs_types(self):
+        attributes = sepolicy.info(sepolicy.TYPE, (self.type))[0]["attributes"]
+        if "mcs_constrained_type" not in attributes:
+            return
+        self.fd.write ("""
+.SH "MCS Constrained"
+The SELinux process type %(type)s_t is an MCS (Multi Category Security) constrained type.  Sometimes this separation is referred to as sVirt. These types are usually used for securing multi-tenant environments, such as virtualization, containers or separation of users.  The tools used to launch MCS types, pick out a different MCS label for each process group.
+
+For example one process might be launched with %(type)s_t:s0:c1,c2, and another process launched with %(type)s_t:s0:c3,c4. The SELinux kernel only allows these processes can only write to content with a matching MCS label, or a MCS Label of s0. A process running with the MCS level of s0:c1,c2 is not allowed to write to content with the MCS label of s0:c3,c4
+""" % {'type': self.domainname})
+
     def _writes(self):
         permlist = sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['open', 'write'], 'class': 'file'})
         if permlist is None or len(permlist) == 0:
-- 
2.12.2
