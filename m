Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9318C03B
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264394; cv=none; b=MF9iGVR4Kx6vwEqFZ2l1i39g+VOh4aVgltcMt6VV01KMhG/lLEsahpRj5LJcskhNLhEhlwfBf5oEFDcOODy7NywUPhzOIS09Et3dsDJqB5VmWGLhiF7IUPHR8l1fXNDGGG19a26vAP2erkaDy5cpqUvyYaglgnz8Ww7LfebvnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264394; c=relaxed/simple;
	bh=cYUEX58QNg+yNRZRqE9VCAGgCgvTY+luUYsIGYeduGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0VFmHaHtVvtsKt845yL7yjJ5MCzSIMAJemDeZxMHFcbo1Aeu1gLos5Cs++OgRrJ4gtkMYKtesQRgXnmcDufKzuZ/OpLuYIaU6p5npX3o9e+KFmj+LQbWEaE/ThDAxYMC6MayR8sRZ7G3xGVhShsgq0f+SxgH2XZw/nPSLSG52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WzvfowrB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WzvfowrB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729264388;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUm5PDnbIiRiQGyTNL24G1DTQaLNdHtiJAaqtfau2pc=;
	b=WzvfowrBWSDA/PUYcblaaNR4xa+tNCjY+MqkyGUraWmSMLVb3713UrORB67evkRL+vFHbV
	l/Zc8sXgqdvRYXM4ae+6PTIUqMWs7T2h71AzvVH3qQe7YrdaazIaw27205PVRGd6MoqKh3
	EZebj9CTWUhj1ZOGE6/gJ0sxLzkrMBMT5DvzYlsRDDbcH7lstu729xcdLtDCEH3QK6Zoyx
	l2TfqRr0hNgfvRY/taKizBqpb+tqaERTS9QhPYN7jAaPFk8U+tHiSNGj+B+fvPHZXudEXc
	gOIqWE5JkyaJr8xobQ/GAXl6H7YavgzyQ5Xj0z73Xi3A5sAZa6wLDGsumhE1fg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] libsemanage: check for rewind(3) failure
Date: Fri, 18 Oct 2024 17:12:59 +0200
Message-ID: <20241018151300.445618-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241018151300.445618-1-cgoettsche@seltendoof.de>
References: <20241018151300.445618-1-cgoettsche@seltendoof.de>
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

Use fseek(3) instead of rewind(3) to detect failures.

Reported-by: clang-analyzer
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/compressed_file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 5546b830..e230a70b 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -114,7 +114,12 @@ static ssize_t bunzip(semanage_handle_t *sh, FILE *f, void **data)
 
 	/* Check if the file is bzipped */
 	bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
-	rewind(f);
+
+	if (fseek(f, 0L, SEEK_SET) == -1) {
+		ERR(sh, "Failure rewinding file.");
+		goto exit;
+	}
+
 	if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
 		goto exit;
 	}
-- 
2.45.2

