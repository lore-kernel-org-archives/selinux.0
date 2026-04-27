Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830934FF76
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307107; cv=none; b=AGN7XFJi3GJ+N8POUq50VLCfI1m3SjQJTNJnUyzQosS+8uU8+9lMeP0WL5BujrAFnbwuPzu6thL6JF8gAxm0IFpSdnkLOwYxrwiGd3O7Ix+vpMuEasbaBkbMDZ7lLYBtsuCQeJszZeKV1clifggb+MUO+H2GWhloIZaRC54E8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307107; c=relaxed/simple;
	bh=ld358c0ddPKE/5glNGUkjOgLdNbMZwnLs9Yc1m1DIz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIWaJVrvBdeeG8UOru/kXMXLIqXsbBZxYf0owAXkp3AWExuwE+cE9jafgmFr4JyoJVWnwJMhk7g8pD0C2XophLOyOy2VPiBMbkUbK1ew//4WfcGXfr4p8MNXR9ZtF40KWpeGrCN6n9B8VG4tPygDJUXQBxGMuNiZUxZ/KUdJU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBYC/kwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBYC/kwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777307105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/Rva/rZa/+6NDRmirvEGoOzcvHIA48eYU0ALNSpNy0=;
	b=aBYC/kwpCIK/v3+CGCoXmrfRu01VZehdc82METNX6DIk7qzEcxh4k0z9nMYfxVNC+dW1rg
	AMm93g2rUKWxwJuOW2KIJ8d17Kl2tdtJNTFaPD/YtVi68ciyiV1ERPncEK2LDJSr8QE1AU
	TUv4u6nlI45qa5+mbOVoz1VulEE/F+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-HbhDmL9MNPSKQv0hkhBEZQ-1; Mon,
 27 Apr 2026 12:25:04 -0400
X-MC-Unique: HbhDmL9MNPSKQv0hkhBEZQ-1
X-Mimecast-MFC-AGG-ID: HbhDmL9MNPSKQv0hkhBEZQ_1777307103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 829E31800464
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:25:03 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81E1E1800664;
	Mon, 27 Apr 2026 16:25:02 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/3] =?UTF-8?q?libsemanage:=20Do=20not=20discard=20?= =?UTF-8?q?=E2=80=98const=E2=80=99=20qualifier?=
Date: Mon, 27 Apr 2026 18:24:39 +0200
Message-ID: <20260427162452.132118-2-lautrbach@redhat.com>
In-Reply-To: <20260427162452.132118-1-lautrbach@redhat.com>
References: <20260427162452.132118-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fixes build errors like the bellow with glibc-2.43

    utilities.c: In function ‘semanage_str_replace’:
    utilities.c:248:16: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      248 |         for (p = strstr(src, search); p != NULL; p = strstr(p + slen, search)) {
          |                ^
    utilities.c:265:16: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      265 |         for (p = strstr(src, search); p != NULL; p = strstr(psrc, search)) {
          |                ^
    utilities.c:265:52: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      265 |         for (p = strstr(src, search); p != NULL; p = strstr(psrc, search)) {
          |                                                    ^
    utilities.c: In function ‘semanage_basename’:
    utilities.c:358:19: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      358 |         char *p = strrchr(filename, '/');
      |                   ^~~~~~~

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsemanage/src/direct_api.c | 2 +-
 libsemanage/src/utilities.c  | 8 ++++----
 libsemanage/src/utilities.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 8f909a3bbf55..424360a68354 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1755,7 +1755,7 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 
 	int retval = -1;
 	char *path = NULL;
-	const char *filename;
+	char *filename;
 	const char *lang_ext = NULL;
 	char *module_name = NULL;
 	char *separator;
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 004ffb627d06..90cc4a3ce990 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -234,8 +234,8 @@ char *semanage_str_replace(const char *search, const char *replace,
 			   const char *src, size_t lim)
 {
 	size_t count = 0, slen, rlen, newsize;
-	char *p, *pres, *result;
-	const char *psrc;
+	char *pres, *result;
+	const char *p, *psrc;
 
 	slen = strlen(search);
 	rlen = strlen(replace);
@@ -353,8 +353,8 @@ int write_full(int fd, const void *buf, size_t len)
 #ifdef __GNUC__
 __attribute__((nonnull))
 #endif
-char *semanage_basename(const char *filename)
+const char *semanage_basename(const char *filename)
 {
-	char *p = strrchr(filename, '/');
+	const char *p = strrchr(filename, '/');
 	return p ? p + 1 : (char *)filename;
 }
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index 7481077aaedb..18abc7e628ad 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -167,6 +167,6 @@ int write_full(int fd, const void *buf, size_t len) WARN_UNUSED;
 #ifdef __GNUC__
 __attribute__((nonnull))
 #endif
-char *semanage_basename(const char *filename);
+const char *semanage_basename(const char *filename);
 
 #endif
-- 
2.54.0

