Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819712E0B6E
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845036; cv=none; b=AuOPEt2e+bQ4WwcJ6yqxWOCBlYnseKn5XJEnK/dFeIJZu2zEHLEfeV+TqdIOs17dxmiN39nBjePVqK3RE0ltXbUjbQYgIeTChdMYl+/dQZXEB4s5reQaAB3wRrCfPhupgR/EMCfMhtoSDgksOutBvbtUZFO3HljELmM1sdAb7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845036; c=relaxed/simple;
	bh=KfoYUtqAIArW5pTAiK1+bN08AU7+4Pv/Gr3DtuWWkHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Welx9X6F2Pgy2VL6LP9cgBVBSjluDfy2nwsSJojQpwqDzq4j+hgHjQiepuxoZ4/W9NeFZ4YkmdfG0U1iobokD4uZ6+F+L4ieh/gWnLZ+G/awd8zQOJibGNUhy5pZlKiCIri+4ZBgPEg1F/jYkXjoqcFcN9q0IGvMXAlcfuMzo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaYuFHzM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaYuFHzM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso7702537a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759845034; x=1760449834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHTwXnOP+p6tRJ87eac8IxFdBMPm7LSl7qzrztnSgF0=;
        b=KaYuFHzMh0rvcS/AhFowuQfrD54uePQF8PIWLugKYRv8EmIeJXr3ul86sAl8xZrCvC
         uCdYrYsQC9hhmOpUsYi1EDhk5eFzb8K6CTlzr4l+1xCknIEA+4BsY06IFjLQRpv1Ba4n
         bkYt1CFWbsUv6yTIs865lnCwPcjVWm6GzH+JBR3TGm7tjBtdU8P1QbnbMTjU3/QMuNlm
         KItdBrVHryIa3YLT9E/uxNJooY1tiER8SuqiY10HGtbqR+YjmJRs/q6FqU/dZEvD+Ipm
         gFmAPPt+8Qf5A0WnfDMoRKdOK76/3tFJxZsBIcmMBRrRomsubzKpblS7Mr04sdW8JbW2
         CNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845034; x=1760449834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHTwXnOP+p6tRJ87eac8IxFdBMPm7LSl7qzrztnSgF0=;
        b=lPqPZuSupG0YryF3NaKx0FQvUhRLmo3QhDGsqCDHsSZXm+LuQCh5dnSsG7eaC/gsGG
         CiK4DliJ/m97+670DR7oGAE1rppFBTvV/pOpH5BLoHxg8M4eTOdCnkXzfx8uIekfYVKY
         o3NOsfLJepLH+888JFdkr8tf68cnAYs2T/K5YvSZIgN4pfwbP2csp6j/T3DqdvwinwZI
         8EBlq+Sz+MbKrYkyujyouiu6mYQmShLJ14OCgkhz0bnZESE3K2w3akrNW191qsybo5qU
         FE8oeEUWhf3XJMmSSdsYyifl6xXUpv03MqCQZglyOvwqO8VmhCLQcoDwNkHHPXluO5yJ
         z7Fw==
X-Gm-Message-State: AOJu0YznrC8zEg5z3y9S1W7SXPRvIE27WQ3pSxgkbsPBbYp7w/G6BdZa
	oOQliJ0LSFAbTyDGQFJE+2GnOoXKGWdMiN0LGcVNJm1R3fE7eYm98azu/vwcfqTxbAHp2R41WB7
	HtuTrTrZW0UsOUnJnP3OGY5RmUSCEaNs=
X-Gm-Gg: ASbGncs514dttQ512utPu1MENPS9URU6hRa/HQAmxf0AwUkxC9z4Udpa7biRjcUjxeP
	IUTI4s+dp7mxZaoeQL0B6Albhq+EX7D74lAYWxXCRRK8ZxbN7aScYKTpNkCvMjVM/fOzCus+H5j
	bjW2PUv8vE/C4IbO9FG6IXOyR3oWjdQhz/cTXqyZbY1B9cMSs9XCTLzyV1xvkwgc5VI0K3LN+C5
	08a+HyE9JFUzBGjrL1XA7ogZXxSpTA=
