Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177F1F3D56
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961662; cv=none; b=jRKDLW5KsjPyjujpAT0alclSbAl5NnvBYlcXflOtHfV0gywyszmPS/YDJGhp8MZHmk5Ut0q1dHQUmByGedQIRUYS1pblttISSuPAG7EcU/4pJ2EtF3Y7MF/AokGZhh8LUvsH/HHMtMWs+MN2j77T+Ky4/5JnCCcTuNL0/dAE4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961662; c=relaxed/simple;
	bh=vmS18DT5vhs/P/iYzUrgIUNAvHSAwO9Xpx+aoVub9Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/CrEGEQok7x5lpqNHBxEzbsREw/KFnGgtpvErpIPnccqhQwdqQGEdyFU92yyQCXxY6oP8ZNnOkLf41p4GgVq8YT8yEmXB4XlpXMiyg45NUN8/vlpMj7IZA3QOTj7xjSeqjvIKiUJ9FpKu+kkskf78+pXa0qVXv5wnIiUdIKYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/1Z7Slp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/1Z7Slp"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso5664738a91.0
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760961660; x=1761566460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjJ6HL94vDPKmqWUkar1fwveTOnRRtstIFKuFRzJHqk=;
        b=f/1Z7Slpd9Qh75gguWsr7D/4mVDi6ztjJJvFHHYLGkcigxsaQyZs+/1Lq76LtN9Eoq
         XjUPLQXJxwscQBsxrmqgtNaAHfNQXR8ZV8T6mlG+5eeixI9bgz1Fi+COY1/Sj8OOz1xt
         ieeS9xL4ireXVUAJWibXkv6om5yrVQtjoXN6uszGN9QfU0Bb6PFWoNimqmDqg47/4TsS
         EiUvMhl4LbgNZQfBeij6iLdxgqcKzP8wY4MrpYniU7Qio3G1UVmrtyUMPoSqkk9aoR7O
         mjeYDstYrn3z5qh58Ye3SBUr3Hyn4WPcA/OYzzbnpAFwYhp2TbIYXsRYLtO4VySFNMFs
         qDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961660; x=1761566460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjJ6HL94vDPKmqWUkar1fwveTOnRRtstIFKuFRzJHqk=;
        b=f9Cfdsgui7owHwAO1yPLVjUfekNOV0JdNCstuFlVimAcbJw1ylewIPJc+WnGnoyoNp
         uIgvq2rwTclMVpuFZt8BviGsrmHT9ohRJC8GWWYooYqHLEhxVbJb5ae9tXs859cFYEQY
         fr+QV8iUjCjLWAkE7TK86ZYCvXIPkluvgcSVx6E8uS1SX3RyIsiy6jaV5YxMn+z1ATCe
         7wGDn77vIYFirLqqtzLxaKZiHdsJC3sB+QLwhnZ7OhXpMDhb1QpkzoOFJVIqZQwwkkFF
         JXEEFNkF3vGXBOI0qkDzHECrA2oYQ0qx4nCBW8QxtYk17C3JJ+TLKYpOgI508107XyzF
         nuBw==
X-Gm-Message-State: AOJu0YyFCjwpNuMwafWKUvDel/v+PXtS356zfQEkMUSsQ9tDkgJRiF5H
	UHFF5S1WNRgWpqNA0aLt5olyJZzuf+CZS+2m56TZkFTOt4IhSYHSeM9gTlIxAeVz0WTjcs4YHxe
	zHFYQhJooNzGm8bvrZ0jq5+lMC5nYfwA=
X-Gm-Gg: ASbGncvlFTGfkfowTyNPKaNBYpJGQAr1Nk/dj45QRrtpeKQClX8yuzsoe7LGNnDri+Z
	uxLo7ktAx28H3PEnvP9KTbllKgEOg5/uteGJolEnMNyT1XdDAbccdIa3HwPJcUnhaE2Az/ujA9l
	uKCWFSpNmSVcY2DTJi2+Z2Hoh7/KzVbjRkrYIZxqTe7Gd86Hbu7TPbv//kcrqh1u2UNPNTvp9e6
	UKMC3v7ohUUC7ZvdOABek03qpinCReJvPX4fx8EhKngmAh1RKtS3JLq8B4y/5wB9Xb/Kpk=
