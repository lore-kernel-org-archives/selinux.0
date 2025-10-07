Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72942D8DC4
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845467; cv=none; b=n6LM/e73/iPvI7RKPVlwcCtDbiAIO0ifZ8Cn1lxEUt23lxcaPBq7dS7jCA1viKGc50pGzAeXQkVb0h1YAK7BnnypET1VWadBhYHyjL8RfrFlk191g5OkHKdHj7Kh2wzduDQX9EysAO9YIiWw+vRpiQl5jQXMOovhm6aVEo5R3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845467; c=relaxed/simple;
	bh=97whpkiNglAIBGWPl7LIkrqaHpoq6Kgvg2HABJh0tR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQFRPQFrRgU4RIuURLOozPhggMIMxcZY4eS4aAW48JMaNswEBdshghm/jchPdPvYqrMqWmgDAmLLxRoPeNAPz1CkjqtM6pxwkZGYNNisD+xlHdsPmHv0eMRpoB89HwkJSS690bQmKQfjNTddWbJHPAbXEIakjzG2sE/RLif00uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTAS1EjH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTAS1EjH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so5253790a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759845465; x=1760450265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hpTNiEmriNXdTHFezCzPoPvneIlAQWxMEHmCpql00Y=;
        b=fTAS1EjHTbpOsZ3aLLsjvmF8ygQQ8i3f7lk/pH+3SFKsXSQtFduU8oVIbebGPuF3UL
         HV6XjCoI6f+H0UsK4uFqSBAzDTFEduiqZnN+SkVPc3dAvVBJAXparCdjpx3HiGimvvRX
         CH9v+3G9yF60PNv+HNJSKyL1IK5N/1DYnI31RL/+LQmk0HWmsESJd0qaT0+1Sp29TfZ6
         Sk5UuM7OPE7xxxphvXn3YaPlWdmQgVaWk9mhh7/C9pEzZ7jwATRg9gVliyq0cNDO7Q1l
         PASp0dPl9tode3qlwWD1o1FbhapAaqfO15xNGGG+LIgJiArm7kiFl7h3qyIbAkFKegvD
         9sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845465; x=1760450265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hpTNiEmriNXdTHFezCzPoPvneIlAQWxMEHmCpql00Y=;
        b=IyyB90RO6T9ZoOjjny+t92cBLpTq9vlbZKYKPYOGtffmw8AKLjRX4onY8hqVptbmnl
         kOYF3qsW6h2EjxDgQ8tv2bYdMROhvFv5jYS8efK9nsi8HcZnZLz+e8/jR8qYnYvKijFB
         BqnfmCKZuuyeWSMYsw23KStOvWKEFIcfbwttPy1zU++LDS8Xs6h5+MNNLnaiYCRDCAsf
         JaIOkJvNhpZfdKLVbCHEtJ7uHEfrlsQk3eGzGLSudhGUUT9rArL1YvqByxzaDS/j9Aw6
         Fw2CC96OfzNF0482k19zerFbLAH7q9mZHoFueaWge/TSzc8MHCEyz+2HBGPCLlwrgSoX
         4LJQ==
X-Gm-Message-State: AOJu0Yz1xAz5hqWk+MIm8h+mTVw4hk7v559DKZX1jgOjJnXR8Wfwj+qt
	tzFO2Zhbb3bUr8GkeBAFVF1HKCEJYvruCdAsZoZ2Uoc7eMFs3qmH5b+9fF92R9v0h8u+I2FwerM
	rgx6NiSLBcm0NHAN85RQZlGn46glfu2w=
X-Gm-Gg: ASbGncu+hH1jNe+fqdPb3yrineiUadG6EfEgEMTVJwdYd3VyivhKRulQA9rE+MlAU1v
	v3mHumWeKnuEfL6ncdRmvOWLmW4iBCwPGa+kEtr4RoXWygXG7rfvJOjTHOlQzVLuvzF8hPtadgV
	Nuj2sCVCQkuQSYztaHmg6iBxxSygr355K+jN3gBi4le3Runvvm10/HaHr85sxhpkTPiNPmowsSW
	lzdjq6e1a46snFrJdhZ/yfPvscpaeQ=
