Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03827874F
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651512; cv=pass; b=bsSExIIAdSnCzkwKeQ3vJRwrSmSNuG/bKkhndijEXpu/j8dl/QAmus+aWAMevxfTuevPvB0TBi0Iqg3YQNWtnhDiQMrzze9BXNnwOQ8BnOPZL18mLpsIcMbeaN1Bq8WqSBjWTUnbckAcj/rulUQ/fifuNFMiPmYtB78Uf0ohFHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651512; c=relaxed/simple;
	bh=4gDwdncpHldZ/TM93cQzZWLd01zntIaQWBpH38woYzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgPJ/Sp3/lvsaqpgVJv8cC+HiZJDawQBHF/2HhvmDx35nk7D42Gl+B0CuWUpU8FNcQ6PQSv8mFyX1n7W8Es1zmE+3o4gG6AE0sqyZcSxtOm0so8oZvrwNQR12q4rgHLjpSM2IfFZffoJdWpHjQWgnUO86Zw5qlkCPXFTKUB1qvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca3RG6ig; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca3RG6ig"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-caf45fc5202so8177583a12.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 09:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651510; cv=none;
        d=google.com; s=arc-20260327;
        b=rUx++gJh6nRR+gepiUm7Et2ceNP3PFUaeWZ23Wc0qBK2k56UjtXMVBuItqwLI8aaGs
         wRw6Ygm0UcHs0t2gdHQbjDYLUuA/2MHCTgSGiP4DSkDUo7XEnDwytu97rnqKXShQv5/R
         Yf8JKZ0yAlc1Mgtwlv6EfffOHaLoF0tf8+7HzjaT0UDLUfcv7QZZk0G/jl54t1FipJo7
         Z71b+DGOWHnokegp/G7/pUEvCOKMIDzVmtxGGlleRusR7owGoSLKPvjWx9ijc2V1CLaQ
         SAljo79liDNCmeoMY2vNF3X9WR6obFmJjFwqg01xyMw8FF9uRwGQCWg3bf2m8aZShqDx
         TjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8LgcsLaKu2CtqIVZ7oeJ/vA0QMvewHOu6bQajDZ3eEk=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=bX7aQu/Cm+Mi97T5TG5ai1APAH8pce3zPWDDiZus6lB5xWJkCZqTas9Ighxh+PGM4J
         rIBACTuVtXBdElC1aHMwfHTvgmrwEJq+hv+1r9jFM3bcb5u9SMhV65q7yL1iYACY9Zm5
         WDgiEwSTZDxdBmaMjXTEw1H5mHOAazd3ScA6V/qotVQoKx0r/peIzdcib8muyYkSs9rw
         6DIb3E0XE/tr6leVLM+3EQPcg8CQA3i1qaI5PTho7gq2y+ZwrY343cEB1HIiQUYqsSyt
         apQDu46VC4RAGMvU8nbVFnbfzBkrl56nXspK2TPbJM2p7q8GElr5wS78CkJKiqnqoEye
         +ZcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651510; x=1785256310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LgcsLaKu2CtqIVZ7oeJ/vA0QMvewHOu6bQajDZ3eEk=;
        b=Ca3RG6igi6P37/JGaRNiMjerP9X8sUM1/S+dPi1ypkE1bLlVl5uJjbZtb+kaZkEj8b
         3ipY1a5+uHslne2/hq7twOs1sE8z8s1t+yS8BwboT8zeFTCYWtvM/govUxRxg40Fjr8B
         /uasIkHJDpuoy0ZC2AJ2aFHroFgN52N1KHDW8ArJsgAz+RdZ42bShTSsCpLT5G0hIV0+
         siJqz5GH2AD0qCbro4tIUF8tUu6xi8OiSw4tXwj1njV4kWMx52JZwM2fSyyevfxb+1HY
         7CyWp0+hS1fYz5aisUkQJ1UWv0T6FvFX3gbtEOv0de8NYrCVHqK+0Iel9Y4Q9GkFyN99
         6C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651510; x=1785256310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LgcsLaKu2CtqIVZ7oeJ/vA0QMvewHOu6bQajDZ3eEk=;
        b=nGiP+WMbOSTt8DRH5qZZdedR14dB0708Q4rsEZsFzxgismMlPn5DXLFLHqZl7DSBXC
         Xei1pvN8oyJa4gZfETKDlrlheY6ydmv9U+x12BYLtWKCUBTKKpFR/8MtVr9PVcn1QjRq
         3X9oiVm08exBCQl3ZG87gFULaqNjSm1rUTzdtUOIe1r8/5Uj6epXRv9Qg3AwEFjhuYMT
         kqcF7ivTl5gmas+CmSJTq7fc76LE82yDrZeJOulm9AgArUFPvttT0pfaHYM5D7hiR1GT
         6CYB7xfXGU7J4vBCWwuKu3b4mAIy5kOHg2gYZC0HgFMgQLPwQT+nCc38eVW+WrSJtey4
         WbqQ==
