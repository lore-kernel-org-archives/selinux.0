Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3221E32D6
	for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995941; cv=pass; b=Awqo/cD/F3q0ZzOz2pX2DPcokc75wWr3jfpWRJg9UCRzBldcbdJZCit0kMmqcZbVxSkDSREhcgL2kDkO5nT5HsAAb5VAyFs/8W0RVwDUoHIF+TmGIQGMZnKMRB+Lv842j9irn1sx3Fs/JfetOqQQvChPjYioT8qyJ/qVOPjnC6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995941; c=relaxed/simple;
	bh=EAWFVPVteRKmrRSmHL701ycqpY1zFT+msjf82M6D+fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHSQW2Jn7g5Du5+l3F2rs2v7S7MiakfgfKXHhCf3QL1RaKpkCsW9UIcCKVB3n+PYe7HeLAwtsGyen/yyQ8GMafeNVMlxgptaQWwhifEd94+zDXKJC5KEAf3/kpcTFRAR7rGph2erah94Kw+ag0izzHLO+z+nFOS7GJmXBgWfMrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfYv5hV9; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfYv5hV9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e5f52b13eso1026317e87.2
        for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 07:19:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770995939; cv=none;
        d=google.com; s=arc-20240605;
        b=P6aEVNgRFk5L5B1EXDpxDRxeVaRScpba+f7AiPa14Feo5cP6e70mUP2pYsD5i4ycRn
         G7y5UR98niBunYioD0gDKw8kCr1wLFQs40GJS8/TMIx6ano95R1PHj3FdPEAca4gYlVc
         06lJYqOgeb/Gm8ZccFL7iRZagGWIqKCa0M81xGyasUoHZuWk/f14NEh2BfcDN5hfFBIm
         mb/cFg6W+8C8GOAcnsNR6dxw+dFl3AxQkVItohvxWflE0ZwvFFfMashTpS+/VbrB9k6N
         tX6M4DxfW+XP6qllFNGf2IHkgQ8uom3amGMKzLY4w7ZlS1hgPvnRI4IfbkpxzspUJvlY
         Xb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKNww5XSnGF+le+Y+DBZB4gczVB0gTTwkDRygOP+z5c=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=d5ocMFWU9WIoxkXY+kw+UUuFUcfPzcisCWEUaEAtizsykg9zJnurUHjrup04sl94+M
         1LwydW3M7WRH6OBV1sSxQZwVn5PgI7+VtJfAQMzwUZaH7TRGiJB/dYU9X0E52YdlknDJ
         hxpqObzSJO8nF9OsOWlXOHVjSPpZuwy7FwG1fPK+gxVtakh3DzmaT1wxguf4N3cJ53+x
         KiRTEsSOAlNDty5ozNabm2HV7NYLtyYSjQ0T/7VIxx/4loNkyT/rC1ahb6LYdgTpKY7o
         BHVA93SrHunOF6vOm3i2hj3bephM+PXQuT36LnuzwEA1Ksqoxr9xkuXxsGJ7jPT657bP
         vbAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770995939; x=1771600739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKNww5XSnGF+le+Y+DBZB4gczVB0gTTwkDRygOP+z5c=;
        b=ZfYv5hV9fXxC3NuulCIl1NX7urGNdw7+3T5rGP2L7CWwrWm2SIluBmOSRaKam3tST7
         DtqEsDKTNGcCo4MI+virEXjFF0tBz+dMQQ6TAoCG/kU2lP6erOuNGrPeh485ko7+YO3D
         NGuGOCCMSRgrkmKwLx7GlOYKDprucQdLBE9mX8voDOiO3eqSRHCfNj3CBtP3Oqcfdo6S
         xlP6DEBsNyYQ8jXBnY/EgCu1OAvTSyhh1nv2Vo8dSNXEQ7em1KsCHXOyq7yks9tMrp/h
         ivPzXSesQ7N6CQzCV2/jbwvf1o/NucM2KT8r+M58KsIxd7VdoPRYmR2i0ejqIFTtezdp
         iFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770995939; x=1771600739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKNww5XSnGF+le+Y+DBZB4gczVB0gTTwkDRygOP+z5c=;
        b=SXKhdLRoAQLGS9e1Y98C+IPi103vy1pYcplbzyU+COMx3RYoJ8uyhruFgawzUsaLsB
         mJgEtRKaq65uIZYdCmqfip8Op1zy7wl+R0k6yPyyv5UO9Gs9VD2sSg73JIg913HKHY5x
         O/3B3Cl+otVtSP/bH8StjqXCb4bWwGzF8PoI1nuu+t0WRDsLM+W1xjyQIEwSorWFrkeO
         lqT45jyc1imXwYqHLUFEfkRDwFdWtJ3M45dtPEgVCLIuvKPFUpxMzMez60ufSUOWu0KY
         yE5sAfObQEHMZWcQUsu7wvo+V5a5gVF6XGNgYild3mWIuga5vUE/b2CGsmJEyvFBwqMl
         4AYg==