X-Google-Smtp-Source: AGHT+IEBMxehuX14L76g7nQfJzAAcaRSxbqjsVMD1fEOKuoXFiRANw9G4uGqkMvguFl3AgV9ypLDkF6Hm+SkYS0hK3A=
X-Received: by 2002:a17:90b:3c02:b0:33b:6bff:35fe with SMTP id
 98e67ed59e1d1-33bc9d1c743mr17654211a91.16.1760961660114; Mon, 20 Oct 2025
 05:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623102726.3818713-1-vmojzis@redhat.com> <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
 <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com> <CAP+JOzQCoCY8AuY1njM1PyZk7gJZ5Ed_hc5ANXEcznwx9EAqQQ@mail.gmail.com>
 <CAP+JOzShgrLBiesobVHWPQ9gZUrWvt=x8OhZ3m8ngyG_Vs8gkw@mail.gmail.com>
 <bd163350-a979-4af9-97a2-80f65f123054@redhat.com> <CAEjxPJ7ijHMzX8TwCxYvEH6ye2NP_Fw=cCfqXwph9Gfxr6oXQw@mail.gmail.com>
 <CAEjxPJ7uga6hHTbPVswoeUikOB2BJ-WdcMeK45miu1LyDhbgCA@mail.gmail.com> <1bfde702-68be-4521-bc5f-b018c3131568@redhat.com>