X-Gm-Message-State: AOJu0YzCTTR3K/rvPGQGPnoBXAf41a5Zi6xZ8qlBsaUHltxFZS7XHGZB
	zrOQbQwA7NVnuBy6rH+Z3r62l9Uh3kj6zDPs50/l/73Cgl2KT4CV1UdW1wIxyW6x7SIm6AElfu3
	R5NPCdFczIn1meqeE2vvBu3S0/bWh+H4=
X-Gm-Gg: AfdE7cmZqSrpJqlhQOD/gu1Zxmcia/rzaTTFMQSmtLkwMYNqrhZTelTRNGjR8i2xvAj
	8P2v0ZZcAqp61KBAPBa6AVF1H3ikKUszAYoMeD6j1Ml8uS+s0QMvFopwNzqZq+nD6O4mMyGBbEB
	h76j/WiZTspc9Nqs1hJzKjluN6gRyP9oVt4ddeGBMIVl0BbHfGeSYCysS6zXVgitKlHT4pSLzlG
	nNhXGKSPsLO1Dlh9DsKP34ytAA5djLU942jqAP+cNp0PRoYUAdnIGZXLrgTXlO6P8vi3Lde
X-Received: by 2002:a05:6300:614e:b0:3c3:875d:704f with SMTP id
 adf61e73a8af0-3c3ad629f84mr21361079637.18.1784651510001; Tue, 21 Jul 2026
 09:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <20260721021127.1313453-2-tweek@google.com>
In-Reply-To: <20260721021127.1313453-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 12:31:38 -0400
X-Gm-Features: AUfX_my2edb1gVkdNSDMswWoD6NKok8EfqK-WQL1k1ykLADHSvZv6mIGJJXij6o
Message-ID: <CAEjxPJ67CPCWK+qmvOgwfxfaT0KVoNSRnaUzWLoHxrm9P4X54Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: support multiple contexts for the file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Update the file labeling backend to support specifying multiple
> SELABEL_OPT_PATH options in selabel_open().
>
> All provided paths are stored in rec->spec_files and processed during
> initialization. Derived files, such as substitutions (.subs, .subs_dist)
> and auxiliary contexts (.homedirs, .local), continue to be based on the
> first path (or default selinux_file_context_path()) when enabled.
>
> Duplicate checking logic is refactored into a helper function
> report_dups(). A duplicate with the same specification result is not
> fatal anymore, but a warning is still logged.
>
> Additionally, duplicate validation is moved after all files (including
> .homedirs and .local) are loaded and sorted. For single file context setu=
ps,
> the only difference in behavior is that duplicate validation now extends =
to
> fc.homedirs and fc.local.
>
> A similar multiple files setup has been used in Android for 9+ years.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  libselinux/src/label_file.c | 216 ++++++++++++++++++++++--------------
>  1 file changed, 132 insertions(+), 84 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index eb2e66da..902c9a25 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -168,28 +204,11 @@ static int nodups_spec_node(const struct spec_node =
*node, const char *path)
>                                     node1->file_kind !=3D node2->file_kin=
d)
>                                         continue;
>
> -                               rc =3D -1;
> -                               errno =3D EINVAL;
> -                               if (strcmp(node1->lr.ctx_raw,
> -                                          node2->lr.ctx_raw) !=3D 0) {
> -                                       COMPAT_LOG(
> -                                               SELINUX_ERROR,
> -                                               "%s: Multiple different s=
pecifications for %s %s  (%s and %s).\n",
> -                                               path,
> -                                               file_kind_to_string(
> -                                                       node1->file_kind)=
,
> -                                               node1->regex_str,
> -                                               node1->lr.ctx_raw,
> -                                               node2->lr.ctx_raw);
> -                               } else {
> -                                       COMPAT_LOG(
> -                                               SELINUX_ERROR,
> -                                               "%s: Multiple same specif=
ications for %s %s.\n",
> -                                               path,
> -                                               file_kind_to_string(
> -                                                       node1->file_kind)=
,
> -                                               node1->regex_str);
> -                               }
> +                               rc =3D report_dups(
> +                                       rec, node1->inputno, node2->input=
no,
> +                                       node1->lr.ctx_raw, node2->lr.ctx_=
raw,
> +                                       node1->regex_str,
> +                                       file_kind_to_string(node1->file_k=
ind));

This will clobber prior errors; need to preserve those.

>                         }
>                 }
>         }
>
