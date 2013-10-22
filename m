Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MGvgTa005786
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 12:57:43 -0400
Received: by mail-ee0-f51.google.com with SMTP id d41so1021189eek.24
        for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 09:57:40 -0700 (PDT)
Received: from yow-turd.ottawa.windriver.com ([128.224.252.2])
        by mx.google.com with ESMTPSA id r48sm58928307eev.14.2013.10.22.09.57.37
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 09:57:38 -0700 (PDT)
From: Joe MacDonald <joe@deserted.net>
To: selinux@tycho.nsa.gov
Subject: [PATCH][v3] libselinux: support building on older PCRE libs
Date: Tue, 22 Oct 2013 12:57:36 -0400
Message-Id: <1382461056-20536-1-git-send-email-joe@deserted.net>
In-Reply-To: <20131022150005.GD3728@deserted.net>
References: <20131022150005.GD3728@deserted.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
absence, use pcre_free() instead.

Signed-off-by: Joe MacDonald <joe@deserted.net>
---

[Re: [PATCH] libselinux: support building on older PCRE libs] On 13.10.22 (Tue
11:56) Stephen Smalley wrote:

> I think you want PCRE_MAJOR < 8 || PCRE_MAJOR == 8 && PCRE_MINOR < 20 to
> avoid problems when we get to version 9.

That is exactly what I wanted, thanks Stephen.

-J.

 libselinux/src/label_file.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index bf0c9e2..0aad3e7 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -8,6 +8,11 @@
 #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
 #define SELINUX_COMPILED_FCONTEXT_MAX_VERS	1
 
+/* Prior to verison 8.20, libpcre did not have pcre_free_study() */
+#if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
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
