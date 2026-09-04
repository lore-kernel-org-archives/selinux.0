Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A64CB8B7
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534946; cv=pass; b=DbQW8pD+eovePYsKRoTqNqTSgKbSfzZ41RQe/Uf88+Q4CuSOLbJDbWPCXnstGL4IzE3xsWS8U42D2eoJH1mUO0DbkshEYMptRHsY/k9fH14KeslpAX4H+IvW3Yg5C2dSTiG29+ZBWPsX3uyn+teVR6KSrF5Bomt4bnQJyNZFPO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534946; c=relaxed/simple;
	bh=WqX8wANgrmsjVWKXYSBocUmjqjAvTnHfggTZnWcrH0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLOyctbAzaxNOyzhYSD02hCWlMF+JRVfUXr50KqXvOCofgneptR6ZSIdCh3AI7YvekJiLpydi+h9G1D4DnsDOnqmdVC0XEEpP3vC9L4RTof45ph7ah3mzYoNioxwYtCS8ck8/mDuT4PdJBXJapgH477MZ5JZmUkXRP4hEDdOUPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXXe5RCy; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXXe5RCy"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-469d76ce704so1074776fac.2
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534940; cv=none;
        d=google.com; s=arc-20260327;
        b=jqycRZgVWKMXOid5VAcNrkFcxBtnEUf2gzcdwrDYzC6VsONwLsP0q5cg5U/4Xe2JaJ
         aJHZYQReVG8JH3h2Mc0fBbPU+++JZZuTPvnO3QykamKLHI4L9y6xDNul0+xXFgpNOL0g
         rOrrVi66p7Zxn/VFN4aMU9bETZLfet2pGpqJqB1fyK6s02aXqObfxKZL8lxKEyu07R/Q
         p4CEmBfeSMqu1TRfPMqB2VGiG3++RpevOFXQCaIl/A6jg/DYEXGQ72pZ4ZEqvqiaQfpu
         YTPWpLh0y56mqcJpQSH0hLoL0RvDTksRkHIzEEIkW0MJ0fX+BYddK+7gbqxtF1RXMM2W
         kNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WqX8wANgrmsjVWKXYSBocUmjqjAvTnHfggTZnWcrH0U=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=Vgp36UqQUExUk82t9UCNrEpopeOdlBBsCJ4QaG1zDJqIt/nAyxcOtfxmrflswgUCjr
         B2xYT7YLljda+gvSI9e8mqehEYwzro4b67jrkvaCQtojAc6RoUWc10kAQvowXh8O0jtu
         GtdSBXBT7JJjhwKFY7VBoOMPfCugiBHyGUf62xvG5RnEHPK2ER8RWVd81V34V3YTqmNQ
         bZv66cEXSkUhrB6uZd9kTP94qBehpHiPf6I0V2ZqdymdXlG0Svys0+kjNQuZky6UoWXO
         OdFbW2yzqQFNk9Axh6Bwy68M992CIMqVr2fOHXt3AnrGKpNI1AyFjsAJ2TAOQQUFStNy
         /QAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534940; x=1789139740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WqX8wANgrmsjVWKXYSBocUmjqjAvTnHfggTZnWcrH0U=;
        b=DXXe5RCyqEBJbRT9tFHe8D4dcjZPYT6bsCIy87LbU548Eg6avLLuEzSqUF4KdsynwU
         PR8Nrh4rSezR1klnAg/TnpkP3dVB79k8ghP6o64yFxfinPRlc/8YKtFMtLwBmFUurG48
         Zdp9zfqMOQtPA04EUkXUP2XigvNSfKl+w7YXpEldAnfA+4MbWGwgQsiCW6mm0NsH2WuR
         fTTUO+PsRHjMip5DEUUQX9mzkNTINo/OXPzPDtBVWkdpZAb1m857j5BHCxuzxLuPuKrO
         YvBqPMS4qGXWGZNyv9HIDrLbo4nkBwjLRxDydXlPDxod9tNi4uq1pGlvrDnAdVBDD5nt
         cmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534940; x=1789139740;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqX8wANgrmsjVWKXYSBocUmjqjAvTnHfggTZnWcrH0U=;
        b=GzV4U7a0WApcLzge3XBSS4A37nfW/gLL7BI48H3Y8vjO6BhkoYD14Vv12CIAivOOeR
         dSPQRW+wctIrCVCRu1s3s0JYnfwpHSVLd5BMsOZEscsaZKcnWsT6ab4vGEU7B3yYl8M5
         QqUPQVZWZTX0kFCu26O3im62vMVfvyALtrYKtxMhG4MuvVT/osiV98JsmVzHePPa2Eyc
         KkvYKvC3jfWen9C4P6tyUc1a8m2+vfs2Es7sSQHdXpdIpnWYi7ZaV8V0HxRH5wW6Ha0J
         4VzkTW62No6ToHQ+Iy+2QPzCWAnYcTiTmXx6cHF3QaItu05YGzxWWPqxi26yJyerCsZq
         XQ/Q==
