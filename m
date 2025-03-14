Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99F2E3389
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958278; cv=none; b=hkFiSp5MvHYzMtZNvbWgNv7cGL0CX4+kWHSRRuOFskmAfKdkrJ0olBStbV4kDM8cd1ess0Y+4qG+GjCC6HbKhnOFjKjQTT7Swp8vaJQws65NMShHQ1HxK0KormAUGpX4OpAD+MfD6c0O3o/WNkCq+B2u4nL1G+cNpFt2K21y9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958278; c=relaxed/simple;
	bh=q7rRAqqlQeW7LG80Ex07bSt1LbfFDJe+LlpSTGvSWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YgVuVCsRhsmv0v0LFTwzvbhiDGZmU7p2Y5UM6WCr1agL1nx0jezFGgqUr7u4aU48OHhjANxjGK6e6uQ9oy5p63CkrbbyAayrK+1rWqYYso1MwG4V3sKcd7QfjLVKx6mx/L8ZeNdmXR4zRe2VWn5ck5/lAmRdpuUEGKn55sqFYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dk89Pxer; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dk89Pxer"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741958274;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8dqm5HG3yNURV3/qzDFZrPN99picnYmF3QeLKHxGZpQ=;
	b=dk89PxerS0/jR3LL779OO5O4CH1E1TmNFMY3ygbWJDNZIeoeuHHp6u+dJiSGtQGEsVV1bu
	vtBFlAgXanbmMKdWjAOvDFTopSwrXEYhzEcbuAvTcPPLXMYAlhU8IbMfjOsegacowkujus
	kbWUjiKew271Vw/TOyfzCy9B5ASirNeflFLwY15WN8b806wk5s/OypUAwABjUmJvTp5vPe
	h+/CdTFH+KvWxtHQ2zvrZAWl8EjOsDeT7yoml3sLne6YtUrdMQP9oG/frlOEahddKalEc0
	8+RcQfb64f4DDju5OyHrlEMzQSaxbqjNrI3kF9escvGYx3RPeEG2QHKWroyywQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 2/4] libselinux: use local instead of global error buffer
Date: Fri, 14 Mar 2025 14:17:48 +0100
Message-ID: <20250314131751.28289-1-cgoettsche@seltendoof.de>
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

