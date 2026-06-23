Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C562348C65
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224049; cv=pass; b=aAe6GtBO1sNkhyRAgBSNlImTDQtpVh7qvYLipvOzlE7vziMLcM3EbyMXywL807E9Y2/o8/0c/4RjPCHbroYtwikhpkmDlJIJRYej7U1arYqN+x73FtulwCbeslmeJlsbcUgeSwBeGHGvSsolrP/uHMlsL/jouHdOEZkfR6dLtNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224049; c=relaxed/simple;
	bh=/+o3vL97VI39UHuTkd1W87MT7JzoVyureeBnGr0enUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8nLxpDRvZMcVof7jGlJhqc7wxhVZVk2cckBmT+QIcGiR6P6oP6z7AVha/rr24zLCACBEtLWsIyLWkEA7IZ2OciqwBNfWNP0iiCUsAQU5+NBjP8kPCLshWVpusuZEt59U+Y6SHFjuY9kPv5loFrH+2fsQGFeg99G7XpDDkBvt0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBI4lyP8; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBI4lyP8"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845369f60faso3470018b3a.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782224047; cv=none;
        d=google.com; s=arc-20240605;
        b=S3feGeIZdjCvziukECUwMR9VZsdN7L6TlT/hRIak5UBaFkvCEEAb00b8Zqtk1Q/10G
         cg0/G03n4kaHHjEtCtGC4Fv7HSlyK3zO6VCRI3MJsdDHARw+siJgel8aKnL/cpdWZcPa
         DqcZLOfaaDgT08w6jkaOUqBNkdjMUAYefp/8cyhiOGhvy1QLUneDgzH5VMErghBJ3xE8
         53OQrsfHbCMdfKll5lU3sb7aSQWj+nkAtJOXk/6fZ+fLCXQY+wkfppeUakCd+oAYh4iT
         7yJ3DBXfSMv9qOBFlA7E1OMFcelusi0rEBvlYdLx0KsX1MbPFbiad2QQxmb+pV/boOjj
         fbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8PkE4t3ATDnH6Gx11cmjHCvIDQ/Y+tKiI7XJVw3wKk=;
        fh=+ymDRLpvH5V4NxzbU6EHTgZVOx8LXRvHxwaIgjsFoxU=;
        b=Uhyn7v12Qz3pb30w4yepJlazkCZA+rE7ORjT7ZKT8PIMbIgQ/uLs4guLW991WkJYCS
         1Z67yeTLckYoSdA02Y5S+EfGf3RLxRpCLObtBYWMdewOcyThAuOLa4Tq2Nm3M3bjFy3E
         oaNpp5JHrEbZwukMTPduqhR6BSrD6DQq1ySgNhGQ5+FC4KakQq0imUYziOMOyJ7FKMtf
         Hnzl97pHLFxXvrSm5Z0uW04G7xDDvoL9r1/2OJTEkfHWf47bZTmgCiUkLHeNU8g4IGzb
         hEvSWcqyua6QVjwzc+mmJgIARXpwoxkR9BnKBoHiNPNTVxosq89grWw5FSCUcG4TnBlX
         yMTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224047; x=1782828847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8PkE4t3ATDnH6Gx11cmjHCvIDQ/Y+tKiI7XJVw3wKk=;
        b=QBI4lyP8iO8gZk3Hnaw01PX4cJrzphustHN0t3V68ZRu7cuMPx8X58J9E66EMOmjvX
         aXZCJJqMCgJ0Jb4o8kZvo38pIfgvAEN/3o/ew9/chogC5xzD2mRz68wnCEzmAlKsGMD2
         7dB1GI8h1Eg37HUXsTsEvmC8XjNiAe06uI840jugO08TfsXmojcne5pgq83I6w14uDui
         y2Ejfrvx1AwHlJRijIDUmlqQ4rXwetcAIkN89wcei1HwiL5ITjCOuz64m19kWCEftcG2
         INPnVELJSwk6aF7+4wssYH9mshnFWj3sTbU+/d16zoT5kLoGT1VZTgeXVUyRXi/mi21V
         P9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224047; x=1782828847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8PkE4t3ATDnH6Gx11cmjHCvIDQ/Y+tKiI7XJVw3wKk=;
        b=FubB2zMkptT06xl8FHCkHtkG0HyRKf0KlKlm+Mn1D12kEIAfcl/mR/PZhOaCN0d+Qm
         NAIPCi8bZjL2bHMtQ//onTefrDiZ/0KXJ/MRzs34PXxZ343i5KDHSftXplVRSUVYonTk
         HrCDdO/YXD48VSX2T1EkdX/Zx3fcO/XpPdZ3AQKbYGr9YHY0j8KDXb7nKyKlr9kQv0ol
         vKH9aftLGZ5YQnguJUCszxOqpq6QJVAgKK0DunsEOxmR82Cp7z3RmtJdCYOybgQXeaXP
         TG0hsYs4NtjQBDJwJ0viFAwP0Gle30pkKNlSzp5H5t5Vl+594a7/ig032tz9Br5EU0yY
         KdMw==
