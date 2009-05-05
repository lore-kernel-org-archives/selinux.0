Subject: [PATCH] Update ltp selinux test script and policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ltp-list <ltp-list@lists.sf.net>,
        Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-BsR1EAb3evNNPN68gvql"
Date: Tue, 05 May 2009 10:10:14 -0400
Message-Id: <1241532614.3023.320.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BsR1EAb3evNNPN68gvql
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Note:  This does not obsolete or replace the other two patches I have
posted (Fix LTPBIN definition in selinux_file.sh, Fix MLS handling in
selinux tests), but rather should be applied on top of them.

Attached is a patch and a tar file to update the ltp selinux test script
and policy so that we no longer conditionally patch the test policy when
we run the test script.  The patch does the following:
- Disable patching of the policy in the test script.
- Change the refpolicy Makefile to redirect to a rhel/N/ subdirectory if
running on a redhat release and move the rhel-specific definitions
there.
- Change the refpolicy Makefile to only include test_bounds.te if the
checkpolicy supports policy.24 (and thus typebounds statements).
- Merge the sbin_deprecated.patch into the test policy.
- Further update the test policy to build cleanly on f11, while
preserving backward compatibility on f10.
- Added open permissions as necessary to the test policy (enabled in
f11).
- Update the ioctl test policy to reflect the updated
selinux_file_ioctl() logic in the kernel.
- Added a missing permission to the wait test policy that was causing it
to wrongly report PASS.

The tar file contains a new
testcases/kernel/security/selinux-testsuite/refpolicy/redhat/5
subdirectory to preserve a legacy copy of the test policy that works on
redhat 5.  The top-level refpolicy Makefile will redirect to this
subdirectory when it detects redhat 5.  Similar subdirectories can be
added for other stable releases going forward as needed.

