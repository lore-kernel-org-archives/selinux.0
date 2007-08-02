Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72ITHUM013448
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:29:17 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72ITGOD011804
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:29:16 GMT
Message-ID: <46B22279.9030909@redhat.com>
Date: Thu, 02 Aug 2007 14:29:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [PATCH] refpolicy: system_iptables changes]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Switch iptables to use nsswitch

--- nsaserefpolicy/policy/modules/system/iptables.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/system/iptables.te	2007-07-25 12:27:26.000000000 -0400
@@ -44,6 +44,8 @@
 
 corenet_relabelto_all_packets(iptables_t)
 
+auth_use_nsswitch(iptables_t)
+
 dev_read_sysfs(iptables_t)
 
 fs_getattr_xattr_fs(iptables_t)
@@ -62,6 +64,7 @@
 init_use_script_ptys(iptables_t)
 # to allow rules to be saved on reboot:
 init_rw_script_tmp_files(iptables_t)
+init_rw_script_stream_sockets(iptables_t)
 
 libs_use_ld_so(iptables_t)
 libs_use_shared_libs(iptables_t)
@@ -96,10 +99,6 @@
 ')
 
 optional_policy(`
-	nscd_socket_use(iptables_t)
-')
-
-optional_policy(`
 	ppp_dontaudit_use_fds(iptables_t)
 ')


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
