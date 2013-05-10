Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2PE015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:11 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 13/16] policycoreutils: Fix cases where hyphen were used as minus sign in manpages
Date: Fri, 10 May 2013 14:45:21 +0200
Message-Id: <1368189924-8501-14-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

And also other minor formating issues
---
 policycoreutils/audit2allow/audit2allow.1          | 32 +++++++--------
 policycoreutils/man/man5/selinux_config.5          |  2 +-
 policycoreutils/mcstrans/man/man8/mcs.8            |  2 +-
 policycoreutils/newrole/newrole.1                  | 24 +++++------
 policycoreutils/scripts/chcat.8                    |  4 +-
 policycoreutils/scripts/fixfiles.8                 | 22 +++++-----
 policycoreutils/scripts/genhomedircon.8            |  2 +-
 policycoreutils/semanage/semanage.8                | 48 +++++++++++-----------
 policycoreutils/semodule/semodule.8                | 16 ++++----
 policycoreutils/semodule_deps/semodule_deps.8      |  6 +--
 .../semodule_package/semodule_package.8            |  8 ++--
 policycoreutils/sestatus/sestatus.conf.5           |  2 +-
 policycoreutils/setfiles/restorecon.8              |  4 ++
 policycoreutils/setfiles/setfiles.8                |  4 +-
 policycoreutils/setsebool/setsebool.8              |  8 ++--
 15 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/policycoreutils/audit2allow/audit2allow.1 b/policycoreutils/audit2allow/audit2allow.1
index a854a45..bb607c3 100644
--- a/policycoreutils/audit2allow/audit2allow.1
+++ b/policycoreutils/audit2allow/audit2allow.1
@@ -29,7 +29,7 @@
 \- generate SELinux policy allow/dontaudit rules from logs of denied operations
 
 .BR audit2why  
-\- translates SELinux audit messages into a description of why the access was denied (audit2allow -w)
+\- translates SELinux audit messages into a description of why the access was denied (audit2allow \-w)
 
 .SH SYNOPSIS
 .B audit2allow
@@ -37,16 +37,16 @@
 .SH OPTIONS
 .TP
 .B "\-a" | "\-\-all"
-Read input from audit and message log, conflicts with -i
+Read input from audit and message log, conflicts with \-i
 .TP
 .B "\-b" | "\-\-boot"
-Read input from audit messages since last boot conflicts with -i
+Read input from audit messages since last boot conflicts with \-i
 .TP
 .B "\-d" | "\-\-dmesg"
 Read input from output of 
 .I /bin/dmesg.
 Note that all audit messages are not available via dmesg when
-auditd is running; use "ausearch -m avc | audit2allow"  or "-a" instead.
+auditd is running; use "ausearch \-m avc | audit2allow"  or "\-a" instead.
 .TP
 .B "\-D" | "\-\-dontaudit"
 Generate dontaudit rules (Default: allow)
@@ -65,7 +65,7 @@ read input only after last policy reload
 Generate module/require output <modulename>
 .TP
 .B "\-M <modulename>" 
-Generate loadable module package, conflicts with -o
+Generate loadable module package, conflicts with \-o
 .TP
 .B "\-p <policyfile>"  | "\-\-policy <policyfile>"
 Policy file to use for analysis
@@ -123,7 +123,7 @@ an 'allow' rule.
 .PP
 .B Using audit2allow to generate module policy
 
-$ cat /var/log/audit/audit.log | audit2allow -m local > local.te
+$ cat /var/log/audit/audit.log | audit2allow \-m local > local.te
 $ cat local.te
 module local 1.0;
 
@@ -141,7 +141,7 @@ allow myapp_t etc_t:file { getattr open read };
 
 .B Using audit2allow to generate module policy using reference policy
 
-$ cat /var/log/audit/audit.log | audit2allow -R -m local > local.te
+$ cat /var/log/audit/audit.log | audit2allow \-R \-m local > local.te
 $ cat local.te
 policy_module(local, 1.0)
 
@@ -157,30 +157,30 @@ files_read_etc_files(myapp_t)
 
 # SELinux provides a policy devel environment under /usr/share/selinux/devel
 # You can create a te file and compile it by executing
-$ make -f /usr/share/selinux/devel/Makefile
-$ semodule -i local.pp
+$ make \-f /usr/share/selinux/devel/Makefile
+$ semodule \-i local.pp
 
 .B Building module policy manually
 
 # Compile the module
