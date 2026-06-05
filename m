Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151C31ED80
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676876; cv=pass; b=kGoqx0+m1iNXMqqxmeYvM7tBfaRhKHAeek0nX26w4icO8XDkKnnemXE5X1e89h+KzHsY3Co7mVTZ8WOqN3cjTLpRt949smg8qxYqhrEEjncZQc7RqjH3Ou0LtuINN8q/ofjP75g/cNJTaBbCF7Bi2Z/uj6AxPaROYZ7icAU7c9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676876; c=relaxed/simple;
	bh=JUHQdLwV2EBAHjrUh1wna+P0f2NL2e6LS4M0RVB8zNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmlEWjykdtRFpI4U2cSmgGnDK0tqvr8AjtAGCFvlUJx0Mel5CFSEF3XrzEBw2IBFHQEizdfcdia92thkQQTsyn50qkYoREi3iwT9iZCZR0ftyyIhxkJ1KLyAmTMm5u8gj3WCILySKTmNeSQBzM4pBgDUhaGPSRxWhdRiKiiN/j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFj+o+4J; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFj+o+4J"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf30d530bdso21635055ad.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676873; cv=none;
        d=google.com; s=arc-20240605;
        b=hmy67oG7ORU/CgwVXmJuzx5hGexwdXUmNFxZc3aPpnSAKUaEeH+jqRHTwtP0GKkANV
         JigmBbJOhVK6hLwfJH6OMKg6lm4NI1HUiegC2+0GgbuZgD+I8fZKSaePKdHrpM3BWaaM
         3C1K2ZBVkBBx8S8IWDyA1ZSbKk2SpdsfJyFG1Gy8hqTDtHm8Z0PxjGhoLNnIm40cyjz7
         UMucewBwi6UjaG6CQbR0nMu0z/b7LyYnjNog23mX5Df8hmvD4O6DPOtr4D0RGPg/dOgc
         C5RRuct9F+3l/Ik53x1jkZHRCnUjfYaE9XD2eWdr5FoDCfsLAfrJL60IZYDbnLgv7IOP
         j1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TXpOJVlDzp8u3vknZfVMiz7KCcxrrTGcg4fAGHgsfF4=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=kULreK23fm7eX/5+Lj7i4mZcMGZgBXQgSN0Fs2woZpp/Sg0mLmmgaSBPN447givODU
         +2zULsVYAeCriAgVayVkfjVH0+qP8gGwb5yinxBlXG83/CNjTmhACyXVINaczX496RyS
         ulqruPIo4S6lPC30t2qEfC5Ko8B2As58OLxJlN2FsE86dI8/G0xqJYX3JqlxlJOZyqPE
         7qgGA7718Wv2G23E7cfw01p9uLzGtW04334RpEhrfJUP6XMKZ5Waua/d6ldAhj/wwN1E
         28pD76alVmXzwFCZgZCfLvKtKuVVJwi+8I9f3lYeS7CxisYmtCmHn1zoOosZN3/Q3NHN
         SL9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676873; x=1781281673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXpOJVlDzp8u3vknZfVMiz7KCcxrrTGcg4fAGHgsfF4=;
        b=oFj+o+4JlcTY5EgMOcQMGhQXMOJfeZeUNhQPDpqdTvo0R+UCW4LZMU2FhSIiiDYfdv
         jdIuTQHze8EJLj0GsP9KQGgg8N7d17y1wCMIzEUhLfD1y0hO9wXMk1TrrZXzkSZsVUQq
         qM/7Ozba6m/Y8OmbaJCFZMBzse9l3N1ASpEC3zYmE0Oc2D+TKmdVUt6eWrH1NQxzsNpe
         UXAhbQXAuYWmx8kk78cYPDw+xhRmjJpho8FBSnEOMbMsR6vjuvNS37zyjLWI5FCaQUMk
         jXMMZLFcNe0hLiqiZ9jq0LjDVE8oxdmHvKd2apClYs4X9kbBVOcdqdYVR5974ynL58I3
         nLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676873; x=1781281673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXpOJVlDzp8u3vknZfVMiz7KCcxrrTGcg4fAGHgsfF4=;
        b=YIo/gVa6xiFpV2DscyZg5RfFZw0djg/iBBQ7XP04Dt4bOfohWQrZYep2pPtsMTMOFp
         gwMnugeVZKPUtveQ95eMcfDMdAVQtQSGUI15thpW+zxr9B98YYxKnS14fqNWfZpTeFSc
         UwRKMZ5AkOL3kupDEOgeDoPcjGvg3j0LVHxCZKOYrq3S4/PSnWy+pNrkScd59cbHYG6l
         8tOt3NK42m/79+WCEpuBkQTbuEkkQ3GfnZ/hM9fdyjHT6Mv+c02pXJYRUFCGRj1ybAT4
         75ZM9wHPfJZltGWwRK3NAfx1K1ItruocMing2vYRuFEgc+0RJSTQFUrGHPogWnOO9TMi
         KzWQ==
