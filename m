Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pARG8C9l004111
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 11:08:12 -0500
Received: from nm4-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pARG8BPm016660
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 16:08:11 GMT
Message-ID: <1322410090.69485.YahooMailClassic@web87006.mail.ird.yahoo.com>
Date: Sun, 27 Nov 2011 16:08:10 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] libselinux - return EINVAL if invalid role selected
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For get_default_context_with_role(3) and get_default_context_with_rolelevel(3), return errno = EINVAL if invalid role.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/get_context_list.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 37d80f2..e02157c 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -38,8 +38,10 @@ int get_default_context_with_role(const char *user,
 	}
 
 	rc = -1;
-	if (!(*ptr))
+	if (!(*ptr)) {
+		errno = EINVAL;
 		goto out;
+	}
 	*newcon = strdup(*ptr);
 	if (!(*newcon))
 		goto out;
-- 
1.7.7.1





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