-$ checkmodule -M -m -o local.mod local.te
+$ checkmodule \-M \-m \-o local.mod local.te
 # Create the package 
-$ semodule_package -o local.pp -m local.mod
+$ semodule_package \-o local.pp \-m local.mod
 # Load the module into the kernel
-$ semodule -i local.pp
+$ semodule \-i local.pp
 
 .B Using audit2allow to generate and build module policy
-$ cat /var/log/audit/audit.log | audit2allow -M local
+$ cat /var/log/audit/audit.log | audit2allow \-M local
 Generating type enforcment file: local.te
-Compiling policy: checkmodule -M -m -o local.mod local.te
-Building package: semodule_package -o local.pp -m local.mod
+Compiling policy: checkmodule \-M \-m \-o local.mod local.te
+Building package: semodule_package \-o local.pp \-m local.mod
 
 ******************** IMPORTANT ***********************
 
 In order to load this newly created policy package into the kernel,
 you are required to execute
 
-semodule -i local.pp
+semodule \-i local.pp
 
 .B Using audit2allow to generate monolithic (non-module) policy
 $ cd /etc/selinux/$SELINUXTYPE/src/policy
diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
index 4963cdc..43f1ce4 100644
--- a/policycoreutils/man/man5/selinux_config.5
+++ b/policycoreutils/man/man5/selinux_config.5
@@ -122,7 +122,7 @@ This is an optional entry that allows the file system to be relabeled.
 .sp
 If set to \fI0\fR and there is a file called \fI.autorelabel\fR in the root directory, then on a reboot, the loader will drop to a shell where a root login is required. An administrator can then manually relabel the file system.
 .sp
-If set to \fI1\fR or no entry present (the default) and there is a \fI.autorelabel\fR file in the root directory, then the file system will be automatically relabeled using \fBfixfiles -F restore\fR
+If set to \fI1\fR or no entry present (the default) and there is a \fI.autorelabel\fR file in the root directory, then the file system will be automatically relabeled using \fBfixfiles \-F restore\fR
 .sp
 In both cases the \fI/.autorelabel\fR file will be removed so that relabeling is not done again.
 .RE
diff --git a/policycoreutils/mcstrans/man/man8/mcs.8 b/policycoreutils/mcstrans/man/man8/mcs.8
index 44126bf..aeaf22e 100644
--- a/policycoreutils/mcstrans/man/man8/mcs.8
+++ b/policycoreutils/mcstrans/man/man8/mcs.8
@@ -20,7 +20,7 @@ readable form.   Administrators can define any labels they want in this file.
 Certain applications like printing and auditing will use these labels to 
 identify the files.  By setting a category on a file you will prevent 
 other applications/services from having access to the files.
-.p
+.P
 Examples of file labels would be PatientRecord, CompanyConfidential etc.
 
 .SH "SEE ALSO"
diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
index 376c458..c47bc52 100644
--- a/policycoreutils/newrole/newrole.1
+++ b/policycoreutils/newrole/newrole.1
@@ -44,7 +44,7 @@ Additional arguments
 .I ARGS
 may be provided after a -- option,
 in which case they are supplied to the new shell.
-In particular, an argument of -- -c will cause the next argument to be
+In particular, an argument of \-\- \-c will cause the next argument to be
 treated as a command by most command interpreters.
 .PP
 If a command argument is specified to newrole and the command name is found
@@ -66,31 +66,31 @@ shows the current version of newrole
 .SH EXAMPLE
 .br
 Changing role:
-   # id -Z
+   # id \-Z
    staff_u:staff_r:staff_t:SystemLow-SystemHigh
-   # newrole -r sysadm_r
-   # id -Z
+   # newrole \-r sysadm_r
+   # id \-Z
    staff_u:sysadm_r:sysadm_t:SystemLow-SystemHigh
 
 Changing sensitivity only:
-   # id -Z
+   # id \-Z
    staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
-   # newrole -l Secret
-   # id -Z
+   # newrole \-l Secret
+   # id \-Z
    staff_u:sysadm_r:sysadm_t:Secret-SystemHigh
 
 .PP
 Changing sensitivity and clearance:
-   # id -Z
+   # id \-Z
    staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
-   # newrole -l Secret-Secret
-   # id -Z
+   # newrole \-l Secret-Secret
+   # id \-Z
    staff_u:sysadm_r:sysadm_t:Secret
 
 .PP
 Running a program in a given role or level:
-   # newrole -r sysadm_r -- -c "/path/to/app arg1 arg2..."
-   # newrole -l Secret -- -c "/path/to/app arg1 arg2..."
+   # newrole \-r sysadm_r \-\- \-c "/path/to/app arg1 arg2..."
+   # newrole \-l Secret \-\- \-c "/path/to/app arg1 arg2..."
 
 .SH FILES
 /etc/passwd - user account information
diff --git a/policycoreutils/scripts/chcat.8 b/policycoreutils/scripts/chcat.8
index 7c6d75a..d095a25 100644
--- a/policycoreutils/scripts/chcat.8
+++ b/policycoreutils/scripts/chcat.8
@@ -21,7 +21,7 @@ chcat \- change file SELinux security category
 [\fI-d\fR] \fIuser\fR...
 .br
 .B chcat
-\fI-L\fR [ -l ] [ user ... ] 
+\fI-L\fR [ \-l ] [ user ... ]
 .br
 .SH DESCRIPTION
 .PP
@@ -31,7 +31,7 @@ Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR.
 .PP
 .B
 Note:
-When removing a category you must specify '--' on the command line before using the -Category syntax.  This tells the command that you have finished entering options and are now specifying a category name instead.
+When removing a category you must specify '\-\-' on the command line before using the \-Category syntax.  This tells the command that you have finished entering options and are now specifying a category name instead.
 
 .TP
 \fB\-d\fR
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 9ab7334..2ac0073 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -5,13 +5,13 @@ fixfiles \- fix file SELinux security contexts.
 .SH "SYNOPSIS"
 
 .B fixfiles 
-.I [-v] [-F] [-l logfile ] { check | restore|[-f] relabel | verify } [[dir/file] ... ] 
+.I [\-v] [\-F] [\-l logfile ] { check | restore|[\-f] relabel | verify } [[dir/file] ... ]
 
 .B fixfiles 
-.I [-v] [-F] [ -R rpmpackagename[,rpmpackagename...] ] [-l logfile ] { check | restore | verify }
+.I [\-v] [\-F] [ \-R rpmpackagename[,rpmpackagename...] ] [\-l logfile ] { check | restore | verify }
 
 .B fixfiles 
-.I [-v] [ -C PREVIOUS_FILECONTEXT ] [-l logfile ] { check | restore | verify }
+.I [\-v] [ \-C PREVIOUS_FILECONTEXT ] [\-l logfile ] { check | restore | verify }
 
 .B fixfiles 
 .I onboot
@@ -28,7 +28,7 @@ It can also be run at any time to relabel when adding support for
 new policy, or  just check whether the file contexts are all
 as you expect.  By default it will relabel all mounted ext2, ext3, xfs and 
 jfs file systems as long as they do not have a security context mount 
-option.  You can use the -R flag to use rpmpackages as an alternative.
+option.  You can use the \-R flag to use rpmpackages as an alternative.
 The file /etc/selinux/fixfiles_exclude_dirs can contain a list of directories
 excluded from relabelling.
 .P
@@ -37,21 +37,21 @@ will setup the machine to relabel on the next reboot.
 
 .SH "OPTIONS"
 .TP 
-.B -l logfile
+.B \-l logfile
 Save the output to the specified logfile
 .TP 
-.B -F
-Force  reset  of  context to match file_context for customizable files
+.B \-F
+Force reset of context to match file_context for customizable files
 
 .TP 
-.B -f
+.B \-f
 Clear /tmp directory with out prompt for removal.
 
 .TP 
-.B -R rpmpackagename[,rpmpackagename...]
-Use the rpm database to discover all files within the specified packages and restore the file contexts.  (-a will get all files in the RPM database).
+.B \-R rpmpackagename[,rpmpackagename...]
+Use the rpm database to discover all files within the specified packages and restore the file contexts.  (\-a will get all files in the RPM database).
 .TP
-.B -C PREVIOUS_FILECONTEXT
+.B \-C PREVIOUS_FILECONTEXT
 Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installed one, and restore the context of all affected files.
 
 .TP 
