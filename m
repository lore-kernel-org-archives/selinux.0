Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4KVtXZ026912
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 15:31:57 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4KUM8f025090
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 20:30:22 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id iA4KYDPZ011977
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 15:34:13 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id iA4KYDWN011976
	for selinux@tycho.nsa.gov; Thu, 4 Nov 2004 15:34:13 -0500
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4KI1XZ026652
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 15:18:03 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4KHod1016749
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 20:17:57 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA4KAARt009673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 14:10:15 -0600
To: selinux@tycho.nsa.gov
Subject: selinux-doc patchset 1 of 2: Fixing name tokens to not contain underscores
References: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
	<1099503633.1213.153.camel@moss-spartans.epoch.ncsc.mil>
	<87fz3qqc20.fsf@glaurung.internal.golden-gryphon.com>
	<1099575909.3174.9.camel@moss-spartans.epoch.ncsc.mil>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Thu, 04 Nov 2004 14:09:46 -0600
In-Reply-To: <1099575909.3174.9.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Thu, 04 Nov 2004 08:45:10 -0500")
Message-ID: <87bredqstx.fsf_-_@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        This is the first of two patch sets that allow selinux-doc to
 be build again by the new openjade. This only modifies the IDs and
 the references to use StudlyCaps instead.

	manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=tags.diff
Content-Description: Use StudlyCaps name tokens

* looking for srivasta@debian.org--2003-primary/selinux-doc--debian--1.0--base-0 to compare with
* comparing to srivasta@debian.org--2003-primary/selinux-doc--debian--1.0--base-0
M  module/inode.sgml
M  module/ip.sgml
M  module/ipc.sgml
M  module/nsid.sgml
M  module/sb.sgml
M  module/skb.sgml
M  module/socket.sgml
M  module/stacking.sgml
M  module/system.sgml
M  module/task.sgml
M  policy/apps.sgml
M  module/binprm.sgml
M  module/changes.sgml
M  module/file.sgml
M  module/helper.sgml
M  module/init.sgml

* modified files

--- orig/module/binprm.sgml
+++ mod/module/binprm.sgml
@@ -7,7 +7,7 @@
 describes these hooks and their helper functions.
 </para>
 
-<sect2 id="binprm_security"><title>Managing Binprm Security Fields</title>
+<sect2 id="BinprmSecurity"><title>Managing Binprm Security Fields</title>
 
 <sect3><title>selinux_bprm_alloc_security and selinux_bprm_free_security</title>
 <para>
@@ -37,7 +37,7 @@
 </para>
 </sect3>
 
-<sect3 id="bprm_set_security"><title>selinux_bprm_set_security</title>
+<sect3 id="BprmSetSecurity"><title>selinux_bprm_set_security</title>
 <para>
 The <function>selinux_bprm_set_security</function> hook function is
 called while loading a new program to fill in the
@@ -72,14 +72,14 @@
 <para>
 The file <constant>execute_no_trans</constant> permission is checked
 when a task would remain in the same SID upon executing a program, as
-shown in <xref linkend="nochange_sid_table">.  This permission check
+shown in <xref linkend="NochangeSidTable">.  This permission check
 ensures that a task is allowed to execute a given program without
 changing its security attributes.  For example, although the login
 process can execute a user shell, it should always change its SID at
 the same time, so it does not need this permission to the shell
 program.
 
-<table id="nochange_sid_table" frame=all>
+<table id="NochangeSidTable" frame=all>
 <title>Permission Checks if Task SID is not changing on exec</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -108,9 +108,9 @@
 <constant>entrypoint</constant> permission check ensures that the new
 SID can only be entered by executing particular programs.  Such
 programs are referred to as entrypoint programs for the SID.  These
-permission checks are shown in <xref linkend="change_sid_table">.
+permission checks are shown in <xref linkend="ChangeSidTable">.
 
-<table id="change_sid_table" frame=all>
+<table id="ChangeSidTable" frame=all>
 <title>Permission Checks if Task SID is changing on exec</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -138,7 +138,7 @@
 
 </sect3>
 
-<sect3 id="bprm_compute_creds"><title>selinux_bprm_compute_creds</title>
+<sect3 id="BprmComputeCreds"><title>selinux_bprm_compute_creds</title>
 <para>
 The <function>selinux_bprm_compute_creds</function> hook function is
 called to set the new security attributes for the task.  This hook
@@ -158,9 +158,9 @@
 <constant>share</constant> permission is checked between the old and
 new SIDs.  If these permission checks fail, then the task SID is left
 unchanged and the task is sent a SIGKILL to terminate it.
-These permission checks are shown in <xref linkend="ptrace_share_table">.
+These permission checks are shown in <xref linkend="PtraceShareTable">.
 
-<table id="ptrace_share_table" frame=all>
+<table id="PtraceShareTable" frame=all>
 <title>Permission Checks if Task SID is changing on exec</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -195,7 +195,7 @@
 open file with requested permissions that correspond to the file mode
 and flags, and closes the open file if these permissions are not
 granted under the new SID.  The <function>file_has_perm</function>
-function is described in <xref linkend="file_has_perm">.  Finally,
+function is described in <xref linkend="FileHasPerm">.  Finally,
 this hook function wakes up the parent task if it is waiting on this
 task.  This allows the <function>selinux_task_wait</function> hook to
 recheck whether the parent task is allowed to wait on the task under


--- orig/module/changes.sgml
+++ mod/module/changes.sgml
@@ -104,7 +104,7 @@
 </para>
 </sect3>
 
-<sect3 id="permission_changes"><title>Leveraging Linux Permission Functions</title>
+<sect3 id="PermissionChanges"><title>Leveraging Linux Permission Functions</title>
 <para>
 The original SELinux kernel patch directly inserted its own permission
 checks throughout the kernel code rather than trying to leverage
@@ -136,8 +136,8 @@
 <para>
 Using these hooks required defining some additional coarse-grained
 permissions for SELinux.  These permissions are discussed further in
-<xref linkend="inode_perms_changes"> and in <xref
-linkend="ipc_perms_changes">.  Whenever possible, the LSM-based
+<xref linkend="InodePermsChanges"> and in <xref
+linkend="IpcPermsChanges">.  Whenever possible, the LSM-based
 SELinux security module leverages these hooks to provide control.  When
 SELinux requires finer-grained control, the module implements 
 these finer-grained SELinux controls using the additional LSM hooks.