X-Gm-Message-State: AOJu0YwEsck2RNzLC59rPELcQke2rPFOlN5M5MfB5xo3BmP5X4vqQyP8
	jHNsjbbjeMqOvoEDJ8lLlemk4gOhGbl8bTR4epxcdVfi59k2xQFTliFSTGPUHd1TF4G+gHbo4hy
	f9MrRQZ4NGJ6cMxxqQ+85EzmVN4HmgMXBh/y0
X-Gm-Gg: AfdE7cmkW3chXfaYSZ4VqtbP9E3POACqDIb/YWPsoodT3D/IQFUKuxaBQBE2vRhG6E3
	ZJiyB4+tFIJ+4V1qWaltZt94SdT6pS8oOeyUU9fmJ2JX6WNlyeVwrhQpMecO5f+ToeSPKcDpRwh
	fnHdEk4alxr5P/ttWf1P5I3saNoyd1GPSHzOLwQdY6QiQWes4SyfoYOgY7KsbIQhUPjf6BViIAn
	yONDTX20byAdHif/CrwMMhY6KxAjlP5iv/+4pwMxCZunnSHfIrjtUMcc8tpztFX7TGgF+XY
X-Received: by 2002:a05:6a00:2a0c:b0:842:5c90:736b with SMTP id
 d2e1a72fcca58-8455088dc84mr23848800b3a.29.1782224047376; Tue, 23 Jun 2026
 07:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622124111.31425-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260622124111.31425-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:13:56 -0400
X-Gm-Features: AVVi8CfDFcXyYkMsogUQ63usacjgNrdhUh7sw18PC8OEcv4peed6Wvvedp39QGE
Message-ID: <CAEjxPJ7PeK-NBrQvjUAf2BweRtJWEDn9CJ6GRD3LdweXWU4yRw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: reject out-of-range extended permission values
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:41=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> avrule_read_xperm_ranges() parses each ioctl/nlmsg command with
> strtoul() and stores it through a uint16_t cast without checking the
> range, so a value above 0xffff is silently truncated and a rule is
> compiled for an unintended command (0x10001 becomes 0x1, 0x123456
> becomes 0x3456). The secilc CIL compiler already rejects values
> outside 0x0000-0xffff. Validate the parsed value here too, before the
> narrowing cast.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/531
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  checkpolicy/policy_define.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 63bf5245..c1f12715 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2035,6 +2035,19 @@ static void avrule_merge_xperms(struct av_xperm_ra=
nge_list **rangehead)
>         }
>  }
>
> +static int avrule_read_xperm_value(const char *id, uint16_t *value)
> +{
> +       unsigned long val =3D strtoul(id, NULL, 0);
> +
> +       if (val > UINT16_MAX) {
> +               yyerror2("extended permission value 0x%lx exceeds the max=
imum of 0x%x",
> +                        val, UINT16_MAX);
> +               return -1;
> +       }
> +       *value =3D (uint16_t)val;
> +       return 0;
> +}
> +
>  static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehe=
ad)
>  {
>         char *id;
> @@ -2053,7 +2066,10 @@ static int avrule_read_xperm_ranges(struct av_xper=
m_range_list **rangehead)
>                         /* high value of range */
>                         free(id);
>                         id =3D queue_remove(id_queue);
> -                       r->range.high =3D (uint16_t)strtoul(id, NULL, 0);
> +                       if (avrule_read_xperm_value(id, &r->range.high)) =
{
> +                               free(id);
> +                               return -1;
> +                       }
>                         if (r->range.high < r->range.low) {
>                                 yyerror2(
>                                         "extended permission range %#x-%#=
x must be in ascending order.",
> @@ -2074,7 +2090,10 @@ static int avrule_read_xperm_ranges(struct av_xper=
m_range_list **rangehead)
>                                 r->next =3D rnew;
>                                 r =3D r->next;
>                         }
> -                       rnew->range.low =3D (uint16_t)strtoul(id, NULL, 0=
);
> +                       if (avrule_read_xperm_value(id, &rnew->range.low)=
) {
> +                               free(id);
> +                               return -1;
> +                       }
>                         rnew->range.high =3D rnew->range.low;
>                         free(id);
>                 }
> --
> 2.54.0
>
