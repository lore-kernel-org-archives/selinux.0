Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7283E0C7E
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943824; cv=none; b=F78hD6lV0RD2MaQc0AWRJa4j88ZCuJYTVOcQMpLQOzBWV4ufzr1MxTQsO/DVKOkJHSFRAJ9ECl0XOejXMt1FyD9gZfMb2aTiqEUEGgu5fGpaDHavc95O1Ju4vcXCUXxIEU7bbioEqFz/tK3HFlIWztoV6iySs3IdHYlY9kOzYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943824; c=relaxed/simple;
	bh=W75fO9HA1XMblnqwKSA94p1hTdFi5UCsUzapOrI75Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXYmvmL1UYv+/T8z+nh1XhI32YPkBYZsfOWMxHsQkF3DMX2YyXyasSnZ8u477osCjNC+VzsUU4uLdK2fzDDRs0/kmdmhtZfYsNaKBCQvfIvapbKMpOccSbaEg3qCiaQ/LJQcXKQuiqm7hpM7lw0Uw3nVHPnf2GdxeowOm+kbNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ2PcT/m; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ2PcT/m"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso47810986d6.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780943822; x=1781548622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBRLsLBE6a6XabUa61Z8k+tqKZYrEtim4dR/35Z+3H4=;
        b=VJ2PcT/mn/0VFfqXpgzGNhndRO5Xdo60vvD918TyRdkd8qf3y6qEMq2KhVjU285wst
         8snuJBq0dFFQUGsfaqJy8MbXhDQC9VVRzyOdQNKGqiaDc444EdmIykmYz5GPbDiKaCQ7
         0DGaLFrp3SifOGOgotk8nJLfqHGaouLsIhtkdg306PABuQucFUDD46/Y0UUZpC5xTukT
         DcCC3t+5zpANezGhGBjR2vPpMcJ+AqhaFTfkBt9bbONVGExignt9pfbMAAENy0gQeUy0
         YoSTz+7KmWUgLa9lmqTy/GFmjj27ZspNCHUFSWoyRvE9VNQUGnyFH+QuvSLfbYVgpMdr
         UffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943822; x=1781548622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBRLsLBE6a6XabUa61Z8k+tqKZYrEtim4dR/35Z+3H4=;
        b=oQ9abk8lSamQyHt5IolY/w0Qxvj+ARk43PNX5iNq+7qUFDFB6p/sEk0jBfM1kZzFFU
         b6CDymhDeamsWVdZmclDHWHThhJtUPYQOjPcRzdmdrACAxmnLWpfY4amlGoqWipCW4oq
         awr3xx3Mv34KMACsamYVKgD4/LrtXyXNgovFc1pS19eT2wQXoBme3TgsaFn+9DlIABou
         ngDGMretq8w8bOUoY1eXGKZ7CoXQ9LHtVVleEArtyKm4/WzDbgl7V1ZqwBf6RuFyqBsT
         9jItkwKRCGNFW3WmY/pBZfu0x9a/qvNoBellOiENo7PSsWosOE00Q8WXuuJSIjxu1B32
         PbrQ==
X-Gm-Message-State: AOJu0YxeM53ZL8Lq/Qv599thHrwpMlqdndAISlf5WXhFT2jGjgmRzaQp
	nh3TQNi/O9Dbyn8Q4y2vW4L6hkekFLxLh2r82oREzgqF9TbGcjBENvolDcsgSg==
X-Gm-Gg: Acq92OGE4AAeaoMmO7/J4/8Xkd7UgUxnBt6IdMgXviRzFm81qbDEa3UlIl/YgH8rZrc
	iRrf9Durj2bcgARhQ/X96RgqFNxknS/aFQoEzZq8+i4ROi9xxqnblKanRUSkEjBALDuTkSIzIsh
	QjjKe68oUC48a6vGS5mgvUjEAdb1rVXe+x8hPQDIwCS1hXwvh+oAJBGtUtlyaWAlFiKXyZ6liNP
	3SBvwKE1vTJeRj63CpYXyqbJRVgSNa/csbK02LSAh9Jip+oJilJ5xYyU446Z8btfLpUh88bt+Zl
	Puiy4HV+Hnao+A5TbZTrNiY9JBn36+6bAaWjNswLa39gTgRj7jDCDTpMbFvAn31Cbu7bAGjMS1s
	nnhP2yLpDfGOojjJBZDAPyd4QWaeKxNDWb6O7VedQtmbsmYTn34ZIUyMN0FVShrOuJBSSTnXPhQ
	2sM7oARGyjESCePpauQi539j4Zw6A7nHJ4l41bPkHq52ZGjSMJStIeh+mXn0vICHlG9wx2qZ8UP
	dIbNIY5S1ZygDHiRNZWYlqscUg6DnToWScZn/nn9xmBRJJH
X-Received: by 2002:a05:6214:80d3:10b0:89c:e4c3:dc1a with SMTP id 6a1803df08f44-8cee5fa941emr202373506d6.1.1780943821887;
        Mon, 08 Jun 2026 11:37:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb94b5sm177332506d6.15.2026.06.08.11.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:37:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libselinux: digest_gen_hash(): reduce the chunk size for Sha1Update() calls
Date: Mon,  8 Jun 2026 14:36:19 -0400
Message-ID: <20260608183618.318484-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sha1Update() implementation in libselinux takes the provided
bufferSize and shifts it left by 3 bits to convert the byte count to a
bit count. To avoid having this overflow, cap the chunk size used for
Sha1Update() calls to (UINT32_MAX >> 3).

Fixes: e17619792fa1 ("libselinux: correctly hash specfiles larger than 4G")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 updates the comment to say chunkSize instead of UINT32_MAX.

 libselinux/src/label_support.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 9fa7f0fa..cc5c279e 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -134,6 +134,7 @@ void digest_gen_hash(struct selabel_digest *digest)
 	Sha1Context context;
 	size_t remaining_size;
 	const unsigned char *ptr;
+	const uint32_t chunkSize = UINT32_MAX >> 3;
 
 	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
@@ -141,13 +142,13 @@ void digest_gen_hash(struct selabel_digest *digest)
 
 	Sha1Initialise(&context);
 
-	/* Process in blocks of UINT32_MAX bytes */
+	/* Process in blocks of chunkSize bytes */
 	remaining_size = digest->hashbuf_size;
 	ptr = digest->hashbuf;
-	while (remaining_size > UINT32_MAX) {
-		Sha1Update(&context, ptr, UINT32_MAX);
-		remaining_size -= UINT32_MAX;
-		ptr += UINT32_MAX;
+	while (remaining_size > chunkSize) {
+		Sha1Update(&context, ptr, chunkSize);
+		remaining_size -= chunkSize;
+		ptr += chunkSize;
 	}
 	Sha1Update(&context, ptr, remaining_size);
 
-- 
2.54.0

