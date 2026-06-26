Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFB3264E5
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499989; cv=pass; b=mXNi7PoYXMg6DfCeyd0VjQaly6YAhmxOktXOo6bQXF3IKH+fwd4eF/IvalGqKFfzkoGQNYfGzOAqYmC8ZD114Edtn93mrmjuUhVmL/NgA5rYrB/5uexbR9T1jxUI9x8XAt4Ma1DoP3+s38MzWbYH0z1PfIWV6d5gtRaU/0R8X7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499989; c=relaxed/simple;
	bh=G2uYPkUsVIAWXBH3ozvwa65EMnQs4Lot9xWR+h7tgGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoHjZfIn6sARdKZtYQAGLuvamtvySdBrwz2zdsuJNyC5VMWIifs2g/BLRFo9mg5YGYIg0O+x8N1bsVc31UQHxjZ0fFmBbJKe+l6COs4JEwZmf2p7dy8K+nY6QHRoUEYj4pE43Xn/cca53xgThSAVNgDoOvmKzN1LOl6n/DOMPAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXnU9IHE; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXnU9IHE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37defb2f231so802798a91.2
        for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 11:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499987; cv=none;
        d=google.com; s=arc-20260327;
        b=KD2LR8dbcK4BdRiUD4whXhEuQbf4401gI1R2XlxKRRn8uxrODoh4Hd3wQDNodu3Z2o
         H3ToyoLzm1UO5cGVqhK6HIHWlnR78rep8MnaK1EvP6WMZ8tfRK7H6T5Cr51AC6XCUln2
         NxQtNCtfoRC5rl/hz7GZQLxl/M8ljEGjL1KyfknjD2MVAev9XCr89q+SyR2tdB7Hn2pM
         GEXKZMRx88enlFCiptzi2bGYWcYULdWYvkdGPs+DH69g2hc2CHhzSKPOTehcu6Mq3ge2
         QZcB2hPbnljzKiGg/etV/KhbZr/ZIQqTQv1Jcw66Gd7p1Y3KgQmZjtBQgTZE7hjJFz4d
         6ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PX2TAcg8aGhfQ9Lv7I7wQtu1BFWLCyx/612UxjaPEDs=;
        fh=HQEqYWRRW4fLNV+P28tAyJzhmeEuSN7KGQy6FmHqCtM=;
        b=FFCs2nhdORhyjohsnSGpjBcz/2j4YCp9bGK7MsN2+QbUXx/U2s1riNbspv4mZ4LAk8
         +zA/WhHN2PvzX0JwGi0bstiRo9OK7zSwdYsJEA0wOhPL3V7VieBbyRH5BQ8WJSKY6J6W
         yMXQQc3LYUv5Lv1TvJ0DBF8TBK6QibIk+VGX/esGk0vHV0iIuLQRmiJVLlX7EiyDN9WQ
         WXFw5chXHMzN5v82sZzbDpYl8jDzsFJHg4OGowBr3xluWZgl31cypGqzXZHyDXm9ieal
         NhWJkiPDNfziaZtwS+zmSevxb8RF+YujrhunJv1TMlWrEQq8OAmoXR/AGqKN12p5xjbV
         iZTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782499987; x=1783104787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX2TAcg8aGhfQ9Lv7I7wQtu1BFWLCyx/612UxjaPEDs=;
        b=HXnU9IHEwQROY8/oXvyDPryxEm2bUQPYXUBwRT6U+yhomyq+Q6nvJN2jNSbOxs3GU9
         5c0ZH2JEEa+Rk8MpG+xIW7sEite1lqUkU3CA0H6vFnujP3RBBcRheMskr+CGQRqi/TJZ
         q3JHOYHKOuz6dgwcmm1dNeHKzJsGgnYq59/gWPeke0vXgZGRXQUXNH+XiuUzPb+h7ZRA
         teLiBFOC1xpo/9/NWb04zhfXzvB2UEOp0zaDNU1XcIouDRPrvo7DfFkq6fJv3PsugxKD
         loYIioOPjjWIlYxszKJl9e1KQBTY+77LJxQ2ArgIVtkQL02s3xhUccAF3KIWc/gAwRgR
         KEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499987; x=1783104787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PX2TAcg8aGhfQ9Lv7I7wQtu1BFWLCyx/612UxjaPEDs=;
        b=AhYDtRWMeaFSh+cNcz5wGvfTWFfABWP/3GoSPnKsaUhXQW9SinZp9tu51YUanwodSH
         BsTWhlfhD5Rt/bgf12hO+ApBjYSNmFU+cBWyx72j+D9gF/UM57N+bic2nOeRcKLh1SF3
         mHX1bkSCYtZLEltQpmoeGCuLjdiQlQgbbt5Wx/BA+XE0T7sEvQnKCjKIGeFYMPo89xIH
         d2xuFPYnWOyuQDrlysDOHuD9lPPkyHLIjcTIHGc+iQHglN+uyXWO1sqrouiZYgiysx3Y
         VxsCKsbevGzlEseessdgp7Hp29AXqufhi81XmtUghSzdeziA0WLc3dhn4s0mpPjpNQwi
         WKAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAGR3Rh64QpDKrdebjtesfDbcSoDUJV2+BGh0tg32A6CxYv+DmraHpHV0lh4ukmLrHxEidhMM/@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDFly4gugfJKu2G+JJOF6+F1kIycAxyGjtaqeM73D7QR/f+rA
	DiyfaO0wwx1m8E6eZQAwB43OdPiuB+OXJAwWe8iF+anV0Dc6wF8xyPLsRYD3t2N95kbqgdgsPvK
	L67TEUtY3yE3vcP135kXMCQEvqRWcPOM=
