From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070309203506.981881820@hp.com>
References: <20070309203327.709750017@hp.com>
Date: Fri, 09 Mar 2007 15:33:28 -0500
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com, sds@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/3] Refpolicy: allow the IPsec management tools to start at boot
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the IPsec tools are rather noisy at startup, in terms of AVC denials,
if they start at all.  This patch attempts to cleanup some of the AVC denials
caused by "fd use" as well as allowing the setkey_t domain to read the required
configuration files.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/system/ipsec.te |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: refpolicy/policy/modules/system/ipsec.te
===================================================================
--- refpolicy.orig/policy/modules/system/ipsec.te
+++ refpolicy/policy/modules/system/ipsec.te
@@ -325,6 +325,8 @@ selinux_compute_access_vector(racoon_t)
 libs_use_ld_so(racoon_t)
 libs_use_shared_libs(racoon_t)
 
+init_dontaudit_use_fds(racoon_t)
+
 locallogin_use_fds(racoon_t)
 
 logging_send_syslog_msg(racoon_t)
@@ -348,6 +350,10 @@ allow setkey_t ipsec_spd_t:association s
 # allow setkey utility to set contexts on SA's and policy
 domain_ipsec_setcontext_all_domains(setkey_t)
 
+allow setkey_t ipsec_conf_file_t:dir list_dir_perms;
+read_files_pattern(setkey_t,ipsec_conf_file_t,ipsec_conf_file_t)
+read_lnk_files_pattern(setkey_t,ipsec_conf_file_t,ipsec_conf_file_t)
+
 files_read_etc_files(setkey_t)
 
 locallogin_use_fds(setkey_t)
@@ -355,6 +361,8 @@ locallogin_use_fds(setkey_t)
 libs_use_ld_so(setkey_t)
 libs_use_shared_libs(setkey_t)
 
+init_dontaudit_use_fds(setkey_t)
+
 miscfiles_read_localization(setkey_t)
 
 seutil_read_config(setkey_t)

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