X-Gm-Message-State: AOJu0YyErW6x3dREs2jDjy+Z0xBiD2bE0NCqk8vjGBlKrtGfrWgJE8Qt
	pFMsae/oTMH2FraaqtA3Ena+gPNW2pXur0wXzdQrQk7T4O1brpN6RPBmOSoqP+6iQ/0SDJxyY+U
	NhC5uGwGVL4sCynRWVkRLE26kuIt5hP8=
X-Gm-Gg: AZuq6aLzCW4JNxvCpRCIr7pPFP3OBVYnx8wqULTuXBoae2bpQHN6H3RwuhGP1WXB6NA
	cKS/0Aa2fCQKVfS0Dnj1gkQ1XZ5mWC10YjyOb6+vlAGl9ZVouCWa6lKhxVh3dkiWinPHqvwIJ8A
	iYRmb2rQmh5Px5sQgJEFczHQrnV6KwF4Xru0yUqehLDVtugoN3PcWBi0KKsT15qFn5hkWMHgcjq
	fHCb/12/xzUAfohz3GNBSYFQfqIdKzhvqshoszOCNxm4/x+41eAlX5Hz5DxXaGtNqjQ09cmtSBQ
	m0uL
X-Received: by 2002:ac2:51ce:0:b0:59e:476:a1ce with SMTP id
 2adb3069b0e04-59f69c7946fmr724098e87.51.1770995938438; Fri, 13 Feb 2026
 07:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202143554.97209-1-cgoettsche@seltendoof.de> <20260202143554.97209-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-4-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Feb 2026 10:18:46 -0500
X-Gm-Features: AZwV_Qjn52F2vSB_aa58yRMVxkCou3AqGjv3CLNJNapmlICVmyGgTMNl6Vhry4A
Message-ID: <CAP+JOzR72A9+vHZS8jDN=PFStQOZTLaeX3_2SJa0xMN8NJRjpQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: drop unnecessary strdup(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 3:59=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Instead of copying the digest and throwing away the original, just move
> the original one.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 8fadf4d2..34927126 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -375,13 +375,7 @@ static int add_xattr_entry(const char *directory, bo=
ol delete_nonmatch,
>                 goto oom;
>         }
>
> -       new_entry->digest =3D strdup(sha1_buf);
> -       if (!new_entry->digest) {
> -               free(new_entry->directory);
> -               free(new_entry);
> -               free(sha1_buf);
> -               goto oom;
> -       }
> +       new_entry->digest =3D sha1_buf;
>
>         new_entry->result =3D digest_result;
>
> @@ -393,7 +387,6 @@ static int add_xattr_entry(const char *directory, boo=
l delete_nonmatch,
>                 dir_xattr_last =3D new_entry;
>         }
>
> -       free(sha1_buf);
>         return 0;
>
>  oom:
> --
> 2.51.0
>
>
