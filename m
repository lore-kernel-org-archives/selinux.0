Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9131F998
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638397; cv=pass; b=HxK+Hd2vpRVEFrV0qOZLJlYfRa3aowOYgb29qdl7R12cmwpQRDCg4gzNbFhmqJiM9wKvaEvJO/ANlt7ni+tTES6ZPBXojT93OUiUrAZOVted/Pb+hbwFQd3sfmODP1DRVTrh3yENKZv5hWauIKk734d4XP+VLq1Vgf6TrxiXHg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638397; c=relaxed/simple;
	bh=S9IX/ZkYBz67kiYRG4RmPRv6cR1ypbQ9U26nj7j/QlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq+JcRKw6yjfpbzZHo93FFDVt4XxC/3YDx92E32JAgXJ+B7+1j2JMYOYKdtLdyydb+sqMbEBl+utctRdnrgyOqSDBB1Vy8Cl5+VowowW5v3p5Ip1eJG3supEpthasV5OmJtPzVTqzz4wlMBCpjPgy/gjIP9JIKxyGj91nKQ+1Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kir41sJb; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kir41sJb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so6316034b3a.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638396; cv=none;
        d=google.com; s=arc-20260327;
        b=AnYRNwoptYDYQOXb/n8AXjjwR51q8swl6gr3+ml7LeHoWtfPJlzF8XJli9UbbbOU4z
         QFEVMbW3LcTkIDHn5JH0xOSIDKbR4+c85hVbKyo7AiA4pwXtZjT5VRyfvXtJH0CLoD8i
         jJcXCQhuSHBONnm41i9N7zgtORgGmYOHyE8WGlu1ZjLNRlGwHz3vFyfxogFlDGZLppzT
         rVCV/S5ULaN8DzwBFYjOsL9/xmLIBCWNoZaKfkFAgfIjGijpFphzyrhUeuVuKVPdzL9i
         BumEwuI58kPr1bQ6OhAzmX+S5V9Oy7Rfhkr0Fb2KWwW38pP+WsDY3s2Y+fpe1Am7P9WY
         ohUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4bFSeLq1DKe/5IMhmLUXqY9Nr4SbZi+QistznzQcdj8=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=BXos0ndmGsu6t6A9UaE1kVCh6WC1238rG4eFER7CnRMMHGtlPuMDPLC1qSPa/UuGbR
         pecBijK498gaHEddyMRj9wRnlagOLzNRc353zNxjOh521woHn69CGD5hjJhmo+E8KnQg
         3SdV5fP0wKkWMBNakLgfb6WjrKuu/qhAvE9U58Dcpf4pJb3Cry83mC1TDMHxEX1f5U+f
         jJPL8vLPRHEPGk+Cy3ebtx4RbVe5YpPX2lchVof8ZTOcS457RNfoBFRoNo4m/ZSg2z7m
         DkYRSwC0wB+d1qmE+cHZh9gJU3xMrWrfAhCsHdFPizsexMqcca2azLvknixjUmk53i3R
         O8+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638396; x=1785243196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4bFSeLq1DKe/5IMhmLUXqY9Nr4SbZi+QistznzQcdj8=;
        b=kir41sJbvp/sRa8CNWYyPXKfDduWasMpl958F0UFpOaAUdC+UE4b3w7tajd/SxVuw5
         HsW2MDQPFiQiG3RU7NvOC/t4kI/Z2Ih22s9VdsjYLPgyuP7s3vLFhiYk8U2sMyRFKNjv
         04a+QjygaRyQF6Y/cdn7mDx+Bbxzevy7BtAHcYjtJbZxw+dBb58dPV/MstdyoEQoLZxo
         ox+4hn9nHJTzMtPMaUSvBhVOTta7QSeJf1NIQf+x4jhThthGV+DXTvjpmT1OENLCjrBJ
         cV3INNC0epNrWNZVA8teLjexjF+HvP0nv6GlIzTCqCqtunyPFF/zEcPFPxmgfdcujuOw
         VeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638396; x=1785243196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bFSeLq1DKe/5IMhmLUXqY9Nr4SbZi+QistznzQcdj8=;
        b=JS7zICHosNVhXsPR0PnkeiKHseBV6ET3Glp/9ked1FBGVFhF3sav2O2EbStsS6b/WW
         EtfCAugv5J8OD6l/V4jcw5PD9cEJXpGIeLJY+Vv1fHCFvc9eOzvyhvd/bJAnueOW/px0
         fvYxAax9lOnFd8xvR6FHcgTO6sNly8lV28cr1R4mBvMzcBPf3qsPI0nbKNC/idDKC7Th
         g5xDHtsS1hyc6/kIUfgemTJ+DM+wB3G2HRIj+Pqlp9zu6WV6tkf3Hdv7Voav4zdw+3/9
         gv28euw/S4b6DwlV5PBrFSFc2nrz8jKAGjXHU8HWcFaeHyS7DC23UOa8CpDj3bDCDaRy
         vzTA==