Subrata, please cvs add the new subdirectory and its files.  Also,
please cvs remove the following:
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.te
(generated file, should not be in the repository)
ltp/testcases/kernel/security/selinux-testsuite/misc/*

Thanks.

-- 
Stephen Smalley
National Security Agency

--=-BsR1EAb3evNNPN68gvql
Content-Disposition: attachment; filename="ltp-selinux-policy.diff"
Content-Type: text/x-patch; name="ltp-selinux-policy.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Index: testscripts/test_selinux.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/testscripts/test_selinux.sh,v
retrieving revision 1.11
diff -u -r1.11 test_selinux.sh
--- testscripts/test_selinux.sh	11 Jul 2008 07:08:55 -0000	1.11
+++ testscripts/test_selinux.sh	5 May 2009 13:47:43 -0000
@@ -83,11 +83,6 @@
     POLICYDIR="$LTPROOT/testcases/kernel/security/selinux-testsuite/policy"
 fi
 
-# Update test policy if needed
-pushd $LTPROOT/testcases/kernel/security/selinux-testsuite/misc
-sh ./update_refpolicy.sh
-popd
-
 config_set_expandcheck
 
 config_allow_domain_fd_use 0
Index: testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	8 Jan 2009 08:51:38 -0000	1.5
+++ testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	5 May 2009 13:47:43 -0000
@@ -1,8 +1,11 @@
 REDHAT_RELEASE=$(shell rpm -q redhat-release)
+REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-")
 POLICYDEVEL = /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
+CHECKPOLICY = /usr/bin/checkpolicy
+VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
 
-TARGETS=test_global.te test_bounds.te test_capable_file.te test_capable_net.te \
+TARGETS=test_global.te test_capable_file.te test_capable_net.te \
 test_capable_sys.te test_dyntrace.te test_dyntrans.te test_entrypoint.te \
 test_execshare.te test_exectrace.te test_execute_no_trans.te \
 test_fdreceive.te test_file.te test_inherit.te test_ioctl.te test_ipc.te \
@@ -12,31 +15,15 @@
 test_task_getpgid.te test_task_getsched.te test_task_getsid.te \
 test_task_setpgid.te test_task_setsched.te test_transition.te test_wait.te 
 
-ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
-    TARGETS=test_global.te test_capable_file.te test_capable_net.te \
-    test_capable_sys.te test_entrypoint.te \
-    test_execshare.te test_exectrace.te test_execute_no_trans.te \
-    test_fdreceive.te test_file.te test_inherit.te test_ioctl.te test_ipc.te \
-    test_link.te test_mkdir.te test_open.te test_ptrace.te test_readlink.te \
-    test_relabel.te test_rename.te test_rxdir.te test_setattr.te test_setnice.te \
-    test_sigkill.te test_stat.te test_sysctl.te test_task_create.te \
-    test_task_getpgid.te test_task_getsched.te test_task_getsid.te \
-    test_task_setpgid.te test_task_setsched.te test_transition.te test_wait.te 
-endif
 
-ifeq (redhat-release-5, $(findstring redhat-release-5, $(REDHAT_RELEASE)))
-    TARGETS=test_global.te test_capable_file.te test_capable_net.te \
-    test_capable_sys.te test_dyntrace.te test_dyntrans.te test_entrypoint.te \
-    test_execshare.te test_exectrace.te test_execute_no_trans.te \
-    test_fdreceive.te test_file.te test_inherit.te test_ioctl.te test_ipc.te \
-    test_link.te test_mkdir.te test_open.te test_ptrace.te test_readlink.te \
-    test_relabel.te test_rename.te test_rxdir.te test_setattr.te test_setnice.te \
-    test_sigkill.te test_stat.te test_sysctl.te test_task_create.te \
-    test_task_getpgid.te test_task_getsched.te test_task_getsid.te \
-    test_task_setpgid.te test_task_setsched.te test_transition.te test_wait.te 
+ifeq ($(VERS),24)
+TARGETS+= test_bounds.te
 endif
 
 load:
+ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
+	$(MAKE) -C redhat/$(REDHAT_VERS)
+else
 	@if [ -d $(POLICYDEVEL) ]; then \
 		set -e; rm -f test_policy.te; for i in $(TARGETS); do cat $$i >> test_policy.te; done; \
 		cp test_policy.* $(POLICYDEVEL); \
@@ -45,6 +32,7 @@
 	else \
 		echo "ERROR: You must have selinux-policy-devel installed."; \
 	fi
+endif
 	
 cleanup:
 	$(SEMODULE) -r test_policy
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te,v
retrieving revision 1.6
diff -u -r1.6 test_capable_file.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te	5 May 2009 13:47:43 -0000
@@ -14,28 +14,31 @@
 typeattribute test_fcap_t capabledomain;
 typeattribute test_fcap_t testdomain;
 domain_type(test_fcap_t)
+unconfined_runs_test(test_fcap_t)
 
 # Domain for processes that have restricted capability
 type test_resfcap_t;
 typeattribute test_resfcap_t capabledomain;
 typeattribute test_resfcap_t testdomain;
 domain_type(test_resfcap_t)
+unconfined_runs_test(test_resfcap_t)
 
 # Another domain for processes that have restricted capability
 type test_res2fcap_t;
 typeattribute test_res2fcap_t capabledomain;
 typeattribute test_res2fcap_t testdomain;
 domain_type(test_res2fcap_t)
+unconfined_runs_test(test_res2fcap_t)
 
 # Domain for process that has no capability
 type test_nofcap_t;
 typeattribute test_nofcap_t capabledomain;
 typeattribute test_nofcap_t testdomain;
 domain_type(test_nofcap_t)
+unconfined_runs_test(test_nofcap_t)
 
 # Allow execution of helper programs.
 corecmd_exec_bin(capabledomain)
-corecmd_exec_sbin(capabledomain)
 domain_exec_all_entry_files(capabledomain)
 files_exec_etc_files(capabledomain)
 libs_use_ld_so(capabledomain)
@@ -47,7 +50,7 @@
 miscfiles_domain_entry_test_files(capabledomain)
 userdom_sysadm_entry_spec_domtrans_to(capabledomain)
 corecmd_bin_entry_type(capabledomain)
-userdom_sysadm_bin_spec_domtrans_to(capabledomain)
+sysadm_bin_spec_domtrans_to(capabledomain)
 
 # Allow these domains to create a temporay file.
 allow capabledomain test_file_t:file { setattr rw_file_perms };
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te,v
retrieving revision 1.6
diff -u -r1.6 test_capable_net.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te	5 May 2009 13:47:43 -0000
@@ -7,12 +7,14 @@
 # Type for process that is allowed certain capabilities
 type test_ncap_t;
 domain_type(test_ncap_t)
+unconfined_runs_test(test_ncap_t)
 typeattribute test_ncap_t capabledomain;
 typeattribute test_ncap_t testdomain;
 
 # Type for process that has restricted capability
 type test_resncap_t;
 domain_type(test_resncap_t)
+unconfined_runs_test(test_resncap_t)
 typeattribute test_resncap_t capabledomain;
 typeattribute test_resncap_t testdomain;
 
@@ -28,7 +30,7 @@
 corenet_raw_sendrecv_all_nodes(capabledomain)
 corenet_tcp_sendrecv_all_ports(capabledomain)
 corenet_udp_sendrecv_all_ports(capabledomain)
-corenet_non_ipsec_sendrecv(capabledomain)
+corenet_all_recvfrom_unlabeled(capabledomain)
 corenet_tcp_bind_all_nodes(capabledomain)
 corenet_udp_bind_all_nodes(capabledomain)
 sysnet_read_config(capabledomain)
@@ -44,8 +46,8 @@
 allow capabledomain hi_reserved_port_t:tcp_socket name_bind;
 
 # Allow sbin_t to be entered from admin via certain utils.
-corecmd_sbin_entry_type(capabledomain)
-userdom_sysadm_sbin_spec_domtrans_to(capabledomain)
+corecmd_bin_entry_type(capabledomain)
+sysadm_bin_spec_domtrans_to(capabledomain)
 
 require {
 	type ifconfig_exec_t;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_sys.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_sys.te,v
retrieving revision 1.1
diff -u -r1.1 test_capable_sys.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_sys.te	22 Mar 2006 21:30:29 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_sys.te	5 May 2009 13:47:43 -0000
@@ -7,12 +7,14 @@
 # Type for process that is allowed certain capabilities
 type test_scap_t;
 domain_type(test_scap_t)
+unconfined_runs_test(test_scap_t)
 typeattribute test_scap_t capabledomain;
 typeattribute test_scap_t testdomain;
 
 # Domain for process that has no capability
 type test_noscap_t;
 domain_type(test_noscap_t)
+unconfined_runs_test(test_noscap_t)
 typeattribute test_noscap_t capabledomain;
 typeattribute test_noscap_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te,v
retrieving revision 1.4
diff -u -r1.4 test_dyntrace.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrace.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,8 @@
 # Domain for parent process.
 type test_dyntrace_parent_t;
 domain_type(test_dyntrace_parent_t)
+unconfined_runs_test(test_dyntrace_parent_t)
+domain_dyntrans_type(test_dyntrace_parent_t)
 typeattribute test_dyntrace_parent_t dyntracedomain;
 typeattribute test_dyntrace_parent_t testdomain;
 allow test_dyntrace_parent_t self:process ptrace;
@@ -16,6 +18,7 @@
 # dynamic trans by the parent.
 type test_dyntrace_child_t;
 domain_type(test_dyntrace_child_t)
+unconfined_runs_test(test_dyntrace_child_t)
 typeattribute test_dyntrace_child_t dyntracedomain;
 typeattribute test_dyntrace_child_t testdomain;
 
@@ -23,6 +26,7 @@
 # dynamic transition by the parent.
 type test_dyntrace_notchild_t;
 domain_type(test_dyntrace_notchild_t) 
+unconfined_runs_test(test_dyntrace_notchild_t)
 typeattribute test_dyntrace_notchild_t dyntracedomain;
 typeattribute test_dyntrace_notchild_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te,v
retrieving revision 1.4
diff -u -r1.4 test_dyntrans.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_dyntrans.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,22 @@
 # Domain for process that is allowed to transition to the new domain.
 type test_dyntrans_fromdomain_t;
 domain_type(test_dyntrans_fromdomain_t)
+unconfined_runs_test(test_dyntrans_fromdomain_t)
+domain_dyntrans_type(test_dyntrans_fromdomain_t)
 typeattribute test_dyntrans_fromdomain_t dyntransdomain;
 typeattribute test_dyntrans_fromdomain_t testdomain;
 
 # Domain for process that is not allowed to transition to the new domain.
 type test_dyntrans_notfromdomain_t;
 domain_type(test_dyntrans_notfromdomain_t)
+unconfined_runs_test(test_dyntrans_notfromdomain_t)
 typeattribute test_dyntrans_notfromdomain_t dyntransdomain;
 typeattribute test_dyntrans_notfromdomain_t testdomain;
 
 # Allow the fromdomain to dyntrans to the new domain.
 type test_dyntrans_todomain_t;
 domain_type(test_dyntrans_todomain_t)
+unconfined_runs_test(test_dyntrans_todomain_t)
 typeattribute test_dyntrans_todomain_t dyntransdomain;
 typeattribute test_dyntrans_todomain_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te,v
retrieving revision 1.4
diff -u -r1.4 test_entrypoint.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_entrypoint.te	5 May 2009 13:47:43 -0000
@@ -10,6 +10,7 @@
 # Test domain that can only be entered via the type above.
 type test_entrypoint_t;
 domain_type(test_entrypoint_t)
+unconfined_runs_test(test_entrypoint_t)
 typeattribute test_entrypoint_t testdomain;
 
 # Allow execution of true.
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te,v
retrieving revision 1.4
diff -u -r1.4 test_execshare.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_execshare.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,21 @@
 # Domain for parent process.
 type test_execshare_parent_t;
 domain_type(test_execshare_parent_t)
+unconfined_runs_test(test_execshare_parent_t)
 typeattribute test_execshare_parent_t execsharedomain;
 typeattribute test_execshare_parent_t testdomain;
 
 # Domain for child process that can share state with the parent across exec.
 type test_execshare_child_t;
 domain_type(test_execshare_child_t)
+unconfined_runs_test(test_execshare_child_t)
 typeattribute test_execshare_child_t execsharedomain;
 typeattribute test_execshare_child_t testdomain;
 
 # Domain for child process that cannot share state with the parent across exec.
 type test_execshare_notchild_t;
 domain_type(test_execshare_notchild_t);
+unconfined_runs_test(test_execshare_notchild_t)
 typeattribute test_execshare_notchild_t execsharedomain;
 typeattribute test_execshare_notchild_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te,v
retrieving revision 1.4
diff -u -r1.4 test_exectrace.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_exectrace.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Domain for parent process.
 type test_exectrace_parent_t;
 domain_type(test_exectrace_parent_t)
+unconfined_runs_test(test_exectrace_parent_t)
 typeattribute test_exectrace_parent_t exectracedomain;
 typeattribute test_exectrace_parent_t testdomain;
 
@@ -17,12 +18,14 @@
 # Domain for child process that can be traced across an exec by the parent.
 type test_exectrace_child_t;
 domain_type(test_exectrace_child_t)
+unconfined_runs_test(test_exectrace_child_t)
 typeattribute test_exectrace_child_t exectracedomain;
 typeattribute test_exectrace_child_t testdomain;
 
 # Domain for child process that cannot be traced across an exec by the parent.
 type test_exectrace_notchild_t;
 domain_type(test_exectrace_notchild_t)
+unconfined_runs_test(test_exectrace_notchild_t)
 typeattribute test_exectrace_notchild_t exectracedomain;
 typeattribute test_exectrace_notchild_t testdomain;
 
@@ -38,7 +41,7 @@
 allow test_exectrace_child_t test_exectrace_parent_t:process sigchld;
 allow test_exectrace_parent_t test_exectrace_child_t:process { ptrace getattr };
 allow test_exectrace_parent_t test_exectrace_child_t:dir search;
-allow test_exectrace_parent_t test_exectrace_child_t:file read;
+allow test_exectrace_parent_t test_exectrace_child_t:file read_file_perms;
 
 # Grant the notchild domain all the same permissions except for ptrace.
 domain_entry_file_spec_domtrans(test_exectrace_parent_t, test_exectrace_notchild_t)
@@ -48,4 +51,4 @@
 allow test_exectrace_notchild_t test_exectrace_parent_t:process sigchld;
 allow test_exectrace_parent_t test_exectrace_notchild_t:process getattr;
 allow test_exectrace_parent_t test_exectrace_notchild_t:dir search;
-allow test_exectrace_parent_t test_exectrace_notchild_t:file read;
+allow test_exectrace_parent_t test_exectrace_notchild_t:file read_file_perms;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te,v
retrieving revision 1.4
diff -u -r1.4 test_execute_no_trans.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_execute_no_trans.te	5 May 2009 13:47:43 -0000
@@ -15,6 +15,7 @@
 # Test domain that can only be entered via the types above.
 type test_execute_notrans_t;
 domain_type(test_execute_notrans_t);
+unconfined_runs_test(test_execute_notrans_t)
 typeattribute test_execute_notrans_t testdomain;
 
 # Allow this domain to be entered via the shell.
@@ -23,4 +24,4 @@
 
 #Allow test_execute_notrans permissions to the allowed type
 can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
-allow test_execute_notrans_t test_execute_notrans_denied_t:file rx_file_perms;
+allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te,v
retrieving revision 1.5
diff -u -r1.5 test_fdreceive.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te	30 Apr 2009 10:20:37 -0000	1.5
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_fdreceive.te	5 May 2009 13:47:43 -0000
@@ -16,12 +16,14 @@
 # Domain for client process.
 type test_fdreceive_client_t;
 domain_type(test_fdreceive_client_t)
+unconfined_runs_test(test_fdreceive_client_t)
 typeattribute test_fdreceive_client_t fdreceivedomain;
 typeattribute test_fdreceive_client_t testdomain;
 
 # Domain for second client process.
 type test_fdreceive_client2_t;
 domain_type(test_fdreceive_client2_t)
+unconfined_runs_test(test_fdreceive_client2_t)
 typeattribute test_fdreceive_client2_t fdreceivedomain;
 typeattribute test_fdreceive_client2_t testdomain;
 
@@ -30,6 +32,7 @@
 # Can access test file, not second test file.
 type test_fdreceive_server_t;
 domain_type(test_fdreceive_server_t);
+unconfined_runs_test(test_fdreceive_server_t)
 typeattribute test_fdreceive_server_t fdreceivedomain;
 typeattribute test_fdreceive_server_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te,v
retrieving revision 1.6
diff -u -r1.6 test_file.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Domain for process that is allowed to perform operations.
 type test_fileop_t;
 domain_type(test_fileop_t)
+unconfined_runs_test(test_fileop_t)
 domain_obj_id_change_exemption(test_fileop_t)
 typeattribute test_fileop_t fileopdomain;
 typeattribute test_fileop_t testdomain;
@@ -15,6 +16,7 @@
 # Domain for process that is not allowed to perform all operations.
 type test_nofileop_t;
 domain_type(test_nofileop_t)
+unconfined_runs_test(test_nofileop_t)
 domain_obj_id_change_exemption(test_nofileop_t)
 typeattribute test_nofileop_t fileopdomain;
 typeattribute test_nofileop_t testdomain;
@@ -30,6 +32,7 @@
 # Domain for running certain executables
 type fileop_t;
 domain_type(fileop_t)
+unconfined_runs_test(fileop_t)
 typeattribute fileop_t fileopdomain;
 typeattribute fileop_t testdomain;
 
@@ -43,7 +46,6 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(fileopdomain)
-corecmd_exec_sbin(fileopdomain)
 domain_exec_all_entry_files(fileopdomain)
 libs_use_ld_so(fileopdomain)
 libs_use_shared_libs(fileopdomain)
@@ -55,10 +57,7 @@
 userdom_sysadm_entry_spec_domtrans_to(fileopdomain)
 
 corecmd_bin_entry_type(fileopdomain)
-userdom_sysadm_bin_spec_domtrans_to(fileopdomain)
-
-corecmd_sbin_entry_type(fileopdomain)
-userdom_sysadm_sbin_spec_domtrans_to(fileopdomain)
+sysadm_bin_spec_domtrans_to(fileopdomain)
 
 allow fileop_t fileop_exec_t:file entrypoint;
 domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
@@ -79,6 +78,6 @@
 allow test_fileop_t fileop_t:process { signal };
 
 # Permissions for the 'bad' domain...
-allow test_nofileop_t nofileop_rw_file_t:file { read write append relabelfrom };
-allow test_nofileop_t nofileop_ra_file_t:file { read append };
+allow test_nofileop_t nofileop_rw_file_t:file { open read write append relabelfrom };
+allow test_nofileop_t nofileop_ra_file_t:file { open read append };
 allow test_nofileop_t fileop_file_t:file { relabelto };
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te,v
retrieving revision 1.9
diff -u -r1.9 test_global.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	30 Apr 2009 10:20:37 -0000	1.9
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te	5 May 2009 13:47:43 -0000
@@ -13,7 +13,7 @@
 
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
-userdom_use_sysadm_terms(testdomain)
+term_use_all_terms(testdomain)
 
 # Allow the test domains to access the test directory and files
 # even if they are not root owned.
@@ -64,9 +64,10 @@
 	type null_device_t;
 	type zero_device_t;
 }
-allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir r_dir_perms;
-allow testdomain lib_t:{ file lnk_file } r_file_perms;
-allow testdomain etc_t:file r_file_perms;
+allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir list_dir_perms;
+allow testdomain lib_t:file read_file_perms;
+allow testdomain lib_t:lnk_file read;
+allow testdomain etc_t:file read_file_perms;
 allow testdomain { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
 miscfiles_read_localization(testdomain)
 domain_use_interactive_fds(testdomain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te,v
retrieving revision 1.4
diff -u -r1.4 test_inherit.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_inherit.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Domain for parent process.
 type test_inherit_parent_t;
 domain_type(test_inherit_parent_t)
+unconfined_runs_test(test_inherit_parent_t)
 typeattribute test_inherit_parent_t inheritdomain;
 typeattribute test_inherit_parent_t testdomain;
 
@@ -18,6 +19,7 @@
 # Domain for child process that can inherit r/w fd to test file from parent.
 type test_inherit_child_t;
 domain_type(test_inherit_child_t)
+unconfined_runs_test(test_inherit_child_t)
 typeattribute test_inherit_child_t inheritdomain;
 typeattribute test_inherit_child_t testdomain;
 
@@ -25,6 +27,7 @@
 # of fd use permission.
 type test_inherit_nouse_t;
 domain_type(test_inherit_nouse_t)
+unconfined_runs_test(test_inherit_nouse_t)
 typeattribute test_inherit_nouse_t inheritdomain;
 typeattribute test_inherit_nouse_t testdomain;
 
@@ -32,6 +35,7 @@
 # due to lack of file write permission.
 type test_inherit_nowrite_t;
 domain_type(test_inherit_nowrite_t)
+unconfined_runs_test(test_inherit_nowrite_t)
 typeattribute test_inherit_nowrite_t inheritdomain;
 typeattribute test_inherit_nowrite_t testdomain;
 
@@ -61,4 +65,4 @@
 allow test_inherit_nowrite_t test_inherit_parent_t:fd use;
 allow test_inherit_nowrite_t test_inherit_parent_t:fifo_file rw_file_perms;
 allow test_inherit_nowrite_t test_inherit_parent_t:process sigchld;
-allow test_inherit_nowrite_t test_inherit_file_t:file r_file_perms;
+allow test_inherit_nowrite_t test_inherit_file_t:file read_file_perms;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te,v
retrieving revision 1.6
diff -u -r1.6 test_ioctl.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te	5 May 2009 13:47:43 -0000
@@ -8,12 +8,14 @@
 # Domain for process that is allowed to perform ioctl.
 type test_ioctl_t;
 domain_type(test_ioctl_t)
+unconfined_runs_test(test_ioctl_t)
 typeattribute test_ioctl_t ioctldomain;
 typeattribute test_ioctl_t testdomain;
 
 # Domain for process that is not allowed to perform ioctl.
 type test_noioctl_t;
 domain_type(test_noioctl_t)
+unconfined_runs_test(test_noioctl_t)
 typeattribute test_noioctl_t ioctldomain;
 typeattribute test_noioctl_t testdomain;
 
@@ -23,7 +25,6 @@
 
 # Allow execution of helper programs.
 corecmd_exec_bin(ioctldomain)
-corecmd_exec_sbin(ioctldomain)
 domain_exec_all_entry_files(ioctldomain)
 files_exec_etc_files(ioctldomain)
 libs_use_ld_so(ioctldomain)
@@ -36,9 +37,9 @@
 miscfiles_domain_entry_test_files(ioctldomain)
 userdom_sysadm_entry_spec_domtrans_to(ioctldomain)
 corecmd_bin_entry_type(ioctldomain)
-userdom_sysadm_bin_spec_domtrans_to(ioctldomain)
+sysadm_bin_spec_domtrans_to(ioctldomain)
 
 # Allow the test domains some access to the temp file
-allow test_ioctl_t test_ioctl_file_t:file { read getattr setattr ioctl };
-allow test_noioctl_t test_ioctl_file_t:file { read };
+allow test_ioctl_t test_ioctl_file_t:file { open read write ioctl };
+allow test_noioctl_t test_ioctl_file_t:file { open read };
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te,v
retrieving revision 1.5
diff -u -r1.5 test_ipc.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te	30 Apr 2009 10:20:37 -0000	1.5
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_ipc.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Base domain for IPC tests, has all IPC permissions 
 type test_ipc_base_t;
 domain_type(test_ipc_base_t)
+unconfined_runs_test(test_ipc_base_t)
 typeattribute test_ipc_base_t ipcdomain;
 typeattribute test_ipc_base_t testdomain;
 allow test_ipc_base_t self:msgq create;
@@ -15,18 +16,21 @@
 # Domain that has read only access to IPC resources
 type test_ipc_read_t;
 domain_type(test_ipc_read_t)
+unconfined_runs_test(test_ipc_read_t)
 typeattribute test_ipc_read_t ipcdomain;
 typeattribute test_ipc_read_t testdomain;
 
 # Domain that can't create, associate, control, or use IPC resources
 type test_ipc_none_t;
 domain_type(test_ipc_none_t)
+unconfined_runs_test(test_ipc_none_t)
 typeattribute test_ipc_none_t ipcdomain;
 typeattribute test_ipc_none_t testdomain;
 
 # Domain that can associate, but not do anything else
 type test_ipc_associate_t;
 domain_type(test_ipc_associate_t)
+unconfined_runs_test(test_ipc_associate_t)
 typeattribute test_ipc_associate_t ipcdomain;
 typeattribute test_ipc_associate_t testdomain;
 
@@ -74,7 +78,7 @@
 miscfiles_domain_entry_test_files(ipcdomain)
 userdom_sysadm_entry_spec_domtrans_to(ipcdomain)
 corecmd_bin_entry_type(ipcdomain)
-userdom_sysadm_bin_spec_domtrans_to(ipcdomain)
+sysadm_bin_spec_domtrans_to(ipcdomain)
 
 allow test_ipc_base_t self:sem create_sem_perms;
 allow test_ipc_base_t self:shm create_sem_perms;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te,v
retrieving revision 1.4
diff -u -r1.4 test_link.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_link.te	5 May 2009 13:47:43 -0000
@@ -16,6 +16,7 @@
 # Domain for process that can create hard links to the file.
 type test_link_t;
 domain_type(test_link_t)
+unconfined_runs_test(test_link_t)
 typeattribute test_link_t test_link_domain;
 typeattribute test_link_t testdomain;
 
@@ -26,6 +27,7 @@
 # because it lacks link permission to the file.
 type test_nolink_t;
 domain_type(test_nolink_t)
+unconfined_runs_test(test_nolink_t)
 typeattribute test_nolink_t test_link_domain;
 typeattribute test_nolink_t testdomain;
 allow test_nolink_t test_link_dir_t:dir { search getattr write add_name };
@@ -36,6 +38,7 @@
 # the directory.
 type test_nolink2_t;
 domain_type(test_nolink2_t)
+unconfined_runs_test(test_nolink2_t)
 typeattribute test_nolink2_t test_link_domain;
 typeattribute test_nolink2_t testdomain;
 allow test_nolink2_t test_link_dir_t:dir { search getattr write };
@@ -44,6 +47,7 @@
 # Domain for process that can remove hard links to the file.
 type test_unlink_t;
 domain_type(test_unlink_t)
+unconfined_runs_test(test_unlink_t)
 typeattribute test_unlink_t test_link_domain;
 typeattribute test_unlink_t testdomain;
 allow test_unlink_t test_link_dir_t:dir { search getattr write remove_name };
@@ -53,6 +57,7 @@
 # because it lacks unlink permission to the file.
 type test_nounlink_t;
 domain_type(test_nounlink_t)
+unconfined_runs_test(test_nounlink_t)
 typeattribute test_nounlink_t test_link_domain;
 typeattribute test_nounlink_t testdomain;
 allow test_nounlink_t test_link_dir_t:dir { search getattr write remove_name };
@@ -62,6 +67,7 @@
 # the test directory because it lacks remove_name permission to the directory.
 type test_nounlink2_t;
 domain_type(test_nounlink2_t)
+unconfined_runs_test(test_nounlink2_t)
 typeattribute test_nounlink2_t test_link_domain;
 typeattribute test_nounlink2_t testdomain;
 allow test_nounlink2_t test_link_dir_t:dir { search getattr write };
@@ -69,5 +75,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_link_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_link_domain)
+sysadm_bin_spec_domtrans_to(test_link_domain)
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te,v
retrieving revision 1.4
diff -u -r1.4 test_mkdir.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_mkdir.te	5 May 2009 13:47:43 -0000
@@ -12,6 +12,7 @@
 # Domain for process that has add_name permission to the test directory.
 type test_addname_t;
 domain_type(test_addname_t)
+unconfined_runs_test(test_addname_t)
 typeattribute test_addname_t test_mkdir_domain;
 typeattribute test_addname_t testdomain;
 allow test_addname_t test_mkdir_dir_t:dir { search getattr write add_name create };
@@ -19,6 +20,7 @@
 # Domain for process that lacks add_name permission to the test directory.
 type test_noaddname_t;
 domain_type(test_noaddname_t)
+unconfined_runs_test(test_noaddname_t)
 typeattribute test_noaddname_t test_mkdir_domain;
 typeattribute test_noaddname_t testdomain;
 allow test_noaddname_t test_mkdir_dir_t:dir { search getattr write create };
@@ -26,6 +28,7 @@
 # Domain for process that lacks search permission to the test directory.
 type test_nosearch_t;
 domain_type(test_nosearch_t)
+unconfined_runs_test(test_nosearch_t)
 typeattribute test_nosearch_t test_mkdir_domain;
 typeattribute test_nosearch_t testdomain;
 allow test_nosearch_t test_mkdir_dir_t:dir { getattr write add_name create };
@@ -38,6 +41,7 @@
 # create permission to the new type.
 type test_create_t;
 domain_type(test_create_t)
+unconfined_runs_test(test_create_t)
 typeattribute test_create_t test_mkdir_domain;
 typeattribute test_create_t testdomain;
 domain_obj_id_change_exemption(test_create_t)
@@ -48,6 +52,7 @@
 # lacks create permission to the new type.
 type test_nocreate_t;
 domain_type(test_nocreate_t)
+unconfined_runs_test(test_nocreate_t)
 typeattribute test_nocreate_t test_mkdir_domain;
 typeattribute test_nocreate_t testdomain;
 domain_obj_id_change_exemption(test_nocreate_t)
@@ -56,4 +61,4 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_mkdir_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_mkdir_domain)
+sysadm_bin_spec_domtrans_to(test_mkdir_domain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te,v
retrieving revision 1.4
diff -u -r1.4 test_open.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_open.te	5 May 2009 13:47:43 -0000
@@ -12,23 +12,28 @@
 # Domain for process that can open the test file for reading and writing.
 type test_open_t;
 domain_type(test_open_t)
+unconfined_runs_test(test_open_t)
 typeattribute test_open_t test_open_domain;
 typeattribute test_open_t testdomain;
-allow test_open_t test_open_file_t:file { getattr read write append };
+allow test_open_t test_open_file_t:file rw_file_perms;
 
 # Domain for process that cannot open the test file for reading or writing.
 type test_noopen_t;
 domain_type(test_noopen_t)
+unconfined_runs_test(test_noopen_t)
 typeattribute test_noopen_t test_open_domain;
 typeattribute test_noopen_t testdomain;
-allow test_noopen_t test_open_file_t:file { getattr };
+# Allow open permission so that this tests read/write permissions.
+# TBD:  Add separate tests for open permission itself.
+allow test_noopen_t test_open_file_t:file { getattr open };
 
 # Domain for process that can open test file for writing with O_APPEND.
 type test_append_t;
 domain_type(test_append_t)
+unconfined_runs_test(test_append_t)
 typeattribute test_append_t test_open_domain;
 typeattribute test_append_t testdomain;
-allow test_append_t test_open_file_t:file { getattr append };
+allow test_append_t test_open_file_t:file append_file_perms;
 
 # Allow all of these domains to be entered from sysadm domain
 miscfiles_domain_entry_test_files(test_open_domain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.if
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.if,v
retrieving revision 1.1
diff -u -r1.1 test_policy.if
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.if	22 Mar 2006 21:30:29 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.if	5 May 2009 13:47:43 -0000
@@ -25,3 +25,39 @@
 ##      Domain allowed to transition.
 ## </param>
 #
+
+interface(`unconfined_runs_test',`
+	gen_require(`
+		type unconfined_t;
+               type unconfined_devpts_t;
+		role unconfined_r;
+	')
+
+       # Transition from the caller to the test domain.
+	allow unconfined_t $1:process transition;
+	role unconfined_r types $1;
+      # Report back from the test domain to the caller.
+      allow $1 unconfined_t:fd use;
+      allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
+      allow $1 unconfined_t:fifo_file { read write ioctl getattr };
+      allow $1 unconfined_t:process { sigchld };
+')
+
+ifdef(`userdom_sysadm_entry_spec_domtrans_to',`', ` dnl
+interface(`userdom_sysadm_entry_spec_domtrans_to',`
+        gen_require(`
+                type sysadm_t;
+	')
+
+        domain_entry_file_spec_domtrans(sysadm_t, $1)
+        allow $1 sysadm_t:fd use;
+        allow $1 sysadm_t:fifo_file rw_file_perms;
+        allow $1 sysadm_t:process sigchld;
+')
+')
+
+ifdef(`userdom_search_generic_user_home_dirs', `', ` dnl
+interface(`userdom_search_generic_user_home_dirs', `
+    userdom_search_user_home_dirs($1)
+')
+')
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te,v
retrieving revision 1.5
diff -u -r1.5 test_ptrace.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te	30 Apr 2009 10:20:37 -0000	1.5
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_ptrace.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Domain for process that is allowed to trace.
 type test_ptrace_tracer_t;
 domain_type(test_ptrace_tracer_t)
+unconfined_runs_test(test_ptrace_tracer_t)
 typeattribute test_ptrace_tracer_t ptracedomain;
 typeattribute test_ptrace_tracer_t testdomain;
 allow test_ptrace_tracer_t self:capability sys_ptrace;
@@ -15,6 +16,7 @@
 # Domain for process that is not allowed to trace.
 type test_ptrace_nottracer_t;
 domain_type(test_ptrace_nottracer_t)
+unconfined_runs_test(test_ptrace_nottracer_t)
 typeattribute test_ptrace_nottracer_t ptracedomain;
 typeattribute test_ptrace_nottracer_t testdomain;
 allow test_ptrace_nottracer_t self:capability sys_ptrace;
@@ -22,6 +24,7 @@
 # Domain for process that is to be traced.
 type test_ptrace_traced_t;
 domain_type(test_ptrace_traced_t)
+unconfined_runs_test(test_ptrace_traced_t)
 typeattribute test_ptrace_traced_t ptracedomain;
 typeattribute test_ptrace_traced_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te,v
retrieving revision 1.2
diff -u -r1.2 test_readlink.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te	13 Dec 2007 09:55:13 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te	5 May 2009 13:47:43 -0000
@@ -14,6 +14,7 @@
 # Domain for process that can read and follow the symbolic link.
 type test_readlink_t;
 domain_type(test_readlink_t)
+unconfined_runs_test(test_readlink_t)
 typeattribute test_readlink_t test_readlink_domain;
 typeattribute test_readlink_t testdomain;
 allow test_readlink_t test_readlink_file_t:file { getattr read };
@@ -22,6 +23,7 @@
 # Domain for process that cannot read or follow the symbolic link.
 type test_noreadlink_t;
 domain_type(test_noreadlink_t)
+unconfined_runs_test(test_noreadlink_t)
 typeattribute test_noreadlink_t test_readlink_domain;
 typeattribute test_noreadlink_t testdomain;
 allow test_noreadlink_t test_readlink_file_t:file { getattr read };
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te,v
retrieving revision 1.4
diff -u -r1.4 test_relabel.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_relabel.te	5 May 2009 13:47:43 -0000
@@ -14,6 +14,7 @@
 # Domain for process that can relabel the test file.
 type test_relabel_t;
 domain_type(test_relabel_t)
+unconfined_runs_test(test_relabel_t)
 domain_obj_id_change_exemption(test_relabel_t)
 typeattribute test_relabel_t test_relabel_domain;
 typeattribute test_relabel_t testdomain;
@@ -23,6 +24,7 @@
 # Domain for process that lacks relabelfrom permission to the old type.
 type test_norelabelfrom_t;
 domain_type(test_norelabelfrom_t)
+unconfined_runs_test(test_norelabelfrom_t)
 domain_obj_id_change_exemption(test_norelabelfrom_t)
 typeattribute test_norelabelfrom_t test_relabel_domain;
 typeattribute test_norelabelfrom_t testdomain;
@@ -32,6 +34,7 @@
 # Domain for process that lacks relabelto permission to the new type.
 type test_norelabelto_t;
 domain_type(test_norelabelto_t)
+unconfined_runs_test(test_norelabelto_t)
 domain_obj_id_change_exemption(test_norelabelto_t)
 typeattribute test_norelabelto_t test_relabel_domain;
 typeattribute test_norelabelto_t testdomain;
@@ -40,5 +43,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_relabel_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_relabel_domain)
+sysadm_bin_spec_domtrans_to(test_relabel_domain)
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te,v
retrieving revision 1.4
diff -u -r1.4 test_rename.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_rename.te	5 May 2009 13:47:43 -0000
@@ -20,6 +20,7 @@
 # Domain for process that can rename the test file and directory.
 type test_rename_t;
 domain_type(test_rename_t)
+unconfined_runs_test(test_rename_t)
 typeattribute test_rename_t test_rename_domain;
 typeattribute test_rename_t testdomain;
 allow test_rename_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -30,6 +31,7 @@
 # Domain for process that can rename the test file over an existing file.
 type test_rename2_t;
 domain_type(test_rename2_t)
+unconfined_runs_test(test_rename2_t)
 typeattribute test_rename2_t test_rename_domain;
 typeattribute test_rename2_t testdomain;
 allow test_rename2_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -41,6 +43,7 @@
 # it lacks rename permission to the file.
 type test_norename_t;
 domain_type(test_norename_t)
+unconfined_runs_test(test_norename_t)
 typeattribute test_norename_t test_rename_domain;
 typeattribute test_norename_t testdomain;
 allow test_norename_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -51,6 +54,7 @@
 # it lacks remove_name permission to the src_dir.
 type test_norename2_t;
 domain_type(test_norename2_t)
+unconfined_runs_test(test_norename2_t)
 typeattribute test_norename2_t test_rename_domain;
 typeattribute test_norename2_t testdomain;
 allow test_norename2_t test_rename_src_dir_t:dir { search getattr write };
@@ -61,6 +65,7 @@
 # it lacks add_name permission to the dst_dir.
 type test_norename3_t;
 domain_type(test_norename3_t)
+unconfined_runs_test(test_norename3_t)
 typeattribute test_norename3_t test_rename_domain;
 typeattribute test_norename3_t testdomain;
 allow test_norename3_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -72,6 +77,7 @@
 # the dst_dir.
 type test_norename4_t;
 domain_type(test_norename4_t)
+unconfined_runs_test(test_norename4_t)
 typeattribute test_norename4_t test_rename_domain;
 typeattribute test_norename4_t testdomain;
 allow test_norename4_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -84,6 +90,7 @@
 # the destination file.
 type test_norename5_t;
 domain_type(test_norename5_t)
+unconfined_runs_test(test_norename5_t)
 typeattribute test_norename5_t test_rename_domain;
 typeattribute test_norename5_t testdomain;
 allow test_norename5_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -95,6 +102,7 @@
 # because it lacks reparent permission.
 type test_norename6_t;
 domain_type(test_norename6_t)
+unconfined_runs_test(test_norename6_t)
 typeattribute test_norename6_t test_rename_domain;
 typeattribute test_norename6_t testdomain;
 allow test_norename6_t test_rename_src_dir_t:dir { search getattr write remove_name };
@@ -103,5 +111,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_rename_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_rename_domain)
+sysadm_bin_spec_domtrans_to(test_rename_domain)
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te,v
retrieving revision 1.2
diff -u -r1.2 test_rxdir.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te	13 Dec 2007 09:55:13 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te	5 May 2009 13:47:43 -0000
@@ -12,17 +12,19 @@
 # Domain for process that can read but not search the directory.
 type test_rdir_t;
 domain_type(test_rdir_t)
+unconfined_runs_test(test_rdir_t)
 typeattribute test_rdir_t test_rxdir_domain;
 typeattribute test_rdir_t testdomain;
-allow test_rdir_t test_rxdir_dir_t:dir { getattr read };
+allow test_rdir_t test_rxdir_dir_t:dir { getattr read open };
 allow test_rdir_t test_rxdir_dir_t:file { getattr };
 
 # Domain for process that can search but not read the directory.
 type test_xdir_t;
 domain_type(test_xdir_t)
+unconfined_runs_test(test_xdir_t)
 typeattribute test_xdir_t test_rxdir_domain;
 typeattribute test_xdir_t testdomain;
-allow test_xdir_t test_rxdir_dir_t:dir { getattr search };
+allow test_xdir_t test_rxdir_dir_t:dir search_dir_perms;
 allow test_xdir_t test_rxdir_dir_t:file { getattr };
 
 # TODO: How to translate this into refpolicy????
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te,v
retrieving revision 1.4
diff -u -r1.4 test_setattr.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_setattr.te	5 May 2009 13:47:43 -0000
@@ -12,6 +12,7 @@
 # Domain for process that can set attributes on the test file.
 type test_setattr_t;
 domain_type(test_setattr_t)
+unconfined_runs_test(test_setattr_t)
 typeattribute test_setattr_t test_setattr_domain;
 typeattribute test_setattr_t testdomain;
 allow test_setattr_t self:capability chown;
@@ -20,6 +21,7 @@
 # Domain for process that cannot set attributes on the test file.
 type test_nosetattr_t;
 domain_type(test_nosetattr_t)
+unconfined_runs_test(test_nosetattr_t)
 typeattribute test_nosetattr_t test_setattr_domain;
 typeattribute test_nosetattr_t testdomain;
 allow test_nosetattr_t self:capability chown;
@@ -27,5 +29,5 @@
 
 # Allow all of these domains to be entered from sysadm domain
 corecmd_bin_entry_type(test_setattr_domain)
-userdom_sysadm_bin_spec_domtrans_to(test_setattr_domain)
+sysadm_bin_spec_domtrans_to(test_setattr_domain)
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te,v
retrieving revision 1.5
diff -u -r1.5 test_setnice.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te	30 Apr 2009 10:20:37 -0000	1.5
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te	5 May 2009 13:47:43 -0000
@@ -8,24 +8,26 @@
 # Domain for process whose nice can be set.
 type test_setnice_set_t;
 domain_type(test_setnice_set_t)
+unconfined_runs_test(test_setnice_set_t)
 typeattribute test_setnice_set_t setnicedomain;
 typeattribute test_setnice_set_t testdomain;
 
 # Domain for process whose nice cannot be set.
 type test_setnice_noset_t;
 domain_type(test_setnice_noset_t)
+unconfined_runs_test(test_setnice_noset_t)
 typeattribute test_setnice_noset_t setnicedomain;
 typeattribute test_setnice_noset_t testdomain;
 
 # Domain for parent process.
 type test_setnice_change_t;
 domain_type(test_setnice_change_t)
+unconfined_runs_test(test_setnice_change_t)
 typeattribute test_setnice_change_t setnicedomain;
 typeattribute test_setnice_change_t testdomain;
 
 # Allow execution of helper programs.
 corecmd_exec_bin(setnicedomain)
-corecmd_exec_sbin(setnicedomain)
 domain_exec_all_entry_files(setnicedomain)
 files_exec_etc_files(setnicedomain)
 libs_use_ld_so(setnicedomain)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te,v
retrieving revision 1.4
diff -u -r1.4 test_sigkill.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_sigkill.te	5 May 2009 13:47:43 -0000
@@ -8,12 +8,14 @@
 # Domain for process that receives the signals.
 type test_kill_server_t;
 domain_type(test_kill_server_t)
+unconfined_runs_test(test_kill_server_t)
 typeattribute test_kill_server_t killdomain;
 typeattribute test_kill_server_t testdomain;
 
 # Domain for process that is allowed to send sigkill.
 type test_kill_sigkill_t;
 domain_type(test_kill_sigkill_t)
+unconfined_runs_test(test_kill_sigkill_t)
 typeattribute test_kill_sigkill_t killdomain;
 typeattribute test_kill_sigkill_t testdomain;
 allow test_kill_sigkill_t test_kill_server_t:process sigkill;
@@ -21,6 +23,7 @@
 # Domain for process that is allowed to send sigstop.
 type test_kill_sigstop_t;
 domain_type(test_kill_sigstop_t)
+unconfined_runs_test(test_kill_sigstop_t)
 typeattribute test_kill_sigstop_t killdomain;
 typeattribute test_kill_sigstop_t testdomain;
 allow test_kill_sigstop_t test_kill_server_t:process sigstop;
@@ -28,6 +31,7 @@
 # Domain for process that is allowed to send sigchld.
 type test_kill_sigchld_t;
 domain_type(test_kill_sigchld_t)
+unconfined_runs_test(test_kill_sigchld_t)
 typeattribute test_kill_sigchld_t killdomain;
 typeattribute test_kill_sigchld_t testdomain;
 allow test_kill_sigchld_t test_kill_server_t:process sigchld;
@@ -35,6 +39,7 @@
 # Domain for process that is allowed to send other signals.
 type test_kill_signal_t;
 domain_type(test_kill_signal_t)
+unconfined_runs_test(test_kill_signal_t)
 typeattribute test_kill_signal_t killdomain;
 typeattribute test_kill_signal_t testdomain;
 
@@ -45,5 +50,5 @@
 miscfiles_domain_entry_test_files(killdomain)
 userdom_sysadm_entry_spec_domtrans_to(killdomain)
 corecmd_bin_entry_type(killdomain)
-userdom_sysadm_bin_spec_domtrans_to(killdomain)
+sysadm_bin_spec_domtrans_to(killdomain)
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te,v
retrieving revision 1.2
diff -u -r1.2 test_stat.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te	13 Dec 2007 09:55:13 -0000	1.2
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te	5 May 2009 13:47:43 -0000
@@ -12,6 +12,7 @@
 # Domain for process that can get attributes on the test file.
 type test_stat_t;
 domain_type(test_stat_t)
+unconfined_runs_test(test_stat_t)
 typeattribute test_stat_t test_stat_domain;
 typeattribute test_stat_t testdomain;
 allow test_stat_t test_stat_file_t:file getattr;
@@ -19,6 +20,7 @@
 # Domain for process that cannot set attributes on the test file.
 type test_nostat_t;
 domain_type(test_nostat_t)
+unconfined_runs_test(test_nostat_t)
 typeattribute test_nostat_t test_stat_domain;
 typeattribute test_nostat_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te,v
retrieving revision 1.6
diff -u -r1.6 test_sysctl.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te	5 May 2009 13:47:43 -0000
@@ -8,19 +8,21 @@
 # Domain for process that is allowed to perform sysctl.
 type test_sysctl_t;
 domain_type(test_sysctl_t)
+unconfined_runs_test(test_sysctl_t)
 typeattribute test_sysctl_t sysctldomain;
 typeattribute test_sysctl_t testdomain;
 
 # Domain for process that is not allowed to perform sysctl.
 type test_nosysctl_t;
 domain_type(test_nosysctl_t)
+unconfined_runs_test(test_nosysctl_t)
 typeattribute test_nosysctl_t sysctldomain;
 typeattribute test_nosysctl_t testdomain;
 
 # Allow all of these domains to be entered from sysadm domain
 # via /sbin/sysctl.
-corecmd_sbin_entry_type(sysctldomain)
-userdom_sysadm_sbin_spec_domtrans_to(sysctldomain)
+corecmd_bin_entry_type(sysctldomain)
+sysadm_bin_spec_domtrans_to(sysctldomain)
 
 # Allow the first domain to perform sysctl operations.
 kernel_rw_all_sysctls(test_sysctl_t)
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te,v
retrieving revision 1.6
diff -u -r1.6 test_task_create.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Domain for process allowed to fork.
 type test_create_yes_t;
 domain_type(test_create_yes_t)
+unconfined_runs_test(test_create_yes_t)
 typeattribute test_create_yes_t test_create_d;
 typeattribute test_create_yes_t testdomain;
 
@@ -21,13 +22,16 @@
 # Ideally, refpolicy would _not_ grant such permissions to every domain,
 # as it makes the permission effectively unusable in real policy.
 #domain_type(test_create_no_t)
+unconfined_runs_test(test_create_no_t)
 typeattribute test_create_no_t test_create_d;
 
 allow test_create_no_t self:process ~fork;
-allow test_create_no_t proc_t:dir r_dir_perms;
+allow test_create_no_t proc_t:dir list_dir_perms;
 allow test_create_no_t proc_t:lnk_file read;
-allow test_create_no_t self:dir r_dir_perms;
-allow test_create_no_t self:notdevfile_class_set r_file_perms;
+allow test_create_no_t self:dir list_dir_perms;
+allow test_create_no_t self:file read_file_perms;
+allow test_create_no_t self:lnk_file read_lnk_file_perms;
+term_use_all_terms(test_create_no_t)
 
 libs_use_ld_so(test_create_no_t)
 libs_use_shared_libs(test_create_no_t)
@@ -35,14 +39,13 @@
 allow test_create_no_t self:process setexec;
 selinux_get_fs_mount(test_create_no_t)
 
-allow test_create_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
-allow test_create_no_t lib_t:lnk_file r_file_perms;
+allow test_create_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir list_dir_perms;
+allow test_create_no_t lib_t:lnk_file read;
 allow test_create_no_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
-allow test_create_no_t locale_t:dir r_dir_perms;
-allow test_create_no_t locale_t:{ file lnk_file } r_file_perms;
+allow test_create_no_t locale_t:dir list_dir_perms;
+allow test_create_no_t locale_t:file read_file_perms;
+allow test_create_no_t locale_t:lnk_file read;
 allow test_create_no_t privfd:fd use;
-userdom_use_sysadm_ptys(test_create_no_t)
-userdom_use_sysadm_ttys(test_create_no_t)
 
 # General rules for the test_create_d
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te,v
retrieving revision 1.4
diff -u -r1.4 test_task_getpgid.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getpgid.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,21 @@
 # Domain for the target process
 type test_getpgid_target_t;
 domain_type(test_getpgid_target_t)
+unconfined_runs_test(test_getpgid_target_t)
 typeattribute test_getpgid_target_t test_getpgid_d;
 typeattribute test_getpgid_target_t testdomain;
 
 # Domain that can get the target's process group ID.
 type test_getpgid_yes_t;
 domain_type(test_getpgid_yes_t)
+unconfined_runs_test(test_getpgid_yes_t)
 typeattribute test_getpgid_yes_t test_getpgid_d;
 typeattribute test_getpgid_yes_t testdomain;
 
 # Domain that cannot get the target's process group ID.
 type test_getpgid_no_t;
 domain_type(test_getpgid_no_t)
+unconfined_runs_test(test_getpgid_no_t)
 typeattribute test_getpgid_no_t test_getpgid_d;
 typeattribute test_getpgid_no_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te,v
retrieving revision 1.4
diff -u -r1.4 test_task_getsched.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsched.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,21 @@
 # Domain for the target process
 type test_getsched_target_t;
 domain_type(test_getsched_target_t)
+unconfined_runs_test(test_getsched_target_t)
 typeattribute test_getsched_target_t test_getsched_d;
 typeattribute test_getsched_target_t testdomain;
 
 # Domain that can get the target's scheduling policy.
 type test_getsched_yes_t;
 domain_type(test_getsched_yes_t)
+unconfined_runs_test(test_getsched_yes_t)
 typeattribute test_getsched_yes_t test_getsched_d;
 typeattribute test_getsched_yes_t testdomain;
 
 # Domain that cannot get the target's scheduling policy.
 type test_getsched_no_t;
 domain_type(test_getsched_no_t)
+unconfined_runs_test(test_getsched_no_t)
 typeattribute test_getsched_no_t test_getsched_d;
 typeattribute test_getsched_no_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te,v
retrieving revision 1.4
diff -u -r1.4 test_task_getsid.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_getsid.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,21 @@
 # Domain for the target process
 type test_getsid_target_t;
 domain_type(test_getsid_target_t)
+unconfined_runs_test(test_getsid_target_t)
 typeattribute test_getsid_target_t test_getsid_d;
 typeattribute test_getsid_target_t testdomain;
 
 # Domain that can get the target's session ID.
 type test_getsid_yes_t;
 domain_type(test_getsid_yes_t)
+unconfined_runs_test(test_getsid_yes_t)
 typeattribute test_getsid_yes_t test_getsid_d;
 typeattribute test_getsid_yes_t testdomain;
 
 # Domain that cannot get the target's session ID.
 type test_getsid_no_t;
 domain_type(test_getsid_no_t)
+unconfined_runs_test(test_getsid_no_t)
 typeattribute test_getsid_no_t test_getsid_d;
 typeattribute test_getsid_no_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te,v
retrieving revision 1.6
diff -u -r1.6 test_task_setpgid.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te	30 Apr 2009 10:20:37 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te	5 May 2009 13:47:43 -0000
@@ -8,6 +8,7 @@
 # Domain for process allowed to setpgid
 type test_setpgid_yes_t;
 domain_type(test_setpgid_yes_t)
+unconfined_runs_test(test_setpgid_yes_t)
 typeattribute test_setpgid_yes_t test_setpgid_d;
 typeattribute test_setpgid_yes_t testdomain;
 
@@ -15,27 +16,29 @@
 # The same permissions as test_setpgid_yes_t, except process setpgid
 type test_setpgid_no_t;
 domain_type(test_setpgid_no_t)
+unconfined_runs_test(test_setpgid_no_t)
 typeattribute test_setpgid_no_t test_setpgid_d;
 
 allow test_setpgid_no_t self:process ~{ setpgid setcurrent };
-allow test_setpgid_no_t proc_t:dir r_dir_perms;
+allow test_setpgid_no_t proc_t:dir list_dir_perms;
 allow test_setpgid_no_t proc_t:lnk_file read;
-allow test_setpgid_no_t self:dir r_dir_perms;
-allow test_setpgid_no_t self:notdevfile_class_set r_file_perms;
+allow test_setpgid_no_t self:dir list_dir_perms;
+allow test_setpgid_no_t self:file read_file_perms;
+allow test_setpgid_no_t self:lnk_file read_lnk_file_perms;
+term_use_all_terms(test_setpgid_no_t)
 
 libs_use_ld_so(test_setpgid_no_t)
 libs_use_shared_libs(test_setpgid_no_t)
 allow test_setpgid_no_t self:process setexec;
 selinux_get_fs_mount(test_setpgid_no_t)
 
-allow test_setpgid_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir r_dir_perms;
-allow test_setpgid_no_t lib_t:lnk_file r_file_perms;
+allow test_setpgid_no_t { root_t bin_t sbin_t lib_t locale_t usr_t devpts_t home_root_t }:dir list_dir_perms;
+allow test_setpgid_no_t lib_t:lnk_file read;
 allow test_setpgid_no_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
-allow test_setpgid_no_t locale_t:dir r_dir_perms;
-allow test_setpgid_no_t locale_t:{ file lnk_file } r_file_perms;
+allow test_setpgid_no_t locale_t:dir list_dir_perms;
+allow test_setpgid_no_t locale_t:file read_file_perms;
+allow test_setpgid_no_t locale_t:lnk_file read;
 allow test_setpgid_no_t privfd:fd use;
-userdom_use_sysadm_ptys(test_setpgid_no_t)
-userdom_use_sysadm_ttys(test_setpgid_no_t)
 
 # Allow domain to be entered from the sysadm domain.
 role sysadm_r types test_setpgid_d;
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te,v
retrieving revision 1.4
diff -u -r1.4 test_task_setsched.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setsched.te	5 May 2009 13:47:43 -0000
@@ -9,18 +9,21 @@
 # Domain for the target process
 type test_setsched_target_t;
 domain_type(test_setsched_target_t)
+unconfined_runs_test(test_setsched_target_t)
 typeattribute test_setsched_target_t test_setsched_d;
 typeattribute test_setsched_target_t testdomain;
 
 # Domain that can change the target's priority and scheduling policy.
 type test_setsched_yes_t;
 domain_type(test_setsched_yes_t)
+unconfined_runs_test(test_setsched_yes_t)
 typeattribute test_setsched_yes_t test_setsched_d;
 typeattribute test_setsched_yes_t testdomain;
 
 # Domain that cannot change the target's priority or scheduling policy.
 type test_setsched_no_t;
 domain_type(test_setsched_no_t)
+unconfined_runs_test(test_setsched_no_t)
 typeattribute test_setsched_no_t test_setsched_d;
 typeattribute test_setsched_no_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te,v
retrieving revision 1.4
diff -u -r1.4 test_transition.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_transition.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,21 @@
 # Domain for process that is allowed to transition to the new domain.
 type test_transition_fromdomain_t;
 domain_type(test_transition_fromdomain_t)
+unconfined_runs_test(test_transition_fromdomain_t)
 typeattribute test_transition_fromdomain_t transitiondomain;
 typeattribute test_transition_fromdomain_t testdomain;
 
 # Domain for process that is not allowed to transition to the new domain.
 type test_transition_notfromdomain_t;
 domain_type(test_transition_notfromdomain_t)
+unconfined_runs_test(test_transition_notfromdomain_t)
 typeattribute test_transition_notfromdomain_t transitiondomain;
 typeattribute test_transition_notfromdomain_t testdomain;
 
 # New domain for the process after the transition.
 type test_transition_todomain_t;
 domain_type(test_transition_todomain_t)
+unconfined_runs_test(test_transition_todomain_t)
 typeattribute test_transition_todomain_t transitiondomain;
 typeattribute test_transition_todomain_t testdomain;
 
Index: testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te,v
retrieving revision 1.4
diff -u -r1.4 test_wait.te
--- testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te	30 Apr 2009 10:20:37 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/refpolicy/test_wait.te	5 May 2009 13:47:43 -0000
@@ -8,18 +8,21 @@
 # Domain for parent process.
 type test_wait_parent_t;
 domain_type(test_wait_parent_t)
+unconfined_runs_test(test_wait_parent_t)
 typeattribute test_wait_parent_t waitdomain;
 typeattribute test_wait_parent_t testdomain;
 
 # Domain for child process that can be reaped by the parent.
 type test_wait_child_t;
 domain_type(test_wait_child_t)
+unconfined_runs_test(test_wait_child_t)
 typeattribute test_wait_child_t waitdomain;
 typeattribute test_wait_child_t testdomain;
 
 # Domain for child process that cannot be reaped by the parent.
 type test_wait_notchild_t;
 domain_type(test_wait_notchild_t)
+unconfined_runs_test(test_wait_notchild_t)
 typeattribute test_wait_notchild_t waitdomain;
 typeattribute test_wait_notchild_t testdomain;
 
@@ -38,4 +41,5 @@
 # Permit the parent to transition to the notchild, but don't
 # grant the permission to wait on it.
 allow test_wait_parent_t test_wait_notchild_t:process transition;
+allow test_wait_notchild_t test_wait_parent_t:fd use;
 allow test_wait_notchild_t test_file_t:file entrypoint;

--=-BsR1EAb3evNNPN68gvql
Content-Disposition: attachment; filename="ltp-refpolicy-redhat.tgz"
Content-Type: application/x-compressed-tar; name="ltp-refpolicy-redhat.tgz"
Content-Transfer-Encoding: base64

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
6enS/wHfuF3LAJABAJ==


--=-BsR1EAb3evNNPN68gvql--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
