Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IHNO70003989
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 13:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2004A401DEAF
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 17:23:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6D1E7C5C
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 17:23:19 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 18 Jun 2018 19:22:01 +0200
Message-Id: <20180618172201.4540-1-vmojzis@redhat.com>
Subject: [PATCH] python/semanage: Stop logging loginRecords changes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

semanage_seuser_modify_local and semanage_seuser_del_local already do
the logging.
Moreover, semanage log for loginRecords.__add was flawed since it
reported old-{seuser,role,range} of default user instead of None. This
was caused by selinux.getseuserbyname, which returns values for default
user when the specified username is not found.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1294663

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index c76dce85..d3e14a8b 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -593,7 +593,6 @@ class loginRecords(semanageRecords):
 
         semanage_seuser_key_free(k)
         semanage_seuser_free(u)
-        self.mylog.log("login", name, sename=sename, serange=serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange)
 
     def add(self, name, sename, serange):
         try:
@@ -601,7 +600,6 @@ class loginRecords(semanageRecords):
             self.__add(name, sename, serange)
             self.commit()
         except ValueError as error:
-            self.mylog.commit(0)
             raise error
 
     def __modify(self, name, sename="", serange=""):
@@ -653,7 +651,6 @@ class loginRecords(semanageRecords):
 
         semanage_seuser_key_free(k)
         semanage_seuser_free(u)
-        self.mylog.log("login", name, sename=self.sename, serange=self.serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange)
 
     def modify(self, name, sename="", serange=""):
         try:
@@ -661,7 +658,6 @@ class loginRecords(semanageRecords):
             self.__modify(name, sename, serange)
             self.commit()
         except ValueError as error:
-            self.mylog.commit(0)
             raise error
 
     def __delete(self, name):
@@ -694,8 +690,6 @@ class loginRecords(semanageRecords):
         rec, self.sename, self.serange = selinux.getseuserbyname("__default__")
         range, (rc, serole) = userrec.get(self.sename)
 
-        self.mylog.log_remove("login", name, sename=self.sename, serange=self.serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange)
-
     def delete(self, name):
         try:
             self.begin()
@@ -703,7 +697,6 @@ class loginRecords(semanageRecords):
             self.commit()
 
         except ValueError as error:
-            self.mylog.commit(0)
             raise error
 
     def deleteall(self):
@@ -717,7 +710,6 @@ class loginRecords(semanageRecords):
                 self.__delete(semanage_seuser_get_name(u))
             self.commit()
         except ValueError as error:
-            self.mylog.commit(0)
             raise error
 
     def get_all_logins(self):
-- 
2.14.3
