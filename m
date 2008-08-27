Message-ID: <48B50A97.8050404@ak.jp.nec.com>
Date: Wed, 27 Aug 2008 17:04:39 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, paul.moore@hp.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: [LTP][PATCH 1/2] Replacement of deprecated interfaces
References: <487C7698.60503@ak.jp.nec.com>  <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>  <487D5A3D.6090801@ak.jp.nec.com>  <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>  <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>  <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>  <4897EB5A.1040404@ak.jp.nec.com>  <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>  <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com> <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil> <48B2A669.7040800@ak.jp.nec.com> <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org> <alpine.LRH.1.10.0808262046000.6838@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808262046000.6838@tundra.namei.org>
Content-Type: multipart/mixed;
 boundary="------------040408050007000907090909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040408050007000907090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Morris wrote:
> Could you also please add tests for this (at least one which should fail 
> and one which should succeed) to the Linux Test Project?
> 
> 
> - James

Policies stored in ltp/testcases/kernel/security/selinux-testsuite/refpolicy/
invokes massive deprecated interfaces on selinux-policy-3.5.4.

This patch fixes them according to the warning messages which encourage to
replace older ones.

BTW, I'm not happy with the test_policy.pp does not allow to invoke test
scripts from unconfined_t domain. Is it to be fixed?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------040408050007000907090909
Content-Type: text/x-patch;
 name="ltp-selinux-refpolicy-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ltp-selinux-refpolicy-fixes.patch"

Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te	(revision 2)
@@ -72,12 +72,12 @@
 # Allow all of these domains to be entered from user domains.
 # via a shell script in the test directory or by another program.
 miscfiles_domain_entry_test_files(ipcdomain)
-userdom_sysadm_entry_spec_domtrans_to(ipcdomain)
+sysadm_entry_spec_domtrans(ipcdomain)
 corecmd_bin_entry_type(ipcdomain)
-userdom_sysadm_bin_spec_domtrans_to(ipcdomain)
+sysadm_bin_spec_domtrans_to(ipcdomain)
 
 allow test_ipc_base_t self:sem create_sem_perms;
 allow test_ipc_base_t self:shm create_sem_perms;
 allow test_ipc_base_t self:shm lock;
 # ipcrm needs this... 
-userdom_search_generic_user_home_dirs(test_ipc_base_t)
+unprivuser_search_home_dirs(test_ipc_base_t)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te	(revision 2)
@@ -43,7 +43,6 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(fileopdomain)
-corecmd_exec_sbin(fileopdomain)
 domain_exec_all_entry_files(fileopdomain)
 libs_use_ld_so(fileopdomain)
 libs_use_shared_libs(fileopdomain)
@@ -52,13 +51,13 @@
 
 # Allow all of these domains to be entered from sysadm domain
 miscfiles_domain_entry_test_files(fileopdomain)
-userdom_sysadm_entry_spec_domtrans_to(fileopdomain)
+sysadm_entry_spec_domtrans(fileopdomain)
 
 corecmd_bin_entry_type(fileopdomain)
-userdom_sysadm_bin_spec_domtrans_to(fileopdomain)
+sysadm_bin_spec_domtrans_to(fileopdomain)
 
-corecmd_sbin_entry_type(fileopdomain)
-userdom_sysadm_sbin_spec_domtrans_to(fileopdomain)
+corecmd_bin_entry_type(fileopdomain)
+sysadm_bin_spec_domtrans_to(fileopdomain)
 
 allow fileop_t fileop_exec_t:file entrypoint;
 domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te	(revision 2)
@@ -19,8 +19,8 @@
 
 # Allow all of these domains to be entered from sysadm domain
 # via /sbin/sysctl.
-corecmd_sbin_entry_type(sysctldomain)
-userdom_sysadm_sbin_spec_domtrans_to(sysctldomain)
+corecmd_bin_entry_type(sysctldomain)
+sysadm_bin_spec_domtrans_to(sysctldomain)
 
 # Allow the first domain to perform sysctl operations.
 kernel_rw_all_sysctls(test_sysctl_t)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	(revision 2)
