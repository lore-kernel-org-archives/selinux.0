Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0613959F
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684600; cv=none; b=uqPJtvOD2GawYuPek+lzisGTB6I4zoFWiraeQiHkOni8PyGllEExCeBS+418EnCVyW3O0moRzBohWmuCm4l5XmUzDPVwZFuiQaViJVl9AwRnbk9YOTuSkMEgIxQmtnE8OyaywfqeHwjYhQ6zbMhOzSrE88eRQjMYYg/w4P76nTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684600; c=relaxed/simple;
	bh=cKvom9PAbwssC6eKGnRX6gbC18N5Ex6U555kRAm+RhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=E6yH62pBP1HmPSC/TFeS03pW/FbAItj/bM6medLCkHAcSAclX4wYFfZC3ooTkweb5PfEH5Jl1t6z6y/fmiOHitpIvNYxbzsWwtG4TlcI/q86DeFwkDwjq1nn9uKWG2gi5+YgsUCmaLAa0x9s9hFCjE1LklQ/KTJdZnE0BUUDXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFdfF7ft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFdfF7ft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715684598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2qtFTgZ0VmP9wCf3VY3PC9llPmqGSnvOMuGGLQQpDM=;
	b=RFdfF7ftm9olozSiZVTfkiqOdN0QYnifg8mbFbD5bZqgGV/6Bn9ojZpLtFM2/O2vtEBXry
	YTuLShH6osEW7aXlI50fCJ/FX4o3UdJX19Zutq73H9SGjsP7lx3njhYFxxW/dH09fjovsj
	5QgbwsyBwPWf0FDkIUeOxVtGRPg1zSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-cKNY86-lPeW3qLve6yFyow-1; Tue, 14 May 2024 06:57:05 -0400
X-MC-Unique: cKNY86-lPeW3qLve6yFyow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8CA61848630
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14DA740C6EB7;
	Tue, 14 May 2024 10:57:03 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 3/4] seunshare: Add [ -P pipewiresocket ] [ -W waylandsocket ] options
Date: Tue, 14 May 2024 12:56:50 +0200
Message-ID: <20240514105651.225925-3-lautrbach@redhat.com>
In-Reply-To: <20240514105651.225925-1-lautrbach@redhat.com>
References: <20240514105651.225925-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Mount /run/user/UID/<waylandsocket> or /run/user/UID/<pipewiresocket>
inside unshared /run/user/UID directory

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 sandbox/seunshare.c | 120 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 7 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 1d38ea92b9ae..106f625fcba5 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -52,7 +52,8 @@
 
 #define BUF_SIZE 1024
 #define DEFAULT_PATH "/usr/bin:/bin"
-#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -r runuserdir ] [ -Z CONTEXT ] -- executable [args] ")
+#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] \
+[ -r runuserdir ] [ -P pipewiresocket ] [ -W waylandsocket ] [ -Z CONTEXT ] -- executable [args] ")
 
 static int verbose = 0;
 static int child = 0;
@@ -265,6 +266,10 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
 		is_tmp = 1;
 	}
 
+	if (strncmp("/run/user", dst, 9) == 0) {
+		flags = flags | MS_REC;
+	}
+
 	/* mount directory */
 	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
@@ -289,6 +294,31 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
 
 }
 
+/**
+ * Mount directory and check that we mounted the right directory.
+ */
+static int seunshare_mount_file(const char *src, const char *dst)
+{
+	int flags = 0;
+
+	if (verbose)
+		printf(_("Mounting %s on %s\n"), src, dst);
+
+	if (access(dst, F_OK) == -1) {
+		 FILE *fptr;
+         fptr = fopen(dst, "w");
+		 fclose(fptr);
+	}
+	/* mount file */
+	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
+		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+
+}
+
 /*
    If path is empty or ends with  "/." or "/.. return -1 else return 0;
  */
