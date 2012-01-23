From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 05/11] Remove unused flush_class_cache method
Date: Mon, 23 Jan 2012 15:41:15 +0000
Message-Id: <1327333281-4223-6-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

* stringrep.c: Delete flush_class_cache
---
 libselinux/src/stringrep.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index f0167e7..176ac34 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -305,28 +305,6 @@ err1:
 	return NULL;
 }
 
-void flush_class_cache(void)
-{
-	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
-	size_t i;
-
-	while (cur != NULL) {
-		free(cur->name);
-
-		for (i=0 ; i<MAXVECTORS ; i++)
-			free(cur->perms[i]);
-
-		free(cur->perms);
-
-		prev = cur;
-		cur = cur->next;
-
-		free(prev);
-	}
-
-	discover_class_cache = NULL;
-}
-
 static security_class_t string_to_security_class_compat(const char *s)
 {
 	unsigned int val;
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