X-Gm-Message-State: AFuF++nOFcqVe9ezNo4v8FHdx9WPzBWcZM04zNiFHtpZ/FyO8Z4RXHZg
	soV2I8Uy9hT4oCPNJplA8osRLQX9Njzof/fkJcpxJnBkbSca1Se7VfuPJAidHCs9e+X3cZ5RZ/7
	CldEA7R/mnJQ0/ALcUI/E2sfLN4vul9majg==
X-Gm-Gg: AYBFou3yRziRULtBr770QhmBNQO+V3mWRlxvxKJBD3mVLErfKAc2wOJu0m05iLpvzNS
	F1G/alYfPwYwbvwDClDaRsNAfNl1Vw4iNSNKN8OzOaeHnEaf6w+GV9kLBYPBfdyLtrSYVpbM40U
	5JsnH+SnK8zKEMg/bmL5aLXX6ybhTkfrrIYPKm8+OYhqMPwHLEH1KJQ6ziJ9PKo+M33YeErSVTU
	FWh7BUVjr0z5XzoNoRMIFqvAHZ/piFjpG4kUOus0h6rSU+A5vHyZ4VqHu9KeGrS4ltIh81z0hAc
	11XFjhsYjrO5kmbfdqUiS91X+PdpBvcS+r/K/bCOGihMLbnrAlyBcYA=
X-Received: by 2002:a05:6870:a688:b0:475:e066:771f with SMTP id
 586e51a60fabf-475e0669606mr2430855fac.38.1788534938621; Fri, 04 Sep 2026
 08:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903115927.17117-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260903115927.17117-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:15:27 -0400
X-Gm-Features: AcwNN1We2li6VNFgo4OPt3ayDPyH3j9xG9qagZulf5hXiVoO8Jpl9cH44x3IdCo
Message-ID: <CAEjxPJ7qoZsJ5CsoDR53_gYkJ+J9OkxC1e1xZ-YmriqiPCuiKg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: optionally sort file_contexts.local by specificity
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The policy-supplied file_contexts is emitted by the CIL compiler in
> least-to-most-specific order (cil_post_filecon_compare()) so that the
> libselinux label_file backend, which returns last matching spec, picks
> the most specific match. file_contexts.local is written by libsemanage
> in the order the entriers were added with semanage fcontext -a, so a
> broad entry added after a narrow one overrides it, and callers cannot
> rely on "most specific wins" for local customizations.
>
> Add a semanage.conf sort-local-fcontexts boolean. When set to true,
> the copy of file_contexts.local installed to the policy directory is
> run through semanage_fc_sort(), which uses the same heuristics as
> cil_post_filecon_compare(), with equally-specific entries retaining
> their insertion order. The module store copy is left in insertion
> order, so semanage fcontext -l -C still shows entries as they were
> added.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D678577
> Fixes: https://github.com/SELinuxProject/selinux/issues/40
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes the code formatting.

This is now merged.
