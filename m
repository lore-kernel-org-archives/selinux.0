Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49KpH4w005429
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 16:51:18 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 9/9] semanage: Update man pages for infiniband
Date: Tue,  9 May 2017 23:50:42 +0300
Message-Id: <1494363042-121766-10-git-send-email-danielj@mellanox.com>
In-Reply-To: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Update the main man page and add specific pages for ibpkeys and
ibendports.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 python/semanage/semanage-ibendport.8 |   66 ++++++++++++++++++++++++++++++++++
 python/semanage/semanage-ibpkey.8    |   66 ++++++++++++++++++++++++++++++++++
 python/semanage/semanage.8           |   16 ++++++--
 3 files changed, 144 insertions(+), 4 deletions(-)
 create mode 100644 python/semanage/semanage-ibendport.8
 create mode 100644 python/semanage/semanage-ibpkey.8

diff --git a/python/semanage/semanage-ibendport.8 b/python/semanage/semanage-ibendport.8
new file mode 100644
index 0000000..c3753a2
--- /dev/null
+++ b/python/semanage/semanage-ibendport.8
@@ -0,0 +1,66 @@
+.TH "semanage-ibendport" "8" "20170508" "" ""
+.SH "NAME"
+.B semanage\-ibendport \- SELinux Policy Management ibendport mapping tool
+.SH "SYNOPSIS"
+.B semanage ibendport [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-t TYPE \-z IBDEV_NAME \-r RANGE port | \-\-delete \-z IBDEV_NAME port | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-z IBDEV_NAME \-r RANGE port ]
+
+.SH "DESCRIPTION"
+semanage is used to configure certain elements of SELinux policy without requiring modification to or recompilation from policy sources.  semanage ibendport controls the ibendport number to ibendport type definitions.
+
+.SH "OPTIONS"
+.TP
+.I  \-h, \-\-help
+show this help message and exit
+.TP
+.I   \-n, \-\-noheading
+Do not print heading when listing the specified object type
+.TP
+.I   \-N, \-\-noreload
+Do not reload policy after commit
+.TP
+.I   \-S STORE, \-\-store STORE
+Select an alternate SELinux Policy Store to manage
+.TP
+.I   \-C, \-\-locallist
+List local customizations
+.TP
+.I   \-a, \-\-add
+Add a record of the specified object type
+.TP
+.I   \-d, \-\-delete
+Delete a record of the specified object type
+.TP
+.I   \-m, \-\-modify
+Modify a record of the specified object type
+.TP
+.I   \-l, \-\-list
+List records of the specified object type
+.TP
+.I   \-E, \-\-extract
+Extract customizable commands, for use within a transaction
+.TP
+.I   \-D, \-\-deleteall
+Remove all local customizations
+.TP
+.I   \-t TYPE, \-\-type TYPE
+SELinux type for the object
+.TP
+.I   \-r RANGE, \-\-range RANGE
+MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login mapping defaults to the SELinux user record range. SELinux Range for SELinux user defaults to s0.
+.TP
+.I \-z IBDEV_NAME, \-\-ibdev_name IBDEV_NAME
+The name of the infiniband device for the port to be labeled.  (ex. mlx5_0)
+
+.SH EXAMPLE
+.nf
+List all ibendport definitions
+# semanage ibendport \-l
+Label mlx4_0 port 2.
+# semanage ibendport \-a \-t allowed_ibendport_t \-z mlx4_0 2
+
+.SH "SEE ALSO"
+.BR selinux (8),
+.BR semanage (8)
+
+.SH "AUTHOR"
+This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-ibpkey.8 b/python/semanage/semanage-ibpkey.8
new file mode 100644
index 0000000..2da4f54
--- /dev/null
+++ b/python/semanage/semanage-ibpkey.8
@@ -0,0 +1,66 @@
+.TH "semanage-ibpkey" "8" "20170508" "" ""
+.SH "NAME"
+.B semanage\-ibpkey \- SELinux Policy Management ibpkey mapping tool
+.SH "SYNOPSIS"
+.B semanage ibpkey [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-t TYPE \-x SUBNET_PREFIX \-r RANGE ibpkey_name | ibpkey_range | \-\-delete \-x SUBNET_PREFIX ibpkey_name | ibpkey_range | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-x SUBNET_PREFIX \-r RANGE ibpkey_name | ibpkey_range ]
+
+.SH "DESCRIPTION"
+semanage is used to configure certain elements of SELinux policy without requiring modification to or recompilation from policy sources.  semanage ibpkey controls the ibpkey number to ibpkey type definitions.
+
+.SH "OPTIONS"
+.TP
+.I  \-h, \-\-help
+show this help message and exit
+.TP
+.I   \-n, \-\-noheading
+Do not print heading when listing the specified object type
+.TP
+.I   \-N, \-\-noreload
+Do not reload policy after commit
+.TP
+.I   \-S STORE, \-\-store STORE
+Select an alternate SELinux Policy Store to manage
+.TP
+.I   \-C, \-\-locallist
+List local customizations
+.TP
+.I   \-a, \-\-add
+Add a record of the specified object type
+.TP
+.I   \-d, \-\-delete
+Delete a record of the specified object type
+.TP
+.I   \-m, \-\-modify
+Modify a record of the specified object type
+.TP
+.I   \-l, \-\-list
+List records of the specified object type
+.TP
+.I   \-E, \-\-extract
+Extract customizable commands, for use within a transaction
+.TP
+.I   \-D, \-\-deleteall
+Remove all local customizations
+.TP
+.I   \-t TYPE, \-\-type TYPE
+SELinux type for the object
+.TP
+.I   \-r RANGE, \-\-range RANGE
+MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login mapping defaults to the SELinux user record range. SELinux Range for SELinux user defaults to s0.
+.TP
+.I \-x SUBNET_PREFIX, \-\-subnet_prefix SUBNET_PREFIX
+Subnet prefix for the specified pkey or range of pkeys.
+
+.SH EXAMPLE
+.nf
+List all ibpkey definitions
+# semanage ibpkey \-l
+Label pkey 0x8FFF (limited membership default pkey) as a default pkey type
+# semanage ibpkey \-a \-t default_ibpkey_t \-x fe80:: 0x8FFF
+
+.SH "SEE ALSO"
+.BR selinux (8),
+.BR semanage (8)
+
+.SH "AUTHOR"
+This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage.8 b/python/semanage/semanage.8
index abc4736..0bdb90f 100644
--- a/python/semanage/semanage.8
+++ b/python/semanage/semanage.8
@@ -3,7 +3,7 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage                {import,export,login,user,port,interface,module,node,fcontext,boolean,permissive,dontaudit}
+.B semanage                {import,export,login,user,port,interface,module,node,fcontext,boolean,permissive,dontaudit,ibpkey,ibendport}
                 ...
 .B positional arguments:
 
