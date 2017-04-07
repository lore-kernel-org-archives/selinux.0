Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37LdxSc021926
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 17:40:00 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8EFBA564677
 for <selinux@tycho.nsa.gov>; Fri,  7 Apr 2017 22:44:58 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/6] libselinux: ensure that 4 columns are read from
 /proc/mounts
Date: Fri,  7 Apr 2017 22:44:29 +0200
Message-Id: <20170407204431.8572-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170407204431.8572-1-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If exclude_non_seclabel_mounts() ever gets run on a kernel where
/proc/mounts only contains three columns, mount_info[3] will be used
"without being initialized in "strtok(mount_info[3], ",")" because
variable index would be 3 at the end of this loop:

    index = 0;
    item = strtok(buf, " ");
    while (item != NULL) {
        mount_info[index] = item;
        if (index == 3)
            break;
        index++;
        item = strtok(NULL, " ");
    }

Swap the condition on index and its increment so that it gets to 4 only
when there are at least four columns.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinux_restorecon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 9fdafea17de7..eefd2cf83e32 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -252,12 +252,12 @@ static int exclude_non_seclabel_mounts(void)
 		item = strtok(buf, " ");
 		while (item != NULL) {
 			mount_info[index] = item;
-			if (index == 3)
-				break;
 			index++;
+			if (index == 4)
+				break;
 			item = strtok(NULL, " ");
 		}
-		if (index < 3) {
+		if (index < 4) {
 			selinux_log(SELINUX_ERROR,
 				    "/proc/mounts record \"%s\" has incorrect format.\n",
 				    buf);
-- 
2.12.0
