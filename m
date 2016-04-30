Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3U7x7jJ016239
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 03:59:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so14469704pfz.1
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 00:59:12 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
Subject: [PATCH v4 7/7] genhomedircon: fix FALLBACK_NAME regex
Date: Sat, 30 Apr 2016 15:58:12 +0800
Message-Id: <1462003092-4611-8-git-send-email-jason@perfinion.com>
In-Reply-To: <1462003092-4611-1-git-send-email-jason@perfinion.com>
References: <1462003092-4611-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Originally the fallback regex for the username was either ".*" or
"[^/]*". The second is more correct but still can match nothing.
changing the * to + means that it must match at least one character.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 6c6eaef..c5ea436 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -86,7 +86,7 @@
 #define FALLBACK_SENAME "user_u"
 #define FALLBACK_PREFIX "user"
 #define FALLBACK_LEVEL "s0"
-#define FALLBACK_NAME ".*"
+#define FALLBACK_NAME "[^/]+"
 #define FALLBACK_UIDGID "[0-9]+"
 #define DEFAULT_LOGIN "__default__"
 
@@ -1024,7 +1024,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 		for (h = homedirs; h; h = h->next) {
 			Ustr *temp = ustr_dup_cstr(h->data);
 
-			if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
+			if (!temp || !ustr_add_cstr(&temp, "/" FALLBACK_NAME)) {
 				ustr_sc_free(&temp);
 				retval = STATUS_ERR;
 				goto done;
-- 
2.7.3
