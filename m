Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA17152
	for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2002 16:02:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA24198
	for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2002 20:00:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA24194
	for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2002 20:00:55 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 393C892725
	for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 06:02:15 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E7E79160B
	for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2002 21:51:29 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: bind9 policy patch
Date: Sun, 15 Sep 2002 21:51:03 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3HWHF1WLZHG1AXNEUH0L"
Message-Id: <200209152151.03247.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_3HWHF1WLZHG1AXNEUH0L
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached patch for the policy is needed for bind9 operation.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_3HWHF1WLZHG1AXNEUH0L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="d"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="d"

diff -ru /usr/share/selinux/policy/default/domains/program/dpkg.te /usr/share/selinux/policy/current/domains/program/dpkg.te
--- /usr/share/selinux/policy/default/domains/program/dpkg.te	2002-09-15 19:26:42.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/dpkg.te	2002-09-15 21:43:58.000000000 +0200
@@ -52,6 +52,9 @@
 ifdef(`apache.te', `
 domain_auto_trans(dpkg_t, httpd_exec_t, httpd_t)
 ')
+ifdef(`named.te', `
+file_type_auto_trans(dpkg_t, named_zone_t, rndc_conf_t)
+')
 
 # for apt
 type apt_t, domain, admin;
diff -ru /usr/share/selinux/policy/default/domains/program/named.te /usr/share/selinux/policy/current/domains/program/named.te
--- /usr/share/selinux/policy/default/domains/program/named.te	2002-09-15 19:26:42.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/named.te	2002-09-15 21:45:38.000000000 +0200
@@ -9,7 +9,8 @@
 #
 # Rules for the named_t domain.
 #
-type named_port_t,port_type;
+type named_port_t, port_type;
+type rndc_port_t, port_type;
 
 daemon_domain(named)
 # ndc_t is the domain for the ndc program
@@ -25,7 +26,8 @@
 allow named_t self:process setsched;
 
 # A type for configuration files of named.
-type named_conf_t, file_type,sysadmfile;
+type named_conf_t, file_type, sysadmfile;
+type rndc_conf_t, file_type, sysadmfile;
 
 # for primary zone files
 type named_zone_t, file_type, sysadmfile;
@@ -49,7 +51,7 @@
 
 # Bind to the named port.
 allow named_t named_port_t:udp_socket name_bind;
-allow named_t named_port_t:tcp_socket name_bind;
+allow named_t { named_port_t rndc_port_t }:tcp_socket name_bind;
 
 #read configuration files
 r_dir_file(named_t, named_conf_t)
@@ -89,6 +91,8 @@
 type ndc_exec_t, file_type,sysadmfile, exec_type;
 domain_auto_trans(sysadm_t, ndc_exec_t, ndc_t)
 uses_shlib(ndc_t)
+can_tcp_connect(ndc_t, named_t)
+allow { named_t ndc_t } rndc_conf_t:file { getattr read };
 
 allow ndc_t etc_t:dir r_dir_perms;
 allow ndc_t self:unix_stream_socket create_stream_socket_perms;
diff -ru /usr/share/selinux/policy/default/file_contexts/program/named.fc /usr/share/selinux/policy/current/file_contexts/program/named.fc
--- /usr/share/selinux/policy/default/file_contexts/program/named.fc	2002-09-15 19:26:42.000000000 +0200
+++ /usr/share/selinux/policy/current/file_contexts/program/named.fc	2002-09-15 21:41:58.000000000 +0200
@@ -3,6 +3,7 @@
 /etc/named.conf       		system_u:object_r:named_conf_t
 /etc/bind(/.*)?			system_u:object_r:named_zone_t
 /etc/bind/named.conf		system_u:object_r:named_conf_t
+/etc/bind/rndc.key		system_u:object_r:rndc_conf_t
 /usr/sbin/named.*      		system_u:object_r:named_exec_t
 /usr/sbin/ndc			system_u:object_r:ndc_exec_t
 /var/cache/bind(/.*)?		system_u:object_r:named_cache_t
diff -ru /usr/share/selinux/policy/default/net_contexts /usr/share/selinux/policy/current/net_contexts
--- /usr/share/selinux/policy/default/net_contexts	2002-09-15 19:26:42.000000000 +0200
+++ /usr/share/selinux/policy/current/net_contexts	2002-09-15 20:49:34.000000000 +0200
@@ -57,6 +57,7 @@
 ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
 ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
 ifdef(`cups.te', `portcon tcp 631 system_u:object_r:ipp_port_t')
+ifdef(`named.te', `portcon tcp 953 system_u:object_r:rndc_port_t')
 ifdef(`use_pop', `
 portcon tcp 993 system_u:object_r:pop_port_t
 portcon tcp 995 system_u:object_r:pop_port_t

--------------Boundary-00=_3HWHF1WLZHG1AXNEUH0L--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
