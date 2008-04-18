From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 04/13] SELinux: netnode.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:25 -0400
Message-Id: <12085547143090-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547142711-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes netnode.c to fix whitespace and syntax issues.  Things that
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
 security/selinux/netnode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index f3c526f..2edc4c5 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -344,7 +344,7 @@ static __init int sel_netnode_init(void)
 		INIT_LIST_HEAD(&sel_netnode_hash[iter]);
 
 	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET,
-	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
 	if (ret != 0)
 		panic("avc_add_callback() failed, error %d\n", ret);
 
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
