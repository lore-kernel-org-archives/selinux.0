Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A82989B0
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933675; cv=pass; b=tSfihE0VuVSfKW6bEbZvMSY+zA9RurK/n9ewGo/CA2vxwzf9Yz7373C2d3ItUafKqH7ZNG2V5lVNZ6qqeoOBEOvvJjHr5ag2JY9AEvf4629fOof1vwFkoUwX2I0DCYQYPjnQEmumixO1TeM8+/DhDlT+jL1MRA9D1jACBXztdl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933675; c=relaxed/simple;
	bh=rIGBO3xHHCqhQz9j0rQEk11YMo8eoeMEaYwAB4a7s3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhIY+hxG1vMYvDJbargTV/6S9mC20QC6+jJI5HfQAS7bffDZ280yUZc4jfGYfKcocKHWpvWEwUTfmY81wuLFZRhfG8qXgPyeNzjfH/bDAMpiemRvVQQtXEG38YkAu5SLuREge2H3Vwu5yVVcAINBtPkjq+JvvjIpdjb18T1Q4YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWA4GJxW; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWA4GJxW"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3967620ceabso43318451fa.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 08:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933672; cv=none;
        d=google.com; s=arc-20240605;
        b=Ln60tTOAfpjlZfL6NK528jrzMg6P1wfdzdaktBr2cMJ/oIq9djTpn4jobpc/Cb+J+Z
         4iNrLSLV97Wfje54e1+GT44qup9kmQTRkK048dw/VKBnmAa/jgS5QxY4aI9SmDetMIxd
         fVaiMwmEd5OT2VvSttHRmPsy4I5dzosBsJYIsO9AbUiSw3h8hQlYe7EPzrtrMiwzSv07
         1X987huc1T7Yo9mmcKDa7UNakO/MXRF+T0R/bX8GdY6vuk7pl4VngiDdNOUXgzScNfSt
         PAAI/Gz/zPgmG5JQVB+tAG4bqu+FXCZJvcthSTXKCyN992od2Zdt783udSoUDsPWwxyo
         0lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sc3o9aRH8EVbyuJxBudCoOgU7kMYfak5VhaCQcuBuY8=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=ZPcSriNsuEQEh/WbQC58Z1w2alIefd1B1RKV+nphqhUmGxeUFP+z01sGPX7CFoRMBi
         g1wj6x4LXDbHHbjPbN/MjOSLPgfVsTG4yU312tDsCD9gNpIZoo9fYRNwSSIXHGvRzmjR
         uPyrlD9AZaPHjlPWLpa5OizCnOQacDL/geAnONPygVTQ5BoVap2q+/Rfb56nCmDNuz4s
         KsVbdkaroiycIVy48PMTujGorKqOBcJc0lHMr0JaX3eofuF+EnjQlTsSCG1bCjvu+9L8
         LXdMCEKuTL1GFw0d3JTymIITckuBLJpZFTNcCBqQ6P8Qg42iQXaZeotI+7AtWPegZTb6
         koOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933672; x=1781538472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc3o9aRH8EVbyuJxBudCoOgU7kMYfak5VhaCQcuBuY8=;
        b=NWA4GJxW2Fpn0ikQ9EplSLEFmo8wfXX/S1YRj2Z1/tRREXcTZ18gj3j65oSjUfyO+5
         cxh+0YkcCHmINPKAmZmkrIOrUn3wkSwtEZOPtiZ7SBQ+ds6Bos2hNgiP0ZDueT1rg2vl
         anhRVKdQTFcHT1HR3OYWmJQ93rDKfCK2J7qhlaUAfmKvTs9nDIBCxCya++6COo/bo+ja
         OzHEajyOI8qK1+Ae3b+Jb2oivq+rDE3d+IGGWCDcvNQ2Kaue1UNSLpsYKT3p85jgJS3U
         hEdsudnrYWNhfGewW+fja+PJeiLbEaPRWyqoBxAKHwCKM/wvAR/x2vxjBZwLnEAolUv/
         TbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933672; x=1781538472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sc3o9aRH8EVbyuJxBudCoOgU7kMYfak5VhaCQcuBuY8=;
        b=TVHieTPmoRntK0bEPfoIRzg2syH/JpTv9c8MP2F247aj4H1q1d+WZrhGZOeActXZy7
         hz+s0GMECrzRxHd1me1JmUTZBHj0E6f430OUKB61iSZptNm0CtXvy/39A4g9Pp4wyoFn
         +mqiBs0UlF/KGqwD1IXW9gusQ6KQwwHk16+z0ToYS2MnQUhitazMzkwP6wffa32XzNP7
         YK1LlANTRNZ5USo1JqoRQPPIUedNGVXwrcpX4zfrHPIY3c4qbi83y7l+fpGOt0ngx2YU
         Y4T43WScn6S2yMt6FG+KF3XwYWGPWeNB8wfAT7dbPvOSSRgRnFLlT9nUnpxhdKuEKR5J
         GKRw==
