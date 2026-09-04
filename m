Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1F44AB94
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523815; cv=pass; b=kkoEM0Iu6Le1RCqJcSyrE0g5saT810RPY6fTEHSC8h1TQp4MuPaRzpmydxVRw1lTd2wR5ovEutf6AYw3bBF68BE8tIJa8gq9ZqxRjBZ2XD7KGVbA6uD549r1dhoDRNMlmMASGf5ALjL5rB4gnocB41xNDy4AVyzStMC7RljYKIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523815; c=relaxed/simple;
	bh=cTM64w7Qtlbin9kRCOSATPXeC+Pl0z8Ypnz0v+kHGlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhpKJSUchd9nIiOChUilBsBUkH3L3kxs/TJk4HCb10p1WNAasIgX87pe8PKSBxVyiItU/AUt+EXiPqvMTbRu9/i+hFTp9AXYYMbxIqM8+q9gRcMLhRQsqM/qugYqZIZhGxfdpn5OlFw/qdT/b8IMy9HInJXN89/HuSrgyse5FgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sv6iaCBy; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv6iaCBy"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b381337e1fso852484b6e.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523813; cv=none;
        d=google.com; s=arc-20260327;
        b=LtO5VMO6PP1kpH8VugA93zrPZrzRw8jlM+w45Y9BEVKecabl+jloctfmEL/bBqNL2F
         hryNrbDslZIX+eYPdGsbi17Mf0JI88ayYvSTJtEIs61gfb1jI44S2jNf85Wui0riaE+a
         dM/oLpcblIQIk5Zm5UZQqH3793rvfKQQWuO8LAB7GpQ3wf1OuJJJkWgVZLkIwqWFsZsW
         2XIVoXRl2RW+3q6vFKOgfNRH7BohQIuL8OS9JkoipXVrhiUdUsmsnEG0xFnQAZAvbgfh
         xm6jUJJ3oFd1HUAkt6calDw5oSAXnGpY56IHLq5YEdTthl+8TUQAQ3MFGwlvIZ7ofsRg
         HNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTM64w7Qtlbin9kRCOSATPXeC+Pl0z8Ypnz0v+kHGlk=;
        fh=qoMQl8U2Kc6nKRRgrQ/IdcNfdWo6eKImTzJ+suCBmMA=;
        b=s/BrQ95EwkgA+OvbjBFG4avNAXXVbqrC0oXkkB13FBJscvhiPOBwzFH8ta1y7mjOTL
         Y3exmNI0RdjT1pMHt1HD+qHL60QcAe4rRR+mtctrC95ztH/q5YAAbITz3KsomJOJcl+M
         RBt8sah7OiGX0KTUJtHueYGvjs61fBlzzgdh4zKo9iFmM2qzsAT4oN1Yzn+4jlxboynM
         N07LWJy1l50sQlzg3Ad5+m40gaKbRokydGK0HjnOOUSgiaSS9vnrOf8jOBbWne4shlIp
         I857711TjiSYQ8ugpNkDPhcQQSDpqcSk8NZpPapukqUaNn5chY9TOultN3tFOlOmQRsH
         vLow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523813; x=1789128613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cTM64w7Qtlbin9kRCOSATPXeC+Pl0z8Ypnz0v+kHGlk=;
        b=sv6iaCByQfqis5+XagJFFwXsujlElUa9LITPYafJOTNOpSn2DOCSB+/h5GYEIFA+9+
         riLk9E7Ev4abeay+j6KqZ1ehRu+3HpODmVcXDctRZDC6M83Ib66BRrhwN+ivSF4KVFTa
         wNFTrIhxXVbcwLbzazV+gJMeSWFCrUN+pabEZ9i+mJPU19hrrcgVmogYOcNzLbhR9Njh
         X1LnIfE3ctfaXBuNUPnAV7X7xBPFvi8O6GapX44nVXmULOXSVXamL8OFL9Eu00g+daZ7
         1ycbTg10LzBLseXOTZJSNVmj1kL9PzEo+krAHp2xPXvHmjWzkKmXb2jmTNXoSLm1tjPD
         Lflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523813; x=1789128613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTM64w7Qtlbin9kRCOSATPXeC+Pl0z8Ypnz0v+kHGlk=;
        b=pH9x7dgTqTGhgeDnkG5B7speqCz7YIh9uvNSKr9sE4cH9lI34pbWtUwPP8Ntv6kuKk
         w0hpMVm4gWkQn0NXEhCaIn8WRPIepIis9oTVEeZpviAQegqD2LI41auH7CZgIz1YLmX+
         wYuyH/zpTonyaTkEL4tlIyOZv4vis5c4uw/gb/E4NoLn2pJT5H08sWupYgaGtbQR/zOz
         DvperILRHe5sNTJIy5itksSxc85svcViaNtDp9eWpa9kXcmcDXbQvlXuEdMg7LW6Cah0
         SlDODLYhZ5k+UDMM0nIk7PUeDnyVPbZIq23mFDc0fu0ZkOcYf023mLBD3J/gMa5M9CG3
         /4Hw==
