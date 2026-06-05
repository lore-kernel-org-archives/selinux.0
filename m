Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E138B12F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674965; cv=pass; b=DYuf+HH+caQrAYAYNk1c+CdrhuUmU3qGpE0qBd+lTjmL1If22baLjMss5Lg3lfWb1B8tKnoUxxpmw/2xWZy4AkR9Z/f6464oAlWlrPrxxzJiEwNYYVO0T9PVwQjx+D8Q2qNU3Rg0/GWY/n95lPUw7/oWd5oT+K9gP3NCOv39bN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674965; c=relaxed/simple;
	bh=X0tmUVu8Tg5yqgJHE5MPnhHlOl32TGwGu7E1K+bOHH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2J+IAW0rGuUaSR2K2p1ArhOmmAKx2XYd7Bh/k7979aA4dRhNu6R856FCKBursXmn5QwAXlwm9fnsWaYkEce83+MdQPCdAnRMYcpzvYMpoVUgOQmU6nWkwfjyWygyMfzdGDb8R3OlOnY5KdiuYBESYr27ueuieOe6grfxsS8ZpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSjVSWgG; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSjVSWgG"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so830577a12.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674964; cv=none;
        d=google.com; s=arc-20240605;
        b=P42sdrJ6/QkTfWfDvSh0LneEAbCCfn9/gqQIka9WZN2GcihXkNcVGBVVIrO3+KiAVM
         ZSYRez7dZYQIIsFI8H9orhHq9xjRNZEID2onXuRQS3RxX4OXknUA9Q9Aeup0UUrgMX/6
         LJhd5inwCxsGm2mpF9ikumQVk/icdIE4pjJuPVF+PSCXqZex7mQGNHHxTVeLEuWbZuJO
         VyqfU4W7gmKT07qHTn/ImPA5kCFLuQSxDWBtK5HnxN9GTxWLlj8NHhQ89kuyBtJZ0J35
         39za/qlMEZhLk8ewfu6H+EmoQPiT0M3psxAWRFfaZI4NMsdkaQ24C3Q4XioxmchYFpeA
         Y9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c/3nAYsah7ly1t6mdzOaOPfizHpM13bravHKGR/cZgA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=kbuXAek0u+Rup+dqwTEm1lCfqtscJ3UPCwkdc0A5A9+E1ACICQmB0tOl7ka0JZrkG1
         I8S765fO2rVu/mo1h5uVwjZl6bksmfOtz9HcGi1+hNEJK6DiAlriI65Bn71KfLpmPH9J
         OGBwmteDiRNYV3jZOQp9t5p1uzd8yJBjZr96C8BGTb8Et8z6uA5tGurcrCi0QmPKEm5f
         LBbnZ+zpBbMfW0P/v0NxdAiPiZu3Zj5KH2fvCZS2fGNLQ/A0JD2x9ZTHGf638d1pctMP
         vjVss/A4DJ9RvAMhBepOojFhxLOh6eqqgnKBVqASk6f88R8FwnFOxKbPxualNNXCkolL
         XU0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674964; x=1781279764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/3nAYsah7ly1t6mdzOaOPfizHpM13bravHKGR/cZgA=;
        b=nSjVSWgGYE+YwDZSTrzZBP/nVAnuj39NqFeG1JB/yejYZSKZKIaCH8NnDqnpSlmzlh
         W8dxZ3YZ9kQrgld8hWHD5ck0Rcd4p1Nqc4H+y6xxaU4i8+st/f48F84bFRdSAbd2WUUd
         hkKG4yt5kWh+uRU9a+YRczsfrAxLev3rP+YtKenO+IZOAD8XX/n++AtzCGjBzsmuwi8J
         yV+k41t81r5y4G9/OwrWsqidadxy9c0tX9s8JWZvKV0BfqhRmrE1SRQ8iBA1B5JauzAJ
         kB9FDbMfpXmc03sDjcPx+ECvEXdpGWxKYPui1n6ZQO6Nl2K3TLSUCKiPSSqQHgTTNaqJ
         RZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674964; x=1781279764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/3nAYsah7ly1t6mdzOaOPfizHpM13bravHKGR/cZgA=;
        b=TBxrNNA05PMKNaRLxDG9sJl7pUSZU3A4RZndxajj7g03W/XHAMJtn3C8xuWMvX1qgf
         zWnTuSXcvKH80LqU5nINMziBmvP9JkQyuImAFHKPyLshidi3yknwhPXaBZr8pQjSGOiA
         uFRl5I0z5DvQWyweXrsDznuzfF28LqrOsq3Tmxt8S1NMxKK2HRFBqQ8VNL3cIUkfCtbV
         6z5G0k2dpyxKkGqa1RbcKB/0Q7JIyN3rr2V1lkbQX+/rPFnhFx2u7YdO9SxPtIhAu84N
         udann6cQOQQGloPfcEtjIIzx183usei/9wPs8dP7ItGIjShuNfORDQHPfvPUYjQrQQfe
         yF3w==
