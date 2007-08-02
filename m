Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KV7DR024450
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:31:07 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KV5M1006159
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:31:05 GMT
Date: Thu, 2 Aug 2007 16:30:01 -0400
Message-Id: <200708022030.l72KU19W032218@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_ipsec changes sends audit messages
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not sure we need ipsec_labeled, used within domain.te

--- nsaserefpolicy/policy/modules/system/ipsec.if	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/ipsec.if	2007-08-02 11:02:02.000000000 -0400
@@ -114,6 +114,26 @@
 
 ########################################
 ## <summary>
+##	Allow an IPsec SA to be used by an IPsec Policy.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_labeled',`
+	gen_require(`
+		type ipsec_spd_t;
+	')
+
+	allow $1 ipsec_spd_t:association polmatch;
+	domain_ipsec_labels($1)
+')
+
+
+########################################
+## <summary>
 ##	Execute racoon in the racoon domain.
 ## </summary>
 ## <param name="domain">
--- nsaserefpolicy/policy/modules/system/ipsec.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/ipsec.te	2007-08-02 11:02:02.000000000 -0400
@@ -283,6 +283,7 @@
 allow racoon_t self:netlink_selinux_socket { bind create read };
 allow racoon_t self:udp_socket create_socket_perms;
 allow racoon_t self:key_socket { create read setopt write };
+logging_send_audit_msgs(racoon_t)
 
 # manage pid file
 manage_files_pattern(racoon_t,ipsec_var_run_t,ipsec_var_run_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
