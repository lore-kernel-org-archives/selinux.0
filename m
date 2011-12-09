Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB9H8VIY018987
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2011 12:08:35 -0500
Received: from nm3.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pB9H8XvI029861
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2011 17:08:33 GMT
Message-ID: <1323450512.6228.YahooMailClassic@web87013.mail.ird.yahoo.com>
Date: Fri, 9 Dec 2011 17:08:32 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] libselinux: Add new libselinux(7) man page
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add new libselinux(7) man page and update the man page Makefile.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/Makefile          |    3 +
 libselinux/man/man7/libselinux.7 |  524 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 527 insertions(+), 0 deletions(-)
 create mode 100644 libselinux/man/man7/libselinux.7

diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
index a20a5d1..a981997 100644
--- a/libselinux/man/Makefile
+++ b/libselinux/man/Makefile
@@ -1,5 +1,6 @@
 # Installation directories.
 MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
+MAN7DIR ?= $(DESTDIR)/usr/share/man/man7
 MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
 MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
 
@@ -8,8 +9,10 @@ all:
 install: all
 	mkdir -p $(MAN3DIR)
 	mkdir -p $(MAN5DIR)
+	mkdir -p $(MAN7DIR)
 	mkdir -p $(MAN8DIR)
 	install -m 644 man3/*.3 $(MAN3DIR)
 	install -m 644 man5/*.5 $(MAN5DIR)
+	install -m 644 man7/*.7 $(MAN7DIR)
 	install -m 644 man8/*.8 $(MAN8DIR)
 
diff --git a/libselinux/man/man7/libselinux.7 b/libselinux/man/man7/libselinux.7
new file mode 100644
index 0000000..6faf03d
--- /dev/null
+++ b/libselinux/man/man7/libselinux.7
@@ -0,0 +1,524 @@
+.TH "libselinux" "7" "08 Dec 2011" "Security Enhanced Linux" "SELinux Userspace API Library"
+
+.SH "NAME"
+libselinux \- Information for writing SELinux-aware userspace applications and object managers using libselinux functions.
+
+.SH "INTRODUCTION"
+libselinux contains all the SELinux functions necessary to build userspace SELinux-aware applications and object managers using 'C', Python, Ruby and PHP languages.
+.sp
+The library hides the low level functionality of (but not limited to):
+.RS
+.IP "1." 4
+The SELinux filesystem that interfaces to the SELinux kernel security server.
+.IP "2." 4
+The proc filesystem that maintains process state information and security contexts \- see  \fBproc\fR(5).
+.IP "3." 4
+Extended attribute services that manage the extended attributes associated to files, sockets etc. \- see \fBattr\fR(5).
+.IP "4." 4
+The SELinux policy and its associated configuration files.
+.RE
+.sp
+The general category of functions available in libselinux are shown in the table below:
+.TS
+center, allbox, tab(@);
+lB lB
+lw(3i) lw(3i) .
+Function Category@Description
+T{
+Access Vector Cache Services
+T}@T{
+Allow access decisions to be cached and audited.
+T}
+T{
+Boolean Services
+T}@T{
+Manage booleans.
+T}
+T{
+Class and Permission Management
+T}@T{
+Class / permission string conversion and mapping.
+T}
+T{
+Compute Access Decisions
+T}@T{
+Determine if access is allowed or denied.
+T}
+T{
+Compute Labeling
+T}@T{
+Compute labels to be applied to instances of an object.
+T}
+T{
+Default File Labeling
+T}@T{
+Obtain default contexts for file operations.
+T}
+T{
+File Creation Labeling
+T}@T{
+Get and set file creation contexts.
+T}
+T{
+File Labeling
+T}@T{
+Get and set file and file descriptor extended attributes.
+T}
+T{
+General Context Management
+T}@T{
+Check contexts are valid, get and set context components.
+T}
+T{
+Key Creation Labeling
+T}@T{
+Get and set  kernel key creation contexts.
+T}
+T{
+Label Translation Management
+T}@T{
+Translate to/from, raw/readable contexts.
+T}
+T{
+Netlink Services
+T}@T{
+Used to detect policy reloads and enforcement changes.
+T}
+T{
+Process Labeling
+T}@T{
+Get and set process contexts.
+T}
+T{
+SELinux Management Services
+T}@T{
+Load policy, set enforcement mode, obtain SELinux configuration information.
+T}
+T{
+SELinux-aware Application Labeling
+T}@T{
+Retrieve default contexts for applications such as database and X-Windows.
+T}
+T{
+Socket Creation Labeling
+T}@T{
+Get and set socket creation contexts.
+T}
+T{
+User Session Management
+T}@T{
+Retrieve default contexts for user sessions.
+T}
+.TE
+.sp
+.sp
+Other SELinux userspace libraries are:
+.sp
+.RS
+\fBlibsepol\fR - To build and manipulate the contents of SELinux binary policy files.
+.sp
+\fBlibsemanage\fR - To manage the policy infrastructure.
+.RE
+.sp
+Details of the libraries, core SELinux utilities and commands with source code are available at:
+.RS
+http://userspace.selinuxproject.org/trac
+.RE
+.sp
+The versions of kernel, SELinux tools and libraries influence the features available, therefore it is important to establish what level of functionality is required for the application. Generally, the policy version gives an idea of additional features available for SELinux and the table below highlights these.
+.sp
+.TS
+center, allbox, tab(@);
+lB lB
+c lw(5i) .
+Version@Description
+15@T{
+The base version when SELinux was merged into the kernel.
+T}
+16@T{
+Added Conditional Policy support (the bool feature).
+T}
+17@T{
+Added support for IPv6.
+T}
+18@T{
+Added Netlink support.
+T}
+19@T{
+Added MLS support, plus the validatetrans statement.
+T}
+20@T{
+Reduced the size of the kernel access vector table.
+T}
+21@T{
+Added support for the MLS \fBrange_transition\fR statement.
+T}
+22@T{
+Added policy capabilities that allows various kernel options to be enabled.
+T}
+23@T{
+Added the \fBpermissive\fR statement. This allows a module to run in permissive mode while the others are still confined (instead of the all or nothing set by the \fBSELINUX=permissive\fR entry in the \fIconfig\fR file).
+T}
+24@T{
+Add the \fBtypebounds\fR statement to support a hierarchical relationship between two domains in multi-threaded applications.
+T}
+25@T{
+Add support for file name transition in \fBtype_transition\fR rule. Requires kernel 2.6.39 minimum.
+T}
+26@T{
+Add support for class in \fBrole_transition\fR rule. Requires kernel 2.6.39 minimum.
+Add support for the \fBattribute_role\fR and \fBroleattribute\fR statements.
+T}
+.TE
+.sp
+.sp
+Writing kernel based object managers is a more specialised subject and is not covered within this man page.
+
+.SH "SELINUX APPLICATIONS AND OBJECT MANAGERS"
+.SS "SELinux\-aware Application or Object Manager"
+The following definitions attempt to explain the difference between the two types of  userspace SELinux application (however the distinction can get 'blurred'):
+.sp
+.RS
+\fBSELinux-aware\fR - Any application that provides support for SELinux. This generally means that the application makes use of SELinux libraries and/or other SELinux applications.
+.sp
+Example SELinux-aware applications are the Pluggable Authentication Manager (\fBPAM\fR(8)) and SELinux commands such as \fBruncon\fR(1). It is of course possible to class an object manager as an SELinux-aware application.
+.sp
+\fBObject Manager\fR - Object Managers are a specialised form of SELinux-aware application that are responsible for the labeling, management and enforcement (see \fBFOOTNOTE\fR [1]) of the objects under their control.
+.sp
+Generally the userspace Object Manager forms part of an application that can be configured out should the base Linux OS not support SELinux.
+.sp
+Example userspace Object Managers are:
+.sp
+.RS
+.IP "1." 4
+X-SELinux is an optional X-Windows extension responsible for labeling and enforcement of X-Windows objects.
+.IP "2." 4
+Dbus has an optional Object Manager built if SELinux is defined in the Linux build. This is responsible for the labeling and enforcement of Dbus objects.
+.IP "3." 4
+SE-PostgreSQL is an optional extension for PostgreSQL that is responsible for the labeling and enforcement of PostgreSQL database and supporting objects.
+.RE
+.sp
+Therefore the basic distinction is that Object Managers manage their defined objects on behalf of an application, whereas general SELinux-aware applications do not (they rely on 'Object Managers' to do this e.g. the kernel based Object Managers such as those that manage filesystem, IPC and network labeling).
+
+.SS "Types of Object Manager"
+There are three basic forms of userspace object manager:
+.sp
+.RS
+.IP "1." 4
+Those that do not cache access decisions (i.e. they do not use the libselinux AVC services). These require a call to the kernel for every decision using \fBsecurity_compute_av\fR(3) or \fBsecurity_compute_av_flags\fR(3). The \fBavc_netlink_*\fR(3) functions can be used to detect policy change events. Auditing would need to be implemented if required.
+.sp
+An example is the SE-PostgreSQL 9.1 object manager.
+.IP "2." 4
+Those that utilise the libselinux userspace AVC services that are initialised with \fBavc_open\fR(3). These can be built in various configurations such as:
+.sp
+.RS
+.RS
+.IP "a)" 4
+Using the default single threaded mode where \fBavc_has_perm\fR(3) will automatically cache entries, audit the decision and manage the handling of policy change events.
+.IP "b)" 4
+Implementing threads or a similar service that will handle policy change events and auditing in real time with \fBavc_has_perm\fR(3) or \fBavc_has_perm_noaudit\fR(3) handling decisions and caching. This has the advantage of better performance, which can be further increased by caching the entry reference.
+.RE
+.RE
+.IP "" 4
+Examples of these are the X-SELinux and dbus object managers.
+.sp
+.IP "3." 4
+Those that build their own caching service  and use \fBsecurity_compute_av\fR(3) or \fBsecurity_compute_av_flags\fR(3) for computing access decisions. The \fBavc_netlink_*\fR(3) functions can then be used to detect policy change events. Auditing would need to be implemented if required.
+.sp
+An example is the SE-PostgreSQL 9.0 object manager.
+.RE
+
+.SS "Implementing SELinux-aware Applications"
+This section puts forward various points that may be useful when developing SELinux-aware applications and object managers using libselinux:
+.RS
+.IP "1." 4
+Determine the security objectives and requirements.
+.IP "2." 4
+Because these applications manage labeling and access control, they need to be trusted.
+.IP "3." 4
+Where possible use the libselinux \fI*_raw\fR(3) functions as they avoid the overhead of translating the context to/from the readable format (unless of course there is a requirement for a readable context \- see \fBmcstransd\fR(8)).
+.IP "4." 4
+Use \fBselinux_set_mapping\fR(3) to limit the classes and permissions to only those required by the application.
+.IP "5." 4
+The standard output for messages generated by libselinux functions is \fIstderr\fR. Use \fBselinux_set_callback\fR(3) with \fBSELINUX_CB_LOG\fR type to redirect these to a log handler.
+.IP "6." 4
+Do not directly reference SELinux configuration files, always use the libselinux path functions to return the location. This will help portability as SELinux has some changes in the pipe-line for the location of the policy configuration files and the SELinux filesystem.
+.IP "7." 4
+Where possible use the \fIselabel_*\fR(3) functions to determine a files default context as they effectively replace the \fImatchpathcon*\fR(3) series of functions \- see \fBselabel_file\fR(5).
+.IP "8." 4
+Do not use class IDs directly, use \fBstring_to_security_class\fR(3) that will take the class string defined in the policy and return the class ID/value. Always check the value is > \fI0\fR. If \fI0\fR, then signifies that the class is unknown and the \fIdeny_unknown\fR flag setting in the policy will determine the outcome of any decision \- see \fBsecurity_deny_unknown\fR(3).
+.IP "9." 4
+Do not use permission bits directly, use \fBstring_to_av_perm\fR(3) that will take the permission string defined in the policy and return the permission bit mask.
+.IP "10." 4
+Where performance is important (see the \fBTypes of Object Manager\fR section) when making policy decisions (i.e. using \fBsecurity_compute_av\fR(3),  \fBsecurity_compute_av_flags\fR(3), \fBavc_has_perm\fR(3) or \fBavc_has_perm_noaudit\fR(3)), then use the \fIselinux_status_*\fR(3) functions to detect policy updates etc. as these do not require system call over-heads once set up. Note that the \fIselinux_status_*\fR functions are only available from libselinux 2.0.99, with Linux kernel 2.6.37 and above.
+.IP "11." 4
+Be aware that applications being built for 32 bit systems need to specify the \fICFLAG -D_FILE_OFFSET_BITS=64\fR as libselinux is built with this flag. This is particularly important if \fBmatchpathcon_filespec_add\fR(3) is used as it passes over \fBino_t\fR \fIino\fR that is too small otherwise (i.e. needs to be 64 bits).
+.IP "12." 4
+There are changes to the way contexts are computed for sockets in kernels 2.6.39 and above as described in the \fBCOMPUTING CONTEXTS\fR section. The functions affected by this are: \fBavc_compute_create\fR(3), \fBavc_compute_member\fR(3), \fBsecurity_compute_create\fR(3), \fBsecurity_compute_member\fR(3) and \fBsecurity_compute_relabel\fR(3).
+.IP "13." 4
+It is possible to set an undefined file context if the process has \fBcapability\fR(7) \fBCAP_MAC_ADMIN\fR and class \fBcapability2\fR with \fBmac_admin\fR permission in the policy. This is called 'deferred mapping of security contexts' and is explained at:
+.br
+.UR http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=12b29f34558b9b45a2c6eabd4f3c6be939a3980f
+.UE
+.RE
+
+.SS "Implementing Object Managers"
+To implement object managers for applications an understanding of the application is essential, because as a minimum:
+.sp
+.RS
+what object types and permissions are required
+.br
+where in the code object instances are created
+.br
+where access controls need to be applied
+.RE
+.sp
+While this section cannot help with those points, here are some notes to help during the design phase (also see the \fBImplementing SELinux-aware Applications\fR section):
+.RS
+.IP "1." 4
+Determine what objects are required and the access controls (permissions) that need to be applied.
+.IP "2." 4
+Does SELinux already have some of these object classes and permissions defined. For standard Linux OS objects such as files, then these would be available. If so, the object manager should remap them with \fBselinux_set_mapping\fR(3) so only those required are available.
+.sp
+However, do not try to reuse a current object that may be similar to the requirements, it will cause confussion at some stage. Always generate new classes/permissions.
+.IP "3." 4
+If the application has APIs or functions that integrate with other applications or scripts, then as part of the object manager implementation these may need to support the use of security contexts (examples are X-Windows and SE-PostgreSQL that provide functions for other applications to use). Therefore if required, provide common functions that can be used to label objects.
+.IP "4." 4
+Determine how the initial objects will be labeled. For example will a configuration file be required for default labels, if so how will this be introduced into the SELinux userspace build. Examples of these are X-Windows (\fBselabel_x\fR(5)), SE-PostgreSQL (\fBselabel_db\fR(3)), and file context series of files (\fBselabel_file\fR(5)).
+.IP "5." 4
+Will the labeling need to be persistent across policy and system reloads or not. X-Windows is an example of a non-persistent, and SE-PostgreSQL is an example of a persistent object manager.
+.IP "6." 4
+Will support for the standard audit log or its own be required (the libselinux functions default to \fIstderr\fR). Use \fBselinux_set_callback\fR(3) to manage logging services.
+.IP "7." 4
+Decide whether an AVC cache is required or not. If the object manager handles high volumes of requests then an AVC will be required. See the \fBTypes of Object Manager\fR section for details.
+.IP "8." 4
+Will the object manager need to do additional processing when policy or enforcement changes are detected. This could be clearing any caches or resetting variables etc. If so, then \fBselinux_set_callback\fR(3) will be used to set up these functions. These events are detected via the \fBnetlink\fR(7) services, see \fBavc_open\fR(3) and \fBavc_netlink_open\fR(3) for the various options available.
+.IP "9." 4
+If possible implement a service like XACE for the application, and use it to interface with the applications SELinux object manager. The XACE interface acts like the LSM which supports SELinux as well as other providers such as SMACK. The XACE interface is defined in the X Access Control Extension Specification, and for reference, the SE-PostgreSQL service also implements a similar interface.
+.br
+The XACE specification is available from: http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf
+.RE
+.sp
+.SS "Reference Policy Changes"
+When adding a new object manager to SELinux, it will require at least a new policy module to be added. This section assumes that the SELinux Reference Policy is in use and gives some pointers, however any detail is beyond the scope of this man page. Further information can be found at the following:
+.br
+.RS
+http://oss.tresys.com/projects/refpolicy
+.br
+http://selinuxproject.org
+.RE
+.sp
+The latest Reference Policy source can be obtained as follows:
+.RS
+.B git clone http://oss.tresys.com/git/refpolicy.git
+.RE
+.sp
+The main points to note when adding to the Reference Policy are:
+.RS
+.IP "1." 4
+Create sample Reference Policy policy modules (\fI*.te\fR, \fI*.if\fR and \fI*.fc\fR files) that provide rules for managing the new objects, as described in:
+.RS
+http://selinuxproject.org/page/NB_RefPolicy#Reference_Policy_Module_Files
+.sp
+The SE-PostgreSQL modules provide an example, see the \fI./refpolicy/policy/modules/services/postgresql.*\fR files in the Reference Policy source.
+.RE
+.IP "2." 4
+Create any new policy classes and permissions for the Reference Policy, these will need to be built into the base module as described in the \fBAdding New Object Classes and Permissions\fR section.
+.RS
+Note, that if no new object classes, permissions or constraints are being added to the policy, then the Reference Policy source code does not require modification, and supplying the module files (\fI*.te\fR, \fI*.if\fR and \fI*.fc\fR) should suffice.
+.RE
+.IP "3." 4
+Create any constraints required as these need to be built into the base module of the Reference Policy. They are added to the \fI./refpolicy/policy/constraints\fR, \fImcs\fR and \fImls\fR files. Again the SE-PostgreSQL entries in these files give examples (find the db_* class entries).
+.IP "4." 4
+Create any SELinux configuration files (context, user etc.) that need to be added to the policy at build time.
+.IP "5." 4
+Either produce a Reference Policy source or module patch, depending on whether new classes/constraints have been added. Note that by default a new module will be generated as a 'module', if it is required that the module is in the base (unusual), then add an entry \fB<required val='true'>\fR to the start of the interface file as shown below:
+.RS
+.RS
+## <summary>
+.br
+##Comment regarding interface file
+.br
+## </summary>
+.br
+## <required val="true">
+.br
+##Comment on reason why required in base
+.br
+## </required>
+.br
+.RE
+.RE
+.sp
+
+.SS "Adding New Object Classes and Permissions"
+Because userspace object managers do not require their new classes and permissions to be built into the kernel, the configuration is limited to the actual policy (generally the Reference Policy) and the application object manager code. New classes are added to the Reference Policy \fIsecurity_classes\fR file and permissions to the \fIaccess_vectors\fR file.
+.sp
+The class configuration file is at:
+.RS
+\fI./refpolicy/policy/flask/security_classes\fR
+.RE
+and each entry must be added to the end of the file in the following format:
+.RS
+\fBclass \fIobject_class_name\fR        \fB# userspace\fR
+.RE
+Where \fBclass\fR is the class keyword and \fIobject_class_name\fR is the name of the object. The \fB# userspace\fR is used by build scripts to detect userspace objects.
+.sp
+The permissions configuration file is at:
+.RS
+\fI./refpolicy/policy/flask/access_vectors\fR
+.RE
+and each entry must be added to the end of the file in the following format:
+.RS
+\fBclass \fIobject_class_name\fR
+.br
+\fB{\fR
+.br
+	\fIperm_name\fR
+.br
+	\fI[........]\fR
+.br
+\fB}\fR
+.RE
+.sp
+Where class is the \fBclass\fR keyword, \fIobject_class_name\fR is the name of the object and \fIperm_name\fR is the name given to each permission in the class (there is a limit of 32 permissions within a class). It is possible to have a common permission section within this file, see the \fBfile\fR object entry in the \fIaccess_vectors\fR file for an example.
+.sp
+For reference:
+.RS
+http://selinuxproject.org/page/Adding_New_Permissions
+.RE
+describes how new kernel object classes and permissions are added to the system.
+
+.SH "COMPUTING CONTEXTS"
+This section explains how a security context is computed when using:
+.RS
+\fBavc_compute_create\fR(3) and \fBsecurity_compute_create\fR(3)
+.br
+\fBavc_compute_member\fR(3) and \fBsecurity_compute_member\fR(3)
+.br
+\fBsecurity_compute_relabel\fR(3)
+.RE
+.sp
+Note that the policy language statements: \fBtype_transition\fR, \fBrole_transition\fR, \fBrange_transition\fR, \fBtype_member\fR and \fBtype_change\fR influence the outcome of any computation (and also the corresponding CIL language statements: \fBtypetransition\fR, \fBfiletransition\fR, \fBroletransition\fR, \fBrangetransition\fR, \fBtypemember\fR and \fBtypechange\fR).
+
+.SS "AVC_COMPUTE_CREATE AND SECURITY_COMPUTE_CREATE"
+The table below shows how the components from the source context \fIscon\fR, target context \fItcon\fR, and class \fItclass\fR, are used to compute the new context \fInewcon\fR (referenced by SIDs for \fBavc_compute_create\fR(3)). The following notes also apply:
+.RS
+.IP "a)" 4
+Any valid policy \fBrole_transition\fR, \fBtype_transition\fR and \fBrange_transition\fR enforcement rules will influence the final outcome as shown.
+.IP "b)" 4
+For kernels less than 2.6.39 the context generated will depend on whether the class is \fBprocess\fR or any \fIother\fR class.
+.IP "c)" 4
+For kernels 2.6.39 and above the following also applies:
+.RS
+.RS
+.IP "i." 4
+Those classes suffixed by \fBsocket\fR will also be included in the \fBprocess\fR class outcome.
+.IP "ii." 4
+If a valid \fBrole_transition\fR rule for \fItclass\fR, then use that instead of the default \fBobject_r\fR. Also requires policy version 26 or greater; see \fBsecurity_policyvers\fR(3).
+.IP "iii." 4
+If the \fBtype_transition\fR rule is classed as the 'file name transition rule' (i.e. it has an \fIobject_name\fR parameter), then provided the object name in the rule matches the last component of the objects name (in this case a file or directory name), then use the rules \fIdefault_type\fR (note CIL uses \fBfiletransition\fR). Also requires policy version 25 or greater.
+.RE
+.RE
+.RE
+.TS
+left, allbox, tab(@);
+c c ce ce ce c .
+ @\fIuser@role@type@range\fR (low-high)@\fItclass\fR
+\fInewcon\fR =@\fIscon@scon@scon@scon-range\fR@T{
+<=2.6.38 \fBprocess\fR >=2.6.39 \fBprocess \fI*socket\fR
+T}
+ @ @T{
+If kernel >=2.6.39, and valid \fBrole_transition\fR rule then use the rules \fInew_role\fR instead.
+T}@T{
+If valid \fBtype_transition\fR rule then use the rules \fIdefault_type\fR instead.
+T}@T{
+If valid \fBrange_transition\fR rule then use the rules \fInew_range\fR instead.
+T}@
+\fInewcon\fR =@\fIscon\fR@\fBobject_r\fI@tcon@scon-low@others\fR
+.TE
+
+.SS "AVC_COMPUTE_MEMBER AND SECURITY_COMPUTE_MEMBER"
+The table below shows how the components from the source context \fIscon\fR, target context \fItcon\fR, and class \fItclass\fR, are used to compute the new context \fInewcon\fR (referenced by SIDs for \fBavc_compute_member\fR(3)). The following notes also apply:
+.RS
+.IP "a)" 4
+Any valid policy \fBtype_member\fR enforcement rules will influence the final outcome as shown.
+.IP "b)" 4
+For kernels less than 2.6.39 the context generated will depend on whether the class is \fBprocess\fR or any \fIother\fR class.
+.IP "c)" 4
+For kernels 2.6.39 and above those classes suffixed by \fBsocket\fR will also be included in the \fBprocess\fR class outcome.
+.RE
+.TS
+left, allbox, tab(@);
+c c c ce ce c .
+ @\fIuser@role@type@range\fR (low-high)@\fItclass\fR
+\fInewcon\fR =@\fItcon@scon@scon@scon-low\fR@T{
+<=2.6.38 \fBprocess\fR >=2.6.39 \fBprocess \fI*socket\fR
+T}
+ @ @ @T{
+If valid \fBtype_member\fR rule then use the rules \fImember_type\fR instead.
+T}@ @
+\fInewcon\fR =@\fItcon\fR@\fBobject_r\fI@tcon@scon-low@others\fR
+.TE
+
+.SS "SECURITY_COMPUTE_RELABEL"
+The table below shows how the components from the source context \fIscon\fR, target context \fItcon\fR, and class \fItclass\fR, are used to compute the new context \fInewcon\fR for \fBsecurity_compute_relabel\fR(3). The following notes also apply:
+.RS
+.IP "a)" 4
+Any valid policy \fBtype_change\fR enforcement rules will influence the final outcome as shown.
+.IP "b)" 4
+For kernels less than 2.6.39 the context generated will depend on whether the class is \fBprocess\fR or any \fIother\fR class.
+.IP "c)" 4
+For kernels 2.6.39 and above those classes suffixed by \fBsocket\fR will also be included in the \fBprocess\fR class outcome.
+.RE
+.TS
+left, allbox, tab(@);
+c c c ce ce c .
+ @\fIuser@role@type@range\fR (low-high)@\fItclass\fR
+\fInewcon\fR =@\fIscon@scon@scon@scon-range\fR@T{
+<=2.6.38 \fBprocess\fR >=2.6.39 \fBprocess \fI*socket\fR
+T}
+ @ @ @T{
+If valid \fBtype_change\fR rule then use the rules \fIchange_type\fR instead.
+T}@ @
+\fInewcon\fR =@\fIscon\fR@\fBobject_r\fI@tcon@scon-low@others\fR
+.TE
+
+.SH "FILES"
+The libselinux functions make use of a number of files within the SELinux sub\-system:
+.RS
+.IP "1." 4
+The SELinux configuration file \fIconfig\fR that is described in \fBselinux_config\fR(5).
+.IP "2." 4
+The SELinux filesystem that is the interface between userspace and the kernel. This is generally mounted as \fI/selinux\fR or \fI/sys/fs/selinux\fR. There is a description at:
+.sp
+.RS
+http://selinuxproject.org/page/NB_LSM#SELinux_Filesystem
+.RE
+.IP "3." 4
+The proc filesystem that maintains process state information and security contexts - see  \fBproc\fR(5).
+.IP "4." 4
+The extended attribute services that manage the extended attributes associated to files, sockets etc. - see \fBattr\fR(5).
+.IP "5." 4
+The SELinux binary policy that describes the enforcement policy.
+.IP "6." 4
+A number of libselinux functions have their own configuration files that in conjunction with the policy allow additional levels of configuration. The following man pages define these configuration files that should be consulted as they also specify the functions that make use of them:
+.RS
+.RS
+.sp
+.BR booleans "(5), " customizable_types "(5), " default_contexts "(5), " default_type "(5), " failsafe_context "(5), " file_contexts "(5), " local.users "(5), " media "(5), " removable_context "(5), " securetty_types "(5), " selabel_db "(5), " selabel_file "(5), " selabel_media "(5), " selabel_x "(5), " sepgsql_contexts "(5), " service_seusers "(5), " seusers "(5), " user_contexts "(5), " virtual_domain_context "(5), " virtual_image_context "(5), " x_contexts "(5) "
+.RE
+.RE
+.RE
+
+.SH "SEE ALSO"
+.BR selinux "(8), " proc "(5), " attr "(5), " PAM "(8),  "netlink "(7), " selinux_set_mapping "(3), " selinux_set_callback "(3), " security_deny_unknown "(3), " selabel_open "(3), " selabel_file "(5), " security_compute_av "(3), "  security_compute_av_flags "(3), " avc_open "(3), " avc_has_perm "(3), " avc_has_perm_noaudit "(3), " selinux_status_open "(3), " avc_netlink_open "(3), " semanage "(8), " selinux_config "(5), " avc_compute_create "(3), " avc_compute_member "(3), " security_compute_create "(3), " security_compute_member "(3), " security_compute_relabel "(3), " mcstransd "(8) "
+
+.SH "FOOTNOTES"
+.IP "[1]" 4
+The SELinux policy / security server do not themselves enforce a decision,
+they merely state whether the operation is allowed or not according to the
+policy. It is the object manager that enforces the decision of the
+policy / security server, therefore an object manager must be trusted.
+This is also true of labeling - the object manager ensures that the labels
+are applied to their objects as defined by the policy.
-- 
1.7.7.1






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
