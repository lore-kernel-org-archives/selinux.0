Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CE1A2389
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049331; cv=none; b=aCJzNn+imWHH/qtCqrGfTqxpCpib7q1MdUXCaAQc95VAQCHS+jPxlmKY2OhITJdSgIzwBjUr91M7zPOXNTVWFV3dzpA2VzV5Yar44QfLqid/s9X0ALR3ch1IHExdk4duBZ162VgzPdV/VL3UxSNhsQh9cRpW5LcxzcG2fBmfDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049331; c=relaxed/simple;
	bh=Sg+kx4q0NazTPyycIRfYC8P9cj61eqowngRgLetnASc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcopcUV6hgmm2d4p6w+Ffo8PEBrVKfUeY7VZmg1ztUEHPALVQ1ci2HLxaPxvdvPXJTj+GceM5LshGoiqlu4AdvbdQxzMCqp4h12hmX+4SoRwY7INIiS5E6dUfC+rF5LMk2XEkrcDU9FFI6pAzqiGLfv4zUbcT7dV+q2dWdGeEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CuPlVOMo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CuPlVOMo"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e1c40ecb0so2495109a91.3
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758049329; x=1758654129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7kOby+LiZCEqRgnjpWbxLDXU8ItrJIpBG6mfssPgBE=;
        b=CuPlVOMosQEoabTSdI6dDBPP4ZD7E4n0iJmmED8u6lrTm2OeZBvzTiY4ebWJvR3KsC
         +8meZu5KExNNFJkiIuOzlGVaM3pTYnSONsT9w01wT26tLMEgZ/9Nd+rH7A7xnXlaLljR
         E/LBKLEpLEXuuEVeC7N+87YnE8oVb+U4ND4v9Uj2WViwDDkY8qHhshbDS/CzqeLkjSuL
         e681Ezw3KQGlYkVsiSA+S26Z5nTS09C6OOHkS82ElUPVEjnQWgVUS15fGztv79Bkm/eF
         7PLtYBPNB4GaO3vvPBDP5vrO38+nt2mGE8aX1yNCcqkXN1BZxvr3wRFAh8LVvPoRdlrq
         25RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758049329; x=1758654129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7kOby+LiZCEqRgnjpWbxLDXU8ItrJIpBG6mfssPgBE=;
        b=gcoQ3evVU901sWZNyAHSdsn/8xR2XyGr/SiONcF6W+PxGxNdmv6e72Z/v+eUXymo6Z
         5b70yIHF2pfeD1kXxn5NSd1UTXl1MiIVoydIrF1+N5NpZADyvTJG3Nb1hqGrQIRwq+z+
         gu3GfdeI4IdwaQWAuyuJyNp2WiLBkzFlaNf6TYkIjo+bdrKjHzelAMnn0nWIRjp0OfUT
         ohQgbZkJk9tpAoZLAqwuIFStC59A1c5ehfd8wifVwPAMvzs6yX4HwlI30jmosOQz0Ceb
         zVyIrC3tQtS+6c6kHPqEr6KIpx4/89U/6EJiYnRLKD2hHOW8ocZGxeXVfxEddhF4/y1G
         quVA==
X-Forwarded-Encrypted: i=1; AJvYcCVwQUfTLNY/T1fKPCoisG7kfmkDFTzBeuCj4tmpA9GD5795yRgwie4+YektYAeEMI24IkSk7U/h@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqg8gg1QniBlIWEvmLkFS+KADEOt89Q/jORmggu6SoleuunjyQ
	tb7YfgHhQ+DCyzxFkhbAq/BxC+VNX+IOi0w0fuxcT5baunZh9m0igQ9o+ULCpyWaLhoUBjjkEGv
	IIbPzFGaIWGIsx2GQjd1kodx6SXXzvkLi2vPCr4pP
