Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23133A4F36
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593485; cv=none; b=OTNFh8gghY8hI3GahViGUO+0pFnuXIuoRf2cFYz4lsbFDolEwLFRc3YsGmhGV0Jw3rFkC7yIB/uGoMPAdDowtZp3YCN7trUlpPxbN867aea3iPT+2WjVy8z5RC16/sK3OcsDyoVwpPqkmKzrPRe8N5BZmnDqGBiwebv6W0vMCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593485; c=relaxed/simple;
	bh=McfoVbZ/utKPkPUJItb9OmxCB9231XrRA0w/2eYmmMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRVDDIUJ/7iY07j9FhVp/O7FFzPWZphi5cQc0JrDrHEo68Dz6Tc06huEAPzUVfxgMw0KTixLqquofTDOxRNtVr1aW94AAMnuh8xBqrqIzVy18lVn4LglMWuCZgEpWPE9gRPbNlhivtN+qyxGuRWXqPY12w3IxBNM79tRfsBcV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTm6S/6A; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTm6S/6A"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9159f631656so106217185a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593483; x=1781198283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5k0OVHpIE7+1QeSPVZYQBGYoPdvEeWN/5NsDAzUBpnI=;
        b=RTm6S/6AAN102v5atOKvSkdLQhAgqofYS0ycJkEpXZCVllGPdZ8YBc3jIyskRYIbkY
         XQ2+KtYh4r7nh05fjOCm0YKEdPlGsfzpgfG4k2uCwhAHX4V/hEWjoWz6vg86HYaHFyt2
         7QYsp+1bxx8t66NP7U25/rp5+XghJNRQK1bNQEI/xgTeimK/VyzNpxXCXB561CW2b9kp
         odwTp8sVV8uu9j4lILkmmlkjZ1heL9QYiISzrmeHYRrhVdIAHLR/mUE1h89ox0FH3NAP
         WFCW6PnAaebs4Unws3v4uFQC0PFREbH95P8EnzgknhA1S1kCGfxI3RtHglCaobswieBV
         wZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593483; x=1781198283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k0OVHpIE7+1QeSPVZYQBGYoPdvEeWN/5NsDAzUBpnI=;
        b=V2MJldxSkymEo4pwViYpVWIC0Gdp8mNXBCcMxPc1BW2bx/i0ZG9maxmYuFSOnISik0
         4EUrFxtgUAIpuFtvsck3+0houZC+BZeeBk3TerhiHNzwk51MZTbd+27Na5zr2NWQBdg3
         9MTMFwL+n8mBsDZWOa/ZbjASB7nsq5W0w2aho4TnK3jAgI8s/1N0Drj30fSnwMbHSKBM
         NaIcXZn8hstBbzNS04uBRzzx+gMIltmXM1BwkCtZTSHoU3Y9Nj57zZtE31Tdvx/6rrnt
         84MYpjA6kCCQEohGbZCAeJxkxiVHFwiS7jSIwiauqoWcIOnvCOh0oBEbcN8yLICo+tlf
         X6jw==
X-Gm-Message-State: AOJu0YzX3EJ0jC8Tu1/L0jroX7q89oO/wPV4FKL5vehK0GDplszgsIDO
	TpDpNClQ39k8wB0xYkTaGVixByjpkdWxbBwmzdmHfxqtmi7xKS3j65olf/YobQ==
X-Gm-Gg: Acq92OE+nWqpQPPlAYK3uRli/Gzq95rHi1Moky62zZOyRmB2mONdTjwbnUM2UqPjRQg
	9kxcp3pVVxc4pkSuPj6xQYcAVqE202CkQsUHPAZYwWaQV/ESfwS+dMdMUvSbVRAoHQIfeVmsV7d
	3EuJu/smXBz8O8Ek+XTAY5AzY/UuBEjIh2DB5/skagjkFS2QN2Xw/8FhMGmTLFWCqqxI0ZOmbnE
	q8myL7e4+U22nHxqtUFWedzeDMKiYE8oZAq4P93eh6ZyxRcdbqTW0FoFysxZJlrjGYLnFcV2RAC
	Lw7CVu8N9IWREqlnvcmIK2hvIuTGB0LKrL7aUQhyKd3zopQSCI0Ne6bOMOfkYgnRjsRlW0JNorC
	0BMP85yQPJ0V4bofsuimFZuTpqFAz1lc++tw+QROGBs7bY/AH68HMZ2EFdgq5Oz7fhYtOOy8WpX
	fw5Ia+tcd1ofkkIgLL1mOzGND/99k40DMkuUGYgKYPEc2LZSZP6XEgzYsD0azcooluuIfUfz/U+
	x/Ht+t6+nuzKqdtKwsFpXaZkr3ZPVZSSBcI2Q==
X-Received: by 2002:a05:620a:2552:b0:915:6ce1:3576 with SMTP id af79cd13be357-9159af54744mr667439085a.20.1780593482726;
        Thu, 04 Jun 2026 10:18:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm684478785a.3.2026.06.04.10.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:18:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix selinux_status_updated() for MAP_FAILED case
Date: Thu,  4 Jun 2026 13:17:46 -0400
Message-ID: <20260604171746.263416-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the status page could not be mapped but the seqno has changed since
the last call to selinux_status_updated(), we can just update the last
seqno and return 1/true to reflect that fact.  We must not continue
further in the function and try to dereference selinux_status.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/sestatus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 2022b23d..bb69fe90 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -120,6 +120,11 @@ int selinux_status_updated(void)
 	if (last_seqno == curr_seqno)
 		return 0;
 
+	if (selinux_status == MAP_FAILED) {
+		last_seqno = curr_seqno;
+		return 1;
+	}
+
 	/* sequence must not be changed during references */
 	do {
 		enforcing = selinux_status->enforcing;
-- 
2.54.0

