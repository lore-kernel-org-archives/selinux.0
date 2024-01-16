Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F141CA87
	for <selinux@vger.kernel.org>; Tue, 16 Jan 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426517; cv=none; b=Vjyps32PRk1p/zSp+3uLRoI7mdvyKiwo6Owemm/DdgEnSETrtku24KRzXcTZJOEq+kZk78uemPf3k3ALaqJCz/pGU8kqpIs9BztXAcMV6TyCasuIPEgjFayAY0EB4nMpexEG/oBpH76oanZMVwd20CNFW5jRvpBS51Mp6ofRFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426517; c=relaxed/simple;
	bh=XylO/TCaHoijKw3wbcshSCCgDO4xRTuP/Vhy79B3gbs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=CSB+fOtWMjU+ne0l0ItUyMmiXCdP7w7C35VyRDeYPW/RmCmcm08X6KDD9oFqeUAPRJOmTZuWpDOsIaCysippzFfRvk8ANH8dXvZQLj4r1hK8Ij/w4Hlq5ABabKR5lzSpwLzjIZchFacfttMEwPsp2OGcd/jnZTKO0um5saNlXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9JryFCp; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9JryFCp"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso115168681fa.0
        for <selinux@vger.kernel.org>; Tue, 16 Jan 2024 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705426514; x=1706031314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SPznOCT8ZLfkjaLol3i/tvOx58l3trKgcH6xr60g00=;
        b=h9JryFCp5NNyTHztdTwDA/udYLkra66+kekVEKk0MHQjA1VkJga0heiDQ9GGGBQcbe
         zNy3jjrtipBPZw9koK30bIA1+kNX9vU0/A4s3GmbcRiCrDum4sOqzHUnNQsTnyExpH6p
         ZSmwFNIvRYUwjYh69TxgA9nMqMkbhMBAz22F0DSdKEbNTg9rxAN9QOPeQYnRbG6+bvCR
         1xBJ6Lqkhfc5P+DiI3jY1BvXoOgUyZihTh87jOZRD8p6qcjyUDt7kQnO0xRkIuPMyGke
         ySXlrhgo3fzpgkKximb4GZcYHF4NA8sHIMl1RQ1Zq0Gn0XYM8xV32Mzp5YRTopV2JlEI
         Tz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705426514; x=1706031314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SPznOCT8ZLfkjaLol3i/tvOx58l3trKgcH6xr60g00=;
        b=OdfBpe4LaQme97nViDd3jU0YQqJV1tle31kYAT6cxJU8tn/86vWn7O9hT68xl8uvhF
         aymvv7csgVCobTvQE/Zhd+bDLDDX1NWmx5lXsw0T8RBO0P1iMjVl59DpqCXs6fWKVqVQ
         +s1B5WnVqQzIJ7a/gzhNXuVDiXxDtJRQIrWj+RsynmcZpA1ZZVXdDL5w9YcSpZqDRXyE
         f7aobk7YLFHzgUuNHDq8cOzUDTdknHvO1Dx1mXSDeJ18D9V1s/San+a5q5reRFMPAN+d
         TQ5ubi0UBlgPbheIEt74mgUBHxPMTnURv+m+ywYHbSPlak2FsERCaNrKwY9/wlpveH2O
         VAMw==
X-Gm-Message-State: AOJu0Yz4StEZRHx4dVXS4zMswehkCIK3E6sVg+0Oj+gFKC2snWfjqhcS
	Eg1j9CivMQC6Oua/uEuh5wxvrTfbYQZScjx1frs=
X-Google-Smtp-Source: AGHT+IGXYIURIC1UPdL1L7mVK/QzmIQIVi5e2VGvuMP+OhZm3ijbMohJCgo4MqzW6zb/QhQSpjufc4NxRf4qGT+M+R0=
X-Received: by 2002:a2e:8754:0:b0:2cd:2e26:19da with SMTP id
 q20-20020a2e8754000000b002cd2e2619damr3579460ljj.60.1705426513884; Tue, 16
 Jan 2024 09:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115133607.10783-1-cgzones@googlemail.com>
In-Reply-To: <20240115133607.10783-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Jan 2024 12:35:02 -0500
Message-ID: <CAP+JOzR2ExEPR7U=PkKCzNVQ+w70oZYxD+21nz4u7p0AhH7hcw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use reentrant strtok_r(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 8:45=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the reentrant version strtok_r(3) instead of strtok(3) to avoid
> potential data races with concurrent threads.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 38f10f1c..acb729c8 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -243,7 +243,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
>         int index =3D 0, found =3D 0;
>         uint64_t nfile =3D 0;
>         char *mount_info[4];
> -       char *buf =3D NULL, *item;
> +       char *buf =3D NULL, *item, *saveptr;
>
>         /* Check to see if the kernel supports seclabel */
>         if (uname(&uts) =3D=3D 0 && strverscmp(uts.release, "2.6.30") < 0=
)
> @@ -258,13 +258,14 @@ static uint64_t exclude_non_seclabel_mounts(void)
>         while (getline(&buf, &len, fp) !=3D -1) {
>                 found =3D 0;
>                 index =3D 0;
> -               item =3D strtok(buf, " ");
> +               saveptr =3D NULL;
> +               item =3D strtok_r(buf, " ", &saveptr);
>                 while (item !=3D NULL) {
>                         mount_info[index] =3D item;
>                         index++;
>                         if (index =3D=3D 4)
>                                 break;
> -                       item =3D strtok(NULL, " ");
> +                       item =3D strtok_r(NULL, " ", &saveptr);
>                 }
>                 if (index < 4) {
>                         selinux_log(SELINUX_ERROR,
> @@ -276,14 +277,15 @@ static uint64_t exclude_non_seclabel_mounts(void)
>                 /* Remove pre-existing entry */
>                 remove_exclude(mount_info[1]);
>
> -               item =3D strtok(mount_info[3], ",");
> +               saveptr =3D NULL;
> +               item =3D strtok_r(mount_info[3], ",", &saveptr);
>                 while (item !=3D NULL) {
>                         if (strcmp(item, "seclabel") =3D=3D 0) {
>                                 found =3D 1;
>                                 nfile +=3D file_system_count(mount_info[1=
]);
>                                 break;
>                         }
> -                       item =3D strtok(NULL, ",");
> +                       item =3D strtok_r(NULL, ",", &saveptr);
>                 }
>
>                 /* Exclude mount points without the seclabel option */
> --
> 2.43.0
>
>
