From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070309203513.357373998@hp.com>
References: <20070309203327.709750017@hp.com>
Date: Fri, 09 Mar 2007 15:33:30 -0500
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com, sds@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/3] Refpolicy: allow netlabelctl to be run at boot
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Allow the NetLabel management tools to be run at boot from the init scripts.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/system/netlabel.te |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: refpolicy/policy/modules/system/netlabel.te
===================================================================
--- refpolicy.orig/policy/modules/system/netlabel.te
+++ refpolicy/policy/modules/system/netlabel.te
@@ -8,8 +8,7 @@ policy_module(netlabel,1.0.0)
 
 type netlabel_mgmt_t;
 type netlabel_mgmt_exec_t;
-domain_type(netlabel_mgmt_t)
-domain_entry_file(netlabel_mgmt_t,netlabel_mgmt_exec_t)
+init_daemon_domain(netlabel_mgmt_t,netlabel_mgmt_exec_t)
 
 ########################################
 #

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
