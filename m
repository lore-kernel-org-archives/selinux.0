Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566833893D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674443; cv=pass; b=lVo5vN8ZNHWRhwTYs3y3osOxhx3pN6m38gIsas0zxq77oM54eHWpmBpHKRW0R41Lrd72bRFiQSrTk9pbDr23X/ZS4e3sOHMLGeHFxigl+3ltRyf994UuMHx6lY/tB/bG31BuSSlnpS5eyhWAaInS/oKQLhYK8wT1ej2QLljQUQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674443; c=relaxed/simple;
	bh=WDGouAtutT96eOhu6R3IvhiCKeobWEK5zsNx7b4fF2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uui4h3PxRCJx3B0nC8WginVnk+udLFjC5uCkRF4Kl60xMssltK6vO4LA1v9qmKOGMmJVJ3POZG/JuQPOJYxTUmMDVZeNbuPvcPIqA4qimRQzCaDxRe4Nv0um0lRoxNTyUsue+tUtBvyYHREeNpHBzyeLciQl2zjvx5OrGGcBy8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw5lWMdy; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw5lWMdy"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso1925109a91.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674441; cv=none;
        d=google.com; s=arc-20240605;
        b=jIXmipeLNAhM0xTKQwhnOk0gkMBWIqmtbYZX5m59DYY3WuXekx/aJBRwn5wvgxE34e
         j7v/yoFDUBjzJNmBSOt2/+Ciy1xHC+ev7yWATFOsduXXTqOtb1HS7BQhujRpXTeTUSJt
         GtAeEemPYA+yt1XSqdE2jUkWjqFupQSioNrH6S52FIgBlAi9IaHb6VXQjLytpnn+44Tv
         NI+eEJikQQp624yIcUlxuZUucGljcjWISI/cSCn8D0GyR9sGf8EwdKAD0xewFsd7B5lK
         SmiMLoqjwK6/nfbaEOZ8apg9TLGmLi/bOxNvYsYHSIBX6cFhpFWM3obVIgIzkzskNinj
         X6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9TlVn6OIKaetv2E22YUFhAZIMHFrtJkr1HOfNw6pxrw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=IKyx/PPx71UIjxCRCEep1e+IV5RKP6hLtoNgxUQWDjcd30Uk6Qba3watoLwUEUTEbS
         epd0ZfBeFgxFLK8LzZEIiXikXYuCzn1wf9/+Lv75cr/8T9MDwSGJxrPiE75X/KFSUEu3
         d0kIUHM8zL6dWcfLfSvWYNcpLpifcqCxhNGlEhp047r8VW/CAdGq4dfb7KcfTR7oPUQB
         iUDxx7333Ad6wgLyc70NNs+p0ODjKteN++33WpL+IOADihZe1PCGNQ9Z9Ih5bH2SMgf8
         w3kq4GSuH5+XJ+BTIPtdeViaQ7fPIsotdPYWsu2wnNcOpxs63CtOKUcC+wMRv6rIU/5d
         7E4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674441; x=1781279241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TlVn6OIKaetv2E22YUFhAZIMHFrtJkr1HOfNw6pxrw=;
        b=nw5lWMdyCKlEBL8qHkpBq5TTuNYsxIS8HdJ3nMWSMIHcoF+jraHFRp6QU4NzaQUesR
         3w2N0tpjYq2ek/7JZad11hloOPEyo+CMsZXPbJXTWnR5qMNzvl0XBnJ4FPtdu3g7BXAw
         Hy4zyXk/b+VB6QBoMYZ9t7ZYANtgqkD6tEV4ja2xkIV/FXeCH8lcPQUZASiRJQuTYQQ1
         5Q5SAc9KGRJ+GVdYm0d8rZhXZsSudKZP5tX3ByOBFGQvpbc6VCIpPJL+ZhgzXFhxs7Nl
         PseX5W1pMJ6E7F9z7OLnapMtNtCYDyYooiHLhiUA/r9DP4nCqVkbnCyuZZMLHaxRg5S2
         xlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674441; x=1781279241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TlVn6OIKaetv2E22YUFhAZIMHFrtJkr1HOfNw6pxrw=;
        b=mMdj3jfA8GFnpGkGrTZ+7eRJPi3JhW0XbvVAhgOR/ssyc8LmyIHKoXDgit7SwUh3FP
         q640vT1yKPWqMzUlvQqSvzkVwqzyba/n2ODMTPc8N+or3gy9RWRh420yB4Dl9Yzuksyr
         a6BNtYVtWnm0cQPaXUZj2zTxcNaC86OgD4x5b2AKOc8RX0ZLcGuXTP2IU4zlPibeLE8J
         2PfEp3q/yobr408aCNM1rokTXk59M0JNbxNZzkof0Wtcu7OAMAVrs4DyfFDtMD2nGX9h
         kVZf9gHwMRKZ6ny6Jim2jpTh0pXLKIWlEpf54YNatNAsBlmSPhNzGrx8vlnC2FkmaXB5
         RFiA==
