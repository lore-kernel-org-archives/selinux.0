Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB42777F3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665190; cv=pass; b=GpuDNmmmDLYuy1fw5hWnujCgJoy7L8K4yhAF9ji3tJfwrIruDgi/LmCIRTa6etfZWtgLx1otxKVgEQXvd4Of6ikZ8fb7NauujfJnASQuTFydhXn6Y0LuN5JyE750ep3U+TvYagYM/EIiBR7U/OWzidmDaiJ1+MakDjpf+lC9mqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665190; c=relaxed/simple;
	bh=S2phJhqZTgnU+alx8wagQfz1QSrDb303s1zuK+8RHfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K60qXANDx3ndbfxRiaXTDv/B3CRuyql3ylzaW7tuDyavg7vVD3iJNxwNAlszebnC9bttBR1bNN57B+15GO348RmFRLD7Iox+qtcOYzKEeh2G1kTjcLTxtAKB6hZsMdo+b6ne14AR4gbF+WMrrw+IhbGhgoA6ybyPMwGmEWdYlUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEqJe8bx; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEqJe8bx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68e66128so1987296e87.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665188; cv=none;
        d=google.com; s=arc-20240605;
        b=kKoPMnUSbtXuTGgEGrrhXU9ILXMQ8EH+bXpF9ONX0SznAFOrZUfvG9KbrwxCDj9T82
         ONrjQ7kQKYX+vvn+bJolg/Xd4JPLPXA+dL/N5+YBKs2HW+BeLAIVXvwhDkZmMjtZ5ZmD
         4LQeYTo0tFYvyzFmZRWWoUQ8mRvR3a9ZzZHXSnSQrTxeHR1ntquZk4Px4RXS2733KaXa
         EOEm1Qo4fsIg/ASxph+LQSFDpH1ZcfafoLIpwstHVaPhZ2LmrhnsOI7CNiiG/Q3zR0c2
         7n1jZrRxNlsvOcCN5pxVJb8tbhFL7uqVvrPyyNX64o9XU4+p3GYRoMSUtrqK80YRM8wY
         KEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5k8vxely7TskHck1SgRQ+8LpLRKOxAO/EL91lkUuJws=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=bVKltdzISzh9eGHfi4CnvAXq9hDAJto+LqjZT4VZE2spRVh/63HuO6I8f/NLb4otIZ
         txQOjVmNLRUyS/+eIU2s9YlIL0Rpw0aLUeu7zWBM5g2+iWiCyIYZAa/Hb6a1Y7wOGVJr
         1l9NUrqis1vqhZKp786uJaxOY1otUG3tpB656VrzAsF3DM2JUKXsTCgyo49/zSanA4cv
         ZZc3MdJ0LmClWbJH6e/h15UQ6HjvmbX+uGz0NY/AUmXG29Apg5DhgFJBsz35/PWkHKVn
         QYNQVNt8o9cqRCfq0fSH0cce2zHH6HngMf+iP7kViEbCuu0TRB5k2haoviAUR047UVKX
         5zDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665188; x=1781269988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k8vxely7TskHck1SgRQ+8LpLRKOxAO/EL91lkUuJws=;
        b=sEqJe8bxzWACPZDNbLc1vN4TO78nzDAPrrhr0RVFOV7j86L7zxG2ioYM2k4ObfCG91
         MFU14hfqg4SfsEGuefrN/tqANIen3/rx85HbUOa2BcfvXWS2+85bM5LFIkAg3NKcKqeb
         XvHU6gkyjNtF37xShEkFr3KbBNqlzY1rEGIz9hJiMZe/1DItIJcb//FtikpOIZUnYsNA
         H/VvOE+rHaDSNCQeRi0TmDXPBJMRXufSy1Fl/lFFXeIO/2iU10tEIRu/MowIxsw10mxU
         mESB8VJc7HlWxfNMza/Bg+5DLUQjJC8aq2duvKlzfWioHwSm5XHOStZgZ23IKdxBAvq7
         bXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665188; x=1781269988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5k8vxely7TskHck1SgRQ+8LpLRKOxAO/EL91lkUuJws=;
        b=Pnn3K1kSyIJQ6xSJZO8Udiq20iN8MgPbLIw3prBYzXUfRGyDmkmDJvVna7IVBHg5Ui
         VZC+D6nSR2gRAU7PTdU3RLMuJuAJ4HDoh6VekMqiYtiZ8hjbwJZ/eAZ1Z2d0OMVR9m3h
         eTDo3uvepZ2Iqd5H6uUbxiua8DAvMriDEFbIMa1L0Z1NoYZnkeBJTA071poNuopSfS9a
         mXnHeWlz25d9WNzJ2AHGOPPCmiZRr83XsoQKMmtLA7AzfHW8nnUPvZvgqhBVK7YbvP3B
         MBOluZtkzyOCum9syJ+Nn6i0nw9yCg1YHyNgQulLGxIP74u58Mzy8Fx6HsDXd58dJWF0
         /Mlg==
