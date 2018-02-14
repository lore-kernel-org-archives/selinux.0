Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1E9rqY9011953
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 04:53:57 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 3zhF9G1l4xzJ3f3
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:54 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 3zhF9G0NWwzJ3f2
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:54 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55B1A40EC7E1
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:50 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 10:53:37 +0100
Message-Id: <20180214095337.1945-5-plautrba@redhat.com>
In-Reply-To: <20180214095337.1945-1-plautrba@redhat.com>
References: <20180214095337.1945-1-plautrba@redhat.com>
Subject: [PATCH 4/4] python/sepolicy: Do not use types.BooleanType
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It was removed from Python 3

Fixes:
File "polgengui.py", line 390, in forward
  self.generate_policy()
File "polgengui.py", line 491, in generate_policy
  my_policy.set_use_syslog(self.syslog_checkbutton.get_active() == 1)
File "/home/plautrba/devel/github/bachradsusi/SELinuxProject-selinux/python/sepolicy/sepolicy/generate.py",  line 468, in set_use_syslog
  if not isinstance(val, types.BooleanType):
AttributeError: module 'types' has no attribute 'BooleanType'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/generate.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 1b36eb6e..31aa968f 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -459,25 +459,25 @@ class policy:
         self.out_udp = [all, False, False, verify_ports(ports)]
 
     def set_use_resolve(self, val):
-        if not isinstance(val, types.BooleanType):
+        if type(val) is not bool:
             raise ValueError(_("use_resolve must be a boolean value "))
 
         self.use_resolve = val
 
     def set_use_syslog(self, val):
-        if not isinstance(val, types.BooleanType):
+        if type(val) is not bool:
             raise ValueError(_("use_syslog must be a boolean value "))
 
         self.use_syslog = val
 
     def set_use_kerberos(self, val):
-        if not isinstance(val, types.BooleanType):
+        if type(val) is not bool:
             raise ValueError(_("use_kerberos must be a boolean value "))
 
         self.use_kerberos = val
 
     def set_manage_krb5_rcache(self, val):
-        if not isinstance(val, types.BooleanType):
+        if type(val) is not bool:
             raise ValueError(_("manage_krb5_rcache must be a boolean value "))
 
         self.manage_krb5_rcache = val
-- 
2.16.1
