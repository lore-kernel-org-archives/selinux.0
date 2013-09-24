Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8OGXLJr027529
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2013 12:33:26 -0400
Subject: [selinux-testsuite RFC PATCH 1/4] test_policy: test_global.te fix
 for Fedora Rawhide (Sept 24th, 2013)
To: serge@hallyn.com
From: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 24 Sep 2013 12:33:21 -0400
Message-ID: <20130924163321.27393.64105.stgit@localhost>
In-Reply-To: <20130924162401.27393.70353.stgit@localhost>
References: <20130924162401.27393.70353.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 policy/test_global.te |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 3891f6e..49c85b1 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -5,6 +5,7 @@ policy_module(test_policy,1.0.0)
 #
 # Declarations
 #
+
 attribute testdomain;
 
 gen_require(`
@@ -34,8 +35,8 @@ miscfiles_read_test_files(testdomain)
 
 # Let the test domains set their current, exec and fscreate contexts.
 allow testdomain self:process setcurrent;
-# domain_dyntrans_type(testdomain)
-selinux_get_fs_mount(testdomain)
+#domain_dyntrans_type(testdomain)
+#selinux_get_fs_mount(testdomain)
 allow testdomain self:process setexec;
 allow testdomain self:process setfscreate;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
