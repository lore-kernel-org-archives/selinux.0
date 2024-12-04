Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9701F759E
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322725; cv=none; b=QQpYA3rxK1tc9C0vvlnvGLipj/FEJCaP21A1zWUYeXLDyyZ/M3EJzNahToEOblNzXCF982Fb7VrK7S8hooP0VigC0RvJK7q0dZJgwtzUIvBEQm3IfwyKcZYnUTX9JZc8XV1T/zNs08Af+9K0tjC3gHZarkd2Qp4yTZksmcWV56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322725; c=relaxed/simple;
	bh=RazehgSIMBn/VmkOVQQcyoWWPbXjEw6uxqJtWqQ1F+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIQ2gKym+0TEuG2nw0k/j0/owuFUkW8bz3hX+8fT3i5WaUhdrgYKc+EKDCuj9f8DS9b2/rvMzUqiQOimwZUYwc13p3uKnKL85wmDYW0tpYY7IDQ6PwbTRtmf7Q7hVwK865DgUuoWfq7wJq4iYIgHu5XAvVed6Xpx4j87kbwDcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfqM0FH/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfqM0FH/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71d41932d32so3003416a34.0
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322722; x=1733927522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l88jlo59Uw7n1dsi2SL5pTb36hmW2JJUI3RX+gQRqyE=;
        b=DfqM0FH/NAt5w47DHgUiqtQApu0FR8cuorgpEMklkS6PDVgOIbMFNQpbHos5iR0VBW
         FCsgAh3JhLLXZ74XalU51AjjrJDMWwLihtF7YOv/v+1Nre8z8iHKrHTb0k85Xv5wUzLV
         SsXeS0cX4uq8+dtBJ3j6CLoGLrsZ6GSw6QpoKTHCdPXK3f6mS/NSo/Ythh7zpXgUDzEh
         pBLBKvc05nd+qA/qGUV8agGksclzumiQHSeyAanQkXJ8qrkcNIMYsiHG7sXe+sOe2g+o
         jFRkkECiCc8DbsoHDAW2kFGL17hGMHNxmUvYc/mx1CsBPXlSWMf19FCQaH6FiCrX5zhg
         BfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322722; x=1733927522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l88jlo59Uw7n1dsi2SL5pTb36hmW2JJUI3RX+gQRqyE=;
        b=hBIGnsW+s4/HwREF4t/qhdVpRkTEO7bCccEQ1twoScjI+QIvei2P0I6E/A2T09mJpu
         mB+/LD+ekrz7ScSIORxPmaW5wGGSMUjlgP4JKkymbi61IpUvrlBg1duWKqe0+kCJNj7e
         Ry5xCwP2pYJ/dU97sJxk+9pEXPumPpQZMONDRNCuFTwRZnipU/a50ilNfn6wcYmuGocT
         +GMGJFo+tid5JbPySB8emkv/cpomta4mh72hPctbxTx+QGYKhK5b8vVzZWA4flRtMQJ0
         rOLmzbFcR34NxDT2MdR/I5UPkejTSvSTmUbsRw7izLvHkRJXrXd7pRfkRCFLi+Bg/3BR
         g/6A==
X-Gm-Message-State: AOJu0YyuasRrlAAKLM4ejv52QIyyv9JhZUXlT/gdj7IK+gTHR5O0EXR2
	NDyGKzd9gVfCu7iiW5VY+gJXOKp7OQAP7+zxo6mE3V5YljKJUTVQPryvP0V2TYjfFXLspJeV+OX
	Fg7VGcM9f+QsVuOJnesoLLUje5f4=
X-Gm-Gg: ASbGnct3G0n++vqlyIiWRmpSEFa1I4nVPETBEUJPcMlPn5Ly06aLh5vik3W7ixLikak
	NoGGfzerCBXIQr5Q3QXiu4d9oS0VOo1M=
X-Google-Smtp-Source: AGHT+IEHdvZ1wo3KzpGx6+ipe0P6kZnuhhC8rUZa8QNJdgShvCygrLksGY6w0M7XRJa24dulcx4RihksPmC8gtCHhcE=
X-Received: by 2002:a05:6359:5f8b:b0:1c6:9280:c6f with SMTP id
 e5c5f4694b2df-1caea7903camr589717355d.0.1733322722545; Wed, 04 Dec 2024
 06:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202110413.27032-1-cgoettsche@seltendoof.de> <CAP+JOzR0amsXLeL8oJ=daj_DK3Q0E4poMbD0Cumm5X8dzw2M+g@mail.gmail.com>
