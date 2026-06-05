Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23030D403
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665227; cv=pass; b=Mx50x92ObKAdz2RMRHu2uUyyaqxfbV7UUkDEW7FZhUJ5hYTBLUP4jUkUtrcGCwRezMWkdkfPG01t7n6cpgpj4FcJu5oNmzMiqUrS992Hr0KuTf2zz8OOjcrjcwedpEDzUqZck5kYljw1Bzj/CC8Tjtli7cRxmuRMBo8IBrINGds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665227; c=relaxed/simple;
	bh=yFrZYuPPVS/pXDpPMFnKvYF2czasdV0+y84QTjfU5jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux9VBlDcjOSjJFFWks7D7uAtlHGt8dNiknZiM6HggJ/5JvuSUP9/o5wgHi8H2XYDdSSEvPbOaDJtZbuzjPpG0ZeoLu9YfaF7wxOv3vYqqU2+Pd4GZ0T0iOG4ovGU8kbEZOfIe4VDqJPBODLgzl80SO18GLeoRPuNaLI5YSzODl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naMwXzOI; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naMwXzOI"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39677aed4d3so17210961fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665224; cv=none;
        d=google.com; s=arc-20240605;
        b=SovkRuH87f3FKeA9Ykq1SC4EP6DEHevDmrW25DpoZi6BNH0CawBytF/2DhK/EK2efp
         hG2rKSUQUD/pmkmX8QBeau5fltN1tuLS+RgLF46v0stc1aE7xvDg0Zu4Z9UAFni3Xf7a
         UcDjnn1QV89XsPzu+/1GAnOVcr2+tpcvZgaHBs+BLQMvPveoM7g8XzkqD6Xz8kV2w1+v
         3IAy+12xway59TvOxMt9zOsXT1ydc68GPkRcx/vtF+5C5PSQ0U+EB5nA/D8Df9+lzNnY
         Ub8br8UeeIXnVebgPUiQlc7RXhgBXdEMx98xHIvcOICIe7k6/JKmTcmVEuX+RzMf1Qqg
         SpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2r4/aRLAG9luO/MSeGHuwwiJN/PsbrlCQYmwMg9VBgA=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=lJD8JnCXfdhgGHIETkYk/WpAOGtjZz4vW8FMmOPZe3dReRhZPERSufp9fRiwyO0fFQ
         6EU9TnwHMZ20fJ+6BLGRABrzoMQMbB0oEBUKKN9Dk9VfWjnCunGQp/+ihTs+OFF/iRPD
         k0SOElXxdXtagYgj7rjjVZvmYYMXcQt/2YfqEnlB3LYwMQEMVTUqdFEgrVOL9d77DRaQ
         24UVP7u6MKEJoEvaefJT7hMjpPKYQeOzD6Slj/CpGqIbtxRBIoJSELrzxpVbVyetyVJ2
         vj9dW3ORMrn1qgRmjktI2ym/24cD/RuIMPBdRZQe2lIyIG6YyM7V8l85Eu7R1B8n3X/K
         GXWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665224; x=1781270024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r4/aRLAG9luO/MSeGHuwwiJN/PsbrlCQYmwMg9VBgA=;
        b=naMwXzOIEQLuct05rLDGi0d3a+4GvG5Rzr7FFy0wzL/T1fcfqMps1ONap+uZ1rKuS1
         1UnkUkxK1prTk+YNMetZs7lsmywd4VC/RuajT/AIBz+Xy8aLSPaUyJpcm1VPqeIVWfWs
         GVMjJ3GkIIaXVXoOZ2tqBbDXCmXaTjZZRJfniM2AqAT5Jbmt38mB4139Vh/kw+LsTyyk
         v+MzJewukYYMqLUOaduGA0sWgyzpZFFQmqMpHHbsDzOCCRM3iEjlTJcCiwYKRcCDYPb6
         nEcRphchv5RZrDFO2zE3pXPKWqWGAIaV9Uggq5wHRCsFeItUL5kWKvxXY03+JMDqDXHi
         MMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665224; x=1781270024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2r4/aRLAG9luO/MSeGHuwwiJN/PsbrlCQYmwMg9VBgA=;
        b=SRYGIeyhitgUZIELKSX0xkqdgf3FirkHa0ChVxL9V9rpAcvsj+sWCy8OoVVNsMZsLM
         w16zNJv483WFBO0dPppU1Av9s4ec62bdG9Vwebpi9KhkyG3iAB5AVExCkPtzdWz1iytl
         rkZwaOMO2RdDBz6xzsOjtJWruLxWNFyr+CDK/sOih7F1bRuS4kmS1MJFUlcTEbKnALhP
         0V9mUAStF+aFOxVnniiGpyEhHR4iP0NPJqnDTYhrIXDnwm2/fX7Z9VZx8h/yuju3pbSA
         t2sO+SBjC8r3UiC7WLs9q1d45o/DKry9Y+ctUDFO7557E7NGedlVBlHDodn7ykJw5rqk
         rJtw==
