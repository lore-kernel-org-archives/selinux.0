From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 01/11] Remove jump over variable declaration
Date: Mon, 23 Jan 2012 15:41:11 +0000
Message-Id: <1327333281-4223-2-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

seusers.c: In function ‘getseuser’:
seusers.c:273:3: error: jump skips variable initialization [-Werror=jump-misses-init]
seusers.c:317:2: note: label ‘err’ defined here
seusers.c:274:8: note: ‘fp’ declared here

* seusers.c: Declare FILE *fp at start of getseuser() method
---
 libselinux/src/seusers.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index b653cad..5cdf6c0 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -269,9 +269,10 @@ int getseuser(const char *username, const char *service,
 	size_t lineno = 0;
 	char *rec = NULL;
 	char *path=NULL;
+	FILE *fp = NULL;
 	if (asprintf(&path,"%s/logins/%s", selinux_policy_root(), username) <  0)
 		goto err;
-	FILE *fp = fopen(path, "r");
+	fp = fopen(path, "r");
 	free(path);
 	if (fp == NULL) goto err;
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