X-Gm-Message-State: AOJu0YycSi4yBfIcd/wQpfBlob/9UhljvR1rhrBkSc0J7QUxX3SpePk6
	iCRMbmM+jYn6qUmw+y/Ro8chD9l7Bn2CQrEAt2FdmGNrT+4bBlRRgsNdU+QYOaj0I7RFnoZRFE0
	fBIiIoFP7rTdI2DQis8Oi7ehfa2dR6IswtA==
X-Gm-Gg: AR+sD13Cy5rmFIRSBXx5DrvBTbY2fUsGryCdQt2nGVMXUX+hsyWBQrwLzl4bKvV7hoU
	NiGaPQtS+MhTD3MaVBazaM/DUPestepeinPP3/jKfIiSeF4V08xyxIJh3ekEPIo56Sf9EeU1CPe
	HIChk7DgiZm/hahumbO3Vv54seBH9iJNHYRkP7x2aWmO8RxltnDPIiiK2X/ZC0kFuhNHGxTRxWp
	Lo/KSP4IguvusB/ChJPle5jHhPTdLohhoTLaQ8q9y8DH4q9z0dQXRADK54XxrAYKq2Jdb0J
X-Received: by 2002:a05:6a00:3c92:b0:845:d274:c024 with SMTP id
 d2e1a72fcca58-84c2954d8e1mr16532169b3a.61.1784638395929; Tue, 21 Jul 2026
 05:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716191123.10829-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716191123.10829-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:53:04 -0400
X-Gm-Features: AUfX_mxYA09OVnCDBq3D64Ng-OCx1ruorzKhjGQx7dDCxlfMGBl11mKOSiaW9FQ
Message-ID: <CAEjxPJ4HcF9N25u4i=hYzZND2DWmdS7RqWeF8h-WCZepH1oOUQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/setfiles: fix -f handling
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:11=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Only trim a delimiter if we are consuming it; otherwise we may
> truncate the last character of a file name being read if it is on the
> final input line with no trailing newline.
>
> Since the -f processing occurs after restore_init() has already
> converted the r_opts flags to restorecon flags, we need to explicitly
> set the restorecon flag when a mass relabel is triggered via a "/"
> line.
>
> Initialize buf_len for good measure; glibc ignores it when the line
> pointer is NULL but we shouldn't rely on this.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/setfiles/setfiles.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 2d38ea8f..e0953708 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -142,7 +142,7 @@ int main(int argc, char **argv)
>         const char *input_filename =3D NULL;
>         int use_input_file =3D 0;
>         char *buf =3D NULL, *endptr;
> -       size_t buf_len, nthreads =3D 1;
> +       size_t buf_len =3D 0, nthreads =3D 1;
>         const char *base;
>         int errors =3D 0;
>         const char *ropts =3D "ce:f:hiIDlmno:pqrsvFURW0xT:";
> @@ -455,10 +455,14 @@ int main(int argc, char **argv)
>
>                 delim =3D (null_terminated !=3D 0) ? '\0' : '\n';
>                 while ((len =3D getdelim(&buf, &buf_len, delim, f)) > 0) =
{
> -                       buf[len - 1] =3D '\0';
> -                       if (!strcmp(buf, "/"))
> +                       if (buf[len - 1] =3D=3D delim)
> +                               buf[len - 1] =3D '\0';
> +                       if (!strcmp(buf, "/")) {
>                                 r_opts.mass_relabel =3D
>                                         SELINUX_RESTORECON_MASS_RELABEL;
> +                               r_opts.restorecon_flags |=3D
> +                                       SELINUX_RESTORECON_MASS_RELABEL;
> +                       }
>                         errors |=3D process_glob(buf, &r_opts, nthreads,
>                                                &skipped_errors,
>                                                &relabeled_files) < 0;
> --
> 2.55.0
>
