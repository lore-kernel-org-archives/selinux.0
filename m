From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 15/15] [src-policy] semanage: source permissive module
Date: Tue, 26 Jan 2010 17:08:21 -0500
Message-Id: <1264543701-20638-16-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-15-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
 <1264543701-20638-8-git-send-email-ccase@tresys.com>
 <1264543701-20638-9-git-send-email-ccase@tresys.com>
 <1264543701-20638-10-git-send-email-ccase@tresys.com>
 <1264543701-20638-11-git-send-email-ccase@tresys.com>
 <1264543701-20638-12-git-send-email-ccase@tresys.com>
 <1264543701-20638-13-git-send-email-ccase@tresys.com>
 <1264543701-20638-14-git-send-email-ccase@tresys.com>
 <1264543701-20638-15-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This changes the permissive module generation to create a source refpol
module instead of a policy package.
---
 policycoreutils/semanage/seobject.py |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 0aa7759..82132f3 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -274,26 +274,21 @@ class permissiveRecords(semanageRecords):
                dirname = tempfile.mkdtemp("-semanage")
                savedir = os.getcwd()
                os.chdir(dirname)
-               filename = "%s.te" % name
+               filename = "%s.ref" % name
                modtxt = """
-module %s 1.0;
+policy_module(%s, 1.0)
 
-require {
+gen_require(`
           type %s;
-}
+')
 
 permissive %s;
 """ % (name, type, type)
                fd = open(filename, 'w')
                fd.write(modtxt)
                fd.close()
-               mc = module.ModuleCompiler()
-               mc.create_module_package(filename, 1)
-               fd = open("permissive_%s.pp" % type)
-               data = fd.read()
-               fd.close()
 
-               rc = semanage_module_install(self.sh, data, len(data));
+               rc = semanage_module_install_file(self.sh, filename)
                if rc >= 0:
                       self.commit()
 
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
