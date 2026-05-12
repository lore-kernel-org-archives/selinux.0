Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AE36404B
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597663; cv=pass; b=R9OtEOD2Xh74VuqgKy82E+a7OkUFZvUoihp8f1TRR0PZFfOPGrMZ1I1tfpTKn695mKvPtmr/nfDbDz4/TXaPBkSYdzZBtDwoQiRrPUViVISsbVeQR0bJWqU4Ck75nmisrv4jUDXtvqtVAmk8trRidqSQXsHVEfZs5UHbk1FjNHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597663; c=relaxed/simple;
	bh=OTJ8K3hSgrfBua71SzyaGPqhkYKj3U9g8BUAk+Qj0ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYQjYlFxnJ9m1oZgcn6N9gE0xHMN9GfBszHCyaNNIOMorLOsYCuCvIyAyd6yAsocNl5OXpiWNkc9YKYCh9T/tZ0KFXvQw+FX6mjyXWPhBxWpuRguOwDxWXgWeePOYDB5NPpYEf3gpYL6tjLNkyP+XISyFFW0PF+zBRyhBRQ0qaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVwdUllE; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVwdUllE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b9e9a6802aso22920575ad.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 07:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778597662; cv=none;
        d=google.com; s=arc-20240605;
        b=VU8dT/36kAr1Py4UM2G3IamNSB0Sm04KWaWtyfL0AesfCVaka/1c2CHadlsBoMXt0e
         MO1/KVwtv9bkMe0ITR+9HopfpqYMdkiKgE03LccyTUXTjVcW/DBIlyYAJzpoH8u94WLD
         iKdu9KUqE69DmTNeyRKiddT5XrLfJIVZoHRS3XUeOWz81gwar9eA/tHQdv4vDXh1rj4f
         trPQLehyGV7tsN94MthfswJvA7bxMoDXVXT9mv8nhfsuF8AYR1qB4C/tOnrAqwhN5z5f
         gTOX+4URbAMOEMjB+VZZg91BJ77XMA3uOtYLeL1srK5rJqHlleZL/fwBEXVunxvzv5kZ
         JZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7qOY0KeihtAuhtfC4zxjw27Z5V/MXAj6IDje/vnwN9w=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=JG891x5UgOf+VrgcK5rUrGgNu7w/CyHKLGLyv0sOrNed/NXigOrqifZ+dakP5KeVsc
         Ev27L30EFScKFZg/v8nSdUUrFuka6yM/aSadDdYnUdSufEcN1RJMxyIchB3f2DlsImgZ
         lnPS4Qsin2lcUyIMKkcx4mr0k7goUCZ7yo1SuNk572PwrVDAMYn5Cqkkqguio+wi6WbB
         aJsGhMNVKEnMOw9oPs93waVMCx2Kx1f7x2Uoy2EWL3NtYzdgvqVUbPgj4UoRekNjkVUL
         5DNpKTtgYqx3BV4PX8eBmvKLdTlyBCNJzVYCoaqSffAzWhdY+Jz3CEAz+p0dRl2Us7FA
         Mucw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597662; x=1779202462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qOY0KeihtAuhtfC4zxjw27Z5V/MXAj6IDje/vnwN9w=;
        b=cVwdUllEJ6HKcLzlYW9w6l3fF17DCmF4ZFZBGBPPviM6HwiyWgwUbMSwzFsG780PA8
         2Oeub0+XVURa52RHWiahbpPCz9nxnNM2OAF4jtHI6xZXGrIeFDFmVdk88VWPSJXCHgDi
         XIpqcjlT59CRoUimlzA/nkYNtj3eqsZtSRLDIif/t38VvBM8PGAwTd61F5n781gX9Ygo
         I/FzRkkIhS6vuaWuoaO9CvAb1Yn2mHhjI/RdFdDIynL8ghAje4CpT6tOEEyw/ORYXHhN
         Yh/vCqrFg0ynhiYCy71Hy9CvdHh9WdElITcO96CexVXjNrRuYAYMs+kFfwvTt/xY1ISQ
         IPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597662; x=1779202462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7qOY0KeihtAuhtfC4zxjw27Z5V/MXAj6IDje/vnwN9w=;
        b=lwk0QYVkvOg90vU/3Hp1NtY+0oDCcoMyOc9Jqn6jQVK96KfddyUHZZ4Pau7svtH5EX
         ZLMLiMF+lwvnpbK0ok/hsTSd5JR1pxjIgz05Ff5OjMjKVDpvVS8vZ/YxWx1mP1VN/v4+
         S8WoqunJv/sKB4/sIQ6lwJmiZAwiM3nm/x2gMCv8vS6OIZP/WXKm/C2A5AK+1MsCwXW4
         inX1ZvPryDU36CyA9omJY0LsTTW7u+InKphvTVpYke3CCEvpRVlIUDHBD/N5Xjs/6pyr
         AwLdNAAEKY1hLTB5fzBGmZXkN1orbDniCGcJpihZ9sK9zVEOiaP8a8zhAUXmNWFptlLW
         0Udg==
