Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwipG005432
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:46 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DEA4E564780
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:38 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/8] libsemanage: make lang_ext parameter const in
 semanage_direct_write_langext()
Date: Sun,  5 Feb 2017 16:58:14 +0100
Message-Id: <20170205155820.29157-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building with "clang -Wwrite-strings", the compiler reports the
following warnings:

    direct_api.c:1030:46: error: passing 'const char [4]' to parameter
    of type 'char *' discards qualifiers
    [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    status = semanage_direct_write_langext(sh, "cil", modinfo);
                                                               ^~~~~
    direct_api.c:898:11: note: passing argument to parameter 'lang_ext'
    here
                                    char *lang_ext,
                                          ^
    direct_api.c:1030:46: error: passing 'const char [4]' to parameter
    of type 'char *' discards qualifiers
    [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    status = semanage_direct_write_langext(sh, "cil", modinfo);
                                                               ^~~~~
    direct_api.c:898:11: note: passing argument to parameter 'lang_ext'
    here
                                    char *lang_ext,
                                          ^

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/direct_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 742c54f037c7..c23494bb4270 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -895,7 +895,7 @@ cleanup:
 }
 
 static int semanage_direct_write_langext(semanage_handle_t *sh,
-				char *lang_ext,
+				const char *lang_ext,
 				const semanage_module_info_t *modinfo)
 {
 	int ret = -1;
-- 
2.11.0
