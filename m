Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEA2C027B
	for <selinux@vger.kernel.org>; Wed,  4 Feb 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770232122; cv=pass; b=o0Lr8S7B6KTXBloCmP7rr9KBNLzUK1JWZKa1cnTyeVw4k7R0v0YHqd7h0byAGzMSScywrDL+OUKqLezNrSKEwaatzu6KtBMDYrJDEh8zJhvaJfx4nGZJbg6iioM1e6rq/PxFT7TJV3meDfPDYy9TD/XDyUX2biqR+myuVJgFcaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770232122; c=relaxed/simple;
	bh=FtbkCw+GeQWlRSXh379CgwKrXq5qphPAjrFIgW3Ho6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv7unqyH/i63wD9oga3XtiWkKiEU1ow7xyjXgh/ltndzORbk+vq0SgLD3fvU1E4b+RkdFmYH1mhqLKNzGOkZxmGRJpPjCX8BV6z3zNMAYTjzt4vvvtrM0QF7KWC+MY8TnVoAMAmQmt5aJXJO1M0VTKs9dxd0adLHQkwGTWCu49g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+c+ibGv; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+c+ibGv"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-382f9930e54so9607781fa.1
        for <selinux@vger.kernel.org>; Wed, 04 Feb 2026 11:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232120; cv=none;
        d=google.com; s=arc-20240605;
        b=LIZOkucXauLtwYvrnE5f5b63h5H6WjwJjTeO2T7hhf+r+GDO/Xpu408w8z+USxsW7s
         eo6s7XMGz2P38fZBTotQoUkM4yhKQAhTke3BiSNxeuT3O6eR4VT9zB0UZiczbT+1m5/w
         cCZi8oSimEginDLutcu/Vm3GDkaEn/0DPxuLo/FRc1eWbYwnCDb8sUJkSjacm3+tNj4D
         RBhNloQKBIBdX/RR+0HvS9Q8wC840DCu5h/rYkvmsodwtBFiN2ZQgeQmhA8xghaDGtx7
         PV04i2hTkVZCXha66tu0PCBpm4VXmYb94A4MG56X2gGgItz0/xCEj54E9DynpNmiJGyL
         MLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtbkCw+GeQWlRSXh379CgwKrXq5qphPAjrFIgW3Ho6w=;
        fh=kFQJiVqcXuiN6fQiBQATHLXc61EoZqo1Fpph/8DgvbI=;
        b=jOs7q85zeH3D6FoMfFdR7dhHWKjpc1Hts8ghYmerY0GydnLYYPIRXFib7tB2Jn2AAO
         TDJpJVoyvoLtaFvadnfd5AyC9jEyrn+2DZn4ZtotRBb8FtAlPfbFegqLurN0AM7nZfpn
         YYbegwo4v1boZWkAfTHUnyb0NCqRGVyhuBEipsG0CWu6YJ8X36388Um+rL1cBmA2ebEu
         gYoioz10W9mXhPUNnvugEiiOqRPs+OWvc43nwC4rhnPj+xsRvBtwJlnAYCU4Q1S3tIWP
         GY35wicd2MmW7ZADDpXnF0mWju2D3Ee9nP8frNMwJ9iSA8AfNkSBIP8gyrqjCaUl5aH+
         gGJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770232120; x=1770836920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtbkCw+GeQWlRSXh379CgwKrXq5qphPAjrFIgW3Ho6w=;
        b=l+c+ibGvkc+2JgG8hRrTgIw8ePnm73squi14upRf10HAV4JCy1ur8pPC347wU8sl/4
         3APyhU5FWf/rx59jOliiNmCeFwcOVOQWY1YpqIqptTI1z9cUeCT9lnqTSEE6YnJ/94YV
         ARyz0JR5Wry+Ub/PoR9nRztCasc5Sy6Cr5Ah/8SZe5HoMUSDIVR1IIDoCLQfKjyPSa4N
         fSPAh+cg7v+09dYi7HoESiMIFYAslhykdPM515ZgWoEAxuL2yOVGT7q8EwIbRvUhB4dg
         otvWi8dS85FzHZvnN3pNYTZk2AIoPeF+jdsF6SucPRAET+mumYkp667fqNgMEjqqIi6N
         nfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770232120; x=1770836920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtbkCw+GeQWlRSXh379CgwKrXq5qphPAjrFIgW3Ho6w=;
        b=FR670COALJ+QDGcfFmzYdo9vutyZHJKrsOAdejnwYqcAyDEIOg4D7ky6EPqEnMnEnN
         Zy/OBY43nNmxsRoJzqbfzSet0SJO5l0r7kn/h5nIPDt6wO0XDscnUwd1q1VtJ7stpeuG
         rXGl0SIycZCJmTqpDRxp/odQPlDw1roONfLnjv6wc/5aEgnavpw0BnOb4fd7vqUk9jK2
         C9qcWYVFEkmvhezi7juF7jCxtgbuKzt17N+uIWj+Dt8yfvn6lSv9iQMwiP7bVT54/O6x
         xbP91SATW1AOQGxnpc9SxeXvZlzKWqbcdxBXU8dLCVJsmPZLNlEDq4EA1JEGwd/mn7D2
         wDUw==
