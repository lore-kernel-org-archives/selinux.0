Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB761313290
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939117; cv=none; b=LL5ljQ3kFf0rXWlW/ojHIAP4B6sH+2u9bRw0M8jl12qcNqPmdtf08P09YeeFk0029qBihNFX3hyNG+pTZw/EBdI3DUkbeO/JrZ8BByo2rjYpnwQ8ACPfl6XRSiy5FpVR4kUXYtDkkmAIcxQi9nZR/hlE2szQUyL/BaV1F9k/H9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939117; c=relaxed/simple;
	bh=QOUQnr4+Q9GiHd/JSOEQsz/2lCiwl+dl56NAmMak8mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5u4Mapf6IPxHcwfjtWUToN3A+X0IC1SjpSS62rxAoXKW22PkOnZVdAB7+/GoUf7/Uy7ZjBUTmRH+8zC/g2Fv+295PEydUxpPxN6fvCUMjfoHBMeDT9RKVNCL8gYtNbabQgJhxEm97VOA8di7NVvPSi7Cn570ETkw3XFWbZxw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWE3iM3R; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWE3iM3R"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-327f87275d4so3961011a91.1
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757939115; x=1758543915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uABdooFnwfoxvZBzTVHW7Qrdl8ig3IbwB5XkOLEs2iU=;
        b=XWE3iM3RHeWw5v7bySTUo0BgLwY66NBbmDad/NWd1Qiv6Y1lgb5aR7eF54vdngNfWu
         G4xy4gD4g/bwTAuYLsXjbMqx8Ekl66xG2BWCNn0nncht97W/Qb1KXpzTcevtUExvfVdD
         eFUZXXcnWNoHQb98VC87E8CTLHz9hE4MpyaloxxP1CaF9maTL1xsgvCPXkJAsMVgb/no
         f3cUuAI1W620e9fiSTFniYCGvZLXMujbGZykau0kJTMdBt0SQSa/x84jdJjN833YfdWQ
         TLJb9ljY8ri8RZTy273ILfe+Y9sBnWtlZUyqKxfjXVgWkW6hstiD+bWR+vh3ZCCrky61
         dP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939115; x=1758543915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uABdooFnwfoxvZBzTVHW7Qrdl8ig3IbwB5XkOLEs2iU=;
        b=aATShepSghhz7V19R5z63N1ykGJ1tZF2U1Z7zIAdzDQkYFP4+LJ3cak4CyMD6jpKHd
         QWb/T27rnNZy5catsST/eYvzMo4Ulv+WTkYQweQFj2u0ue446rrpJdZhQFKQhCXBw62O
         A7msp/Jo8FGAIVIlnYWXh40hfvjVOSs/5bkgOZufL3FmrXPvcXAhSKkKI12PphFjMugG
         4wIGZ/zJ7EsZiOn93+xgP4GiTiQhHOg8wmpGwcqNd54Y+PuyR6znQMRru4kzAWu8uumf
         2ThTYxiYYX9w9ybfc4cMcg26lw+d88CXMf07QBIXR7OVamOywiULZuNM1W+gLHiFer8g
         QtRA==
X-Forwarded-Encrypted: i=1; AJvYcCWjl1nNGLSqDKRmeF6ZWik8JAOEu7B+yd7szOLmtuVlU/2akY0v+sv3fc2reBsV683DMau60D9a@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ox7V9IKHDxSUJfTc/vgexYh246kJ5jLVHx3jn7UKIilrwhiv
	kvEspy1Px/w/71k7rgMdSikM/97DpFvXrp988U4+9D72EC+deD06Fx6J/Fb08QpYM8XM5Q6UNd1
	q+bgLWUb8u2yVY361W0UTsN86Gocz9GE=
X-Gm-Gg: ASbGncs+C4QMwZ3+J+TIqxtQkKG8/mqa/XS9GW5y6EO264svLspVclcQROPaULMPfw8
	eMDvgvy+IftgmpdM+lXRbJThvYfczxQx1/wZiNd1eyN6ThL8QMCcfON5qkCHycvQT1+xPOzPmGG
	NVGq6dTRULeDAJWjSRO6CSsFjLFD3GRaHt1nVWwS9tvaXYdYn1MAzdO1uaIVra83iBzzSmyQhbK
	Oz4Pi8=
X-Google-Smtp-Source: AGHT+IENPeC03l+z6RMxG1WWJfLbey30LKTSrzVCtUh4n2z1wryG2BQ9E46LH5hI84rrFCIYyQpjfM5YlYoiazlvSzk=
X-Received: by 2002:a17:90b:4c0d:b0:32e:6156:3571 with SMTP id
 98e67ed59e1d1-32e61564740mr3846689a91.18.1757939114910; Mon, 15 Sep 2025
 05:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78602e06-7db0-4e0c-9415-75098682e58a@gmail.com> <87frcpfvox.fsf@defensec.nl>
In-Reply-To: <87frcpfvox.fsf@defensec.nl>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Sep 2025 08:25:03 -0400
X-Gm-Features: Ac12FXzANP9kYVfXanx-BIiV24whKnqby-nNYg3fjoQEmIFaPdNcrbWBCp03m5k
Message-ID: <CAEjxPJ5fPtzKOyEvv04PQTtdEFSV7k1Sxarjbxv6V2jAnPs4bQ@mail.gmail.com>
Subject: Re: File access macros
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: Ian Pilcher <arequipeno@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 1:33=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ian Pilcher <arequipeno@gmail.com> writes:
>
> > I'm writing a policy module to allow containerized and non-containerize=
d
> > services to share content.  (Basically to give container_t access to
> > public_content_t and/or public_content_rw_t.)
> >
> > I don't normally make much use of SELinux policy macros, as the
> > documentation seems to be rather difficult to find, scattered, and
> > sometimes conflicting; instead I usually just use the denials generated
> > by the program that I'm confining to determine exactly what access it
> > needs.
> >
> > In this case, however, I'm trying to do something much more generic.
> > I don't really know exactly what permissions a given containerized
> > service might need, so I'm looking for a good, standard set of read-onl=
y
> > and read/write permissions for files, directories, and symbolic links.
> >
> > It sure seems like this must be a solved problem.  I.e. there must be
> > something like this macro, which Google Gemini so helpfully
> > hallucinated.
> >
> >     fs_read_access(<domain_type>, <file_type>);
> >
> > Thus far, I've been completely unable to find anything like this.
> >
> > Am I wrong that macros like this exist?
>
> I can give you an example of how the public content feature might be
> implemented with an example. the refpolicy ftp module:
>
> There are two scenario's there:
>
> 1. by default ftpd_t can read(only) public_content_t and public_content_r=
w_t
> dirs, files and symlinks:
>
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/serv=
ices/ftp.te#L251
>
> This interface is defined here:
>
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/syst=
em/miscfiles.if#L915
>
> 2. write access to public_content_rw_t is conditional in this
> example (with a boolean):
>
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/serv=
ices/ftp.te#L16
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/serv=
ices/ftp.te#L260
>
> This interface is defined here:
>
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/syst=
em/miscfiles.if#L937

Just to add onto what Dominick said, audit2allow -R will try to find
the closest matching refpolicy interface from a set of avc: denied
messages, although YMMV, and there are also a set of general file
access patterns and permission set macros defined in the files under
https://github.com/SELinuxProject/refpolicy/tree/main/policy/support
which can be found under /usr/share/selinux/devel/include/support if
you have selinux-policy-devel installed on Fedora (or similar on other
distributions).
/usr/share/selinux/devel/include/html should also contain the
generated documentation from the refpolicy sources.





>
> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
>
