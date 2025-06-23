Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD91D61BB
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702877; cv=none; b=MejIq/mLqu8DBhIP6wKRhQGms6xG9kArbHicgIbXR56ewc064iz0/yBssQ8vt2B4BYAc+ic0rv1xbsK/510sWXzpT41hINMJSjyoEIWJPA7Eg9tjHEwhsHhCvQgWLSM5jpvVDzjYn8/C1KlMwNVkY0Zoqpq91XYLANVofmyMfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702877; c=relaxed/simple;
	bh=O57VipuWGQSKBdgoOJBuLMosgcuVkZ5FkzbJ8leRgJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av+6OExy5RPRT6vrA7tgAdbQ7BDnXrLu7bb7urf47Gk58gK9YewLqD19Nyu5GfofAtDw3FU6E+Mn4EsiuSANX17kHerHufiYzE2mPEwnxowqBe6rnBOLfRCwA8j3yN04eTva7YBRTnWKXmy1H2Huthgz8x30OD1esYSx68KXX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfVZgPCN; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfVZgPCN"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e9a7b4a412so3743369137.0
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750702875; x=1751307675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUZeD9+IlNlJumOQLLM07tAq48dYIGOO115L30EAeGA=;
        b=GfVZgPCND5geZBQ6J6Bx+QW5s96LU8ne6QMJq5tVOPs4d9vKPX2e0pnPN+YJ8SyUe2
         6VokvtL6auswFRZQa3GJ+7MMazn2aowU+nHjsr5TYU35PAxL6Z4cW27o7KFogfnUBfy/
         PyaqXuZPLw1vdP9qYfjXonH11PgV6gH9OlWqBZOKOYapOhckqL04U7lPnWxmzI95GCqo
         P9m8O+x5dzykWEOxZIt1DnBanL6U/NnTVc/ivXS6Z/QTpK0I4uzoXxw0eB/MOfIVHw7X
         dVVQSWrTa0xLOjfeLTNJQmVCQyHEMhcPMCeVIC01Qd77iM9wsw9z6yYUuiDCcY82NGrq
         gXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702875; x=1751307675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUZeD9+IlNlJumOQLLM07tAq48dYIGOO115L30EAeGA=;
        b=GdcpJYuPAwI1RnmYR8hLDeK1WPBTSV7lEnMR8s2kis1eg8YTWaisLElEIYDiRVieuR
         IXrJ6GyBfzfcvgUexrzklE+O6YwH2bxL+nEixRYtYMyYcDh4S4FmbXY3587Iy1NBzQ9s
         5AWUzibkN0cDkw5rrtjFFg4iyajCBVJTRJAp7DKLtmkvQqwMjFEShCTdiGdFbS33eLs7
         YnGGQgdoE/GbHJSDqSlZaLdY4ox+wKc/tJF6EfDVsNAWD/Ez6g9n/u81q7rKmjqqNzfr
         nkL116qyUDLOVma71KnpRakvZ7mShntq/VTQVMtghs2jEO/9P3oWoy2Sbmbi3rKledFo
         WX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV92KTFrxiEyPjywnl2v0gXBs37v4etIv2DCAXz66OZeMW8XJWiXoK7U60lexBtTope55VblSHg@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaU0w2lzQRB92FZ6ClwYFpKma84Gmm2bYN3MWRFgLpx7Pb/yv
	5AkfTyQn5eeawbevtJaULIMvOGpMADEEwrxI7g4r1h+Ms1EMniDldWT54GsNJhveIfs56PmLw4t
	jan+21ABGXXTr8JzvzvNQPRSoLnyiLbg=
X-Gm-Gg: ASbGncsFTQF3xXu9JCa3UsVcSu3T/0Q6lUesBgz91CgmfEuKWHaE6FyM+ah3FJWcvf6
	3B10u7MWz4mCdt7/hFIyL6OaBZ/nXRS0Y8kBHoeUikpjVZZO1anS/UzuMJSJtmVwrWEGLN/y4r5
	D+jsM30DGK1lqcCVRyaUxl3Z4pbmPZORONqN6EXBuoFtNST4+BSx8=
X-Google-Smtp-Source: AGHT+IFeduLZn5SipM4SYwUgKTH3wnrcPGnr8dSRK5sRpc6srYXv18RnZjDKCUtCNHy3rf3YPvkI4kEOY6UOOFeep30=
X-Received: by 2002:a05:6102:4b16:b0:4c1:9526:a636 with SMTP id
 ada2fe7eead31-4e9c2bc70dbmr8223110137.15.1750702874981; Mon, 23 Jun 2025
 11:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623102726.3818713-1-vmojzis@redhat.com> <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
 <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com> <CAP+JOzQCoCY8AuY1njM1PyZk7gJZ5Ed_hc5ANXEcznwx9EAqQQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQCoCY8AuY1njM1PyZk7gJZ5Ed_hc5ANXEcznwx9EAqQQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:21:04 -0400
