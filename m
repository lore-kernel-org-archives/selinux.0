Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8PCGdhN015441
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 08:16:39 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 91FFF564E1C
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 14:16:34 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libselinux: silent -Wsign-compare warnings
Date: Sun, 25 Sep 2016 14:16:07 +0200
Message-Id: <20160925121609.14516-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building libselinux with gcc and many warning flags, the build
fails with the following errors:

    selinux_restorecon.c: In function ‘selinux_restorecon’:
    selinux_restorecon.c:784:36: error: comparison between signed and
    unsigned integer expressions [-Werror=sign-compare]
       if (!flags.ignore_digest && size == fc_digest_len &&
                                        ^~

    selabel_digest.c: In function ‘main’:
    selabel_digest.c:162:16: error: comparison between signed and
    unsigned integer expressions [-Werror=sign-compare]
      for (i = 0; i < digest_len; i++)
                    ^
    selabel_digest.c:173:17: error: comparison between signed and
    unsigned integer expressions [-Werror=sign-compare]
       for (i = 0; i < num_specfiles; i++) {
                     ^

clang reports the precise type information of the variables:

    selinux_restorecon.c:784:36: error: comparison of integers of
    different signs: 'ssize_t' (aka 'long') and 'size_t' (aka 'unsigned
    long') [-Werror,-Wsign-compare]
                if (!flags.ignore_digest && size == fc_digest_len &&
                                            ~~~~ ^  ~~~~~~~~~~~~~

    selabel_digest.c:162:16: error: comparison of integers of different
    signs: 'int' and 'size_t' (aka 'unsigned long')
    [-Werror,-Wsign-compare]
            for (i = 0; i < digest_len; i++)
                        ~ ^ ~~~~~~~~~~
    selabel_digest.c:173:17: error: comparison of integers of different
    signs: 'int' and 'size_t' (aka 'unsigned long')
    [-Werror,-Wsign-compare]
                    for (i = 0; i < num_specfiles; i++) {
                                ~ ^ ~~~~~~~~~~~~~

Silent the warnings by using size_t where appropriate.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 libselinux/utils/selabel_digest.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index d49fb15f836e..0d3e4d585151 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -781,7 +781,7 @@ int selinux_restorecon(const char *pathname_orig,
 		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
 							    fc_digest_len);
 
-		if (!flags.ignore_digest && size == fc_digest_len &&
+		if (!flags.ignore_digest && (size_t)size == fc_digest_len &&
 			    memcmp(fc_digest, xattr_value, fc_digest_len)
 								    == 0) {
 			selinux_log(SELINUX_INFO,
diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 1e9fb34c46ec..38162a5b3343 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -59,11 +59,11 @@ static int run_check_digest(char *cmd, char *selabel_digest)
 
 int main(int argc, char **argv)
 {
-	int backend = 0, rc, opt, i, validate = 0;
+	int backend = 0, rc, opt, validate = 0;
 	char *baseonly = NULL, *file = NULL, *digest = (char *)1;
 	char **specfiles = NULL;
 	unsigned char *sha1_digest = NULL;
-	size_t num_specfiles;
+	size_t i, num_specfiles;
 
 	char cmd_buf[4096];
 	char *cmd_ptr;
-- 
2.10.0
