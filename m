Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFD1EFFB7
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198514; cv=pass; b=MusfynKcG0cI8Kx4iok5ejJvIsX1LOw8G7PTHPBE03aW2Udk7w0u+kmSUjer2gdgUUKFEj2Svmv7svIFlaeEyf51cp0098MTxfbWGN5XsWd8Tk/F6xI/s7afdSHAP1W52k5F/xadiu/AGpF2J+1XBRxKI4WqnR7u+fYHAyRn86w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198514; c=relaxed/simple;
	bh=YClnWxAZzLXxSW6y3LH3i9NbMLvH66kZ0/+Caj+H2aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXSm+x8xUs9J/JKkUGFvoqdr/QVq6VYvgioMxQYlRIAaxLVi2qNPGJ33ejY0W0UFhP++ss6JKgtGaCfyZwkxbR2kRHL/hRzEwQW7dyGM/7K5ZwKXvOxNpxeS/2GzgtC+p70n+UUdHFEkBr8qy8sjfk85x2V6JrUSkrENz2zE+t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pg2AM2L1; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pg2AM2L1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69ffb48d599so2334986a12.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785198511; cv=none;
        d=google.com; s=arc-20260327;
        b=c5oE6GUEs0ZlFZFyO6qcRm/IO/0w8Z4iRy/cjM+1GV3smW9By5gAKln8ra2E5PniR+
         AsyKUqa9n3C/NtXDDTihkT4QsBD0nnq0o++V2/xyKQBX4cTUMdsBn4bx5Ogvzd84njVH
         IMT8imghXkJHb6587WGo+CI7v05G4ddhVv0lCDnCVPuLUwwzBGncmChIp2370o8O1/Oc
         0itKX+vKcUi4FN+tDIcwrP6LDUO4PtwF3b9MgN6fMzkGkrnUBrhw6llVfIVQ+AQzrJl8
         ztMg1URw+fdUP1sdnWkrt2J4EGNCkiwAejOnE2DeiWI/tr+L1BLMSlSouYbvY7qgWTrH
         NGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoAWrFtDL9wLXrUXpLS9z22viQcTgc6ahMrO+sMDQqc=;
        fh=OV6iJnErG8Si16Dnxum4M1VhKNLN1StxMDyaXbWuLlc=;
        b=bjBd0rEaXNkOspBIWzImDZnrUirVJX22jydc/zjmM8MdNwMPAQ+5Ox6WBUJ0p7Klv6
         mWJEgHb1Ry4F8XfmRyOJKQzB7fECQLfYKbLpBZjNcIW/ZLJWDZhv0Pi8NF11qiEB8Ks1
         RdiKVMijmFRDeeoEWbUV+A0hoyhvLnq6Iezt8eDbPOb3AIWfTZkRzCsC9h0C9NMSc6DH
         8Uuztvv/brZgMgcXlQX+oM/vRH4DjvfWPOQ5wHLJ5VU3l1ZXpRbMDGSs65ZNrmEOLYiX
         EMT/vEnUAi/cd4SE+MLOeJzbKScogsmw+AcKkqlvD6SJne5u7dFt39CbBm+ynsj33Yoc
         nDzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785198511; x=1785803311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoAWrFtDL9wLXrUXpLS9z22viQcTgc6ahMrO+sMDQqc=;
        b=Pg2AM2L1JbFMBTcYTWDmamF1g/gqwYKzVmaskYyvpYvI8XPjw0M22ipRS4VbvChhEy
         aNxP+c1c38iXt8AOpitFUC7/wzhpC1WlJG3B2OBZHdZ4sAwucOncG0VFmr16FGurdXBQ
         hHTE55JCS7Snj59xGroyvob7/HQe9x9+rKTqGI2iQNS8/jlZU+/XGseyGHr24zHJPE/u
         R5LsqPoJ9bcmjklXfsKVsD9lN3rIBLvG1Mk9T//dSW5uBsufnmDC6DvRmQsfB05qedFo
         hBTkhC4clp0EypBCW9dkydLGJBWHH4/2jpl9hsc2/C/lT1jmsnwapyDMFD9HJOckKZKI
         H4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198511; x=1785803311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoAWrFtDL9wLXrUXpLS9z22viQcTgc6ahMrO+sMDQqc=;
        b=V5AE9uc+/PSlfqNNfSykC4G0dmZ9MXHpqtk79OvAAwuTVbmC+OLN7/Ok26UAtcxWtb
         zJHWYuTTrDEgWx9bcEHartiVxt7NE9Ff6j6jkEkuGxouhMEJbsbHuZrlMQoOCmJJ69By
         Lc/KP7IlIeCcK51xo/ubno4HheHBcti7VXSIm00P2ITW77jOHECdi4TjNa7sH9jSuI5x
         lruM2IXYgZ9jHEGg7Br9QK8vKUI0hzIoSQJQBa3iQya7/JLVDGxhm5+gIMiFQf7dKsdr
         eJy+TildYk/hkaQKManrA6UKspXaUiIvIlxo6KnwozZmPEJPJAOZj1ZohrvZMbLWhJ1v
         X81Q==
