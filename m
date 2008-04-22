From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: avc_ss.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:08 -0400
Message-Id: <12089007782175-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes avc_ss.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
location of { around structs and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
no assignments in if statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/avc_ss.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index ff869e8..c0d314d 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -10,22 +10,19 @@
 
 int avc_ss_reset(u32 seqno);
 
-struct av_perm_to_string
-{
+struct av_perm_to_string {
 	u16 tclass;
 	u32 value;
 	const char *name;
 };
 
-struct av_inherit
-{
+struct av_inherit {
 	u16 tclass;
 	const char **common_pts;
 	u32 common_base;
 };
 
-struct selinux_class_perm
-{
+struct selinux_class_perm {
 	const struct av_perm_to_string *av_perm_to_string;
 	u32 av_pts_len;
 	const char **class_to_string;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