X-Gm-Message-State: AOJu0YyGynl4Cql5Go1tk7edoXgxmfFdQldp5AOE+R2e/oV0bGkdT+91
	oMV3aAEQoE2HrqqDceaeDI11CwZzXo8CYe4RYxlhDjXDkQ4jlMrd0S5b/01x/A4KDP14hxkoClB
	0/O7EPlUWjtKKNpYd4Q9Tnc0nfWUwP0E=
X-Gm-Gg: Acq92OErI/gnkzqZyqJogASTxYSAukJagiLtxrw/wnj16hb8++7LRYdKWyeupd3SKBu
	m5gIo7oTW3b4k+4DjIOUds1XqGoGS5W6xxG0nr28QUYNxpmVDRjj8zr64A7OzAIRMINweGlFo/O
	VcVGBM0AoEsw1YUT1AnM61GwNpJgtlcI4bV8+lnJV/IPqhRHlEmWZ9wOkuLCm9ETFuwgcVh/yio
	igrRQbEyOJRjbn/ds3CPJQ94Ad5ASiR7Yk4KwcfmqvXO3zyqjh+Nmo1SeBdwz15JdSXc2QSye7x
	eahPyprV9JpnPdbXZA==
X-Received: by 2002:a17:90b:38c8:b0:36d:b12f:613c with SMTP id
 98e67ed59e1d1-370ef2f0208mr4726728a91.10.1780674441298; Fri, 05 Jun 2026
 08:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605140203.76848-1-cgoettsche@seltendoof.de> <20260605140203.76848-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 11:47:10 -0400
X-Gm-Features: AVHnY4LyFfGRMq2cCkWb7aWApyQ4Ksaz342d4fp99J7hIxFcjvBx97ZwBFyuOWk
Message-ID: <CAEjxPJ4=-_kZJuLsMqyP4yFciBQpBKumLxEeu0xit7BRVH7vAA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: bounds-check serialized regex length
 before PCRE2 decode
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> regex_load_mmap() (PCRE2 build) passed mmap_area->next_addr to
> pcre2_serialize_get_number_of_codes() and pcre2_serialize_decode()
> before verifying that entry_len bytes were actually within the mapped
> region.  The bounds check via next_entry() only happened afterwards.
>
> Those PCRE2 routines take no buffer-length argument and trust the
> serialized stream, so a crafted compiled fcontext file (e.g. a
> file_contexts.bin reached via selabel_open() with SELABEL_OPT_PATH or a
> "-f" argument to setfiles/restorecon) could trigger an out-of-bounds
> read.  The version/architecture gate (do_load_precompregex) is not a
> security boundary: the embedded version and arch strings are plain text
> in the file and trivially forged to match the host.
>
> Validate entry_len against mmap_area->next_len before the PCRE2 calls,
> mirroring the ordering already used in the PCRE1 code path.
>
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/regex.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index c40d4cb4..0289a45a 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -137,6 +137,9 @@ int regex_load_mmap(struct mmap_area *mmap_area, stru=
ct regex_data **regex,
>
>         entry_len =3D be32toh(data_u32);
>
> +       if (entry_len > mmap_area->next_len)
> +               return -1;
> +
>         if (entry_len && do_load_precompregex) {
>                 /*
>                  * this should yield exactly one because we store one pat=
tern at
> --
> 2.53.0
>
>
