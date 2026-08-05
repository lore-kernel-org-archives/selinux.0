Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0445326939
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911695; cv=pass; b=luBU6maXBs0owZM3hlB+w71dhUruykIbT2N7dX2lrx8asHJ6NX99NjI+yL4ZX0FjUYBEmj+86hcxnEtVW/YE/NmHWJykDQU8PQxthglGb607QQIEXXpaut4leiNa0Ux36dZiUssz2WWKu2uOWzBSFyltyPWyg6OMEhWTcCqsS0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911695; c=relaxed/simple;
	bh=49PzS8ZYGr1yBaiogpnWaKC6IaVNjhxYEPP12XM2sY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvj+NTaEPhD84SjA68E1+XAK0+1EKWYtZz+oTISKMI+QLtxMZI/2iMq6GAlkTxkIlwL/CjZfpQHS19nqA3hkHBJACajTwUu8LE0/pEuwGTsLD2gkpROVbpMeD5CrOme4hAq4/M6d8YVid+6luzoZeAnJUrvJ0GnoC/qJmTszFRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO/KKigF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=US+aSf84; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO/KKigF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="US+aSf84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785911692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoWEy3w2G7i5JKOxGb/8WcseYcfjSKrsgdVdx+92saI=;
	b=XO/KKigF8B6XsL+E0hi12pDoP29y7cd2HKYevi/8IeE12iAWkNdTRCLSm3MDkACRnkWWn6
	ePYz889teLfHvSqycs63Pv3In3jAPmpKbAkk1gHduBmmIDOcMj+LT4z3Uwhd19rhz1buRI
	sguNeOPMNP3IjeyauOGa3RYxLsn9jUY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-7D83FkxYMUmQ8-9ybi_kkQ-1; Wed, 05 Aug 2026 02:34:51 -0400
X-MC-Unique: 7D83FkxYMUmQ8-9ybi_kkQ-1
X-Mimecast-MFC-AGG-ID: 7D83FkxYMUmQ8-9ybi_kkQ_1785911691
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so923704a12.3
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 23:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785911690; cv=none;
        d=google.com; s=arc-20260327;
        b=lzOuZvlJP2XkZF12NppQCWUsuaV5jeO3yKO38k69xt0SzJdKeG1NlAoTGRjzxS3wmD
         IMjF3rbQz2ijIsYK8VshqsKa+0Za/nJfuQKUibocgDPzFyRhfpFXHrJdwMl8+e6s2UZ0
         qG7kgsQ0I2RHDvtfx5/ky/LnOI+A8aPb2J11aLWVFjnO4b0cwXiVf70F1X/xnOOWDrIA
         kjPNQGZ/kilZA/RrPimBYZG62KgyZbB7r6RKcmeExAtvAzVt3Ub+TmtFeV5Xgup2Q0so
         0evnNqXUTEOVNmqSTLAf0NELvgRNMPlu5tdlU6oIa4yBGnjAkf+ncPD/SgDolrKoB1+a
         IVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WoWEy3w2G7i5JKOxGb/8WcseYcfjSKrsgdVdx+92saI=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=MjEfSARPiG1+ZXlOb6G4zR8y71BfRV0v8byUGJ4cI0z90RIW5PuADLtzksmiNfoTD1
         sNqzwEWLlNRUJ++3KGu3mTarriZzN+RlnTZZOgCDBtli8DpDRYeKJPqJhuqrMmD7pPsn
         OMLZzkgcIUBpUhDA8h7lgRB/omQnQw3waqt5zcWDBe49i2ff++FX+FSwLs/g6JxR0aeT
         4/CKIBzfqyHQH4s+wW09gCfC9ftlwjPc6oFjErg4fD7aw1usjDCx7wgi/fXqi+aQcM+f
         oRCpq0pBjpc2IlwTdvk21IlBEpQY+81YhsKcdD6+e9/5oWsg2tp37kImS59CELQEyGWc
         WhzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785911690; x=1786516490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WoWEy3w2G7i5JKOxGb/8WcseYcfjSKrsgdVdx+92saI=;
        b=US+aSf84rNF2AWjYJlG0g1+1JmzT1NUta7jflgOXWuF+bNpfCaqBbqocyxR4TsIfTo
         VmnnlCBNXqFD1O2A1J23NvACWiOH9x3GBWihhhuUOeBHDFXRLb682v4pw+mbsIWCATmO
         InFs4TZTb2QbBxl5qAmPisWUrqXOmqLo9FSd7kPhTb0qDPVqzY3ilNw8xtmgznNDYwCj
         S77bmKXxoFTc8D1bcWUxQWMXXEvztc52F56T91Tl4+EVtk8zf0OvxbPdK7MFbRcrfIxS
         pQzmwvXuqpT33wI2idgtNkZU6McaNNigOPBtg/M382VNKoBWdt4jf/J1opLPiXUOvlIF
         m9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785911690; x=1786516490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoWEy3w2G7i5JKOxGb/8WcseYcfjSKrsgdVdx+92saI=;
        b=NgZNyrkS51dfN1+UC/1qY7rTHxXX+t2POZY9Y2hOxh/oenHlSYeeNs4SkokZIr7Siu
         UAZq/nFFeO3dh8L5qG8gg9WXDC1t5SJpLGX50Lvr4VEOStOlWNQbiddUwjdl3gD22EgL
         +J189Pwl68fTuxNH634UgMi0t0WsyNvvGydw5C4XDZ0e5fh+TnQz1ETPoxT9o3gPLJVO
         pZQfUzjYD9+tgRdjvidAotd2IkZrELEuefmqKYg5o8yIAC63qwqEJM2xURu4aotb8TQF
         ptdyuw8Sx62PjhLsNDW7C7GGWR4obczj79kS8fVXHFD1fl4Jfj/GOoLiIdqJBdii52m3
         BEuQ==
