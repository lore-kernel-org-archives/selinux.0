Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D49481A9C
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040581; cv=pass; b=M+u1GPK7VXqQZ9ASghY8Troaty28w0Isbpeldi5gi8AR8nH6ZOUe5MpJBpRfymSK//VrmnjTZZ4vAm1S5iQyhG5jx0s/+E06DY2WCCxHhf2k/a05G/sa9XtgwN1+seP7pTP0rTp4XDx1i+Y9/gAE3cynKTl1GpOdc6fXe1KVIq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040581; c=relaxed/simple;
	bh=7s9xDDI28ZAwtwY8TqzXj3n1KJGPfvrPqNXhL9VfEsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmXjqph4Y4HQUdlJqaubpzlTpEBAi9zQu/jzYSodg7FSWfI2WGC4YZ4g+f2xGobsMDaL35W5QMHq3TBHQh1olnbnSwFm3CAgBhBFSMEfYH7cHUnlY8GO5EYBWcNiE7i16r5Km9KsxNUO3SzJdUcJcs5jnAGQhaBvBnCYdVM4Qg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC+aWe6Y; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC+aWe6Y"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad4170e8eso52376945ad.3
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 07:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784040577; cv=none;
        d=google.com; s=arc-20260327;
        b=d9AWoU+y8i2G+vz1khv7sZSzFPRjwiSB2awaj08bfzlhsmI9vwBYGi6jMSCUcZ9OWa
         FGfrsDOM48J3rJ5Q9AWSQB77qIQDRB9QL3rw/BkQIjQCu74qTnkacLtiZLQpjA+ytDyS
         fq8C3/xX1u+7CI5CkGaNDHNsiHknYUxixZgzTrpNMtUtQN68vhQX9kftZ//4VvZz+ip5
         wyxwdtEzsMw1zivsePrdCUz4/uQl2NENsKoJcvN6TZkHnqX8jW2KPbObdusF2hu/4CPI
         BTDEB+A9YIoZAgh9wiShkLywpHlwoaAJq3a2XIubQxnUw+TT5kM0Zd42JG1j/nJw9LJX
         N/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bcszBVJZUqAU1fvE6PROGixxtIH/lnJKxsWyGPPLmXo=;
        fh=lljEVFYdfCB3byAKxht8IF+nEoY6w7szJhhpQunOFzM=;
        b=e46PhN72SXv1rYGUiK7VPSLCEJxkYvWbBNX8KtQaUvjr06bdqrimyPrSrzPaIaFvmT
         /heo6spbPAooo2g3udiu89hRN9v3/Stnt0fE8LmnA393mIZb77XLi3jTtWERpjtzIUjl
         dby0iFWjXQmFCgqL4GPJhP4H/kzOnWGITyn57WPBFn9fE1phnBG7xGPs+BSE8Ss7ruLz
         ATLfdkpoj0MPvcd6Uu/hUgAucPtLzdqjdOn39llnhPZY3ADJvlCCHsK+47MmdE5vZEdy
         VJaSbzQrmfBqrTZN5zUr6z/T+wdnqXbEnyCgdI888H4F+ROrCF2pnEYD85qkuQN3yE0p
         YatA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040577; x=1784645377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bcszBVJZUqAU1fvE6PROGixxtIH/lnJKxsWyGPPLmXo=;
        b=XC+aWe6YugP1h8Jm6Y/sPtJ6qQAOX4Rrw13frv7B1G3NwGukKWBC7xFxAT6msl7Fg6
         Pbsc0agl/9aLzJ40kpdtVzsOdOGtn9BXKMUPb7/WFIDUdOtTzmI3ufltckThJHJuELwF
         FkQMCUgAMLpSigOQEHagf2w80eTVRNEbZLLghT5liTypiLUIIcR+xs/Zs1V8OvpUWz1i
         peNzhcYC65+1r50VT5lKCt4W6AOpgzQwSLqiKHkZnzamkj5CKShn1T1jQe1Odofjr23C
         ZVDSggdWW2TxWXRPVaJqacLR4SJukaPVsj5aCCKv92rz4Ul6vddeP/4eeoRXD+oIna6z
         8NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040577; x=1784645377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcszBVJZUqAU1fvE6PROGixxtIH/lnJKxsWyGPPLmXo=;
        b=UjWvMihHiLo142DNgVfgBaf2jhEkLtEvwF8sqoxr2uOsmPR9TD4QhBnVla4ug/OSnD
         Qipq/WDXgt+ZqYFq24c+nFyHFWSN0OCfHIJqMaNbcvh6GSHsQcELGMTkqeV494LccsjC
         QVHv/2DSJ56aKW8EFI1ciASpsuoukWYIDc1B8+66ACisNA+QpURGgo5FSd4Uo2DLtwhG
         fCFCG4dbGuyyivzptUhAXed6/bD5BiLCupCsrzZ0qGx8lReiqtH0ETUnr4r1z2QtNNRs
         wwwq0Q6No27KBYsbV+3a+v04ChNKrd4cTcaDVysHrDoKj6A2ei9wVhuZlF4CbIaydzBZ
         3W3w==