@@ -145,7 +145,7 @@
 </sect3>
 </sect2>
 
-<sect2 id="exec_perms_changes"><title>Program Execution Changes</title>
+<sect2 id="ExecPermsChanges"><title>Program Execution Changes</title>
 <para>
 This subsection describes general changes between the original SELinux
 kernel patch and the LSM-based SELinux security module related to
@@ -184,11 +184,11 @@
 file class for consistency.  The file <constant>execute</constant> and
 process <constant>transition</constant> permissions were left
 unchanged.  These checks are described further in <xref
-linkend="bprm_set_security">.
+linkend="BprmSetSecurity">.
 </para>
 </sect3>
 
-<sect3 id="fd_inherit_changes"><title>Inheritance of State</title>
+<sect3 id="FdInheritChanges"><title>Inheritance of State</title>
 <para>
 Several changes were made to the controls over the inheritance of
 state across a context-changing execve.  These changes included
@@ -199,7 +199,7 @@
 <para>
 The file descriptor inheritance permission checks during program
 execution were revised for the LSM-based SELinux security module.
-This is discussed in <xref linkend="fd_perms_changes">.  
+This is discussed in <xref linkend="FdPermsChanges">.  
 </para>
 
 <para>
@@ -218,14 +218,14 @@
 <constant>share</constant> permission was added to provide
 configurable control over process state sharing across SID
 transitions.  This is described further in <xref
-linkend="bprm_compute_creds">.
+linkend="BprmComputeCreds">.
 </para>
 
 <para>
 New permission checks were implemented in the LSM-based SELinux to
 control inheritance of signal-related state and resource limits.
 These checks are also described in <xref
-linkend="bprm_compute_creds">.  Furthermore, a
+linkend="BprmComputeCreds">.  Furthermore, a
 <constant>AT_SECURE</constant> flag was added to the ELF auxiliary
 table so that the SELinux module could inform glibc when to enable its
 own secure mode in order to sanitize the environment and other state
@@ -285,13 +285,13 @@
 inodes is still handled by the hooks called by the VFS layer.  The LSM-based
 SELinux also expanded and generalized support for pseudo filesystem labeling.
 The handling for these pseudo filesystem types is described in <xref
-linkend="inode_precondition">.
+linkend="InodePrecondition">.
 </para>
 </sect3>
 
-<sect3 id="inode_perms_changes"><title>Leveraging <function>permission</function></title>
+<sect3 id="InodePermsChanges"><title>Leveraging <function>permission</function></title>
 <para>
-As discussed in <xref linkend="permission_changes">, LSM inserts a
+As discussed in <xref linkend="PermissionChanges">, LSM inserts a
 hook into the existing Linux functions for permission checking,
 including the <function>permission</function> function for checking
 access to objects represented by inodes.  The LSM-based SELinux
@@ -329,7 +329,7 @@
 </para>
 </sect3>
 
-<sect3 id="fd_perms_changes"><title>File Descriptor Permissions</title>
+<sect3 id="FdPermsChanges"><title>File Descriptor Permissions</title>
 <para>
 In the original SELinux kernel patch, distinct file descriptor
 permissions were defined for getting the file offset or flags
@@ -368,7 +368,7 @@
 </para>
 </sect3>
 
-<sect3 id="pipe_changes"><title>Pipe Security Class</title>
+<sect3 id="PipeChanges"><title>Pipe Security Class</title>
 <para>
 In the original SELinux kernel patch, a separate security class was
 defined for pipes, although this security class merely inherited the
@@ -452,7 +452,7 @@
 security module leverages the hooks in the existing Linux permission
 functions but also required two additional hooks in the Unix domain
 protocol implementation due to the abstract namespace.  The SELinux
-socket access controls are described in <xref linkend="socket_ac"> and
+socket access controls are described in <xref linkend="SocketAc"> and
 the SELinux network layer access controls are described in <xref
 linkend="ip">.
 </para>
@@ -462,7 +462,7 @@
 <para>
 The file descriptor transfer permission checks during socket IPC
 were revised for the LSM-based SELinux security module.
-This is discussed in <xref linkend="fd_perms_changes">.
+This is discussed in <xref linkend="FdPermsChanges">.
 </para>
 </sect3>
 
@@ -529,13 +529,13 @@
 with common information.  Hence, LSM was able to add a single security
 field to this common structure and a single security field to the
 structure for individual messages.  This is discussed further in <xref
-linkend="ipc_security">.
+linkend="IpcSecurity">.
 </para>
 </sect3>
 
-<sect3 id="ipc_perms_changes"><title>Leveraging <function>ipcperms</function></title>
+<sect3 id="IpcPermsChanges"><title>Leveraging <function>ipcperms</function></title>
 <para>
-As discussed in <xref linkend="permission_changes">, LSM inserts a
+As discussed in <xref linkend="PermissionChanges">, LSM inserts a
 hook into the existing Linux functions for permission checking,
 including the <function>ipcperms</function> function for checking
 access to IPC objects.  The LSM-based SELinux security module
@@ -552,7 +552,7 @@
 finer-grained permission.  The coarse-grained permission checks could
 be omitted, but they are present to ensure that all IPC accesses are
 controlled by SELinux.  These checks are discussed in <xref
-linkend="ipc_permission">.
+linkend="IpcPermission">.
 </para>
 </sect3>
 


--- orig/module/file.sgml
+++ mod/module/file.sgml
@@ -116,7 +116,7 @@
 </para>
 </sect3>
 
-<sect3 id="set_fowner"><title>selinux_file_set_fowner</title>
+<sect3 id="SetFowner"><title>selinux_file_set_fowner</title>
 <para>
 This hook function is called to save security information about the
 current task in the file security structure for later use by the
@@ -132,7 +132,7 @@
 
 <sect2><title>Controlling File Operations</title>
 
-<sect3 id="file_has_perm"><title>file_has_perm</title>
+<sect3 id="FileHasPerm"><title>file_has_perm</title>
 <para>
 This helper function checks whether a task can use an open file descriptor to
 access a file in a given way.  It takes the task, the file, and the
@@ -180,10 +180,10 @@
 file permission is specified so only the <constant>use</constant>
 permission is checked.  The generic <constant>ioctl</constant>
 file permission is used for commands that are not specifically handled.
