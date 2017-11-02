Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA2DkMuV017775
 for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2017 09:46:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E08A37E438
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 13:19:36 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu,  2 Nov 2017 14:19:30 +0100
Message-Id: <20171102131930.11585-1-plautrba@redhat.com>
Subject: [PATCH] python/semanage: Do not try to reload policy when
 SELinux is disabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When SELinux is disabled, semanage without -N fails with a quite complicated
error message when it tries to reload a new policy. Since reload in this case
doesn't make sense, we should probably try to avoid that.

Fixes:
$ sudo umount /sys/fs/selinux

$ sudo semanage fcontext -a --type=postfix_local_tmp_t /var/opt/01789667
SELinux:  Could not downgrade policy file /etc/selinux/targeted/policy/policy.31, searching for an older version.
SELinux:  Could not open policy file <= /etc/selinux/targeted/policy/policy.31:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
SELinux:  Could not downgrade policy file /etc/selinux/targeted/policy/policy.31, searching for an older version.
SELinux:  Could not open policy file <= /etc/selinux/targeted/policy/policy.31:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
FileNotFoundError: [Errno 2] No such file or directory

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/seobject.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 1385315f..37f2b8c6 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -241,7 +241,7 @@ class semanageRecords:
 
     def __init__(self, store):
         global handle
-        self.load = True
+        self.load = selinux.is_selinux_enabled()
         self.sh = self.get_handle(store)
 
         rc, localstore = selinux.selinux_getpolicytype()
@@ -251,7 +251,7 @@ class semanageRecords:
             self.mylog = nulllogger()
 
     def set_reload(self, load):
-        self.load = load
+        self.load = selinux.is_selinux_enabled() and load
 
     def get_handle(self, store):
         global is_mls_enabled
-- 
2.14.3
