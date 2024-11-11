Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD81A00C9
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334638; cv=none; b=GUnWilnZIoLhGhpmJ+AaJ9kfF1irXAECCPa8ROkNEYwII1+iKXytwD+OxfiK5ACz4meqbeUe/6uxKRMxrL61zEW/Z1aQ41rxwxR+woND+ZorncDpTExU17ujLurolj+wqO7iz0cLw2ktS3X51jG69X8c388YXBk86jpW97rLsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334638; c=relaxed/simple;
	bh=ZwjZcZ6E+ATQO/DAb+NcMe/qLoWl/W1w/PDC6LO3Adg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rd/YnMEYlHSXwOLNWMoRTppk9KcrBhpYDathSqEf9+5oKJ8I2oRHkUZpnguoo7yksOCUujMNxysHDz/26L/f5dLiFoJkKTbsbGUHex+VP9tsHWNhowytIeaQDG+a9+7BGq6zp2Pc1eAMEO1o7I00U/jFiJaIYHbLvYgNFUFLxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UN3Sdv4l; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UN3Sdv4l"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334633;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrVtepWLMBQmYKPCZLUdmN/YI/TKd59y0vHcs8GScLc=;
	b=UN3Sdv4lV+cEuuohh/rCkWHcGsCTkjjiGLj3jtcvNhYshT0RqFgEMOtoHnVuychf9e/yfG
	VIQTSMqnSlH3wvq5OTbhoKg6KNseWtpeOoWaqr2pbSKHXDcl6qR63js2hTZYrGooW2cvaP
	KDMwq0Oj8+2Ai4/yJjK79qyeR8cnevSgqEkgsgrnMDjOOoziH/+uaIZErgfZJqFCa9p1rx
	pYPDOi02EZHjWTBzvu5wr88n1JRoUbnQeaquluSWJ7XKvUsXJxnUhXc37jYUR7ZcpbqqQu
	Ch4WmD3SYv+S0UskCnO0EJ4SmvYTqF196MTefjVRjy8Tjq9kkJfhNZ7tHND7JA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 04/47] libsemanage: drop dead assignments
Date: Mon, 11 Nov 2024 15:16:23 +0100
Message-ID: <20241111141706.38039-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/compressed_file.c | 2 +-
 libsemanage/src/direct_api.c      | 4 ++--
 libsemanage/src/semanage_store.c  | 4 +---
 libsemanage/src/users_base_file.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index e230a70b..067f54d7 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -45,7 +45,7 @@ static int bzip(semanage_handle_t *sh, const char *filename, void *data,
 	size_t  size = 1<<16;
 	int     bzerror;
 	size_t  total = 0;
-	size_t len = 0;
+	size_t len;
 	FILE *f;
 
 	if ((f = fopen(filename, "wb")) == NULL) {
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 84c31399..104dbd40 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -582,7 +582,7 @@ cleanup:
 static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int fd, char **out_data_read, size_t *out_read_len)
 {
 	size_t max_len = initial_len;
-	ssize_t read_len = 0;
+	ssize_t read_len;
 	size_t data_read_len = 0;
 	char *data_read = NULL;
 
@@ -1001,7 +1001,7 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 	/* to be incremented when checksum input data format changes */
 	static const size_t CHECKSUM_EPOCH = 2;
 
-	int i, status = 0;
+	int i, status;
 	char cil_path[PATH_MAX];
 	struct stat sb;
 	Sha256Context context;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index df994297..82c5a684 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2081,7 +2081,7 @@ int semanage_direct_get_serial(semanage_handle_t * sh)
 
 int semanage_load_files(semanage_handle_t * sh, cil_db_t *cildb, char **filenames, int numfiles)
 {
-	int i, retval = 0;
+	int i, retval;
 	char *filename;
 	struct file_contents contents = {};
 
@@ -2557,8 +2557,6 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	semanage_file_context_bucket_t *main;
 	semanage_file_context_bucket_t *bcurrent;
 
-	i = 0;
-
 	if (sh == NULL) {
 		return -1;
 	}
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index a0f8cd7e..4e4d8d9b 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -66,7 +66,7 @@ static int user_base_parse(semanage_handle_t * handle,
 			   parse_info_t * info, semanage_user_base_t * user)
 {
 
-	int islist = 0;
+	int islist;
 	char *str = NULL;
 	char *start;
 	char *name_str = NULL;
-- 
2.45.2

