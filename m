From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu,  3 May 2018 14:48:44 -0400
Message-Id: <20180503184845.19790-4-sds@tycho.nsa.gov>
In-Reply-To: <20180503184845.19790-1-sds@tycho.nsa.gov>
References: <20180503184845.19790-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 3/4] libselinux: avcstat: fix build warning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following build warning.

avcstat.c: In function ‘main’:
avcstat.c:113:4: error: ‘strncpy’ specified bound 4096 equals destination size [-Werror=stringop-truncation]
    strncpy(avcstatfile, optarg, sizeof avcstatfile);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/utils/avcstat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 5ff582b8..884a10bf 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -110,7 +110,8 @@ int main(int argc, char **argv)
 			cumulative = 1;
 			break;
 		case 'f':
-			strncpy(avcstatfile, optarg, sizeof avcstatfile);
+			strncpy(avcstatfile, optarg, sizeof(avcstatfile) - 1);
+			avcstatfile[sizeof(avcstatfile)-1] = '\0';
 			break;
 		case 'h':
 		case '-':
-- 
2.14.3
