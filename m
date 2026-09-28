Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB0267B89
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624918; cv=none; b=tLMU7B926281zFdnw5c9t/BEcVsywWoO0eqZX0lqYb1UKXXs8+IFFmQEU+Zak7Sr2Iwslf9AKQvEKSomHx6gbEvOcz3df+BRF1+whq/yKltpo1y38hVZ6IKUP83vFRY10dh1mCzaqXcqwj69Rub6Fgm5JJIb8YcAWpiT4UVTz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624918; c=relaxed/simple;
	bh=B+1bFfbNJbXoSjY+wDsmwAP0/w7YP/3AZG/P+COabec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl3axPQXps55t9jWrUdQhRX1v7hgV1Za4mnUfVQPpugiuESkNxpAWTuYTYoSVSPLYOw2CjLKBlzsdFRmDblPaVyblKfuwgmbvrj+hgpWBVoABBkd38jyPPyZFvlhX6p+OiCHG3fyeyBlGQpRYtxcwQkMfzb0hS5NTloyZmGu3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9VNwVTv; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9VNwVTv"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-533245fd18dso18247911cf.0
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790624916; x=1791229716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B+1bFfbNJbXoSjY+wDsmwAP0/w7YP/3AZG/P+COabec=;
        b=E9VNwVTvPIO0lSc5YLGn0+R2vamdfJQdpiscS1clHHikuAxTiwqxLAae7FEN1U1khq
         HcteQ8VYy6eR1qmfVr3E4co3+IrKre/tk87iW2A8VZVcQ5esptejBdzgvyVFdFgQSHTn
         1BUODIPhmkHnTGjolkA9d1KD3F6Qrg+f6yzqJ5o0ia3s1jYQRZJNi+zBZixMngEnf1wM
         BywlIcG4+8IvoVLJKtyFkoBNx9LnXYcPul9uHL+NM3LJvR/S/9W1p7zQM8LxYL7ddpYq
         f635R07UJpX5ppmIXM5ebJj1bPegruikvQPAcE66tTAn5KRTDtBa8bhLGkWvPL4fV4/L
         XXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624916; x=1791229716;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+1bFfbNJbXoSjY+wDsmwAP0/w7YP/3AZG/P+COabec=;
        b=vESTHnjbrHz3LcGcR1kwLUGeGRHY9Dyjg65d4a8ZROVOsaK8zTdU5WlOAMDsYBzTTP
         GuNyvVOy7fVJJE1JJeAPj4VgbTkyGPJukv0/+QmfUR/eooiY+QYr+QLCTnIwDpJ3AsKn
         aU+k8soTfLudTVU5aPBbgMVlblutxDIFKD7UHbHExPlY/7cURBUhjkOaxAZEOpYFawDe
         kbXYzRa0b6g6MVh8y/bYwyycBXazvnkgjJd/W6I1jLFtpeKsHJGXBAWrHLPObKaRCFE0
         pqBbda3zJjyQGWvomp3olxOPdYld/1On15g0seR/u4XetbWavsoeomCnFFsyQZBgIA0C
         jY1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz/GJcaPytrtT8GqTOHDNVyKvgFJ4Dm+daOYddelYLV2eyqOp+v8Wbh8tsEYL+ycHLyaHBkE4NW@vger.kernel.org
X-Gm-Message-State: AFuF++nkr8UAREatP9w++SmB54Ti7s6yoBuxgxToe75TsdDHyu/JuPUT
	lujNKZXDsrmaz88Dn4ZMXzV1IOpaI0Zj0XPZGllfhuAW1Dy4nHNP+FFs
X-Gm-Gg: AYBFou0YPGcSDakuhWC5LUp1O3Bnnbpi7gvfRAicep6cApBQ54B9RmC+y8Sgn60hkFy
	u+TGltGdbVsQVMqXwyQ3jEeYjxRqL3LKg1zXmYk+yP6GdePvej2toHZx8Gq5trhJyffFW9uydAf
	zWwS/UuPChWd+S74ZFt7/Q0tTr3qIvenN+zl1/xMklOkvWDDUqJ9mRlBSVj+fRFrQATGr/nonSz
	mhrJ7G3oRIILNsZHcHxdpmISe7qteokZHjN3UddhpLbbXtpOt7WbqNM5TRLLU2tKPK7mHV+R+XV
	BLVhibfyw608oZLK3IDbtcWt/lKQx68N9NaPBI0d//XuHwVOTiUuciI8gZX5wjg585bhz7rj2uT
	umSPAEBAc4O8+mGv2UjgFcvDONmxmsTm2UK+V7lMRklDs7HIwK4g858HgvP3piBJ0heYDSB0JqH
	r/nU9gvxTv9SEjUo+lAFYuirpouignItB/unwZdt/862hnKT+D6y+4fOLKV1cfEM4x3IsKAyyLZ
	JypcwHw8mIiI0SYIBo+p8rKiwrupqoAey+kmOn59C6kjuq+z1KTsK5J7i/XB85v72SA6p3umjQ=
X-Received: by 2002:a05:622a:e199:10b0:533:2ad7:42c8 with SMTP id d75a77b69052e-5332ad7487dmr99537911cf.2.1790624916423;
        Mon, 28 Sep 2026 12:48:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533222585a1sm70690491cf.11.2026.09.28.12.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:48:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: cgoettsche@seltendoof.de
Cc: cgzones@googlemail.com,
	omosnacek@gmail.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [RFC PATCH 15/32] selinux: make mls_level_isvalid() static
Date: Mon, 28 Sep 2026 15:48:08 -0400
Message-ID: <20260928194812.82315-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>It is only used within mls.c.

>Assisted-by: Claude:claude-opus-5-5
>Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

You have a patch submitted at:
https://lore.kernel.org/selinux/20260928165253.2388012-1-cgoettsche@seltendoof.de/
that re-introduces a call to this function from outside of mls.c.
So if that patch is merged first, this one needs to be dropped, or
if this one is merged first, then it will need to be reverted again
for that one.