X-Gm-Message-State: AOJu0YxYtXqMCFnfdysSViGfDPwUJHs4b1yCIj6jKBwqwkHaudlbsJ/e
	XdEqd7sB3mZNZxwKEzAPc/jyL8EdfXWHa+68x8qSuNhsz5tpqWmmdGtcynaFuo0DsD9Zw7fmZM5
	/TR8B2DhbEudRszTfqa1Q3lnx3MenFyLV5A==
X-Gm-Gg: Acq92OF4vrtR2UuozA5TffKt2/aQOnEGLrSzGyo419KLW0+z/CQS9kvhi08C5tKKdAM
	x2MvlUDxbVJM0PNUIuiyN38XPuJlyVGeV+l8/6ikqanbpsPVXvmnr2QNraQCjjws06+tgKj6hEb
	d+mOztsD5+g6TaqbkCNhRwvTaMHWROJXQ1h7SpYslUjNCPxvFQ82Lu3RKNdH3cSdX49cnAANzSN
	JQSoVQITmIaMF3Pe+V7vKNsLDjziyk4PPDSnj0Cs5lSRmYnvogr+rZBofPYPdo1pT9klJrP3HSx
	pCVMAFa2RzqgxcQ7YSjdAByqrw==
X-Received: by 2002:a2e:b8cd:0:b0:393:ba06:158f with SMTP id
 38308e7fff4ca-396d09fc5b7mr12404991fa.16.1780665223984; Fri, 05 Jun 2026
 06:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604193105.56300-1-jwcart2@gmail.com> <CAEjxPJ6PbESQszZ2HRCQSQ_LKX35LzdkwAH_=kxQqF7iqN9DUg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6PbESQszZ2HRCQSQ_LKX35LzdkwAH_=kxQqF7iqN9DUg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:13:31 -0400
X-Gm-Features: AVVi8CedgFVjE1jGj-A5T6E0B8QXA2rz4V4XeomYkUlyYrih8e39H4O1zTn7OGM
Message-ID: <CAP+JOzTG4OQStisSaKpo3ZxGfr=CTDS1HXuyJMTxs2Jd_p9crA@mail.gmail.com>
Subject: Re: [PATCH] secilc/secil2tree: Test for stdout rather than stdin
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:56=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 3:35=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > When exiting there was a check "file !=3D stdin" to avoid calling
> > fclose on it, but that check should have been for stdout.
> >
> > Check that file is not pointing to stdout before closing it.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Jim

> > ---
> >  secilc/secil2tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> > index aae5f998..dc12490d 100644
> > --- a/secilc/secil2tree.c
> > +++ b/secilc/secil2tree.c
> > @@ -220,7 +220,7 @@ int main(int argc, char *argv[])
> >         }
> >
> >  exit:
> > -       if (file !=3D NULL && file !=3D stdin) {
> > +       if (file !=3D NULL && file !=3D stdout) {
> >                 fclose(file);
> >         }
> >         free(buffer);
> > --
> > 2.54.0
> >
> >