In-Reply-To: <1bfde702-68be-4521-bc5f-b018c3131568@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 08:00:48 -0400
X-Gm-Features: AS18NWBXYMJ2XCUc7pLkxNjv2N0H4qYziwGhPlg2C6OxKA77QiEMa08zGYpXvCc
Message-ID: <CAEjxPJ5OiqH1omsm_LhBrdocC3q64TbH=K7rx1+ZON2NRjbwcQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:22=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
>
>
> On 10/7/25 3:57 PM, Stephen Smalley wrote:
> > On Tue, Oct 7, 2025 at 9:50=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Mon, Jun 23, 2025 at 3:25=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com=
> wrote:
> >>> On 6/23/25 8:21 PM, James Carter wrote:
> >>>> On Mon, Jun 23, 2025 at 2:06=E2=80=AFPM James Carter <jwcart2@gmail.=
com> wrote:
> >>>>> On Mon, Jun 23, 2025 at 7:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.=
com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 6/23/25 12:56 PM, Christian G=C3=B6ttsche wrote:
> >>>>>>> Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
> >>>>>>>
> >>>>>>>> Allow "typeattribute <attribute> <attribute>" to pass checkpolic=
y,
> >>>>>>>> since (typeattributeset <attribute> <attribute>) is valid in CIL=
.
> >>>>>>>>
> >>>>>>>> Fixes:
> >>>>>>>>      $ cat myattributetest.te
> >>>>>>>>      policy_module(attributetest, 1.0.0)
> >>>>>>>>
> >>>>>>>>      gen_require(`
> >>>>>>>>        attribute domain;
> >>>>>>>>      ')
> >>>>>>>>
> >>>>>>>>      attribute myattribute;
> >>>>>>>>
> >>>>>>>>      typeattribute myattribute domain;
> >>>>>>>>
> >>>>>>>>      $ make -f /usr/share/selinux/devel/Makefile attributetest.p=
p                                                                          =
                                                  2 =E2=86=B5
> >>>>>>>>      Compiling targeted attributetest module
> >>>>>>>>      attributetest.te:9:ERROR 'unknown type myattribute' at toke=
n ';' on line 3418:
> >>>>>>>>      typeattribute myattribute domain;
> >>>>>>>>
> >>>>>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >>>>>>>> ---
> >>>>>>>> After some simple tests with CIL policies, it seems that attribu=
te
> >>>>>>>> assignment works as expected. Is there a reason checkpolicy does=
 not
> >>>>>>>> recognise it?
> >>>>>>> Did you test that all types associated with myattribute are the a=
lso associated with domain?
> >>>>>>>
> >>>>>> Yes, also please see the more complex example below (mytype_t is p=
art of
> >>>>>> "a", "b" and "c" after being assigned to "c").
> >>>>>> As for the "domain" example:
> >>>>>>
> >>>>>> $ cat typeattribute.te
> >>>>>> policy_module(attributetest, 1.0.0)
> >>>>>>
> >>>>>> gen_require(`
> >>>>>>            attribute domain;
> >>>>>> ')
> >>>>>>
> >>>>>> attribute myattribute;
> >>>>>>
> >>>>>> typeattribute myattribute domain;
> >>>>>>
> >>>>>> type mytype_t;
> >>>>>>
> >>>>>> typeattribute mytype_t myattribute;
> >>>>>>
> >>>>>> $ make -f /usr/share/selinux/devel/Makefile attributetest.pp
> >>>>>> Compiling targeted attributetest module
> >>>>>> Creating targeted attributetest.pp policy package
> >>>>>> rm tmp/attributetest.mod.fc tmp/attributetest.mod
> >>>>>>
> >>>>>> $ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.c=
il
> >>>>>> $ cat attributetest.cil
> >>>>>> (typeattribute myattribute)
> >>>>>> (typeattributeset myattribute (mytype_t ))
> >>>>>> (type mytype_t)
> >>>>>> (roletype object_r mytype_t)
> >>>>>> (roleattributeset cil_gen_require system_r)
> >>>>>> (typeattributeset cil_gen_require domain)
> >>>>>> (typeattributeset domain (myattribute ))
> >>>>>>
> >>>>>> $ semodule -i attributetest.pp
> >>>>>> $ seinfo -xa domain | grep mytype
> >>>>>>        mytype_t
> >>>>>>
> >>>>>> I also tested the functionality on a combination of multiple attri=
butes
> >>>>>> from container module and all seems to work fine (at least as long=
 as we
> >>>>>> can trust "seinfo" and "sesearch"). CIL is not even complaining ab=
out a
> >>>>>> mixed assignements that result in some interface calls on attribut=
es
> >>>>>> (e.g. kernel_read_all_proc(container_t_domain) -> (typeattributese=
t
> >>>>>> can_dump_kernel (container_runtime_t container_t container_t_domai=
n
> >>>>>> container_userns_t container_logreader_t container_logwriter_t
> >>>>>> container_kvm_t container_init_t container_engine_t container_devi=
ce_t
> >>>>>> container_device_plugin_t container_device_plugin_init_t ))). In
> >>>>>> combination with "typeattribute mycontainer_t container_t_domain;"=
 this
> >>>>>> also works as expected:
> >>>>>> $ seinfo -xa can_dump_kernel | grep mycontainer_t
> >>>>>>        mycontainer_t
> >>>>>>
> >>>>>> It is by no means a complete test. I was hoping someone here would=
 be
> >>>>>> more familiar with attribute assignment and would let me know why =
it's
> >>>>>> not allowed or that it is just an oversight.
> >>>>>>
> >>>>> I don't think the kernel supports attributes being assigned to attr=
ibutes.
> >>>>> For CIL to support typeattributesets, it expands all attributes whe=
n
> >>>>> it evaluates the set.
> >>>>>
> >>>>> I think what is happening is that binary format unintentionally
> >>>>> handles attributes being assigned to attributes (even though that w=
as
> >>>>> never intended) and since CIL is creating the final binary policy f=
or
> >>>>> the kernel all the attributes in an attribute get expanded.
> >>>>> It might actually be possible to start allowing this, but I would w=
ant
> >>>>> to test more to make sure.
> >>>> I just realized that the fatal flaw in this is that the kernel binar=
y
> >>>> policy produced by checkpolicy will not work (if I am correct that t=
he
> >>>> kernel will not properly handle attributes having attributes and eve=
n
> >>>> if it does there could be severe performance issues).
> >>>> Jim
> >>>>
> >>> Thank you for the analysis. Does that mean that I need to test that t=
he
> >>> access is actually allowed? Is there some simple way to measure
> >>> performance (or are there other side effects I can watch for instead)=
?
> >>>
> >>> I just tried replacing all the rules assigned to container_t with
> >>> container_t_doman attribute
> >>> https://github.com/vmojzis/container-selinux/commit/3645ca555ed5b5aac=
bd64e300522cfc6e2fbc493
> >>> and a comparison of sesearch outputs matched between original
> >>> container_t and mycontainer_t that was assigned to the new attribute
> >>> (outputs attached). So even complex policy constructs seem to at leas=
t
> >>> transfer to CIL properly.
> >>>
> >>> Thank you.
> >>> Vit
> >> Sorry to join this thread late but I believe James is correct that
> >> this is NOT supported by the kernel and hence won't work if one
> >> compiles policy monolithically with checkpolicy as opposed to
> >> compiling it modularly (which ends up indirecting through CIL). Hence,
> >> we can't safely allow this in checkpolicy itself except for modular
> >> policy and even then only if we know that the libsepol on the end
> >> system where the module will be installed is going to handle it
> >> properly. If we were to alter the libsepol expand_module() logic to
> >> replicate whatever it is that CIL does for attribute expansion, then
> >> maybe we could allow this in checkpolicy too.
> > Also, I'd be willing to allow this in checkpolicy for modular policy
> > if we don't care about ensuring that it works on very old Linux
> > distributions that don't use CIL-based libsepol.
> >
>
> Hi, thank you for the analysis. I did not realize monolithical policy
> was compiled without CIL altogether (since I only ever work with
> modular). Frankly I probably do not have the expertise to implement the
> change in expand_module() logic, but I'd appreciate if this could be
> merged with the current limitations (modular policy and CIL-based
> libsepol only).
> Should I note the limitations in the commit message, or in some man/wiki
> page?

At compilation time, we know whether we are compiling monolithically
or modularly, so we should be able to trigger a compile-time error in
the monolithic case here.
