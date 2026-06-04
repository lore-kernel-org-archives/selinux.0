Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507532ED21
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595601; cv=none; b=J1KHGffZEpFeQGWOOeHWujZJzWN/qSIj2Wqn7LFfKTUeUmYxiCYwDIA8B1g3oKRNzt0vCAM3klBLD7Xn6aMKXE2rqi6coTtdiHISOxiUxOfnTKlev+MqLVyi5OKsgCW++BtITOTbXARnefbLrzxR7ftQqBGK6L9+nAR8JKzDM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595601; c=relaxed/simple;
	bh=NV9mPDgqrIz/p8OLX+4QRwfJfX2ZhMzBBR1gyOot3fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP76gyt1W9/D9whYl6HNXxvL/VRERV3+8t1QvILlVYOBW1cnU58zqk5GgjtSh9QQT0Y3xwePFfmt3gGBn6fAF5IwMwcEZYB7W4IFuIY0zsZoDF2Z08pBI1Zj/d+pngj6I8uQePcK2Tro67jhf7cJG8jxcCQAYctphZi1ofaAcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR8M3fXM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR8M3fXM"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158c621ebbso118947185a.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780595599; x=1781200399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv5neVqk/sCq1d4/e720UMqYh9U4aTjcPcRWOAbycUw=;
        b=KR8M3fXM19KHL+xKJoB3RSje1JZanJbdHtZPL3R1eGUrLBqC1SI6hWZl3Wq7z02N+s
         my2/ZrBt91AWb2Q7ZiwDvnqym2vMZedaG71S6jvYC6kcb3Aj5hCKlMahdomWWZGVRcL/
         bYfrSto21M8B7W8iK7KZXRiY6vvTvIt+nUip91PXxh+IYn8SoaGwGDcA0omFfdXMr8Sf
         LJsOGegvUya+j6QZyy7RBXKzcicUVCObsQuwmMkURSG08i2Vph8SElN+rOl4HnrjrlHW
         Dog2klgqLfrbMgNOyR3CDN+NSvR5mvMRSfVIVtckqsvlrqMNGppuGgoG+C9cpnjKIdLu
         SjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595599; x=1781200399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vv5neVqk/sCq1d4/e720UMqYh9U4aTjcPcRWOAbycUw=;
        b=fED/meEU2A17vejTIPKchKP/U0X582JAQ1Nfg3CFI6m5wDZj0GpsGzcI/ioKKCjH6K
         6DSY3E+FZv5ov4fW2UpwxsyS3mfNY5BlUCGcUy18HgVbNzKUcItrIprUQcK1d62TpeHV
         9+aF/Am+7fyP9IQUtnt8yWh11r+dyI2iU7wkI/9soJMZ1cYZ1eonnp8F/yd6wwpSiQ41
         b/FY3gIPsPAhgMsmQMP4IGFaMuuA9Ko17gM/azX6DHJoVIxyw3SkXoaV/X+V+f5XZ+36
         33mJXex0Gi9LjZLxGB103FJenoILPtcmKYrr3VIo5my0tRGBsYEentP/nMIhHvhVe9Uv
         2VkQ==
X-Gm-Message-State: AOJu0YzCcfmk6IXHZjEGDGGC6fzYB7sHNiH3LyUxwsMemmuT2uKM3Bfz
	B8IW7w1sbtZVCS0tZeD3SURoWx8HXO/m4VoQNOz01VXInFUeJMH4DAne9DjZ8w==
X-Gm-Gg: Acq92OFXPZ2GHKu8Zvmzw9HPU8VR+ClrVvc73p60hG+U1OBqg+8ZKOg1C6DJQw5IKis
	jj5u+agtTIPsYFLxhp0C41bZAQYR1vgoYlMRtW7uJ1JiQESEkB7qylDMO/FdGonOczK7mPzplvv
	VnavSPM+hOBzuQ0xOwwRD+Pz8Lltx3b6dOVTMWs5xD15EzLVuR9EgudXbeLJAohGeXiuD6V1tWK
	tSq/lAGBkawxp0StndJ540mXXneC78Xro+Oq3vr4Vg8xHP9OWkLLX9JXY4Ft5bkNSCYzXfJuJbB
	uYoZMli62+GBWwMRQPrs3R6Ol/44L23DdnAyw/cjAX4k/gv67E0/vcciBbtgb577SICzRvSnbzP
	GDYh5e2n2+bpTXtde+IzfuK0gpaSeDhx5zachI8l/Cnh6e52lsRA29UvHAK86irzr/43Q6ioH62
	kIIU3676iSNlsRiFbhzjXaOkLwo02NT0Sxdex9e0IpRQux8Oa63q52gT+4ogCfG1VoqQZUJ53MF
	dNKAn9c2ii9xAj5WyKuXd0qZuFEi3BBOp2TvQ==
X-Received: by 2002:a05:620a:1a1e:b0:915:80e8:67d1 with SMTP id af79cd13be357-915a9df5a98mr23683085a.56.1780595599320;
        Thu, 04 Jun 2026 10:53:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm646259985a.43.2026.06.04.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:53:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] restorecond: fix glob() error checking
Date: Thu,  4 Jun 2026 13:52:58 -0400
Message-ID: <20260604175258.264439-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604175258.264439-1-stephen.smalley.work@gmail.com>
References: <20260604175258.264439-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glob(3) returns 0 on success, > 0 on various error conditions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index b197bdc2..bfaf4f29 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -193,7 +193,7 @@ void watch_list_add(int fd, const char *path)
 	globbuf.gl_lstat = nofollow_lstat;
 	globbuf.gl_stat = nofollow_lstat; /* never follow symlinks */
 	if (glob(path, GLOB_TILDE | GLOB_PERIOD | GLOB_ALTDIRFUNC, NULL,
-		 &globbuf) >= 0) {
+		 &globbuf) == 0) {
 		for (i = 0; i < globbuf.gl_pathc; i++) {
 			const char *p = globbuf.gl_pathv[i];
 
-- 
2.54.0

