Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B47345752
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835138; cv=none; b=N9nvMO+zFP5qFiCnUWxGr6/JKvSy0fScijYozHTYaaQxgEK2cfboAf35ybYSuaQx4RvnXjZIwjEPrdklvV5xcpfwdWP6InY3lZPIVpntMJClfohgrI+UxmwsSBN3SzZYyNul1Jff53jR5+DOXYgVAfwltzanSqvbKAYWBH+TK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835138; c=relaxed/simple;
	bh=1ar368/cIpOPpD+zr295sSTi67MBB133pKI2re95ynE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVi/UaVkMzLqgGfBOYdWZTFKm1Chg7imy6P5Dp2xIef8IzBYt+vU71RhKwZ5Snqci/E7Nr0giJ0hZaGRY374jEQxsGBhH7V9jOyUS+FwiVmkJcwElPKP8u5i/MihBjhKjGASZEktGVzhBLAqPBbXYx0Z0ik194lp8TtMfWzGz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkJ+ySk/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkJ+ySk/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47174beb13so3815100a12.2
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835136; x=1757439936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMoZJRVHa9OmxxHk1b+yQ5PUn3jTpgybBli4xSvWxfc=;
        b=KkJ+ySk/LxYUAnYUHbuCbZHcAQh7LQXVUHZ86uJ7CNJYSrEnmIAJ3PwIceHif0K2ri
         2ZffOe57yv3KiUEROut4dPqsFYV2KjIuwso6tre3lsBFQqQPWfQ/RsDEiG1Y5A6Gmyii
         n34JQzfT/AfWAS4yHIIF8Ge2hYqs3BFJ3Ma9JCGFEZjpW7ubPJ23zUMyiIfF6bXKwpus
         rZxKODu/lDxNK453LoIPU6HfS4eDPBFXgiivC0FF3cHmLxvHeaw7G//0yTVwb0L3G/ga
         d6zA9gHYvE2q+7ap/rXwtcL0sbJxDPZ3v0mJwSAu50unquenthyI3919O6k/VnLhi10k
         3fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835136; x=1757439936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMoZJRVHa9OmxxHk1b+yQ5PUn3jTpgybBli4xSvWxfc=;
        b=McDzNzGngWpi+g6jI4YCP2TfJZA3QdTqmXuvktO+bD4AZu/nybdAOyxkyywsziyVBh
         ipxjJGsdoMfaWZOi1G6TrRa0taS6s0PymtQtgnleDJcKquxgl5NrMTsRc85aPsYlfWTw
         m9hqWMtRMt63ykRPRkeHbEjerwud29JR5AH+EZ5SGlzJjJ5zowDXXkls1AWMf67cfafn
         +BFZ1WsQpbbrdFHTFpg8qR/f1skUIOS4wPGUkJvu5VAUWV6uVG6pWk8rM/9kPFO8t8p2
         7nhfuberwA7EL/MXN+dQqsiI0+hZfCD1Qdt0/TjFyxtbBbkRYu0jj+3PCprItL0USEm2
         zBMA==
X-Forwarded-Encrypted: i=1; AJvYcCXGmeSkQEyRSPKYUfMa0V5MT0DhQTLRlxD7K0EaXPH1JrdFWxIV+XlioVL9m2lZfUSD+A9ymJ0o@vger.kernel.org
X-Gm-Message-State: AOJu0YxEa9HFtdQAIBegQOdLWtYxEyk10bevb1Aw3rQF72g2nXCriF0o
	m7R9ZseW4SbWUliwtWn/Byp3nVPrKGPmWB1W2v1hpmx7vd57lBys49X+eB7iCVq3swTY7Xs2OUG
	XVVNi/4uwp3YOK6gDZph5/okB14+6uypsUA==
X-Gm-Gg: ASbGncu+bT8dR/2oK1evcR3UoAqzg5PoXlqPXX2KLGGsUWNDrzRtDPEnqVvTKc6de6G
	tzUzRMeZiyAZ0eEwFrjYx2lSDw4N+b7nVDMgDYlpb7m0SbPd1FrxOblt43YgKkcMgHx/bI8lfvI
	gAn88IbAt6O4ylo6TcnkRmjKSC2zHfz08xOni5+ZjkZglCWBOeHqXOqEu4FWmjkeqHO0uZDuKls
	GYMCseFFaxbeXdBiw==
X-Google-Smtp-Source: AGHT+IGQDXSWhlTZFlQd4MP17lMEeRdDcF5MBK0PisHinhbuJa6UVuQgR5Xj7N1dxrGiKCL/JpPKYVhaBO8+ik74u8M=
X-Received: by 2002:a17:902:c946:b0:24c:6125:390a with SMTP id
 d9443c01a7336-24c61253bb3mr16684995ad.10.1756835136110; Tue, 02 Sep 2025
 10:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901143412.2904562-1-rjones@redhat.com> <20250901143412.2904562-2-rjones@redhat.com>
 <CAEjxPJ499HdhmsfX7kbchq7JFW07RD6jY5CrZMAAc3wZ+bbjXQ@mail.gmail.com>
 <871poo96ld.fsf@redhat.com> <20250902165435.GA1480@redhat.com>
In-Reply-To: <20250902165435.GA1480@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Sep 2025 13:45:24 -0400
X-Gm-Features: Ac12FXwop3xwOhWJKeKavNiAJNwSxr-ViGcY8lmVyki4J9EO5rpJ64VM_EGwLcs
Message-ID: <CAEjxPJ5BbCtQNjEdeSaHH1-54xzkYn_Qgptu91QKwfMQyyB9Gg@mail.gmail.com>
Subject: Re: [PATCH] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:54=E2=80=AFPM Richard W.M. Jones <rjones@redhat.c=
om> wrote:
>
>
> BTW we seem to have "forked" the reviews.  I made an update to the
> pull request, as requested by a reviewer there:
>
> https://github.com/SELinuxProject/selinux/pull/490
>
> I can post a v2 on the list if required.

Yes please. The actual SELinux maintainers only review and merge
patches on the list.

>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> Fedora Windows cross-compiler. Compile Windows programs, test, and
> build Windows installers. Over 100 libraries supported.
> http://fedoraproject.org/wiki/MinGW
>
