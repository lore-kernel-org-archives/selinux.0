Subject: Re: Selinux testsuite updated in latest LTP release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1144966405.2462.41.camel@faith.austin.ibm.com>
References: <1144966405.2462.41.camel@faith.austin.ibm.com>
Content-Type: multipart/mixed; boundary="=-C69eC8JXUJZO3TpFkyO0"
Date: Mon, 15 May 2006 13:26:28 -0400
Message-Id: <1147713988.30789.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-C69eC8JXUJZO3TpFkyO0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-04-13 at 17:13 -0500, Joy Latten wrote:
> LTP has released ltp-20060411, their April release which contains
> the selinux testsuite with refpolicy!
> 
> Is there an selinux command/flag in which I can determine whether
> system is running refpolicy or old monolithic policy? 
> If so, I can modify testsuite such that it can run either policy. I am
> unable to determine this piece of info, so currently by default, the
> refpolicy gets used when running the testsuite.

Hi,

I finally got around to trying this, and had to make some modifications
to get the test policy module to build and also to workaround the TODO
items you listed.  The diff below enabled me to build and run all tests
except task_create successfully (if I disable assertion checking via
expand-check = 0 in /etc/selinux/semanage.conf), but this patch is
obviously not the right way to do it (direct references to types in the
base policy).  Can we get these remaining issues resolved so that the
selinux testsuite in ltp works cleanly on FC5?

-- 
Stephen Smalley
National Security Agency

--=-C69eC8JXUJZO3TpFkyO0
Content-Disposition: attachment; filename=ltp-refpolicy.diff
Content-Type: text/x-patch; name=ltp-refpolicy.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ru refpolicy/test_capable_net.te refpolicy.new/test_capable_net.te
--- refpolicy/test_capable_net.te	2006-03-27 11:55:48.000000000 -0500
+++ refpolicy.new/test_capable_net.te	2006-05-15 12:59:06.000000000 -0400
@@ -42,11 +42,11 @@
 corecmd_sbin_entry_type(capabledomain)
 userdom_sysadm_sbin_spec_domtrans_to(capabledomain)
 
-#TODO: Need ifconfig_exec_t to be an entrypoint in order for domain
-# transition to succeed. How to do this with refpolicy???
-#ifdef(`sysnetwork.te', `
-#	domain_trans(sysadm_t, ifconfig_exec_t, capabledomain)
-#')
+require {
+	type ifconfig_exec_t;
+}
+domain_trans(sysadm_t, ifconfig_exec_t, capabledomain)
+domain_entry_file(capabledomain, ifconfig_exec_t)
 
 # Permissions for the good domain
 allow test_ncap_t self:capability { dac_override net_admin net_raw };
diff -ru refpolicy/test_global.te refpolicy.new/test_global.te
--- refpolicy/test_global.te	2006-03-24 12:29:38.000000000 -0500
+++ refpolicy.new/test_global.te	2006-05-15 12:49:45.000000000 -0400
@@ -27,7 +27,7 @@
 miscfiles_read_test_files(testdomain)
 
 # Let the test domains set their current, exec and fscreate contexts.
-#allow testdomain self:process setcurrent;
+allow testdomain self:process setcurrent;
 # domain_dyntrans_type(testdomain)
 selinux_get_fs_mount(testdomain)
 allow testdomain self:process setexec;
@@ -51,6 +51,18 @@
 files_list_home(testdomain)
 dev_read_rand(testdomain)
 files_list_pids(testdomain)
+require {
+	type root_t;
+	type etc_t;
+	type bin_t;
+	type sbin_t;
+	type lib_t;
+	type usr_t;
+	type devpts_t;
+	type devtty_t;
+	type null_device_t;
+	type zero_device_t;
+}
 allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir r_dir_perms;
 allow testdomain lib_t:{ file lnk_file } r_file_perms;
 allow testdomain etc_t:file r_file_perms;
diff -ru refpolicy/test_readlink.te refpolicy.new/test_readlink.te
--- refpolicy/test_readlink.te	2006-03-22 16:30:29.000000000 -0500
+++ refpolicy.new/test_readlink.te	2006-05-15 12:57:52.000000000 -0400
@@ -29,4 +29,8 @@
 
 # TODO: Needs to be translated into refpolicy... how?
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+require {
+	type ls_exec_t;
+}
+domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+domain_entry_file(test_readlink_domain, ls_exec_t)
diff -ru refpolicy/test_rxdir.te refpolicy.new/test_rxdir.te
--- refpolicy/test_rxdir.te	2006-03-22 16:30:29.000000000 -0500
+++ refpolicy.new/test_rxdir.te	2006-05-15 12:59:41.000000000 -0400
@@ -27,4 +27,8 @@
 
 # TODO: How to translate this into refpolicy????
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
+require {
+	type ls_exec_t;
+}
+domain_entry_file(test_rxdir_domain, ls_exec_t)
+domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
diff -ru refpolicy/test_stat.te refpolicy.new/test_stat.te
--- refpolicy/test_stat.te	2006-03-22 16:30:29.000000000 -0500
+++ refpolicy.new/test_stat.te	2006-05-15 12:59:52.000000000 -0400
@@ -24,4 +24,8 @@
 
 # TODO: what is a replacement for this in refpolicy???
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+require {
+	type ls_exec_t;
+}
+domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+domain_entry_file(test_stat_domain, ls_exec_t)
diff -ru refpolicy/test_task_create.te refpolicy.new/test_task_create.te
--- refpolicy/test_task_create.te	2006-03-27 11:55:48.000000000 -0500
+++ refpolicy.new/test_task_create.te	2006-05-15 12:48:02.000000000 -0400
@@ -22,7 +22,7 @@
 # process_fork. Something needs to be done such that test_create_no_t
 # does not have fork permissions, but all the other necessary
 # "domain" permissions.
-#allow test_create_no_t self:process ~fork;
+allow test_create_no_t self:process ~fork;
 allow test_create_no_t proc_t:dir r_dir_perms;
 allow test_create_no_t proc_t:lnk_file read;
 allow test_create_no_t self:dir r_dir_perms;

--=-C69eC8JXUJZO3TpFkyO0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
