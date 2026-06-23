Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA7348C65
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224024; cv=pass; b=Hq7e2GYXDvgvLHvmqo/9ZWKOzoLLw2aTuhHcNpWy0dj7Vml3p8roOmkTzvLiSkqNHGHAbRr2qosQxkeF238T2RBmtu95Oar7ePPKBDUQ4yKGx4HzwlaEUzpGyjvLwwT5X+r9LWOGNsm7ixhO4Mbmwu4ITjeI4MDUOjPjbXoMHeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224024; c=relaxed/simple;
	bh=udiRF+I6p/IegWiWYOJ24pk93jTQyKnoZ3FAVX+IfwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk23Qm6wN56yXuN57J/OKuzpTnx6z69VfSuiQDG0dd6wnra2FK/06u2G7oebleI6+AlswjSpZCcVET3PRcKe4sLL498+JHxn6rs3Zc7Kci48H+T1OYTCY388/WxhbPbGv6TdGirGaMtao4RXlPSDlzYXlX0GM7Ov3rMQmzgnztc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdpUoikW; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdpUoikW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b900f350fso5226847a91.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782224022; cv=none;
        d=google.com; s=arc-20240605;
        b=FfsMjjyPJ6Pe7ZPzemGkEou2ARREVOkubfgZR/jebx1u+YRAiaBM9fQwYX2phU6egb
         UapSL0bh98cHER2HdkwfrKkHpH0IT1h09GadTESiuM88US8X+rSzlHVuAowIbrQ3BZoQ
         h38hWrFlKz2tCwwjGrDwGiSWCMoPqEee7esAosYTaZ8uH3O8I3+V9uFNps45qYDmsWiS
         4tUhW6y4sQNygxVcgpe6pYnWBAIX+w1XkvTzKZgcvOBlbYGUR0f8/OCKwqRBYAOYT4O1
         2D7/MXFlJBAxmGfkX8GzBXoYqg6mruq7NF35eR77taYd2mNiwTM0cND1zwGYegc0c1lH
         zkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRfyH85KQoV0m5lU8wnpU9FsO9GG0odIHZf/kd6sGJM=;
        fh=+ymDRLpvH5V4NxzbU6EHTgZVOx8LXRvHxwaIgjsFoxU=;
        b=UWY2a9pN1c0K7nIrWRDsbXmxLdbAOks1ofHFdrfZmcGxyxru8GA0+900q4TX9Zs9P2
         EPfNHPxStAEvF77u9OF4usCrPbS1EAbmGMORxgfDkehXU8eToI74xp43wHukxC3rHzVi
         iTx9WZg26YmNRppzf/ghy2iUcvvqsz3CJ9sN0cErCREaozvkiuKOlzmcrlXun+Oon2FH
         BZtgmDSYm/Y9QxIouGW8gbb1BeSopph5ic7jlKRbB9r3KmgW5rR3Wbj1XNrxM9DOt2wT
         X5CjO/RKTbHAQaa+xrHSTog/PyZ/vq+7ODmIxV/J9H+Au+q91FQZVXsSKbbkn4lSZuVx
         Rf7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224022; x=1782828822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRfyH85KQoV0m5lU8wnpU9FsO9GG0odIHZf/kd6sGJM=;
        b=NdpUoikWhOaQOOpMleFIHjOzxf2zTmYMG4PrfbGqkXTpfz4IbZNISnc78Xg7B4RPDB
         5t9x7Su42FP7PMiapXOakCVoHhjv6+ixUmj2Fi3qkEOTs2crMpoZAkr87f6zNHUVGcjb
         c71wMZxh4Be+32qfIwceL3fa9uCudpaILPnCPMdFrkcDiiQy0jX4hXrKmxC0JhgDX9TD
         nSFqckzoUOwJKQL1cislZ5FIsLaSqHLF5sOtii2vv+CSVtm+yzmMGUdXN3hMbIH3pHfS
         OnmNS2CQD5of0D+TSd6nmmYrKRPdPjCQoH1WWGiT9ec2mDefPl8/kO7x2aWzO75J/9ke
         GHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224022; x=1782828822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRfyH85KQoV0m5lU8wnpU9FsO9GG0odIHZf/kd6sGJM=;
        b=h5YQSybrWIuV5oSJT/h8KTAb3FgmLHuOkznHaxQFQsOxAQ0OOqznkUKINQ+YpLp/p3
         B9o/Sk5+W5ikmrKXIhI/M+0Ja2w42+vsdRDyPIlns+LIaUkbylmla7tldL30AaWXoB+h
         WOBL4EhCvjJX7gw0rCOkTNtWCrnvTOyXDuHhsCsfb1rX7vuM2FoEjXQmqAi8CnwZP21u
         Jj43xUM78CK0f3Pi3a9EfJWq+YjOWm9+MXS8NYSMHaMmicqkTqi1oub87vE/f6OnA6CW
         dCdT24Ui6JFJ4eszfVjL/BqCGbZ/FmAk5oeVbFdsh1O8RfaTWTgEb54vs+SHO1cVlBjj
         x7Jw==
