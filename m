Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9F36657D
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529351; cv=pass; b=Tuu0lJj8Q9BAl26/A7OUfSiPCFO9nlrSBvdgkfvbjDrmdRRLUqiyEQYVko4QcT3nLPkfQXrAY+JoyByLzuWogrnyKIV5prxuw+kCWnHVl5Zxm3H8VWYNZp2baBg2LVb5S0h84atRgaceChZEt7GfPIb7TlVPkAjy3cjGdjO+MRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529351; c=relaxed/simple;
	bh=1CRC7gO0ryMkTkJ8rAOUD3ZdeBEZ1FQs2E1p5faLWGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxfQLNyQLLdJfStS4YykKa8wMZ3KRB2BLDF85seCMdevPFizkfngZ6LYE411oSjX1ChKzGCNSTOm/KGWL9uN9fXGuc2II/ADL/7lMowE3R+UxGmF6fvugxbjjJyhq/o3RYZ5KWqmAmbQnbbSaAXLdqp0CZ51wlSdsRHqCAHOyDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WV2nmFdh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tt3AxHHt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WV2nmFdh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tt3AxHHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777529347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgpG8Sqo5A4kzOap5OrRe9Z/+oueHNIzbiNKLbnIrnI=;
	b=WV2nmFdhg6/zzMarWCAmXdKdAr/5Ea/wVFMVs4avWZhSSoXMrO0EgmRm9fzIEB8/bdmo1G
	QGStsMQxRwFrAFVQkRx2f2XGv8TXaZFCpq/XfKKZlBk7Wa4gOQGvJPz2Z1T/NMcfLwvb70
	zV0amrdbkpMdyncPze5fkVJ3mCo2jec=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-JAHgjvaXM2qhl6-RmO_FZg-1; Thu, 30 Apr 2026 02:09:03 -0400
X-MC-Unique: JAHgjvaXM2qhl6-RmO_FZg-1
X-Mimecast-MFC-AGG-ID: JAHgjvaXM2qhl6-RmO_FZg_1777529342
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso5761385ad.1
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 23:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777529342; cv=none;
        d=google.com; s=arc-20240605;
        b=Lu19oRGeoLmxcIpKY5/zIoJLMVDPYF1DDi1OBXRozzbdk2GuQoM8c4QHDXKwlkiJMW
         vVPZrCfVjK8S97wKwFmllzoTaK665L/20xZbrY9M31wARGG0uXDhZhtLk1mzkOYW/qFi
         4W4h4qqqSiRy/uHPdyRxtmr3i+arKHepw3Aygl03v/ifEJPqTvq3FU+NZRjY4gavjz+a
         jrvh/P3PTOyYjwM40Ko6M0iLjhYk+dkrfEp0sZIZGd7MhmbNFOLmbKJ0q7Fcik62oZXk
         MW8f5iTurLJpmMy3CBKY9CSEhwXhpfPVBa9dlbkXi+7taYZLn2Pu7mkUQlx/8roSPPEM
         1MTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LgpG8Sqo5A4kzOap5OrRe9Z/+oueHNIzbiNKLbnIrnI=;
        fh=LWoJkQLWL94W/tKWLtIVIRDILPlsqq+t11tHPyfXr/s=;
        b=GmRGa1xWH6x5McIG+lobC3Owm2hS5HG4ffNKq7MQuwRjBKQKgdFWKwkyg/5Tg6rWy0
         Yn3nr7U5ODrvaCfIlmK8ldBcysSNhBxdB+jRbuBPokKcN3nhxpFYN2LLdWmJiNrpbrj9
         uVQd/ezCTg3L8UCTMsna1hPTDej/nQdWKkyeWXFUO/PZdJAfu+LV+x5/wpm37RzRKquQ
         VYEgycfZsUTQJ32G6g3C58AZFpstWvIbeGBnHLq1KnTPOrNsnCoYIoFl8QGB2/rqFts+
         yLEQUtR0cJvhSp9aQCjKFoe+TixLhVMvfQatqDeKx1pqA8vOjPfab+rCh+LO3bSh+aen
         WJVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777529342; x=1778134142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgpG8Sqo5A4kzOap5OrRe9Z/+oueHNIzbiNKLbnIrnI=;
        b=tt3AxHHt5N2e2NJaf3VfR/gS8XO/B0Lr3kh4sT3/Wmce9T4m9SHXLAv08k21CY2apk
         H29GQR5C0i5qvwjTvkovV0Ig4yfkCGdIkS9fJmw6o6c0JJKfQIL1BkG9kiZRe+inJmwE
         DIhp2huLVpEJTnfWJTVrvqjPhFYqXrwpZvs31nneYm4A0GgzzQY6jzuB0asy9J594De3
         3X4HAHw45APN6PeRq+OHD1oHMurEPHBH7eXlb+wh/LljKy+4Kdy4Zy1pDYNir9HYQ9XW
         llTPiK5rGdV70g7Bm1m0Q2mil9CkP+2hmvtXelNOHNtuYl1hOkKEU0T8La55pXw+j11m
         iHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529342; x=1778134142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgpG8Sqo5A4kzOap5OrRe9Z/+oueHNIzbiNKLbnIrnI=;
        b=Y1V6Aq9ybaWQOvwP1GmvyjL6HJHEWs63HUa3yjJvOj4uoSddfbOKU46DBHMxW2Smjm
         RaGf4AqMa++IWBBxpj1naLgg/eGo8W3kNYZC8wMGPCL/sBG2O5hsa8ATkr2fcFT7SFCM
         mD1HD1IfoG2Qm+DvWPdVt9Hcz1bbriybVBqO8JyVkDUvujr8qICZpgx1XDSFUpFSz+xL
         L8PHykpflgAVZP8vqWRy7b9P2mwRBZ59s9HYM7rm4mpuUdvsJNQtqSTGG4cP/qItPB+l
         WB9iXlKcwWND54u7YiGsiLS18aGSVrVdVrRGbC3Ev31scfPWJ6VXrcDxeTDdSMkHJKoU
         RIFg==
