Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA43FE64A
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535514; cv=pass; b=F0bjkH/CPmdAgxsn0AUysZWI5Ssr8Cfwy06PUnprBXXE2vSKMgxbYnDGboejTXIc/qB5e/B5iwHhLautfYplGwLMvA4Qbn42/smhX3w8/qWOGYDrsjSBL57LcBlljjA4UVZ20WOLrrgmZo3x8jK/NOkppnWogGPhkRXmQRx5Isg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535514; c=relaxed/simple;
	bh=hYcVjbuXd+nUgARhGd7q1CzuhAUk5I0KIqsrPGWIXiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK6nHMpMc7ex3JbCrWV5IGS3S9q0O+uPnhse0M+ZbpyYZIM+i+hHFucC+FastScIEqN13AiWobfvGKevM+hBvRe9ABma5BMghfsZMUOLvGglwNzdlCURbR4Mhnn/bJGRaXWiV5y2yCZI79wEz01ig/sN/hKKb1bGJayd3FaQvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF7/J5xG; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF7/J5xG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c40397e746so20362355ad.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535511; cv=none;
        d=google.com; s=arc-20240605;
        b=lJvvh5XM21u6OVanDPIyDzWI9q/phjAQp98RBHkJLcrCCDiS4ULQt4Ev+ouqwLrkzy
         GLNQEPRJZLFvMh4OkzLTJZC7R2sZSQIpPffxufzsgZaz8FUEpn/2EnHr2HYe0YmaHxqp
         fAWVNIjL329lRAzyxB6iMHhxhWoTNm4gZsz54LeJl/hzKyS6fKlVfpzypCYxqYinGMKA
         6KEblKZWRvFZCAzK9v+xRZ+pGzrurN3g25edqLdJ74+5NPTxGSlwv/M6wXjEpxaWFGYv
         fhWnTp7JF1+vP7yJTywFPbArHRHaqsBvmxo9uDod0fewcEbr3d/qWPf2h24mPm67ZRmD
         UkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zYSos4DlkODKkuCbUV26o2yavWJkcJJUcJYT3ne78DU=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=I6DnpK7VXIplEfpUPE5Ig4bE6l79Mro9O78D8g9x1CuU9MOxIvuRw/NG8ObSIWBXrU
         bW/I+RVDhtUU5G+YbPLJefZp6DJzH93mSDgrLH2LZzAQzgekOgrvf8B6BCyg7DZONYXH
         Z0ZapOs73mqWaQVROysqMmzdQ5vFgyfnMGLiTkt2lWf8Bp2CvT8vd2oBLVTeclYxSwVV
         5VAlPp0kwQOZQJ2PeuYXxcpCyANmyl51uTsjPPn5e7VnRTFk+tHReRHgFgAwsMx8Se1a
         AYnRqQSmlgt3Q6WdfvqwNFtaBEFtHFybHwuPndKV4CRyNBSMiOJZeKaFQdW6UMLZBQ+N
         wqQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535511; x=1782140311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYSos4DlkODKkuCbUV26o2yavWJkcJJUcJYT3ne78DU=;
        b=fF7/J5xGbo5o/W/vcB+g4arrzw5t72IDc/KMlXnJxIXHOHtUAqW9Te2Snre4Yu9O8F
         U6b8+rcdfrqjd1DptTQQoStcnEsLAQEBXigkpqSqQhOgeCZReyygMa4yGV+WlgmbMsbr
         RyR0ycTi+2W0z4RxjH+22Gc9LKenbgjQHcst8WAVH2MzW4hE0wq1FR3AJvk+1kV0AZlx
         PcjWuGPDlrOGWaaM38lLQjLpQzGhsQBu16y8qPFGT8leEnJGIP8iwgPvBdVMGz0tFgv/
         /mEmZ7mx2ekQcOLc7gigWGaBI1V5fZwKlrNxt78aue1vv2sR15hMKPke1vNWQ+4PMvuO
         Vn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535511; x=1782140311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYSos4DlkODKkuCbUV26o2yavWJkcJJUcJYT3ne78DU=;
        b=NpUbHtQFBYUgI7pE7+nCXzlFi+aDBamPUUXD94NGsPSlTQIVZF+Iy0zy7jD/sIMG9J
         z1IAb9oICu1v2dlQDWejRaiyoLtJUYd/4rFh4KuciVdyqbTkkZI52tV4OO3FPJmTDrTw
         sOgppwyIuYDsBzL/jIyiNWYZZy0Di8WC/vCLMSjjDa2PqJEBbApwYE/YGPOnSKONqPtT
         LLCTyhXVIKn0HTyeSQL/5rX2yxw3LpGjIIVHAq3zgA4h9xVs4BUl86P1cy9kZKMS2Yn8
         OonRG3gl8Fhz5QJYH0Hdb2aE+cuvzAw/uOr++ZnLT1MqVgPj9uZe2WLN2Q+ruEwt+Th1
         tUcQ==
X-Gm-Message-State: AOJu0YzSF+dXAATtEAcKagpmL7596l+AwmBlLJmdvcK4xmMvvhAu5IFb
	iFkogUJiqL2BXJioWxIjzafmyoelM6g5RJQEi1Nbi7D8OkYhcx7SReWaX5Zev011WqLyp7HArUm
	gjJeiDbZUjC98yDuKnJ12fpmmT/pNSWU=
X-Gm-Gg: Acq92OHt8dt4hvvXTkHYtgwWP9+9wbwJQOohDnoBuz4+Y+RkCO+HquJO09c6J1bcKLd
	TCNk1sFWhO9JnYOJkDHMNL4xbR5v13PF9sDM1rvha0eNEk31t7QiRuq4nK0R6QyKO/Yq5nUMmBB
	uJvluyY2V9kEnUwYJG8iLNyYpJpda/bK99eND3VyqardooE84bz9aA3Aa6ofQhidCLkuG/biz/L
	S4ti/0ThXUUkns7EDqyxuM/DJ9DwUK1eSizAVr7L3MWwVUwoUKsfUsWgYztg0R/n4RIdf6SYIAs
	zYb9IQM=
X-Received: by 2002:a17:903:41cb:b0:2c2:8659:da43 with SMTP id
 d9443c01a7336-2c410411a71mr167374955ad.4.1781535511217; Mon, 15 Jun 2026
 07:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614165422.25058-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614165422.25058-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:58:20 -0400
X-Gm-Features: AVVi8CeC323gQzzAgFnySC-KEx1dWxF5TDBcElGlWq8Lku1vPNM723uMWO6x31Y
Message-ID: <CAEjxPJ5jQ0JeswEw2YA=frdw+1X5i_eJyVEAfpWT8Jx3yLSdMA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: use null character in a string
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 12:54=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/run_init/run_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_in=
it/run_init.c
> index f304c4f3..bb9593ad 100644
> --- a/policycoreutils/run_init/run_init.c
> +++ b/policycoreutils/run_init/run_init.c
> @@ -317,7 +317,7 @@ static int get_init_context(char **context)
>
>                 buf_len =3D strlen(buf);
>                 if (buf[buf_len - 1] =3D=3D '\n')
> -                       buf[buf_len - 1] =3D 0;
> +                       buf[buf_len - 1] =3D '\0';
>
>                 bufp =3D buf;
>                 while (*bufp && isspace(*bufp))
> --
> 2.54.0
>
>
