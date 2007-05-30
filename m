Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbxp3014621
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbt2p008441
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:56 GMT
Date: Wed, 30 May 2007 10:47:00 -0400
Message-Id: <200705301447.l4UEl0ik008155@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Kerberos changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added kerberosclient to consolodate policies
Servers now need to communicate with ldap

--- nsaserefpolicy/policy/modules/services/kerberos.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/kerberos.if	2007-05-30 07:35:54.000000000 -0400
@@ -33,43 +33,10 @@
 #
 interface(`kerberos_use',`
 	gen_require(`
-		type krb5_conf_t;
-		type krb5kdc_conf_t;
+		attribute kerberosclient;
 	')
 
-	files_search_etc($1)
-	allow $1 krb5_conf_t:file { getattr read };
-	dontaudit $1 krb5_conf_t:file write;
-	dontaudit $1 krb5kdc_conf_t:dir list_dir_perms;
-	dontaudit $1 krb5kdc_conf_t:file rw_file_perms;
-
-	tunable_policy(`allow_kerberos',`
-		allow $1 self:tcp_socket create_socket_perms;
-		allow $1 self:udp_socket create_socket_perms;
-
-		corenet_non_ipsec_sendrecv($1)
-		corenet_tcp_sendrecv_all_if($1)
-		corenet_udp_sendrecv_all_if($1)
-		corenet_tcp_sendrecv_all_nodes($1)
-		corenet_udp_sendrecv_all_nodes($1)
-		corenet_tcp_sendrecv_kerberos_port($1)
-		corenet_udp_sendrecv_kerberos_port($1)
-		corenet_tcp_bind_all_nodes($1)
-		corenet_udp_bind_all_nodes($1)
-		corenet_tcp_connect_kerberos_port($1)
-		corenet_tcp_connect_ocsp_port($1)
-		corenet_sendrecv_kerberos_client_packets($1)
-		corenet_sendrecv_ocsp_client_packets($1)
-
-		sysnet_read_config($1)
-		sysnet_dns_name_resolve($1)
-	')
-
-	optional_policy(`
-		tunable_policy(`allow_kerberos',`
-			pcscd_stream_connect($1)
-		')
-	')
+	typeattribute $1 kerberosclient;
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/kerberos.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/kerberos.te	2007-05-30 07:35:54.000000000 -0400
@@ -5,6 +5,7 @@
 #
 # Declarations
 #
+attribute kerberosclient;
 
 ## <desc>
 ## <p>
@@ -126,6 +127,7 @@
 miscfiles_read_localization(kadmind_t)
 
 sysnet_read_config(kadmind_t)
+sysnet_use_ldap(kadmind_t)
 
 userdom_dontaudit_use_unpriv_user_fds(kadmind_t)
 userdom_dontaudit_search_sysadm_home_dirs(kadmind_t)
@@ -221,6 +223,7 @@
 miscfiles_read_localization(krb5kdc_t)
 
 sysnet_read_config(krb5kdc_t)
+sysnet_use_ldap(krb5kdc_t)
 
 userdom_dontaudit_use_unpriv_user_fds(krb5kdc_t)
 userdom_dontaudit_search_sysadm_home_dirs(krb5kdc_t)
@@ -236,3 +239,36 @@
 optional_policy(`
 	udev_read_db(krb5kdc_t)
 ')
+
+files_search_etc(kerberosclient)
+allow kerberosclient krb5_conf_t:file { getattr read };
+dontaudit kerberosclient krb5_conf_t:file write;
+dontaudit kerberosclient krb5kdc_conf_t:dir list_dir_perms;
+dontaudit kerberosclient krb5kdc_conf_t:file rw_file_perms;
+
+tunable_policy(`allow_kerberos',`
+	allow kerberosclient self:tcp_socket create_socket_perms;
+	allow kerberosclient self:udp_socket create_socket_perms;
+
+	corenet_non_ipsec_sendrecv(kerberosclient)
+	corenet_tcp_sendrecv_all_if(kerberosclient)
+	corenet_udp_sendrecv_all_if(kerberosclient)
+	corenet_tcp_sendrecv_all_nodes(kerberosclient)
+	corenet_udp_sendrecv_all_nodes(kerberosclient)
+	corenet_tcp_sendrecv_kerberos_port(kerberosclient)
+	corenet_udp_sendrecv_kerberos_port(kerberosclient)
+	corenet_tcp_bind_all_nodes(kerberosclient)
+	corenet_udp_bind_all_nodes(kerberosclient)
+	corenet_tcp_connect_kerberos_port(kerberosclient)
+	corenet_tcp_connect_ocsp_port(kerberosclient)
+	corenet_sendrecv_kerberos_client_packets(kerberosclient)
+	corenet_sendrecv_ocsp_client_packets(kerberosclient)
+
+	sysnet_read_config(kerberosclient)
+	sysnet_dns_name_resolve(kerberosclient)
+')
+optional_policy(`
+	tunable_policy(`allow_kerberos',`
+		pcscd_stream_connect(kerberosclient)
+	')
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