X-Gm-Message-State: AOJu0YxymB6BmHbdqN13C+uWy4cqa8vFsw0OiixlMh0RHD/2F+nZKCos
	LmXR9j8p4m8lWDQvLaXB1QuxYKIPMGxwKF+cBQURFYLTClp2vrbM8qbESZg8WORjLFNXkdahDGa
	K1QlrigAiGsDH+T2P9dh8ndjPy3eLWFAZ3Ft5
X-Gm-Gg: Acq92OE54xaz9uzFGvgobPpOpwL5Qo2nOAqyAPE8l+ow/e20GW67Tq/9WO42IHrnRRu
	5EYEcGfXCUDQh6XnVwYeMgTDw/yGnSYxx33Kr71Q/OzAbEtbABaEwdd65zGxBMYnXDetAWasTwf
	OBubI0bQh7XnPOdhGEIAkBSg2M52/Zenlz8YimV7dhlI/vpZ9XVrQKFpbP2HKsFgBfEWRBZ3agh
	kcPwUkLFFG2QqV89Ue8u1eJN2tXN2E0MQ9LdQI+l+7lgAsNLmhbezXrWc7IEnhE+87IperFJGCl
	KvaD7gs=
X-Received: by 2002:a17:902:da84:b0:2b4:5c20:ec7 with SMTP id
 d9443c01a7336-2baf0e8709cmr195950705ad.41.1778597661724; Tue, 12 May 2026
 07:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407054003.801744-1-lautrbach@redhat.com> <20260407054003.801744-2-lautrbach@redhat.com>
In-Reply-To: <20260407054003.801744-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 10:54:09 -0400
X-Gm-Features: AVHnY4IePL6v_YIhrLPmT7c8R0CDJmBpsW3HFWWtaa-pfuMkho9H81i-Z-qslTs
Message-ID: <CAEjxPJ7LLHO+t7mUML7s8+w3fn8PuO5RNBh+RX7dBoxOQngGBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] restorecond.service: Use Type=simple
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:42=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> There's a race condition when daemon() in parent process immediately
> exits while pid file is not created or updated. Using Type=3Dforking it
> can confuse systemd which tries to open non-existing pid file. It's
> better to run restocond in foreground and use Type=3Dsimple
>
> Fixes:
>
>     openat(80</run>, "restorecond.pid", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_P=
ATH) =3D -1 ENOENT (No such file or directory) <0.000006>
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  restorecond/restorecond.service | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/restorecond/restorecond.service b/restorecond/restorecond.se=
rvice
> index 0e4ea72d08ae..56f970707d93 100644
> --- a/restorecond/restorecond.service
> +++ b/restorecond/restorecond.service
> @@ -5,9 +5,8 @@ ConditionPathExists=3D/etc/selinux/restorecond.conf
>  ConditionSecurity=3Dselinux
>
>  [Service]
> -Type=3Dforking
> -ExecStart=3D/usr/sbin/restorecond
> -PIDFile=3D/run/restorecond.pid
> +Type=3Dsimple
> +ExecStart=3D/usr/sbin/restorecond -F
>
>  [Install]
>  WantedBy=3Dmulti-user.target
> --
> 2.53.0
>
>