@@ -24,10 +24,10 @@
 typeattribute test_create_no_t test_create_d;
 
 allow test_create_no_t self:process ~fork;
-allow test_create_no_t proc_t:dir r_dir_perms;
+allow test_create_no_t proc_t:dir list_dir_perms;
 allow test_create_no_t proc_t:lnk_file read;
-allow test_create_no_t self:dir r_dir_perms;
-allow test_create_no_t self:notdevfile_class_set r_file_perms;
+allow test_create_no_t self:dir list_dir_perms;
+allow test_create_no_t self:notdevfile_class_set read_file_perms;
 
 libs_use_ld_so(test_create_no_t)
 libs_use_shared_libs(test_create_no_t)
@@ -35,14 +35,14 @@
 allow test_create_no_t self:process setexec;
 selinux_get_fs_mount(test_create_no_t)
 
-allow test_create_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
-allow test_create_no_t lib_t:lnk_file r_file_perms;
+allow test_create_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir list_dir_perms;
+allow test_create_no_t lib_t:lnk_file read_file_perms;
 allow test_create_no_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
-allow test_create_no_t locale_t:dir r_dir_perms;
-allow test_create_no_t locale_t:{ file lnk_file } r_file_perms;
+allow test_create_no_t locale_t:dir list_dir_perms;
+allow test_create_no_t locale_t:{ file lnk_file } read_file_perms;
 allow test_create_no_t privfd:fd use;
-userdom_use_sysadm_ptys(test_create_no_t)
-userdom_use_sysadm_ttys(test_create_no_t)
+sysadm_use_ptys(test_create_no_t)
+sysadm_use_ttys(test_create_no_t)
 
 # General rules for the test_create_d
 
@@ -50,4 +50,4 @@
 role sysadm_r types test_create_d;
 role system_r types test_create_d;
 miscfiles_domain_entry_test_files(test_create_d)
-userdom_sysadm_entry_spec_domtrans_to(test_create_d)
+sysadm_entry_spec_domtrans(test_create_d)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te	(revision 2)
@@ -35,7 +35,6 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(capabledomain)
-corecmd_exec_sbin(capabledomain)
 domain_exec_all_entry_files(capabledomain)
 files_exec_etc_files(capabledomain)
 libs_use_ld_so(capabledomain)
@@ -45,9 +44,9 @@
 
 # Allow test_file_t and bin_t to be entered from sysadm role
 miscfiles_domain_entry_test_files(capabledomain)
-userdom_sysadm_entry_spec_domtrans_to(capabledomain)
+sysadm_entry_spec_domtrans(capabledomain)
 corecmd_bin_entry_type(capabledomain)
-userdom_sysadm_bin_spec_domtrans_to(capabledomain)
+sysadm_bin_spec_domtrans_to(capabledomain)
 
 # Allow these domains to create a temporay file.
 allow capabledomain test_file_t:file { setattr rw_file_perms };
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te	(revision 2)
@@ -25,7 +25,6 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(setnicedomain)
-corecmd_exec_sbin(setnicedomain)
 domain_exec_all_entry_files(setnicedomain)
 files_exec_etc_files(setnicedomain)
 libs_use_ld_so(setnicedomain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te	(revision 2)
@@ -35,7 +35,7 @@
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(fdreceivedomain)
-userdom_sysadm_entry_spec_domtrans_to(fdreceivedomain)
+sysadm_entry_spec_domtrans(fdreceivedomain)
 
 # Grant the necessary permissions for the server domain.
 ## Create the Unix domain socket file.
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te	(revision 2)
@@ -69,5 +69,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_link_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_link_domain)
+sysadm_bin_spec_domtrans_to(test_link_domain)
 
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te	(revision 2)
@@ -43,7 +43,7 @@
 # Allow all of these domains to be entered from the sysadm domains,
 # via kill or a program in the test directory.
 miscfiles_domain_entry_test_files(killdomain)
-userdom_sysadm_entry_spec_domtrans_to(killdomain)
+sysadm_entry_spec_domtrans(killdomain)
 corecmd_bin_entry_type(killdomain)
