Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5619CC29
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=q2A/oQZI1nNlagSBNuwDIO37QvYD4Bc3IrnJ3SlAUxKAohShqW81uJnCWfP4RkAIKq+eKAP5xPidH5CMky/H0mnbMtvOFp8RkiwWpNKmjgKhQFqF8cskqvdudq1bkI8okfrkjGFOxYycdDFHGdKaiwrJHUd5fO6c8t8faBaKFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=fqZiJyAWqPM3AMSaj2cwuHsg5vUofSU8XyBerpvhpAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSQb62mLWXwBdV70FreNUxzKHt9QjvhQIeGFfNSbAJDlpi6nzXabaUZdqSSp/p0sQK/gZh89sYcvBORBR6GMXKgfnYOsa23POdWlhes5bUdbFXmzEQJ/vNlayNn3F3TYznT4D8/ey0NR2RlXHKGORxohgCDhLPPo3iSmVlh6kME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=drJXXdmm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="drJXXdmm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334639;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VdB24ENeIT5CWWSeTC2Eg/BlcS/cKwWvX3S4SRQcjs=;
	b=drJXXdmmuBw7rb1sk8g6168QggGzulXHHnW3d+DGMA6GGRzP5Y6TOsZ1oOn0xHX3dJS139
	B7vYQvsDK1xmt+2+sciCOgQ4vTZhFGOMHhVBhAhw1dIH894psbEEyg4fke5xEP88N32EQt
	jOBDkJPcguFFmkRhdcFrQy7ZpwXawadA/4ofufELR5SKfykxh+AbZDpvKbdwsFRNwIOEUu
	NwUVE9uK2f0PC/8UGaLiPhwsq1ncimk5W4dSJAIikl3BSzZoEh2Hd8kp708c6jonb4et5j
	F2zzOJjXWRzatv3R8NBtbRQ/MM2/MDgfvJjTmvdjOp4os9xjZm+BjlMUpVWOaQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 33/47] libsemanage: use size_t for hash input sizes
Date: Mon, 11 Nov 2024 15:16:52 +0100
Message-ID: <20241111141706.38039-33-cgoettsche@seltendoof.de>
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

It's unlikely any input will every be bigger than 4G, but avoid any
potential truncation regardless.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/modules.c | 5 +----
 libsemanage/src/sha256.c  | 4 ++--
 libsemanage/src/sha256.h  | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index e6a47362..e569b98d 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -996,7 +996,6 @@ int semanage_module_compute_checksum(semanage_handle_t *sh,
 				     size_t *checksum_len)
 {
 	semanage_module_info_t *extract_info = NULL;
-	Sha256Context context;
 	SHA256_HASH sha256_hash;
 	char *checksum_str;
 	void *data;
@@ -1018,9 +1017,7 @@ int semanage_module_compute_checksum(semanage_handle_t *sh,
 	semanage_module_info_destroy(sh, extract_info);
 	free(extract_info);
 
-	Sha256Initialise(&context);
-	Sha256Update(&context, data, data_len);
-	Sha256Finalise(&context, &sha256_hash);
+	Sha256Calculate(data, data_len, &sha256_hash);
 
 	munmap(data, data_len);
 
diff --git a/libsemanage/src/sha256.c b/libsemanage/src/sha256.c
index 79664138..9daac285 100644
--- a/libsemanage/src/sha256.c
+++ b/libsemanage/src/sha256.c
@@ -180,7 +180,7 @@ void
     (
         Sha256Context*      Context,        // [in out]
         void const*         Buffer,         // [in]
-        uint32_t            BufferSize      // [in]
+        size_t              BufferSize      // [in]
     )
 {
     uint32_t n;
@@ -282,7 +282,7 @@ void
     Sha256Calculate
     (
         void  const*        Buffer,         // [in]
-        uint32_t            BufferSize,     // [in]
+        size_t              BufferSize,     // [in]
         SHA256_HASH*        Digest          // [in]
     )
 {
diff --git a/libsemanage/src/sha256.h b/libsemanage/src/sha256.h
index 406ed869..fbabd1f8 100644
--- a/libsemanage/src/sha256.h
+++ b/libsemanage/src/sha256.h
@@ -58,7 +58,7 @@ void
     (
         Sha256Context*      Context,        // [in out]
         void const*         Buffer,         // [in]
-        uint32_t            BufferSize      // [in]
+        size_t              BufferSize      // [in]
     );
 
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -84,6 +84,6 @@ void
     Sha256Calculate
     (
         void  const*        Buffer,         // [in]
-        uint32_t            BufferSize,     // [in]
+        size_t              BufferSize,     // [in]
         SHA256_HASH*        Digest          // [in]
     );
-- 
2.45.2

