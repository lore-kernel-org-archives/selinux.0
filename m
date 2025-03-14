Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA371F4722
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957870; cv=none; b=Jm4K9atyUu27olgxbnTOlHL0aAJfXSBlPWV23pcJb3OLhtnEiyWCBThkgXwDzet+YIdBaQoCEe9whsAb+QNATTszCK4PIetzK5bsbw6Sx1MsFLTW/NmpbgaYhsiKXF0ppoty9Yx+g3h3X6eeskp+mdhpv1KZlhohpRerCZCgZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957870; c=relaxed/simple;
	bh=q7rRAqqlQeW7LG80Ex07bSt1LbfFDJe+LlpSTGvSWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6PBo923plin6I9oACV8k6x7KRfNIOA8+9BUrt4HlRvDZ0FxFi3ZFOgDmdYH08BufUIxWaz0LvuebrSj+l4kjiGrpvHZ+vEEwO86dD4IimriH05OfeRTqgnoDl+xOqswqJ4SuyiRPd6R5Bohb1dq49nnTpPKkji9lUuTOxKi02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=okLBwkcF; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="okLBwkcF"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741957858;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8dqm5HG3yNURV3/qzDFZrPN99picnYmF3QeLKHxGZpQ=;
	b=okLBwkcFtSi+uszLlXephtHErrE8JsGOANCqjGtNeH84lneAjKY36q6Q9zTJzrms0d3E2/
	Qx2HykrE1kcgoWP7ANml+1ebXyF8oE5DXAqJ3U9pXaavfX7u0P6pdDAUs7YZhEfmgivGIr
	WPsK74gF3gnMFGm85vQv5wQzuRFO5eYWVMAVO/gfXfiotADMRXV/YeyHa26zK2IXzXofk+
	lHRJzjFUcILA19nkajw0OuLcgugJzFuXRHzU+5Vxd0mERjpIhohb5F6koSdUUtYFTYWEsU
	snZ3mVc8vcGZDsohsTswRPiDB48oGL/tje1eLIRnAHZs9/3AQ5Zntu6v+xdyhg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/4] libselinux: use local instead of global error buffer
Date: Fri, 14 Mar 2025 14:10:51 +0100
Message-ID: <20250314131054.24450-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use a function local, and thus thread-safe, buffer for error messages
instead of a shared global one.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: check for valid error buffer in compile_regex()
---
 libselinux/src/label_file.c |  4 ++--
 libselinux/src/label_file.h | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 56e20949..85d42ff2 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1662,7 +1662,7 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 		for (uint32_t i = n->regex_specs_num; i > 0; i--) {
 			/* search in reverse order */
 			struct regex_spec *rspec = &n->regex_specs[i - 1];
-			const char *errbuf = NULL;
+			char errbuf[256];
 			int rc;
 
 			if (child_regex_match &&
@@ -1673,7 +1673,7 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 			if (file_kind != LABEL_FILE_KIND_ALL && rspec->file_kind != LABEL_FILE_KIND_ALL && file_kind != rspec->file_kind)
 				continue;
 
-			if (compile_regex(rspec, &errbuf) < 0) {
+			if (compile_regex(rspec, errbuf, sizeof(errbuf)) < 0) {
 				COMPAT_LOG(SELINUX_ERROR, "Failed to compile regular expression '%s':  %s\n",
 					   rspec->regex_str, errbuf);
 				goto fail;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 60ebbb47..470e2385 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -388,16 +388,22 @@ static inline void sort_specs(struct saved_data *data)
 	sort_spec_node(data->root, NULL);
 }
 
-static inline int compile_regex(struct regex_spec *spec, const char **errbuf)
+static inline int compile_regex(struct regex_spec *spec, char *errbuf, size_t errbuf_size)
 {
 	const char *reg_buf;
 	char *anchored_regex, *cp;
 	struct regex_error_data error_data;
-	static char regex_error_format_buffer[256];
 	size_t len;
 	int rc;
 	bool regex_compiled;
 
+	if (!errbuf || errbuf_size == 0) {
+	    errno = EINVAL;
+	    return -1;
+	}
+
+	*errbuf = '\0';
+
 	/* We really want pthread_once() here, but since its
 	 * init_routine does not take a parameter, it's not possible
 	 * to use, so we generate the same effect with atomics and a
@@ -435,9 +441,8 @@ static inline int compile_regex(struct regex_spec *spec, const char **errbuf)
 	len = strlen(reg_buf);
 	cp = anchored_regex = malloc(len + 3);
 	if (!anchored_regex) {
-		if (errbuf)
-			*errbuf = "out of memory";
 		__pthread_mutex_unlock(&spec->regex_lock);
+		snprintf(errbuf, errbuf_size, "out of memory");
 		return -1;
 	}
 
@@ -452,12 +457,7 @@ static inline int compile_regex(struct regex_spec *spec, const char **errbuf)
 	rc = regex_prepare_data(&spec->regex, anchored_regex, &error_data);
 	free(anchored_regex);
 	if (rc < 0) {
-		if (errbuf) {
-			regex_format_error(&error_data,
-					regex_error_format_buffer,
-					sizeof(regex_error_format_buffer));
-			*errbuf = &regex_error_format_buffer[0];
-		}
+		regex_format_error(&error_data, errbuf, errbuf_size);
 		__pthread_mutex_unlock(&spec->regex_lock);
 		errno = EINVAL;
 		return -1;
@@ -624,9 +624,9 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 		data->num_specs++;
 
 		if (rec->validating) {
-			const char *errbuf = NULL;
+			char errbuf[256];
 
-			if (compile_regex(&node->regex_specs[id], &errbuf)) {
+			if (compile_regex(&node->regex_specs[id], errbuf, sizeof(errbuf))) {
 				COMPAT_LOG(SELINUX_ERROR,
 					   "%s:  line %u has invalid regex %s:  %s\n",
 					   path, lineno, regex, errbuf);
-- 
2.47.2