@@ -616,6 +646,8 @@ killall (const char *execcon)
 int main(int argc, char **argv) {
 	int status = -1;
 	const char *execcon = NULL;
+	const char *pipewire_socket = NULL;
+	const char *wayland_display = NULL;
 
 	int clflag;		/* holds codes for command line flags */
 	int kill_all = 0;
@@ -641,6 +673,8 @@ int main(int argc, char **argv) {
 		{"verbose", 1, 0, 'v'},
 		{"context", 1, 0, 'Z'},
 		{"capabilities", 1, 0, 'C'},
+		{"wayland", 1, 0, 'W'},
+		{"pipewire", 1, 0, 'P'},
 		{NULL, 0, 0, 0}
 	};
 
@@ -670,7 +704,7 @@ int main(int argc, char **argv) {
 	}
 
 	while (1) {
-		clflag = getopt_long(argc, argv, "Ccvh:r:t:Z:", long_options, NULL);
+		clflag = getopt_long(argc, argv, "Ccvh:r:t:W:Z:", long_options, NULL);
 		if (clflag == -1)
 			break;
 
@@ -693,6 +727,12 @@ int main(int argc, char **argv) {
 		case 'C':
 			cap_set = CAPNG_SELECT_CAPS;
 			break;
+		case 'P':
+			pipewire_socket = optarg;
+			break;
+		case 'W':
+			wayland_display = optarg;
+			break;
 		case 'Z':
 			execcon = optarg;
 			break;
@@ -767,8 +807,14 @@ int main(int argc, char **argv) {
 		char *display = NULL;
 		char *LANG = NULL;
 		char *RUNTIME_DIR = NULL;
+		char *XDG_SESSION_TYPE = NULL;
 		int rc = -1;
 		char *resolved_path = NULL;
+		char *wayland_path_s = NULL; /* /tmp/.../wayland-0 */
+		char *wayland_path = NULL; /* /run/user/UID/wayland-0 */
+		char *pipewire_path_s = NULL; /* /tmp/.../pipewire-0 */
+		char *pipewire_path = NULL; /* /run/user/UID/pipewire-0 */
+
 
 		if (unshare(CLONE_NEWNS) < 0) {
 			perror(_("Failed to unshare"));
@@ -805,6 +851,42 @@ int main(int argc, char **argv) {
 			}
 		}
 
+		if ((XDG_SESSION_TYPE = getenv("XDG_SESSION_TYPE")) != NULL) {
+			if ((XDG_SESSION_TYPE = strdup(XDG_SESSION_TYPE)) == NULL) {
+				perror(_("Out of memory"));
+				goto childerr;
+			}
+		}
+
+		if (runuserdir_s && (wayland_display || pipewire_socket)) {
+			if (wayland_display) {
+				if (asprintf(&wayland_path_s, "%s/%s", runuserdir_s, wayland_display) == -1) {
+					perror(_("Out of memory"));
+					goto childerr;
+				}
+
+				if (asprintf(&wayland_path, "%s/%s", RUNTIME_DIR, wayland_display) == -1) {
+					perror(_("Out of memory"));
+					goto childerr;
+				}
+
+				if (seunshare_mount_file(wayland_path, wayland_path_s) == -1)
+					goto childerr;
+			}
+
+			if (pipewire_socket) {
+				if (asprintf(&pipewire_path_s, "%s/%s", runuserdir_s, pipewire_socket) == -1) {
+					perror(_("Out of memory"));
+					goto childerr;
+				}
+				if (asprintf(&pipewire_path, "%s/pipewire-0", RUNTIME_DIR) == -1) {
+					perror(_("Out of memory"));
+					goto childerr;
+				}
+				seunshare_mount_file(pipewire_path, pipewire_path_s);
+			}
+		}
+
 		/* mount homedir, runuserdir and tmpdir, in this order */
 		if (runuserdir_s &&	seunshare_mount(runuserdir_s, RUNTIME_DIR,
 			&st_runuserdir_s) != 0) goto childerr;
@@ -816,10 +898,21 @@ int main(int argc, char **argv) {
 		if (drop_privs(uid) != 0) goto childerr;
 
 		/* construct a new environment */
-		if ((display = getenv("DISPLAY")) != NULL) {
-			if ((display = strdup(display)) == NULL) {
-				perror(_("Out of memory"));
-				goto childerr;
+
+		if (XDG_SESSION_TYPE && strcmp(XDG_SESSION_TYPE, "wayland") == 0) {
+			if (wayland_display == NULL && (wayland_display = getenv("WAYLAND_DISPLAY")) != NULL) {
+				if ((wayland_display = strdup(wayland_display)) == NULL) {
+					perror(_("Out of memory"));
+					goto childerr;
+				}
+			}
+		}
+		else {
+			if ((display = getenv("DISPLAY")) != NULL) {
+				if ((display = strdup(display)) == NULL) {
+					perror(_("Out of memory"));
+					goto childerr;
+				}
 			}
 		}
 
@@ -835,8 +928,16 @@ int main(int argc, char **argv) {
 			perror(_("Failed to clear environment"));
 			goto childerr;
 		}
-		if (display)
+		if (display) {
 			rc |= setenv("DISPLAY", display, 1);
+		}
+		if (wayland_display) {
+			rc |= setenv("WAYLAND_DISPLAY", wayland_display, 1);
+		}
+
+		if (XDG_SESSION_TYPE)
+			rc |= setenv("XDG_SESSION_TYPE", XDG_SESSION_TYPE, 1);
+
 		if (LANG)
 			rc |= setenv("LANG", LANG, 1);
 		if (RUNTIME_DIR)
@@ -874,9 +975,14 @@ int main(int argc, char **argv) {
 		fprintf(stderr, _("Failed to execute command %s: %s\n"), argv[optind], strerror(errno));
 childerr:
 		free(resolved_path);
+		free(wayland_path);
+		free(wayland_path_s);
+		free(pipewire_path);
+		free(pipewire_path_s);
 		free(display);
 		free(LANG);
 		free(RUNTIME_DIR);
+		free(XDG_SESSION_TYPE);
 		exit(-1);
 	}
 
-- 
2.45.0

