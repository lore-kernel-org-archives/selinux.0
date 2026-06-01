Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC71A5BAE
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317756; cv=none; b=oxcLVBYlbdNldcHis+H1pKCoUTCYYH0zaZc/jfwgN8ug8voMeP85FlamlKuR9Wj1b0TH8yxlOBAi6Sahx6QkLQ7C1DwkgpxlQAxDB13R7AQrXJxoDd41LpKEjbKiP8QDnUtPIfgMj1TyVE7KNcD0fUg9gmwvwMthCu1w7u33Xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317756; c=relaxed/simple;
	bh=8uAvyRDwAPMXVkq4wqMKp9Nbz2DoZ1+pE4vRH2kI588=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1wEb1K/rUnApq200u6+mANIQPn3i5AxrXe5xGOZRB0kpVlBzCgBWSShmqQ7jzs4sd1Vqebeux73axrtHl3RIQn31H8TW7eilizIPXipiV6F7HBc+Dc3OAxJQ5Sd848QSYevm7iBK2HZqyBENusCycY7qiepv7VsMRNv8UPKF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fANr+n2k; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fANr+n2k"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91563abd6a9so33765085a.3
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780317754; x=1780922554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATU9kHSJLK6Xr8UaYs231mfLHZxGoHZwHgKbFim6sy4=;
        b=fANr+n2kc/mnOj2LSIRQN2WG3lWJp8mJ3yFFV9HUzrQhbY9Jr6zqD4mrUAzOexlha+
         CTkVVYTFE5KOqLqsZXoXqSRd9xS1N0Tm7EZEQ2kBrNDeWiQvK3nPVnf5f7AI3pHfewCM
         Ur+Djlvw3Ccc5PIRWdGh1LFud0rarHuWTgcqz4tnPEurcLk2U1JRf3RRBgdjhNAUQT40
         5KgiubUkGUg3T7dRL4YYi+Y6EibgKuxPDIKFqIjIIPCFqgLERky9Bn9/RcRC7WgoruVw
         aL0jeEbQ9mOAed6fIUIzt1HQGefZC1Jq2SqMbRJKwHbasvM78AWZ3sF1FRHRiksIjoyd
         FfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317754; x=1780922554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATU9kHSJLK6Xr8UaYs231mfLHZxGoHZwHgKbFim6sy4=;
        b=dlBiDZwLDMJxFiU/V6kl1EOoE1vS7OmnVufpAujKhOGauvmYd+i09k5Xm1BQy/6we0
         1Qh7kmRVpx/j4HWDMYZSYHomdSNmChP+GWxDFKs9sJdPavJv+2dPTzf9AzbPR2sNGbca
         bN+4LSwAeiOPMMsW2qEDCaqXRjRi4fQY06h424XysHyh5yHAT+++EmoHmYcVcL2AdVDX
         1LrpGLLzuOk64SwMbE8hvDD00XX8045Lb/ROJqgWJzdkiX7WfkQwty4PcVBkTqIfk6qu
         mRfkeRA0kVeyXsnGpOTSBGhqOLZakxhX1f6Kh5Z6EEQ6ATrZDupVCY2DBPMPkgUNleW+
         g6pQ==
X-Gm-Message-State: AOJu0Yxd+262ptdwiEM3P+YLVwhxkSwI8VvDQm/9mqIEsJiQO0KVoayv
	Vc4xK1QwKVtVyq8Lq113P54kzGP1Zm0Tr91mSHLBVM4eNzhyo9z0sBF7zAbpDw==
X-Gm-Gg: Acq92OHuJC6QhAeTirNqVBayiWMlyGPqjOvf8FeyytHHYIw+UQbtaZslPERUDxrhid7
	7v62HxaQ1vNMQZuzQd778hVW3ER2g714SngjdB0q8M4YgHEVQUTFkxtY+r5Ll7/1fWdU4OcbRgF
	gNpOuNjLWlfOpSGrSTjib74tDNBfcv2C6CB4ZyQDhP0c+EgoY9IDDL/No0h2gtl5PKZDgloL+ow
	pBO4fC9CvW1w51L1qBUqOZbMYFPCDyG20ePsKWIe/f68kenQYyS86zBsQU8+e0FHMpQZC9QLp2O
	OhouCFxspP29020W5ZM/dN8BcytCokN2xnsI5jN/9G3R0DuSoi6QnvlwZWn62PVhH7Fxgb08REH
	6z/6TnP2Qe/TnKID5nP2nXmjjMMaMYj46xCEGIZSJ/i6qZH4pMtru2xaxGmZNMs1E1lCyIycQmI
	3CfJZPhloAt7hhwQ4e5ZVytPyZdD63+R278/mQad//fFTNJyUPesjWCQxy6ZXz7Dz++hY9usl+S
	6rtBJ2owd157IOx2uJM74mk0KdHKZcashazjg==
X-Received: by 2002:a05:620a:6304:20b0:914:aa94:8ea with SMTP id af79cd13be357-9153d96a6dfmr1342421685a.19.1780317753730;
        Mon, 01 Jun 2026 05:42:33 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262f45dsm1015568185a.41.2026.06.01.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:42:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libselinux: load_mmap: avoid unmapping already merged mapping
Date: Mon,  1 Jun 2026 08:42:10 -0400
Message-ID: <20260601124210.174430-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601124210.174430-1-stephen.smalley.work@gmail.com>
References: <20260601124210.174430-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to clear addr to prevent unmapping the area on the err
path.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 88c2c9e1..1649cecf 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -992,6 +992,7 @@ end_arch_check:
 	mmap_area->next = data->mmap_areas;
 	data->mmap_areas = mmap_area;
 	mmap_area = NULL;
+	addr = NULL;
 
 	if (data->num_specs == 0) {
 		free_spec_node(data->root);
-- 
2.54.0