In-Reply-To: <CAP+JOzR0amsXLeL8oJ=daj_DK3Q0E4poMbD0Cumm5X8dzw2M+g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:31:52 -0500
Message-ID: <CAP+JOzTQU4i7gGs0KdNTEC6yQOpc3FsfTmKZpOLCcqb0m24VXA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: drop host bits in IPv6 CIDR address
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:53=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Dec 2, 2024 at 6:27=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Drop the host bits in the IPV6 address defined via a CIDR notation in
> > define_ipv6_cidr_node_context(), similar to
> > define_ipv4_cidr_node_context().  Otherwise the kernel will never match
> > this entry since the host bits from the actual address will be zeroed
> > before comparison, see
> > security/selinux/ss/services.c:match_ipv6_addrmask().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > Note the traditional address+mask syntax does not drop the host bits as
> > well, so they are also dead entries, but I refrained from changing
> > this legacy behavior (the CIDR support is new) and checkpolicy nowadays
> > also warns about host bits set (and fails with the option `-E`).
> > ---
> >  checkpolicy/policy_define.c                        | 9 +++++++++
> >  checkpolicy/tests/policy_allonce.conf              | 5 ++++-
> >  checkpolicy/tests/policy_allonce.expected.conf     | 3 +++
> >  checkpolicy/tests/policy_allonce.expected_opt.conf | 3 +++
> >  4 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 4b0eca6b..2f811b67 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -5709,6 +5709,14 @@ static void ipv6_cidr_bits_to_mask(unsigned long=
 cidr_bits, struct in6_addr *mas
> >         }
> >  }
> >
> > +static void ipv6_apply_mask(struct in6_addr *restrict addr, const stru=
ct in6_addr *restrict mask)
> > +{
> > +       unsigned i;
> > +
> > +       for (i =3D 0; i < 4; i++)
> > +               addr->s6_addr32[i] &=3D mask->s6_addr32[i];
> > +}
> > +
> >  static int insert_ipv6_node(ocontext_t *newc)
> >  {
> >         ocontext_t *c, *l;
> > @@ -5884,6 +5892,7 @@ int define_ipv6_cidr_node_context(void)
> >                 return -1;
> >         }
> >
> > +       ipv6_apply_mask(&addr, &mask);
> >         memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
> >         memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
> >
> > diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/=
policy_allonce.conf
> > index 51a8c40a..95a0f265 100644
> > --- a/checkpolicy/tests/policy_allonce.conf
> > +++ b/checkpolicy/tests/policy_allonce.conf
> > @@ -76,9 +76,12 @@ portcon tcp 80 USER1:ROLE1:TYPE1
> >  portcon udp 100-200 USER1:ROLE1:TYPE1
> >  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> > -nodecon 127.0.0.0/24 USER1:ROLE1:TYPE1
> > +nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
> > +nodecon 127.0.0.1/24 USER1:ROLE1:TYPE1
> > +nodecon 192.168.41.0/16 USER1:ROLE1:TYPE1
> >  nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1
> >  nodecon ff80::/16 USER1:ROLE1:TYPE1
> > +nodecon ff00::1/8 USER1:ROLE1:TYPE1
> >  # hex numbers will be turned in decimal ones
> >  ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
> >  ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpoli=
cy/tests/policy_allonce.expected.conf
> > index 355d9991..79d62319 100644
> > --- a/checkpolicy/tests/policy_allonce.expected.conf
> > +++ b/checkpolicy/tests/policy_allonce.expected.conf
> > @@ -82,8 +82,11 @@ portcon udp 100-200 USER1:ROLE1:TYPE1
> >  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
> > +nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> > +nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
> >  nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1
> >  nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
> > +nodecon ff00:: ff00:: USER1:ROLE1:TYPE1
> >  ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
> >  ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
> >  ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/check=
policy/tests/policy_allonce.expected_opt.conf
> > index 74eec4ba..fa4e319b 100644
> > --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> > +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> > @@ -82,8 +82,11 @@ portcon udp 100-200 USER1:ROLE1:TYPE1
> >  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
> > +nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> > +nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
> >  nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1
> >  nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
> > +nodecon ff00:: ff00:: USER1:ROLE1:TYPE1
> >  ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
> >  ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
> >  ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> > --
> > 2.45.2
> >
> >
