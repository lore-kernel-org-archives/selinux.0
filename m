Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB33630A9
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028027; cv=pass; b=sBxJDP8ZPsz7mmd0kyUXI4KZa8yot5vKRQBidfjipaEqDu3F49Wxm/i5r1o8HKqC+OiUJCmnJ7WLmK6I0wDkGgriIjwVU6048V12FJmCxDRs+YmmDoURTCGYBLo6yxH3mT5lT3dcZFqgzVhhkEEMdyC0nYwGfHbLhqKppi6/oeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028027; c=relaxed/simple;
	bh=apb/SVoIIF7QtpicP77A4nTKrq1sNqD0F9wh03XNYMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKh8mCPcziCg5GLaGJ/5Xm836Prg2KH6fLAVRr8Qa3mmazKr/gqPMEPm20KcCp0CSMLnjMxJ+EZtCijhgFH4y9LdSblaBJwjcYbScl1CWrZj6Q/XYu3/y5mmlybcFbUgckYu0AOzNwh+Shy7fVUValeKgxMC1ogUzEuYaKxEo0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1VuJz06; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1VuJz06"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa5ce4904eso6137745e87.3
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 11:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781028024; cv=none;
        d=google.com; s=arc-20240605;
        b=AHPtbp7+azwiNjFQJThJLA60N4P9Nlz6NVOoadFj40Zjm+a2cz3LjYEMBDsjmLSeQp
         5ByBpznVjx4fhaz5x5o7S2xrShzA5chRE9k8wO8gadZWuVkq3XxdX/biKEdba/Hyjpq6
         gJ7oGTJeBIrpitQ7dtHDR/jRzsd6pURN5umCmjhbGdorsQOCQWnCF6rurXRi7UbVIjfr
         9NzqjJ/vmbT2YCdwx8YafxM1iEIKjx8BcDn/C8SSNfTTZ2svcbkEVpgzLpapNSgvfsLV
         JPTKoGbu0F94W9lGG21GJ4FmHljf+GmFq/yvtRN5Gxx2TrIRUOxrPQ5PXzI+1UN3vjdb
         gBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YzdNDTl0+jTae3I9m6+tPyjv8CyPh0TlRcegwBdmdRw=;
        fh=O5eaInpEYMH3sq23C/QESel+JOHLfHMFMQUnKM5jr6Y=;
        b=NaT/9zEz1zWulO0L2awhCuXRyb9kOXccK6OuqtmUzNahhpjiM/ctpMNfG7AR4HC1jd
         P4ybreJsALZ69GuYBVPET5gu90yUvuIG82oang1j05bcupe8ZCV7aQtAxDya8ndq/rQa
         HF8zJoWICfMle8PJssVrqDJmZLDrzcY6vgmvr2xwCYt1vWw99RFgUQ7AfcVTZ7dEuqMg
         nzB7d2IVS2n4ZuNHmgwH7SuquEAnDOm01NxjnuIdL6LRcZd7uUtaadBYuQ2ZVRYzpysM
         oE0ZErqlxU1sMi6p9pqCNBXxKYcqc57Kx30OOdm4eIWeELtIYJE4APsgqM0WFJXsUDrg
         uykQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028024; x=1781632824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzdNDTl0+jTae3I9m6+tPyjv8CyPh0TlRcegwBdmdRw=;
        b=l1VuJz06bkSkUnfuf8yfaeVoYGgq/4zA7SsAEvPDGnAh3jH3DHfqEyZyrsNCNZC0d2
         JSLmR0L7hnpIe+BtN2zZ9/Gmsrm0PknRweItTMoS+tojPcgxp49zj3anvotKY/yGMJNp
         4P3otVZe9dxk0/WlKCaF6GY2dlLOKVwyXBGobCl4AvMYzpu76K1H3VtmMMgPqALC3T4O
         QkBXk5gIV2aetBws/EleYbLEiqRhifUxnx3hVUlMVNgus52N40mtTDJu9NdDegCcPkxw
         uB67ZgdJnMleoPc4BF+h69CHk4erPtEIYT5CMAvYSMqW3yGG1Unpqdo4SWmYSSdoLEtW
         ewEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028024; x=1781632824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzdNDTl0+jTae3I9m6+tPyjv8CyPh0TlRcegwBdmdRw=;
        b=JENwIB2p+Ij8lIfDjVMjtPVdrjD/Ud8ZOcvYtG3kjdE5mdySIW9xOs4GAbhY7l0bbX
         99ulLlF6JtxDbGXEj/q22zweUSJN3hyaMgdaWJqAwfkzuPUvzd+/IVMyjcUrWjzvNVZ/
         yVt4TxRZXrFb8x82ittabVPqa8/jMRmGmdgRsnO8mncYM7MQkJue/6uLe2NTB0Ol3mG/
         be0LSZgqqZvHmE55SGYxcWdY/Q1ON+0xTWfGEiAHnKOdympePx6tfrUUnJVMHvABQlzL
         XBxs0kBZFuB1oF+8US5LAY36D2TUjD61dCnYdoqbAB3gaME0JFE41ycgVGsZJHW3CdhH
         1bmg==