-userdom_sysadm_bin_spec_domtrans_to(killdomain)
+sysadm_bin_spec_domtrans_to(killdomain)
 
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	(revision 2)
@@ -13,7 +13,7 @@
 
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
-userdom_use_sysadm_terms(testdomain)
+sysadm_use_terms(testdomain)
 
 # Allow the test domains to access the test directory and files
 # even if they are not root owned.
@@ -64,9 +64,9 @@
 	type null_device_t;
 	type zero_device_t;
 }
-allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir r_dir_perms;
-allow testdomain lib_t:{ file lnk_file } r_file_perms;
-allow testdomain etc_t:file r_file_perms;
+allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir list_dir_perms;
+allow testdomain lib_t:{ file lnk_file } read_file_perms;
+allow testdomain etc_t:file read_file_perms;
 allow testdomain { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
 miscfiles_read_localization(testdomain)
 domain_use_interactive_fds(testdomain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te	(revision 2)
@@ -32,4 +32,4 @@
 
 # Allow all of these domains to be entered from sysadm domain
 miscfiles_domain_entry_test_files(test_open_domain)
-userdom_sysadm_entry_spec_domtrans_to(test_open_domain)
+sysadm_entry_spec_domtrans(test_open_domain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te	(revision 2)
@@ -25,7 +25,7 @@
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_getsid_d)
-userdom_sysadm_entry_spec_domtrans_to(test_getsid_d)
+sysadm_entry_spec_domtrans(test_getsid_d)
 
 # Give test_getsid_yes_t the permission needed.
 allow test_getsid_yes_t test_getsid_target_t:process getsession;
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te	(revision 2)
@@ -37,7 +37,7 @@
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(inheritdomain)
-userdom_sysadm_entry_spec_domtrans_to(inheritdomain)
+sysadm_entry_spec_domtrans(inheritdomain)
 
 # Grant the necessary permissions for the parent domain.
 allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
@@ -61,4 +61,4 @@
 allow test_inherit_nowrite_t test_inherit_parent_t:fd use;
 allow test_inherit_nowrite_t test_inherit_parent_t:fifo_file rw_file_perms;
 allow test_inherit_nowrite_t test_inherit_parent_t:process sigchld;
-allow test_inherit_nowrite_t test_inherit_file_t:file r_file_perms;
+allow test_inherit_nowrite_t test_inherit_file_t:file read_file_perms;
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te	(revision 2)
@@ -25,7 +25,7 @@
 
 # Allow domain to be entered from the sysadm domain
 miscfiles_domain_entry_test_files(test_getpgid_d)
-userdom_sysadm_entry_spec_domtrans_to(test_getpgid_d)
+sysadm_entry_spec_domtrans(test_getpgid_d)
 
 # Give test_getpgid_yes_t the permission needed.
 allow test_getpgid_yes_t test_getpgid_target_t:process getpgid;
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te	(revision 2)
@@ -40,5 +40,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_relabel_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_relabel_domain)
+sysadm_bin_spec_domtrans_to(test_relabel_domain)
 
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te	(revision 2)
@@ -25,7 +25,7 @@
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(execsharedomain)
-userdom_sysadm_entry_spec_domtrans_to(execsharedomain)
+sysadm_entry_spec_domtrans(execsharedomain)
 
 # Grant the necessary permissions for the child domain.
 domain_entry_file_spec_domtrans(test_execshare_parent_t, test_execshare_child_t)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te	(revision 2)
@@ -25,7 +25,7 @@
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_getsched_d)
-userdom_sysadm_entry_spec_domtrans_to(test_getsched_d)
+sysadm_entry_spec_domtrans(test_getsched_d)
 
 # Give test_getsched_yes_t the permission needed.
 allow test_getsched_yes_t test_getsched_target_t:process getsched;
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te	(revision 2)
@@ -28,7 +28,7 @@
 
 # Allow test_files_t to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(dyntracedomain)
