Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7A3D3B8
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702033; cv=none; b=Tl+RxC9WHfT6aCTMfAoCcsnO5eBHGDTJwGmsNF8FUWMOTI0k7I+vGZ1GClF+FaXd6myiOBdFua8oEPyN9wrsQKg36f/SK039/IK/oS+m5W6nv2r7NZk2r2dC1f9ErYXqcnNEB7GcSagW90O27CYIfQX2ygC+PlsnzmpGNuvJFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702033; c=relaxed/simple;
	bh=X9YJLZ/Ifmi36qB4HO6h3CPLGYKdbsQswTcAnXjDq/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emxl58C06ydkqGXocPjy3g8RRNb+7tGvDtJlZCnZreOk/B4KRpKdirGtYxwZ5i4KIVBzl/WJfGykRqY/PKYfFwS8iXLtyXaMoSB5I9VFBGmZC5Ogujor9/JygewKhQvAzRqDhV3qcH5zKZhJd7W8gRPyrpYvuquyBwB4H6AYiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R432LAXh; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R432LAXh"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87ec9aee6dbso983052241.0
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750702030; x=1751306830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVQ7eVY9Hn3KHnbNl5mEHuARi7xK8zXUNTHvc6tEWTk=;
        b=R432LAXhDzDubduEhBKezE1yykmsoajqZCu6NAcbskKbB+pI+s/N1FGMPebL3O0b7R
         ljiB9jRq77DfWmseWPACnBf6AuNfK1/7ATMjrhQ5hJ7OZDsoJU/E5O2jg9o1pVNM1I+U
         JwtTM+pll/EXDU01PNmg9qqO5OkBhMM4/Y7yBadK9vJlCBsiHLxabNQa+H7AbKLfqkeY
         d8pikGfghkihI3x4Z0m5C1r15QLiIUHCBhrtK8xZj7VTHujTUjJDZfU4N88pXdC7gxNO
         8IskTSXAvvfDbeDRcDNkezHcSBOgvQmeIUg5oYXc2BwY/L9RnMtI4zK2uLDZJ4UiFthA
         BjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702030; x=1751306830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVQ7eVY9Hn3KHnbNl5mEHuARi7xK8zXUNTHvc6tEWTk=;
        b=SMLZ9nmSvNNx8zOAo562hGJdhL5Eau/1duRSkov1Q49tHcZ/yXeAfTkDs6RZaXa4ZL
         yeAauk0sH9IkvbbgFkk1zjkfdFqr9PTuNk8Nkx3pDIxo3fzoXlFK05lw51Xy9y4rupCc
         caT/BOJWsNwrTL0HAg1jW68u/g072fIIBovGuvcdQrwec+J8Fwe0e0UP9R825awhAkmP
         IHLenEtOyRVY/QmSKDoZCLwOWMQlubne7uaqC32+pQDbWfvmraFm13m+e+kV5O/38FPV
         03xXDBUJbcXDJk8amByjJ+z3/nXczr9gQOsocsaPI6/tDYh5UOCzmtFXkH26rmQMalmt
         9sTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXICftCMZmtMLjaKO95Q7PmrsVlATwbxKvOmMqC8aAuyLHjB/QY2dMe3PYX6cDFk5Q2D9SSMGWG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx896e3MMVTP5zTo6VIcUfgZcyxk7T4tMfS9mvnsffdGbYVoSHY
	yLPE9u76PIDOTV01w99SNO57LYaoohsiDoQNmQMu4n/dEYjNxooIJGFSxUs/a4ddYwV/W7W8OG6
	Q4NJj4hiMSZ9OYawzBUF6KE/C14lm8VPn8w==
X-Gm-Gg: ASbGncu4vM/Sl5nd0RM77ZLEYAaGfdH7iGvCvNxC/awBolKXeUiSFh9u/8GNugGqvR1
	RXGy3Bb3s+ziE5m+kIFJ9bDZoSv/rH5DAG6uU27dvxmjTu/rNRGFKFpGQ/qw+sSVWKbadUc0J8f
	cHOke5BFLULY7FCwMZDsQoUFR+WcbGl3wZ28Pbcwkh
X-Google-Smtp-Source: AGHT+IExaHFejiHeYnG5I5/vDk4tZx9JMadKgaxjpcJ2m+8T+G8ogyc41MYqisLihXst9NW6IMyH5QMJe1CYHIOLMX4=
X-Received: by 2002:a05:6102:dcc:b0:4e9:ad6a:cd06 with SMTP id
 ada2fe7eead31-4e9c299f3fdmr8609378137.13.1750702029548; Mon, 23 Jun 2025
 11:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623102726.3818713-1-vmojzis@redhat.com> <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
 <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com>