X-Gm-Features: Ac12FXzPGL0eu9IMKkjPNxvwbWycy5cTdIcp1VlTTXBibU4psrz3VfP1tut3gtk
Message-ID: <CAP+JOzShgrLBiesobVHWPQ9gZUrWvt=x8OhZ3m8ngyG_Vs8gkw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: Vit Mojzis <vmojzis@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:06=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 23, 2025 at 7:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> >
> >
> > On 6/23/25 12:56 PM, Christian G=C3=B6ttsche wrote:
> > > Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
> > >
> > >> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
> > >> since (typeattributeset <attribute> <attribute>) is valid in CIL.
> > >>
> > >> Fixes:
> > >>    $ cat myattributetest.te
> > >>    policy_module(attributetest, 1.0.0)
> > >>
> > >>    gen_require(`
> > >>      attribute domain;
> > >>    ')
> > >>
> > >>    attribute myattribute;
> > >>
> > >>    typeattribute myattribute domain;
> > >>
> > >>    $ make -f /usr/share/selinux/devel/Makefile attributetest.pp     =
                                                                           =
                                            2 =E2=86=B5
> > >>    Compiling targeted attributetest module
> > >>    attributetest.te:9:ERROR 'unknown type myattribute' at token ';' =
on line 3418:
> > >>    typeattribute myattribute domain;
> > >>
> > >> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > >> ---
> > >> After some simple tests with CIL policies, it seems that attribute
> > >> assignment works as expected. Is there a reason checkpolicy does not
> > >> recognise it?
> > > Did you test that all types associated with myattribute are the also =
associated with domain?
> > >
> > Yes, also please see the more complex example below (mytype_t is part o=
f
> > "a", "b" and "c" after being assigned to "c").
> > As for the "domain" example:
> >
> > $ cat typeattribute.te
> > policy_module(attributetest, 1.0.0)
> >
> > gen_require(`
> >          attribute domain;
> > ')
> >
> > attribute myattribute;
> >
> > typeattribute myattribute domain;
> >
> > type mytype_t;
> >
> > typeattribute mytype_t myattribute;
> >
> > $ make -f /usr/share/selinux/devel/Makefile attributetest.pp
> > Compiling targeted attributetest module
> > Creating targeted attributetest.pp policy package
> > rm tmp/attributetest.mod.fc tmp/attributetest.mod
> >
> > $ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.cil
> > $ cat attributetest.cil
> > (typeattribute myattribute)
> > (typeattributeset myattribute (mytype_t ))
> > (type mytype_t)
> > (roletype object_r mytype_t)
> > (roleattributeset cil_gen_require system_r)
> > (typeattributeset cil_gen_require domain)
> > (typeattributeset domain (myattribute ))
> >
> > $ semodule -i attributetest.pp
> > $ seinfo -xa domain | grep mytype
> >      mytype_t
> >
> > I also tested the functionality on a combination of multiple attributes
> > from container module and all seems to work fine (at least as long as w=
e
> > can trust "seinfo" and "sesearch"). CIL is not even complaining about a
> > mixed assignements that result in some interface calls on attributes
> > (e.g. kernel_read_all_proc(container_t_domain) -> (typeattributeset
> > can_dump_kernel (container_runtime_t container_t container_t_domain
> > container_userns_t container_logreader_t container_logwriter_t
> > container_kvm_t container_init_t container_engine_t container_device_t
> > container_device_plugin_t container_device_plugin_init_t ))). In
> > combination with "typeattribute mycontainer_t container_t_domain;" this
> > also works as expected:
> > $ seinfo -xa can_dump_kernel | grep mycontainer_t
> >      mycontainer_t
> >
> > It is by no means a complete test. I was hoping someone here would be
> > more familiar with attribute assignment and would let me know why it's
> > not allowed or that it is just an oversight.
> >
>
> I don't think the kernel supports attributes being assigned to attributes=
.
> For CIL to support typeattributesets, it expands all attributes when
> it evaluates the set.
>
> I think what is happening is that binary format unintentionally
> handles attributes being assigned to attributes (even though that was
> never intended) and since CIL is creating the final binary policy for
> the kernel all the attributes in an attribute get expanded.
> It might actually be possible to start allowing this, but I would want
> to test more to make sure.

I just realized that the fatal flaw in this is that the kernel binary
policy produced by checkpolicy will not work (if I am correct that the
kernel will not properly handle attributes having attributes and even
if it does there could be severe performance issues).
Jim


>
> This is definitely an interesting finding!
>
> Thanks,
> Jim
>
> > Vit
> >
> > >> $ cat a.cil
> > >> (typeattribute a)
> > >> (typeattribute b)
> > >> (typeattribute c)
> > >> (type mytype_t)
> > >> (typeattributeset a b)
> > >> (typeattributeset b c)
> > >> (typeattributeset c mytype_t)
> > >> (allow a user_home_t (dir (getattr open search)))
> > >> (allow b tmp_t (dir (getattr open search)))
> > >> (allow c etc_t (dir (getattr open search)))
> > >>
> > >> $semodule -i a.cil
> > >>
> > >> $sesearch -A -s mytype_t
> > >> allow a user_home_t:dir { getattr open search };
> > >> allow b tmp_t:dir { getattr open search };
> > >> allow c etc_t:dir { getattr open search };
> > >>
> > >> $seinfo -xa a
> > >>
> > >> Type Attributes: 1
> > >>     attribute a;
> > >>      mytype_t
> > >>
> > >>
> > >> checkpolicy/policy_define.c | 2 +-
> > >> 1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define=
.c
> > >> index 4e0ddcc6..be788e8e 100644
> > >> --- a/checkpolicy/policy_define.c
> > >> +++ b/checkpolicy/policy_define.c
> > >> @@ -1440,7 +1440,7 @@ int define_typeattribute(void)
> > >>          return -1;
> > >>      }
> > >>      t =3D hashtab_search(policydbp->p_types.table, id);
> > >> -   if (!t || t->flavor =3D=3D TYPE_ATTRIB) {
> > >> +   if (!t) {
> > >>          yyerror2("unknown type %s", id);
> > >>          free(id);
> > >>          return -1;
> > >> --
> > >> 2.49.0
> >
> >
