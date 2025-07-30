Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4023741
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880372; cv=none; b=tnq+uFOWlA1/L75AzsBrdioFQCa2MWoTOC7pshwpE2jXdyDBaDYKyujBdpQAwXWObzG/B6TG1tbQfY54vaBJATJjI+Kb0ZifjBYseGFyG0HI7JvPgysmvNUdiWIrAwXWQW8XjKELky5LSBLGY5INuPYVfXodDTw4qkwZEP9J/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880372; c=relaxed/simple;
	bh=LWIESrSXneP9miNYyYJnrYopTJHon1nwQpHj3e+7XH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2C/b/HQ1yylbx1NzV918v5TMwGPSNkfU5GGDCfsFMUcakQjIK9QAHFeQdJSjBW16pddu9wkkQG17KP9ke3BkUj84VO+C+jz4SGZj+IWl0A40gcV5yOmJhSFKuva5yvTG2QuxC93zGLzrbzdtmqV+voYh6F/j0dVpyNkfJY2NS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJtW4Zm8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJtW4Zm8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f3fe66ebaso757472a91.0
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753880370; x=1754485170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtMno2MVKsPcJAdUGnQiPEfdqYcUniDuiqwjKv+dbk8=;
        b=TJtW4Zm83zYzOU3NNmuaYB1tvrbdcvTeW9SNC3XYt/TlFSpuIsTQM6lvR/ehRdCjV5
         o21X1+dw7kwb6JxdF8jN1p61tGhm5d3LCS0f8J4YZfcYStbj+HxcwUPiiXAHAPEGfGTS
         Ub9MdX6IdJUBIgJutNGQ9zKVQsS5uCKtecrs/rqtcwkLQR2tzAZbHJrou9pZxmaq0Q1D
         NhMc2cA2i6hP3eLboC/Ugw6S0LlUUwRxXVL91MJre1D5f0UOQckz4ErHGG/m1DfxHgUH
         5V/W4cnqQACrt6QskthU/kbWcdNTTQTQc8X4HeFIqdJb5tdVSQkQIC4TwxuiObX3afrX
         Ed1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880370; x=1754485170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtMno2MVKsPcJAdUGnQiPEfdqYcUniDuiqwjKv+dbk8=;
        b=UYOoAVrTGitz3vc0DOPwz1CfIO0/Uitnyt2eJ1rVpef8O5+NtU7KBfATaphaenIGVE
         3bIqBglZB7p6Mrkr8fndIotj8PdtmGmg6+J1zV5uANe43udU2+gmAsVp8ElJ0vPyXh9P
         ZL/dMEvlXpSaXGpSOAVLCLAlH6eK2j2qKg4ADe9uTda/BTBqcy6eCi6Vd8Uy/T4iSfJC
         wzksPxQSRxQ+nGXHVmlRTiQDy+6+vbpSvgIGn3C98+pH0MbMMxwhv3tmxqUIPvNCATVu
         NgkdFn35ODcY1huKT2QoqNcxFQzMsnBRVqoybi+Alzwz+t2pcTB/1PpAjsD107yHK4Xm
         iu2g==
X-Forwarded-Encrypted: i=1; AJvYcCWEnWNZdzJ04cjp+KNH1Js/oiN+CGf4Wyxpmc/yrM5xnTiCoIKscHQ0EHkjd9UKSlo7geaFv+Y/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u4QRdhLBCS9yLZaYAodaFAfoJSZtRJJvZTxr7KJ4cJ2Krk/3
	bygXnqcTo6gVNCz6ngoDMpbNwtOYXctKBl4Fe9d8qIVh+S/JsXQXd9HHLwl8XMbYcTiE3mD9Jpj
	Yhc3sC87xyDsiyODnKha04GcFb9gevfI=
X-Gm-Gg: ASbGncshsocEuCsYWPLGxbNjdQzWGExe7q4g7Pjg4ugaK7Vv8Ul3+l0IR5by9xoDD/X
	l9v+aW6//b/iLMDAhHOj6o+wjjn061kO/rrL76ArkvNBtWVrS/RfBtcOkArbOFZ0WLJcipeHS5T
	a/BCp8UL5Zeok0tNLp+oKI81XiTCR070w0iF8zb1lXJZ+mjN9l8BoEHfrT56uHmKs+aoYuFJgym
	teZWEBVLosoufDYig==
