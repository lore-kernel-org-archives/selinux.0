From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu,  3 May 2018 14:48:45 -0400
Message-Id: <20180503184845.19790-5-sds@tycho.nsa.gov>
In-Reply-To: <20180503184845.19790-1-sds@tycho.nsa.gov>
References: <20180503184845.19790-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 4/4] libselinux: audit2why: fix build warnings
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following build warnings.

audit2why.c: In function ‘__policy_init’:
audit2why.c:207:22: warning: ‘%s’ directive output may be truncated writing up to 4095 bytes into a region of size 4081 [-Wformat-truncation=]
      "unable to open %s:  %s\n",
                      ^~
      path, strerror(errno));
      ~~~~
audit2why.c:206:4: note: ‘snprintf’ output 20 or more bytes (assuming 4115) into a destination of size 4096
    snprintf(errormsg, sizeof(errormsg),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      "unable to open %s:  %s\n",
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      path, strerror(errno));
      ~~~~~~~~~~~~~~~~~~~~~~
audit2why.c:253:28: warning: ‘%s’ directive output may be truncated writing up to 4095 bytes into a region of size 4074 [-Wformat-truncation=]
     "invalid binary policy %s\n", path);
                            ^~     ~~~~
audit2why.c:252:3: note: ‘snprintf’ output between 24 and 4119 bytes into a destination of size 4096
   snprintf(errormsg, sizeof(errormsg),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "invalid binary policy %s\n", path);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/audit2why.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 857383ac..0331fdfd 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -193,7 +193,7 @@ static int __policy_init(const char *init_path)
 {
 	FILE *fp;
 	char path[PATH_MAX];
-	char errormsg[PATH_MAX];
+	char errormsg[PATH_MAX+1024+20];
 	struct sepol_policy_file *pf = NULL;
 	int rc;
 	unsigned int cnt;
-- 
2.14.3