X-Gm-Message-State: AOJu0YyGNsGL5Ljf/4y2ImW/5+4WsneewjVCdDJjNvdG8XY+Z9X99pYo
	GxMKR1N26ESa9TyRWU0jQ4dMBy1OuHFClCf7En/0oOo5ZWfAGOOT/iBOUzByaDj6/dbx/Y3PfdI
	QxFwMFoxXrcQQ7MRDpfwACMEW8xvlyyYZzw==
X-Gm-Gg: Acq92OG8kkFuXSsWHKYXlJBRWIxxI5DcGXluBW9k9cWt1gCvSdQejDI2JJeEk2JyEXw
	0MUVkFMVPzYBPC8nB+XOdO/KzFEHNWewk38CSuPLvC6AO8AVUe+fmjYTOY8ozGYhm6OwexCrEY6
	v/XWqG9HuxXRg5AeN5J7y/HauzCP9IJUUT7PkeqcIMyYH6yrP2HXpTTq/Csxg8yC+/7beGDp17K
	ea1+xfww5Aw3GEAjd3ndYO1Z+quL7me61enzc18+3g/Ijjx5H5gkGivRiBW+3z6NMso3N4LsB6f
	Yb35Y6zfRXB0NMsKHg==
X-Received: by 2002:a05:6a21:4613:b0:3b4:bdd5:2f8 with SMTP id
 adf61e73a8af0-3b4cd041d4fmr4566338637.38.1780674963855; Fri, 05 Jun 2026
 08:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605140203.76848-1-cgoettsche@seltendoof.de> <20260605140203.76848-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 11:55:52 -0400
X-Gm-Features: AVHnY4INK26UmcyADKPhpB2Vc3Ev2qzgcOCwKzEzcp9guBOe1VOfjvOptBPXVdQ
Message-ID: <CAEjxPJ5FRx3-TpkEqiBEU6+bpWSOfeWETosm8XNPfLYCWUiEKA@mail.gmail.com>
Subject: Re: [PATCH 4/4] libselinux: validate netlink message length before
 accessing payload
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> avc_netlink_process() cast NLMSG_DATA(nlh) to selnl_msg_setenforce,
> selnl_msg_policyload or nlmsgerr and dereferenced it without checking
> that nlmsg_len was large enough to contain that payload.  A short
> message would lead to reading past the received data (into the
> uninitialized remainder of the stack receive buffer).
>
> The SELinux netlink socket only accepts messages from the kernel
> (avc_netlink_receive() rejects packets whose source pid is non-zero),
> so this is not a reachable vulnerability, but the payload size should
> be validated as defense in depth before being trusted.
>
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/avc_internal.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.=
c
> index 41257ee6..ec19010a 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -204,7 +204,15 @@ static int avc_netlink_process(void *buf)
>
>         switch (nlh->nlmsg_type) {
>         case NLMSG_ERROR: {
> -               struct nlmsgerr *err =3D NLMSG_DATA(nlh);
> +               struct nlmsgerr *err;
> +
> +               if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*err))) {
> +                       avc_log(SELINUX_WARNING,
> +                               "%s:  warning: truncated netlink message\=
n",
> +                               avc_prefix);
> +                       return -1;
> +               }
> +               err =3D NLMSG_DATA(nlh);
>
>                 /* Netlink ack */
>                 if (err->error =3D=3D 0)
> @@ -217,7 +225,15 @@ static int avc_netlink_process(void *buf)
>         }
>
>         case SELNL_MSG_SETENFORCE: {
> -               struct selnl_msg_setenforce *msg =3D NLMSG_DATA(nlh);
> +               struct selnl_msg_setenforce *msg;
> +
> +               if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*msg))) {
> +                       avc_log(SELINUX_WARNING,
> +                               "%s:  warning: truncated netlink message\=
n",
> +                               avc_prefix);
> +                       return -1;
> +               }
> +               msg =3D NLMSG_DATA(nlh);
>                 rc =3D avc_process_setenforce(!!msg->val);
>                 if (rc < 0)
>                         return rc;
> @@ -225,7 +241,15 @@ static int avc_netlink_process(void *buf)
>         }
>
>         case SELNL_MSG_POLICYLOAD: {
> -               struct selnl_msg_policyload *msg =3D NLMSG_DATA(nlh);
> +               struct selnl_msg_policyload *msg;
> +
> +               if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*msg))) {
> +                       avc_log(SELINUX_WARNING,
> +                               "%s:  warning: truncated netlink message\=
n",
> +                               avc_prefix);
> +                       return -1;
> +               }
> +               msg =3D NLMSG_DATA(nlh);
>                 rc =3D avc_process_policyload(msg->seqno);
>                 if (rc < 0)
>                         return rc;
> --
> 2.53.0
>
>
