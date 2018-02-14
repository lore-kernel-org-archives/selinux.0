Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1E9rqY7011953
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 04:53:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 3zhF9B5vV6z2NjRV
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:50 +0000 (UTC)
Received: from UPDC3CPA12_EEMSG_MP28.eemsg.mil (unknown [192.168.18.23])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 3zhF9B5D4Gz2NjRT
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:50 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C011EEAEB1
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:47 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 10:53:34 +0100
Message-Id: <20180214095337.1945-2-plautrba@redhat.com>
In-Reply-To: <20180214095337.1945-1-plautrba@redhat.com>
References: <20180214095337.1945-1-plautrba@redhat.com>
Subject: [PATCH 1/4] gui/polgengui.py: Fix sepolicy.generate import
 in polgengui.py
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

b43991f9 added direct import of sepolicy but it forgot to import
sepolicy.generate and didn't change use of generate to sepolicy.generate

Fixes:

Traceback (most recent call last):
  File "/usr/bin/selinux-polgengui", line 778, in <module>
    app = childWindow()
  File "/usr/bin/selinux-polgengui", line 205, in __init__
    self.all_types = sepolicy.generate.get_all_types()
AttributeError: 'module' object has no attribute 'generate'

Traceback (most recent call last):
  File "/usr/share/system-config-selinux/polgengui.py", line 365, in forward
    if self.on_in_net_page_next():
  File "/usr/share/system-config-selinux/polgengui.py", line 701, in on_in_net_page_next
    generate.verify_ports(self.in_tcp_entry.get_text())
NameError: global name 'generate' is not defined

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 gui/polgengui.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/gui/polgengui.py b/gui/polgengui.py
index af6b822b..09723278 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -34,7 +34,9 @@ except ValueError as e:
     sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
     sys.exit(1)
 
+import sepolicy.generate
 import sepolicy.interface
+
 try:
     from subprocess import getstatusoutput
 except ImportError:
@@ -696,16 +698,16 @@ class childWindow:
 
     def on_in_net_page_next(self, *args):
         try:
-            generate.verify_ports(self.in_tcp_entry.get_text())
-            generate.verify_ports(self.in_udp_entry.get_text())
+            sepolicy.generate.verify_ports(self.in_tcp_entry.get_text())
+            sepolicy.generate.verify_ports(self.in_udp_entry.get_text())
         except ValueError as e:
             self.error(e.message)
             return True
 
     def on_out_net_page_next(self, *args):
         try:
-            generate.verify_ports(self.out_tcp_entry.get_text())
-            generate.verify_ports(self.out_udp_entry.get_text())
+            sepolicy.generate.verify_ports(self.out_tcp_entry.get_text())
+            sepolicy.generate.verify_ports(self.out_udp_entry.get_text())
         except ValueError as e:
             self.error(e.message)
             return True
@@ -741,7 +743,7 @@ class childWindow:
             if exe == "":
                 self.error(_("You must enter a executable"))
                 return True
-            policy = generate.policy(name, self.get_type())
+            policy = sepolicy.generate.policy(name, self.get_type())
             policy.set_program(exe)
             policy.gen_writeable()
             policy.gen_symbols()
-- 
2.16.1
