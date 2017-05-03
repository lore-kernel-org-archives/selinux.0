Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfI029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7D308124A
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:51 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/19] sepolicy: Add manpages for typealiased types
Date: Wed,  3 May 2017 12:30:20 +0200
Message-Id: <20170503103036.17514-4-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index bd5a64ac..b268680a 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -30,6 +30,13 @@ import sepolicy
 import os
 import time
 
+typealias_types = {
+"antivirus_t":("amavis_t", "clamd_t", "clamscan_t", "freshclam_t"),
+"cluster_t":("rgmanager_t", "corosync_t", "aisexec_t", "pacemaker_t"),
+"svirt_t":("qemu_t"),
+"httpd_t":("phpfpm_t"),
+}
+
 equiv_dict = {"smbd": ["samba"], "httpd": ["apache"], "virtd": ["virt", "libvirt", "svirt", "svirt_tcg", "svirt_lxc_t", "svirt_lxc_net_t"], "named": ["bind"], "fsdaemon": ["smartmon"], "mdadm": ["raid"]}
 
 equiv_dirs = ["/var"]
@@ -523,6 +530,16 @@ class ManPage:
         self._get_ptypes()
 
         for domain_type in self.ptypes:
+            try:
+                if typealias_types[domain_type]:
+                    fd = self.fd
+                    man_page_path =  self.man_page_path
+                    for t in typealias_types[domain_type]:
+                        self._typealias_gen_man(t)
+                    self.fd = fd
+                    self.man_page_path = man_page_path
+            except KeyError:
+                continue;
             self.attributes[domain_type] = sepolicy.info(sepolicy.TYPE, ("%s") % domain_type)[0]["attributes"]
 
         self._header()
@@ -542,6 +559,34 @@ class ManPage:
             if f.startswith(self.short_name) or f.startswith(self.domainname):
                 self.ptypes.append(f)
 
+    def _typealias_gen_man(self, t):
+        self.man_page_path = "%s/%s_selinux.8" % (self.path, t[:-2])
+        self.ports = []
+        self.booltext = ""
+        self.fd = open(self.man_page_path, 'w')
+        self._typealias(t[:-2])
+        self._footer()
+        self.fd.close()
+
+    def _typealias(self,typealias):
+        self.fd.write('.TH  "%(typealias)s_selinux"  "8"  "%(date)s" "%(typealias)s" "SELinux Policy %(typealias)s"'
+                 % {'typealias':typealias, 'date': time.strftime("%y-%m-%d")})
+        self.fd.write(r"""
+.SH "NAME"
+%(typealias)s_selinux \- Security Enhanced Linux Policy for the %(typealias)s processes
+.SH "DESCRIPTION"
+
+%(typealias)s_t SELinux domain type is now associated with %(domainname)s domain type (%(domainname)s_t). 
+""" % {'typealias':typealias, 'domainname':self.domainname})
+
+        self.fd.write(r"""
+Please see 
+
+.B %(domainname)s_selinux 
+
+man page for more details.
+"""  % {'domainname':self.domainname})
+
     def _header(self):
         self.fd.write('.TH  "%(domainname)s_selinux"  "8"  "%(date)s" "%(domainname)s" "SELinux Policy %(domainname)s"'
                       % {'domainname': self.domainname, 'date': time.strftime("%y-%m-%d")})
-- 
2.12.2
