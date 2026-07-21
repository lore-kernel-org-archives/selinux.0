Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815331715F
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638254; cv=pass; b=et+O0jiNp+SK0YrWQr4+jBlywJKEMaOPYySWhLmEKMW4dHDevn72E0KOdi5KsNst3/Vqk2z1ktRhReWdTiF0MkVfs8kNdcXl2FQEwYdnmrPSGDkZGSNj8D3yVqqSvqL4HjvP2HSTzTwl8JYwnm5no8Ye/q7F64kDUKE9aGNHXMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638254; c=relaxed/simple;
	bh=g/YSpX3gevB9KERm6IG3WOGH6/rGUTCYptVtdE7yNWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOc0EttrYcUTI2KqqPcxySCf+sQakle+SuSCGyROBPgfbCRiDuB2yz4CdXdfqyhPhQ0m/sUbU/tEFbrorznaIwtNRI9nQbopPuwZbJLZb25EzuyFixQBkox8hqoQv0s4CQkC0gKtynqAc6R+clabFbqfbbMOesrBdfEoFvsDtwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOl3mdFl; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOl3mdFl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9aea40d799so3840476a12.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638253; cv=none;
        d=google.com; s=arc-20260327;
        b=aNDNqPg2x6WkTEPfe12Lh2r25iNxllhB2J69dIte5JvUt+67seM4J0aEHNbyxfyJQ1
         klu3HFr+c79Lbls9ehsQNbkAmLqYTBehPxNyewbtdEP3m0e/FPoJNGiw1CUcGnjU0f0M
         xXXC3BoMv5gxpGU7yjp0V5+KMZYnt8c5YBmXPX2xPM3Hl0rza7uqRamAmAdclR6xlzbV
         gLF8zJqavRwUM4ChODiTRsaIkqdQWEoQ0RIiBn1lG8DDfBRwOtxfSGVx2y7cRbB/rKEe
         XKHPbzOUpB43LP4+qm4ez+I4HtoxHco7yEzDBc32WdEJNsji5wStqqRt663ik3Jzhkun
         p3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XYBSdJTXqf/uBxA/QpIcNOwNQfS1jkvHH3k3N8No4rg=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=lwc+HAAIawolne/LJ/eb/Jh8COyNJAJpp3bDH4+haL4LqhmV1YnSR2n6b0wh0x0wV+
         ZCmyjEAd5EGt5NHZ1Ns4odcAzEgl1wieY5JUxTw3ZIQ3LfJLUX9jZtxaWWyUsLK5z7fw
         Rq0fYKcJPf8M+y/qSKkf3ZM0Bhlpn9Np6U1qDbgeE9o7HZrQpzRdqSq6GZDgLJ7/M+aj
         KCwmOJtZ2uZw05fyTo2GEQVl3IWsXx5D7IzX0VwY9CXs1A/XeCgc6kAlur9Yhi89fvZ+
         FeVPh1McPFwg2dpn1HRMkXA5K/tA4bJDllhdMsa8RYp5540y8NOx8ZRAB8GHrcDWPVJh
         KfXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638253; x=1785243053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XYBSdJTXqf/uBxA/QpIcNOwNQfS1jkvHH3k3N8No4rg=;
        b=iOl3mdFlnZbpZ06ZJfYEI0il4b2wPIsadEc+zUU/ia2sq/62h1sK87jGQon2s3Nklf
         yG71DQh2D9zxedGzBaL+uHwFfNZcVzyV9LaP1+7M1ACTL/Ed33lYz2/Z8S4TkbDwtTCA
         MkR5/gRYcCoEPfHVht4zgAHe+vXP7sMVVvR0ZcJOWEIkN/vUKyvl4Yn4HU9DHUsbdAVm
         vF8VE09Y5pKqRMJV+xJnQN+RmawrL8/OT2Pz0CuXVgY23e2nVwODcscIZ+5y9xyp5jsH
         VJveKKlPB3tPoV0K/TTa4yurZSxfXhZ1s9+XcX1ZkKUn240SJ0zd6HyxbF0hZTg8QgYE
         g9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638253; x=1785243053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYBSdJTXqf/uBxA/QpIcNOwNQfS1jkvHH3k3N8No4rg=;
        b=sZrmyDfdUOYZFMtLXbY9er+/0teyayEQDyVHP3NfGdZOT+Y+1XAJFwE3uDjeIgxqPf
         zdzz+ezkWj/tJVR+LzRgQkrLU/QuBYOn80jjV3C0iSPnwJmjSJMfTJ1y6N4myJ6razWY
         mFQx+/2MASJIkRhQZEK3DryvVeH78PkmPs/OXxOXTXxR5BBTJH+A/PjFrn+XtE8VACFw
         FAZTDq5bccnqGhp5R51apQrZSVaRPXPFRAcvWMwv9OtgDeS6aPftMU+vFv7U/F/N9NYq
         BHF00kemyf5XRurlpYxOXO2FNQx0UZq899t5yC76FUqMzG/yfoEG9is3jd0R/atwa3Kz
         OlDQ==
X-Gm-Message-State: AOJu0YzuYAMUtw2N08H4ZprgY1sCvlIGBGtbKyhx7a97EIo8sxgUc+xO
	ZWkPm1vlE/Xyb890eSuEZLZdTODp3N8186meSGk0ufpxCIGTNszchMfzidfPrlgebB0YnkDwYDN
	EsWYD6Koqvq+tJmYTdBgG4LU8RoioiKLCxQ==
X-Gm-Gg: AfdE7cn/Aox+oZOTf/kLeqt9YBfTrLX9JXgFPER5J1I8X1zvEzt6Bxt58n1p5Rs7YFq
	ys/gwLV/2EwUIJu818+eDiCZrVeBsQL1EEiKlEkhovsfN+EPfFsC06uKuqt9tdE/XLzVnWiJkr2
	g8k85KRcHnoaQmm7GwrUa15guIun8M5Ctg0r4YhOYSjKSsOlAjtT35sQiEyeEW1uSOJe3A8rhVu
	iTEkABwfEJwA/ZmSRjJXsWlR+bPvVWdbYN3iItYYtKuOYMVEJlCKUfczNqRH4oi01mAUBeG
X-Received: by 2002:a05:6a20:734f:b0:3bf:c07b:a9ab with SMTP id
 adf61e73a8af0-3c3ad9dfdecmr20143148637.55.1784638252948; Tue, 21 Jul 2026
 05:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716144905.8874-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716144905.8874-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:50:41 -0400
X-Gm-Features: AUfX_mzlFXsbC_cQgeyc8u4RUcjmXNCDGh3QUjbHZZMXqHxdncVkNhqlq86Jx9c
Message-ID: <CAEjxPJ61+jnsd7L9rMkZPRw5PAfVLFFLgrvSPL08cTJQw2QfyA@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils/semodule_package: report the output
 filename on write errors
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The error message reported argv[1] for the output filename, but this
> may be incorrect depending on option ordering. Use outfile instead.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  semodule-utils/semodule_package/semodule_package.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodul=
e-utils/semodule_package/semodule_package.c
> index fa50a80a..c2bc49fd 100644
> --- a/semodule-utils/semodule_package/semodule_package.c
> +++ b/semodule-utils/semodule_package/semodule_package.c
> @@ -285,7 +285,7 @@ int main(int argc, char **argv)
>         if (sepol_module_package_write(pkg, out)) {
>                 fprintf(stderr,
>                         "%s:  Error while writing module package to %s\n"=
,
> -                       argv[0], argv[1]);
> +                       argv[0], outfile);
>                 goto failure;
>         }
>
> --
> 2.55.0
>