X-Google-Smtp-Source: AGHT+IEUW3Bg/oavJ41h+AlBKapE/frEQj/PJ1V79jReSwgL4JkiZbg2uUaY4GMrLCRH0Uaa7FiXnqFgTj34fWgSorE=
X-Received: by 2002:a17:90b:180c:b0:32b:a2b9:b200 with SMTP id
 98e67ed59e1d1-339c2782ea1mr16969135a91.13.1759845465054; Tue, 07 Oct 2025
 06:57:45 -0700 (PDT)
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
In-Reply-To: <CAEjxPJ7ijHMzX8TwCxYvEH6ye2NP_Fw=cCfqXwph9Gfxr6oXQw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 09:57:33 -0400
X-Gm-Features: AS18NWCl-L1TNwSCgK_-GbqTj-NjjeHdq9Pl0qRqGAslihSf1zKNevw6QaOFmOE
Message-ID: <CAEjxPJ7uga6hHTbPVswoeUikOB2BJ-WdcMeK45miu1LyDhbgCA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 23, 2025 at 3:25=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > On 6/23/25 8:21 PM, James Carter wrote:
> > > On Mon, Jun 23, 2025 at 2:06=E2=80=AFPM James Carter <jwcart2@gmail.c=
om> wrote:
> > >>
> > >> On Mon, Jun 23, 2025 at 7:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.c=
om> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 6/23/25 12:56 PM, Christian G=C3=B6ttsche wrote:
> > >>>> Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
> > >>>>
> > >>>>> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy=
,
> > >>>>> since (typeattributeset <attribute> <attribute>) is valid in CIL.
> > >>>>>
> > >>>>> Fixes:
> > >>>>>     $ cat myattributetest.te
> > >>>>>     policy_module(attributetest, 1.0.0)
> > >>>>>
> > >>>>>     gen_require(`
> > >>>>>       attribute domain;
> > >>>>>     ')
> > >>>>>
> > >>>>>     attribute myattribute;
> > >>>>>
> > >>>>>     typeattribute myattribute domain;
> > >>>>>
> > >>>>>     $ make -f /usr/share/selinux/devel/Makefile attributetest.pp =
                                                                           =
                                                2 =E2=86=B5
> > >>>>>     Compiling targeted attributetest module
> > >>>>>     attributetest.te:9:ERROR 'unknown type myattribute' at token =
';' on line 3418:
> > >>>>>     typeattribute myattribute domain;
> > >>>>>
> > >>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > >>>>> ---
> > >>>>> After some simple tests with CIL policies, it seems that attribut=
e
> > >>>>> assignment works as expected. Is there a reason checkpolicy does =
not
> > >>>>> recognise it?
> > >>>> Did you test that all types associated with myattribute are the al=
so associated with domain?
> > >>>>
> > >>> Yes, also please see the more complex example below (mytype_t is pa=
rt of
> > >>> "a", "b" and "c" after being assigned to "c").
> > >>> As for the "domain" example:
> > >>>
> > >>> $ cat typeattribute.te
> > >>> policy_module(attributetest, 1.0.0)
> > >>>
> > >>> gen_require(`
> > >>>           attribute domain;
> > >>> ')
> > >>>
> > >>> attribute myattribute;
> > >>>
> > >>> typeattribute myattribute domain;
> > >>>
> > >>> type mytype_t;
> > >>>
> > >>> typeattribute mytype_t myattribute;
> > >>>
> > >>> $ make -f /usr/share/selinux/devel/Makefile attributetest.pp
> > >>> Compiling targeted attributetest module
> > >>> Creating targeted attributetest.pp policy package
> > >>> rm tmp/attributetest.mod.fc tmp/attributetest.mod
> > >>>
> > >>> $ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.ci=
l
> > >>> $ cat attributetest.cil
> > >>> (typeattribute myattribute)
> > >>> (typeattributeset myattribute (mytype_t ))
> > >>> (type mytype_t)
> > >>> (roletype object_r mytype_t)
> > >>> (roleattributeset cil_gen_require system_r)
> > >>> (typeattributeset cil_gen_require domain)
> > >>> (typeattributeset domain (myattribute ))
> > >>>
> > >>> $ semodule -i attributetest.pp
> > >>> $ seinfo -xa domain | grep mytype
> > >>>       mytype_t
> > >>>
> > >>> I also tested the functionality on a combination of multiple attrib=
utes
> > >>> from container module and all seems to work fine (at least as long =
as we
> > >>> can trust "seinfo" and "sesearch"). CIL is not even complaining abo=
ut a
> > >>> mixed assignements that result in some interface calls on attribute=
s
> > >>> (e.g. kernel_read_all_proc(container_t_domain) -> (typeattributeset
> > >>> can_dump_kernel (container_runtime_t container_t container_t_domain
> > >>> container_userns_t container_logreader_t container_logwriter_t
> > >>> container_kvm_t container_init_t container_engine_t container_devic=
e_t
> > >>> container_device_plugin_t container_device_plugin_init_t ))). In
> > >>> combination with "typeattribute mycontainer_t container_t_domain;" =
this
> > >>> also works as expected:
> > >>> $ seinfo -xa can_dump_kernel | grep mycontainer_t
> > >>>       mycontainer_t
> > >>>
> > >>> It is by no means a complete test. I was hoping someone here would =
be
> > >>> more familiar with attribute assignment and would let me know why i=
t's
> > >>> not allowed or that it is just an oversight.
> > >>>
> > >>
> > >> I don't think the kernel supports attributes being assigned to attri=
butes.
> > >> For CIL to support typeattributesets, it expands all attributes when
> > >> it evaluates the set.
> > >>
> > >> I think what is happening is that binary format unintentionally
> > >> handles attributes being assigned to attributes (even though that wa=
s
> > >> never intended) and since CIL is creating the final binary policy fo=
r
> > >> the kernel all the attributes in an attribute get expanded.
> > >> It might actually be possible to start allowing this, but I would wa=
nt
> > >> to test more to make sure.
> > >
> > > I just realized that the fatal flaw in this is that the kernel binary
> > > policy produced by checkpolicy will not work (if I am correct that th=
e
> > > kernel will not properly handle attributes having attributes and even
> > > if it does there could be severe performance issues).
> > > Jim
> > >
> >
> > Thank you for the analysis. Does that mean that I need to test that the
> > access is actually allowed? Is there some simple way to measure
> > performance (or are there other side effects I can watch for instead)?
> >
> > I just tried replacing all the rules assigned to container_t with
> > container_t_doman attribute
> > https://github.com/vmojzis/container-selinux/commit/3645ca555ed5b5aacbd=
64e300522cfc6e2fbc493
> > and a comparison of sesearch outputs matched between original
> > container_t and mycontainer_t that was assigned to the new attribute
> > (outputs attached). So even complex policy constructs seem to at least
> > transfer to CIL properly.
> >
> > Thank you.
> > Vit
>
> Sorry to join this thread late but I believe James is correct that
> this is NOT supported by the kernel and hence won't work if one
> compiles policy monolithically with checkpolicy as opposed to
> compiling it modularly (which ends up indirecting through CIL). Hence,
> we can't safely allow this in checkpolicy itself except for modular
> policy and even then only if we know that the libsepol on the end
> system where the module will be installed is going to handle it
> properly. If we were to alter the libsepol expand_module() logic to
> replicate whatever it is that CIL does for attribute expansion, then
> maybe we could allow this in checkpolicy too.

Also, I'd be willing to allow this in checkpolicy for modular policy
if we don't care about ensuring that it works on very old Linux
distributions that don't use CIL-based libsepol.