X-Google-Smtp-Source: AGHT+IHNpITtxbwUIIrIgVqK7oUcJCqDI51McBdhUqDgiCsntWu1kzCUVW+16tt4ypz5fXsK2jny3RAfCIMZwnDQfdo=
X-Received: by 2002:a17:90b:514e:b0:32d:a37c:4e31 with SMTP id
 98e67ed59e1d1-339edadd3bdmr5521804a91.17.1759845033209; Tue, 07 Oct 2025
 06:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623102726.3818713-1-vmojzis@redhat.com> <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
 <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com> <CAP+JOzQCoCY8AuY1njM1PyZk7gJZ5Ed_hc5ANXEcznwx9EAqQQ@mail.gmail.com>
 <CAP+JOzShgrLBiesobVHWPQ9gZUrWvt=x8OhZ3m8ngyG_Vs8gkw@mail.gmail.com> <bd163350-a979-4af9-97a2-80f65f123054@redhat.com>
In-Reply-To: <bd163350-a979-4af9-97a2-80f65f123054@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 09:50:22 -0400
X-Gm-Features: AS18NWA0V6c2m01MVvBCdUbFOQao127VBJCJ8nDvH-NkFwKVcVAB_iy2YswVQH8
Message-ID: <CAEjxPJ7ijHMzX8TwCxYvEH6ye2NP_Fw=cCfqXwph9Gfxr6oXQw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:25=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> On 6/23/25 8:21 PM, James Carter wrote:
> > On Mon, Jun 23, 2025 at 2:06=E2=80=AFPM James Carter <jwcart2@gmail.com=
> wrote:
> >>
> >> On Mon, Jun 23, 2025 at 7:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com=
> wrote:
> >>>
> >>>
> >>>
> >>> On 6/23/25 12:56 PM, Christian G=C3=B6ttsche wrote:
> >>>> Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
> >>>>
> >>>>> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
> >>>>> since (typeattributeset <attribute> <attribute>) is valid in CIL.
> >>>>>
> >>>>> Fixes:
> >>>>>     $ cat myattributetest.te
> >>>>>     policy_module(attributetest, 1.0.0)
> >>>>>
> >>>>>     gen_require(`
> >>>>>       attribute domain;
> >>>>>     ')
> >>>>>
> >>>>>     attribute myattribute;
> >>>>>
> >>>>>     typeattribute myattribute domain;
> >>>>>
> >>>>>     $ make -f /usr/share/selinux/devel/Makefile attributetest.pp   =
                                                                           =
                                              2 =E2=86=B5
> >>>>>     Compiling targeted attributetest module
> >>>>>     attributetest.te:9:ERROR 'unknown type myattribute' at token ';=
' on line 3418:
> >>>>>     typeattribute myattribute domain;
> >>>>>
> >>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >>>>> ---
> >>>>> After some simple tests with CIL policies, it seems that attribute
> >>>>> assignment works as expected. Is there a reason checkpolicy does no=
t
> >>>>> recognise it?
> >>>> Did you test that all types associated with myattribute are the also=
 associated with domain?
> >>>>
> >>> Yes, also please see the more complex example below (mytype_t is part=
 of
> >>> "a", "b" and "c" after being assigned to "c").
> >>> As for the "domain" example:
> >>>
> >>> $ cat typeattribute.te
> >>> policy_module(attributetest, 1.0.0)
> >>>
> >>> gen_require(`
> >>>           attribute domain;
> >>> ')
> >>>
> >>> attribute myattribute;
> >>>
> >>> typeattribute myattribute domain;
> >>>
> >>> type mytype_t;
> >>>
> >>> typeattribute mytype_t myattribute;
> >>>
> >>> $ make -f /usr/share/selinux/devel/Makefile attributetest.pp
> >>> Compiling targeted attributetest module
> >>> Creating targeted attributetest.pp policy package
> >>> rm tmp/attributetest.mod.fc tmp/attributetest.mod
> >>>
> >>> $ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.cil
> >>> $ cat attributetest.cil
> >>> (typeattribute myattribute)
> >>> (typeattributeset myattribute (mytype_t ))
> >>> (type mytype_t)
> >>> (roletype object_r mytype_t)
> >>> (roleattributeset cil_gen_require system_r)
> >>> (typeattributeset cil_gen_require domain)
> >>> (typeattributeset domain (myattribute ))
> >>>
> >>> $ semodule -i attributetest.pp
> >>> $ seinfo -xa domain | grep mytype
> >>>       mytype_t
> >>>
> >>> I also tested the functionality on a combination of multiple attribut=
es
> >>> from container module and all seems to work fine (at least as long as=
 we
> >>> can trust "seinfo" and "sesearch"). CIL is not even complaining about=
 a
> >>> mixed assignements that result in some interface calls on attributes
> >>> (e.g. kernel_read_all_proc(container_t_domain) -> (typeattributeset
> >>> can_dump_kernel (container_runtime_t container_t container_t_domain
> >>> container_userns_t container_logreader_t container_logwriter_t
> >>> container_kvm_t container_init_t container_engine_t container_device_=
t
> >>> container_device_plugin_t container_device_plugin_init_t ))). In
> >>> combination with "typeattribute mycontainer_t container_t_domain;" th=
is
> >>> also works as expected:
> >>> $ seinfo -xa can_dump_kernel | grep mycontainer_t
> >>>       mycontainer_t
> >>>
> >>> It is by no means a complete test. I was hoping someone here would be
> >>> more familiar with attribute assignment and would let me know why it'=
s
> >>> not allowed or that it is just an oversight.
> >>>
> >>
> >> I don't think the kernel supports attributes being assigned to attribu=
tes.
> >> For CIL to support typeattributesets, it expands all attributes when
> >> it evaluates the set.
> >>
> >> I think what is happening is that binary format unintentionally
> >> handles attributes being assigned to attributes (even though that was
> >> never intended) and since CIL is creating the final binary policy for
> >> the kernel all the attributes in an attribute get expanded.
> >> It might actually be possible to start allowing this, but I would want
> >> to test more to make sure.
> >
> > I just realized that the fatal flaw in this is that the kernel binary
> > policy produced by checkpolicy will not work (if I am correct that the
> > kernel will not properly handle attributes having attributes and even
> > if it does there could be severe performance issues).
> > Jim
> >
>
> Thank you for the analysis. Does that mean that I need to test that the
> access is actually allowed? Is there some simple way to measure
> performance (or are there other side effects I can watch for instead)?
>
> I just tried replacing all the rules assigned to container_t with
> container_t_doman attribute
> https://github.com/vmojzis/container-selinux/commit/3645ca555ed5b5aacbd64=
e300522cfc6e2fbc493
> and a comparison of sesearch outputs matched between original
> container_t and mycontainer_t that was assigned to the new attribute
> (outputs attached). So even complex policy constructs seem to at least
> transfer to CIL properly.
>
> Thank you.
> Vit

Sorry to join this thread late but I believe James is correct that
this is NOT supported by the kernel and hence won't work if one
compiles policy monolithically with checkpolicy as opposed to
compiling it modularly (which ends up indirecting through CIL). Hence,
we can't safely allow this in checkpolicy itself except for modular
policy and even then only if we know that the libsepol on the end
system where the module will be installed is going to handle it
properly. If we were to alter the libsepol expand_module() logic to
replicate whatever it is that CIL does for attribute expansion, then
maybe we could allow this in checkpolicy too.
