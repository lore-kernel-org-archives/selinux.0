Subject: Re: Announce: Updated SELinux conditional policy extensions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Selinux Dev <selinux-dev@tresys.com>
In-Reply-To: <1074114393.10070.42.camel@colossus.columbia.tresys.com>
References: <1074114393.10070.42.camel@colossus.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-ewvCyVfKvDnAX0/3pmAk"
Message-Id: <1074631222.31819.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 15:40:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ewvCyVfKvDnAX0/3pmAk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-01-14 at 16:06, Karl MacMillan wrote:
> This release includes modifications to the linux kernel, checkpolicy,
> libselinux, and the default policy and allows the creation and loading
> of conditional policies. Any testing or feedback would be greatly
> appreciated.

At least until fine-grained labeling support exists for selinuxfs, I'd
suggest adding a new permission for controlling writes to your booleans
rather than re-using setenforce, as the latter conveys too much power. 
Even if fine-grained labeling support is added, you may still want to
retain such a permission to provide a coarse-grained first level of
control over who can set the booleans.  The two patches below add a
setbool permission to the kernel and policy for that purpose, and
adjusts your code to use it instead of setenforce.

With regard to fine-grained labeling, it should be straightforward for
your sel_make_bools() code to call security_genfs_sid and set the SID in
the inode security structure for the boolean inodes, as you have all of
the necessary information available there.  You can then set the inode
security structure initialized flag, and thereby avoid having
inode_doinit clobber your SID value when d_instantiate is called.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-ewvCyVfKvDnAX0/3pmAk
Content-Disposition: attachment; filename=kernel-setbool.diff
Content-Type: text/x-patch; name=kernel-setbool.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -X /nfshome/sds/dontdiff -ru linux-2.6.1/security/selinux/include/av_permissions.h linux-2.6/security/selinux/include/av_permissions.h
--- linux-2.6.1/security/selinux/include/av_permissions.h	2004-01-20 09:07:56.000000000 -0500
+++ linux-2.6/security/selinux/include/av_permissions.h	2004-01-20 14:35:44.000000000 -0500
@@ -512,6 +514,7 @@
 #define SECURITY__COMPUTE_RELABEL                 0x00000020UL
 #define SECURITY__COMPUTE_USER                    0x00000040UL
 #define SECURITY__SETENFORCE                      0x00000080UL
+#define SECURITY__SETBOOL                         0x00000100UL
 
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
diff -X /nfshome/sds/dontdiff -ru linux-2.6.1/security/selinux/include/av_perm_to_string.h linux-2.6/security/selinux/include/av_perm_to_string.h
--- linux-2.6.1/security/selinux/include/av_perm_to_string.h	2004-01-20 09:07:56.000000000 -0500
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	2004-01-20 14:35:44.000000000 -0500
@@ -84,6 +84,7 @@
    { SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL, "compute_relabel" },
    { SECCLASS_SECURITY, SECURITY__COMPUTE_USER, "compute_user" },
    { SECCLASS_SECURITY, SECURITY__SETENFORCE, "setenforce" },
+   { SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool" },
    { SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info" },
    { SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read" },
    { SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod" },
diff -X /nfshome/sds/dontdiff -ru linux-2.6.1/security/selinux/selinuxfs.c linux-2.6/security/selinux/selinuxfs.c
--- linux-2.6.1/security/selinux/selinuxfs.c	2004-01-20 15:07:32.614456521 -0500
+++ linux-2.6/security/selinux/selinuxfs.c	2004-01-20 14:30:50.000000000 -0500
@@ -722,7 +722,7 @@
 
 	down(&sel_sem);
 	
-	length = task_has_security(current, SECURITY__SETENFORCE);
+	length = task_has_security(current, SECURITY__SETBOOL);
 	if (length)
 		goto out;
 
@@ -778,7 +778,7 @@
 
 	down(&sel_sem);
 
-	length = task_has_security(current, SECURITY__SETENFORCE);
+	length = task_has_security(current, SECURITY__SETBOOL);
 	if (length)
 		goto out;
 


--=-ewvCyVfKvDnAX0/3pmAk
Content-Disposition: attachment; filename=policy-setbool.diff
Content-Type: text/x-patch; name=policy-setbool.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/flask/access_vectors
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/access_vectors,v
retrieving revision 1.4
diff -u -r1.4 access_vectors
--- policy/flask/access_vectors	20 Nov 2003 13:46:15 -0000	1.4
+++ policy/flask/access_vectors	20 Jan 2004 19:30:23 -0000
@@ -286,6 +286,7 @@
 	compute_relabel
 	compute_user
 	setenforce     # was avc_toggle in system class
+	setbool
 }
 
 

--=-ewvCyVfKvDnAX0/3pmAk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
