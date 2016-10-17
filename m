From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 5/8] libselinux/utils: add noreturn to sefcontext_compile
Date: Mon, 17 Oct 2016 16:24:07 -0400
Message-Id: <1476735850-7844-5-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

When building on mac, one encounters this error:
sefcontext_compile.c:270:1: error: function 'usage' could be declared with attribute 'noreturn' [-Werror,-Wmissing-noreturn]

To correct this, add the attribute noreturn to the function.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/utils/sefcontext_compile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 6b564b4..54600e2 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -266,7 +266,7 @@ static void free_specs(struct saved_data *data)
 	memset(data, 0, sizeof(*data));
 }
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 	    "usage: %s [-o out_file] [-p policy_file] fc_file\n"
-- 
1.9.1
