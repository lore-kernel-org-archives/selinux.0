Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3AGIaNN000584
	for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2011 12:18:38 -0400
Received: from nm4-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3AGIZgX016265
	for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2011 16:18:35 GMT
Message-ID: <706242.2086.qm@web87005.mail.ird.yahoo.com>
Date: Sun, 10 Apr 2011 17:18:28 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] mcstransd select correct colour range.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

mcstransd: Now selects the range color for a matching 'range' entry in secolor.conf file, and not the first range to pass the dominance check.

The second patch has the man pages to support the colour functions that match how mcstransd manages colour selection.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policycoreutils/mcstrans/src/mcscolor.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/mcstrans/src/mcscolor.c b/policycoreutils/mcstrans/src/mcscolor.c
index a443320..90c4321 100644
--- a/policycoreutils/mcstrans/src/mcscolor.c
+++ b/policycoreutils/mcstrans/src/mcscolor.c
@@ -135,12 +135,12 @@ static const secolor_t *find_color(int idx, const char *component,
 	}
 
 	while (ptr) {
-		if (idx == COLOR_RANGE) {
-		    if (check_dominance(ptr->pattern, raw) == 0)
-			return &ptr->color;
-		} else {
-		    if (fnmatch(ptr->pattern, component, 0) == 0)
-			return &ptr->color;
+		if (fnmatch(ptr->pattern, component, 0) == 0) {
+			if (idx == COLOR_RANGE) {
+			    if (check_dominance(ptr->pattern, raw) == 0)
+					return &ptr->color;
+			} else 
+				return &ptr->color;
 		}
 		ptr = ptr->next;
 	}
-- 
1.7.3.2


Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
