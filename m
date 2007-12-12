Subject: Re: [LTP] Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: subrata@linux.vnet.ibm.com
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@redhat.com>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        SE Linux <selinux@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        Robert Williamson <robbiew@us.ibm.com>, Paul Larson <plars@us.ibm.com>,
        Michael Reed <mreed10@us.ibm.com>
In-Reply-To: <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
	 <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
	 <20071211155219.GA22416@sergelap.austin.ibm.com>
	 <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="=-aGect/WSEO8kWvz+ErDB"
Date: Wed, 12 Dec 2007 11:30:42 -0500
Message-Id: <1197477042.1125.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aGect/WSEO8kWvz+ErDB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-12-12 at 16:47 +0530, Subrata Modak wrote:
> On Tue, 2007-12-11 at 09:52 -0600, Serge E. Hallyn wrote:
> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> > > On Mon, 2007-12-10 at 11:15 -0600, Serge E. Hallyn wrote:
> > > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > > On Mon, 2007-12-10 at 11:31 +0530, Subrata Modak wrote:
> > > > > > On Fri, 2007-12-07 at 21:55 +0530, Subrata Modak wrote:
> > > > > > > Hi All,
> > > > > > > 
> > > > > > > Today i had the opportunity to meet James Morris from Red Hat at FOSS.in
> > > > > > > held at Bangalore, India. After his talks on Se-Linux, we were
> > > > > > > discussing about the Policy Reference support for Se-linux available in
> > > > > > > LTP under the directory:
> > > > > > > ltp/testcases/kernel/security/selinux-testsuite/
> > > > > > > 
> > > > > > > Though i have released RHEL5 EAL4+ Certification Testsuites from IBM, i
> > > > > > > have not seen the testcases under:
> > > > > > > ltp/testcases/kernel/security/selinux-testsuite/
> > > > > > > updated for more than an year. I am not aware exactly about the reason
> > > > > > > for the same. I would like to request you send me any updates that you
> > > > > > > may want to give to LTP for your selinux-testsuite.
> > > > > > 
> > > > > > Can somebody give me some direction on this ??
> > > > > 
> > > > > What kind of direction are you seeking?
> > > > > 
> > > > > We gave the selinux testsuite to IBM at their request, and they ported
> > > > > it over to the LTP and submitted it there.  Joy Latten was involved in
> > > > > the porting; I've cc'd her above.
> > > 
> > > Well i have not received any selinux testcases updates for reference
> > > policy for the last 3 quarters. What i have received and released is  
> > > EAL4+ Certification Test Suite, which includes
> > > rhel5_ibm_eal4_cert_suite2.tgz. I drilled down in to this and tried to
> > > find whether there are any se-linux testcases included here, which are
> > > apparently present in ltp/testcases/kernel/security/selinux-testsuite/
> > > directory of ltp-full-20073011.tgz (can be downloaded from
> > > http://prdownloads.sourceforge.net/ltp/ltp-full-20071130.tgz?download).
> > > I did not find either of them. They seemed different to me. 
> > > 
> > > > 
> > > > So the question is who should update the testsuite.  This is not just an
> > > > issue for selinux, but for all the ltp tests.
> > > > 
> > > > One could say it's Joy because she submitted the testcases.  But let me
> > > > warn you that that attitude will definitely decrease the likelyhood of
> > > > testcases being submitted to LTP.  (It'll certainly deter me)
> > > > 
> > > > One could say it should be the selinux community in general, but that
> > > > community is too large for such an answer to be helpful, and it may not
> > > > be fair since they can say "we didn't submit that."
> > > > 
> > > > One could say it should be the reference policy maintainer, because I
> > > > suspect refpolicy updates will be the biggest cause of breakage - but
> > > > that isn't fair to him since again he didn't submit it.
> > > > 
> > > > One might say it should be the ltp community - after the biggest
> > > > advantage of submitting to LTP should be some free maintenance.  However
> > > > it likely doesn't have the needed expertise.
> > > 
> > > Ok. This is i would say as a collective responsibility rather than
> > > somebody?? alone. It is the responsibility of the maintainer (here LTP
> > > and hence myself) to find out the validity of test cases in his/her
> > > project he/she is maintaining, and, then try to contact the author(s) of
> > > that particular test case component to provide updates if even he/she
> > > (Author(s)) has the updates themselves. Now it is upto their (Author(s))
> > > interest to write back if they are interested. Else the Maintainer is
> > > helpless.
> > > I initiated this mail as i found it my responsibility to find out
> > > authors who actually wrote these reference policy test cases for
> > > se-linux, and which are part of LTP in
> > > ltp/testcases/kernel/security/selinux-testsuite/ directory. Now if the
> > > author(s) respond, then i would work hard to integrate the same.
> > > After interaction with James Morris at FOSS.in, Bangalore, India, i came
> > > to know that he is also working on se-linux and he mentioned about the
> > > presence of reference policy support in LTP. I pointed him the release
> > > that i made this year (EAL4+ Certification Test Suite) and also
> > > requested him whether he can update me on the se-linux reference policy
> > > test cases of se-linux available inside Main LTP, he pointed me to write
> > > to se-linux test suite mailing list. Hence this mail. 
> > 
> > Reasonable.  And it looks like the prod was needed.
> 
> So, can somebody now give me some updates for testcases in this
> Directory::
> http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/kernel/security/selinux-testsuite/,

Patch attached.

-- 
Stephen Smalley
National Security Agency

--=-aGect/WSEO8kWvz+ErDB
Content-Disposition: attachment; filename=ltp-selinux.diff
Content-Type: text/x-patch; name=ltp-selinux.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Apply some fixes to the selinux testsuite's test policy.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 kernel/security/selinux-testsuite/README                         |   10 +++-
 kernel/security/selinux-testsuite/refpolicy/test_capable_file.te |    2 
 kernel/security/selinux-testsuite/refpolicy/test_capable_net.te  |   22 +++++-----
 kernel/security/selinux-testsuite/refpolicy/test_file.te         |    6 +-
 kernel/security/selinux-testsuite/refpolicy/test_global.te       |   22 +++++++++-
 kernel/security/selinux-testsuite/refpolicy/test_ioctl.te        |    2 
 kernel/security/selinux-testsuite/refpolicy/test_readlink.te     |    6 ++
 kernel/security/selinux-testsuite/refpolicy/test_rxdir.te        |    6 ++
 kernel/security/selinux-testsuite/refpolicy/test_setnice.te      |    2 
 kernel/security/selinux-testsuite/refpolicy/test_stat.te         |    6 ++
 kernel/security/selinux-testsuite/refpolicy/test_sysctl.te       |    6 +-
 kernel/security/selinux-testsuite/refpolicy/test_task_create.te  |    4 -
 kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te |    2 
 13 files changed, 65 insertions(+), 31 deletions(-)

Index: testcases/kernel/security/selinux-testsuite/README
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/README,v
retrieving revision 1.2
diff -u -r1.2 README
--- testcases/kernel/security/selinux-testsuite/README	8 Nov 2005 16:49:33 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/README	12 Dec 2007 16:26:15 -0000
@@ -6,6 +6,10 @@
 such as getenforce are found. The test_selinux.sh script adds /usr/sbin
 to the PATH. 
 
+You must also add expand-check=0 to your /etc/selinux/semanage.conf file
+as the test policy will violate some of the neverallow rules in the
+base policy.
+
 There are two ways to run the SELinux testcases:
 	1. testsuite - all testcases
 	2. individual testcases
@@ -62,8 +66,8 @@
 Run Individual Testcases
 --------------------------
 First build the test policy manually. Do this by first changing 
-to the selinux-testsuite policy directory (cd to 
-$LTPROOT/testcases/kernel/security/selinux-testsuite/policy)
+to the selinux-testsuite refpolicy directory (cd to 
+$LTPROOT/testcases/kernel/security/selinux-testsuite/refpolicy)
 and build the policy by doing a, 
 	make load
 
@@ -88,7 +92,7 @@
 testcase directory of the testcase being debugged.	
 
 To remove the test policy and restore original policy,
-cd to selinux-testsuite/policy directory and execute,
+cd to selinux-testsuite/refpolicy directory and execute,
 	make cleanup
 
 Remember to remove test policy and restore original policy after
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te,v
retrieving revision 1.2
diff -u -r1.2 test_capable_file.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te	12 Dec 2007 16:26:15 -0000
@@ -35,7 +35,7 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(capabledomain)
-corecmd_exec_sbin(capabledomain)
+corecmd_exec_bin(capabledomain)
 domain_exec_all_entry_files(capabledomain)
 files_exec_etc_files(capabledomain)
 libs_use_ld_so(capabledomain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te,v
retrieving revision 1.2
diff -u -r1.2 test_capable_net.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	12 Dec 2007 16:26:15 -0000
@@ -32,21 +32,21 @@
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
 
-# Allow sbin_t to be entered from admin via certain utils.
-corecmd_sbin_entry_type(capabledomain)
-userdom_sysadm_sbin_spec_domtrans_to(capabledomain)
+# Allow bin_t to be entered from admin via certain utils.
+corecmd_bin_entry_type(capabledomain)
+userdom_sysadm_bin_spec_domtrans_to(capabledomain)
 
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
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te,v
retrieving revision 1.2
diff -u -r1.2 test_file.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te	12 Dec 2007 16:26:15 -0000
@@ -43,7 +43,7 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(fileopdomain)
-corecmd_exec_sbin(fileopdomain)
+corecmd_exec_bin(fileopdomain)
 domain_exec_all_entry_files(fileopdomain)
 libs_use_ld_so(fileopdomain)
 libs_use_shared_libs(fileopdomain)
@@ -57,8 +57,8 @@
 corecmd_bin_entry_type(fileopdomain)
 userdom_sysadm_bin_spec_domtrans_to(fileopdomain)
 
-corecmd_sbin_entry_type(fileopdomain)
-userdom_sysadm_sbin_spec_domtrans_to(fileopdomain)
+corecmd_bin_entry_type(fileopdomain)
+userdom_sysadm_bin_spec_domtrans_to(fileopdomain)
 
 allow fileop_t fileop_exec_t:file entrypoint;
 domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te,v
retrieving revision 1.2
diff -u -r1.2 test_global.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	24 Mar 2006 17:29:38 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	12 Dec 2007 16:26:15 -0000
@@ -11,6 +11,12 @@
 role sysadm_r types testdomain;
 role system_r types testdomain;
 
+allow sysadm_t test_file_t:dir_file_class_set *;
+allow testdomain sysadm_t:fd use;
+allow testdomain sysadm_t:process sigchld;
+
+allow testdomain self:process setfscreate;
+
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
 userdom_use_sysadm_terms(testdomain)
@@ -27,7 +33,7 @@
 miscfiles_read_test_files(testdomain)
 
 # Let the test domains set their current, exec and fscreate contexts.
-#allow testdomain self:process setcurrent;
+allow testdomain self:process setcurrent;
 # domain_dyntrans_type(testdomain)
 selinux_get_fs_mount(testdomain)
 allow testdomain self:process setexec;
@@ -51,7 +57,19 @@
 files_list_home(testdomain)
 dev_read_rand(testdomain)
 files_list_pids(testdomain)
-allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir r_dir_perms;
+require {
+	type root_t;
+	type etc_t;
+	type bin_t;
+	type bin_t;
+	type lib_t;
+	type usr_t;
+	type devpts_t;
+	type devtty_t;
+	type null_device_t;
+	type zero_device_t;
+}
+allow testdomain { root_t etc_t bin_t bin_t lib_t usr_t devpts_t }:dir r_dir_perms;
 allow testdomain lib_t:{ file lnk_file } r_file_perms;
 allow testdomain etc_t:file r_file_perms;
 allow testdomain { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te,v
retrieving revision 1.2
diff -u -r1.2 test_ioctl.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te	12 Dec 2007 16:26:15 -0000
@@ -23,7 +23,7 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(ioctldomain)
-corecmd_exec_sbin(ioctldomain)
+corecmd_exec_bin(ioctldomain)
 domain_exec_all_entry_files(ioctldomain)
 files_exec_etc_files(ioctldomain)
 libs_use_ld_so(ioctldomain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te,v
retrieving revision 1.1
diff -u -r1.1 test_readlink.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te	22 Mar 2006 21:30:29 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te	12 Dec 2007 16:26:15 -0000
@@ -29,4 +29,8 @@
 
 # TODO: Needs to be translated into refpolicy... how?
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+require {
+	type ls_exec_t;
+}
+domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+domain_entry_file(test_readlink_domain, ls_exec_t)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te,v
retrieving revision 1.1
diff -u -r1.1 test_rxdir.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te	22 Mar 2006 21:30:29 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te	12 Dec 2007 16:26:15 -0000
@@ -27,4 +27,8 @@
 
 # TODO: How to translate this into refpolicy????
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
+require {
+	type ls_exec_t;
+}
+domain_entry_file(test_rxdir_domain, ls_exec_t)
+domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te,v
retrieving revision 1.1
diff -u -r1.1 test_setnice.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te	22 Mar 2006 21:30:29 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te	12 Dec 2007 16:26:15 -0000
@@ -25,7 +25,7 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(setnicedomain)
-corecmd_exec_sbin(setnicedomain)
+corecmd_exec_bin(setnicedomain)
 domain_exec_all_entry_files(setnicedomain)
 files_exec_etc_files(setnicedomain)
 libs_use_ld_so(setnicedomain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te,v
retrieving revision 1.1
diff -u -r1.1 test_stat.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te	22 Mar 2006 21:30:29 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te	12 Dec 2007 16:26:15 -0000
@@ -24,4 +24,8 @@
 
 # TODO: what is a replacement for this in refpolicy???
 # Allow all of these domains to be entered from sysadm domain
-#domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+require {
+	type ls_exec_t;
+}
+domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+domain_entry_file(test_stat_domain, ls_exec_t)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te,v
retrieving revision 1.2
diff -u -r1.2 test_sysctl.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te	12 Dec 2007 16:26:15 -0000
@@ -18,9 +18,9 @@
 typeattribute test_nosysctl_t testdomain;
 
 # Allow all of these domains to be entered from sysadm domain
-# via /sbin/sysctl.
-corecmd_sbin_entry_type(sysctldomain)
-userdom_sysadm_sbin_spec_domtrans_to(sysctldomain)
+# via /bin/sysctl.
+corecmd_bin_entry_type(sysctldomain)
+userdom_sysadm_bin_spec_domtrans_to(sysctldomain)
 
 # Allow the first domain to perform sysctl operations.
 kernel_rw_all_sysctls(test_sysctl_t)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te,v
retrieving revision 1.2
diff -u -r1.2 test_task_create.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	12 Dec 2007 16:26:15 -0000
@@ -22,7 +22,7 @@
 # process_fork. Something needs to be done such that test_create_no_t
 # does not have fork permissions, but all the other necessary
 # "domain" permissions.
-#allow test_create_no_t self:process ~fork;
+allow test_create_no_t self:process ~fork;
 allow test_create_no_t proc_t:dir r_dir_perms;
 allow test_create_no_t proc_t:lnk_file read;
 allow test_create_no_t self:dir r_dir_perms;
@@ -34,7 +34,7 @@
 allow test_create_no_t self:process setexec;
 selinux_get_fs_mount(test_create_no_t)
 
-allow test_create_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
+allow test_create_no_t { root_t bin_t bin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
 allow test_create_no_t lib_t:lnk_file r_file_perms;
 allow test_create_no_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
 allow test_create_no_t locale_t:dir r_dir_perms;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te,v
retrieving revision 1.2
diff -u -r1.2 test_task_setpgid.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te	27 Mar 2006 16:55:48 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te	12 Dec 2007 16:26:15 -0000
@@ -28,7 +28,7 @@
 allow test_setpgid_no_t self:process setexec;
 selinux_get_fs_mount(test_setpgid_no_t)
 
-allow test_setpgid_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
+allow test_setpgid_no_t { root_t bin_t bin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
 allow test_setpgid_no_t lib_t:lnk_file r_file_perms;
 allow test_setpgid_no_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
 allow test_setpgid_no_t locale_t:dir r_dir_perms;

--=-aGect/WSEO8kWvz+ErDB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