X-Forwarded-Encrypted: i=1; AHgh+RoKDhAHIsWRQdkEKa+NUyZ6pB1lPCPUqtW1HZsR/M2qwc8mg4k4uyIP8S45pn7L8yl2OldXpqs2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FIuflRRpV0V4eOyaOfbqf4hC8HvLzTUZM+gj4V6EEYbRY9ZD
	WKOTrkdER44BPtGIXcDbdpxP7l6THFzghObBpo6n9OaFmlBCa6UbOVEvarI5md5iUrSFJaZ8ppG
	x0V6qOcOt8ekfbWQfqFe3Rbr+hFsT4i0=
X-Gm-Gg: AfdE7ck0EwUQTiMZiAb+gXGZ33fPSIQiOjr8Ir2/pM16WaSZ0v06f4Siz+Xnc3zKFhi
	vOoK6UiIw6fi09Li6vI3UaVeCt2X8wgteohZcsWuwNI/sYWD9sjp2x4nY90g74gvOP86eGOHjOv
	Ms6mwygnud5xEUwDRPc3j81UPunLuf5mHgYPJUM3aa6mvvAoyGXLzWYenRjtEnZ3Pu7XXoweuUX
	8Uk2IeO/CyIXZmsdfBkOcY6FE28WRgr4MoVpctd6zxaz4EXR/SUz5WXPN9Fmb3YzSCglVHk
X-Received: by 2002:a17:903:3904:b0:2c8:25c8:85a6 with SMTP id
 d9443c01a7336-2cef12e9583mr30116265ad.2.1784040576632; Tue, 14 Jul 2026
 07:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alW2ktr8JUVlQNgU@dev>
In-Reply-To: <alW2ktr8JUVlQNgU@dev>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Jul 2026 10:49:25 -0400
X-Gm-Features: AUfX_mzPAhAMy6QeGn5vEUQ6aqd-fn2XJCPUjKdbsXzxznBBTt2hLK3xTMTISTo
Message-ID: <CAEjxPJ4h=O8NbkGLbc8YZEJSVpV=1-gmROG-imfzDVtru4qVNA@mail.gmail.com>
Subject: Re: [PATCH] selinux: compute the IMA configuration settings string
 length once at boot
