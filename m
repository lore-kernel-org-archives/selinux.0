Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E062F9DA1
	for <selinux@vger.kernel.org>; Mon,  3 Nov 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179804; cv=none; b=Rjq5ASAcT96u9FrVrfxDADapdCFhDbG/YKcKfKUZhN+D9cwGpsyXt4mK74SzudE6so1+rv6RLW6R2ku6pt88RF8/hdbJ1oFXPfuKPeTJ0HNqNGYmyepZKiMp3DzLYijk44ckmyA0LJL6bTnSDfZ65Gfsifa8VeY8t/uRp6e1Y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179804; c=relaxed/simple;
	bh=417rO+UUZ4PKJJXcqWMWodtliWA8uHvqLDEjvCIcrz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjiCnGM3EiycqVyk0t81SSIimmXwmmWd4NRuQz72MMRwcnOSJ5qlmQ+c4s9YGtfhbx/jVsmkTNv5ZXF3Z4iTJcZv5bbBLSvXBQEQBKAEIvzRgcwbW4dADffdud84woFQO6YVyztfQQevvAXTwOxi5eFjzapI200cr0HbJr/H/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjOsL8sN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjOsL8sN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33292adb180so4902102a91.3
        for <selinux@vger.kernel.org>; Mon, 03 Nov 2025 06:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179803; x=1762784603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=417rO+UUZ4PKJJXcqWMWodtliWA8uHvqLDEjvCIcrz4=;
        b=HjOsL8sNc97peSf8OpE/11V9LYEQMRh1Tyc2w8e992vWIyJRnMT2nCPrzrRjIiaij0
         T830dGgdGKJbfv0zLkaXdxn2FJPeDDnBDHVz0CTtE+tOxCFvauyh24WMiX8texR0mdLy
         RWd3rtvrf75iGsAEpIoUmxllQlKINb2n0sM2FjtpoKqATRMlw6x1O3BHZNcEZoMZrAaZ
         4u2pfEjkvUb7i0aHRXNC6q0V2FchDxab4AULhIZw+gcTQA87dY6CXQjRiFoqplddLg0A
         kdnuYCIO60344mG4wzM0/Y4omOJTIkSwhmEtEV8R4ekuMESYcxSqxTx4A15KLKO5JE0X
         kXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179803; x=1762784603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=417rO+UUZ4PKJJXcqWMWodtliWA8uHvqLDEjvCIcrz4=;
        b=BTpxdp+bylrnMyboqwaMphj6a4u5El2jNmJrp+Q9Tp/2ZcdRoZWFxbJRNOLHeeyax2
         hb7/Dp8aLIyprCCYZi3p4YxjqN6AnC6oBP+hSSQDl5/KGfsWo7g7cHUvtp9AgNx10exD
         HmzGhDbdPpRfMuy3jA2QTU9kfduvbv57H9+z3ycJqFjp6EisiDZjYPd50vyF/xRrajcR
         W1rfvrLE9WS9YnOMlBEQofdrWhl/TU1aC51lH6KCpp/CcaJJWhGGbo3ThkSuy6jSWiRr
         3lfSg0W4X1HqU2gjuHG5OCtarCbkDb0dIZKZwL0QLqFVkc590Pjc80ekMNZ1W/3A5Pvj
         RkwA==
X-Forwarded-Encrypted: i=1; AJvYcCW6MiM0bgCiJNSTHYqo0bbf5Wo9O0v5bKmMF73Etm7wQe4tVibXILYtW6x6x48B3AHCOzdf6tso@vger.kernel.org
X-Gm-Message-State: AOJu0YzfL/ck4gUm+ohBgpawUOPkmaNT8VN7zeiB2Ko3ijogYRG/OW6S
	6vQz3evrq0VXigRfmSVfpFeJ6IQkfrU/knwJGfucmIQdgp2zlbEtcyu1HL0ZTUx9Cek1omqk7SV
	TiF1nYiYDilNmoftsPWD3tkGfhfaQc3c=
