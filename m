Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949843;
	b=2S+NWhy8LHssHVJz9Ot8KdnepE+MJVj2l2/Z23xX1U8VcUsSaVJo0AS9drLwcCyxoxBN
	 ipF1T6g36YG19rnFRGOw+bzsG5Nd6yG/Qt+gfbjHt6A3KxZysC9SkdJy2J+gaLOjCpyI1
	 BZ8NHhn6fs5gcFuJEECVgZbGFaBdUSRjwfySod5ZvlXXy4FtkC7bp1e7gX8+8xF/BZcGE
	 3pOdpO8ozm5OMq0kWMPaB3PufOjah9/tzWhmH+QN7rBkLxX0zCxadRd6hI0IfnJrDGNNe
	 0Y7czvqt2fG7eS73IFppfB5Co3SPcDXa3tsqZqjzHVDv1FQ/4A4nj/F3dbJI4EoJ00w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=RbJd2yor7a1B6FmjIbgcMguBuxsvlroWpg20DMSf/BQ=;
	b=Kp1q8Fi3vemWaxCe2v/9MfEbRFRs0shnY0+Gr9ZpJrDXRk6xpgJFwuB0CuQUJPtAsfgN
	 NrHsg0WLba8eXV9KoQx/vQCABdjpMRR5mDMxBKx2PTf8XPdnlV6rtmka9kxTpgi/anmTy
	 F5QRDYba6F1IdMi7oH2nvx7VJgJwpifSGd7BiolK5Yd9aKKe9hjb6yE2a1T0lMVROMupp
	 i21QDC3ZIZH5+dC4gqEo/lNK2DMB15aOBEY/iQEYiHoqjkmyerF1UzoZlYgKCsIndxBpw
	 5/Vs7ZaUC5A9x5cqJ88/FWQ9Q0phk0M+QR5rPCiqjghDoGgBQ39aQVbQNOIg9/p1wLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=W3OC8bYO;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAA606A883
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 21:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CAA606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=W3OC8bYO
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55c48582654so2806641cf.0
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794949842; x=1795554642; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbJd2yor7a1B6FmjIbgcMguBuxsvlroWpg20DMSf/BQ=;
        b=W3OC8bYO8X0GRGY/8MZ8eftx9H37MJN/mqo67JR2Cj9y5iuqQPFfrOX/jF0nkOR5AM
         mQxz8x3bP+lCKpB4imrNuaoy/47un1WNB30A0skerxA9mVRkJ/TgRdXrPyqwS8BUduf3
         7uF94Q9fEU7cVLLSlTfZCHLjd+bpY++5Y+RYjd+oRIRv9/FjuB6BLXgsd0n2Wsp95IXp
         ovCiEI8sntqLUQM2Nhvrd747GOyFmF4JAI02AZpVCXNuPeKs0WBYulWn/uoNPaXNBMel
         Xqyda38WxpnJOSV4AJJA4ov0bl+yDJGqF/jyann+XyvB7RvpYsPtOf0eY9w6hSN7W7qg
         vSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949842; x=1795554642;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbJd2yor7a1B6FmjIbgcMguBuxsvlroWpg20DMSf/BQ=;
        b=OPQqJA0+VvbO4phjQlykqpMh0T7MizAcSe6oki/d53uNJ35xYsMadRYtxZg9QnhsNO
         9AYccj6F3/XTSo123Jmx50J5o9CH7YXxRd5E9uKuWmKDeYW8giB6LH0wHlXzs68icJUs
         h5OpU3y0/m+ksNMrYHuaVySTsa7005Ybuix27BgrUxOFwYoY/B512AcvzotRhEr/osW/
         EMD+3TLB07jSNNSlg3m9uvLwQKoYyP/C7+Uvs1XezkcOR88w/THd7ykyUpI+GPSMqWrk
         w6aPHPqWB1ObKdagjNCzRP2frtrs3/ENsHb7PAabzdUprZ/Cg9yDZ4KScrkPSb0hWJok
         qLvw==
X-Forwarded-Encrypted: i=1; AL+hErF1dLxIcylZLU8AlGGEHG3tJrQlnqTS9g87jsAaUU5HK3TCCb15hYtzCWCz1EW6tEWLKPC06mbN@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hz2BzYsrP87Buu677YV/VQejQ7kYYpgy7tfSnnJSu3CKb20/b
	S2yA5/8qPjntlRLEeapZCW817yWTMBM16vlMlV27wQ7hpv7Co5emYYH6Vo0mbkp1Lg==
X-Gm-Gg: AYBFou2FG92n1Xaa0/aFTeZrp2yWfstW16cfvsgZZ26bXIapEYCrfI0UTRik4i9uwrw
	zKd3NWReT8aZkJJ4nhvYDHddpEG42bBiBlqPN898nk0tY2MoMBRORBvJQX3+nYUhpGWB88cr1Uc
	kpe4DuJK5lhBPniDi99wGzHHcwbJ+JYm5iIRJFaghpKDWeQzEWCLumX9lGEqDDHqznuRZZPK9gN
	sMCgLCxCBd1vXutXG/MowIT9ks2r8fghdtyVsjhetraOMCqP77JEplTljU9VihJm5veBWGEXPTY
	EtRu67PoQkEwl9zWfhw8ZObuQCgpo8Rt9ZED3Od9BquN7eMlszOkX6AcBl5vGFEV5UDzIrHOyXE
	6Sv1rOEh7uSCgxepisqP+D3Wuu3sSsbUlWvyID4lJPqF/HL4xHzkaLPBB1qxjIS3li8eAEO/r8R
	m/qDbdV0qSmqPtxod/Vk18l5RWi8cOIyl9k4Yhr3kg8UCug1mFRKqIySIwSn2MMIO6YKM/6ZJKq
	Buw7mcUGqFkXNlo1UKcCdRUTxIVGgxXdKgez7aoXWIyGjwhKTB6ylbX2G1qJbNFdRyrvBWlax78
	c1BSGIIqZDn9ifOnWUZTQElQ8AzXdJ5wiOm69lxOTQKlfbLrvnjXEYuXbWHQP3FkJJUSpn+FA9V
	q3/btsJ0gIEfx8M+hYE2/geL4A4NzJvMFi+hO1Jha+Hh9waKSOLpF
X-Received: by 2002:a05:622a:c8c:b0:535:162c:2e83 with SMTP id d75a77b69052e-55d5a5543f1mr9261781cf.16.1794949841754;
        Tue, 17 Nov 2026 13:10:41 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d59f7160dsm4614811cf.29.2026.11.17.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 13:10:39 -0800 (PST)
Date: Tue, 17 Nov 2026 16:10:38 -0500
Message-ID: <6b97318740a2ed35f6becbae7c24395d@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: Thorsten Blum <blum@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: use isdigit() in selinux_genfs_get_sid()
References: <20261014160741.222219-3-blum@kernel.org>
In-Reply-To: <20261014160741.222219-3-blum@kernel.org>

On Oct 14, 2026 Thorsten Blum <blum@kernel.org> wrote:
> 
> Use isdigit() to replace the open-coded implementation.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

As mentioned earlier, this is a partial dup of a patch that is currently
in the queue to be reviewed, however, that patch combines this change with
another unrelated change, so merging this ahead of the other patch might
be beneficial.

Merged into selinux/dev, thanks.

--
paul-moore.com
