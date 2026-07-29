Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39847ACFC
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328732; cv=pass; b=rUQ4qDOcxYam3h5bE6q4dXLFjKvzcghdVebFuq+5YCGZnrJos6QBspmsDndH95FvEX+QDRtgAzZygvxE0E1X+oVdUopPHAdX6tMxwVBSdyJUHY/APhplkgmvaPAgC4MjGgGWN1DF66uoj4n0REwi6ZR7SatHa0yBhDIVm13Fpag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328732; c=relaxed/simple;
	bh=l32jgkUrk5x1eUUFBvMmHpOM4sMGhFjgMAToXt0pQzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsTBDv/gyRFTCTPG7M9S6g1jqW4R8MV3Ig9UX9tRwQpi9LlhaD6y0e9ObhlVfOJyp+Y0uL2o9+LCVlGqAbCMXNG4hcrfKnl6FzSi7PL6lSHo095a1absvtvoQlZuxqQZmNYy3FSmQWr99HCyfBea7/39eGF2N3U4/iJw7qoRPLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXhqKsVf; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXhqKsVf"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aaee9a5084so535239eaf.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785328720; cv=none;
        d=google.com; s=arc-20260327;
        b=cZ0XkyLvjFSvkp2iU7+ku+S1MJE8jX3ey34cztv1SIIxexeojVozVXxdCPA3cu5Cmr
         uZU5YMa1smSkx/Ok5ZnCMxmnPUzhlWi9y9kOypbImrAu4jdY9zvfdX9kfp8r8irpPyxQ
         NzqH2NygjeIkfPZV0LKoxLCxYvW76SGLPfI2kCczIk3GCqXloe0DWR7Jz37SZt8vKY2h
         PKN9x1SuhM7RwWHk7R1qxYcivLM/V7tXaHy+pgH5jczCyeVmh3nOR2uK3JgWsp0p7jln
         gK6fCr/RH2kWlyB6cSSx6vTh8KlcEl7cHUmfntDs19p9nY0o+K7QUvZUJsB/nncifP9M
         byzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l32jgkUrk5x1eUUFBvMmHpOM4sMGhFjgMAToXt0pQzo=;
        fh=vuNDbUMxxQBDHXw0k69IXlb1TKioaNe81F1YBzSaKHs=;
        b=Nmbo/YrRAC42x6j3PhCbrB5ux4yDhF3QuOd5R/boX2ckqFkMlAYSXd2AnLB3Ooqfl0
         JgWcUtttgi3CyVRpvjmGID+dxnndJJxUpjg3PbB8CUKhP6SV/BvKN8LFAqdZeJg/kkxH
         jChY9HotXtNAafaM9OjHaTTvDrY3Dq1MHrGa6TDU0mIlY60EPsgkzqVvBxUbINYy6CUC
         6UoOU5rQBjVqh9ZwA3xgOoLo0b+wqsPDXJ88zofokAmEpxSNgjAcY+iEnUipXWSMP0B3
         g1cJC9laZ41I3CU0SGTnpwTnAaFwOH9I55EL7vpkXVbXfNUGkvj0PKTv/8DH+xdBu+1y
         p7FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785328720; x=1785933520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l32jgkUrk5x1eUUFBvMmHpOM4sMGhFjgMAToXt0pQzo=;
        b=lXhqKsVfwY/Z74FVUhV1QJr24VLIQPGVri4XlQ5g3uLhDkjlANf5YbcBwts5MpTak8
         YrRuT3Ka4DTzXQ+ethAu9n6CkadMmKeciKMLnH9NaZOk77fdlsRMDzmzKAZWzZFQZ+Bx
         UqtwCjee3HToAybG07WbAjUop3XZk2ymN8AEDDNKriahfkNMAdgLu3O2u90j3dD5MJwu
         kPeLDzUyWRlf+UG8My5k60PrWcxVO/syz4nK+kF6AadpywNNuSCYyZO692shWg5k2LXy
         oni/x9wUlFUyqualV1elJSrQddJ0shkvgTyvvjDAdj4jhhpopK7z2pvbLHvojGmXqdCa
         eMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328720; x=1785933520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l32jgkUrk5x1eUUFBvMmHpOM4sMGhFjgMAToXt0pQzo=;
        b=Ig7YwZQqlVlWl9+cue3G3Uz4e76yYfiP8mW97fZHKtfpOF+ELbFfcvEWtbVNUNVZqG
         sR2cSYhotZMGjachsZlE4onx6x85cMgIuovsnI/AuRC8P3MSgZ4yVIxoJJYlIbsBGxwt
         skM6CcMDsnzj1h8wlqb53Gn9ZiJ4euH1kL7VpZMTz2Q2L9dSVH98CiWQGclnosOBM5t0
         WLE/5jgdz3bw8GRrqlBOLgTMoskydRhzeWGJPhfMgffwkwMqzHTjCBApWqUuZmgYFp2z
         EA7y7I5yLW5bhOm+57JWcX7CNGvqqFkBHeU1gcbuBd6KPA/zk91WLJcG/7IWGFe6eLmP
         cOlw==
