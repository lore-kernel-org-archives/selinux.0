Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C3CC4332F
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLHN0b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLHN00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 08:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C786591
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKTQaZodpDnpl5W9gAWwAe7PlIi7MNaR1U1ZdaGrtOY=;
        b=EzR4g6nNtt9Akob03gVThZwSpF8yeymrkuKAtjbarkny83WphZGikzGIZSVWTaPhXIgHId
        CZM1cI2k3vgAT6YHR1bzcsI/JRAA0c0WQkLI8rSylGkvPJ1fzkc0UKf6TGuUYK9xn+pZpE
        t2WIzL5YDnswPd2C+FNIKoruDBTHYZA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-PWZY8FZoNwGn6uQEUlb3jg-1; Thu, 08 Dec 2022 08:25:29 -0500
X-MC-Unique: PWZY8FZoNwGn6uQEUlb3jg-1
Received: by mail-ej1-f71.google.com with SMTP id hd17-20020a170907969100b007c117851c81so1082835ejc.10
        for <selinux@vger.kernel.org>; Thu, 08 Dec 2022 05:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKTQaZodpDnpl5W9gAWwAe7PlIi7MNaR1U1ZdaGrtOY=;
        b=yPJPoWMBKwoz3OCstkR6/ZtfPUZayBKJhdKb+gm4vM6K+uT0ARh1O3lwYSI6pJrdx9
         v0I0QU/kHMFUPaoE4bakdNLzhdufrhejT+wJUrizNsd5TFIcKPW7kyzYGvG7kWCbcpbW
         92xKblox2hiN1sPqqbZjN8YB6QlC4NsSkc2H/R3s4uYj1PPVmgDzTJOIUcRQBx6zf7iK
         N557sZ7GSGEofz+wqisFZYr0Onp8qsw2HRyvPtoVBwgglXm0KI1BMznRHA9mqwwYOVkr
         z5WL8Z/kBOk6ASZ4/YCIHp72pCy1kuj+xDKlsfj8ooQNv8yx4TNxbKOmY2IMkOC5d75C
         G3HA==
X-Gm-Message-State: ANoB5pn9XDLRHqLXwSwJtUbsW2bTVS9KNSi3OFtPsZZUseuzt1lJPRTR
        FaRxkxpZNEDdPbWuLW47PhApOCJw8iF/FFKK5OxA4NtTmYesIwTRLlRxQtAOHbfq5yIbOvQzyy2
        uAykgdbKuCq1FMA29uuph4Eg2KnS9Qj7StGmGN45Hhwd++WTUYcURKgJTKXybgfN6E3dWjw==
X-Received: by 2002:a17:906:5402:b0:7be:ac3d:f67c with SMTP id q2-20020a170906540200b007beac3df67cmr1720783ejo.44.1670505928218;
        Thu, 08 Dec 2022 05:25:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7x8xyHTnOEbHvArYt2d3A+oWaOq2yktM5/krZaQB7Whv4QnhxYGY/5DAn3j4bhQHl7CmqMqQ==
X-Received: by 2002:a17:906:5402:b0:7be:ac3d:f67c with SMTP id q2-20020a170906540200b007beac3df67cmr1720765ejo.44.1670505927637;
        Thu, 08 Dec 2022 05:25:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709066b1200b007bf988ce9f7sm9753959ejr.38.2022.12.08.05.25.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:25:26 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/4] tests: use correct type for context string variables
Date:   Thu,  8 Dec 2022 14:25:20 +0100
Message-Id: <20221208132522.309657-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208132522.309657-1-omosnace@redhat.com>
References: <20221208132522.309657-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In libselinux 3.4+ the return type of context_str(3) changed to const
cahr *, so fix the code to compile without warnings with either old or
new libselinux.

