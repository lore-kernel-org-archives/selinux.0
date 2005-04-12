From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: named policy patch
Date: Tue, 12 Apr 2005 23:26:30 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jy8WCQT4WFeg4JR"
Message-Id: <200504122326.33930.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Jy8WCQT4WFeg4JR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows named to correctly start on FC4T2 with the strict 
policy when unlimitedRC is commented.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Jy8WCQT4WFeg4JR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -u old/named.fc new/named.fc
--- old/named.fc	2005-04-12 23:24:32.000000000 +1000
+++ new/named.fc	2005-04-12 23:24:23.000000000 +1000
@@ -16,6 +16,7 @@
 /etc/rndc.*		--	system_u:object_r:named_conf_t
 /etc/rndc.key  		-- 	system_u:object_r:dnssec_t
 /usr/sbin/named      	--	system_u:object_r:named_exec_t
+/usr/sbin/named-checkconf --	system_u:object_r:named_checkconf_exec_t
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
 /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
diff -u old/named.te new/named.te
--- old/named.te	2005-04-12 23:24:39.000000000 +1000
+++ new/named.te	2005-04-12 23:24:45.000000000 +1000
@@ -15,6 +15,9 @@
 daemon_domain(named, `, nscd_client_domain')
 tmp_domain(named)
 
+type named_checkconf_exec_t, file_type, exec_type, sysadmfile;
+domain_auto_trans(initrc_t, named_checkconf_exec_t, named_t)
+
 # For /var/run/ndc used in BIND 8
 file_type_auto_trans(named_t, var_run_t, named_var_run_t, sock_file)
 

--Boundary-00=_Jy8WCQT4WFeg4JR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
