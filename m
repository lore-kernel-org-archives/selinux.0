Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72K2AfM021737
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:02:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72K26ev029878
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:02:06 GMT
Date: Thu, 2 Aug 2007 16:01:42 -0400
Message-Id: <200708022001.l72K1gH3029628@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: kernel_domain changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not sure all of this is still required with latest changes of netlabel.  But this is my current diff
--- nsaserefpolicy/policy/modules/kernel/domain.if	2007-06-19 16:23:34.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/domain.if	2007-08-02 11:02:02.000000000 -0400
@@ -45,6 +45,11 @@
 	# start with basic domain
 	domain_base_type($1)
 
+	optional_policy(`
+		unconfined_use_fds($1)
+		unconfined_sigchld($1)
+	')
+
 	# send init a sigchld and signull
 	optional_policy(`
 		init_sigchld($1)
@@ -59,6 +64,7 @@
 	')
 
 	optional_policy(`
+		selinux_dontaudit_getattr_fs($1)
 		selinux_dontaudit_read_fs($1)
 	')
 
@@ -1271,3 +1277,20 @@
 	typeattribute $1 mmap_low_domain_type;
 ')
 
+########################################
+## <summary>
+##	Allow specified type to associate ipsec packets from any domain
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type of subject to be allowed this.
+##	</summary>
+## </param>
+#
+interface(`domain_ipsec_labels',`
+	gen_require(`
+		attribute domain;
+ 	')
+ 
+	allow $1 domain:association { sendto recvfrom };
+')
--- nsaserefpolicy/policy/modules/kernel/domain.te	2007-07-25 10:37:36.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/domain.te	2007-08-02 11:02:02.000000000 -0400
@@ -6,6 +6,29 @@
 # Declarations
 #
 
+ifdef(`enable_mls',`
+## <desc>
+## <p>
+## Allow all domains to use netlabel labeled packets
+## </p>
+## </desc>
+gen_tunable(allow_netlabel,true)
+
+## <desc>
+## <p>
+## Allow all domains to use ipsec labeled packets
+## </p>
+## </desc>
+gen_tunable(allow_ipsec_label,true)
+')
+
+## <desc>
+## <p>
+## Allow unlabeled packets to work on system
+## </p>
+## </desc>
+gen_tunable(allow_unlabeled_packets,true)
+
 # Mark process types as domains
 attribute domain;
 
@@ -134,3 +157,25 @@
 
 # act on all domains keys
 allow unconfined_domain_type domain:key *;
+
+# xdm passes an open file descriptor to xsession-errors.log which is then audited by all confined domains.
+optional_policy(`
+	xserver_dontaudit_use_xdm_fds(domain)
+	xserver_dontaudit_rw_xdm_pipes(domain)
+')
+
+tunable_policy(`allow_unlabeled_packets',`
+	kernel_sendrecv_unlabeled_association(domain)
+	corenet_sendrecv_unlabeled_packets(domain)
+')
+
+ifdef(`enable_mls',`
+	tunable_policy(`allow_netlabel',`
+		kernel_raw_recvfrom_unlabeled(domain)
+		kernel_tcp_recvfrom_unlabeled(domain)
+		kernel_udp_recvfrom_unlabeled(domain)
+	')
+	tunable_policy(`allow_ipsec_label',`
+		ipsec_labeled(domain)
+	')
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