-<xref linkend="ioperm_table"> shows the permission checks performed for each
+<xref linkend="IopermTable"> shows the permission checks performed for each
 command.
 
-<table id="ioperm_table" frame=all>
+<table id="IopermTable" frame=all>
 <title>I/O Control Permission Checks</title>
 <tgroup cols=4 align=left>
 <colspec colwidth="40*">
@@ -315,9 +315,9 @@
 call.  It calls <function>file_has_perm</function> with a requested
 file permission based on the command parameter.  
 The basic permission checks performed for each command are shown in
-<xref linkend="filecontrol_table">.
+<xref linkend="FilecontrolTable">.
 
-<table id="filecontrol_table" frame=all>
+<table id="FilecontrolTable" frame=all>
 <title>File Control Permission Checks</title>
 <tgroup cols=4 align=left>
 <thead>
@@ -376,7 +376,7 @@
 </para>
 </sect3>
 
-<sect3 id="send_sigiotask"><title>selinux_file_send_sigiotask</title>
+<sect3 id="SendSigiotask"><title>selinux_file_send_sigiotask</title>
 <para>
 This hook function is called to check whether a signal generated by an
 event on a file descriptor can be sent to a task.  This function is


--- orig/module/helper.sgml
+++ mod/module/helper.sgml
@@ -8,7 +8,7 @@
 in the appropriate hooks section.
 </para>
 
-<sect2 id="alloc_free"><title>Primitive Allocation Helper Functions</title>
+<sect2 id="AllocFree"><title>Primitive Allocation Helper Functions</title>
 
 <para>
 For each SELinux security data structure defined in
@@ -105,8 +105,8 @@
 limited.  The SELinux module does what it can to determine the correct
 attributes after the fact, but it isn't always successful in the
 dynamically loaded module case.  This is discussed in detail for
-inodes in <XRef LinkEnd="inode_precondition"> and for tasks in <XRef
-LinkEnd="task_precondition">.  We recommend always compiling the
+inodes in <XRef LinkEnd="InodePrecondition"> and for tasks in <XRef
+LinkEnd="TaskPrecondition">.  We recommend always compiling the
 SELinux module into the kernel.
 </para>
 


--- orig/module/init.sgml
+++ mod/module/init.sgml
@@ -1,4 +1,4 @@
-<sect1 id="init_exit"><title>Initialization and Exit</title>
+<sect1 id="InitExit"><title>Initialization and Exit</title>
 
 <para>
 This section describes the initialization and exit code for the


--- orig/module/inode.sgml
+++ mod/module/inode.sgml
@@ -13,7 +13,7 @@
 control.
 </para>
 
-<sect2 id="inode_security"><title>Managing Inode Security Fields</title>
+<sect2 id="InodeSecurity"><title>Managing Inode Security Fields</title>
 <sect3><title>Inode Security Structure</title>
 <para>
 The <structname>inode_security_struct</structname> structure contains
@@ -134,7 +134,7 @@
 
 </sect3>
 
-<sect3 id="inode_precondition"><title>inode_precondition</title>
+<sect3 id="InodePrecondition"><title>inode_precondition</title>
 
 <para>
 This helper function is the
@@ -154,15 +154,15 @@
 <function>socket_type_to_security_class</function> function is used to
 obtain the security class based on the socket family and type.  The
 socket security classes are described in <XRef
-LinkEnd="socket_post_create">.  Otherwise, the
+LinkEnd="SocketPostCreate">.  Otherwise, the
 <function>inode_mode_to_security_class</function> function is used to
 obtain the security class based on the inode mode.  The mapping
 between inode modes and security classes is described in
-<xref linkend="inodeclasses_table">.  If the inode does not have any
-of the modes listed in <xref linkend="inodeclasses_table">, 
+<xref linkend="InodeclassesTable">.  If the inode does not have any
+of the modes listed in <xref linkend="InodeclassesTable">, 
 then it defaults to the file security class.
 
-<table id="inodeclasses_table" frame=all>
+<table id="InodeclassesTable" frame=all>
 <title>Inode Security Classes</title>
 <tgroup cols=2 align=left>
 <thead>
@@ -383,7 +383,7 @@
 
 </sect2>
 
-<sect2 id="inode_ac"><title>Controlling Inode Operations</title>
+<sect2 id="InodeAc"><title>Controlling Inode Operations</title>
 
 <sect3><title>inode_has_perm</title>
 <para>
@@ -419,9 +419,9 @@
 new file.  If so, then this SID is used.  Otherwise, a SID is obtained
 from the security server using the
 <function>security_transition_sid</function> interface.  The function
-then checks permissions as described in <xref linkend="createperm_table">.
+then checks permissions as described in <xref linkend="CreatepermTable">.
 
-<table id="createperm_table" frame=all>
+<table id="CreatepermTable" frame=all>
 <title>Create Permission Checks</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -470,9 +470,9 @@
 a file or directory.  It takes the parent directory inode, the <structname>dentry</structname>
 of the file, and a flag indicating the requested operation.  The
 permission checks for these operations are shown in 
-<xref linkend="linkperm_table"> and <xref linkend="unlinkperm_table">.
+<xref linkend="LinkpermTable"> and <xref linkend="UnlinkpermTable">.
 
-<table id="linkperm_table" frame=all>
+<table id="LinkpermTable" frame=all>
 <title>Link Permission Checks</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -497,7 +497,7 @@
 </tgroup>
 </table>
 
-<table id="unlinkperm_table" frame=all>
+<table id="UnlinkpermTable" frame=all>
 <title>Unlink or Rmdir Permission Checks</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -540,18 +540,18 @@
 directory.  It takes the inodes of the old and new parent directories,
 the <structname>dentry</structname> of an existing link to the file, and the new <structname>dentry</structname> for the
 file.  This function checks the permissions described in
-<xref linkend="renameperm_table">, <xref linkend="additionalrename_table">, 
-and <xref linkend="additionalparent_table">.
-The permissions in <xref linkend="renameperm_table"> are always
-checked.  The permissions in <xref linkend="additionalrename_table">
+<xref linkend="RenamepermTable">, <xref linkend="AdditionalrenameTable">, 
+and <xref linkend="AdditionalparentTable">.
+The permissions in <xref linkend="RenamepermTable"> are always
+checked.  The permissions in <xref linkend="AdditionalrenameTable">
 are only checked if the new <structname>dentry</structname>
 already has an existing inode (i.e. a file already exists with the
 new name), in which case that file will be removed by the rename.  The
