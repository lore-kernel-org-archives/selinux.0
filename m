Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958E47AF61
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875764; cv=pass; b=r7xRF6EsFHp2bEstFPAPsS/60KkGotTTz9ry7EPqHx1Y4OBy2shygOMmKKhJeaBQdEiELcYqYpmU0E1cR3iaYVEEAKVsuxakANSiQx3tBfZAjy+YFl9EARnYUMyEyOs8wzpe4uW3ARzMgBzFzLAFP7XdZxgsKB/HqIgnj1hEVjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875764; c=relaxed/simple;
	bh=4AvL7D5QZZmjQQIhfgI5EDdj3p0Dn5mdA8kJCGqeLu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfdiuL0YzySZsrO5YEZ9E0aMf1/STzmRKGm0HnwrI8mLRBe+7CHynB0e9ylotbp0Ep8xrzh+XRDtVFwMjDuIVI63u1zFi3N5Ni58z2BhaGxuvQyP9QOAIydFi5OGlUjKHOCLZ8ZC63LykmuUwnNXQvL7dnOIGCo+Hrl9Z6XZuVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDK7EsTY; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDK7EsTY"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43bf9548df4so152239fac.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 13:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875761; cv=none;
        d=google.com; s=arc-20260327;
        b=nMUkkmrp0FQBwl7CRXEYmdE1fuYxbpg728HSrTU+AVWNIJF35IBXE8lPmeP9SDElWW
         7wflBV3JneJBtVWb3R2HZCjfXO236CY/huaIr4zzn0ez/i+rmB+2WsK5lWMyE9uuLFU0
         cjO8cbdiBHy8WlV9z0vRPz0giOLwcy9LPdTZaVougLo+cmBoWYLT38OJEZpILTsJT8a8
         hOIS+uYp6468813mpyD4VCgP0ygvhIweeK/JfJivSG4OFLAFYWr6eTuL4URBBKKldnR8
         rW3xOXp7EHXvqX9WgKOS1/PjWi5D4F/wHGUxnC5vHMvYPLYEJaLp48YFYI3TBe8E+Pb3
         EiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4AvL7D5QZZmjQQIhfgI5EDdj3p0Dn5mdA8kJCGqeLu0=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=lYs/ghDiXf8A6ytkuh+Xr55UTMwH28QsTPhqsp/rFN/OyxwBzpwrPzc6ZaWzukPu2j
         GQLM+ianxSmP2OKD4yaxJYPAszdp0TcTz86NwUSglENCv3mUmyA9fi9HxN9jSbc1ECq0
         EUY0oevPqwczLefezBwjzfDj3rhxTwxCpjfn5bf82QVtiD0H0qX8A5ib+Ez2iXsZcBvR
         CTTw7Dt3Rkt+SrRdqTx4Ze7PmWDi3kWPLVzyW8xIlqEaNoI2p4+q50iAbf3uypvv3IsS
         5vBiemeVFoqtzQGsG9asqp6NkDsEm36yh87rIWgjzCaIhd+85yU8QMN8CZLzkGMqUzc3
         P+5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875761; x=1786480561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4AvL7D5QZZmjQQIhfgI5EDdj3p0Dn5mdA8kJCGqeLu0=;
        b=fDK7EsTYx/Vm15nouw3fhepk42Nd5Gc+zDAsh+JkON4NmMgHfmjgQ/D31uu8G4oOCw
         gBucc/czm4mXY5PRFrlDIiY5qWHe1zZ0hKwA3j2dyditpxPRqt7vqwFVJbs5+pMMHESZ
         Qz6tyDnI3GmB578NjWmSPfOCD+C5BKabl+e7l5HyO3rqZJEN4SVXHHBa2rNkohHR04Zq
         RqigPEi/UlXNGw+UOyKkivhyFkke+QOIUzDLcbryuAi4iMfYcZkMHOoXsdKyos+wSzUA
         WnnGwN8Hap47diRLnmy3Lj6oZ2nzY94P8uWUFQjcdbIalcwKoNgJCAuSBcF3rl1G9GhJ
         jlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875761; x=1786480561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AvL7D5QZZmjQQIhfgI5EDdj3p0Dn5mdA8kJCGqeLu0=;
        b=Ch4uxZ1kXkMNOboHfExRVpmPVJ3FhVmxmqiMQuXu7hoaDObxgtaCJs9/K/KBQkf+Q4
         nPyLRaIoQO8XbGmdA67iqHBVWzO7ZwLH6bdEtcB2MnJtD1hj2s2htcak8lt6q2sW14Fm
         92wKIIEjPbNau1zRWD9Di46e5ttuczdoX1lzdLukdlz82TjkLtP4NMFYTLu68J2/hGhi
         dWKUFv4YRCWhCLqjS+Shcnwg5hT8ZisYbNVxgc14YN0vUqLU82HlV2CzZIpehBImAOW2
         ymC6yszaLsKkCP/npL1h1vnaK26TTBSrnCRxyBHY5NQFEXwmD9AdvplN0MPo+kW6UyLZ
         lFVQ==
X-Gm-Message-State: AOJu0Yyx8L9E6F4qDVCdpSKeM+MuqO3tfeY8noYQCSbuArsSTCvcf5Ba
	Sz7DB6QD2ODepKx9IblCsaeZLLLX6+27Fdynbb89caFQCCAuF3SolNmzVnSY/lwUuDylF6JnM/Y
	rJLFcUu4yw6xxQynW/aQCBUkJMbXDe5M=
X-Gm-Gg: AR+sD13IGE1OROC64cW4iZzaYLgJPP8XAcOuWutmqyjPsqLcTJm/G7hicdJ7kjT8nVp
	zccJs3eIXq8geOirgAdYVfcru+vlrF+wUIS3ni1EDLEiBijddFal6A/OuPmpbmI5mmODFhEF70J
	+dtgFtvGH4eBSJi+TnGJWLrAr7qGzQKtGizQZdYb+TdEhyWLCwwroCZOYmCroD1Q1bQ6tBpnVzr
	EXuqAcS1ZQ0wqT0j43t4RKJeQVPFXarwB+1z/ATwD1VN8ba1GFabp61tx3yax9zwVh4HhulxAOo
	jAkjB9lJN2hgqSLe8RyMk9qFtPuO6mDN8QmdO/jRyUow
X-Received: by 2002:a05:6871:471e:b0:434:5c90:9d87 with SMTP id
 586e51a60fabf-4599edd0fc9mr918376fac.12.1785875761035; Tue, 04 Aug 2026
 13:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804184826.36330-1-jwcart2@gmail.com> <CAEjxPJ4hfCiAgRRspTW0OiVxQP-jwpFf9bPHtZfpsvKSUYdbqw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4hfCiAgRRspTW0OiVxQP-jwpFf9bPHtZfpsvKSUYdbqw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 16:35:49 -0400
X-Gm-Features: AUfX_mxt4U2kUo7ZPIf4LLp51h-9qPMY5rDb9VrqxrUAwu7_NqC2qZ6cdb3wA3Y
Message-ID: <CAEjxPJ5j=2mLSN=Lbc07dzDvhqXcDjB+8syTM2Guuc+g+3rm6w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Do not convert mls rules to CIL for a non-mls policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 4, 2026 at 2:48=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > When converting a module policydb to CIL mls rules for sensitivies
> > and categories are processed if they exist even for a non-mls
> > policy. This allows for a maliciously crafted policy to cause an
> > OOB access.
> >
> > If the policy is not an mls policy, then skip sensitivity,
> > category, and the ordering rules for sensitivies and categories.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