diff --git a/policycoreutils/scripts/genhomedircon.8 b/policycoreutils/scripts/genhomedircon.8
index 8ec509c..08e3bad 100644
--- a/policycoreutils/scripts/genhomedircon.8
+++ b/policycoreutils/scripts/genhomedircon.8
@@ -1,4 +1,4 @@
-.TH GENHOMEDIRCON "12" "Sep 2011" "Security Enhanced Linux" "SELinux"
+.TH GENHOMEDIRCON "8" "Sep 2011" "Security Enhanced Linux" "SELinux"
 .SH NAME
 genhomedircon \- generate SELinux file context configuration entries for user home directories
 .SH SYNOPSIS
diff --git a/policycoreutils/semanage/semanage.8 b/policycoreutils/semanage/semanage.8
index 28a9022..4d84ec0 100644
--- a/policycoreutils/semanage/semanage.8
+++ b/policycoreutils/semanage/semanage.8
@@ -5,16 +5,16 @@ semanage \- SELinux Policy Management tool
 .SH "SYNOPSIS"
 Output local customizations
 .br
-.B semanage [ -S store ] -o [ output_file | - ]
+.B semanage [ -S store ] \-o [ output_file | \- ]
 
 Input local customizations
 .br
-.B semanage [ -S store ] -i [ input_file | - ]
+.B semanage [ -S store ] \-i [ input_file | \- ]
 
 Manage booleans.  Booleans allow the administrator to modify the confinement of
 processes based on his configuration.
 .br
-.B semanage boolean [\-S store] \-{d|m|l|D} [\-nN] [\-\-on|\-\-off|\-\1|\-0] -F boolean | boolean_file
+.B semanage boolean [\-S store] \-{d|m|l|D} [\-nN] [\-\-on|\-\-off|\-\1|\-0] \-F boolean | boolean_file
 
 Manage SELinux confined users (Roles and levels for an SELinux user)
 .br
@@ -26,7 +26,7 @@ Manage login mappings between linux users and SELinux confined users.
 
 Manage policy modules.
 .br
-.B semanage module [\-S store] \-{a|d|l} [-m [--enable | --disable] ] [\-N] module_name
+.B semanage module [\-S store] \-{a|d|l} [\-m [\-\-enable | \-\-disable] ] [\-N] module_name
 
 Manage network port type definitions
 .br
@@ -39,7 +39,7 @@ Manage network interface type definitions
 
 Manage network node type definitions
 .br
-.B semanage node [\-S store] -{a|d|m|l|D} [-nNrt] [ -p protocol ] [-M netmask] address
+.B semanage node [\-S store] \-{a|d|m|l|D} [\-nNrt] [ \-p protocol ] [\-M netmask] address
 .br
 
 Manage file context mapping definitions
@@ -97,12 +97,12 @@ Delete a OBJECT record NAME
 Remove all OBJECTS local customizations
 .TP
 .I                \-\-disable
-Disable a policy module, requires -m option
+Disable a policy module, requires \-m option
 
 Currently modules only.
 .TP
 .I                \-\-enable
-Enable a disabled policy module, requires -m option
+Enable a disabled policy module, requires \-m option
 
 Currently modules only.
 .TP
@@ -114,7 +114,7 @@ defined for the source.
 .TP
 .I                \-f, \-\-ftype
 File Type.   This is used with fcontext.
-Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
+Requires a file type as shown in the mode field by ls, e.g. use \-d to match only directories or \-\- to match only regular files.
 .TP
 .I                \-F, \-\-file
 Set multiple records from the input file.  When used with the \-l \-\-list, it will output the current settings to stdout in the proper format.
@@ -174,42 +174,42 @@ Take a set of commands from a specified file and load them in a single
 transaction.
 .TP
 .I                \-o, \-\-output
-Output all local customizations into a file. This file than can be used with the semanage -i command to customize other machines to match the local machine.
+Output all local customizations into a file. This file than can be used with the semanage \-i command to customize other machines to match the local machine.
 
 .SH EXAMPLE
 .nf
 .B SELinux user
 List SELinux users
-# semanage user -l
+# semanage user \-l
 
 .B SELinux login
 Change joe to login as staff_u
-# semanage login -a -s staff_u joe
+# semanage login \-a \-s staff_u joe
 Change the group clerks to login as user_u
-# semanage login -a -s user_u %clerks
+# semanage login \-a \-s user_u %clerks
 
 .B File contexts
-.i remember to run restorecon after you set the file context
+.I remember to run restorecon after you set the file context
 Add file-context for everything under /web
-# semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
-# restorecon -R -v /web
+# semanage fcontext \-a \-t httpd_sys_content_t "/web(/.*)?"
+# restorecon \-R \-v /web
 
 Substitute /home1 with /home when setting file context
