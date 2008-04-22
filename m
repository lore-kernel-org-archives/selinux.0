From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: selinux/include/security.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:11 -0400
Message-Id: <120890077840-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007782327-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes selinux/include/security.h to fix whitespace and syntax issues.  Things that
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
 security/selinux/include/security.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 1904c46..6445b64 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -62,7 +62,7 @@ enum {
 extern int selinux_policycap_netpeer;
 extern int selinux_policycap_openperm;
 
-int security_load_policy(void * data, size_t len);
+int security_load_policy(void *data, size_t len);
 
 int security_policycap_supported(unsigned int req_cap);
 
@@ -110,7 +110,7 @@ int security_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
 
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
-                                 u16 tclass);
+				 u16 tclass);
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
