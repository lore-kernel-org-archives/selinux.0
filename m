Subject: [RFC v2][PATCH] refpolicy:  add memprotect and cap_override
	definitions and interfaces
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 10:42:40 -0400
Message-Id: <1181918560.17547.757.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Introduce policy definitions and interfaces for the new memprotect and
cap_override classes recently added to the kernel.

Since the prior version of the patch, two changes have been made:

- As observed by Eric Paris, we also need to exclude the file type for
any domain that has cap overrides from being created or relabeled-to by
unconfined_t or unconfined_t can create its own entrypoint program into
such a domain, so add a files_cap_override() interface in addition to
the domain_cap_override() interface.  I would have preferred a single
interface but it doesn't seem to fit with the module encapsulation.

- Added a domain_mmap_low() interface for memprotect:mmap_zero.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 policy/flask/access_vectors     |   44 ++++++++++++++++++++++++++++++++++++++++
 policy/flask/security_classes   |    4 +++
 policy/modules/kernel/domain.if |   42 ++++++++++++++++++++++++++++++++++++++
 policy/modules/kernel/domain.te |   15 +++++++++++--
 policy/modules/kernel/files.if  |   18 ++++++++++++++++
 policy/modules/kernel/files.te  |   11 ++++++++--
 6 files changed, 130 insertions(+), 4 deletions(-)

Index: refpolicy/policy/flask/security_classes
===================================================================
--- refpolicy/policy/flask/security_classes	(revision 2333)
+++ refpolicy/policy/flask/security_classes	(working copy)
@@ -97,4 +97,8 @@
 
 class dccp_socket
 
+class memprotect
+
+class cap_override
+
 # FLASK
Index: refpolicy/policy/flask/access_vectors
===================================================================
--- refpolicy/policy/flask/access_vectors	(revision 2333)
+++ refpolicy/policy/flask/access_vectors	(working copy)
@@ -648,3 +648,47 @@
 	node_bind
 	name_connect
 }
+
+class memprotect
+{
+	mmap_zero
+}
+
+class cap_override
+{
+	# The capabilities are defined in include/linux/capability.h
+	# Care should be taken to ensure that these are consistent with
+	# those definitions. (Order matters)
+
+	chown           
+	dac_override    
+	dac_read_search 
+	fowner          
+	fsetid          
+	kill            
+	setgid           
+	setuid           
+	setpcap          
+	linux_immutable  
+	net_bind_service 
+	net_broadcast    
+	net_admin        
+	net_raw          
+	ipc_lock         
+	ipc_owner        
+	sys_module       
+	sys_rawio        
+	sys_chroot       
+	sys_ptrace       
+	sys_pacct        
+	sys_admin        
+	sys_boot         
+	sys_nice         
+	sys_resource     
+	sys_time         
+	sys_tty_config  
+	mknod
+	lease
+	audit_write
+	audit_control
+}
Index: refpolicy/policy/modules/kernel/files.if
===================================================================
--- refpolicy/policy/modules/kernel/files.if	(revision 2333)
+++ refpolicy/policy/modules/kernel/files.if	(working copy)
@@ -4588,3 +4588,21 @@
 
 	allow $1 { file_type -security_file_type }:dir manage_dir_perms;
 ')
+
+########################################
+## <summary>
+##	Program type used to enter domain with ability to override capabilities.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Program type.
+##	</summary>
+## </param>
+#
+interface(`files_cap_override',`
+	gen_require(`
+		attribute cap_override_file_type;
+	')
+
+	typeattribute $1 cap_override_file_type;
+')
Index: refpolicy/policy/modules/kernel/domain.if
===================================================================
--- refpolicy/policy/modules/kernel/domain.if	(revision 2333)
+++ refpolicy/policy/modules/kernel/domain.if	(working copy)
@@ -1254,3 +1254,45 @@
 	typeattribute $1 can_change_object_identity;
 	typeattribute $1 set_curr_context;
 ')
+
+########################################
+## <summary>
+##	Ability to mmap a low area of the address space,
+##      as configured by /proc/sys/kernel/mmap_min_addr.
+##      Preventing such mappings helps protect against
+##      exploiting null deref bugs in the kernel.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to mmap low memory.
+##	</summary>
+## </param>
+#
+interface(`domain_mmap_low',`
+	gen_require(`
+		attribute mmap_low_domain_type;
+	')
+
+	typeattribute $1 mmap_low_domain_type;
+
+	allow $1 self:memprotect mmap_zero;
+')
+
+
+########################################
+## <summary>
+##	Ability to override capabilities.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to override capabilities.
+##	</summary>
+## </param>
+#
+interface(`domain_cap_override',`
+	gen_require(`
+		attribute cap_override_domain_type;
+	')
+
+	typeattribute $1 cap_override_domain_type;
+')
Index: refpolicy/policy/modules/kernel/files.te
===================================================================
--- refpolicy/policy/modules/kernel/files.te	(revision 2333)
+++ refpolicy/policy/modules/kernel/files.te	(working copy)
@@ -12,6 +12,9 @@
 attribute mountpoint;
 attribute pidfile;
 
+# For file types that are entrypoints to domains with cap_overrides.
+attribute cap_override_file_type;
+
 # For labeling types that are to be polyinstantiated
 attribute polydir;
 
@@ -212,10 +215,14 @@
 # Unconfined access to this module
 #
 
-# Create/access any file in a labeled filesystem;
-allow files_unconfined_type file_type:{ file chr_file } ~execmod;
+# Create/access any file without cap overrides in a labeled filesystem
+allow files_unconfined_type { file_type - cap_override_file_type }:file ~execmod;
+allow files_unconfined_type file_type:chr_file ~execmod;
 allow files_unconfined_type file_type:{ dir lnk_file sock_file fifo_file blk_file } *;
 
+# Read/execute-only access to files with cap overrides.
+allow files_unconfined_type cap_override_file_type:file { read getattr execute execute_no_trans };
+
 # Mount/unmount any filesystem with the context= option. 
 allow files_unconfined_type file_type:filesystem *;
 
Index: refpolicy/policy/modules/kernel/domain.te
===================================================================
--- refpolicy/policy/modules/kernel/domain.te	(revision 2333)
+++ refpolicy/policy/modules/kernel/domain.te	(working copy)
@@ -15,6 +15,14 @@
 # Domains that are unconfined
 attribute unconfined_domain_type;
 
+# Domains that have capability overrides.
+attribute cap_override_domain_type;
+neverallow { domain -cap_override_domain_type } self:cap_override *;
+
+# Domains that can mmap low memory.
+attribute mmap_low_domain_type;
+neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
+
 # Domains that can set their current context
 # (perform dynamic transitions)
 attribute set_curr_context;
@@ -130,9 +138,12 @@
 allow unconfined_domain_type domain:fd use;
 allow unconfined_domain_type domain:fifo_file rw_file_perms;
 
-# Act upon any other process.
-allow unconfined_domain_type domain:process ~{ transition dyntransition execmem execstack execheap };
+# Act upon any other process that lacks capability overrides.
+allow unconfined_domain_type { domain -cap_override_domain_type }:process ~{ transition dyntransition execmem execstack execheap };
 
+# More limited access to domains with capability overrides.
+allow unconfined_domain_type cap_override_domain_type:process { signull getsched getpgid getattr };
+
 # Create/access any System V IPC objects.
 allow unconfined_domain_type domain:{ sem msgq shm } *;
 allow unconfined_domain_type domain:msg { send receive };

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