-permissions in <xref linkend="additionalparent_table"> are only
+permissions in <xref linkend="AdditionalparentTable"> are only
 checked if the file is a directory and its parent directory is being
 changed by the rename.
 
-<table id="renameperm_table" frame=all>
+<table id="RenamepermTable" frame=all>
 <title>Basic Rename Permission Checks</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -581,7 +581,7 @@
 </tgroup>
 </table>
 
-<table id="additionalrename_table" frame=all>
+<table id="AdditionalrenameTable" frame=all>
 <title>Additional Rename Permission Checks if NewFile Exists</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -606,7 +606,7 @@
 </tgroup>
 </table>
 
-<table id="additionalparent_table" frame=all>
+<table id="AdditionalparentTable" frame=all>
 <title>Additional Rename Permission Checks if Reparenting</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -636,7 +636,7 @@
 
 </sect3>
 
-<sect3 id="inode_permission"><title>selinux_inode_permission</title>
+<sect3 id="InodePermission"><title>selinux_inode_permission</title>
 
 <para>
 This hook function is called by the Linux
@@ -644,14 +644,14 @@
 accessing an inode.  It converts the permission mask to an access
 vector using the <function>file_mask_to_av</function> function, and
 calls <function>inode_has_perm</function> with the appropriate
-parameters.  <xref linkend="dirperms_table"> specifies the SELinux permission
+parameters.  <xref linkend="DirpermsTable"> specifies the SELinux permission
 that is checked for each permission mask flag when checking access
-to a directory.  <xref linkend="nondirperm_table"> provides the corresponding
+to a directory.  <xref linkend="NondirpermTable"> provides the corresponding
 permission information when checking access to a non-directory file.
 </para>
  
 <para>
-In <xref linkend="dirperms_table">, notice that a
+In <xref linkend="DirpermsTable">, notice that a
 write permission mask causes the general <constant>write</constant>
 permission to be checked.  This hook function cannot distinguish among
 the various kinds of modification operations on directories, so it
@@ -664,7 +664,7 @@
 could be omitted from this hook, but it is performed to ensure that all
 directory modifications are mediated by the policy.
 
-<table id="dirperms_table" frame=all>
+<table id="DirpermsTable" frame=all>
 <title>Directory Permission Checks</title>
 <tgroup cols=2 align=left>
 <thead>
@@ -694,7 +694,7 @@
 
 <para>
 
-In <xref linkend="nondirperm_table">, notice that a
+In <xref linkend="NondirpermTable">, notice that a
 separate <constant>MAY_APPEND</constant> permission mask and
 <constant>append</constant> permission are listed.  This permission
 mask was added by the LSM kernel patch and is used (along with
@@ -705,7 +705,7 @@
 <constant>O_APPEND</constant> flag is not subsequently cleared unless
 the process has <constant>write</constant> permission to the file.
 
-<table id="nondirperm_table" frame=all>
+<table id="NondirpermTable" frame=all>
 <title>Non-Directory Permission Checks</title>
 <tgroup cols=2 align=left>
 <thead>
@@ -744,9 +744,9 @@
 for various operations.  Since each of these remaining hook functions
 only require a single permission between the current task and the
 file, the permission checks are all described in 
-<xref linkend="miscinode_table">.
+<xref linkend="MiscinodeTable">.
 
-<table id="miscinode_table" frame=all>
+<table id="MiscinodeTable" frame=all>
 <title>Remaining Inode Hook Permission Checks</title>
 <tgroup cols=2 align=left>
 <thead>


--- orig/module/ip.sgml
+++ mod/module/ip.sgml
@@ -44,9 +44,9 @@
 on the protocol type) between the network buffer and the receiving
 network interface and a permission between the network buffer and the
 source node.  The permission checked for each protocol type is shown
-in <xref linkend="packetrcv_table">.
+in <xref linkend="PacketrcvTable">.
 
-<table id="packetrcv_table" frame=all>
+<table id="PacketrcvTable" frame=all>
 <title>Packet Receive Permissions</title>
 <tgroup cols=2 align=left>
 <thead>
@@ -137,7 +137,7 @@
 type) between the network buffer and the sending network device. It
 also checks the same permission between the network buffer and the
 destination node.  The permission checked for each protocol type is
-shown in <xref linkend="packetsnd_table">. The SID used in these
+shown in <xref linkend="PacketsndTable">. The SID used in these
 checks is the message SID stored in the network buffer security
 structure. In the case of forwarded packets, this SID was initialized
 by the <function>selinux_ip_preroute_last</function> hook during input
@@ -145,7 +145,7 @@
 <function>selinux_skb_set_owner_w</function> hook sets the message
 SID.
 
-<table id="packetsnd_table" frame=all>
+<table id="PacketsndTable" frame=all>
 <title>Packet Send Permissions</title>
 <tgroup cols=2 align=left>
 <thead>


--- orig/module/ipc.sgml
+++ mod/module/ipc.sgml
@@ -6,7 +6,7 @@
 describes these hooks and their helper functions.
 </para>
 
-<sect2 id="ipc_security"><title>Managing System V IPC Security Fields</title>
+<sect2 id="IpcSecurity"><title>Managing System V IPC Security Fields</title>
 
 <sect3><title>IPC Security Structure</title>
 <para>
@@ -24,7 +24,7 @@
 };
 </programlisting>
 
-<table id="ipc_security_struct_table" frame=all>
+<table id="IpcSecurityStructTable" frame=all>
 <title>ipc_security_struct</title>
 <tgroup cols=2 align=left>
 <colspec colwidth="20*">
@@ -49,7 +49,7 @@
 <row>
     <entry>sclass</entry>
     <entry>Security class for the IPC object (see 
-	<xref linkend="ipc_alloc">).
+	<xref linkend="IpcAlloc">).
     </entry>
 </row>
 <row>
@@ -128,7 +128,7 @@
 
 </sect3>
 
-<sect3 id="ipc_alloc"><title>ipc_alloc_security and ipc_free_security</title>
+<sect3 id="IpcAlloc"><title>ipc_alloc_security and ipc_free_security</title>
 <para>
 The <function>ipc_alloc_security</function> and
 <function>ipc_free_security</function> helper functions are the