X-Forwarded-Encrypted: i=1; AHgh+RqGP7HUfvvKNuDLoXigN2vosJLX+kkiBxpVX48OeKPzAb3t/dGXmIUC18X8ml2x9H6RnzhZOXvP@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyqqETg5Vgn89noLJkK+khDanLSXennuMpkfxeH6QjTF0/IoH
	1i7aV7KbMxUuPiuihl57zTOCH2PEpNjE7HwCdVZjUDD2PfOt9SsTMJ7o1q7I7+TCRMPxILs6si+
	lQFlrSzJAnweA84fHt9/Yi+uo6pReE8U=
X-Gm-Gg: AR+sD123adGGY/8VGUD5S+8BP1ABxJsNxKegg8xfP6iVTvaGc9p/36OVSPOAgmNWXh9
	7MMUIa7XyI5dZojRHsLTleGAmkYSVxpkDakjRXpmbjVvYZn2Tnb1R/DtaiHGHCputD7TlYzjl0R
	4jYfdvhlluAGOeHUECaeKup6ZTRctMov6zV8jC6R2TwVeER4ORIZH+NrLa3OaL81SFSjlIhjPgb
	o5Bj4ZE83eW88Tlweqgmab9dN+anuEdO3mXjGRPIwHY+n805K2APFZo7d5G4F8DqlS1FDiA7vKJ
	7+AgNxRBaMGjO+5Sx/k9wpfj0msokrFnMBA4AHpS/FKF
X-Received: by 2002:a05:6820:4b18:b0:6a3:2c5e:2b37 with SMTP id
 006d021491bc7-6ac96cfc022mr3411334eaf.72.1785328719908; Wed, 29 Jul 2026
 05:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
 <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com>
In-Reply-To: <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 08:38:28 -0400
X-Gm-Features: AUfX_myQ6icyVz3HMUE4Dc_AbLVEYWJEbwTVdNE2tq8trcGL3jQR-YTV4PwfdkQ
Message-ID: <CAEjxPJ4DvjMdEF-RAXHfySrtcNOx8hbrLU0YJ_WzVvgv3xsZdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] SECURITY.md: Update security contacts
To: Paul Moore <paul@paul-moore.com>
Cc: Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 1:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jul 23, 2026 at 9:42=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Jul 23, 2026 at 2:24=E2=80=AFAM Jason Zaman <jason@perfinion.co=
m> wrote:
> > >
> > > Part of the annual cleanup of security contacts, drop people that are
> > > not as active committers currently. Thanks for all the work over the
> > > years!
> > >
> > > Signed-off-by: Jason Zaman <jason@perfinion.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

I re-based this on top of Nicolas' patch removing himself and merged
the first two,
leaving the third one (the RFC PATCH) for another spin based on feedback.