X-Gm-Message-State: AOJu0YwLEGI1oaxRbRLpJJreTIiQHbZUu4v1D/Ku0rkwmQ/BNwiMa5Gy
	uwuOjkPnUEHcwvoSYJ5O+GQg/wOxocfdzRpk43ZtYKwVl4ZuVI817DEi+cZIYTtoe7l/Ri0tp5L
	EXeYLqsKIuzmm75aAc6c/FMT8/P2/Dyyhyw==
X-Gm-Gg: Acq92OHI18I4k6zUdXOxiXKbx/HClT53aeq0aDG1PE1Ye31cJF7S/BdxT/Y5GnBuaAx
	SrEPFxCTG4yeNPsTKzOuEs2NbgfA8YduKzqdrHzLc07jigaQg+wvMPA4pSjDrJRgnzd2MpSwB/D
	keGnTVj5NqtY/t+dkJUvITCNUtJNAplKUBsfE/zRUIkSiJ4hR4W7EDFydkemXhWdmMwzKGvcm2h
	ayvFYaxaalpAIP6JKhRyLV+LBDDNEqnzCpHVf1+lLr3GZO/4p5HHNGCnphvZsM/aYEol3kB1wuF
	4zx4pwRrHyQ+2wY=
X-Received: by 2002:a05:6512:3e18:b0:5aa:6b8b:8c9c with SMTP id
 2adb3069b0e04-5aa87bf3751mr1184643e87.42.1780665187517; Fri, 05 Jun 2026
 06:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604190843.47747-1-jwcart2@gmail.com> <CAEjxPJ4xLjiJ=z6uH6pfxG_pz70TiaR-OOyaCtqcH483s71SqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4xLjiJ=z6uH6pfxG_pz70TiaR-OOyaCtqcH483s71SqQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:12:56 -0400
X-Gm-Features: AVVi8CcWEBHAG-UUulbQbkrD158lWfX9y6zuTJi3MlzRjCLzvJ4Mw_Nk4JsWYSw
Message-ID: <CAP+JOzSCaCVx=Rkcm6-_sT+E+WWtB22RyXuVysGAYJttrs-bHw@mail.gmail.com>
Subject: Re: [PATCH] secilc/secilcheck: Remove extra sepol_policydb_free(pdb)
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 3:11=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > Since sepol_policydb_free() gets called at the end regardless,
> > do not need to call it in the error path.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Jim

> > ---
> >  secilc/secilcheck.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> > index bf12a812..a2cfd9e2 100644
> > --- a/secilc/secilcheck.c
> > +++ b/secilc/secilcheck.c
> > @@ -78,7 +78,6 @@ static int get_binary_policy_db(const char *filename,=
 sepol_policydb_t *pdb)
> >
> >         if (sepol_policydb_read(pdb, pf) < 0) {
> >                 fprintf(stderr, "Error reading binary policy: %s\n", fi=
lename);
> > -               sepol_policydb_free(pdb);
> >                 rc =3D SEPOL_ERR;
> >                 goto exit;
> >         }
> > --
> > 2.54.0
> >
> >