To: Ian Bridges <icb@fastmail.org>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 12:09=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> selinux_ima_collect_state() builds a string of the current SELinux
> configuration settings. The string lists each setting as a name and
> one digit. The length of the string therefore never changes, but is
> still recomputed on every call.
>
> Add selinux_ima_config_len_init() to compute the length once during
> selinux_init(). Update selinux_ima_collect_state() to use the stored
> length.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Link: https://lore.kernel.org/r/df755e0282dab3b932d19aceab71b7d7@paul-moo=
re.com
> Signed-off-by: Ian Bridges <icb@fastmail.org>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> The produced string is unchanged. selinux_ima_collect_state() now
> depends on selinux_ima_config_len_init() having run. The call sits in
> selinux_init(), as suggested in the review of the seq_buf conversion.
>
> The length computation itself moves verbatim. The strlen() + 1 on
> the string literal could become sizeof(), which counts the
> terminator. That rewrite was left out so the moved block stays
> identical to the applied code.
>
> The patch was tested as follows.
>
> - W=3D1 build of security/selinux with CONFIG_IMA=3Dy, zero warnings.
> - A userspace differential harness compiled the old and the new
>   functions side by side, covering every combination of the settings
>   and the policy capabilities. The outputs were byte identical. The
>   stored length was an exact fit for the produced string in every
>   case, with no overflow and no slack.
>
>  security/selinux/hooks.c       |  3 +++
>  security/selinux/ima.c         | 33 ++++++++++++++++++++++++---------
>  security/selinux/include/ima.h |  4 ++++
>  3 files changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f4a4edbff2bd..1ead2eee1944 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -107,6 +107,7 @@
>  #include "netlabel.h"
>  #include "audit.h"
>  #include "avc_ss.h"
> +#include "ima.h"
>
>  #define SELINUX_INODE_INIT_XATTRS 1
>
> @@ -7856,6 +7857,8 @@ static __init int selinux_init(void)
>
>         hashtab_cache_init();
>
> +       selinux_ima_config_len_init();
> +
>         security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
>                            &selinux_lsmid);
>
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index cb0efa2fc1ad..cda68122e032 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -13,6 +13,27 @@
>  #include "security.h"
>  #include "ima.h"
>
> +static int selinux_ima_config_len __ro_after_init;
> +
> +/*
> + * selinux_ima_config_len_init - Compute the configuration settings stri=
ng length
> + *
> + * The string is fixed text plus one digit per setting, so its length
> + * is known at boot.
> + */
> +void __init selinux_ima_config_len_init(void)
> +{
> +       int buf_len, suffix_len, i;
> +
> +       buf_len =3D strlen("initialized=3D0;enforcing=3D0;checkreqprot=3D=
0;") + 1;
> +       suffix_len =3D strlen("=3D0;");
> +
> +       for (i =3D 0; i < __POLICYDB_CAP_MAX; i++)
> +               buf_len +=3D strlen(selinux_policycap_names[i]) + suffix_=
len;
> +
> +       selinux_ima_config_len =3D buf_len;
> +}
> +
>  /*
>   * selinux_ima_collect_state - Read selinux configuration settings
>   *
> @@ -23,19 +44,13 @@ static char *selinux_ima_collect_state(void)
>  {
>         struct seq_buf s;
>         char *buf;
> -       int buf_len, suffix_len, i;
> +       int i;
>
> -       buf_len =3D strlen("initialized=3D0;enforcing=3D0;checkreqprot=3D=
0;") + 1;
> -       suffix_len =3D strlen("=3D0;");
> -
> -       for (i =3D 0; i < __POLICYDB_CAP_MAX; i++)
> -               buf_len +=3D strlen(selinux_policycap_names[i]) + suffix_=
len;
> -
> -       buf =3D kzalloc(buf_len, GFP_KERNEL);
> +       buf =3D kzalloc(selinux_ima_config_len, GFP_KERNEL);
>         if (!buf)
>                 return NULL;
>
> -       seq_buf_init(&s, buf, buf_len);
> +       seq_buf_init(&s, buf, selinux_ima_config_len);
>
>         seq_buf_printf(&s, "initialized=3D%d;enforcing=3D%d;checkreqprot=
=3D%d;",
>                        selinux_initialized(), enforcing_enabled(),
> diff --git a/security/selinux/include/ima.h b/security/selinux/include/im=
a.h
> index 38ab302f5946..d7d18f030d3d 100644
> --- a/security/selinux/include/ima.h
> +++ b/security/selinux/include/ima.h
> @@ -14,9 +14,13 @@
>  #include "security.h"
>
>  #ifdef CONFIG_IMA
> +void __init selinux_ima_config_len_init(void);
>  extern void selinux_ima_measure_state(void);
>  extern void selinux_ima_measure_state_locked(void);
>  #else
> +static inline void selinux_ima_config_len_init(void)
> +{
> +}
>  static inline void selinux_ima_measure_state(void)
>  {
>  }
> --
> 2.47.3
>
