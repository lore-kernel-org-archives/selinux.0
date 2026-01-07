Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C236346AC9
	for <selinux@vger.kernel.org>; Wed,  7 Jan 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805178; cv=none; b=rpmyPgNWCc0GUMSaNweEfG8VNl3ttEcucGb/UCSITKI9vnYza+KOjqZ12jg7q0nuh+R0y74MlT/NfduQnAZbM0U3xyqdNGrDwIGojp+P1w0p+43hTayOPEmDbgnu3F9Tegum7bMqe5Xs0cimTB0Vyd4aZSlAPtK0M4Oz8G5Ysy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805178; c=relaxed/simple;
	bh=CHhL20Ke5C2J+STOW4ICs2f64EuZpRFd2L2CJxBCaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=hDMaFip5uMNgwIpJyZeKbzmlm/ktENKnCZhLB/ViKx0yLbXOrZd/bfvKK3UptvjslW5A4Aw7Vyo9moJtS9Dyovu0WOICHnLL92L2EaOBSbNQhVfczeXKicH0E++5xzfOAxn2y623uHStdUDisMzbEL1sn+aX5sbSyvbx7fxsOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROmbQORc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROmbQORc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767805170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32bjPJoJPCOcNbSr/cp+3MJoXwsE/jGSFS+DtLTmAYY=;
	b=ROmbQORcMkhTzAlBseAdyDvAV9n/DDlxWxxnDeD2IwPNCHfvkoRSjj7oZb0K77zD1GRSKb
	1vmAzXWhAKKySKXyjRKiQNkahr8P3WFN2J65jvfgYXO2mkgqvr2chIjCywiDTk5ppAZoJw
	yK2eITEauxTYse159lz9TFcgJDotEkg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-xSqwyjKPOuGisYggjHDYvQ-1; Wed,
 07 Jan 2026 11:59:26 -0500
X-MC-Unique: xSqwyjKPOuGisYggjHDYvQ-1
X-Mimecast-MFC-AGG-ID: xSqwyjKPOuGisYggjHDYvQ_1767805165
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF563195608F;
	Wed,  7 Jan 2026 16:59:25 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8675F1800240;
	Wed,  7 Jan 2026 16:59:24 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH v2] sandbox/seunshare: Replace system() with execv() to prevent shell injection
Date: Wed,  7 Jan 2026 17:58:34 +0100
Message-ID: <20260107165908.1584087-1-lautrbach@redhat.com>
In-Reply-To: <DFID35MI20QY.1TO7H1O354V64@gmail.com>
References: <DFID35MI20QY.1TO7H1O354V64@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Refactor spawn_command() to use execv() instead of system() to eliminate
shell injection vulnerabilities.

Reported-By: Rahul Sandhu <nvraxn@gmail.com>
Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
v2  - drop index initialization

 sandbox/seunshare.c | 132 ++++++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 53 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 65da46463a8f..2512a18c7b52 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -56,6 +56,12 @@
 #define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] \
 [ -r runuserdir ] [ -P pipewiresocket ] [ -W waylandsocket ] [ -Z CONTEXT ] -- executable [args] ")
 
+#define strdup_or_err(args, index, src) do {	\
+		args[index] = strdup(src); \
+		if (! args[index]) \
+			goto err; \
+	} while(0)
+
 static int verbose = 0;
 static int child = 0;
 
@@ -136,15 +142,14 @@ static int set_signal_handles(void)
 	} while(0)
 
 /**
- * Spawn external command using system() with dropped privileges.
- * TODO: avoid system() and use exec*() instead
+ * Spawn external command with dropped privileges.
  */
