Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0011E909C
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831993; cv=none; b=H9wMe3ghtaLHWWhHQXkykgDYr5L+rALWyIpYG07CBCGJINeH+7/b/CyKB1g1knx+fquZXlLeIoYXT7JHW9EnzUKRvFJLWOjXdiByjBLMZfu6CF9NaDIxJ3bfFkEOiRbU23pkPtHjl8NYTv4JybX0QkYBxK8RVVFafJjSGycgfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831993; c=relaxed/simple;
	bh=RB+Ril/MNI5r6+4gLBAlAkobDSUsYYh2c41bOhFAO24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGCzAo2IjCz5m1TIlr9FZi6ihDIINF6l3Vb2IC5hG/zzNdDxsnwNzpC79OPXcu3XpqmusopUzFhPuuButxsPqb9/06elaeUxBh6QtLFzG3RcGpe4aIwfQvhlbKPWJO5OMTKGzBxfTZhlwzsrozTsvH/x4l9jZIHlS86X/0JRNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=g1NUXRFN; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="g1NUXRFN"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831988;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xuOjyaj4sjYGzNrT4Z/cMfwZZ1InKpNQMGg6FKloJ2c=;
	b=g1NUXRFNqPM4KR1/AQ7elFN0TjIcI9ijRP4gvyoa/kjctym4G475rggbac+zDKraCvC0of
	2iWUh4I9KfuM29wibKf7LedaQNsxYiMXNRSUuX4d0tTswdOTAazqGCqOv6/CM+C/Zfhx5V
	lUc+24UuK4IVlMquoDIbt2A9if675XG8qnIYIakpku49YLpJsYdGf4A0RAJJwIygjuhjZ5
	vwtGrf60NJuIfu6XvRek57zNYkW+A+7VpIySObJC73AjCGSiceQ3sgBoR1sOrPVmxeco8J
	p1K8OLQ5wKYB+Y0yzmIj4r6U3PYEGmAEzVIVYdQo5MYo6jEv4sGlsHT/F6Efkw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libselinux: make use of calloc(3)
Date: Tue,  5 Nov 2024 19:39:35 +0100
Message-ID: <20241105183936.252530-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use calloc(3) instead of calling malloc(3) plus a call to memset(3) or
manual zero'ing.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/fgetfilecon.c         |  3 +--
 libselinux/src/get_context_list.c    |  3 +--
 libselinux/src/get_initial_context.c |  3 +--
 libselinux/src/getfilecon.c          |  3 +--
 libselinux/src/getpeercon.c          |  3 +--
 libselinux/src/hashtab.c             | 23 +++++++++++------------
 libselinux/src/label_media.c         |  6 ++----
 libselinux/src/label_x.c             |  6 ++----
 libselinux/src/lgetfilecon.c         |  3 +--
 libselinux/src/matchpathcon.c        |  3 +--
 libselinux/src/procattr.c            |  3 +--
 libselinux/src/setrans_client.c      |  5 ++---
 12 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index d7051171..782861ed 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -39,10 +39,9 @@ int fgetfilecon_raw(int fd, char ** context)
 	ssize_t ret;
 
 	size = INITCONTEXTLEN + 1;
-	buf = malloc(size);
+	buf = calloc(1, size);
 	if (!buf)
 		return -1;