-userdom_sysadm_entry_spec_domtrans_to(dyntracedomain)
+sysadm_entry_spec_domtrans(dyntracedomain)
 miscfiles_exec_test_files(dyntracedomain)
 
 # Grant the necessary permissions for the child domain.
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te	(revision 2)
@@ -23,7 +23,6 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(ioctldomain)
-corecmd_exec_sbin(ioctldomain)
 domain_exec_all_entry_files(ioctldomain)
 files_exec_etc_files(ioctldomain)
 libs_use_ld_so(ioctldomain)
@@ -34,9 +33,9 @@
 # Allow all of these domains to be entered from sysadm domain
 # via a shell script in the test directory or by....
 miscfiles_domain_entry_test_files(ioctldomain)
-userdom_sysadm_entry_spec_domtrans_to(ioctldomain)
+sysadm_entry_spec_domtrans(ioctldomain)
 corecmd_bin_entry_type(ioctldomain)
-userdom_sysadm_bin_spec_domtrans_to(ioctldomain)
+sysadm_bin_spec_domtrans_to(ioctldomain)
 
 # Allow the test domains some access to the temp file
 allow test_ioctl_t test_ioctl_file_t:file { read getattr setattr ioctl };
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te	(revision 2)
@@ -17,5 +17,4 @@
 
 # Allow this domain to be entered via its entrypoint type.
 domain_entry_file(test_entrypoint_t, test_entrypoint_execute_t)
-userdom_sysadm_entry_spec_domtrans_to(test_entrypoint_t)
-
+sysadm_entry_spec_domtrans(test_entrypoint_t)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te	(revision 2)
@@ -27,7 +27,7 @@
 
 # Allow the tracer domain to trace the traced domain.
 allow test_ptrace_tracer_t test_ptrace_traced_t:process ptrace;
-userdom_search_generic_user_home_dirs(test_ptrace_traced_t)
+unprivuser_search_home_dirs(test_ptrace_traced_t)
 
 # Let the tracer wait on the traced domain.
 allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
@@ -35,4 +35,4 @@
 # Allow all of these domains to be entered from the sysadm domains.
 # via a program in the test directory.
 miscfiles_domain_entry_test_files(ptracedomain)
-userdom_sysadm_entry_spec_domtrans_to(ptracedomain)
+sysadm_entry_spec_domtrans(ptracedomain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te	(revision 2)
@@ -18,27 +18,28 @@
 typeattribute test_setpgid_no_t test_setpgid_d;
 
 allow test_setpgid_no_t self:process ~{ setpgid setcurrent };
-allow test_setpgid_no_t proc_t:dir r_dir_perms;
+allow test_setpgid_no_t proc_t:dir list_dir_perms;
 allow test_setpgid_no_t proc_t:lnk_file read;
-allow test_setpgid_no_t self:dir r_dir_perms;
-allow test_setpgid_no_t self:notdevfile_class_set r_file_perms;
+allow test_setpgid_no_t self:dir list_dir_perms;
+allow test_setpgid_no_t self:notdevfile_class_set read_file_perms;
 
 libs_use_ld_so(test_setpgid_no_t)
 libs_use_shared_libs(test_setpgid_no_t)
 allow test_setpgid_no_t self:process setexec;
 selinux_get_fs_mount(test_setpgid_no_t)
 
-allow test_setpgid_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
-allow test_setpgid_no_t lib_t:lnk_file r_file_perms;
+allow test_setpgid_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir list_dir_perms;
+allow test_setpgid_no_t lib_t:lnk_file read_file_perms;
 allow test_setpgid_no_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
-allow test_setpgid_no_t locale_t:dir r_dir_perms;
-allow test_setpgid_no_t locale_t:{ file lnk_file } r_file_perms;
+allow test_setpgid_no_t locale_t:dir list_dir_perms;
+allow test_setpgid_no_t locale_t:{ file lnk_file } read_file_perms;
 allow test_setpgid_no_t privfd:fd use;
-userdom_use_sysadm_ptys(test_setpgid_no_t)
-userdom_use_sysadm_ttys(test_setpgid_no_t)
+sysadm_use_ptys(test_setpgid_no_t)
+sysadm_use_ttys(test_setpgid_no_t)
 
 # Allow domain to be entered from the sysadm domain.
 role sysadm_r types test_setpgid_d;
 role system_r types test_setpgid_d;
 miscfiles_domain_entry_test_files(test_setpgid_d)
-userdom_sysadm_entry_spec_domtrans_to(test_setpgid_d)
+sysadm_entry_spec_domtrans(test_setpgid_d)
+userdom_entry_spec_domtrans_unpriv_users(test_setpgid_d)
\ No newline at end of file
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te	(revision 2)
@@ -26,7 +26,7 @@
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_setsched_d)
-userdom_sysadm_entry_spec_domtrans_to(test_setsched_d)
+sysadm_entry_spec_domtrans(test_setsched_d)
 
 # Allow these domains to execute renice.
 corecmd_bin_entry_type(test_setsched_d)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te	(revision 2)
