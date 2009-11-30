Subject: [PATCH] Contributed manual pages for libselinux (second and last
 part)
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
Cc: "ewalsh@tycho.nsa.gov ; Joshua Brindle" <method@manicmethod.com>
Content-Type: multipart/mixed; boundary="=-p0VEQMDEbV8Qqk62lF65"
Date: Mon, 30 Nov 2009 18:47:17 +0100
Message-Id: <1259603237.2771.18.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-p0VEQMDEbV8Qqk62lF65
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello again !

I have completed the second and last part of the manual pages that were
missing for libselinux, as (still) described in
http://userspace.selinuxproject.org/trac/wiki/Todo

Because I do not generally use git to commit changes, then I have
attached the patch directly from the output of diff in unified format.

The following manual pages have been created from scratch:

- security_canonicalize_context(3);
- selinux_customizable_types_path(3);
- selinux_get_callback(3);
- selinux_raw_lto_trans_context(3);
- selinux_trans_to_raw_context(3) as a link to the previous one;
- selinux_translations_path(3);
- selinux_users_path(3).

Also, a few typos have been corrected and the author name has been
included. This patch is the companion of the other patch named
new-libselinux-manpages.patch that has already been committed.

Comments are much welcomed, so that I can amend any proposed change as
soon.

By the way, I have noticed that the patch for adding the "version"
option to checkpolicy has been committed but not the one for
policycoreutils. Is there any reason for that ?

Regards,

Guido

--=-p0VEQMDEbV8Qqk62lF65
Content-Disposition: attachment; filename="new-libselinux-manpages-part2.patch"
Content-Type: text/x-patch; name="new-libselinux-manpages-part2.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -pruN selinux.orig/libselinux/man/man3/init_selinuxmnt.3 selinux.newmanpages/libselinux/man/man3/init_selinuxmnt.3
--- selinux.orig/libselinux/man/man3/init_selinuxmnt.3	2009-11-30 18:23:35.277113764 +0100
+++ selinux.newmanpages/libselinux/man/man3/init_selinuxmnt.3	2009-11-30 11:33:55.363132406 +0100
@@ -22,7 +22,7 @@ changes the selinuxfs mountpoint to
 .I mnt. 
 
 .SH "AUTHOR"
-This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
 
 .SH "SEE ALSO"
 .BR selinux (8),
diff -pruN selinux.orig/libselinux/man/man3/security_canonicalize_context.3 selinux.newmanpages/libselinux/man/man3/security_canonicalize_context.3
--- selinux.orig/libselinux/man/man3/security_canonicalize_context.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/security_canonicalize_context.3	2009-11-30 17:25:07.857111701 +0100
@@ -0,0 +1,31 @@
+.TH "security_canonicalize_context" "3" "30 Nov 2009" "guido@trentalancia.com" "SELinux API documentation"
+.SH "NAME"
+security_canonicalize_context \- get the canonical (primary) form of a SELinux security context.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int security_canonicalize_context(security_context_t " con ", security_context_t * " canoncon ");"
+
+.SH "DESCRIPTION"
+.B security_canonicalize_context
+returns the canonical security context that the kernel is using rather than
+what is stored on disk.
+.sp
+Policies presently define a number of type aliases to provide compatibility
+and allow sharing with other policies, both in the policy itself and in the
+on-disk attributes. Since when attributes are set they are not canonicalized,
+the alias is stored on-disk.
+.sp
+The canonical form of a context is sometimes also referred to as the primary
+form.
+
+.SH "RETURN VALUE"
+.B security_canonicalize_context
+returns zero on success or \-1 on error.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " getfilecon "(3), " setfilecon "(3), " freecon "(3), " getfscreatecon "(3), " setfscreatecon "(3), " getcon "(3), " setcon "(3)"
diff -pruN selinux.orig/libselinux/man/man3/security_disable.3 selinux.newmanpages/libselinux/man/man3/security_disable.3
--- selinux.orig/libselinux/man/man3/security_disable.3	2009-11-30 18:23:35.286115073 +0100
+++ selinux.newmanpages/libselinux/man/man3/security_disable.3	2009-11-30 17:24:21.900113416 +0100
@@ -1,4 +1,4 @@
-.TH "security_disable" "3" "21 Nov 2009" "" "SELinux API documentation"
+.TH "security_disable" "3" "21 Nov 2009" "guido@trentalancia.com" "SELinux API documentation"
 .SH "NAME"
 security_disable \- disable the SELinux kernel code at runtime.
 
