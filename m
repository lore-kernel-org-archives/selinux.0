Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A70313545
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232684; cv=pass; b=Mao7xoY120615fy0u1WHdt/1NNjxBjlmev17tE0kva0SpJI2R2En+kvjf1JVuT4440SOMsUBO1LfzXQN5OC5NTdqlWzGqhyxsZnx1zv5iUteuugsJ4tq/A9Rp1qRtMXKUtmjGri4WoRU3r1ZBn+B4Tj6mSJWWTRVDveNrx8y1Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232684; c=relaxed/simple;
	bh=f0DxdsgIlsD14OGVNOHmIyKGx7AYcbRXbwDUhC5rq68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6yF3335qfCFFm2g+xqxcA+fJudKrdTPXvxeGZwCZAUolNCm9joZPmzO9d9LnRmKCvYFikAwnVmCW71oOjvM981r6X29tzUb708f7TjiT03Qq2JITP5WeQ4oOH+y+xw4XhEILNUTz0xlmXqiSJAEW1yacO0Xraadw7qBsHRcrrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+KGQ5Jn; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+KGQ5Jn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so222885ad.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782232682; cv=none;
        d=google.com; s=arc-20240605;
        b=Cn3qnwljY0j3dC7o2dshYtxNdFgQAe3cnSrRsEhL6Dc6YzYYp7EmXTGmS8aAJbyR0n
         7kntHaLsV2U08rZri2geHZ1dx4mxjPmJsqVDrGC5RW3A+TlCmiXDdgIVnRHUS6zoaHtB
         DSJoosFQ0hm/CWRDreerzMlBR5j3ZELbD9IqcA98MKLiw74XCX09RQ7IhQUogUT0Dz9k
         g+nKYVKNXDdxVfyEfEQHkP3F1awINKhRYbHPS7lGDKsMLLbp8/glAMXFEsH3HKn9bJn2
         OeiX1oW5Nyn79o531M2/OhOydOhVKBpqFPCAh4bThK0qEmG7kq+WJus2ZaEznL8Mt+bi
         dNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iKwXeRkYAUTKsuzcd9Jh+CgN9lsoE4DfYtditL/k2dM=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=aWegC5rtuf3LL9XVtS+lYVd5lhSe3o2hRjx/Zrw870CcxuUv1JE4W8EOt1VXE4NS77
         /Vg8n6MDU17OSS3gUkP/qm0YVx2efUZHOhQ5suWfSMGCSsVIFaqhfMJR7+2+k2h6V9xo
         j3mWyAgbb6HzJ+codoWIWWG1HHCY0TBE4UaAanz+I8g6kd4u8HQDaH4DILuX8A256UJL
         TlDkwV/2pSybjv8CWATqqe/HOkyzMCc+7R/ByEDJosLzhp7RN2rQCZFt19U9J4vnfcRr
         sWGuhPuUId9c9zpyNz5xSJoZ3xKlj5s7Jp43KvAXOzcVv3i4j+RXdM7W3MkfHJIzHJ7I
         h4Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232682; x=1782837482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKwXeRkYAUTKsuzcd9Jh+CgN9lsoE4DfYtditL/k2dM=;
        b=P+KGQ5JnhMmCSUK2hb7msrreYI+KVN+Zgnl8i6rKS1bht7hNc9BG4+x+mnoIHQexuS
         B7JWfdS4Wt0P3jOG7TyU8BI9NeNGZ6JijQHiGOiIOh8MGu/Ucaoz/7qzPaFsM7YS1SeN
         483M1TJqqEsJn3e8qHRHabdLVoKn7eTixnDdHoHtgqU5NfAKo1/TJZcOjivrHUz3/xZj
         kzJihsmI67UR8LzhVElIbAAKBrJqPFQK2PxtPQcOdpQShKz2OtN1HLKcxOvzrbx5P8Xs
         oOkIFv6RPpfe7x2m3MQ1cqhykVAk7AkeAlP5DHBvgLQFnenokRqLYrYmZVNC8TDhoYTu
         xjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232682; x=1782837482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKwXeRkYAUTKsuzcd9Jh+CgN9lsoE4DfYtditL/k2dM=;
        b=BVOZARxYvIEo72gscBH0IBwiVnX7SsU7DE26+TMyALiXrUBQQ6VrbeLas1i1k7vgxM
         c4KnjDrv7lsBlDN6Q08ldFAX3WuBUA1Yn3SyLWft6v+Lg9s33is69DVAg9IEkbPzlAVU
         tlEQfbzVHkKSJez0SCeg5ynTBWKkqcStPiUFYfzfuqB5JME8m5dY09jzxGuqkzdudbA/
         ACfSQa+CWoSBh+7k4durBuDLslm/NpZsUASySXUrjOl+dQuNS0+ZpDmXeNkE8B4cIGQv
         CyqQqWbYAZhchM+1X8MaSepNgMrniGWwnDXGBbO5qjJFMLQsknb4CisCNYJgSpPY6xAd
         TJPg==