X-Gm-Message-State: AFuF++kin5EdTuc+VrmkQ9ORiUm/MrRNhwXBqsmUe89fuX2vj+SKRlPA
	J0rlQiaKwW3qRSYw9dNOFbo6O3MhSm4a/r0NJw4bI6JMsQ/CbdJcUkfO+Lr9Y60NBVcc0dI01D2
	mCYHwnsPZrmI4gOGG115TpKpqLzgSRqg=
X-Gm-Gg: AYBFou2d1R9z9asIA06Uccbu21Sm/IRpxVtQExBWTlBCi2i8FuLXG7iJtX5yhb8/glt
	JF4XvHl8o6gO4/8KA2sK4qOJ9p6C9okncf3o2HQmvgvFdWZ8+mgttxIVFGO9U21+zKCz6/2ak7q
	D4ARsNVedcHrbBrbVysXRAKZ1g6/hrxwud+GSOEW+a+aUxOs2nFQlw+Onz/uUwoAWMJfHsQ+Tsx
	Y1CyR7oJr0qGQi6UbxPbsdfWi5aNYBOSk95+p5R/pCKEz5ejD8rMiILT+g6zkBpE6jAByGoqRH/
	ktRXpget3DpcRIYJk4Ry5XnkR2MqAJdqUU7E24UAOJ/o
X-Received: by 2002:a05:6808:1804:b0:4b5:5bfd:518f with SMTP id
 5614622812f47-4b964b3ac5fmr4345244b6e.21.1788523812602; Fri, 04 Sep 2026
 05:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <CAEjxPJ5Yy+GQCjpddDQTjCcCLB=9DCJ-Bf2Wv9n26=vgwP84qA@mail.gmail.com> <CAJ2a_DcCfeeEf4BBY5SEEHyMo2QwaQ2KtTuwAGGxnPWg_0CXJA@mail.gmail.com>
In-Reply-To: <CAJ2a_DcCfeeEf4BBY5SEEHyMo2QwaQ2KtTuwAGGxnPWg_0CXJA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:10:01 -0400
X-Gm-Features: AcwNN1UiMEKdIO0CjrqDjUA-KYRdvYKyHrShonRU1FRlMiom8DXZ4FYpoz6xHcc
Message-ID: <CAEjxPJ683+ooDDih=9QbgeKbGYHaynDOsbAjgjtK2FTMDbtJ1g@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: bounds-check filename transition source
 types at load
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 3 Sept 2026 at 15:47, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > filename_trans_read_helper() validates the target type, target class =
and
> > > each datum's otype, but the per-datum stypes ebitmap is read without =
any
> > > bound on its set bits.
> > > Reject a stypes bitmap whose highest set bit is not a defined type.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Technically this will reject a policy with an empty stypes bitmap and
> > no types (p->p_types.nprim =3D=3D 0) but that's fine since no real poli=
cy
> > should do that.
>
> Since a valid policy needs at least one entry in the global avtab,
> isn't at least one type already required?

Yes, that seems perfectly reasonable to me.

>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
