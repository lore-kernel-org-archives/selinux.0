Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87F40587D
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805364; cv=pass; b=R1xEFBrIzQ96WggffOsQbaRPdSbMhrcNQZhS4sMxtH6u/r0qlu58nm+p+scs7nZnai7s1N6TVXxWhcxUb9Gmu6o8/wFwJZgKnEy3F9QoDShQuBS96OwJLV6GpEMc3LMTx+Bz458PmagIQl79CkwNJ0iG/BopoxUS1ikZxXd5Dhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805364; c=relaxed/simple;
	bh=8o2ripSRj2xzpTJ8eo+m0VdyVcSLjCM23KeObxP3Amk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNBUuFbnreMhUCxCdcKu7+oGNiIHqVrhyIN6BfgresvNxXnGCyeRXwfw5k5K3A6HmYcJQPfRAwKEvl8LK4oQXBoy8C+CnA0Jv+p/UEE69V1SCVXuVVG8fFDeNl1RkwNZ6YJeZtpEn4S1sZ+qi0EfJzn5E5FHwYI9/HgwUK+4oNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMrv4O6/; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMrv4O6/"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c796163fac5so8393881a12.1
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805362; cv=none;
        d=google.com; s=arc-20240605;
        b=FSdz2NL+8yKk/ljqZfzS8c/l82+5eDo7WuV18+j3uXKETB5bh2eL/jmVXqB3zLhpCP
         45ZqJSLbAK6c/3Y+V5PreACOwbw8rQMm86a69ARcaS20XX1NOgVQuE+43d3Bd0MZYqZM
         EOzTxnxBVcFYfPau3kdNR/dlCEbJK1BwOzovMciD5riWqMFcknDbN9Tr7lcUGiGxGOKA
         rxa/+rlC9McJcStkZXMvdmmkOxcfVBaqSMlw5NZRwTu/mlj0ioDcEiayNgB5uPjVs7o2
         wPlQfa86uPCRxjIGlC5GB7x2AMuWQgMyr3xBTiFf7q5hHG9+Oh1p5riP9i/Jk4KQez0k
         v4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8StxN88UK2QPOhtx4U8pXD6ludGLZ6wyFYFohFuRuyM=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=U1yxvVyqHThN5pGyhKkpvAO3blttfZGFPOzG+Uz/v7CE1Ai+J+7WhO2PehJvlX70V8
         q5SGyGyH2z+rZQVQLTuZFl5bt3eNACiSp0WwRWvun+W5ndpdMRcSj4I9d7801tNjnuKy
         u9UroXvwSBgiV2on9fiop5wLh44Frfr33yWaRIbBlicVT/KwrgGFXk4AG+4XfTa9C5Oj
         szyK1VQLwrQkRlzzSZ7nYWvzykRIKFOfD9+OHFiQeM2OCqk8nNFJclyJr56ZH7USHVns
         2BpPJrzTUjnjUyFFBOwJ9LrdVLUksXem0e0T8CebI/lV+MKsZ91HX7Gu5FGNtPudM6Ry
         ZJBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805362; x=1780410162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8StxN88UK2QPOhtx4U8pXD6ludGLZ6wyFYFohFuRuyM=;
        b=gMrv4O6/KBUss3BCIt6ZUl5vZm3+2j9MALOTBi4+6pcJuGSXrLsYnbGMeNO1vNbx2w
         FPZDNm+oZcWBJ5y2QIdZoSVJZSKU571Xb2xvXccuIa9xmvuVCs6E4ZgJ5KWtMO32jF1q
         9g9FR6aazVSnBmMB/yKsBgcEtSRPk328jR8EaHyZLNLU8HgxoNJJv1jtcHYwPBrRBdOE
         2TD9IqVCNHfY0+hHB07AtDoiDVwBHjmi7nnfaKi0HCbTHq5KGO+DUR5jTyCuG/cuDPez
         2SfA2hYlrr1G7SRuvx9eXMIaydOvMgayPDfdoSATqjS8brtorB6xsiEghyQO2q/p6yMk
         RA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805362; x=1780410162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8StxN88UK2QPOhtx4U8pXD6ludGLZ6wyFYFohFuRuyM=;
        b=QdZpOUl9G+wI8yDUHXpcXCgSzgI+rXeD1EQkVx1sa6Fy45p0Yqj0gsv3XMOm943/lM
         MsE84TztEJrDRms4tm7LO0cJDAn0Z06i+YZmATzyTLbZHBPHxRisP+yd79ac/vZIhHsK
         c4SMQgTpm/5em26BmjIJHCUfFV9SXAAXw5xEwLA3EmpLl+PcRr1OGdIEFSo+zyPdXSXY
         naZ5FmV16wMNwfenmaFXqm5NoSpzWNE8UCNYXz6lfZcmNtuSwSlhj+imJcMVYpK7bxpo
         zhuA3PcH+5ZVdijYOljlenMPj20RTig44APiNih0X646MZpnqtFrjCRzEPlE4ypRc7Qj
         cEdg==
X-Gm-Message-State: AOJu0Yy+U2fSiyLt3yo8ovru86RrAzew0qFvy9YGZvqMvmb0QKv7Bn6N
	v4oIYQMom/ZpYZ6RAS1o4KJEgh3+sSVg+TTTxhKEoWswFt1KO3wZkRmBuX2deaNpMExozIPm3Ir
	Rp0HJqJqwhFAUjLPANYp1kGSiqQlfVeV6Ww==
X-Gm-Gg: Acq92OGwn1MCQroumYn1uPfBvGSXbuzBn0owobcvjLAYLUGm5yAx0m8ovC/mYxeCbFr
	VIMJX+ZOqGdimPuIw7nLu0Gn7YixDEHbU5FPh0aV5cydT2rzscvR9Dug5wvZupXhQupoycf/2Pi
	Db1e/c2FJbc7i4830ru9slSwLsKI+97dBkEMyIa3YcuAFL2+uYFhR3DRV24pxwYWm71KM8jGqrB
	usgr0IxEIH6FOuJadvZ3T3YGzXc9GDRXvjHtQkmQH/IfrSMocwTrO1MmaRmV4B4XqIpgk5/BI4D
	aw+5dFE=
X-Received: by 2002:a05:6a21:a06:b0:3b2:8799:d29 with SMTP id
 adf61e73a8af0-3b328f9ad17mr20106053637.44.1779805362465; Tue, 26 May 2026
 07:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521153133.26631-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260521153133.26631-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:22:31 -0400
X-Gm-Features: AVHnY4ITD-9DWfjOuMsyU8I4OzqefaDAnQE7IfVttidHSNRqhxiau4DYLXvwifY
Message-ID: <CAEjxPJ4UAAcSDRRz2v1_DVFn73iNW=F+YbPPU0iojQNM0E20xg@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: check for errors from parent drop_caps()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:31=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Make sure we don't continue processing in the parent if
> drop_caps() failed.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  sandbox/seunshare.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 7a4233fb..1d13d261 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -1242,7 +1242,8 @@ childerr:
>                 exit(-1);
>         }
>
> -       drop_caps();
> +       if (drop_caps() =3D=3D -1)
> +               goto err;
>
>         /* parent waits for child exit to do the cleanup */
>         waitpid(child, &status, 0);
> --
> 2.54.0
>
