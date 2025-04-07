Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844A2222A0
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052324; cv=none; b=aG2MGG92RXYIawh3frdrvQOm352QmKUX3GFg8NEU4BM/3oP21oGO0R7e4Cj4YVs4bSBSM7Phn5YD7Z/0AOY6Z04Jj2joZ10u1+8xF5keBvA9pILEVppIus/wEPAjhbve7Eex3pVe+F+pe5ZNhxF7ZaT/qC4+IxFTGBtllLbDR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052324; c=relaxed/simple;
	bh=IuBCuL7bynuErAdcgX8SK137FqVrjtCeDVpoRAda9dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMSGhJpR16IvGqTCrQO+sYrWakHZo62o29+yoHlnyXBrScgED9wchp9eIdkXFxTg4Cyvt7Cvsrf+x8yJSVI6VqQKPuNHNAXS805APtDieONbKpSgG3F46LLdRdWuCsGhl6dc6Ba6eBhrEgucLHJlO7ZmUVcf/IDKSgtzFTr6Bdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8cWHHUf; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8cWHHUf"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d377306ddso2031587241.2
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052321; x=1744657121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbub8CVmJl9hQ/bwrPsnsDjWyxHwiD8QQach31qP/3M=;
        b=Q8cWHHUfRhF8og7NvqHNbwQWAxQusH1XJTXrKQrPXVlXf0ptedp0CnBoK5T1chcfeL
         z6vaRM7oArURE/HIMwPAKgrToZLyMoJEMACIu4cZqYBt12krgMyiPrNj77RTfHBirJjN
         eEtmXKl0ttMC4ZKN/0erzV/MQhydHriXCUv/T6jT/sUwpxSQr2cOuDHOVkBbzDHNb3Ye
         PhGpdXLvbXe+1BZnPbbZv5ysel2m0it12TpMu9hNl0ZdhH6hlR4F2+OIXxvBeEf92c/v
         zCtrU55jXSzvdCKMxG+bwWGheU8/1+k616zu7Zd5AzcU/G3NqGqun7INXxnQ0nEChBXs
         h/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052321; x=1744657121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbub8CVmJl9hQ/bwrPsnsDjWyxHwiD8QQach31qP/3M=;
        b=AgxCliAEmjmd4BMaOLRPbGPplJbabIAmTfZRWR3ldY5+sXq9LaB1bcCKyDASU/bDSA
         0qqJeUwMeOlgAiuyB7XOmXB17xY960//RBxyOlcywTjVI0u4ARGs8x0Da9X0E9FhYlwb
         k+OBtZi/E1Lz7PDQhx31RftvN6hyrLhXpMBOYVsZsYOwztDk9WU0oNvQX6TNOpLTJMP+
         5u+Ozcvq7ek32jug1cANLOS3idseqo1UjBbheXN4dQLBmx7/1Uca1ncGTjARwgzHuoLb
         CiBJz2WWgbYRk2o3hF1csiugrc3FqarMc5Pkx1u4cX8K5cZxvIGXJJygAd1miYAKgpVr
         6HlQ==
X-Gm-Message-State: AOJu0Ywvi2i1X+uaXGg1IiOR07tUo8mxvUyH6LJc23RWj6QZII9ABVHq
	OPAQXnfbqJ5YgQVECgz5ksQF7vafTBlUdNVL2PopnmxgVSE62GH66kXd9Dt4J57mnWWbVWjraTJ
	0lg3Ipj/kBnKoVgOT0flaOwylQwc=
X-Gm-Gg: ASbGnct4WqYNCjaSFyikLQ1SMtrm8l9fCZy6aXSLE71n/TnB/Ej1fiYAIa82EiwY6n0
	31lcVGdiMeTUqAnq7Eseq+P7MbfenNKSp9Fxw+quhIHhzNcJ0ZzxyYW54ajX+IbBiDkM/Ip83Zr
	q4XYV/5P0K5ROvZxM5qjIU+AA=