X-Gm-Message-State: AOJu0Yycd7MUHGlLbv2/bo16gtqib8KcfjrZoLtYw6IMIuvoyXKcgGGI
	qQ6QNXeqROkAbOWpbT07KCZL+P4PmI5PB5KtNRHGoTl//ZoFtVWZVmbGVM2NR6HN9Z2BXkQx6Eu
	EC8onOwlRLBlHgYqCtZgaQ/LtDtZEGvpj8w==
X-Gm-Gg: AfdE7cmZqO22AK7iU8ufUFytf4wg/05xSujGOUCA2cKMRYecejro3KgX3sUHvgy6OHA
	LKssbBw0MlyymiKKKQpdCU3R6Sfwf2WzMGQh6oJFsvH8qxoBCdsYQG2CJTyXF9fEHldG78HvbQc
	3wVfpqz6Ho6wWnGnUUgDs+EPzhbpDiZqmxtIaCf/8FQ3n13MfdzZZcTJiD9kEtmfuC5Axbn5tW+
	COENOosrrPU4bym1gjALHOhb2A7JTwmcWfZAqa9BmZTlT6LdjsJX9N/FFzqTxJLuYDow/ch
X-Received: by 2002:a17:90b:518f:b0:37d:ab59:e48c with SMTP id
 98e67ed59e1d1-37dd16c26fcmr2969377a91.5.1782224022156; Tue, 23 Jun 2026
 07:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622124042.31385-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260622124042.31385-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:13:30 -0400