X-Gm-Gg: ASbGncs+xkMzUq4TZKX06Zi+WcdIbnCZIWzyj9NpC/VLcrekHfsH5Pgo+7hGYJN2/VJ
	qjVH6P+nC7mJ9hG7oaMVoku68gLL4TuYRmD8P/CKfktUqvf5ahWF7fIlAxn7f6XhN6BVRhMrjGG
	1tSuCcB2kSiwDHIreytHXoTpXextp3wcM0zIiLRkitruj04rzHD+mjlekYaSl1YKLuoHp6ltdXN
	sHk5O4XmzXnuNrrokJqqgJa8wq3qBmTiXM0k3UXhfESl2THsHZUxfiytytV3P8z0Xw4Tpk=
X-Google-Smtp-Source: AGHT+IEHwdc0KgxqM63Fv0Nl5Y2ICAPMtUelEWF9PObrwX0EKW+D8JRPK8SbLj5afej/EZoDwLzsMhncVW6+wMkW9as=
X-Received: by 2002:a17:90b:2b83:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-3408309b5d0mr15355896a91.32.1762179802626; Mon, 03 Nov 2025
 06:23:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030200720.18719-2-stephen.smalley.work@gmail.com>
 <9e69696a-cbee-4bc5-8679-5e5407490c3d@ieee.org> <4706985.LvFx2qVVIh@xev>
 <7788525.18pcnM708K@dojacat> <CAEjxPJ6D9DZhzQ4DivTv8y4AVW2hLJa1MciPgdOVywCLU4XG5w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6D9DZhzQ4DivTv8y4AVW2hLJa1MciPgdOVywCLU4XG5w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Nov 2025 09:23:11 -0500
X-Gm-Features: AWmQ_bmtkVPnBRvW1oRT28J5PEzoYuj-gz7R2IN5dBBzqnBQsuiVB3-OFB8Mr-w
Message-ID: <CAEjxPJ69MpEb266VUoWJUGEBVYPwV6g55nPBh8n_OzGJksrnbA@mail.gmail.com>
Subject: Re: [PATCH refpolicy] kernel: remove some unused initial SID contexts
To: Russell Coker <russell@coker.com.au>
Cc: selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>, 
	paul@paul-moore.com, omosnace@redhat.com, 
	SElinux list <selinux@vger.kernel.org>, James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Nov 2, 2025 at 8:07=E2=80=AFPM Russell Coker <russell@coker.com.a=
u> wrote:
> >
> > On Sunday, 2 November 2025 12:28:21 AEDT Russell Coker wrote:
> > > The above is what apparently used to be the policy so it looks like n=
ode_t
> > > is being changed to sysctl_t.
> >
> > allow sshd_t sysctl_t:tcp_socket node_bind;
> >
> > I also tried rebooting a VM running that policy (previously I had loade=
d it on
> > a running system) and got the same result with TCP as an additional iss=
ue.
> >
> > Also I tried kernel 6.12.48+deb13-amd64 (the latest kernel for Debian/T=
rixie
> > the latest stable release).
>
> My apologies, please revert. Due to differences between Fedora selinux
> policy and refpolicy, I did NOT test loading of the patched refpolicy
> itself but instead manually patched the base module (i.e. semodule -cE
> base, edit base.cil to remove the CIL sidcontext statements for the
> "UNKNOWN*" sids, then semodule -i base.cil) and tested that behavior,
> which worked correctly. Looking at the generated base module from the
> patched refpolicy, it is removed not only the sidcontext statements
> but also the sid declarations and omitting them from the sidorder
> statement, thereby perturbing the SID assignments. Not yet sure where
> this is happening in refpolicy build.

Ok, if I semodule_unpackage base.pp base.mod and dismod base.mod, then
select 0 (Display initial SIDs), I see the initial SIDs with the
expected SID values and gaps for those that lack a context. But if I
run checkmodule -C -o base.cil base.mod, the resulting CIL file omits
any SID declarations that lack a context and therefore ends up
renumbering them when they are compiled into a kernel policy.