X-Gm-Message-State: AOJu0YzUEplmKvPyiaw5Xo2JZLiADSM6CVzCH8miHBzl7Nf/RaiiUEjF
	G20Y9OdZuB/1IiAktPWbbkFrLzMwzE/Hek3X+8uQw1IDI4e960+5D8BW0MXoDBWHmfdfGTJVBm0
	Rwyew/ASx6QL+O76Mma7unsTzPemRVoKfojb7Yoy8xKFUvilk9as39c10Bf9hk8yNcl3r5flP5N
	DoiREoERhgsIFkoXDJHYR6h7rUUl3m7c5dR/n/1PleyZu/
X-Gm-Gg: AeBDiesR5HgndUSiYcahH4QDXcMGObqnSvHgOypL/QwIMWlYnCQVkrYkqIvc3ArwT/G
	3sskZyscg0MxcrHTJf/p3k4PJWdcNzfPeZuWQ1bhWoY/h3wvi2oVBly+7LuCxbAZ4aU4OqQstzJ
	mnueI/lo+cpzgTS7mKTUSxj4JbZr9PxfADYwjHnwsPNL1yEqF4gLQzrGXRpY6+OnPZPgZVfCe/f
	DSI1l9JVe5B4vrN
X-Received: by 2002:a17:902:d3c3:b0:2ae:504c:ae8a with SMTP id d9443c01a7336-2b9a2338089mr11488955ad.16.1777529342020;
        Wed, 29 Apr 2026 23:09:02 -0700 (PDT)
X-Received: by 2002:a17:902:d3c3:b0:2ae:504c:ae8a with SMTP id
 d9443c01a7336-2b9a2338089mr11488785ad.16.1777529341569; Wed, 29 Apr 2026
 23:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com> <20260429211229.3750-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429211229.3750-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 30 Apr 2026 08:08:50 +0200
X-Gm-Features: AVHnY4Jwh1llw5xw41qm9WpnWMyDfgc18FI15Zp-ag6Lj2eC64JaTyVbvqTKmTw
Message-ID: <CAFqZXNsh83H4TZ5Pn0aseZWERZcHKT7v1vNPsFm8PE4-4Ac6Gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: prune /sys/fs/selinux/checkreqprot
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 11:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot'
> functionality") removed the ability to modify the checkreqprot setting
> but left everything except the updating of the checkreqprot value
> intact. Aside from unnecessary processing, this could produce a local
> DoS from log spam and incorrectly calls selinux_ima_measure_state() on
> each write even though no state has changed. Prune it to just return
> count (i.e. all bytes written successfully) so that userspace never
> breaks.

The log spam could also be addressed by switching to pr_err_once(),
but a full removal is also fine with me.

>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 45 ++++--------------------------------
>  1 file changed, 5 insertions(+), 40 deletions(-)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