@@ -257,21 +257,21 @@
 </para>
 </sect3>
 
-<sect3 id="ipc_permission"><title>selinux_ipc_permission</title>
+<sect3 id="IpcPermission"><title>selinux_ipc_permission</title>
 <para>
 This hook function is called from the kernel
 <function>ipcperms</function> function, so it is called prior to all
 IPC operations that will read or modify the IPC object.  This hook
 function checks <constant>unix_read</constant> and/or
 <constant>unix_write</constant> permission to the IPC object based on
-the flag, as shown in <xref linkend="ipcperm_table">.  These
+the flag, as shown in <xref linkend="IpcpermTable">.  These
 permissions provide a coarse-grained equivalent to the Unix
 permissions, whereas the other IPC hooks check finer-grained
 permissions.  These coarse-grained permission checks are not strictly
 necessary, but ensure that all IPC accesses are mediated by the
 policy.
 
-<table id="ipcperm_table" frame=all>
+<table id="IpcpermTable" frame=all>
 <title>ipc_permission Permission Checks</title>
 <tgroup cols=2 align=left>
 <thead>
@@ -333,10 +333,10 @@
 This hook function checks permissions before performing an operation on the
 specified semaphore; the specific permission is determined by the
 operation being performed. The permissions required for each operation
-are shown in <xref linkend="semcontrol_table">.
+are shown in <xref linkend="SemcontrolTable">.
 
 
-<table id="semcontrol_table" frame=all>
+<table id="SemcontrolTable" frame=all>
 <title> Semaphore Control Permissions</title>
 <tgroup cols=4 align=left>
 <thead>
@@ -421,9 +421,9 @@
 This hook function checks permissions before performing an operation on the
 specified shared memory region; the specific permission is determined by the
 operation being performed. The permissions required for each operation
-are shown in <xref linkend="shmcontrol_table">.
+are shown in <xref linkend="ShmcontrolTable">.
 
-<table id="shmcontrol_table" frame=all>
+<table id="ShmcontrolTable" frame=all>
 <title> Shared Memory Control Permissions</title>
 <tgroup cols=4 align=left>
 <thead>
@@ -494,9 +494,9 @@
 This hook function checks permissions before performing an operation on the
 specified message queue; the specific permission is determined by the
 operation being performed.  The permissions required for each
-operation are shown in <xref linkend="msgcontrol_table">.
+operation are shown in <xref linkend="MsgcontrolTable">.
 
-<table id="msgcontrol_table" frame=all>
+<table id="MsgcontrolTable" frame=all>
 <title> Message Queue Control Permissions</title>
 <tgroup cols=4 align=left>
 <thead>
@@ -541,7 +541,7 @@
 call to check the ability to place an individual message on a message
 queue.  It performs three permission checks, involving the current
 task, the message queue, and the individual message.  These checks are
-shown in <xref linkend="msgsnd_table">.  This hook function also sets the SID on the
+shown in <xref linkend="MsgsndTable">.  This hook function also sets the SID on the
 message if it is unlabeled.  It uses the SID from the <structfield>in_sid</structfield> array of
 the task security structure if the new
 <function>msgsnd_secure</function> system call was used.  Otherwise,
@@ -549,7 +549,7 @@
 the security server to obtain a SID based on the SID of the task and
 the SID of the message queue.
 
-<table id="msgsnd_table" frame=all>
+<table id="MsgsndTable" frame=all>
 <title>Message Send Permissions</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -590,7 +590,7 @@
 receiving task may not be the current task and is explicitly passed to
 the hook. This hook function performs two permission checks, involving
 the receiving task, the message queue, and the individual message.
-These permission checks are shown in <xref linkend="msgrcv_table">.
+These permission checks are shown in <xref linkend="MsgrcvTable">.
 In the case that the new <function>msgrcv_secure</function> system
 call is being used to specify a desired message SID, then this hook
 also checks the actual message SID against the desired message SID.
@@ -602,7 +602,7 @@
 process and may cause the calling process to block waiting for
 messages that are accessible.
 
-<table id="msgrcv_table" frame=all>
+<table id="MsgrcvTable" frame=all>
 <title>Message Receive Permissions</title>
 <tgroup cols=3 align=left>
 <thead>


--- orig/module/nsid.sgml
+++ mod/module/nsid.sgml
@@ -11,7 +11,7 @@
 <citation><XRef LinkEnd="MorrisSeloptOverview02"></citation>.
 </para>
 
-<sect2 id="nsid_functions"><title>NSID API</title>
+<sect2 id="NsidFunctions"><title>NSID API</title>
 <para>
 The Network SID (NSID) API provides a general framework for labeled
 networking that is intended to be independent of the underlying
@@ -130,7 +130,7 @@
 
 </para>
 
-<sect3 id="selopt_ip_label_output"<title>selopt_ip_label_output</title>
+<sect3 id="SeloptIpLabelOutput"><title>selopt_ip_label_output</title>
 <para>
 This function adds security labels to the IP packet by copying the
 SIDs from the network buffer security structure into the IP packet's
@@ -141,7 +141,7 @@
 </para>
 </sect3>
 
-<sect3 id="selopt_ip_map_input"<title>selopt_ip_map_input</title>
+<sect3 id="SeloptIpMapInput"><title>selopt_ip_map_input</title>
 <para>
 This function will return <constant>NF_DROP</constant> for any packet
 from outside the perimeter that is labeled, and for any unlabeled packet
@@ -165,7 +165,7 @@
 </para>
 </sect3>
 
-<sect3 id="selopt_ip_decode_options"<title>selopt_ip_decode_options</title>
+<sect3 id="SeloptIpDecodeOptions"><title>selopt_ip_decode_options</title>
 <para>
 This function will decode the security labels from the options field
 of the IP packet header. For packets that are not being delivered to
@@ -176,7 +176,7 @@
 </para>
 </sect3>
 
-<sect3 id="selopt_ip_defragment"<title>selopt_ip_defragment</title>
+<sect3 id="SeloptIpDefragment"><title>selopt_ip_defragment</title>
 <para>
 This function is used verify security labels across IP fragments. At this
 time, labeled fragments are not supported, so this function prints a
@@ -184,7 +184,7 @@
 </para>
 </sect3>
 