-	memset(buf, 0, size);
 
 	ret = fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1);
 	if (ret < 0 && errno == ERANGE) {
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 222b54c1..8d5ee6fb 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -481,12 +481,11 @@ int get_ordered_context_list(const char *user,
 	   the "failsafe" context to at least permit root login
 	   for emergency recovery if possible. */
 	freeconary(reachable);
-	reachable = malloc(2 * sizeof(char *));
+	reachable = calloc(2, sizeof(char *));
 	if (!reachable) {
 		rc = -1;
 		goto out;
 	}
-	reachable[0] = reachable[1] = 0;
 	rc = get_failsafe_context(user, &reachable[0]);
 	if (rc < 0) {
 		freeconary(reachable);
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index 0f25ba3f..fb774c82 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -39,12 +39,11 @@ int security_get_initial_context_raw(const char * name, char ** con)
 		return -1;
 
 	size = selinux_page_size;
-	buf = malloc(size);
+	buf = calloc(1, size);
 	if (!buf) {
 		ret = -1;
 		goto out;
 	}
-	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
 		goto out2;
diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
index 4bee3137..31c9f0de 100644
--- a/libselinux/src/getfilecon.c
+++ b/libselinux/src/getfilecon.c
@@ -14,10 +14,9 @@ int getfilecon_raw(const char *path, char ** context)
 	ssize_t ret;
 
 	size = INITCONTEXTLEN + 1;
-	buf = malloc(size);
+	buf = calloc(1, size);
 	if (!buf)
 		return -1;
-	memset(buf, 0, size);
 
 	ret = getxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
 	if (ret < 0 && errno == ERANGE) {
diff --git a/libselinux/src/getpeercon.c b/libselinux/src/getpeercon.c
index a9dca73e..c7abd886 100644
--- a/libselinux/src/getpeercon.c
+++ b/libselinux/src/getpeercon.c
@@ -18,10 +18,9 @@ int getpeercon_raw(int fd, char ** context)
 	ssize_t ret;
 
 	size = INITCONTEXTLEN + 1;
-	buf = malloc(size);
+	buf = calloc(1, size);
 	if (!buf)
 		return -1;
-	memset(buf, 0, size);
 
 	ret = getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &size);
 	if (ret < 0 && errno == ERANGE) {
diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
index 0c6641ed..409cf5a4 100644
--- a/libselinux/src/hashtab.c
+++ b/libselinux/src/hashtab.c
@@ -20,24 +20,22 @@ hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 {
 
 	hashtab_t p;
-	unsigned int i;
 
 	p = (hashtab_t) malloc(sizeof(hashtab_val_t));
 	if (p == NULL)
 		return p;
 
-	memset(p, 0, sizeof(hashtab_val_t));
-	p->size = size;
-	p->nel = 0;
-	p->hash_value = hash_value;
-	p->keycmp = keycmp;
-	p->htable = (hashtab_ptr_t *) malloc(sizeof(hashtab_ptr_t) * size);
+	*p = (hashtab_val_t) {
+		.size = size,
+		.nel = 0,
+		.hash_value = hash_value,
+		.keycmp = keycmp,
+		.htable = calloc(size, sizeof(hashtab_ptr_t))
+	};
 	if (p->htable == NULL) {
 		free(p);
 		return NULL;
 	}
-	for (i = 0; i < size; i++)
-		p->htable[i] = (hashtab_ptr_t) NULL;
 
 	return p;
 }
@@ -64,9 +62,10 @@ int selinux_hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum
 	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
 	if (newnode == NULL)
 		return HASHTAB_OVERFLOW;
-	memset(newnode, 0, sizeof(struct hashtab_node));
-	newnode->key = key;
-	newnode->datum = datum;
+	*newnode = (hashtab_node_t) {
+		.key = key,
+		.datum = datum
+	};
 	if (prev) {
 		newnode->next = prev->next;
 		prev->next = newnode;
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index d535ef86..b541faf4 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -134,10 +134,9 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				status = 0;
 				goto finish;
 			}
-			data->spec_arr = malloc(sizeof(spec_t)*data->nspec);
+			data->spec_arr = calloc(data->nspec, sizeof(spec_t));
 			if (data->spec_arr == NULL)
 				goto finish;
-			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
 			maxnspec = data->nspec;
 
 			status = fseek(fp, 0L, SEEK_SET);
@@ -229,10 +228,9 @@ int selabel_media_init(struct selabel_handle *rec,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &close;
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index c0d1d475..6bdba9cd 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -161,10 +161,9 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				status = 0;
 				goto finish;
 			}
-			data->spec_arr = malloc(sizeof(spec_t)*data->nspec);
+			data->spec_arr = calloc(data->nspec, sizeof(spec_t));
 			if (data->spec_arr == NULL)
 				goto finish;
-			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
 			maxnspec = data->nspec;
 
 			status = fseek(fp, 0L, SEEK_SET);
@@ -254,10 +253,9 @@ int selabel_x_init(struct selabel_handle *rec, const struct selinux_opt *opts,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &close;
diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.c
index d1fb821b..f0a3aa1a 100644
--- a/libselinux/src/lgetfilecon.c
+++ b/libselinux/src/lgetfilecon.c
@@ -14,10 +14,9 @@ int lgetfilecon_raw(const char *path, char ** context)
 	ssize_t ret;
 
 	size = INITCONTEXTLEN + 1;
-	buf = malloc(size);
+	buf = calloc(1, size);
 	if (!buf)
 		return -1;
-	memset(buf, 0, size);
 
 	ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
 	if (ret < 0 && errno == ERANGE) {
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 967520e4..dbc11ee1 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -202,10 +202,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 	struct stat sb;
 
 	if (!fl_head) {
-		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
+		fl_head = calloc(HASH_BUCKETS, sizeof(file_spec_t));
 		if (!fl_head)
 			goto oom;
-		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
 	}
 
 	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index b7a93a2b..ddcc7f8d 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -139,12 +139,11 @@ static int getprocattrcon_raw(char **context, pid_t pid, const char *attr,
 		return -1;
 
 	size = selinux_page_size;
-	buf = malloc(size);
+	buf = calloc(1, size);
 	if (!buf) {
 		ret = -1;
 		goto out;
 	}
-	memset(buf, 0, size);
 
 	do {
 		ret = read(fd, buf, size - 1);
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index d7dbc0ca..45cbe5c1 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -173,11 +173,10 @@ receive_response(int fd, uint32_t function, char **outdata, int32_t * ret_val)
 		return -1;
 	}
 
-	data = malloc(data_size);
+	/* coveriety doesn't realize that data will be initialized in readv */
+	data = calloc(1, data_size);
 	if (!data)
 		return -1;
-	/* coveriety doesn't realize that data will be initialized in readv */
-	memset(data, 0, data_size);
 
 	resp_data.iov_base = data;
 	resp_data.iov_len = data_size;
-- 
2.45.2