X-Google-Smtp-Source: AGHT+IFxzyGaKQQx/vfmJdj5s/ottFIWgEQP4sWn2aORXqyBkvHwpT+N5OUT/fpMcDJJYniJFZ3CVoO3syvNmTSfwOU=
X-Received: by 2002:a17:90b:3a8a:b0:31e:b772:dfcb with SMTP id
 98e67ed59e1d1-31f28cdb992mr10270621a91.10.1753880369964; Wed, 30 Jul 2025
 05:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82e217c7-7124-4d49-ab98-074a6c2535c9@googlemail.com> <20250730074729.936489-1-nvraxn@gmail.com>
In-Reply-To: <20250730074729.936489-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Jul 2025 08:59:18 -0400
X-Gm-Features: Ac12FXzHetvxjmRWSIYI_h7Z1VBVHLjUT3NDmPHJP932TPER-TlPaxCYsXcGRBE
Message-ID: <CAEjxPJ7m3Mj2NAntf2TUSrostQDmOeBtN4Ja67s5RFCnMXwFwA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: refactor selinux_getenforcemode
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:47=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Invert the check for cfg being a nullptr and early return.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_config.c | 75 ++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 38 deletions(-)
>
> v2: Don't mark len static.
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index 75db14ba..e1bc1b79 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -88,47 +88,46 @@ static const uint16_t file_path_suffixes_idx[NEL] =3D=
 {
>
>  int selinux_getenforcemode(int *enforce)
>  {
> -       int ret =3D -1;
>         FILE *cfg =3D fopen(SELINUXCONFIG, "re");
> -       if (cfg) {
> -               char *buf;
> -               char *tag;
> -               int len =3D sizeof(SELINUXTAG) - 1;
> -               buf =3D malloc(selinux_page_size);
> -               if (!buf) {
> -                       fclose(cfg);
> -                       return -1;
> -               }
> -               while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> -                       if (strncmp(buf, SELINUXTAG, len))
> -                               continue;
> -                       tag =3D buf+len;
> -                       while (isspace((unsigned char)*tag))
> -                               tag++;
> -                       if (!strncasecmp
> -                           (tag, "enforcing", sizeof("enforcing") - 1)) =
{
> -                               *enforce =3D 1;
> -                               ret =3D 0;
> -                               break;
> -                       } else
> -                           if (!strncasecmp
> -                               (tag, "permissive",
> -                                sizeof("permissive") - 1)) {
> -                               *enforce =3D 0;
> -                               ret =3D 0;
> -                               break;
> -                       } else
> -                           if (!strncasecmp
> -                               (tag, "disabled",
> -                                sizeof("disabled") - 1)) {
> -                               *enforce =3D -1;
> -                               ret =3D 0;
> -                               break;
> -                       }
> -               }
> +       if (!cfg)
> +               return -1;
> +
> +       char *buf =3D malloc(selinux_page_size);
> +       if (!buf) {
>                 fclose(cfg);
> -               free(buf);
> +               return -1;
>         }
> +
> +       int ret =3D -1;
> +       const int len =3D sizeof(SELINUXTAG) - 1;
> +       while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> +               if (strncmp(buf, SELINUXTAG, len))
> +                       continue;
> +
> +               char *tag =3D buf + len;
> +               while (isspace((unsigned char)*tag))
> +                       tag++;
> +
> +               if (!strncasecmp(tag, "enforcing", sizeof("enforcing") - =
1)) {
> +                       *enforce =3D 1;
> +                       ret =3D 0;
> +                       break;
> +               } else if (!strncasecmp(tag, "permissive",
> +                                       sizeof("permissive") - 1)) {
> +                       *enforce =3D 0;
> +                       ret =3D 0;
> +                       break;
> +               } else if (!strncasecmp(tag, "disabled",
> +                                       sizeof("disabled") - 1)) {
> +                       *enforce =3D -1;
> +                       ret =3D 0;
> +                       break;
> +               }
> +       }
> +
> +       fclose(cfg);
> +       free(buf);
> +
>         return ret;
>  }
>
> --
> 2.50.1
>