-static int spawn_command(const char *cmd, uid_t uid){
+static int spawn_command(char **cmd, uid_t uid){
 	int childpid;
 	int status = -1;
 
 	if (verbose > 1)
-		printf("spawn_command: %s\n", cmd);
+		printf("spawn_command: %s\n", cmd[0]);
 
 	childpid = fork();
 	if (childpid == -1) {
@@ -155,8 +160,7 @@ static int spawn_command(const char *cmd, uid_t uid){
 	if (childpid == 0) {
 		if (drop_privs(uid) != 0) exit(-1);
 
-		status = system(cmd);
-		status_to_retval(status, status);
+		status = execv(cmd[0], cmd);
 		exit(status);
 	}
 
@@ -342,15 +346,24 @@ static int bad_path(const char *path) {
 	return 0;
 }
 
-static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
-{
+static void free_args(char **args) {
+	char **args_p = args;
+	if (! args)
+		return;
+	while (*args_p != NULL) {
+		free(*args_p);
+		args_p++;
+	}
+	free(args);
+}
+
+static int rsynccmd(const char * src, const char *dst, char ***cmd) {
+	char **args;
 	char *buf = NULL;
-	char *newbuf = NULL;
 	glob_t fglob;
 	fglob.gl_offs = 0;
 	int flags = GLOB_PERIOD;
-	unsigned int i = 0;
-	int rc = -1;
+	unsigned int i = 0, index;
 
 	/* match glob for all files in src dir */
 	if (asprintf(&buf, "%s/*", src) == -1) {
@@ -365,43 +378,35 @@ static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
 
 	free(buf); buf = NULL;
 
-	for ( i=0; i < fglob.gl_pathc; i++) {
-		const char *path = fglob.gl_pathv[i];
-
-		if (bad_path(path)) continue;
-
-		if (!buf) {
-			if (asprintf(&newbuf, "\'%s\'", path) == -1) {
-				fprintf(stderr, _("Out of memory\n"));
-				goto err;
-			}
-		} else {
-			if (asprintf(&newbuf, "%s  \'%s\'", buf, path) == -1) {
-				fprintf(stderr, _("Out of memory\n"));
-				goto err;
-			}
-		}
-
-		free(buf); buf = newbuf;
-		newbuf = NULL;
+	/* rsync  -trlHDq + <glob list> + dst + NULL */
+	*cmd = calloc(2 + fglob.gl_pathc + 2, sizeof(char *));
+	if (! *cmd) {
+		fprintf(stderr, _("Out of memory\n"));
+		return -1;
 	}
 
-	if (buf) {
-		if (asprintf(&newbuf, "/usr/bin/rsync -trlHDq %s '%s'", buf, dst) == -1) {
-			fprintf(stderr, _("Out of memory\n"));
-			goto err;
-		}
-		*cmdbuf=newbuf;
-	}
-	else {
-		*cmdbuf=NULL;
-	}
-	rc = 0;
+	args = *cmd;
+	strdup_or_err(args, 0, "/usr/bin/rsync");
+	strdup_or_err(args, 1, "-trlHDq");
 
+	for ( i=0, index = 2; i < fglob.gl_pathc; i++) {
+		const char *path = fglob.gl_pathv[i];
+		if (bad_path(path)) continue;
+		strdup_or_err(args, index, path);
+		index++;
+	}
+	strdup_or_err(args, index, dst);
+	index++;
+	args[index] = NULL;
+	globfree(&fglob);
+	return 0;
 err:
-	free(buf); buf = NULL;
 	globfree(&fglob);
-	return rc;
+	if (args) {
+		free_args(args);
+		*cmd = NULL;
+	}
+	return -1;
 }
 
 /*
@@ -472,21 +477,38 @@ static bool rm_rf(int targetfd, const char *path) {
 static int cleanup_tmpdir(const char *tmpdir, const char *src,
 	struct passwd *pwd, int copy_content)
 {
-	char *cmdbuf = NULL;
+	char **args;
 	int rc = 0;
 
 	/* rsync files back */
 	if (copy_content) {
-		if (asprintf(&cmdbuf, "/usr/bin/rsync --exclude=.X11-unix -utrlHDq --delete '%s/' '%s/'", tmpdir, src) == -1) {
+		args = calloc(7, sizeof(char *));
+		if (! args) {
 			fprintf(stderr, _("Out of memory\n"));
-			cmdbuf = NULL;
-			rc++;
+			return 1;
+		}
+
+		strdup_or_err(args, 0, "/usr/bin/rsync");
+		strdup_or_err(args, 1, "--exclude=.X11-unix");
+		strdup_or_err(args, 2, "-utrlHDq");
+		strdup_or_err(args, 3, "--delete");
+		if (asprintf(&args[4], "%s/", tmpdir) == -1) {
+			fprintf(stderr, _("Out of memory\n"));
+			free_args(args);
+			return 1;
 		}
-		if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) {
+		if (asprintf(&args[5], "%s/", src) == -1) {
+			fprintf(stderr, _("Out of memory\n"));
+			free_args(args);
+			return 1;
+		}
+		args[6] = NULL;
+
+		if (spawn_command(args, pwd->pw_uid) != 0) {
 			fprintf(stderr, _("Failed to copy files from the runtime temporary directory\n"));
 			rc++;
 		}
-		free(cmdbuf); cmdbuf = NULL;
+		free_args(args);
 	}
 
 	if ((uid_t)setfsuid(0) != 0) {
@@ -506,6 +528,10 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 	}
 
 	return rc;
+err:
+	if (args)
+		free_args(args);
+	return 1;
 }
 
 /**
@@ -518,7 +544,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 	struct stat *out_st, struct passwd *pwd, const char *execcon)
 {
 	char *tmpdir = NULL;
-	char *cmdbuf = NULL;
+	char **cmd = NULL;
 	int fd_t = -1, fd_s = -1;
 	struct stat tmp_st;
 	char *con = NULL;
@@ -605,7 +631,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 	if ((uid_t)setfsuid(pwd->pw_uid) != 0)
 		goto err;
 
-	if (rsynccmd(src, tmpdir, &cmdbuf) < 0) {
+	if (rsynccmd(src, tmpdir, &cmd) < 0) {
 		goto err;
 	}
 
@@ -613,7 +639,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 	if ((uid_t)setfsuid(0) != pwd->pw_uid)
 		goto err;
 
-	if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) {
+	if (spawn_command(cmd, pwd->pw_uid) != 0) {
 		fprintf(stderr, _("Failed to populate runtime temporary directory\n"));
 		cleanup_tmpdir(tmpdir, src, pwd, 0);
 		goto err;
@@ -623,7 +649,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 err:
 	free(tmpdir); tmpdir = NULL;
 good:
-	free(cmdbuf); cmdbuf = NULL;
+	free_args(cmd);
 	freecon(con); con = NULL;
 	if (fd_t >= 0) close(fd_t);
 	if (fd_s >= 0) close(fd_s);
-- 
2.52.0