-<sect3 id="selopt_sock_sendmsg"<title>selopt_sock_sendmsg</title>
+<sect3 id="SeloptSockSendmsg"><title>selopt_sock_sendmsg</title>
 <para>
 Before an IP packet with options can be sent out, the maximum segment size
 (<acronym>MSS</acronym>) must be adjusted. This function is called by the 


--- orig/module/sb.sgml
+++ mod/module/sb.sgml
@@ -8,7 +8,7 @@
 discusses the superblock hook functions for performing access control.
 </para>
 
-<sect2 id="sb_security"><title>Managing Superblock Security Fields</title>
+<sect2 id="SbSecurity"><title>Managing Superblock Security Fields</title>
 <sect3><title>Superblock Security Structure</title>
 <para>
 The <structname>superblock_security_struct</structname> structure
@@ -192,7 +192,7 @@
 
 </sect2>
 
-<sect2 id="sb_ac"><title>Controlling Filesystem Operations</title>
+<sect2 id="SbAc"><title>Controlling Filesystem Operations</title>
 
 <sect3><title>superblock_has_perm</title> 
 <para>
@@ -268,9 +268,9 @@
 <sect3><title>Summary of Filesystem Permission Checks</title>
 <para>
 The permission checks for the super_block hooks are summarized
-in <xref linkend="fsperm_table">.
+in <xref linkend="FspermTable">.
 
-<table id="fsperm_table" frame=all>
+<table id="FspermTable" frame=all>
 <title>Filesystem Permission Checks</title>
 <tgroup cols=4 align=left>
 <thead>


--- orig/module/skb.sgml
+++ mod/module/skb.sgml
@@ -20,7 +20,7 @@
 implementation for these two hooks.
 </para>
 
-<sect2 id="skb_security"><title>Network Buffer Security Structure</title>
+<sect2 id="SkbSecurity"><title>Network Buffer Security Structure</title>
 <para>
 The <structname>skb_security_struct</structname> structure contains security
 information for network buffers. This structure is defined as:
@@ -109,14 +109,14 @@
 
 <para>
 See <xref linkend="nsid">, <xref linkend="ip">, and <xref
-linkend="sock_rcv_skb"> for a discussion of how these fields are used
+linkend="SockRcvSkb"> for a discussion of how these fields are used
 by the labeled networking support, the IP hooks, and the
 <function>sock_rcv_skb</function> hook.
 </para>
 
 </sect2>
 
-<sect2 id="selinux_skb_set_owner_w"><title>selinux_skb_set_owner_w</title>
+<sect2 id="SelinuxSkbSetOwnerW"><title>selinux_skb_set_owner_w</title>
 <para>
 This hook sets the SID fields in a network buffer for an outgoing
 packet when the buffer is associated with a particular sending socket.
@@ -147,13 +147,13 @@
 the source socket SID and message SID for the network buffer are set
 by default to the SID of the sending socket.  However, the extended
 socket calls may change the SIDs used for the network
-buffer.  See <xref linkend="extsocket_skb_set_owner_w"> for a
+buffer.  See <xref linkend="ExtsocketSkbSetOwnerW"> for a
 discussion of the optional extended socket call processing.
 </para>
 
 </sect2>
 
-<sect2 id="selinux_skb_recv_datagram"><title>selinux_skb_recv_datagram</title>
+<sect2 id="SelinuxSkbRecvDatagram"><title>selinux_skb_recv_datagram</title>
 <para>
 This hook calls the <function>extsocket_skb_recv_datagram</function> function
 to perform the processing necessary for the extended socket calls.


--- orig/module/socket.sgml
+++ mod/module/socket.sgml
@@ -98,14 +98,14 @@
 <function>inode_alloc_security</function>,
 <function>inode_free_security</function> and
 <function>inode_precondition</function> functions are also applicable
-to sockets.  See <XRef LinkEnd="inode_security"> for a discussion of
+to sockets.  See <XRef LinkEnd="InodeSecurity"> for a discussion of
 these functions.  However, additional socket-specific hook functions
 are necessary to initialize and manage the information in these
 inode security structures for sockets.  These hook functions are
 described below.
 </para>
 
-<sect3 id="socket_post_create"><title>selinux_socket_post_create</title>
+<sect3 id="SocketPostCreate"><title>selinux_socket_post_create</title>
 <para>
 After a <structname>socket</structname> structure has been
 successfully created, this hook function is called to update the inode
@@ -115,14 +115,14 @@
 for the different types of sockets, as determined by the type and
 protocol family specified as parameters to the
 <function>socket</function> system call.  The security class is
-assigned according to <xref linkend="sockclass_table">.  If the socket
+assigned according to <xref linkend="SockclassTable">.  If the socket
 does not match any of the specified types, it defaults to the generic
 socket security class. The kernel socket (<structname>struct sock</structname>)
 associated with the socket will have it's SID set to the user socket SID.
 This SID is used to label outgoing packets from
 a socket that has no user space socket structure associated with it.
 
-<table id="sockclass_table" frame=all>
+<table id="SockclassTable" frame=all>
 <title> Socket Security Classes</title>
 <tgroup cols=3 align=left>
 <thead>
@@ -176,13 +176,13 @@
 </para>
 </sect3>
 
-<sect3 id="socket_accept"><title>selinux_socket_accept</title>
+<sect3 id="SocketAccept"><title>selinux_socket_accept</title>
 <para>
 This hook function is called after a new
 <structname>socket</structname> has been created for the connection
 but prior to calling the protocol family's accept function.  In
 addition to checking permission (discussed further in <XRef
-LinkEnd="socket_ac">), this hook function sets the SID and security
+LinkEnd="SocketAc">), this hook function sets the SID and security
 class for the new socket.  The new socket always inherits the security
 class of the listening socket.  By default, the new socket SID
 is initialized to the SID of the listening socket.  The
@@ -192,7 +192,7 @@
 </para>
 </sect3>
 
-<sect3 id="socket_post_accept"><title>selinux_socket_post_accept</title>
+<sect3 id="SocketPostAccept"><title>selinux_socket_post_accept</title>
 <para>
 This hook function is called after calling the protocol family's
 <function>accept</function> function.  This hook calls the
@@ -201,7 +201,7 @@
 </para>
 </sect3>
 
