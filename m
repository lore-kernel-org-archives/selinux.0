Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639743D5227
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226509; cv=pass; b=EFIM6MzTGFHyLNnbiqqT1bX5h91zAr+OuaTpb14eVUJUUdJP0epdLZJJH1kyaNhlyLTN0fJ5tkrSUWvXQnlGYHmqm8iN7ljyoDv4y5ARyrQPr0SRrQEyHRk0xSv5wxMyzRZ2bCmtmQbxjGpDhjrQRoJeshzE+eoQbxu5zdjyWMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226509; c=relaxed/simple;
	bh=fNMhPXX5hkfbZ/MzqldaRB+ZniHNMpI88GUGEwhQ0Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhLlfu3xXKEsQyuIaT7aIJRPPFSPc/sOpYXDRqdvQYSUqrMMrlxKSXy4aMC0/01oiwCQM4zl1bS6+XsdKktQb34KgOyjrwBkhn6fJY3j3Hl7xx8ovm5qnifV8xI/T6e6ODnk6sMn9lz+I/PXHp2TYj5Ea/4vxziDDb8RcK9g82E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URnXP7jJ; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URnXP7jJ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8584e80d59so2301970a12.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226508; cv=none;
        d=google.com; s=arc-20240605;
        b=gOUpbdpuGh+qeriUSLObyM12hWg0tEQ5esdlUOwGxMAGiwqSCxa7r7YmmRY9/h+zHk
         WZ8+OV9SaNXD9273uua520LrY3SqHI16C1IBV949HvbovVGh9aR6bWQ0OPBQj5Z3Wzx6
         OShIQ1s637cKpg0m4xxheljRiHHpmxUm3Ht4uk1yagOinZczypCzmjnJPYUoBX7+itii
         fmspF8CVYKQwMNiuZk4XC4EB+SCoFiF+8f48fUg+Jfc3ESRarCSvR3SgVxCwAlh249LN
         O9/U367YlbxkxsyxhOs4LNiM+TyvV0kpsENLInFU7ZwlntPppATe2xS/rjYGO7pQ7epM
         UoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zfQkfmZPc53M5pI+MctZxbXsoD6rzAM1oRbk7cfbNA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=bDEDGg0cgmx6DJS3Q8FQILWwehotApOG5LDJlSPbC7HW6XQoXQJ6+dhZWuU5V+Gzts
         z3AVRrWrJjCvbqc3wpqPKYy1rgVzrS6oPMA5UGLAp7eNldFAZruGQyEyGrAMjPBKlUkO
         KO9mpgjswk8fk7UPWd3IR/69ThsojUQ+U1FRg3c4q7CsK+1+fMBd9Fm/xeYfKEfygiA+
         8dJXPqOw0yC4mFA/H8oWvJSH58RHbgQvXopXF9/iyzT78yiV4C2nttBHENK3ajFRbHDn
         Ywz0RnaTa7VLJboHD2htGhpVAfy30YO6BXG4VVNWkIf29KpZ0Zzvsh8AeeyH1ZYt8lq6
         Y/Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226508; x=1782831308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zfQkfmZPc53M5pI+MctZxbXsoD6rzAM1oRbk7cfbNA=;
        b=URnXP7jJNHI6oDAdORynUnISSz4EPHgcvbec/SDDTs4fufyDzVVj5S+z2T1kOmQvRd
         rD4DGe5AmziI60zawZUrvEpU07YTVwCYFyzfiXsdoTFG/luf/YOyBBiSA/s1WaWqIcrE
         r/6qHNb+4YqjnrE+/5AE5z7bkBeDwdBwPhZVffpHZ//crzGERDSzUDGUHQBhg+jwqoua
         ujcktFN5h7/IsSNp8tRoXfk6qEfwejSE6wuXh5LKICSFEgMKiLnb5T2sKDIk36Y0e/x5
         p/BlZ3ndKd1iVMTh1zpLFMO6mYhXEcDnzTHOVm1+L6tqeuIKVNqW0NAciLiFZIicvHf3
         vPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226508; x=1782831308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zfQkfmZPc53M5pI+MctZxbXsoD6rzAM1oRbk7cfbNA=;
        b=I5ut0rPCsghOzi4hVJEYczmIeL6PJ4qh/PobzqPGKBE4cztdiEKD+7RR35hN5CWoRv
         pfiuHzRbwbFLfeGvNSSwaR82T6C/2s8p34SQB05IMbxnTV/R6nxrVlMYBBt8DBSP5o4f
         cPcQjCH3K+zo4pMzGr/IPfz8NJw3rTLswXtFtzhh35szDT3HI2KB9YZGb/doI99Hp1/f
         TCb4piH35GtN3mfjcY2SFknoLtRrCVR3IJBy+ivx45jtkv9NqakW6tgGtTJudv8+/+3e
         mMBxEMExiiH7D9MD/MYE4lwXzdqAH6BJGz3HbtIGxfVV9zzLeeNL5cBLOijyRF43H1ej
         r8kQ==
X-Gm-Message-State: AOJu0Yyl43bTYbXbxcib2F8t2dWM98KGOvx6DDwQ4WCeJXKpXEgmVqdA
	FGyF2qXtWtXKLTFOLwuB5RzdNLNC730l95WW9rwZtLj7JiVCwtHBRAIa64rDDBrzZsN4YR+ROt/
	FeyxPGx0ZPZepGOZc/cT5syWMqHHdC+i0BA==
X-Gm-Gg: AfdE7cmIMIFkv07p7QGmMgYeqGRDOMDPiXKZ3b71Hwrgzr7atPE3r1iGWOp/2p6bHfk
	7g9Z0L8hmsy5WL91m3eeGSrsYF0CIUBv3Pg1X1GSVOC6Qfm7qvZRtn3FCgmsZG+rLgFSQW+3JlX
	5nI5EgkT6VvVDmJu00Q6ZjG804SvRhncs/nHiDOxKrGqK9JcSX0L3lVnWbwrRTwEJYBKjBCwxrd
	btAA/hwROMFTdKNDFEMp0zo5+LkVc3QoVQMFbmzYxTVsDLIsCyt1AVtpmS1/YHQyUA3gby0
X-Received: by 2002:a05:6a21:4584:b0:3bc:5284:4859 with SMTP id
 adf61e73a8af0-3bd14f55bfcmr4288253637.13.1782226507704; Tue, 23 Jun 2026
 07:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:54:55 -0400
X-Gm-Features: AVVi8CdDbVRK7_iNkka9s12pzP5ELI1pvT1uoD4sL9Z5uwQhIUYx4veSv8-s81E
Message-ID: <CAEjxPJ7=Vpt7zBHOJ+Q9O-r4A+WzqW58gwzG3LcF2GHwWB5Lig@mail.gmail.com>
Subject: Re: [PATCH 02/24] libselinux/utils: fix matchpathcon usage
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add the supported -q flag to matchpathcon's usage string.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/utils/matchpathcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpath=
con.c
> index d8b9216c..ebf3c94d 100644
> --- a/libselinux/utils/matchpathcon.c
> +++ b/libselinux/utils/matchpathcon.c
> @@ -13,7 +13,7 @@
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_fi=
le] [-p prefix] [-P policy_root_path] filepath...\n",
> +               "usage:  %s [-V] [-q] [-N] [-n] [-m type] [-f file_contex=
ts_file] [-p prefix] [-P policy_root_path] filepath...\n",
>                 progname);
>         exit(1);
>  }
> --
> 2.53.0
>
>
