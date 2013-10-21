Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9LJGs2Z029207
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 15:16:57 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so3909496eek.30
        for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 12:16:54 -0700 (PDT)
Received: from yow-turd.ottawa.windriver.com ([128.224.252.2])
        by mx.google.com with ESMTPSA id w6sm36621954eeo.12.2013.10.21.12.16.52
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 12:16:52 -0700 (PDT)
From: Joe MacDonald <joe@deserted.net>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: support building on older PCRE libs
Date: Mon, 21 Oct 2013 15:16:39 -0400
Message-Id: <1382383000-16439-2-git-send-email-joe@deserted.net>
In-Reply-To: <1382383000-16439-1-git-send-email-joe@deserted.net>
References: <1382383000-16439-1-git-send-email-joe@deserted.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
absence, use pcre_free() instead.

Signed-off-by: Joe MacDonald <joe@deserted.net>
---
 libselinux/src/label_file.c           |    4 ++++
 libselinux/utils/sefcontext_compile.c |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 9b0d6b0..51520cf 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -561,7 +561,11 @@ static void closef(struct selabel_handle *rec)
 		free(spec->type_str);
 		if (spec->regcomp) {
 			pcre_free(spec->regex);
+#if (PCRE_MAJOR >= 8 && PCRE_MINOR >= 20)
 			pcre_free_study(spec->sd);
+#else
+			pcre_free(spec->sd);
+#endif
 		}
 	}
 
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 6f79dd6..b34966b 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -301,7 +301,11 @@ static int free_specs(struct saved_data *data)
 		free(specs[i].lr.ctx_trans);
 		free(specs[i].regex_str);
 		pcre_free(specs[i].regex);
+#if (PCRE_MAJOR >= 8 && PCRE_MINOR >= 20)
 		pcre_free_study(specs[i].sd);
+#else
+		pcre_free(specs[i].sd);
+#endif
 	}
 	free(specs);
 
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
