Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2D2DCC08
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081010; cv=pass; b=WKhW4kEfFeRTuh0EnhKPGoQzBGD2ULPHnKl2WT/VTrJ/4Ng3v8gpki7piRXpQYTsiyaGK5C+EUHbRSmEKqVre7LUYSJK7KD8ozPo/5S+mxcq7yzDCElVHqLMe0ehClPwJr+WJ/s4lv4oA6F20zXzoB6n23qThsMO6lBg2GTuNWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081010; c=relaxed/simple;
	bh=DXuNxX7s5HLGzjWgmYUGjYQjEYK7X8BGzNXmE0b/M9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaNM0BJ5riMcNvjTV4IsUeCtNLotWQAzf+31t1+PNV333LzFSD6GwXxImrYQwieBNYZ5nyVHCZbuvWEew6Qqhf6lA0Wnz3fg66gAmjyk2JySyjPh3rE+Zdm96Q9wGk/nvD4goj11FFUBO4WbK7bNIJC1myrEogNwukf37c7kYOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFylIezs; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFylIezs"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso203791a12.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 11:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780081009; cv=none;
        d=google.com; s=arc-20240605;
        b=jTPhYINsV/riRznQcmz8R02JWrO4ATrDEfSo0JZQIy54PQwOK1BC0IJF7pnimzKGzV
         abxzl2ogp8gs2xMAMo8vhszLvd81Qd3ZfDijUndcBVVsSADm3J5NikDwQ03LPlNoXShN
         EtUOsrlXcfmYD0VVvgcPNHH9tib9eLdilpbDqUt6ByO/LPNQVaKo8qgLhGFLBbvmvtd/
         7bibrx3xXdESGoAsnnRgp58818vzegf3rQLtWomn2okxBQnnew+QqofVoaH/XN597tG0
         Gg92khv5o0FRvry1bv/PSlrCxM/KWNZR6Ep6/LxQcEHLJBGZfl6gNd9Hpi37hW4VoI32
         9B+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1JgAz2i3H3UmhM4AKslKFFMOo1KQVGNY+m4b2a/wS44=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=UU+55xYHWJ+le/kgU6LMHsmI5Y7q6qF7mYK+CLk13Yt2Q35bq73eAmYnhvPUAb1LyJ
         Dm1Ftr7Pzs4u9ZworuD0EZSltyDG1q6wEyZeeEnAbODndKSMCIRos0LSWaXtDNzMlXRJ
         iJ4Yw2AF77nq4idBKNwBRF/J0rLI+qRNMa9jzdsedFT7vdVgwdtBuTEU2KbCNCCjQLBw
         3bxx6ghsgwO9QTbJ/H4XbMCMfti4b21DrwDrIIEc+8i1NR+go8abYIqJaun2x+WoJV+f
         fHEK6Zprj9Ku6nJmJnE3Cd3zB/RQrqIuLM2JWw9JUtLBtXi1Au2HfSPWYxhI16NMcd+a
         cQzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780081009; x=1780685809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JgAz2i3H3UmhM4AKslKFFMOo1KQVGNY+m4b2a/wS44=;
        b=JFylIezsP90/vw8uLh39dcqrtVy6SMSFegdhlmEvjaoRhnVbh+KcSGqbdJW/z+N3aQ
         y5sz9ZnNSTOim/HrTLTtyUvI13x1R7Ntr81qQITaJvVmqRgulSapacMUdR8JW8EBngRS
         u2b9Hamxx4W7810RgzXRHTnUA4bxRK650JKMcyJPu/K1ycCHqIg5WT/1h/p078GgWdU8
         7vkCdl1GPWZMgRiD9Z9h67hFFCX8QrkrAChqIuiRUadxlnWSc/OWseSDoh9ZS1ymH1+2
         n3WPBjKhIRLPNqvojmVEBZ454znBHKeoWmw0gzJbEnhmSU4d1Dy2vPUUmWjoByCshGUX
         tT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780081009; x=1780685809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JgAz2i3H3UmhM4AKslKFFMOo1KQVGNY+m4b2a/wS44=;
        b=K6CtLQFKXLVbvEPq4vbMcEfMWZerQuKjxrOU4wcRoBNB2SfKpcEvhSybZ8OHaSW/LM
         9NFYqtBziK431Qu2PqEa+dEY4cAw4VXMhZhYkd4dzYO+Yhh2CpIW8CVP6Tav5goqUNKf
         zyoJTQqEkjTiQth8rfZ5m29hjH5yM+vkXIRJACHjCMl+71300ncGt1l8pC2S51/NPhvu
         Qsw/vFz99i+2lV23Fspg+Mnj7lAqKuuL8mMO7l3z+xeYmAYxWvyY6Nf9RUFdJM/PnsON
         RWNbiQdL25pgMUFDjzMFUH+yC7maRJqVlyC7lZFoB5H8uXXh2c89+Q8/rEDZWP+UNT5c
         p3SA==