X-Gm-Gg: AfdE7cmFwTBsv5/E28YIjfqNVhOcoPYHN03cSYp0LCKhEn/F21KC1ptjU0FvKKV/fhN
	GilNgVqZd74tZ2Ckfw3reM3wI33h6eZEdpphdZTMd6RZfi7B97AsWf5xUGYG7gV8QFqrQKsNdXT
	rGw/bbl+8E+vbECsza36Czi/h1Q6kW0puN5vwwQdaEhCD1QTSvbS10jdqHRsEChFqwV5kLdTx0M
	r5ESsQiTsRzhH3FCamSxhHzRb/LD+/U68U9yrovqca7mfMZXlLFlzKl4quFTsgaTmIR/T71
X-Received: by 2002:a17:90b:3810:b0:36b:b06c:30a1 with SMTP id
 98e67ed59e1d1-37dfa19c4d4mr6947220a91.1.1782499987483; Fri, 26 Jun 2026
 11:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aj6hVjECikvYtnED@dev>
In-Reply-To: <aj6hVjECikvYtnED@dev>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jun 2026 14:52:55 -0400
X-Gm-Features: AVVi8Cd0D4PniqJ0dQLP4_xnxxF7r84r9JgtD4Q9k4JDWoxyYhHGvigpsQC4xzw
Message-ID: <CAEjxPJ7ZbBObzWve0f3-Am6Phw6HD0FBhFX28vz--NVnLAFuZw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: replace strlcat() with seq_buf in selinux_ima_collect_state()
To: Ian Bridges <icb@fastmail.org>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 11:57=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> In preparation for removing the deprecated strlcat() API[1], replace the
> strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> seq_buf, which tracks the write position and remaining space internally.
>
> Each field is written with seq_buf_printf() using a "=3D%d;" format, whic=
h
> removes the open-coded "=3D1;"/"=3D0;" constants. The seven per-append
> WARN_ON(rc >=3D buf_len) truncation checks are replaced by a single
> seq_buf_has_overflowed() check after the string is built.
>
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changed in v2: replace the v1 seq_buf_puts() pairs with seq_buf_printf()
> using a "=3D%d;" format, which drops the open-coded "=3D1;"/"=3D0;" const=
ants.
>
> v1: https://lore.kernel.org/all/ajlN94VO7BYNUTAy@dev/
>
> I didn't change the precomputation of the string size. An alternative,
> which is used by other seq_buf callers (e.g. kernel/rcu/refscale.c,
> mm/memcontrol.c), is to drop the precomputation and allocate an oversized
> fixed buffer, relying on the seq_buf overflow check as a backstop. I'm
> happy to rework the patch to adopt that alternative.
>
>  security/selinux/ima.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index aa34da9b0aeb..cb0efa2fc1ad 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/vmalloc.h>
>  #include <linux/ima.h>
> +#include <linux/seq_buf.h>
>  #include "security.h"
>  #include "ima.h"
>
> @@ -20,46 +21,31 @@
>   */
>  static char *selinux_ima_collect_state(void)
>  {
> -       const char *on =3D "=3D1;", *off =3D "=3D0;";
> +       struct seq_buf s;
>         char *buf;
> -       int buf_len, len, i, rc;
> +       int buf_len, suffix_len, i;
>
>         buf_len =3D strlen("initialized=3D0;enforcing=3D0;checkreqprot=3D=
0;") + 1;
> +       suffix_len =3D strlen("=3D0;");
>
> -       len =3D strlen(on);
>         for (i =3D 0; i < __POLICYDB_CAP_MAX; i++)
> -               buf_len +=3D strlen(selinux_policycap_names[i]) + len;
> +               buf_len +=3D strlen(selinux_policycap_names[i]) + suffix_=
len;
>
>         buf =3D kzalloc(buf_len, GFP_KERNEL);
>         if (!buf)
>                 return NULL;
>
> -       rc =3D strscpy(buf, "initialized", buf_len);
> -       WARN_ON(rc < 0);
> +       seq_buf_init(&s, buf, buf_len);
>
> -       rc =3D strlcat(buf, selinux_initialized() ? on : off, buf_len);
> -       WARN_ON(rc >=3D buf_len);
> +       seq_buf_printf(&s, "initialized=3D%d;enforcing=3D%d;checkreqprot=
=3D%d;",
> +                      selinux_initialized(), enforcing_enabled(),
> +                      checkreqprot_get());
>
> -       rc =3D strlcat(buf, "enforcing", buf_len);
> -       WARN_ON(rc >=3D buf_len);
> -
> -       rc =3D strlcat(buf, enforcing_enabled() ? on : off, buf_len);
> -       WARN_ON(rc >=3D buf_len);
> -
> -       rc =3D strlcat(buf, "checkreqprot", buf_len);
> -       WARN_ON(rc >=3D buf_len);
> -
> -       rc =3D strlcat(buf, checkreqprot_get() ? on : off, buf_len);
> -       WARN_ON(rc >=3D buf_len);
> -
> -       for (i =3D 0; i < __POLICYDB_CAP_MAX; i++) {
> -               rc =3D strlcat(buf, selinux_policycap_names[i], buf_len);
> -               WARN_ON(rc >=3D buf_len);
> +       for (i =3D 0; i < __POLICYDB_CAP_MAX; i++)
> +               seq_buf_printf(&s, "%s=3D%d;", selinux_policycap_names[i]=
,
> +                              selinux_state.policycap[i]);
>
> -               rc =3D strlcat(buf, selinux_state.policycap[i] ? on : off=
,
> -                       buf_len);
> -               WARN_ON(rc >=3D buf_len);
> -       }
> +       WARN_ON(seq_buf_has_overflowed(&s));
>
>         return buf;
>  }
> --
> 2.47.3
>
