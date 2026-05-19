Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682103016FB
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219437; cv=pass; b=WyY295cyl2Mj+7LzzAQS6OOqt+XNMHrc6CfEeV6kJVz0e/roLj6Sc5QuQW2w78qgBSiOmN82lBgc1dAoatY/iietbjSkA0/jNJn+htrwEUaK7c0vfF1i7qWi3fRiCzBZBUanLG6jjKrZYNchR7nReGsR9CrDqE36GaXTd+xp+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219437; c=relaxed/simple;
	bh=4efPdwypmP/SLkETOkRFmJOWId+J2I45eeNw+u364s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Svn9KYBHH3RGLWKVwsLxpd30tn5h25HnnCufWdKMa2IIhzr0TsGob+6hQERwSx3wYEK8os0wyTje2ZPskHG4l2LJeFfGYFNJ1hCpkZ3TKlFvQvV/BfhK1zAafMt+IvKbV+zAt1bGPiEp9tlIQ4l0ulxcl0ty80Ik01fNUY4Un7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRM9R//o; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRM9R//o"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso38013991fa.2
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779219434; cv=none;
        d=google.com; s=arc-20240605;
        b=iGTtBS1BOHX2JHrQft0EBxwmvtZj60jlZrAXyv9SYUa8i5GnmGBb4mk5kmylhQ40Rw
         Nqwk6ejGJD38StntzBf4j9RwL46SFXHtxjWamd9AU4ekOfqRmt1pX9WPzhLIaVLYGu2P
         /XZvWU0LS3rf8X2HeYes+crJE/VntN4h7KeCksnA5m4yH1ecop5XGI6Ji65KzFC1tFYd
         e2+ZXz+pQFC/ga54Hicb4tGuuwD/N/M0auPr1nkn3jaapy/6rCMFhbRUOQ7Ud6DHiSQB
         qXjdFK2kmf4PgMQdqEqrNwhgx7FQJakGxhvJ8xcYf1hXUkJ1S+ePZoCd+hCIito5nt2B
         fG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R9iZDKuODbH9EMrnz0ak1FEu/LoI0fr7qltS8UhJpVE=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=jc/+kW9vLlq5FCPxVEgQHyigkP6hnS4+Qgwoo7oOC1hZwTDTfY4iiN+5Yr+KSmd/b2
         gCD99+k7hmn6g5+TZYDv8iM1MOiS08Stj6KrSvd4v6+VffaFnQvaixkgRrN9IXRtWoI2
         x4O40ybzxPy1CaTBR+K5N1wtEaNfumXp7qtOeKShLDR1tBCGoT3Go35fWT+8+7GICY6J
         Q1zdJl5326ZvZZ2MDzbMnm1+cxteQn3xUADlEb3Fk0d8fpe3kw+Gpzr28z6fOdUL8ZVg
         3X49U3mSCPe6KRlMgr/Uk+zEYRtjCdDyzXfoMRvFANFB319/NmptnsVeTzqT8sULI+Xz
         pGMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219434; x=1779824234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9iZDKuODbH9EMrnz0ak1FEu/LoI0fr7qltS8UhJpVE=;
        b=GRM9R//o93TpfRhrs37m16sj0n1QsFgNC5IGb1+Z426/d0kvIhYTWjcmcfHDCP6JQv
         tIykBhBAha2nV+BYwROdu44mHBeXzZYKXMepziJf+U+zmJ2zaPzR3Omtvqd5skbVd+pX
         yjmeB3YDIthWd8ahg5oEd+V1QDr3tQvmKEaDp0Zm6GQgngNAU3Rrb1QToabjWO2UDa6v
         Gip4m/T94rGc0BdO0aGi9cuJ/VdsihErE3usD3IVDSnSokz4tuwlVO63nRCLI0s3VMid
         xd0M8xabXJ+Jx+PSc03/voDyhqXZyIbWjWZQVwzQCkQ8kdIzRHyDLHegX/4p+nDCreah
         z9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219434; x=1779824234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9iZDKuODbH9EMrnz0ak1FEu/LoI0fr7qltS8UhJpVE=;
        b=Vm948v39hXCf2yQeqdzuXThK+lkc96aTZBPoSivK0q7sc5A6Mq86jAwhHy2dmtsbBu
         /qEd8VWJ7Wh5mDXwpKLUkK2/Zbj9UxKtiA4FVYQ8/W9yVtqZcYZ3da0J70yPtdLA5z9/
         RJUA0/jnFI+XctJn6hBEm3fxIAgqrWnGs6N0JG7fkFbVbvYmmIEe1tGVQLraTsIwcnZN
         +PLRoNgcQv0azw2R1KkKkhGI2E/aeYOwPR3KSsOLxMKqiLVdJi8vH1jrG5I0UYFhQCSP
         mnVTpD47HHIHR6rQI5D3y+m0Gzmnd2dVqvbr0vqJbglEMqrNigYax7mrymCHEjIr33HM
         yBTQ==
