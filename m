Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v049xOQ9031559
 for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2017 04:59:24 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 774797D0F9
 for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2017 09:59:12 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/restorecond: Decrease loglevel of termination
 message
Date: Wed,  4 Jan 2017 10:59:07 +0100
Message-Id: <1483523947-14979-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Decrease loglevel of termination message
(eg. "restorecond[709]: terminated") to LOG_INFO because it is printed
upon normal shutdown of the daemon.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1264505

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 restorecond/watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 2be45d4..691df82 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -179,7 +179,7 @@ int watch(int fd, const char *watch_file)
 			syslog(LOG_ERR, "Read error (%s)", strerror(errno));
 			return 0;
 		}
-		syslog(LOG_ERR, "terminated");
+		syslog(LOG_INFO, "terminated");
 		return -1;
 	} else if (!len)
 		/* BUF_LEN too small? */
-- 
2.7.4
