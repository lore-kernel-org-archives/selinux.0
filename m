Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5693364044
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908916; cv=pass; b=emQ+aXtjBNsmVHB26Mt8j2aVHSwmEPQmFF/PEfXt+47T5zn1zgHLm3kvBg0gAT8utv77GiO8WifrGLnyL3gMo+Z+fPFZH+HKQ8mWGyKlyt5O1oZs+jKWI4Zz2Bn3Z3517WNVEL4/ucXK3/F5NVWu4E8m52Cnbboj8THN7U4vkX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908916; c=relaxed/simple;
	bh=8aYMJ/SJNVthqJROcqmV6RdxLPxtJ9UamisdhucK48Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuuhZ+NHbkjFtSyPd0Y7YjxaxRRq84ypf2NvQNRPjPc5hTxBYLpUJpn6zI4y8GX2LWREoIE7akblH8yyoQPaHG91ESthAVAj6JZM6E+EBSIxHevAD/Mf6NfoTiS0fLfSIfJ5LuyIONT7L8EvBX9PJT61O46NRoaAC+/P7hxdDWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1li0KuF; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1li0KuF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c801b30188dso5323876a12.3
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908915; cv=none;
        d=google.com; s=arc-20240605;
        b=JveaiXVCIbERNz4tcGWBNCVhMUK70/t97Hy6RLH1QwJO3K/hZ+iOtegWRqHAA2kuoh
         UsW2svVI07oXI7j6Vf98pLv3h/J6MS0rBAp+rzpd3s8urfU2r2eV+OJxxu6ASirSj92x
         7vH3liL7fq0Lp+CAtLB736SKgXDAW7q7HmDQH1ff+5Vp0AC16K25z9d45psa0cY6f0vX
         dl5xz+NuLFypmy9QcpgHFJg1E5hF11FvBslZCk+JUf6Rj8GtXW24fcB3IFZAzN9vtHVA
         GDSFulosOci6xLja7tw3C94RYx5qwpQOhFbfKePp76RRdgx4/gLGpcjWkqP8Rpms9hRT
         tfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RV1mEZsaTdii1eXkKN4+YpSmDnv/QzWE41nZnKsJypM=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=aK7VlgyqkDMOr2KgETeYklqaMnflwM5BPCRjXyAKJvNFZDoVJhCOpnACd2H+l4FdPK
         YXMzv0UH2M0XI89fU3QtZw+LpzmYxLhB4MxUUFbBgqmdyTGb/Q6MANZAfLT4PzopmbE7
         +ItFHOcpYhCK8yy9JBN94+0v3sOMxtVlC7TrvsGdOvTTDgmyntURGGpE0l1OUhHZI1mz
         UNlTOc4WwUkpqmAYw1nGU6rwCee/MByn9gBkoU/tvdEqWJNvKHPexvZ8Xqm6lhKFYIWc
         41scuzdKWmkybga1g63zT3eItokeCGyc/vJ/jTJMYm/mKSJM0sYPJVJdnaDMiCjNTk6J
         aIGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779908915; x=1780513715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV1mEZsaTdii1eXkKN4+YpSmDnv/QzWE41nZnKsJypM=;
        b=C1li0KuFZyw1ABoLlNeX2N2/HtqNj8AB7mKSHlzx4U/PtIZNmr00b1fTp/zI0d/kHl
         ZzxzFZKIIEeeJlyPktNIqyvKX5yIuYvKgmx1XVRTMUkTSrNqTNsgb76JGxDiz5tU4OEz
         t9iY2pNuFYQyIvtAvIZ13RfcIBVuCTBvvSc5zboCxjYJHfhT6ZEFrBeePr2LBP6aGe2F
         TmoHGii7BcRfoCXh7y4Cbz1kr7Qbn4IgFg03hHiR4QYyghVZC12tZEwHC0fcDlXgD1PQ
         3Vr8IA+gGqR4dy8mhLgDAt4cruBgNOO2jayQBvyeIVHxn9rnUdQS85ZLo4UQ61b31hfP
         js0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908915; x=1780513715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RV1mEZsaTdii1eXkKN4+YpSmDnv/QzWE41nZnKsJypM=;
        b=XyuDkbjyzJWQRHoyGTYM/4GmW/2ZEqaBVZYwxZ0LCIinDjUoDQgk5T1+zrBJzPG8O5
         elPjZH7ZKfWJ0Jt64g6VrwZEuuulbppiHJgvqqpeNbI2SQFHzwpXJYspgtPN8UJ99FSN
         7QHRfp0VpS60LNJj5uRfbIibmVl1xKQHbvqocPsinZmIAEHeokBPOWr3uoxJV0Tie0ad
         z3bzBXVpyDytj2Z8Pe6vGN44kjwHxm5Dg39CSJi4lpA8asRvAvPwu4t3cHbm3rMYWCoC
         eqFQTMxayWV9HTFTrw72DXzote7VjgYiVr/eUcgIM4T+0IgN0Q7W+fW+li61REEd8X2l
         WZJg==