X-Gm-Message-State: AOJu0YyoSerGCVAC5wMnUXjW37Uy6WLFyZiK+/UEFsJA9idTEkvaFygc
	zuGbowT5ZaElXYvMfjEcbcqaDZ1SaJ5bcSx1weFkYTjW+5e3yEHROH7ZzIsXeii7FMmsUeb6IY6
	bmnFpjH1TKwpZ+U4ivaxHmRb85IBn6Qk=
X-Gm-Gg: Acq92OF4EgRccdBUEy0k9XEBG9wCxaN1tS0DVEQtFkIsTP8tUHDd859p07cCwundxta
	B9s9Z/pDAe/QKmfZ4ENpkPl/xPanV6DBJ+4rH7IiNqEtxVj6xTgr6LKkTsKAAS2/zRLHB+TpSnD
	ll9Ahylh2yfYXoTzACFoakQCdILpSQs5tgOgZBbrhRIWPsXZYVYijR5aYIhnmB1cIzdJq8claLr
	reW4KBeenYOreT6wwRfBAF1BdBprGomBnJvd/qEENimclH9oIkhxPQM8EHUhiGQSddbY+TlWGhD
	xcofzAiMFarawlk=
X-Received: by 2002:a05:6512:3b12:b0:5a7:4a60:1454 with SMTP id
 2adb3069b0e04-5aa87b88cd6mr6382748e87.33.1781028023944; Tue, 09 Jun 2026
 11:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609174800.6715-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260609174800.6715-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 9 Jun 2026 14:00:11 -0400
X-Gm-Features: AVVi8Cc12ayEFkAX7_7vsWaVirN8Uw39OoBXH7gDf5Z4prfUf-6ofNXPyvYNgCM
Message-ID: <CAP+JOzQm9q4AxWSJq4=e4L4m4C=2Mbmp2FT9rpjdnur4Up-t3Q@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: Do not clobber errno of the world
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	=?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:48=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
>
> libselinux clobbers errno of all consumers (systemd, sshd you name it)
> because its constructors do not properly save and restore errno.
> The following program demonstrates it.
>
> int main(void)
> {
>         assert(errno =3D=3D 0);
>         /* Just a test, it doesn't matter already clobbered */
>         if(is_selinux_enabled() < 0) {
>                 perror("not enabled");
>                 return 1;
>         }
> }
>
> if any function sets errno, it is not switched back to the original
> value and standards DO NOT require errno to the set to zero before
> entering main
>
> Signed-off-by: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> v3 applies make format.
>
>  libselinux/src/init.c             | 1 +
>  libselinux/src/selinux_internal.h | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index 499e4e44..abed3088 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -145,6 +145,7 @@ void set_selinuxmnt(const char *mnt)
>  static void init_lib(void) __attribute__((constructor));
>  static void init_lib(void)
>  {
> +       SELINUX_PROTECT_ERRNO;
>         selinux_page_size =3D sysconf(_SC_PAGE_SIZE);
>         init_selinuxmnt();
>  #ifndef ANDROID
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 6089463d..ce04b128 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -147,4 +147,13 @@ static inline void fclose_errno_safe(FILE *stream)
>
>  #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
>
> +static inline void selinux_reset_errno(int *saved_errno)
> +{
> +       errno =3D *saved_errno;
> +}
> +
> +#define SELINUX_PROTECT_ERRNO                             \
> +       __attribute__((__cleanup__(selinux_reset_errno))) \
> +       __attribute__((__unused__)) int _saved_errno =3D errno
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> --
> 2.54.0
>
