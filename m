From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: cups policy
Date: Thu, 14 Oct 2004 22:32:17 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RHnbBC+9edgr77a"
Message-Id: <200410142232.18006.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_RHnbBC+9edgr77a
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for the latest version of cups in rawhide.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_RHnbBC+9edgr77a
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cups.diff"

--- /usr/src/se/policy/file_contexts/program/cups.fc	2004-10-14 10:10:00.000000000 +1000
+++ file_contexts/program/cups.fc	2004-10-14 21:55:17.000000000 +1000
@@ -20,7 +20,7 @@
 /usr/sbin/cupsd		--	system_u:object_r:cupsd_exec_t
 /usr/bin/cups-config-daemon --	system_u:object_r:cupsd_config_exec_t
 /usr/sbin/hal_lpadmin --	system_u:object_r:cupsd_config_exec_t
-/usr/sbin/printconf-backend --	system_u:object_r:sbin_t
+/usr/sbin/printconf-backend --	system_u:object_r:cupsd_config_exec_t
 /var/log/cups(/.*)?		system_u:object_r:cupsd_log_t
 /var/spool/cups(/.*)?		system_u:object_r:print_spool_t
 /var/run/cups/printcap	--	system_u:object_r:cupsd_var_run_t
--- /usr/src/se/policy/domains/program/unused/cups.te	2004-10-14 10:09:57.000000000 +1000
+++ domains/program/unused/cups.te	2004-10-14 22:01:18.000000000 +1000
@@ -170,6 +170,14 @@
 # CUPS configuration daemon
 daemon_domain(cupsd_config)
 
+ifdef(`distro_redhat', `
+ifdef(`rpm.te', `
+allow cupsd_config_t rpm_var_lib_t:dir { getattr search };
+allow cupsd_config_t rpm_var_lib_t:file { getattr read };
+')
+allow cupsd_config_t initrc_exec_t:file getattr;
+')dnl end distro_redhat
+
 allow cupsd_config_t { etc_t etc_runtime_t net_conf_t }:file { getattr read };
 allow cupsd_config_t self:file { getattr read };
 

--Boundary-00=_RHnbBC+9edgr77a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