X-Gm-Message-State: AOJu0YxlfMA2P9GjldGAsbIq/AAh6zQQFLeI5Pzj6OudmLSWP2ghm8HF
	dwVuHhzOMUnD8rSEYivy51ZJQK4v2UKMLSzHEkGESbAWVSPSUpaUqNzCAM0gkB5XR4fqDCyjHPW
	MBLlTXlj5SmvizoIpzInagvyhQu+5lV7VwiIF
X-Gm-Gg: Acq92OEBmsIMtbfove74+UGyJyVt3CKN01QjvEq79YFCwZXGcudmqyBczdCytSoiqjg
	s1/5HF4+N1P+WlLRP3/C4shT09wLcCmbNGxekQ16nSxiYNmjTFzXbj2QxirF/efHJfUrAK7LEPs
	35D0uHL7pX1Ebuupzq1R4khFfI+KpZvVXbI2HnW919h0pf8eDmZT+zCLdtWtTqlmz/9rtuN3Dqa
	BcbJ7feavl0dBGBAXwDzyJMbWBcgyOebRzDplTVZTrqz/xKvHsN7Vzj06QEqfr52Is/YCpFEC5D
	I80sFTck0nQiG5ss3A==
X-Received: by 2002:a05:6a21:7105:b0:3a0:c2b4:d976 with SMTP id
 adf61e73a8af0-3b3293c0a32mr24533203637.44.1779908915174; Wed, 27 May 2026
 12:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526202640.19141-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260526202640.19141-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:08:24 -0400
X-Gm-Features: AVHnY4I_w5HZrmMMlzaFWg5kxzNqtF8RIRfzNeQRRxP-Cdw8TWj0mF3llDV8RtM
Message-ID: <CAEjxPJ5GdwakM_3+BSvroDqTJ2-qpOBP2f=me9qUaAnxXYoV_w@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: avoid size_t underflow
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 4:26=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Since the prefix and suffix regexes are matched independently
> and unanchored, the matches may overlap such that end < start.
> Prevent size_t underflow in this case.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 002877e4..1baf7ba9 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1280,8 +1280,12 @@ compute_raw_from_trans(const char *level, domain_t=
 *domain) {
>                              (g->prefixes && prefix) ||
>                              (g->suffixes && suffix)) &&
>                              g->word_regexp) {
> -                               char *s =3D work + prefix_offset + prefix=
_len;
> -                               PCRE2_SIZE len =3D (suffix_len ? suffix_o=
ffset : work_len) - prefix_len - prefix_offset;
> +                               PCRE2_SIZE start =3D prefix_offset + pref=
ix_len;
> +                               PCRE2_SIZE end =3D (suffix_len ? suffix_o=
ffset : work_len);
> +                               if (end < start)
> +                                       goto no_word_match;
> +                               char *s =3D work + start;
> +                               PCRE2_SIZE len =3D end - start;
>                                 match_data =3D pcre2_match_data_create_fr=
om_pattern(g->word_regexp, NULL);
>                                 if (!match_data) {
>                                         log_error("allocation error %s", =
strerror(errno));
> @@ -1342,6 +1346,7 @@ compute_raw_from_trans(const char *level, domain_t =
*domain) {
>                                 pcre2_match_data_free(match_data);
>                                 match_data =3D NULL;
>                         }
> +no_word_match:
>  /* YYY */
>                         complete=3D1;
>                         char *p =3D work;
> --
> 2.54.0
>