X-Gm-Message-State: AOJu0YzuyHBpJdeKE67PgihLUPN5jptRRexCiJs/sihi1c4+nPU9FjT0
	7uOLu/ah9aLrblyoK8AN7iWpaRUdrd+MgQsBUSaDdE5etiwRXynGAvMLn8BWLW0dqznVp5Jy0uW
	JpkJSCKtDcXNzGzEM/H3PAyz23woHSCZzHg==
X-Gm-Gg: Acq92OHWL4cvjy71GgFHVDxa32K6hS2RaOpBuz8v1otYxOcSHOe6llX8DPzPHwfyshw
	ZhzSo4d9EUEBmUlxnJ83uBqRD0ZztncAZQprh1MWR5DFKaTIYvhbrIb17Edjygh3ic/fRrgjLL2
	emfu/bfobW3VfalIKP9VWhJozsCqSd6pRkN/HP8uzAXZ3TJGRAWI12ed3PfwS9IwvrBFNqx9BCT
	WicPDXRgBlSGn56SlFN/99fROPNpytwputo/CiIZiFGmW0x4b5fxCdt+rAh4vAOl6o3Aj+jUrwt
	f2RZyrJABNZczZBXGQ==
X-Received: by 2002:a17:903:3585:b0:2bd:eeb6:ff28 with SMTP id
 d9443c01a7336-2bf367c3452mr12922215ad.12.1780081008909; Fri, 29 May 2026
 11:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529175640.151814-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260529175640.151814-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 May 2026 14:56:36 -0400
X-Gm-Features: AVHnY4IsR3065AKPFic5B3k_BNXqoAUjcZQjevdxQ5Tx3G1OH2ha3G-5WHy78fI
Message-ID: <CAEjxPJ5DXqjg=Y4mXcrFOBfKx0=Fv2Bz1PTDWk11gUbwhEsqyw@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: check and handle NULL returns from create_*()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Fix several instances where the return value of create_*()
> wasn't being checked.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index ff33621c..733eed18 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -803,6 +803,8 @@ process_trans(char *buffer) {
>
>         if (!strcmp(raw, "Domain")) {
>                 domain =3D create_domain(tok);
> +               if (!domain)
> +                       return -1;
>                 group =3D NULL;
>                 return 0;
>         }
> @@ -1479,6 +1481,8 @@ compute_trans_from_raw(const char *level, domain_t =
*domain) {
>
>                                 if (! *t) {
>                                         word_group_t *wg =3D create_group=
(&groups, g->name);
> +                                       if (!wg)
> +                                               goto err;
>                                         if (g->prefixes)
>                                                 if (append(&wg->prefixes,=
 g->prefixes->text) < 0)
>                                                         goto err;
> @@ -1551,7 +1555,8 @@ compute_trans_from_raw(const char *level, domain_t =
*domain) {
>                                         for (t =3D &groups; *t; t =3D &(*=
t)->next)
>                                                 if (!strcmp(currentGroup-=
>name, (*t)->name))
>                                                         break;
> -                                       create_word(&(*t)->words, current=
Word->text);
> +                                       if (!create_word(&(*t)->words, cu=
rrentWord->text))
> +                                               goto err;
>                                         change++;
>                                 }
>                         }
> --
> 2.54.0
>
