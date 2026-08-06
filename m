Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C13546D7
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033874; cv=pass; b=JmvmluntxK2j8ZstsLIS7TchxKBAZl838pkxGK6Na8M+Xolgk2eWZaeash1Zsrju9uyCLsWtUMCk8ihhu2hFHPk+BSYxXntT3fnK9JMoTUf8vv5JFm8K8zSUjESLVFYm8k1IKiCKqURRm8SVwj4tEYaIFJRNx28SBlvaLt2vGjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033874; c=relaxed/simple;
	bh=XW9nIiuOffgkQzOT4+cg5AS20jwqr+1AcaDyspcDDSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pW3aENkClkGmGjtRo02SHOe3FkW0HVseIHsBVow09sZCmgshGM4Dub+PwMHw09KgAMm1pnSlHlJDfk1XVQtFxtrkmf65IypDR3KyCnXUzbw0dMAtTuhp2m5JU7p/NLNky43bKZvSrptWdvExL9XFp6oGqcsMUCbmClCR/cZlMhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gm53DjQ8; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gm53DjQ8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caf228a910so20014075ad.2
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 09:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786033872; cv=none;
        d=google.com; s=arc-20260327;
        b=KR7oVj3dVv0TSBVCrPlJKn8K1InrxzzshpNxt/3fEcsDSmaWzk9Ch+sdOJCYvHyIkr
         26UFtcTMefWgpXuxNfZlj8o7gzVPA/6zXyocHadf8g3tn2NEaks9gZ+WqtE+7E/4NrGF
         NODOpnNq7V4OmThlXv7bawwRo+n9jc/65LrwgrMkvlO1UhkUDONRPf2VvFVW1DcNNaBo
         lOIy47jwHQ/Cy9WPhMV0yv5YgRh4/FVaCWve/efTXeouDIx8OZO0kivOgEGzul+mwMJm
         j9tqGJXLCsG7N+IjJevLD2ZiHcZ/XvYE1G3GVBNM2BiJnDTmeWLvbMnyn1UcU3G794BV
         CrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LdnVM4OW43IupFVnK7dTDn/Au7HTQaZEjANHiIkPXc=;
        fh=+0Cswg/Tdx45wOstFT3Z9aBTy524b2HL4I10iSxQQxE=;
        b=o+s9GGQbid0d048viIQbGRk4metW1dct+NjUrjxgD298548lyGWj6a3kelFsQXkoPL
         8P/PSAaFH4aI0HMhqWXgJR82hLfGTuMgjLDOKVjTJK1TxyoU+cRxk8wGVWJ1Da/0Ue2I
         1Y9UfP5D7rWeioRauhwzJF4pqpW8v79P9aLUemU5yCHD3twuvViD+z7sHbxzQtePZFt6
         iOZsxzb0CU7vhZtFdR38P7Pw0iHDxG62D6IDAEHNGTQttRAIcPYpubSP+Q1hKrQ8uLa7
         RakaCt60SlTVg+5iWPBxa1g4PYSxmKBHru5gjc12w/tJz2mbZfWAabpQBMx++Si/I6w6
         h3kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786033872; x=1786638672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LdnVM4OW43IupFVnK7dTDn/Au7HTQaZEjANHiIkPXc=;
        b=Gm53DjQ8v916TgOaA3kAppcRx2ucQXUQh/RE2AaROccaa97JApxUbsXUaOQaaoRFQ/
         bAGrUrIBgnM7bqd/iMhxRXKQywfuCGJgpyZfnV5tZrif/ngdeek4k62LeSbcO2/cFnGH
         RTb5XqZedn7Wqz9CgyCoKWu0rqU9xC3nTc3axSg5QNe5kDwA3rttMLmCI20UaJNN/FRM
         XTEVOSjVvCCASxSiw1SOKh+gln98B07+d0fKoZiteKehj2CmwPrBvUz7vfxkXFG+4+7l
         2dcq80K+fjVe0c4XZmjkZ3GC3HpmZXrDHkJZF2EmZ+t16HSlkJUIcfS226io6aJjYQf+
         Ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033872; x=1786638672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LdnVM4OW43IupFVnK7dTDn/Au7HTQaZEjANHiIkPXc=;
        b=BktBMt3/NhEI9SYBjs5Sq5eAxzk91cyAm27Hz6Fk6sbxXln4feS7EEYOFX6SHxZEyo
         h4+jt2IKTxRKdzvwvmA0DH6is8u+5E2v2pvU3WLAMspM8hksnMstkYz/z68RfVhfvZ/K
         uELNo+vU9AKWl08NLIZHM592meW/xkVDvV9YvHORcIEWxqx+fM2T1cTkuyl+j66QY1+r
         4egKLTjHQrSoWTxejnetXUHzHu6l8sgR5rQ1GE0X3d5BY1jITMJ8OtY8kESPRkD4t9f7
         OHCDrbiMOqqJa4p5hmAD600uWYDjc2Ku60xJIUE48PNTqGjTk8h+9IwQWIkd/BTicSg9
         Tybw==