@@ -22,7 +22,7 @@ but only placed in "permissive" mode by 
 returns zero on success or \-1 on error.
 
 .SH "AUTHOR"
-This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
 
 .SH "SEE ALSO"
-.BR selinux (8), " setenforce "(3)
+.BR selinux "(8), " setenforce "(3)
diff -pruN selinux.orig/libselinux/man/man3/security_load_policy.3 selinux.newmanpages/libselinux/man/man3/security_load_policy.3
--- selinux.orig/libselinux/man/man3/security_load_policy.3	2009-11-30 18:23:35.288113749 +0100
+++ selinux.newmanpages/libselinux/man/man3/security_load_policy.3	2009-11-30 11:34:38.866113686 +0100
@@ -51,7 +51,7 @@ in enforcing one).
 returns zero on success or \-1 on error.
 
 .SH "AUTHOR"
-This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " security_disable "(3), " setenforce "(1)
diff -pruN selinux.orig/libselinux/man/man3/selinux_customizable_types_path.3 selinux.newmanpages/libselinux/man/man3/selinux_customizable_types_path.3
--- selinux.orig/libselinux/man/man3/selinux_customizable_types_path.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_customizable_types_path.3	2009-11-30 17:23:59.061116446 +0100
@@ -0,0 +1,63 @@
+.TH "selinux_customizable_types_path" "3" "30 Nov 2009" "guido@trentalancia.com" "SELinux API documentation"
+.SH "NAME"
+selinux_customizable_types_path \- get the path to the file which defines the customizable types.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "const char * selinux_customizable_types_path(void);"
+
+.SH "DESCRIPTION"
+.B selinux_customizable_types_path
+returns a pointer to a string representing the path to the file which
+defines the customizable types.
+.sp
+A customizable type is a file context type that is usually set on files
+that need to be shared among certain domains and where the administrator
+wants to manually manage the type.
+.sp
+For example, users could choose a directory under
+.I /var
+to share files via http and so they would label it as
+.I httpd_sys_content_t
+and they would define the same type in the customizable types file.
+Then when an autorelabel is triggered, the files under
+.I /var
+would normally get relabeled as
+.I var_t.
+However types that are entries of the customizable types file would
+not get relabelled and their context would be preserved, so in the
+example, the files would remain of the
+.I httpd_sys_content_t
+type. The problem with this approach is that it does not scale well
+and mislabeled files might never get fixed if they are defined as
+customizable types.
+.sp
+Normally
+.B restorecon(8)
+and
+.B
+setfiles(8)
+would not change the context of customizable types.
+However, it should be noted that when 
+.B restorecon(8)
+or
+.B setfiles(8)
+are called with the \-F option ("force" option) they would also
+restore the context of the customizable types.
+.sp
+The use of customizable types is deprecated as the preferred approach
+is now to use
+.B semanage fcontext (8)
+.
+
+.SH "RETURN VALUE"
+.B selinux_customizable_types_path
+returns a pointer to the string value of the path to the file which defines
+the customizable types.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " restorecon "(8), " setfiles "(8), " is_context_customizable "(3)
diff -pruN selinux.orig/libselinux/man/man3/selinux_get_callback.3 selinux.newmanpages/libselinux/man/man3/selinux_get_callback.3
--- selinux.orig/libselinux/man/man3/selinux_get_callback.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_get_callback.3	2009-11-30 17:25:43.080116063 +0100
@@ -0,0 +1,34 @@
+.TH "selinux_get_callback" "3" "30 Nov 2009" "guido@trentalancia.com" "SELinux API documentation"
+.SH "NAME"
+selinux_get_callback \- get the callback function of the given type.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "union selinux_callback selinux_get_callback(int " type ");"
+
+.SH "DESCRIPTION"
+.B selinux_get_callback
+is used to get a pointer to the callback function of the given
+type. Callback functions are set using
+.B selinux_set_callback(3)
+.
+.sp
+All callback functions should return a negative value with
+.I errno
+set appropriately on error.
+.sp
+The following callback function types are defined: log, audit,
+validate, setenforce and policyload (see
+.B selinux_set_callback(3)
+for a detailed description of these types).
+
+.SH "RETURN VALUE"
+.B selinux_get_callback
+returns a pointer to the callback function of the required type.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_set_callback "(3)
diff -pruN selinux.orig/libselinux/man/man3/selinux_raw_to_trans_context.3 selinux.newmanpages/libselinux/man/man3/selinux_raw_to_trans_context.3
--- selinux.orig/libselinux/man/man3/selinux_raw_to_trans_context.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_raw_to_trans_context.3	2009-11-30 17:37:31.679116143 +0100
@@ -0,0 +1,40 @@
+.TH "selinux_raw_to_trans_context" "3" "30 Nov 2009" "guido@trentalancia.com" "SELinux API"
+.SH "NAME"
+selinux_raw_to_trans_context, selinux_trans_to_raw_context \- perform context translation between raw and human-readable formats.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int selinux_raw_to_trans_context(security_context_t " raw ", security_context_t * " transp ");"
+.sp
+.BI "int selinux_trans_to_raw_context(security_context_t " trans ", security_context_t * " rawp ");"
+
+.SH "DESCRIPTION"
+.B selinux_raw_to_trans_context
+and
+.B selinux_trans_to_raw_context
+are used to perform security context translation between the
+human-readable ("translated") format and the internal ("raw")
+system format.
+.sp
+Only the MLS range portion of the security context
+(sensitivity and category) is translated and therefore these
+functions only have a meaning when used with the MLS
+(Multi-Level Security) policy or with the MCS (Multiple
+Category Security) policy.
+.sp
+The function
+.B selinux_translations_path(3)
+can be used to get the actual location of the file which
+contains the translations. Such file should not be edited
+manually, but instead the administrator should use
+.B semanage translation(8).
+
+.SH "RETURN VALUE"
+Zero is returned on success and -1 on error.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_translations_path "(3)
diff -pruN selinux.orig/libselinux/man/man3/selinux_set_callback.3 selinux.newmanpages/libselinux/man/man3/selinux_set_callback.3
--- selinux.orig/libselinux/man/man3/selinux_set_callback.3	2009-11-30 18:23:35.295111911 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_set_callback.3	2009-11-30 14:28:48.797112709 +0100
@@ -111,8 +111,9 @@ None.
 Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