X-Gm-Gg: ASbGncv8WUOaTxNOzWMtlOPwxQbwVdBRDDB9qwsUKAgPGm1NdpkdbGZJ1nXnUjFdXie
	Jel/erXPNCmPtlZCeK7YyEHJmBzHL6FhbLAdMCLBPA3el20NLFIP/F8sqTCH08fLL8urnDgyGXH
	fSyvZ4ksWqhq/pAELU1hwkxdWfvdlJCrC3J2ZvI/06dkkybavgS77BAFEWk7k5Who4aHvAXIl0y
	7JPEPk=
X-Google-Smtp-Source: AGHT+IExktKzFcvvXful1IUQpZLpF7VzSzA2hxyi1ZyatFWSxAFp5DTdrk4y8nmtXMgJl1cd0ojTV2bY6BDTLom74Ms=
X-Received: by 2002:a17:90b:3907:b0:32b:d79e:58a6 with SMTP id
 98e67ed59e1d1-32de4f97ba0mr18912467a91.25.1758049328814; Tue, 16 Sep 2025
 12:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
 <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com>
 <1ea8829c-7b4a-4048-8045-768b5af70218@ieee.org> <CAEjxPJ692h1RbJfHLGfVye7diVW1r5WJz=P0iZeNet0gf8Qusg@mail.gmail.com>
 <d3a2e381-1814-4d14-978a-8a2ad02063a3@ieee.org> <CAEjxPJ7mc1AtE1m1_fypn-q=Y=+WiGPpgkmHPZCdbWMqSdQQ+w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7mc1AtE1m1_fypn-q=Y=+WiGPpgkmHPZCdbWMqSdQQ+w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Sep 2025 15:01:57 -0400
X-Gm-Features: AS18NWBUhyMTIl0NZ6SlvThM_B56f7ARFfA4dHWk2Ogkr66PL2F5GBxFVxNFn80
Message-ID: <CAHC9VhTCzGXv=2oET6404_XNTDxsHXA+=g6--984GNXpWQjEQg@mail.gmail.com>
Subject: Re: Lack of official hosted macro documentation
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Chris PeBenito <pebenito@ieee.org>, Ian Pilcher <ian@penurio.us>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 15, 2025 at 4:16=E2=80=AFPM Chris PeBenito <pebenito@ieee.org=
> wrote:
> >
> > On 9/15/2025 3:38 PM, Stephen Smalley wrote:
> > > On Mon, Sep 15, 2025 at 3:26=E2=80=AFPM Chris PeBenito <pebenito@ieee=
.org> wrote:
> > >> On 9/15/2025 2:01 PM, Stephen Smalley wrote:
> > >>> On Mon, Sep 15, 2025 at 1:56=E2=80=AFPM Ian Pilcher <ian@penurio.us=
> wrote:
> > >>>>
> > >>>> TL;DR - Writing policy modules is harder than it needs to be, beca=
use
> > >>>> the documentation for the macros/interfaces in the reference polic=
y is
> > >>>> not easily discoverable.  This could be helped by hosting the gene=
rated
> > >>>> HTML documentation in a location that would be indexed/processed b=
y
> > >>>> search engines and AI chatbots.
> > >>>
> > >>> Great idea. I thought we actually used to have something like this =
but
> > >>> am not finding it now.
> > >>> Chris, any clues?
> > >>
> > >> We did have some generated pages, but when the project moved to GitH=
ub,
> > >> there wasn't a place to put them.  There hadn't been any requests fo=
r it
> > >> to return, so I never looked into it.
> > >>
> > >> `make html` in the repo checkout will generate them in the doc/html/
> > >> directory (from the repo root).
> > >
> > > Maybe we could put these in GitHub pages for SELinuxProject?
> >
> > I have no objection.
>
> If someone else were to create a GitHub pages repo for SELinuxProject,
> I can help maintain it.

That's on my todo list, at least for a demo site to see how we like it.

--=20
paul-moore.com
