From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 08/11] Add printf format attribute annotation to die() method
Date: Mon, 23 Jan 2012 15:41:18 +0000
Message-Id: <1327333281-4223-9-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

Annotating the die method as taking printf format exposes
a bug in error reporting
---
 libselinux/utils/avcstat.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 772118a..7239ef2 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -43,7 +43,7 @@ static char buf[DEF_BUF_SIZE];
 /* selinuxfs mount point */
 extern char *selinux_mnt;
 
-static void die(const char *msg, ...)
+static __attribute__((__format__(printf,1,2))) void die(const char *msg, ...)
 {
 	va_list args;
 
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 			exit(0);
 		default:
 			usage();
-			die("unrecognized parameter", i);
+			die("unrecognized parameter '%c'", i);
 		}
 	}
 
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