X-Gm-Features: AVVi8CeferOIqhc9OD2Cw9F54K9K132Xvc465vMeAnhmzkqkcXYsHcVwW0q7PQo
Message-ID: <CAEjxPJ6pqqEEdrBo9fmiicXG6tukHqWon7rPq9D=wQtgY3ceJQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: fix xperm complement at range boundaries
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> 1. avrule_omit_xperms() builds the complement of an omitted ("~")
>    extended permission range set and advanced the next allowed range
>    start with r->range.high + 1 kept in a uint16_t.
> 2. when an omitted range ended at 0xffff the increment wrapped to 0, so
>    a spurious [0,0xffff] range was appended and the omitted value was
>    granted; an omit range starting at 0 with no successor left the
>    trailing range high unset, producing a malformed low > high range.
> 3. reworked it to walk the sorted, merged ranges with a uint32_t cursor
>    and emit each gap, so the 0 and 0xffff boundaries are handled.
>
> Added a roundtrip regression in tests/policy_allonce.conf covering
> ~0xffff and ~0x0.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/530
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  checkpolicy/policy_define.c                   | 63 +++++++++++--------
>  checkpolicy/tests/policy_allonce.conf         |  2 +
>  .../tests/policy_allonce.expected.conf        |  4 ++
>  .../tests/policy_allonce.expected_opt.conf    |  4 ++
>  4 files changed, 47 insertions(+), 26 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 63bf5245..d7576dd4 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2092,48 +2092,59 @@ error:
>  /* flip to included ranges */
>  static int avrule_omit_xperms(struct av_xperm_range_list **rangehead)
>  {
> -       struct av_xperm_range_list *rnew, *r, *newhead, *r2;
> +       struct av_xperm_range_list *rnew, *r, *newhead =3D NULL, *tail =
=3D NULL;
> +       uint32_t next_low =3D 0;
>
> -       rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
> -       if (!rnew)
> -               goto error;
> -
> -       newhead =3D rnew;
> -
> -       r =3D *rangehead;
> -       r2 =3D newhead;
> -
> -       if (r->range.low =3D=3D 0) {
> -               r2->range.low =3D r->range.high + 1;
> -               r =3D r->next;
> -       } else {
> -               r2->range.low =3D 0;
> +       /*
> +        * The input ranges are sorted and merged. Emit the gaps between =
them
> +        * as the complement. next_low is the first value not yet covered=
 by an
> +        * emitted (allowed) range; promote it to uint32_t so that high +=
 1 does
> +        * not wrap when a range ends at 0xffff.
> +        */
> +       for (r =3D *rangehead; r !=3D NULL; r =3D r->next) {
> +               if (r->range.low > next_low) {
> +                       rnew =3D calloc(1, sizeof(struct av_xperm_range_l=
ist));
> +                       if (!rnew)
> +                               goto error;
> +                       rnew->range.low =3D next_low;
> +                       rnew->range.high =3D r->range.low - 1;
> +                       if (tail)
> +                               tail->next =3D rnew;
> +                       else
> +                               newhead =3D rnew;
> +                       tail =3D rnew;
> +               }
> +               next_low =3D (uint32_t)r->range.high + 1;
>         }
>
> -       while (r) {
> -               r2->range.high =3D r->range.low - 1;
> +       if (next_low <=3D UINT16_MAX) {
>                 rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
>                 if (!rnew)
>                         goto error;
> -               r2->next =3D rnew;
> -               r2 =3D r2->next;
> -
> -               r2->range.low =3D r->range.high + 1;
> -               if (!r->next)
> -                       r2->range.high =3D 0xffff;
> -               r =3D r->next;
> +               rnew->range.low =3D next_low;
> +               rnew->range.high =3D UINT16_MAX;
> +               if (tail)
> +                       tail->next =3D rnew;
> +               else
> +                       newhead =3D rnew;
> +               tail =3D rnew;
>         }
>
>         r =3D *rangehead;
>         while (r !=3D NULL) {
> -               r2 =3D r;
> +               rnew =3D r;
>                 r =3D r->next;
> -               free(r2);
> +               free(rnew);
>         }
>         *rangehead =3D newhead;
>         return 0;
>
>  error:
> +       while (newhead !=3D NULL) {
> +               rnew =3D newhead;
> +               newhead =3D newhead->next;
> +               free(rnew);
> +       }
>         yyerror("out of memory");
>         return -1;
>  }
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> index 4115dea2..263237fa 100644
> --- a/checkpolicy/tests/policy_allonce.conf
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -43,6 +43,8 @@ dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1=
 };
>  neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
>  allowxperm TYPE1 TYPE2 : CLASS1 ioctl { 0x456-0x5678 };
>  allowxperm TYPE2 TYPE1 : CLASS4 nlmsg { 0x1 0x12 };
> +allowxperm TYPE3 TYPE4 : CLASS1 ioctl ~0xffff;
> +allowxperm TYPE4 TYPE3 : CLASS1 ioctl ~0x0;
>  auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
>  dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
>  neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
> diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
> index a88d8785..c1100992 100644
> --- a/checkpolicy/tests/policy_allonce.expected.conf
> +++ b/checkpolicy/tests/policy_allonce.expected.conf
> @@ -44,6 +44,10 @@ allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x456-0x4ff };
>  allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x500-0x55ff };
>  allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5600-0x5678 };
>  allowxperm TYPE2 TYPE1:CLASS4 nlmsg { 0x1 0x12 };
> +allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0x0-0xfeff };
> +allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0xff00-0xfffe };
> +allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x1-0xff };
> +allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x100-0xffff };
>  auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
>  dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
>  type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
> index 3d21c310..2510c91a 100644
> --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> @@ -44,6 +44,10 @@ allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x456-0x4ff };
>  allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x500-0x55ff };
>  allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5600-0x5678 };
>  allowxperm TYPE2 TYPE1:CLASS4 nlmsg { 0x1 0x12 };
> +allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0x0-0xfeff };
> +allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0xff00-0xfffe };
> +allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x1-0xff };
> +allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x100-0xffff };
>  auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
>  dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
>  type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> --
> 2.54.0
>
