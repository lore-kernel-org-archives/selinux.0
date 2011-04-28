Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3SCgp5M025819
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 08:42:51 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3SCgoqg012594
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 12:42:51 GMT
Received: by wyi11 with SMTP id 11so2385468wyi.12
        for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 05:42:50 -0700 (PDT)
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Delete redundant role system_r assignments after init_daemon_domain
Date: Thu, 28 Apr 2011 14:42:46 +0200
Message-Id: <1303994566-1483967-1-git-send-email-andronicus.spiros@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Elia Pinto <gitter.spiros@gmail.com>

The interface init_daemon_domain in reference policy
already call role system_r types <domain type>. Calling
it again after init_daemon_domain is therefore redundant.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 policy/modules/services/apache.te   |    1 -
 policy/modules/services/bind.te     |    1 -
 policy/modules/services/milter.if   |    1 -
 policy/modules/services/pads.te     |    1 -
 policy/modules/services/prelude.te  |    1 -
 policy/modules/system/ipsec.te      |    2 --
 policy/modules/system/raid.te       |    1 -
 policy/modules/system/sysnetwork.te |    1 -
 8 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/policy/modules/services/apache.te b/policy/modules/services/apache.te
index 3136c6a..2175c26 100644
--- a/policy/modules/services/apache.te
+++ b/policy/modules/services/apache.te
@@ -157,7 +157,6 @@ attribute httpd_script_domains;
 type httpd_t;
 type httpd_exec_t;
 init_daemon_domain(httpd_t, httpd_exec_t)
-role system_r types httpd_t;
 
 # httpd_cache_t is the type given to the /var/cache/httpd
 # directory and the files under that directory
diff --git a/policy/modules/services/bind.te b/policy/modules/services/bind.te
index 4deca04..27810a1 100644
--- a/policy/modules/services/bind.te
+++ b/policy/modules/services/bind.te
@@ -20,7 +20,6 @@ files_security_file(dnssec_t)
 type named_t;
 type named_exec_t;
 init_daemon_domain(named_t, named_exec_t)
-role system_r types named_t;
 
 type named_checkconf_exec_t;
 init_system_domain(named_t, named_checkconf_exec_t)
diff --git a/policy/modules/services/milter.if b/policy/modules/services/milter.if
index ed1af3c..f6959c6 100644
--- a/policy/modules/services/milter.if
+++ b/policy/modules/services/milter.if
@@ -20,7 +20,6 @@ template(`milter_template',`
 	type $1_milter_t, milter_domains;
 	type $1_milter_exec_t;
 	init_daemon_domain($1_milter_t, $1_milter_exec_t)
-	role system_r types $1_milter_t;
 
 	# Type for the milter data (e.g. the socket used to communicate with the MTA)
 	type $1_milter_data_t, milter_data_type;
diff --git a/policy/modules/services/pads.te b/policy/modules/services/pads.te
index b246bdd..ea5755e 100644
--- a/policy/modules/services/pads.te
+++ b/policy/modules/services/pads.te
@@ -8,7 +8,6 @@ policy_module(pads, 1.0.0)
 type pads_t;
 type pads_exec_t;
 init_daemon_domain(pads_t, pads_exec_t)
-role system_r types pads_t;
 
 type pads_initrc_exec_t;
 init_script_file(pads_initrc_exec_t)
diff --git a/policy/modules/services/prelude.te b/policy/modules/services/prelude.te
index b1bc02c..68d5ced 100644
--- a/policy/modules/services/prelude.te
+++ b/policy/modules/services/prelude.te
@@ -35,7 +35,6 @@ files_pid_file(prelude_audisp_var_run_t)
 type prelude_correlator_t;
 type prelude_correlator_exec_t;
 init_daemon_domain(prelude_correlator_t, prelude_correlator_exec_t)
-role system_r types prelude_correlator_t;
 
 type prelude_correlator_config_t;
 files_config_file(prelude_correlator_config_t)
diff --git a/policy/modules/system/ipsec.te b/policy/modules/system/ipsec.te
index 55a6cd8..c5bdc2a 100644
--- a/policy/modules/system/ipsec.te
+++ b/policy/modules/system/ipsec.te
@@ -15,7 +15,6 @@ gen_tunable(racoon_read_shadow, false)
 type ipsec_t;
 type ipsec_exec_t;
 init_daemon_domain(ipsec_t, ipsec_exec_t)
-role system_r types ipsec_t;
 
 # type for ipsec configuration file(s) - not for keys
 type ipsec_conf_file_t;
@@ -57,7 +56,6 @@ files_pid_file(ipsec_mgmt_var_run_t)
 type racoon_t;
 type racoon_exec_t;
 init_daemon_domain(racoon_t, racoon_exec_t)
-role system_r types racoon_t;
 
 type racoon_tmp_t;
 files_tmp_file(racoon_tmp_t)
diff --git a/policy/modules/system/raid.te b/policy/modules/system/raid.te
index 73cc8cf..2855e86 100644
--- a/policy/modules/system/raid.te
+++ b/policy/modules/system/raid.te
@@ -8,7 +8,6 @@ policy_module(raid, 1.10.1)
 type mdadm_t;
 type mdadm_exec_t;
 init_daemon_domain(mdadm_t, mdadm_exec_t)
-role system_r types mdadm_t;
 
 type mdadm_map_t;
 files_type(mdadm_map_t)
diff --git a/policy/modules/system/sysnetwork.te b/policy/modules/system/sysnetwork.te
index 34d0ec5..f1e5d1a 100644
--- a/policy/modules/system/sysnetwork.te
+++ b/policy/modules/system/sysnetwork.te
@@ -17,7 +17,6 @@ files_type(dhcp_state_t)
 type dhcpc_t;
 type dhcpc_exec_t;
 init_daemon_domain(dhcpc_t, dhcpc_exec_t)
-role system_r types dhcpc_t;
 
 type dhcpc_state_t;
 files_type(dhcpc_state_t)
-- 
1.7.2.1.44.g721e7


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