-# semanage fcontext -a -e /home /home1
-# restorecon -R -v /home1
+# semanage fcontext \-a \-e /home /home1
+# restorecon \-R \-v /home1
 
 For home directories under top level directory, for example /disk6/home,
 execute the following commands.
-# semanage fcontext -a -t home_root_t "/disk6"
-# semanage fcontext -a -e /home /disk6/home
-# restorecon -R -v /disk6
+# semanage fcontext \-a \-t home_root_t "/disk6"
+# semanage fcontext \-a \-e /home /disk6/home
+# restorecon \-R \-v /disk6
 
 .B Port contexts
 Allow Apache to listen on tcp port 81
-# semanage port -a -t http_port_t -p tcp 81
+# semanage port \-a \-t http_port_t \-p tcp 81
 
 .B Change apache to a permissive domain
-# semanage permissive -a httpd_t
+# semanage permissive \-a httpd_t
 
 .B Turn off dontaudit rules
 # semanage dontaudit off
@@ -219,10 +219,10 @@ Multiple machines that need the same customizations.
 Extract customizations off first machine, copy them
 to second and import them.
 
-# semanage -o /tmp/local.selinux
+# semanage \-o /tmp/local.selinux
 # scp /tmp/local.selinux secondmachine:/tmp
 # ssh secondmachine
-# semanage -i /tmp/local.selinux
+# semanage \-i /tmp/local.selinux
 
 If these customizations include file context, you need to apply the
 context using restorecon.
diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 9f911fb..35277e9 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -21,7 +21,7 @@ by semodule_package.  Conventionally, these files have a .pp suffix
 force a reload of policy
 .TP
 .B \-B, \-\-build		
-force a rebuild of policy (also reloads unless -n is used)
+force a rebuild of policy (also reloads unless \-n is used)
 .TP
 .B \-D, \-\-disable_dontaudit
 Temporarily remove dontaudits from policy.  Reverts whenever policy is rebuilt
@@ -65,19 +65,19 @@ be verbose
 .SH EXAMPLE
 .nf
 # Install or replace a base policy package.
-$ semodule -b base.pp
+$ semodule \-b base.pp
 # Install or replace a non-base policy package.
-$ semodule -i httpd.pp
+$ semodule \-i httpd.pp
 # List non-base modules.
-$ semodule -l
+$ semodule \-l
 # Turn on all AVC Messages for which SELinux currently is "dontaudit"ing.
-$ semodule -DB
+$ semodule \-DB
 # Turn "dontaudit" rules back on.
-$ semodule -B
+$ semodule \-B
 # Install or replace all non-base modules in the current directory.
-$ semodule -i *.pp
+$ semodule \-i *.pp
 # Install or replace all modules in the current directory.
-$ ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule -b base.pp -i
+$ ls *.pp | grep \-Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule \-b base.pp \-i
 .fi
 
 .SH SEE ALSO
diff --git a/policycoreutils/semodule_deps/semodule_deps.8 b/policycoreutils/semodule_deps/semodule_deps.8
index 86b7b3c..6f21a64 100644
--- a/policycoreutils/semodule_deps/semodule_deps.8
+++ b/policycoreutils/semodule_deps/semodule_deps.8
@@ -3,7 +3,7 @@
 semodule_deps \- show the dependencies between SELinux policy packages.
 
 .SH SYNOPSIS
-.B semodule_deps [-v -g -b] basemodpkg modpkg1 [modpkg2 ... ]
+.B semodule_deps [\-v \-g \-b] basemodpkg modpkg1 [modpkg2 ... ]
 .br
 .SH DESCRIPTION
 .PP
@@ -19,12 +19,12 @@ general this means that the list of modules will usually be
 quite long.
 
 By default options to the base module are excluded as almost every