-<sect3 id="tcp_connection_request"><title>selinux_tcp_connection_request</title>
+<sect3 id="TcpConnectionRequest"><title>selinux_tcp_connection_request</title>
 <para>
 A new connection is being requested on a listening socket. This hook allows
 the LSM module to maintain security information about the client during the
@@ -210,7 +210,7 @@
 </para>
 </sect3>
 
-<sect3 id="tcp_synack"><title>selinux_tcp_synack</title>
+<sect3 id="TcpSynack"><title>selinux_tcp_synack</title>
 <para>
 A reply SYN/ACK is being sent for a connection request. This hook allows
 the LSM module to label the SYN/ACK packet. For SELinux, the label used
@@ -222,7 +222,7 @@
 </para>
 </sect3>
 
-<sect3 id="tcp_create_openreq_child"><title>selinux_tcp_create_openreq_child</title>
+<sect3 id="TcpCreateOpenreqChild"><title>selinux_tcp_create_openreq_child</title>
 <para>
 This hook is called when a new TCP kernel socket is created,
 typically during the <function>accept</function> system call. The 
@@ -236,7 +236,7 @@
 
 </sect2>
 
-<sect2 id="socket_ac"><title>Controlling Socket Operations</title>
+<sect2 id="SocketAc"><title>Controlling Socket Operations</title>
 
 <sect3><title>socket_has_perm</title> 
 <para>
@@ -255,11 +255,11 @@
 are needed for additional processing).  Some of the
 hook functions perform additional processing.  The hook functions and
 the initial permission that they check are shown in <xref
-linkend="socklayer_table">.  Any additional processing for the hook
+linkend="SocklayerTable">.  Any additional processing for the hook
 functions, excluding the optional extended socket call processing, is
 then described in the following subsections.
 
-<table id="socklayer_table" frame=all>
+<table id="SocklayerTable" frame=all>
 <title>Socket Layer Hook Permission Checks</title>
 <tgroup cols=4 align=left>
 <colspec colwidth="35*">
@@ -352,7 +352,7 @@
 </table>
 </para>
 
-<sect4 id="selinux_socket_bind"><title>selinux_socket_bind</title> 
+<sect4 id="SelinuxSocketBind"><title>selinux_socket_bind</title> 
 <para>
 The <function>selinux_socket_bind</function> hook function
 performs an additional <constant>name_bind</constant> permission
@@ -361,7 +361,7 @@
 </para>
 </sect4>
 
-<sect4 id="selinux_socket_sendmsg"><title>selinux_socket_sendmsg</title>
+<sect4 id="SelinuxSocketSendmsg"><title>selinux_socket_sendmsg</title>
 <para>
 Prior to returning, this hook function calls the <acronym>NSID</acronym> hook
 <function>nsid_sock_sendmsg</function> to adjust the maximum segment
@@ -373,7 +373,7 @@
 
 </sect3>
 
-<sect3 id="sock_rcv_skb"><title>selinux_socket_sock_rcv_skb (Transport Layer Hook)</title> 
+<sect3 id="SockRcvSkb"><title>selinux_socket_sock_rcv_skb (Transport Layer Hook)</title> 
 <para>
 This hook function is called by the transport layer network protocols
 (e.g. UDP, TCP, raw IP, etc) to control receipt of individual packets
@@ -423,7 +423,7 @@
 of the socket and the kind of packet, additional processing may be
 performed.  The additional processing is described below, and the
 additional permission checks are shown in <xref
-linkend="conperm_table">.  The optional extended socket call processing is
+linkend="ConpermTable">.  The optional extended socket call processing is
 described separately in <xref linkend="extsocket">.
 </para>
 
@@ -442,7 +442,7 @@
 </para>
 
 <para>
-<table id="conperm_table" frame=all>
+<table id="ConpermTable" frame=all>
 <title>Connection Establishment Permission Checks</title>
 <tgroup cols=5 align=left>
 <colspec colwidth="35*">
@@ -507,8 +507,8 @@
 called for Unix datagram communications.  It checks the
 <constant>sendto</constant> permission between the sending socket and
 the receiving socket.  These permission checks are summarized in 
-<xref linkend="domaincheck_table">.
-<table id="domaincheck_table" frame=all>
+<xref linkend="DomaincheckTable">.
+<table id="DomaincheckTable" frame=all>
 <title>Unix Domain Permission Checks</title>
 <tgroup cols=4 align=left>
 <colspec colwidth="40*">
@@ -772,7 +772,7 @@
 </para>
 </sect4>
 
-<sect4 id="extsocket_post_accept"><title>extsocket_post_accept</title>
+<sect4 id="ExtsocketPostAccept"><title>extsocket_post_accept</title>
 <para>
 This function is called by
 <function>selinux_socket_post_accept</function>.
@@ -790,7 +790,7 @@
 
 </sect4>
 
-<sect4 id="extsocket_sendmsg"><title>extsocket_sendmsg</title>
+<sect4 id="ExtsocketSendmsg"><title>extsocket_sendmsg</title>
 <para>
 This function is called by <function>selinux_socket_sendmsg</function>.
 If the socket is a stream socket, then this function verifies
@@ -887,7 +887,7 @@
 </para>
 </sect4>
 
-<sect4 id="extsocket_sock_rcv_skb"><title>extsocket_sock_rcv_skb</title>
+<sect4 id="ExtsocketSockRcvSkb"><title>extsocket_sock_rcv_skb</title>
 <para>
 This function is called by <function>selinux_sock_rcv_skb</function>.
 If the socket is a TCP socket in the <constant>TCP_LISTEN</constant>
@@ -1033,7 +1033,7 @@
 
 </sect4>
 
-<sect4 id="extsocket_skb_set_owner_w"><title>extsocket_skb_set_owner_w</title>
+<sect4 id="ExtsocketSkbSetOwnerW"><title>extsocket_skb_set_owner_w</title>
 <para>
 This function is called by <function>selinux_skb_set_owner_w</function>.
 If the message SID (non-stream only) or destination socket SID are set
@@ -1041,7 +1041,7 @@
 then cleared from the socket.  These SID fields in the socket's inode
 security structure are set during
 <function>selinux_socket_sendmsg</function>. [XXX This is unreliable,
-see <xref linkend="extsocket_sendmsg">.]
+see <xref linkend="ExtsocketSendmsg">.]
 </para>
 </sect4>
 