@@ -43,6 +43,12 @@ Manage process type enforcement mode
 .B    dontaudit
 Disable/Enable dontaudit rules in policy
 
+.B    ibpkey
+Manage infiniband pkey type definitions
+
+.B    ibendport
+Manage infiniband end port type definitions
+
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
 SELinux policy without requiring modification to or recompilation
@@ -50,9 +56,9 @@ from policy sources.  This includes the mapping from Linux usernames
 to SELinux user identities (which controls the initial security context
 assigned to Linux users when they login and bounds their authorized role set)
 as well as security context mappings for various kinds of objects, such
-as network ports, interfaces, and nodes (hosts) as well as the file
-context mapping. See the EXAMPLES section below for some examples
-of common usage.  Note that the semanage login command deals with the
+as network ports, interfaces, infiniband pkeys and endports, and nodes (hosts)
+as well as the file context mapping. See the EXAMPLES section below for some
+examples of common usage.  Note that the semanage login command deals with the
 mapping from Linux usernames (logins) to SELinux user identities,
 while the semanage user command deals with the mapping from SELinux
 user identities to authorized role sets.  In most cases, only the
@@ -79,6 +85,8 @@ List help information
 .BR semanage-permissive (8),
 .BR semanage-port (8),
 .BR semanage-user (8)
+.BR semanage-ibkey (8),
+.BR semanage-ibendport (8),
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
-- 
1.7.1
