From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070309203511.778297290@hp.com>
References: <20070309203327.709750017@hp.com>
Date: Fri, 09 Mar 2007 15:33:29 -0500
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com, sds@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/3] Refpolicy: remove a duplicate rule in the ipsec.te file
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The "seutil_read_config(setkey_t)" rule is duplicated in the IPsec policy file,
it is possibile that the first occurrence is intended to be for the racoon_t
domain but we'll just remove for now.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/system/ipsec.te |    2 --
 1 file changed, 2 deletions(-)

Index: refpolicy/policy/modules/system/ipsec.te
===================================================================
--- refpolicy.orig/policy/modules/system/ipsec.te
+++ refpolicy/policy/modules/system/ipsec.te
@@ -333,8 +333,6 @@ logging_send_syslog_msg(racoon_t)
 
 miscfiles_read_localization(racoon_t)
 
-seutil_read_config(setkey_t)
-
 ########################################
 #
 # Setkey local policy

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