--- orig/module/stacking.sgml
+++ mod/module/stacking.sgml
@@ -17,7 +17,7 @@
 </para>
 
 <para>
-As mentioned in <XRef LinkEnd="init_exit">, the
+As mentioned in <XRef LinkEnd="InitExit">, the
 <function>selinux_plug_init</function> function initializes the
 secondary security module to the dummy security module, which is
 always resident in the kernel, prior to registering the SELinux


--- orig/module/system.sgml
+++ mod/module/system.sgml
@@ -137,14 +137,14 @@
 <function>capable</function> hook and a separate hook that offers
 finer-grained control.  In many of these cases, the checking performed
 by <function>selinux_capable</function> is adequate for SELinux, so no
-other processing is required.  <xref linkend="sysdefer_table"> lists system 
+other processing is required.  <xref linkend="SysdeferTable"> lists system 
 hook functions for which no additional processing is required and the
 capability permission that is used to control the same operation.
 Of course, finer-grained permissions may be added to SELinux in the
 future, e.g. a permission to control what files can be used for
 accounting, so these hooks may be used at a later point in time.
 
-<table id="sysdefer_table" frame=all>
+<table id="SysdeferTable" frame=all>
 <title>System Hook Functions that Defer to Capable</title>
 <tgroup cols=2 align=left>
 <thead>
@@ -227,9 +227,9 @@
 It then performs a permission check based on the requested operation,
 treating the sysctl entry as a directory for search operations and
 as a file for read or write operations on a variable.
-<xref linkend="sysctlperm_table"> shows the permission checks associated with
+<xref linkend="SysctlpermTable"> shows the permission checks associated with
 each requested operation.
-<table id="sysctlperm_table" frame=all>
+<table id="SysctlpermTable" frame=all>
 <title>sysctl Permission Checks</title>
 <tgroup cols=4 align=left>
 <thead>
@@ -337,12 +337,12 @@
 <sect2><title>Remaining System Hook Functions</title>
 <para>
 Each of the remaining system hook functions performs a simple
-permission check, as summarized in <xref linkend="sysremain_table">.  The
+permission check, as summarized in <xref linkend="SysremainTable">.  The
 <function>selinux_ptrace</function> hook function also calls the
 secondary module to permit it to perform additional capability
 checking.
 
-<table id="sysremain_table" frame=all>
+<table id="SysremainTable" frame=all>
 <title>Remaining System Hook Function Permission Checks</title>
 <tgroup cols=4 align=left>
 <thead>


--- orig/module/task.sgml
+++ mod/module/task.sgml
@@ -7,7 +7,7 @@
 describes these hooks and their helper functions.
 </para>
 
-<sect2 id="task_security"><title>Managing Task Security Fields</title>
+<sect2 id="TaskSecurity"><title>Managing Task Security Fields</title>
 <sect3><title>Task Security Structure</title>
 <para>
 The <structname>task_security_struct</structname> structure contains
@@ -92,7 +92,7 @@
 </para>
 </sect3>
 
-<sect3 id="task_precondition"><title>task_precondition</title>
+<sect3 id="TaskPrecondition"><title>task_precondition</title>
 <para>
 This helper function is the
 precondition function for task security structures.  This function
@@ -154,13 +154,13 @@
 
 </sect2>
 
-<sect2 id="task_ac"><title>Controlling Task Operations</title>
+<sect2 id="TaskAc"><title>Controlling Task Operations</title>
 
 <sect3><title>Helper Functions for Checking Task Permissions</title>
 <para>
 Several helper functions are provided for performing task permission
 checks.  These functions and their permission checks are summarized in
-<xref linkend="tskhelp_table">. The <function>task_has_perm</function> function
+<xref linkend="TskhelpTable">. The <function>task_has_perm</function> function
 checks whether a task has a particular permission to another task.
 The <function>task_has_capability</function> function checks whether a
 task has permission to use a particular Linux capability.  The
@@ -172,7 +172,7 @@
 <function>task_has_security</function> function checks whether a task
 has permission to use one of the security server system calls.
 
-<table id="tskhelp_table" frame=all>
+<table id="TskhelpTable" frame=all>
 <title>Task Helper Function Permission Checks</title>
 <tgroup cols=4 align=left>
 <thead>
@@ -228,10 +228,10 @@
 <sect3><title>Hook Functions for Controlling Task Operations</title>
 <para>
 The task hook functions that perform access control and their
-permission checks are summarized in <xref linkend="tskperm_table">.  These
+permission checks are summarized in <xref linkend="TskpermTable">.  These
 functions call the <function>task_has_perm</function> helper function.
 
-<table id="tskperm_table" frame=all>
+<table id="TskpermTable" frame=all>
 <title>Task Hook Function Permission Checks</title>
 <tgroup cols=4 align=left>
 <colspec colwidth="40*">


--- orig/policy/apps.sgml
+++ mod/policy/apps.sgml
@@ -178,7 +178,7 @@
 Each file is discussed below.
 </para>
 
-<sect3 id="default_contexts"><title>Default_Contexts</title>
+<sect3 id="DefaultContexts"><title>Default_Contexts</title>
 <para>
 The modified daemons ask the security server for the set of legal SIDs
 for a given user that are reachable from the current process SID
@@ -223,7 +223,7 @@
 </para>
 </sect3>
 
-<sect3 id="default_type"><title>Default_Type</title>
+<sect3 id="DefaultType"><title>Default_Type</title>
 <para>
 The <filename>default_type</filename> file defines the default type
 (domain) for each role.  Each line specifies a role:type pair, and the
@@ -236,7 +236,7 @@
 </para>
 </sect3>
 
-<sect3 id="initrc_context"><title>Initrc_Context</title>
+<sect3 id="InitrcContext"><title>Initrc_Context</title>
 <para>
 The <filename>initrc_context</filename> file defines the security
 context for running <filename>/etc/rc.d</filename> scripts via the
@@ -248,7 +248,7 @@
 </para>
 </sect3>
 
-<sect3 id="passwd_context"><title>Passwd_Context and Shadow_Context</title>
+<sect3 id="PasswdContext"><title>Passwd_Context and Shadow_Context</title>
 <para>
 The <filename>passwd_context</filename> and
 <filename>shadow_context</filename> files define the context to be




--=-=-=


-- 
Doubt is a pain too lonely to know that faith is his twin brother. 
 Kahlil Gibran
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