-module has this dependency. The -b option will include these
+module has this dependency. The \-b option will include these
 dependencies.
 
 In addition to human readable output, semodule_deps can output the
 dependencies in the Graphviz dot format (http://www.graphviz.org/)
-using the -g option. This is useful for producing a picture of the
+using the \-g option. This is useful for producing a picture of the
 dependencies.
 
 .SH "OPTIONS"
diff --git a/policycoreutils/semodule_package/semodule_package.8 b/policycoreutils/semodule_package/semodule_package.8
index ddad2d2..563d526 100644
--- a/policycoreutils/semodule_package/semodule_package.8
+++ b/policycoreutils/semodule_package/semodule_package.8
@@ -3,7 +3,7 @@
 semodule_package \- Create a SELinux policy module package.
 
 .SH SYNOPSIS
-.B semodule_package -o <output file> -m <module> [-f <file contexts>]
+.B semodule_package \-o <output file> \-m <module> [\-f <file contexts>]
 .br
 .SH DESCRIPTION
 .PP
@@ -16,11 +16,11 @@ be installed via semodule.
 .SH EXAMPLE
 .nf
 # Build a policy package for a base module.
-$ semodule_package -o base.pp -m base.mod -f file_contexts
+$ semodule_package \-o base.pp \-m base.mod \-f file_contexts
 # Build a policy package for a httpd module.
-$ semodule_package -o httpd.pp -m httpd.mod -f httpd.fc
+$ semodule_package \-o httpd.pp \-m httpd.mod \-f httpd.fc
 # Build a policy package for local TE rules and no file contexts.
-$ semodule_package -o local.pp -m local.mod 
+$ semodule_package \-o local.pp \-m local.mod
 .fi
 
 .SH "OPTIONS"
diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils/sestatus/sestatus.conf.5
index d2bb3fe..acfedf6 100644
--- a/policycoreutils/sestatus/sestatus.conf.5
+++ b/policycoreutils/sestatus/sestatus.conf.5
@@ -49,7 +49,7 @@ The start of the file list block.
 .RE
 .I file_name
 .RS
-One or more fully qualified file names, each on a new line will that will have its context displayed. If the file does not exist, then it is ignored. If the file is a symbolic link, then \fBsestatus -v\fR will also display the target file context.
+One or more fully qualified file names, each on a new line will that will have its context displayed. If the file does not exist, then it is ignored. If the file is a symbolic link, then \fBsestatus \-v\fR will also display the target file context.
 .RE
 .sp
 .B [process]
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 80b6d6e..dff06d8 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -26,6 +26,10 @@ If a file object does not have a context, restorecon will write the default
 context to the file object's extended attributes. If a file object has a
 context, restorecon will only modify the type portion of the security context.
 The -F option will force a replacement of the entire context.
+.P
+It is the same executable as
+.BR setfiles
+but operates in a slightly different manner depending on it's argv[0].
 
 .SH "OPTIONS"
 .TP
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 89d2a49..c405c63 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -4,7 +4,7 @@ setfiles \- set SELinux file security contexts.
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-q] [\-s] [\-v] [\-W] [\-F] spec_file pathname...
+.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-p] [\-q] [\-s] [\-v] [\-W] [\-F] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -23,7 +23,7 @@ check whether the file contexts are all set as specified by the active policy
 If a file object does not have a context, setfiles will write the default
 context to the file object's extended attributes. If a file object has a
 context, setfiles will only modify the type portion of the security context.
-The -F option will force a replacement of the entire context.
+The \-F option will force a replacement of the entire context.
 .SH "OPTIONS"
 .TP
 .B \-c
diff --git a/policycoreutils/setsebool/setsebool.8 b/policycoreutils/setsebool/setsebool.8
index 38abeb8..d53f15b 100644
--- a/policycoreutils/setsebool/setsebool.8
+++ b/policycoreutils/setsebool/setsebool.8
@@ -4,21 +4,21 @@ setsebool \- set SELinux boolean value
 
 .SH "SYNOPSIS"
 .B setsebool
-.I "[ -PN ] boolean value | bool1=val1 bool2=val2 ..."
+.I "[ \-PN ] boolean value | bool1=val1 bool2=val2 ..."
 
 .SH "DESCRIPTION"
 .B setsebool 
 sets the current state of a particular SELinux boolean or a list of booleans 
 to a given value. The value may be 1 or true or on to enable the boolean, or 0 or false or off to disable it. 
 
-Without the -P option, only the current boolean value is 
+Without the \-P option, only the current boolean value is
 affected; the boot-time default settings 
 are not changed. 
 
-If the -P option is given, all pending values are written to
+If the \-P option is given, all pending values are written to
 the policy file on disk. So they will be persistent across reboots.
 
-If the -N option is given, the policy on disk is not reloaded into the kernel.
+If the \-N option is given, the policy on disk is not reloaded into the kernel.
 
 
 .SH AUTHOR	
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