Also fix various context variable mishandling and error path logic
discovered along the way.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/bounds/thread.c                         | 17 +++----
 tests/dyntrace/parent.c                       | 13 +++---
 tests/dyntrans/parent.c                       |  9 ++--
 tests/execshare/parent.c                      |  9 ++--
 tests/exectrace/parent.c                      | 13 +++---
 tests/filesystem/check_mount_context.c        | 13 +++---
 tests/filesystem/create_file_change_context.c | 46 +++++++++----------
 tests/filesystem/fs_relabel.c                 | 10 ++--
 tests/inherit/parent.c                        |  9 ++--
 tests/keys/keyring_service.c                  | 15 +++---
 tests/prlimit/parent.c                        |  9 ++--
 tests/setnice/parent.c                        |  9 ++--
 tests/tun_tap/tun_common.c                    |  4 +-
 tests/tun_tap/tun_common.h                    |  2 +-
 tests/tun_tap/tun_relabel.c                   |  3 +-
 15 files changed, 95 insertions(+), 86 deletions(-)

diff --git a/tests/bounds/thread.c b/tests/bounds/thread.c
index acb976f..eccfeb8 100644
--- a/tests/bounds/thread.c
+++ b/tests/bounds/thread.c
@@ -19,7 +19,7 @@ static int thread_status = 0;
 
 static void *worker(void *datap)
 {
-	char *security_context = datap;
+	const char *security_context = datap;
 	int rc;
 
 	rc = setcon(security_context);
@@ -31,7 +31,8 @@ static void *worker(void *datap)
 
 int main(int argc, char *argv[])
 {
-	char *security_context;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 	pthread_t thread;
 	int rc;
@@ -41,13 +42,13 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	rc = getcon(&security_context);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s: unable to get my context\n", argv[0]);
 		return 1;
 	}
 
-	context = context_new(security_context);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s: unable to create context structure\n", argv[0]);
 		return 1;
@@ -58,14 +59,14 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	freecon(security_context);
-	security_context = context_str(context);
-	if (!security_context) {
+	freecon(context_tmp);
+	context_s = context_str(context);
+	if (!context_s) {
 		fprintf(stderr, "%s: unable to obtain new context string\n", argv[0]);
 		return 1;
 	}
 
-	rc = pthread_create(&thread, NULL, worker, security_context);
+	rc = pthread_create(&thread, NULL, worker, (void *)context_s);
 	if (rc) {
 		fprintf(stderr, "%s: unable to kick a new thread\n", argv[0]);
 		return 1;
diff --git a/tests/dyntrace/parent.c b/tests/dyntrace/parent.c
index 63cbd76..6b98463 100644
--- a/tests/dyntrace/parent.c
+++ b/tests/dyntrace/parent.c
@@ -12,7 +12,8 @@
 int main(int argc, char **argv)
 {
 	int pid, rc, status;
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 	char *child_argv[3];
 
@@ -21,14 +22,14 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -39,7 +40,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
@@ -79,12 +80,12 @@ repeat:
 
 	if (WIFSTOPPED(status)) {
 		fprintf(stderr, "Child stopped by signal %d.\n", WSTOPSIG(status));
-		rc = getpidcon(pid, &context_s);
+		rc = getpidcon(pid, &context_tmp);
 		if (rc < 0) {
 			perror("getpidcon");
 			exit(-1);
 		}
-		fprintf(stderr, "Child has context %s\n", context_s);
+		fprintf(stderr, "Child has context %s\n", context_tmp);
 		fprintf(stderr, "..Resuming the child.\n");
 		rc = ptrace(PTRACE_CONT, pid, 0, 0);
 		if (rc < 0) {
diff --git a/tests/dyntrans/parent.c b/tests/dyntrans/parent.c
index c8320cc..e86b3ed 100644
--- a/tests/dyntrans/parent.c
+++ b/tests/dyntrans/parent.c
@@ -11,7 +11,8 @@
 int main(int argc, char **argv)
 {
 	int rc;
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 
 	if (argc != 2) {
@@ -19,14 +20,14 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -37,7 +38,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index 5b9bd80..7c689fd 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -22,7 +22,8 @@ int main(int argc, char **argv)
 	int pagesize;
 	void *clone_stack, *page;
 	int pid, rc, status, cloneflags;
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 
 	if (argc != 4) {
@@ -44,14 +45,14 @@ int main(int argc, char **argv)
 	}
 	clone_stack = page + pagesize;
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -62,7 +63,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
diff --git a/tests/exectrace/parent.c b/tests/exectrace/parent.c
index 6906ee9..9c37f61 100644
--- a/tests/exectrace/parent.c
+++ b/tests/exectrace/parent.c
@@ -11,7 +11,8 @@
 int main(int argc, char **argv)
 {
 	int pid, rc, status;
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 
 	if (argc != 3) {
@@ -19,14 +20,14 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -37,7 +38,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
@@ -80,12 +81,12 @@ repeat:
 
 	if (WIFSTOPPED(status)) {
 		fprintf(stderr, "Child stopped by signal %d.\n", WSTOPSIG(status));
-		rc = getpidcon(pid, &context_s);
+		rc = getpidcon(pid, &context_tmp);
 		if (rc < 0) {
 			perror("getpidcon");
 			exit(-1);
 		}
-		fprintf(stderr, "Child has context %s\n", context_s);
+		fprintf(stderr, "Child has context %s\n", context_tmp);
 		fprintf(stderr, "..Resuming the child.\n");
 		rc = ptrace(PTRACE_CONT, pid, 0, 0);
 		if (rc < 0) {
diff --git a/tests/filesystem/check_mount_context.c b/tests/filesystem/check_mount_context.c
index 2899dea..7d503b8 100644
--- a/tests/filesystem/check_mount_context.c
+++ b/tests/filesystem/check_mount_context.c
@@ -24,7 +24,8 @@ static void print_usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, result;
-	char *context = NULL, *expected = NULL, *mount = NULL, *newcon = NULL;
+	const char *newcon;
+	char *context = NULL, *expected = NULL, *mount = NULL;
 	bool verbose = false, reset = false;
 	const char *type = "unlabeled_t";
 	context_t con_t;
@@ -74,21 +75,21 @@ int main(int argc, char **argv)
 
 		if (context_type_set(con_t, type)) {
 			fprintf(stderr, "Unable to set new type\n");
-			free(con_t);
+			context_free(con_t);
 			result = -1;
 			goto err;
 		}
 
 		newcon = context_str(con_t);
-		free(con_t);
 		if (!newcon) {
 			fprintf(stderr, "Unable to obtain new context string\n");
 			result = -1;
+			context_free(con_t);
 			goto err;
 		}
 
 		result = setfilecon(mount, newcon);
-		free(newcon);
+		context_free(con_t);
 		if (result < 0) {
 			fprintf(stderr, "setfilecon(3) Failed: %s\n",
 				strerror(errno));
@@ -96,7 +97,7 @@ int main(int argc, char **argv)
 			goto err;
 		}
 
-		free(context);
+		freecon(context);
 
 		result = getfilecon(mount, &context);
 		if (result < 0) {
@@ -122,6 +123,6 @@ int main(int argc, char **argv)
 	}
 
 err:
-	free(context);
+	freecon(context);
 	return result;
 }
diff --git a/tests/filesystem/create_file_change_context.c b/tests/filesystem/create_file_change_context.c
index 83f780e..44ded46 100644
--- a/tests/filesystem/create_file_change_context.c
+++ b/tests/filesystem/create_file_change_context.c
@@ -23,7 +23,8 @@ static void print_usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, result, fd, save_err;
-	char *newfcon = NULL, *orgfcon = NULL, *type = NULL, *file = NULL;
+	const char *newfcon;
+	char *orgfcon, *type = NULL, *file = NULL;
 	char *context;
 	bool verbose = false;
 	context_t con_t;
@@ -62,7 +63,7 @@ int main(int argc, char **argv)
 	fd = creat(file, O_RDWR);
 	save_err = errno;
 	if (fd < 0) {
-		fprintf(stderr, "creat(2) Failed: %s\n", strerror(errno));
+		fprintf(stderr, "creat(2) Failed: %s\n", strerror(save_err));
 		return save_err;
 	}
 	if (verbose)
@@ -80,25 +81,26 @@ int main(int argc, char **argv)
 
 	/* Build new file context */
 	con_t = context_new(orgfcon);
+	freecon(orgfcon);
 	if (!con_t) {
 		fprintf(stderr, "Unable to create context structure\n");
-		result = -1;
-		goto err;
+		close(fd);
+		return -1;
 	}
 
 	if (context_type_set(con_t, type)) {
 		fprintf(stderr, "Unable to set new type\n");
-		free(con_t);
-		result = -1;
-		goto err;
+		context_free(con_t);
+		close(fd);
+		return -1;
 	}
 
 	newfcon = context_str(con_t);
-	free(con_t);
 	if (!newfcon) {
 		fprintf(stderr, "Unable to obtain new context string\n");
-		result = -1;
-		goto err;
+		context_free(con_t);
+		close(fd);
+		return -1;
 	}
 
 	/* hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE */
@@ -107,28 +109,31 @@ int main(int argc, char **argv)
 	close(fd);
 	if (result < 0) {
 		fprintf(stderr, "fsetfilecon(3) Failed: %s\n",
-			strerror(errno));
-		result = save_err;
-		goto err1;
+			strerror(save_err));
+		context_free(con_t);
+		return save_err;
 	}
 
 	fd = open(file, O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "open(2) Failed: %s\n", strerror(errno));
-		result = -1;
-		goto err1;
+		context_free(con_t);
+		return -1;
 	}
 
 	result = fgetfilecon(fd, &context);
 	if (result < 0) {
 		fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
 			strerror(errno));
-		result = -1;
-		goto err1;
+		close(fd);
+		context_free(con_t);
+		return -1;
 	}
 	if (verbose)
 		printf("New file context is: %s\n", context);
 
+	close(fd);
+
 	result = 0;
 	if (strcmp(newfcon, context)) {
 		fprintf(stderr, "File context error, expected:\n\t%s\ngot:\n\t%s\n",
@@ -136,11 +141,6 @@ int main(int argc, char **argv)
 		result = -1;
 	}
 
-err:
-	free(orgfcon);
-err1:
-	free(newfcon);
-	close(fd);
-
+	context_free(con_t);
 	return result;
 }
diff --git a/tests/filesystem/fs_relabel.c b/tests/filesystem/fs_relabel.c
index 8ebc0bf..4daf70c 100644
--- a/tests/filesystem/fs_relabel.c
+++ b/tests/filesystem/fs_relabel.c
@@ -26,7 +26,8 @@ static void print_usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, result, save_err;
-	char *context, *fs_con = NULL, *newcon = NULL, *base_dir, *type;
+	const char *newcon;
+	char *context, *fs_con = NULL, *base_dir, *type;
 	char fs_mount[PATH_MAX];
 	bool verbose = false;
 	context_t con_t;
@@ -57,7 +58,7 @@ int main(int argc, char **argv)
 			exit(-1);
 		}
 		printf("Process context:\n\t%s\n", context);
-		free(context);
+		freecon(context);
 	}
 
 	result = getfilecon(base_dir, &context);
@@ -130,9 +131,8 @@ int main(int argc, char **argv)
 		result = -1;
 	}
 err:
-	free(context);
-	free(newcon);
-	free(fs_con);
+	freecon(context);
+	freecon(fs_con);
 
 	return result;
 }
diff --git a/tests/inherit/parent.c b/tests/inherit/parent.c
index 10b59b4..d37bcfe 100644
--- a/tests/inherit/parent.c
+++ b/tests/inherit/parent.c
@@ -9,7 +9,8 @@
 int main(int argc, char **argv)
 {
 	char **childargv;
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 	int rc, fd;
 
@@ -18,14 +19,14 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -36,7 +37,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
diff --git a/tests/keys/keyring_service.c b/tests/keys/keyring_service.c
index 9913653..b83a7b9 100644
--- a/tests/keys/keyring_service.c
+++ b/tests/keys/keyring_service.c
@@ -15,7 +15,8 @@ int main(int argc, char **argv)
 {
 	int opt, pid, result, status;
 	bool verbose;
-	char *context_s, *request_keys_argv[4] = { NULL };
+	const char *context_s;
+	char *context_tmp, *request_keys_argv[4] = { NULL };
 	context_t context;
 	key_serial_t private, prime, base, newring;
 
@@ -38,30 +39,30 @@ int main(int argc, char **argv)
 	if (verbose)
 		printf("%s process information:\n", argv[0]);
 
-	result = getcon(&context_s);
+	result = getcon(&context_tmp);
 	if (result < 0) {
 		fprintf(stderr, "Failed to obtain process context\n");
 		exit(1);
 	}
 	if (verbose)
-		printf("\tProcess context:\n\t\t%s\n", context_s);
+		printf("\tProcess context:\n\t\t%s\n", context_tmp);
 
 	/* Set context requires process { setkeycreate } and key { create } */
-	result = setkeycreatecon(context_s);
+	result = setkeycreatecon(context_tmp);
 	if (result < 0) {
 		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
 			strerror(errno));
 		exit(3);
 	}
 	if (verbose)
-		printf("\tSet keycreate context:\n\t\t%s\n", context_s);
+		printf("\tSet keycreate context:\n\t\t%s\n", context_tmp);
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "Unable to create context structure\n");
 		exit(2);
 	}
-	free(context_s);
+	freecon(context_tmp);
 
 	if (context_type_set(context, argv[optind])) {
 		fprintf(stderr, "Unable to set new type\n");
diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
index b735445..649aecf 100644
--- a/tests/prlimit/parent.c
+++ b/tests/prlimit/parent.c
@@ -26,7 +26,8 @@ int main(int argc, char **argv)
 {
 	char buf[1];
 	int pid, rc, fd[2], fd2[2], opt;
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 	struct rlimit newrlim, oldrlim, *newrlimp = NULL, *oldrlimp = NULL;
 	bool get = false, set = false, soft = false;
@@ -60,14 +61,14 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -78,7 +79,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
diff --git a/tests/setnice/parent.c b/tests/setnice/parent.c
index bbb0c7f..3ac58e4 100644
--- a/tests/setnice/parent.c
+++ b/tests/setnice/parent.c
@@ -14,7 +14,8 @@ int main(int argc, char **argv)
 {
 	char buf[1];
 	int pid, rc, rc2, fd[2], fd2[2];
-	char *context_s;
+	const char *context_s;
+	char *context_tmp;
 	context_t context;
 
 	if (argc != 3) {
@@ -22,14 +23,14 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	rc = getcon(&context_s);
+	rc = getcon(&context_tmp);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
 		exit(-1);
 
 	}
 
-	context = context_new(context_s);
+	context = context_new(context_tmp);
 	if (!context) {
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
@@ -40,7 +41,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	freecon(context_s);
+	freecon(context_tmp);
 	context_s = context_str(context);
 	if (!context_s) {
 		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
diff --git a/tests/tun_tap/tun_common.c b/tests/tun_tap/tun_common.c
index 5a4a5ee..9a3c5de 100644
--- a/tests/tun_tap/tun_common.c
+++ b/tests/tun_tap/tun_common.c
@@ -71,7 +71,7 @@ int tunsetqueue(int fd, int op, char *name, bool verbose)
 	return 0;
 }
 
-int switch_context(char *newcon, bool verbose)
+int switch_context(const char *newcon, bool verbose)
 {
 	int result;
 
@@ -85,8 +85,6 @@ int switch_context(char *newcon, bool verbose)
 	if (verbose)
 		printf("New process context:\n\t%s\n", newcon);
 
-	free(newcon);
-
 	return 0;
 }
 
diff --git a/tests/tun_tap/tun_common.h b/tests/tun_tap/tun_common.h
index 0259563..6a3a604 100644
--- a/tests/tun_tap/tun_common.h
+++ b/tests/tun_tap/tun_common.h
@@ -18,5 +18,5 @@ extern int setiff(int fd, struct ifreq *ifr, bool verbose);
 extern int persist(int fd, int op, char *name, bool verbose);
 /* Queue state 'op': 0 = IFF_DETACH_QUEUE, 1 = IFF_ATTACH_QUEUE */
 extern int tunsetqueue(int fd, int op, char *name, bool verbose);
-extern int switch_context(char *newcon, bool verbose);
+extern int switch_context(const char *newcon, bool verbose);
 extern void del_tuntap_name(int fd, char *context, char *name, bool verbose);
diff --git a/tests/tun_tap/tun_relabel.c b/tests/tun_tap/tun_relabel.c
index 7aeabd1..f4e6771 100644
--- a/tests/tun_tap/tun_relabel.c
+++ b/tests/tun_tap/tun_relabel.c
@@ -13,7 +13,8 @@ static void print_usage(char *progname)
 
 int main(int argc, char *argv[])
 {
-	char *origcon, *newcon, *test_str;
+	const char *newcon;
+	char *origcon, *test_str;
 	char alloc_name[IFNAMSIZ];
 	int opt, result, test, fd1, fd2;
 	bool verbose = false;
-- 
2.38.1

