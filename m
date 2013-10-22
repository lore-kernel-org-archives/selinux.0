Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MEkjv5028076
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 10:46:45 -0400
Received: by mail-ea0-f170.google.com with SMTP id q10so3464119eaj.29
        for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 07:46:42 -0700 (PDT)
Received: from yow-turd.ottawa.windriver.com ([128.224.252.2])
        by mx.google.com with ESMTPSA id a1sm57708392eem.1.2013.10.22.07.46.40
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 07:46:41 -0700 (PDT)
From: Joe MacDonald <joe@deserted.net>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: support building on older PCRE libs
Date: Tue, 22 Oct 2013 10:46:39 -0400
Message-Id: <1382453199-19064-1-git-send-email-joe@deserted.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
absence, use pcre_free() instead.

Signed-off-by: Joe MacDonald <joe@deserted.net>
---

This will hit all uses of pcre_free_study() provided label_file.h gets
included somewhere along the way.  Also makes it cleaner to back out when
ancient versions of libpcre fall off the support map and it keeps the code
from being filled with all-caps.

 libselinux/src/label_file.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index bf0c9e2..7d48832 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -8,6 +8,11 @@
 #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
 #define SELINUX_COMPILED_FCONTEXT_MAX_VERS	1
 
+/* Prior to verison 8.20, libpcre did not have pcre_free_study() */
+#if (PCRE_MAJOR < 8 || PCRE_MINOR < 20)
+#define pcre_free_study  pcre_free
+#endif
+
 /* A file security context specification. */
 struct spec {
 	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