+.BR selinux_get_callback (3),
 .BR selabel_open (3),
 .BR avc_init (3),
-.BR avc_netlink_open(3),
+.BR avc_netlink_open (3),
 .BR selinux (8)
 
diff -pruN selinux.orig/libselinux/man/man3/selinux_translations_path.3 selinux.newmanpages/libselinux/man/man3/selinux_translations_path.3
--- selinux.orig/libselinux/man/man3/selinux_translations_path.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_translations_path.3	2009-11-30 17:29:20.823113396 +0100
@@ -0,0 +1,28 @@
+.TH "selinux_translations_path" "3" "30 Nov 2009" "guido@trentalancia.com" "SELinux API"
+.SH "NAME"
+selinux_translations_path \- get the path to the file which specifies the security context translations.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "const char * selinux_translations_path(void);"
+
+.SH "DESCRIPTION"
+.B selinux_translations_path
+returns a pointer to a string representing the path to the file which
+specifies the translations of the security contexts from their "raw"
+representation.
+.sp
+The translation mechanism is only used in conjunction with the MLS
+(Multi-Level Security) or MCS (Multiple Category Security) policies.
+
+.SH "RETURN VALUE"
+.B selinux_translations_path
+returns a pointer to the string value of the path to the file which 
+specifies the translations of the security contexts.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_raw_to_trans_context "(3), " selinux_trans_to_raw_context "(3)
diff -pruN selinux.orig/libselinux/man/man3/selinux_trans_to_raw_context.3 selinux.newmanpages/libselinux/man/man3/selinux_trans_to_raw_context.3
--- selinux.orig/libselinux/man/man3/selinux_trans_to_raw_context.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_trans_to_raw_context.3	2009-11-30 14:33:10.104114416 +0100
@@ -0,0 +1 @@
+.so man3/selinux_raw_to_trans_context.3
diff -pruN selinux.orig/libselinux/man/man3/selinux_users_path.3 selinux.newmanpages/libselinux/man/man3/selinux_users_path.3
--- selinux.orig/libselinux/man/man3/selinux_users_path.3	1970-01-01 01:00:00.000000000 +0100
+++ selinux.newmanpages/libselinux/man/man3/selinux_users_path.3	2009-11-30 18:19:01.242131888 +0100
@@ -0,0 +1,36 @@
+.TH "selinux_users_path" "3" "30 Nov 2009" "guido@trentalancia.com" "SELinux API"
+.SH "NAME"
+selinux_users_path \- get the path to the directory containing the SELinux user identities files.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "const char * selinux_users_path(void);"
+
+.SH "DESCRIPTION"
+.B selinux_users_path
+returns a pointer to a string representing the path to the directory
+which contains the files that describe the various SELinux user
+identities.
+.sp
+In general, such directory contains a file for each SELinux user
+identity. The file is named after the identity itself and describes
+the role that is assigned to a given user, for example, when the
+login is made (a given user could be assigned a different role
+depending on whether the login is local or remote) or when crontab
+jobs need to be runned on behalf of that user.
+.sp
+Although they might have the same name and are generally matched
+together, SELinux user identities are different from Unix user
+identities.
+
+.SH "RETURN VALUE"
+.B selinux_users_path
+returns a pointer to the string value of the path to the directory which 
+contains the files that describe the various SELinux user identities.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>.
+
+.SH "SEE ALSO"
+.BR selinux "(8)
diff -pruN selinux.orig/libselinux/man/man3/setfilecon.3 selinux.newmanpages/libselinux/man/man3/setfilecon.3
--- selinux.orig/libselinux/man/man3/setfilecon.3	2009-11-30 18:23:35.298113838 +0100
+++ selinux.newmanpages/libselinux/man/man3/setfilecon.3	2009-11-30 12:59:32.346112764 +0100
@@ -17,19 +17,19 @@ sets the security context of the file sy
 
 .B lsetfilecon
 is identical to setfilecon, except in the case of a symbolic link, where the
-link itself has it's context set, not the file that it refers to.
+link itself has its context set, not the file that it refers to.
 
 .B fsetfilecon
 is identical to setfilecon, only the open file pointed to by filedes (as
-returned by open(2)) has it's context set in place of path.
+returned by open(2)) has its context set in place of path.
 
 .SH "RETURN VALUE"
 On success, zero is returned. On failure, -1 is returned and errno is
 set appropriately.
 
 If there is insufficient space remaining to store the extended
-attribute, errno is set to either ENOSPC, or EDQUOT if quota enforce-
-ment was the cause.
+attribute, errno is set to either ENOSPC, or EDQUOT if quota
+enforcement was the cause.
 
 If extended attributes are not supported by the filesystem, or are dis-
 abled, errno is set to ENOTSUP.

--=-p0VEQMDEbV8Qqk62lF65--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