X-Gm-Message-State: AOJu0YxXb5TzFPWawYOF/VLZIxCBMeAVFK9f+wfl48W7KX0kNsQMihGL
	cHCHfQfLmOVuKFKvcUf+3bLQLBrfnZpBygeDI00HtwOa51RJMsaPXPJeRdT0jUUdkCjTfama29/
	HaMAkBftauxBws9G0/WpntJVOlzzydo5RMvey
X-Gm-Gg: AfdE7cm8Dig9JAwk6Z79qf/MuQc/1Pj8ydrmjf/uQso5K6t0yrHCVeqjVaMZHnptbHR
	wrmovvOFTqGHue1WdZt26rs+3/tJL+D0rxRNpZXIrF3OYiC65R4DKElNCBLl1dH7sZwi1MAgxV+
	Gk68nAIAhMmU+Gtdlsdsa47SIOEIPsIv3Pf6h79x05/BwI8Jt9lWka0/zmlOlp2eKfqMdG2tIgp
	NtjNgisf5OBAnYZbd89MYBZ9Yu5o75YumOgIieomDlnOhY8LKpBFS+Z/1+cIr75CSoRv6tzm16D
	5vRzEkE=
X-Received: by 2002:a17:903:24c:b0:2c0:a711:539 with SMTP id
 d9443c01a7336-2c7422c36e1mr162705255ad.5.1782232682399; Tue, 23 Jun 2026
 09:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de> <20260623141023.114173-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260623141023.114173-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:37:51 -0400
X-Gm-Features: AVVi8CcaX8oL0Ad7v88Vfb3fdckrMHQoDDLsm3D76Tg55aH5ARbFUc_vqB6FBbs
Message-ID: <CAEjxPJ4Lm8FQshMh6n2vWKKdiq3PUjNp_LRnK_oGN=4mRxbZJA@mail.gmail.com>
Subject: Re: [PATCH 1/5] newrole: fix minor leaks and uninitialized status
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:10=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Free duplicate PAM service-name entries in process_pam_config() instead
> of leaking them, free old_context in the parent branch before exiting,
> and initialize the wait() status variable to 0 so WIFEXITED/WEXITSTATUS
> are not applied to an indeterminate value when wait() is not reached.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/newrole/newrole.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 8f75706e..960c8875 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -280,6 +280,11 @@ static int process_pam_config(FILE *cfg)
>                                 _("newrole: service name configuration ha=
shtable overflow\n"));
>                         goto err;
>                 }
> +               if (ret !=3D HASHTAB_SUCCESS) {
> +                       /* duplicate entry: hashtab kept the first, free =
this one */
> +                       free(app);
> +                       free(service);
> +               }
>         }
>
>         free(line_buf);
> @@ -1208,7 +1213,7 @@ int main(int argc, char *argv[])
>                  */
>                 pid_t pid;
>                 int exit_code =3D 0;
> -               int status;
> +               int status =3D 0;
>
>                 do {
>                         pid =3D wait(&status);
> @@ -1224,6 +1229,7 @@ int main(int argc, char *argv[])
>                 }
>                 freecon(tty_context);
>                 freecon(new_tty_context);
> +               freecon(old_context);
>                 if (close(fd)) {
>                         fprintf(stderr, _("Failed to close tty properly\n=
"));
>                         exit_code =3D -1;
> --
> 2.53.0
>
>