X-Forwarded-Encrypted: i=1; AHgh+RrURVwJ03+huOuPlXp3uuPFvrB+uP5qXsn5vMnXp6oop/NtcSUgQg6n7hlZv5o2NFvuFN7CdMn4@vger.kernel.org
X-Gm-Message-State: AOJu0YxB61wUzozJijsJWsf2v5+iP5oNsJaiANYS+XccFAONdJIE/Ta3
	Lzm4GLXGvrUbXXeA4+JveKn4zdH/YFq7vdn3zHBTPsTYU4DFE5bMZcb8VUBU3DkQAcCDRbPunkt
	otjk6fD8t9TepfkzL+illKFwriUh8wVjqWnzOBCVn
X-Gm-Gg: AR+sD122pJ2qSpZAllU+mHzI50Pmeo+DbbDM4m/Ri9r+eoHDRMPE2a6KSro92cM5QkW
	HyFvYqboWosGC9Itdj7uzKmxYjp4oxSv+C78BR+kSbYJLvNQtNyBlIA+iDqUenzA3wqouhWMVp7
	QooXRwq9IG5sSZRVwQKVNLuAUNAtzRuqOEcxrdDQ6KvjnSMZcrJb0gKE+zAcqoEyPmENeahKghV
	PkDxRWXdSGIe3Kyj8JRZXOCHrJF2QuLesNw42MV8vGEDWH+Z6DBCONMAhqcGaTjg8u9TshrgzAL
	43l6SmACIWAKst5RSAgifCbLTYHn3Dyfjq6Fapuybd2BQQ==
X-Received: by 2002:a17:903:3d0d:b0:2d0:4021:bb6b with SMTP id
 d9443c01a7336-2d0ca15c87amr195151295ad.0.1786033871690; Thu, 06 Aug 2026
 09:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804135700.3713-1-stephen.smalley.work@gmail.com>
 <8335d7b97813e178446e4e8b37e8e961@paul-moore.com> <CAMgFczBaRgj=aH4A-Bd9Zw12Kmt2ymtMQwpaUW7rOk3FpDJenQ@mail.gmail.com>
 <CAHC9VhQmEkeN+ZwApXnbak_w-TUJA53o1EEhtCSf56dDi8OvpQ@mail.gmail.com> <CAMgFczB05ig+Fpe1bpaWQQguOVycTa+Y+Zt=oiag3Ot8i2f3QA@mail.gmail.com>
In-Reply-To: <CAMgFczB05ig+Fpe1bpaWQQguOVycTa+Y+Zt=oiag3Ot8i2f3QA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Aug 2026 12:30:58 -0400
X-Gm-Features: AUfX_mz7RWobGlpJo4jmQ8ZchuGj_n84K4PHFeQJSpizmaMv5kACRkc9o0Zvu1k
Message-ID: <CAHC9VhSrij5h7RHS0CjfdzdREs_DkDMX4rwt=JL4FZ+Ed98gUA@mail.gmail.com>
Subject: Re: [PATCH] selinux: check level category sets once at load time
To: Jiri Vozar <jvozar@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, jhladky@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:20=E2=80=AFAM Jiri Vozar <jvozar@redhat.com> wrote=
:
>
> Yes, you can.

My apologies, I sent this up to Linus yesterday so was not able to
include your tested by tag, but you do have reporter and suggested
credit.  I also just saw that Linus has merged the fix and it should
be part of Linux v7.2 when it is released in a couple of weeks.

Thanks again for your help!

> st 5. 8. 2026 v 17:31 odes=C3=ADlatel Paul Moore <paul@paul-moore.com> na=
psal:
> >
> > On Wed, Aug 5, 2026 at 10:56=E2=80=AFAM Jiri Vozar <jvozar@redhat.com> =
wrote:
> > >
> > > Hi,
> > > thank you for the quick patching. I tried the patch and the
> > > performance fully recovered.
> >
> > Thanks for the verification.  Can I add your 'Tested-by:' tag to the co=
mmit?
> >
> > > =C3=BAt 4. 8. 2026 v 16:57 odes=C3=ADlatel Paul Moore <paul@paul-moor=
e.com> napsal:
> > > > On Aug  4, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wr=
ote:
> > > > >
> > > > > As reported by Jiri Vozar, commit 7edea6e8c8e8 ("selinux: beef up
> > > > > isvalid checks") introduces a new loop in mls_level_isvalid() tha=
t
> > > > > causes ~89-94% throughput regression in System V IPC message queu=
e
> > > > > operations (msgsnd/msgrcv).
> > > > >
> > > > > Move the expensive part of the ebitmap checking to policy load ti=
me
> > > > > instead as the reporter suggested.
> > > > >
> > > > > Reported-by: Jiri Vozar <jvozar@redhat.com>
> > > > > Link: https://lore.kernel.org/selinux/CAMgFczCi2Z011dNf84Amc0Q-qn=
Tt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com/
> > > > > Fixes: 7edea6e8c8e8 ("selinux: beef up isvalid checks")
> > > > > Suggested-by: Jiri Vozar <jvozar@redhat.com>
> > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > ---
> > > > >  security/selinux/ss/mls.c      | 24 +++++++-----------------
> > > > >  security/selinux/ss/policydb.c | 23 +++++++++++++++++++++++
> > > > >  2 files changed, 30 insertions(+), 17 deletions(-)
> > > >
> > > > Merged into selinux/stable-7.2, thanks everyone!

--=20
paul-moore.com