X-Forwarded-Encrypted: i=1; AJvYcCWD0xLMjIzuWyndCsEstVJ37u9LzSkQMwhgzfYcvtfCzaKyfIH35Tj1RPRxJLtDnAZH7tgYwMsu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8z3s00MbO2+rtaOntTXf2Zo4M8TIODHMdWGUl9YhUUEDzWnuR
	zRTBc2YC4K09E6BHvkfrQU2YyK95/WfLVFm2U/fEjK8SAtVpHqfNfjXVMC5fENI6wPTM5iAl8YK
	BWFgEgd+dXp4aJEpF8MxUKROgd77zuYQ=
X-Gm-Gg: AZuq6aJayI5HakPBkztufu5PbDNsbyXD6RIcU4hp//BK6z/MGlFW7JqME4Voa19+A5e
	D+dvUg/xELN3QwhH2JM9dx+B9sc3mpw4JTEN9xDBFxjd9zxRCQJDr/DAeCNtal7afetzH1P3Z7a
	R52IezySVHL9VkidIX/y3LGlkeKyly71hMUjNwzy09LBE4bMIMrbpohuFUMm5CYpHaNH1avnCuV
	7KcAC5AC2VfqO52NINVwiRBNuVC1iFdkNAJnyNTRH9xnHsr3EcUSAyir5Hy11LAsqlt
X-Received: by 2002:a2e:7313:0:b0:385:beb9:dbfa with SMTP id
 38308e7fff4ca-386a0c42909mr831561fa.22.1770232120211; Wed, 04 Feb 2026
 11:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aXbPKpbIXh7_fpTM@anduin.perfinion.com> <aYAKEjlKxwVWGgrw@anduin.perfinion.com>
 <DG44N7XQP94D.2E7L9CFJ7PTXR@gmail.com>
In-Reply-To: <DG44N7XQP94D.2E7L9CFJ7PTXR@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Feb 2026 14:08:28 -0500
X-Gm-Features: AZwV_QiqmzVlzdW-HDUa1S_InwRxUYpNBg3K-WlgHrDBgNlLi8C-IOL4zbAJtDc
Message-ID: <CAP+JOzSkoPgfoM2ARo5P91g53jeuewmQ+Tb5eypwNHtB=2VGOA@mail.gmail.com>
Subject: Re: SELinux userspace release 3.10
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I forgot about reformatting. What we wanted to do was to
reformat and apply your patch as the last things before the release.

If we do it now, I think we cause all sorts of pain for the distros.
So, unfortunately, I think we need to wait to just before the next
release.

Jim

On Sun, Feb 1, 2026 at 9:40=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> Earlier on the ML, I think we concluded that once 3.10 was released,
> we would format all the code in the repo with clang-format[1]. Should
> we do this now? After, we should be able to merge the formatting CI
> patch[2].
>
> [1] https://lore.kernel.org/selinux/CAEjxPJ7T-xTyPhbNnC5GgC4d9wMtMD+pkPF0=
JgRmOdMvM6opUg@mail.gmail.com/
> [2] https://lore.kernel.org/selinux/CAEjxPJ4jsZ_bWrLF=3D1si18f09p2Q_TEPWf=
1rd_a9=3D_kCb6iTEw@mail.gmail.com/
>
> Best Regards,
> Rahul
>
> On Mon Feb 2, 2026 at 2:21 AM GMT, Jason Zaman wrote:
> > Hi All,
> >
> > The SELinux userspace 3.10 release is now on github:
> > https://github.com/SELinuxProject/selinux/releases/tag/3.10
> >
> > Thanks to everyone that contributed to this release!
> >
> > With Kind Regards,
> > Jason Zaman
> >
> > RELEASE 3.10
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > User-visible changes since 3.9
> > ------------------------------
> >
> > * libsepol: fix TARGET and LIBSO on Darwin
> >
> > * secilc: use correct long option name for -X
> >
> > * Fix problem with bounds statements in optional blocks
> >
> > * libsepol: Fix processing of levels for user rule in an optional block
> >
> > * libsepol: Fix problem with handling type attributes in role-types rul=
e
> >
> > * libsepol: Fix expand_role_attributes_in_attributes()
> >
> > * Allow type attributes to be associated with other type attributes
> >
> > * libsepol: Support functionfs_seclabel policycap
> >
> > * improve semanage man pages: Add examples for -r RANGE flag usage
> >
> > * libselinux: fix parsing of the enforcing kernel cmdline parameter
> >
> > * seunshare: always use translations when printing
> >
> > * treewide: add .clang-format configuration file
> >
> > * setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
> >
> > * libsepol: add memfd_class capability
> >
> > * semanage: Reset active value when deleting boolean customizations
> >
> > * python/sepolicy: Add support for DNF5
> >
> > * sandbox/seunshare: Replace system() with execv() to prevent shell inj=
ection
> >
> > * libsepol: Tighten checks on MLS range and level when validating
> >
> > * libsepol: Fix potential NULL dereference in policydb_read()
> >
> > * libsepol: Fix potential use of an uninitialized value in link.c
> >
> > * libsepol: add bpf_token_perms polcap
> >
> > * libsepol: Fix possible use-after-free when expanding attributes
> >
> > * libselinux/src/Makefile: build python module without isolation
> >
> > * restorecon: Add option to count relabeled files
> >
> > * Bug fixes
>
>