In-Reply-To: <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:06:58 -0400
X-Gm-Features: Ac12FXydMgzK0HCYSdRYM4AdxGzo05vhbJI_qzXZqnBqBMbfjKIcxvdjcDAxN10
Message-ID: <CAP+JOzQCoCY8AuY1njM1PyZk7gJZ5Ed_hc5ANXEcznwx9EAqQQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: Vit Mojzis <vmojzis@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 7:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
>
>
> On 6/23/25 12:56 PM, Christian G=C3=B6ttsche wrote:
> > Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
> >
> >> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
> >> since (typeattributeset <attribute> <attribute>) is valid in CIL.
> >>
> >> Fixes:
> >>    $ cat myattributetest.te
> >>    policy_module(attributetest, 1.0.0)
> >>
> >>    gen_require(`
> >>      attribute domain;
> >>    ')
> >>
> >>    attribute myattribute;
> >>
> >>    typeattribute myattribute domain;
> >>
> >>    $ make -f /usr/share/selinux/devel/Makefile attributetest.pp       =
                                                                           =
                                          2 =E2=86=B5
> >>    Compiling targeted attributetest module
> >>    attributetest.te:9:ERROR 'unknown type myattribute' at token ';' on=
 line 3418:
> >>    typeattribute myattribute domain;
> >>
> >> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >> ---
> >> After some simple tests with CIL policies, it seems that attribute
> >> assignment works as expected. Is there a reason checkpolicy does not
> >> recognise it?
> > Did you test that all types associated with myattribute are the also as=
sociated with domain?
> >
> Yes, also please see the more complex example below (mytype_t is part of
> "a", "b" and "c" after being assigned to "c").
> As for the "domain" example:
>
> $ cat typeattribute.te
> policy_module(attributetest, 1.0.0)
>
> gen_require(`
>          attribute domain;
> ')
>
> attribute myattribute;
>
> typeattribute myattribute domain;
>
> type mytype_t;
>
> typeattribute mytype_t myattribute;
>
> $ make -f /usr/share/selinux/devel/Makefile attributetest.pp
> Compiling targeted attributetest module
> Creating targeted attributetest.pp policy package
> rm tmp/attributetest.mod.fc tmp/attributetest.mod
>
> $ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.cil
> $ cat attributetest.cil
> (typeattribute myattribute)
> (typeattributeset myattribute (mytype_t ))
> (type mytype_t)
> (roletype object_r mytype_t)
> (roleattributeset cil_gen_require system_r)
> (typeattributeset cil_gen_require domain)
> (typeattributeset domain (myattribute ))
>
> $ semodule -i attributetest.pp
> $ seinfo -xa domain | grep mytype
>      mytype_t
>
> I also tested the functionality on a combination of multiple attributes
> from container module and all seems to work fine (at least as long as we
> can trust "seinfo" and "sesearch"). CIL is not even complaining about a
> mixed assignements that result in some interface calls on attributes
> (e.g. kernel_read_all_proc(container_t_domain) -> (typeattributeset
> can_dump_kernel (container_runtime_t container_t container_t_domain
> container_userns_t container_logreader_t container_logwriter_t
> container_kvm_t container_init_t container_engine_t container_device_t
> container_device_plugin_t container_device_plugin_init_t ))). In
> combination with "typeattribute mycontainer_t container_t_domain;" this
> also works as expected:
> $ seinfo -xa can_dump_kernel | grep mycontainer_t
>      mycontainer_t
>
> It is by no means a complete test. I was hoping someone here would be
> more familiar with attribute assignment and would let me know why it's
> not allowed or that it is just an oversight.
>

I don't think the kernel supports attributes being assigned to attributes.
For CIL to support typeattributesets, it expands all attributes when
it evaluates the set.

I think what is happening is that binary format unintentionally
handles attributes being assigned to attributes (even though that was
never intended) and since CIL is creating the final binary policy for
the kernel all the attributes in an attribute get expanded.
It might actually be possible to start allowing this, but I would want
to test more to make sure.

This is definitely an interesting finding!

Thanks,
Jim

> Vit
>
> >> $ cat a.cil
> >> (typeattribute a)
> >> (typeattribute b)
> >> (typeattribute c)
> >> (type mytype_t)
> >> (typeattributeset a b)
> >> (typeattributeset b c)
> >> (typeattributeset c mytype_t)
> >> (allow a user_home_t (dir (getattr open search)))
> >> (allow b tmp_t (dir (getattr open search)))
> >> (allow c etc_t (dir (getattr open search)))
> >>
> >> $semodule -i a.cil
> >>
> >> $sesearch -A -s mytype_t
> >> allow a user_home_t:dir { getattr open search };
> >> allow b tmp_t:dir { getattr open search };
> >> allow c etc_t:dir { getattr open search };
> >>
> >> $seinfo -xa a
> >>
> >> Type Attributes: 1
> >>     attribute a;
> >>      mytype_t
> >>
> >>
> >> checkpolicy/policy_define.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> >> index 4e0ddcc6..be788e8e 100644
> >> --- a/checkpolicy/policy_define.c
> >> +++ b/checkpolicy/policy_define.c
> >> @@ -1440,7 +1440,7 @@ int define_typeattribute(void)
> >>          return -1;
> >>      }
> >>      t =3D hashtab_search(policydbp->p_types.table, id);
> >> -   if (!t || t->flavor =3D=3D TYPE_ATTRIB) {
> >> +   if (!t) {
> >>          yyerror2("unknown type %s", id);
> >>          free(id);
> >>          return -1;
> >> --
> >> 2.49.0
>
>