X-Gm-Message-State: AOJu0YxEge9cCftomJ6WxDXlfyBu9kKJZeiwKy0gz18W5GLz+aKxPHAk
	iUAsc3nrEXfAYMRgc5JB8YrUj9Lig9NEsJ2if2ulYEgSCF4yi5JkBAAwvCKanoNxoD5Jor4RasQ
	LAGnn8galP9W6OHEWU3Zcd7N8uhq3SVE=
X-Gm-Gg: Acq92OEBm+yi50PrnH3TDD2DIO2BIlmfqAokRiH0y4eH0kAkkWTfiz/e1EMOzE8wmET
	cmMGIlD36pbabwavt64amkyseqKV92YqlCVnvt/Brn6YYFdJ4ce+tKhWXKXMcvRHOco5OzX+uOv
	Qwu7gh3KO0nhrEnL/aoPTjTa3XGCwOOgz29DyL1fZzMhQGOEDoFzSpah9ogvPcqIpz9T5lO2Bjh
	91tmrnTOi7J5/tanXDyGoUdxXVkfzMRhF5RnAUEfBziInOeFosXE6Wo6jIki2eK+B209NeO+3r9
	3qQGuHHknKfB674=
X-Received: by 2002:a2e:bc24:0:b0:396:7707:b2ef with SMTP id
 38308e7fff4ca-396d09f62f9mr42773601fa.27.1780933672028; Mon, 08 Jun 2026
 08:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608151806.311513-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608151806.311513-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 11:47:41 -0400
X-Gm-Features: AVVi8CeZr9m_oRBkoyCBKJo83DfMEW3eRi7X62ZgIYngYXkBwUzToMclJrh58wI
Message-ID: <CAP+JOzTZq+6fPeq6B5dWL3wHBaiW00qxoML8ForZqcRSEr+D+w@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: bunzip: guard against size overflow
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 11:18=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> bunzip() grows the output buffer by doubling "size" with no
> overflow check. The function also returns ssize_t and
> assigns ret =3D total without bounding total. Add appropriate
> guards to prevent overflows.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/compressed_file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compress=
ed_file.c
> index 03eba117..6af81bb5 100644
> --- a/libsemanage/src/compressed_file.c
> +++ b/libsemanage/src/compressed_file.c
> @@ -20,6 +20,7 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
>   */
>
> +#include <limits.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdint.h>
> @@ -140,7 +141,15 @@ static ssize_t bunzip(semanage_handle_t *sh, FILE *f=
, void **data)
>         while (bzerror =3D=3D BZ_OK) {
>                 nBuf =3D BZ2_bzRead(&bzerror, b, buf, bufsize);
>                 if ((bzerror =3D=3D BZ_OK) || (bzerror =3D=3D BZ_STREAM_E=
ND)) {
> +                       if (nBuf > (size_t)SSIZE_MAX - total) {
> +                               ERR(sh, "Decompressed data too large.");
> +                               goto exit;
> +                       }
>                         if (total + nBuf > size) {
> +                               if (size > SIZE_MAX / 2) {
> +                                       ERR(sh, "Decompressed data too la=
rge.");
> +                                       goto exit;
> +                               }
>                                 size *=3D 2;
>                                 tmpalloc =3D realloc(uncompress, size);
>                                 if (tmpalloc =3D=3D NULL) {
> --
> 2.54.0
>
