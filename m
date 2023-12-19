Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038611D140
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nwmkxlad"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a236456fee1so251563766b.1
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002213; x=1703607013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=altqZyX0zTQ2UMVZ0cwNTY7l34ou2n2ZoZAQGilpw/Y=;
        b=Nwmkxlad/9axKXuGHYQLjS5UeWID9KGeKI/Vy20eR0fsyjQTAHA5yMRjF3ATpnEaar
         W1+Q/QfLs6jh0deNkpczX73LGfGQNTzXSyVM5bcbE7juKlnckHl1S5EARuFxYfLab9kL
         tq/oJNhyvNpsxFmXksUOmIdpw8W8u+RPiBTuxG68ZjON4a0Ykz9NzO0nGJF0V9sjnhx+
         JZcPLB9CB3mZRK50EAWeVhUI4sCAAdhVCHIDWLzwr9kk6rde6zgJsohgfVocd6vOV0zf
         4/vN6b9mi/CTi/Kry19pnv4DbFvUw3e0FIBEQRGO1BefFALuPxzkfFEQ3N5LNTgsuZd4
         xphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002213; x=1703607013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=altqZyX0zTQ2UMVZ0cwNTY7l34ou2n2ZoZAQGilpw/Y=;
        b=Yv4ml2jyKmnuGX0+gy9oaWaDQsFp8SGXBSBZCfx9DB7oe21ROhbKY6XY9kPvjEFY2z
         1KvWNXFNBsdQm+XFK0mEol32OUAfA33UFLXhvtrUqtlq88OVUlKdGxYntKrgG9K64woS
         6mOTLfDnQAztq1348hfYPbdMSRmL6gbiF2+lpiC3a0jn5Ok0NUCIhNrBwBZZ+PAk3m2y
         6hPtbTPOPkMdkSlANMVNIM/QD8c5A9tdNO1kWWn0VzKAZIOyp7Cq6KRt3g7j46NNMcx7
         hB4+/mxn9uiDmlHxRoEZntxQOfcfmv2AsbwLp9jMvjvZ/OJg+KBkq/k6g2ru5hMtjWXz
         krmg==
X-Gm-Message-State: AOJu0YwhltZP4Ps15I9LIUHtZCZpTvkFwI+5k7wLolQ0dFYxNPkWb89d
	MB+AgestyD7gFrdyuGHsVnRlYjnEgWw=
X-Google-Smtp-Source: AGHT+IH6LSbo94AJ53G3JeJlA9kgg+fy5YsAB9WcjBlw163GKqGPozjT/L7+ei+VwmWeOi+GIPrROw==
X-Received: by 2002:a17:907:c313:b0:a23:6dfa:f7ae with SMTP id tl19-20020a170907c31300b00a236dfaf7aemr2034519ejc.104.1703002213172;
        Tue, 19 Dec 2023 08:10:13 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:12 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 03/11] libselinux/utils: free allocated resources
Date: Tue, 19 Dec 2023 17:09:25 +0100
Message-ID: <20231219160943.334370-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove noise while running with sanitizers or under valgrind.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getconlist.c     | 10 +++++++---
 libselinux/utils/getdefaultcon.c  | 20 +++++++++++++++++---
 libselinux/utils/selinuxexeccon.c |  1 +
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 92f6a793..1ff05209 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -19,8 +19,9 @@ static __attribute__ ((__noreturn__)) void usage(const char *name, const char *d
 
 int main(int argc, char **argv)
 {
-	char **list, *cur_context = NULL;
-	char *user = NULL, *level = NULL;
+	char **list;
+	const char *cur_context, *user;
+	char *cur_con = NULL, *level = NULL;
 	int ret, i, opt;
 
 	while ((opt = getopt(argc, argv, "l:")) > 0) {
@@ -54,11 +55,12 @@ int main(int argc, char **argv)
 
 	/* If a context wasn't passed, use the current context. */
 	if (((argc - optind) < 2)) {
-		if (getcon(&cur_context) < 0) {
+		if (getcon(&cur_con) < 0) {
 			fprintf(stderr, "Couldn't get current context:  %s\n", strerror(errno));
 			free(level);
 			return 2;
 		}
+		cur_context = cur_con;
 	} else {
 		cur_context = argv[optind + 1];
 		if (security_check_context(cur_context) != 0) {
@@ -82,10 +84,12 @@ int main(int argc, char **argv)
 	} else {
 		fprintf(stderr, "get_ordered_context_list%s failure: %d(%s)\n",
 			level ? "_with_level" : "", errno, strerror(errno));
+		free(cur_con);
 		free(level);
 		return 4;
 	}
 
+	free(cur_con);
 	free(level);
 
 	return 0;
diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 50f1ea91..67c84f94 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -19,8 +19,9 @@ static __attribute__ ((__noreturn__)) void usage(const char *name, const char *d
 
 int main(int argc, char **argv)
 {
-	char * usercon = NULL, *cur_context = NULL;
-	char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL, *dlevel=NULL;
+	const char *cur_context, *user;
+	char *usercon = NULL, *cur_con = NULL;
+	char *level = NULL, *role=NULL, *seuser=NULL, *dlevel=NULL;
 	char *service = NULL;
 	int ret, opt;
 	int verbose = 0;
@@ -54,6 +55,9 @@ int main(int argc, char **argv)
 	if (!is_selinux_enabled()) {
 		fprintf(stderr,
 			"%s may be used only on a SELinux kernel.\n", argv[0]);
+		free(level);
+		free(role);
+		free(service);
 		return 1;
 	}
 
@@ -61,15 +65,23 @@ int main(int argc, char **argv)
 
 	/* If a context wasn't passed, use the current context. */
 	if ((argc - optind) < 2) {
-		if (getcon(&cur_context) < 0) {
+		if (getcon(&cur_con) < 0) {
 			fprintf(stderr, "%s:  couldn't get current context:  %s\n", argv[0], strerror(errno));
+			free(level);
+			free(role);
+			free(service);
 			return 2;
 		}
+		cur_context = cur_con;
 	} else
 		cur_context = argv[optind + 1];
 
 	if (security_check_context(cur_context)) {
 		fprintf(stderr, "%s:  invalid from context '%s'\n", argv[0], cur_context);
+		free(cur_con);
+		free(level);
+		free(role);
+		free(service);
 		return 3;
 	}
 
@@ -101,6 +113,8 @@ out:
 	if (level != dlevel) free(level);
 	free(dlevel);
 	free(usercon);
+	free(cur_con);
+	free(service);
 
 	return ret >= 0;
 }
diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinuxexeccon.c
index 66754b6a..463bf5aa 100644
--- a/libselinux/utils/selinuxexeccon.c
+++ b/libselinux/utils/selinuxexeccon.c
@@ -45,6 +45,7 @@ int main(int argc, char **argv)
 		con = strdup(argv[2]);
 		if (security_check_context(con)) {
 			fprintf(stderr, "%s:  invalid from context '%s'\n", argv[0], con);
+			free(con);
 			return -1;
 		}
 	}
-- 
2.43.0