X-Gm-Message-State: AOJu0YzqpLJC+P78311YE88Zs2OfUnJo8RnVW0wCV0vZkarq6rrjHaIx
	wSkOZva41o9fTs5NyP2QRWvfjIEws5koeROltLq2Rb8kieLCpXAOsdV3xx1WpIvo5Fz2rPTcVXk
	YCe7I5iOf/azq5GjRk6SFcJj9TBQw80OFtL7c6I8bZBcNGmcWTJcFvesxdC3q529dtSssuiqtGq
	XF8aUntplyy6WfCvPzSV5REUe53kLyt9DUDPMjHLecQDeB
X-Gm-Gg: AR+sD106bLVVxYPV74EaQ3tF8sTeqYcwO98s13pAensfC7WABY+IPBrH4GvjxQp57QM
	BG7vvrMCXQ/nVS1qreLRBdC85PDq4i2I3WIAWwrE3Ac0LCFOA/EsA1GiaPP4LLiDqN1XaGItzWI
	RwZb4qTK8y+TFjOWxcNusagURU25zZydlzu4MPP+OzvG3pQ0NjFE8JGwih3MOGl/Lci3XJAqZJU
	QRGwXHoUTEqfU2BMg==
X-Received: by 2002:a05:6a20:d4b:b0:3c3:8255:8c4a with SMTP id adf61e73a8af0-3cb85ea2ee0mr5461990637.17.1785911690572;
        Tue, 04 Aug 2026 23:34:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:d4b:b0:3c3:8255:8c4a with SMTP id
 adf61e73a8af0-3cb85ea2ee0mr5461939637.17.1785911690141; Tue, 04 Aug 2026
 23:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804071454.2122438-1-omosnace@redhat.com> <CAEjxPJ7t9x9jeojt6jsr064a8p8Q-_J+XGDpb=phiU=V25KRaQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7t9x9jeojt6jsr064a8p8Q-_J+XGDpb=phiU=V25KRaQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 5 Aug 2026 08:34:38 +0200
X-Gm-Features: AUfX_myOaNeQ-3GZyN9JEAajqsKCku-rMY1zRD8fn6BBMIMmAO05RyWIUs-fPCw
Message-ID: <CAFqZXNt7x0jFyttf6hwzDcE854b5G5bhz5MJ7tzEPP8PZs8g5g@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow all test domains to inherit limits
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 4, 2026 at 3:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Currently the "minimal" test domains aren't allowed to inherit resource
> > limits from other domains. However, that means that their resource
> > limits get reset to at most the init task's limits, which on some
> > distros and platforms (e.g. CentOS Stream 9 / RHEL 9 + ppc64le) isn't
> > enough to run the io_uring tests.
> >
> > Since the rlimitinh permission isn't tested by the testsuite, it can be
> > safely granted even to the minimal domains, so do just that.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policy/test_policy.if | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > index ea15ca6..2a1a575 100644
> > --- a/policy/test_policy.if
> > +++ b/policy/test_policy.if
> > @@ -42,6 +42,7 @@ interface(`testsuite_domain_type_minimal',`
> >         testsuite_domain_type_common($1)
> >
> >         # minimal set of rules to substitute missing domain_type()
> > +       allow { domain testsuite_domain } $1:process { rlimitinh };
>
> Why are you allowing it to all "domain"?

Actually, scratch this patch... I was working under the assumption
that all `domain_type()` generally allows domains to inherit limits
from other domains, but that's not true (I saw that io_uring's policy
uses testsuite_domain_type_minimal() and automatically assumed that
it's the culprit).

I now think that just making sure that the RLIMIT_MEMLOCK soft limit
is set to the hard limit specifically in iouring.c is the right way to
fix this. Let me do some more research/testing and send a new patch...

>
> >         allow $1 proc_t:dir { search };
> >         allow $1 proc_t:lnk_file { read };
> >         allow $1 self:dir { search };
> > --
> > 2.55.0
> >
> >
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