X-Forwarded-Encrypted: i=1; AHgh+RoUKmSkGtGTp6sxcO60ZSkzPmwrpbDeyOdzVirbGHerDQJ6LZU85cdTXBv6bFW15Pe8G0srm/SP@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFcm11I71iJEtXi7k2rSlCGLU/ZSmKmiP2aWIlrGvkCv24Y69
	bOyeM815q62LdSHDii47tM/7ibAHArlbTzGih/INhd0HQeuCIPSp4ZNufvziYEy8ghY/RpSpyXa
	3VzkEMk4i+wnU/8/Aj76mmbnQOy9nMzsmBg5XOfSK
X-Gm-Gg: AR+sD12QantAUH+P2XnJ7L2S5hxauy6RyejS9RyvFOx/GYxYfeETiEERDRahgNVMDwt
	2dbb3TfoUU5FPutwcNAEPwRG7t+h3YbmMIB6N5qgovUdKzQrTid8XJkte9QcSP9q7Ru+OQkdQ2Z
	v+XbjD1pzrtUQ5hmTOjZSS3pN2Dm4BX04BmCwyU8aEY8GxmPu+K200dQ43U62Mxz5JILFL/pTWA
	nPr8MnVhg1NohrZA4cmnoo2N1ZXlaMuymMo5HtLGilQUg4XUrRznh0NsHv/4g==
X-Received: by 2002:a05:6402:2684:b0:69f:e3cd:5ae0 with SMTP id
 4fb4d7f45d1cf-6a034a1c2e8mr59739a12.18.1785198510685; Mon, 27 Jul 2026
 17:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174521.589520-1-tristan@talencesecurity.com>
In-Reply-To: <20260715174521.589520-1-tristan@talencesecurity.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 20:28:17 -0400
X-Gm-Features: AUfX_mwWZHYR3F51fSZZlvPN9mmlMg7Kfjq2d-ETIPzjCOnQRzggRcMBgn-pmhQ
Message-ID: <CAHC9VhR+4nBiAqdNDPequ9o9MW84EeA3t279Pfr8fCHhUz=nQg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use socket SID for SCTP bind/connect permission
 checks in softirq
To: Tristan Madani <tristmd@gmail.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 1:45=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> __selinux_socket_bind() and selinux_socket_connect_helper() call
> sock_has_perm() which uses current_sid() as the AVC subject.  When
> selinux_sctp_bind_connect() is invoked from the ASCONF softirq path
> (sctp_process_asconf), current is whichever process was interrupted,
> so the permission check uses an unrelated subject SID.
>
> Thread an explicit caller SID through __selinux_socket_bind() and
> selinux_socket_connect_helper().  The process-context wrappers
> (selinux_socket_bind, selinux_socket_connect) pass current_sid(), and
> selinux_sctp_bind_connect() passes the socket own SID (sksec->sid),
> consistent with other softirq-context hooks such as
> selinux_socket_sock_rcv_skb() and selinux_sctp_assoc_request().
>
> Factor out __sock_has_perm() with an explicit subject SID parameter
> so that sock_has_perm() remains unchanged for all other callers.
>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  security/selinux/hooks.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Based on an off-list discussion with Tristan, I believe we will see a
revised v2 of this patchset.

--=20
paul-moore.com