X-Google-Smtp-Source: AGHT+IESrG/7CNGQDngaAtaXYtrP/4Dj8T86JJLyLiXEbJecvoQy30Si9xzpI6JkR1IpY7wmwvfP7HPldvVHlvKMJ2s=
X-Received: by 2002:a05:6102:5786:b0:4bb:c9bd:8dc5 with SMTP id
 ada2fe7eead31-4c86362d0a9mr7823020137.3.1744052320832; Mon, 07 Apr 2025
 11:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116105427.22307-1-cgoettsche@seltendoof.de> <CAP+JOzTkkjuvYF3e4Y+Gk19=vcRi7xeX4szKnA3HRnproFsRew@mail.gmail.com>
In-Reply-To: <CAP+JOzTkkjuvYF3e4Y+Gk19=vcRi7xeX4szKnA3HRnproFsRew@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:58:30 -0400
X-Gm-Features: ATxdqUEydpd7e3lYoRlkPjdYY-pfeqI050TiKZaauS5aqJeqjzeASnNbOemmxjE
Message-ID: <CAP+JOzRnFzZXowCqEquJHXu9OTOHSCvXc4NXi4aQpLa3DfBx0w@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: limit node depth while parsing compiled fcontexts
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, Jan 16, 2025 at 5:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Limit the node depth while parsing a pre-compiled fcontext definition t=
o
> > avoid unlimited recursions causing stack overflows.
> >
> > Use a sufficiently high value of 32, instead of the node depth of
> > currently 3 for generating a database, to not unnecessarily limit
> > custom changes.
> >
> > Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> > Reported-by: oss-fuzz (issues 388615595 and 388592303)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Missed this one earlier. It is now merged.
Thanks,
Jim

> > ---
> > v2: add code comment
> > ---
> >  libselinux/src/label_file.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 56e20949..507ce0d3 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -674,12 +674,22 @@ static int load_mmap_regex_spec(struct mmap_area =
*mmap_area, bool validating, bo
> >  }
> >
> >  static int load_mmap_spec_node(struct mmap_area *mmap_area, const char=
 *path, bool validating, bool do_load_precompregex,
> > -                              struct spec_node *node, bool is_root, ui=
nt8_t inputno, const struct context_array *ctx_array)
> > +                              struct spec_node *node, const unsigned d=
epth, uint8_t inputno, const struct context_array *ctx_array)
> >  {
> >         uint32_t data_u32, lspec_num, rspec_num, children_num;
> >         uint16_t data_u16, stem_len;
> > +       const bool is_root =3D (depth =3D=3D 0);
> >         int rc;
> >
> > +       /*
> > +        * Guard against deep recursion by malicious pre-compiled fcont=
ext
> > +        * definitions. The limit of 32 is chosen intuitively and shoul=
d
> > +        * suffice for any real world scenario. See the macro
> > +        * SPEC_NODE_MAX_DEPTH for the current value used for tree buil=
ding.
> > +        */
> > +       if (depth >=3D 32)
> > +               return -1;
> > +
> >         node->from_mmap =3D true;
> >
> >
> > @@ -794,7 +804,7 @@ static int load_mmap_spec_node(struct mmap_area *mm=
ap_area, const char *path, bo
> >                 node->children_alloc =3D children_num;
> >
> >                 for (uint32_t i =3D 0; i < children_num; i++) {
> > -                       rc =3D load_mmap_spec_node(mmap_area, path, val=
idating, do_load_precompregex, &node->children[i], false, inputno, ctx_arra=
y);
> > +                       rc =3D load_mmap_spec_node(mmap_area, path, val=
idating, do_load_precompregex, &node->children[i], depth + 1, inputno, ctx_=
array);
> >                         if (rc)
> >                                 return -1;
> >
> > @@ -969,7 +979,7 @@ end_arch_check:
> >
> >         rc =3D load_mmap_spec_node(mmap_area, path, rec->validating,
> >                                  reg_version_matches && reg_arch_matche=
s,
> > -                                root, true,
> > +                                root, 0,
> >                                  inputno,
> >                                  &ctx_array);
> >         if (rc)
> > --
> > 2.47.1
> >
> >