X-Gm-Message-State: AOJu0YydMOXB1a/5lv6V5UQRRlnHmHHGEe0+k/YScXvoZ81nurYWUbpw
	Pw0i89mR6ufc6Oit9W3Q+VjDQoqFF4JVpznmn5LHsvuxBTuOAXadsE0aTYxn4AFFWCmgvm2oc7o
	YisVB82CfbjKafrdIuLq6DU07iGuSXII=
X-Gm-Gg: Acq92OH9V8L/FWijZVNajI3xIPyh2erfs81Q+wawYF/R6FW6kmXDR7LV8M29MbIqeZp
	aJBykIYdcxSo2LdwsR2T8Gz/pi3GWYy210G1GPUzSjxb1X5oHEXC5tc4zSgv4Mtk1bLH6PQbVuC
	6Zl3sknH67ER7SyeRj2emhGDisGH++dw+F3iuHij7KH5BCehFwiHOLY8be3EOL18NPmIkt08nbL
	NxO4pSqnnNR4nR3nQiXYNoZabuvIQQ/KIix8jRAZKjiGChGHg3QeRGspv2y6UBuZkLv38RXjYAR
	u7pXM0UJMAv0OecZ328XfTi5/7fe
X-Received: by 2002:a17:903:46cb:b0:2c1:ee75:56bf with SMTP id
 d9443c01a7336-2c1ee755865mr38864425ad.3.1780676872924; Fri, 05 Jun 2026
 09:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605130432.273624-1-stephen.smalley.work@gmail.com> <CAP+JOzQyMFie9s-agWCUz_0uTbPx6dABQDKp2qKz2oEPcOpmZQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQyMFie9s-agWCUz_0uTbPx6dABQDKp2qKz2oEPcOpmZQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:27:41 -0400
X-Gm-Features: AVHnY4LAsL2rE9SyqaToLPWEZE06jwNG_Z4g8IuijKsB0t4oYBjUZ5t5zgZC8MU
Message-ID: <CAEjxPJ7bZo25Xrh4UnGhdNZbrkEKwxBVowq-PAXvGa+sUwLb8g@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: fix STR_COMPARATOR() passed
 to lfind()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:10=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Jun 5, 2026 at 9:04=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > lfind() passes a pointer to the key and a pointer to the current array
> > element to the compar() function. The array is group->gr_mem, which is
> > char *[], so the second argument is a char**.  STR_COMPARATOR() was
> > incorrectly casting it to char * and passing it to strcmp() such that
> > the key was being compared to the pointer value and never
> > matching. Fix STR_COMPARATOR() to instead dereference the second
> > argument and compare the key with the actual username from the
> > group->gr_mem array.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> make format doesn't like having a space after a "*", so it wants:
> return strcmp((const char *)a, *(const char *const *)b);
>
> Other than that:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged with fixed format.

>
> > ---
> >  libsemanage/src/genhomedircon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index 68382b95..d990c535 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -563,7 +563,7 @@ static int USER_CONTEXT_PRED(const char *string)
> >
> >  static int STR_COMPARATOR(const void *a, const void *b)
> >  {
> > -       return strcmp((const char *)a, (const char *)b);
> > +       return strcmp((const char *)a, *(const char * const *)b);
> >  }
> >
> >  /* make_template
> > --
> > 2.54.0
> >
