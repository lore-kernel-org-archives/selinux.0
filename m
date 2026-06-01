Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474C361667
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323375; cv=none; b=D83v9+M5PCM7EOK9+D5eEPKiEbB2ZAjrNSXlalfYT0kF8iX5Caubb+mpzn/51lfKaXb+Vx5v5CKnCWDwBvuePPnvCYEZkvE9FEQHU3WEGVRAnVpo+CPuS2m46u8o2M1DlH8I9ERb7wXI2qQo9w1GAQNfwYFkb7zVL7TyacczL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323375; c=relaxed/simple;
	bh=rnRKC3+dE0bBwXIshg1AekjNJzJU0F7rF8ibaXBMjAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOiY0vzbhydgkRLgjiyVGp1y7qxN0KVpoL6uh7O0V4XHqNzG8Ofls6Q48Cr56vbL++slRbHZv7dFKae3Emj+Q19AAlaXAKYppaHk4ZJRGR+xXPI584V0bf5kcFJOUG0PXUjOFzd68Gg4vbU0yTM2hQYcmeANaJQvFC76TOzFZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoLxHdH0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoLxHdH0"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915767ea2d0so8476985a.1
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323373; x=1780928173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69NUsT/03bakmMEpyow0q2rO10MYjK+wVxZvhRK2ax8=;
        b=KoLxHdH0qufJxl2EtIWRb3uyQgUg/DWTOdDW1REVXSfAg66FrQ6ChPu2roAoSX/JFV
         MU8pntJ0Ww3ZWOoJjwUNFdIt/BePYp2o6zhFIvJPBf0M3fnsNe5kQ2booQi1b80qAswt
         GF+HsOLyDpXI5nn3cdBw6td04EAeRLXG2XzvgcJaLqEf7ee+MUwpmV6cNMw3LCcJKpIm
         +ddwa03IEsSa2xIhcdz0kBxWTBlA7QylQMHJKVk0QnrmQix0chs+ROGTNi7W4+5RaeAG
         1DnU2m+PYdQ+5/d/sqoj3E/30sruvxx4sV9NeqLAH/yow6ADtlpPn1dlhG1PzIXj4waW
         9WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323373; x=1780928173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69NUsT/03bakmMEpyow0q2rO10MYjK+wVxZvhRK2ax8=;
        b=YnNbVk78C/NYHnOE26ybTnkfuXRXe/btG9BRJrdJHCOtFj4NDuC+Cixkf123M4RNs8
         NWF1xmQ8VlZmW6YlwPYFOh4wRQNafs1Go3lJBRmWCXh4rIKzH54OHTNozsra3ZA/zfWf
         Mu0h5R11kZSvU4UgE0SREy6lAQ+dOBX653Sc32/rl+h/vmUJmHFKLoIIhV0WRJb90hlZ
         E+7813fbh+U9x6SZ+rG3bWmKYdClFyPFjVEejyGffk9cjOsuctMVPDvTpn0Qjm2uu2GJ
         I1Zgf5Q0uQXJqRFQOXHQ3pI6xaESEPu52JNG3nrmO+E/KD+R11iJdXC4urEymR1GM2Fy
         ULow==
X-Gm-Message-State: AOJu0Ywnd1IZQ3bEgiKHZHmLbuXoYCvT/jwMGFFLBCjf3a0Kp0LewlQ5
	UoBJdysmImG8ueoo3Z5dbvMvcxSFYsG2ZyTEtS+gWew7GOu4WeyRt4u7MkGwBw==
X-Gm-Gg: Acq92OHXq59W6iPgwWQbWezT19OnRe0Kdz39lx16XkpML/Ek7fQFET6PHKRfhhG7Gv2
	ylKjLVriIRd95VXhApNOZtae6Z47k/9jpdeGz7rtWfGrefC23B5Rwkv9iB/pP83Xp876JqUiDnF
	8hZ9ywGvkMKfDLk1Alk9dx1F/GETqCO5xg6mYx1YrqlTOuyYvvB5PNahHpFd3jLTU1K6kPpKdTH
	7Iojs8fL8Ox9X3HRXLetjKFYlN7cXNR+8Sx7ypFAxdR5eqN5XhWfThT9fS6jyje9521hG5+cWm0
	Prmo/v446CqRXelr1Qu3eqsijOaE0p0Km6G9I2ckamNXnaKCj2yP8V/B9zBqKiBu0ZMIL/BJhby
	SXru5jz5UePqjnml8OLpy6BmBuSsu6sGCyYUNXY8j7DkjfzhIqXeDlElsYbJIcY51DHYMZ3vsaG
	cpl5AY/vaepLOrM5Q84WDsjB1Xm0CZqNZRTY4bxixSqakDxSBi7FAQpcrtkaaZJ2MrO/vrrdrEI
	eLDvfuXC8IFTRlFfabAHuJhMDVknPYb2tH5tA==
X-Received: by 2002:a05:620a:a406:10b0:915:5cbd:1d92 with SMTP id af79cd13be357-9155cbd22a4mr574633985a.41.1780323372936;
        Mon, 01 Jun 2026 07:16:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm109607285a.24.2026.06.01.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:16:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/6] libselinux: label_backends_android: preserve errors from process_line
Date: Mon,  1 Jun 2026 10:15:48 -0400
Message-ID: <20260601141552.191733-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
References: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

status is reset to zero at the end of the first pass, so we need to
set it to -1 again on error paths.

Also pass the full buffer length to fgets, which already reads one
less than the size and writes the NUL byte.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_backends_android.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index cf4f5cbf..16abb8d0 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -192,11 +192,13 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		data->nspec = 0;
 		lineno = 0;
 
-		while (fgets(line_buf, sizeof(line_buf) - 1, fp)
+		while (fgets(line_buf, sizeof(line_buf), fp)
 		       && data->nspec < maxnspec) {
 			if (process_line(rec, path, line_buf, pass, ++lineno)
-									  != 0)
+				!= 0) {
+				status = -1;
 				goto finish;
+			}
 		}
 
 		if (pass == 1) {
@@ -213,8 +215,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			}
 
 			if (NULL == (data->spec_arr =
-				     calloc(data->nspec, sizeof(spec_t))))
+					calloc(data->nspec, sizeof(spec_t)))) {
+				status = -1;
 				goto finish;
+			}
 
 			maxnspec = data->nspec;
 
-- 
2.54.0

