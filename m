From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 02/13] SELinux: netlabel.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:23 -0400
Message-Id: <12085547142360-git-send-email-eparis@redhat.com>
In-Reply-To: <1208554714617-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes netlabel.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/netlabel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index e8ee91a..89b4183 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -118,7 +118,7 @@ void selinux_netlbl_cache_invalidate(void)
 void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec,
 				      int family)
 {
-        if (family == PF_INET)
+	if (family == PF_INET)
 		ssec->nlbl_state = NLBL_REQUIRE;
 	else
 		ssec->nlbl_state = NLBL_UNSET;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