@@ -27,5 +27,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_setattr_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_setattr_domain)
+sysadm_bin_spec_domtrans_to(test_setattr_domain)
 
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te	(revision 2)
@@ -30,4 +30,4 @@
 allow test_transition_todomain_t test_transition_fromdomain_t:fd use;
 
 # Allow all of these domains to be entered from the sysadm domain.
-userdom_sysadm_entry_spec_domtrans_to(transitiondomain)
+sysadm_entry_spec_domtrans(transitiondomain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	(revision 2)
@@ -28,7 +28,7 @@
 corenet_raw_sendrecv_all_nodes(capabledomain)
 corenet_tcp_sendrecv_all_ports(capabledomain)
 corenet_udp_sendrecv_all_ports(capabledomain)
-corenet_non_ipsec_sendrecv(capabledomain)
+corenet_all_recvfrom_unlabeled(capabledomain)
 corenet_tcp_bind_all_nodes(capabledomain)
 corenet_udp_bind_all_nodes(capabledomain)
 sysnet_read_config(capabledomain)
@@ -44,8 +44,8 @@
 allow capabledomain hi_reserved_port_t:tcp_socket name_bind;
 
 # Allow sbin_t to be entered from admin via certain utils.
-corecmd_sbin_entry_type(capabledomain)
-userdom_sysadm_sbin_spec_domtrans_to(capabledomain)
+corecmd_bin_entry_type(capabledomain)
+sysadm_bin_spec_domtrans_to(capabledomain)
 
 require {
 	type ifconfig_exec_t;
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te	(revision 2)
@@ -28,5 +28,4 @@
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(dyntransdomain)
-userdom_sysadm_entry_spec_domtrans_to(dyntransdomain)
-
+sysadm_entry_spec_domtrans(dyntransdomain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te	(revision 2)
@@ -28,7 +28,7 @@
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(exectracedomain)
-userdom_sysadm_entry_spec_domtrans_to(exectracedomain)
+sysadm_entry_spec_domtrans(exectracedomain)
 
 # Grant the necessary permissions for the child domain.
 domain_entry_file_spec_domtrans(test_exectrace_parent_t, test_exectrace_child_t)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te	(revision 2)
@@ -25,7 +25,7 @@
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(waitdomain)
-userdom_sysadm_entry_spec_domtrans_to(waitdomain)
+sysadm_entry_spec_domtrans(waitdomain)
 
 # Grant permissions for a domain transition from parent to child,
 # including the ability to wait on the child.
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te	(revision 2)
@@ -19,8 +19,8 @@
 
 # Allow this domain to be entered via the shell.
 corecmd_shell_entry_type(test_execute_notrans_t)
-userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
+sysadm_entry_spec_domtrans(test_execute_notrans_t)
 
 #Allow test_execute_notrans permissions to the allowed type
 can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
-allow test_execute_notrans_t test_execute_notrans_denied_t:file rx_file_perms;
+allow test_execute_notrans_t test_execute_notrans_denied_t:file { mmap_file_perms ioctl lock };
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te	(revision 2)
@@ -56,4 +56,4 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_mkdir_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_mkdir_domain)
+sysadm_bin_spec_domtrans_to(test_mkdir_domain)
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te	(revision 2)
@@ -103,5 +103,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_rename_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_rename_domain)
+sysadm_bin_spec_domtrans_to(test_rename_domain)
 

--------------040408050007000907090909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