X-Gm-Message-State: AOJu0YwivywvxFACc5wGkHwp0q+3wu2v+INq8r8fPPPbJpHJC8/dOOop
	4uAi8LUZKE9r+lL1UCxdiVAaCnhWfNVS8twZ+2hsUchqHmV2TtfMmTxsj0MqWnB+elHy5VMt5jA
	BU/HQ/Soi0D20m2gnkb8YjEM1jhnQGCjTp/K6
X-Gm-Gg: Acq92OEgt8+gf80AxBvNfGkrx1+afP3FUvC7zQg4y5Zn05TS+bevjjCnlWqiFFwJLwO
	iSsXbQizcTr/YzTjyy3Vt5CM+70MnyoaBbhwSXTq8lOhRbwQcWg7Eeg5vI+kO+GhjJt0CKTE4QI
	1Hw1U6J/Zlh3A4AGqZnYAWkGvesIWbrDpxpIzRAc0YDREUb8y6qRNPLJMTMcIJYSyxCS9H5tcGM
	SzrnE12TLasApehJED88u3yeHc6Yqs7nsI7YdWalnmbWEJBYAVnLvND1ekLVZpJ6QrWk3dSp0a6
	iYvS
X-Received: by 2002:a05:651c:1503:b0:394:7f1:5114 with SMTP id
 38308e7fff4ca-39561d65053mr63592041fa.28.1779219433349; Tue, 19 May 2026
 12:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507162107.70210-1-kalevi@kolttonen.fi>
In-Reply-To: <20260507162107.70210-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 19 May 2026 15:37:01 -0400
X-Gm-Features: AVHnY4KebGfBKLo9VLZOJKMap3-AohId_yUAo28v0IOzHRIwUCzQw4ei3tLCZ_U
Message-ID: <CAP+JOzQjauSGvLamzAaX7jkUDHR3s_5zYuDTrGR_wOTasxy5Qg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: remove useless assignment and test
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 12:27=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_support.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 57e191c8..3cfd92ed 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -190,13 +190,11 @@ int  digest_add_specfile(struct selabel_digest *dig=
est, FILE *fp,
>                                             1, buf_len, fp) !=3D buf_len)
>                         return -1;
>
> -       } else if (from_addr) {
> -               tmp_buf =3D memcpy(digest->hashbuf +
> -                                   (digest->hashbuf_size - buf_len),
> -                                   from_addr, buf_len);
> -               if (!tmp_buf)
> -                       return -1;
> -       }
> +       } else if (from_addr)
> +               memcpy(digest->hashbuf +
> +                           (digest->hashbuf_size - buf_len),
> +                           from_addr, buf_len);
> +
>         /* Now add path to list */
>         digest->specfile_list[digest->specfile_cnt] =3D strdup(path);
>         if (!digest->specfile_list[digest->specfile_cnt])
> --
> 2.54.0
>
>
