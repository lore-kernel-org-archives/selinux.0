Subject: Re: [LTP] Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jburke@redhat.com
Cc: James Morris <jmorris@redhat.com>, Joy Latten <latten@us.ibm.com>,
        Daniel Walsh <dwalsh@redhat.com>, subrata@linux.vnet.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        Robert Williamson <robbiew@us.ibm.com>,
        Michael Reed <mreed10@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Larson <plars@us.ibm.com>
In-Reply-To: <4761CF71.1020101@redhat.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
	 <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
	 <20071211155219.GA22416@sergelap.austin.ibm.com>
	 <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
	 <1197477042.1125.83.camel@moss-spartans.epoch.ncsc.mil>
	 <4761CF71.1020101@redhat.com>
Content-Type: multipart/mixed; boundary="=-+jLdNffm3u9zth710t3I"
Date: Mon, 17 Dec 2007 13:43:13 -0500
Message-Id: <1197916993.17307.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+jLdNffm3u9zth710t3I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-12-13 at 19:33 -0500, Jeff Burke wrote:
> Stephen, Joy, Dan and James
> 	Using Stephens latest patch. Here are the results for the selinux tests
> ltp-full-20071130, RHEL5.1 + selinux-policy-2.4.6-106.el5_1.3:

Reverting the prior patches and applying this one instead, I am able to
run all of the test cases successfully on RHEL5.1 with that policy
version.

I never did get a failure on SELinux10 though even with the old patch.
Looking at your log file, it suggests that you were running the tests
without a controlling tty?  That will break that particular test at
least (sendsigio_task).

As for the build failure on execshare_parent, I don't know how to fix
that on ia64 - is there a portable way to write a call to clone(2) that
will work there?  I don't have ia64 hardware readily available to me.

-- 
Stephen Smalley
National Security Agency

--=-+jLdNffm3u9zth710t3I
Content-Disposition: attachment; filename=ltp-selinux.diff
Content-Type: text/x-vhdl; name=ltp-selinux.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

---

 testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te |   21 ++++++----
 testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te      |   14 ++++++
 testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te    |    6 ++
 testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te       |    6 ++
 testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te        |    6 ++
 testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te |   15 +++----
 6 files changed, 49 insertions(+), 19 deletions(-)

diff -ru ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te
--- ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	2006-03-27 11:55:48.000000000 -0500
+++ ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	2007-12-17 13:16:36.000000000 -0500
@@ -32,21 +32,26 @@
 corenet_tcp_bind_all_nodes(capabledomain)
 corenet_udp_bind_all_nodes(capabledomain)
 sysnet_read_config(capabledomain)
-optional_policy(`mount', `
-	mount_send_nfs_client_request(capabledomain)
-')
+#optional_policy(`mount', `
+#	mount_send_nfs_client_request(capabledomain)
+#')
 
 corenet_tcp_bind_reserved_port(capabledomain)
 
+require {
+	type hi_reserved_port_t;
+}
+allow capabledomain hi_reserved_port_t:tcp_socket name_bind;
+
 # Allow sbin_t to be entered from admin via certain utils.
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
diff -ru ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te
--- ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	2006-03-24 12:29:38.000000000 -0500
+++ ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	2007-12-14 14:53:05.000000000 -0500
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
diff -ru ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te
--- ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te	2006-03-22 16:30:29.000000000 -0500
+++ ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te	2007-12-14 14:53:05.000000000 -0500
@@ -29,4 +29,8 @@
 
 # TODO: Needs to be translated into refpolicy... how?
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+require {
+	type ls_exec_t;
+}
+domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+domain_entry_file(test_readlink_domain, ls_exec_t)
diff -ru ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te
--- ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te	2006-03-22 16:30:29.000000000 -0500
+++ ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te	2007-12-14 14:53:05.000000000 -0500
@@ -27,4 +27,8 @@
 
 # TODO: How to translate this into refpolicy????
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
+require {
+	type ls_exec_t;
+}
+domain_entry_file(test_rxdir_domain, ls_exec_t)
+domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
diff -ru ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te
--- ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te	2006-03-22 16:30:29.000000000 -0500
+++ ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te	2007-12-14 14:53:05.000000000 -0500
@@ -24,4 +24,8 @@
 
 # TODO: what is a replacement for this in refpolicy???
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+require {
+	type ls_exec_t;
+}
+domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+domain_entry_file(test_stat_domain, ls_exec_t)
diff -ru ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te
--- ltp-full-20071130.orig/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	2006-03-27 11:55:48.000000000 -0500
+++ ltp-full-20071130/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	2007-12-17 13:15:14.000000000 -0500
@@ -14,15 +14,16 @@
 # Domain for process not allowed to fork.
 # The same permissions as test_create_yes_t, except process fork
 type test_create_no_t;
-domain_type(test_create_no_t)
-typeattribute test_create_no_t test_create_d;
 
-# TODO
 # In refpolicy, all types with "domain" attribute are allowed
-# process_fork. Something needs to be done such that test_create_no_t
-# does not have fork permissions, but all the other necessary
-# "domain" permissions.
-#allow test_create_no_t self:process ~fork;
+# process_fork. Thus, to prevent test_create_no_t from picking up this
+# permission so we can test it, we omit the domain attribute. 
+# Ideally, refpolicy would _not_ grant such permissions to every domain,
+# as it makes the permission effectively unusable in real policy.
+#domain_type(test_create_no_t)
+typeattribute test_create_no_t test_create_d;
+
+allow test_create_no_t self:process ~fork;
 allow test_create_no_t proc_t:dir r_dir_perms;
 allow test_create_no_t proc_t:lnk_file read;
 allow test_create_no_t self:dir r_dir_perms;

--=-+jLdNffm3u9zth710t3I--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
