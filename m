Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402525DAEC
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707214; cv=none; b=jPhYUH4+nQV4Ly76zjEytYaBJocDvo5LiAxUWzLr/9etPdTdvSTsX9y+SsWxYFCPrjSRPKecm3/Oxy9Qp8buZeI0I9Of1ZsKMcO8pSXy/UD149N7cZfOe0NlvpqxTVbWiI4l7GrFQ2TXMO51/RERhRhTd8ECalywaytoZmW96Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707214; c=relaxed/simple;
	bh=xVHThv0Gj7+LCFB31w608IEj6QhWvXOaYyUAZKeBtX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDRMwpPl9zAUAmjTUyvp/BEecSKfiE/W0SegmGTSZnTaNGW9tfrDWiW6o7Nd/B22EW1P/AklxopTLEmwNCCPQi84zqRs0YfEKwt8ApzmnPogpfqNr2y+UsmsuaRCnnSl/tzlxNf6LfULeR4ocVRWVMN6twaH7+DxGHLmwNL6Z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpVAUcKH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpVAUcKH"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c04df48a5bso499673085a.2
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741707211; x=1742312011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FEBoEOSqA6a0xbqDn4WPn/5/Cz1uMoP7ZSe5NuptXw=;
        b=hpVAUcKHGAFmvEPSyiKkM9KxXRNLd8AnNWJfzcmmW6kf1iKzuWAXhESXg8I4OD8d4g
         SqWjcjaCZ76FuRkPbH16FS+CUmABpt4lwy5B5C9SLmChiOz5ZJyNkxlJhMsfAWuDjhgX
         S+bU0y5oVnuywu1MMbQxSQkkoHV0uNtcld3aMDCtk3aV7Zv+DcqzGXJLlV+0qHtPo5n6
         KvnK7hcRoEns2V19AvJjIJzHVLpVGaxszHLyzmxpNr1L4/Lp6S8SNJznAx5yItSIGG2I
         iDxKAUAi7KruGnRN3Mvc7Lwc6v7Jh1riYAcGNMWkDDPaaTdvGnqj/1s3q4tflzRc0MBp
         ZV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707211; x=1742312011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FEBoEOSqA6a0xbqDn4WPn/5/Cz1uMoP7ZSe5NuptXw=;
        b=v9aSnC1ZLA0zinT8XbJRNFAieNtKVr7JihGrOr0VRELj+t7PD2kUc6f/NmRHPqLe1H
         WcMXyl+U9cdoYajzsgNdIQCRgXzC72Nkc2qXobFKZqF5fngUcxt9BAxtSMR0M39otWdK
         9/zyPjPLQiMRqj65AoATtcwYnC0f00s+WaunAv9imSRvfMP19FbHxXTSRS25krJC//W2
         4m0kwoFEx5miwNcFwrnmNu8aVxwqeaWuNiWH8ixq1buFkL4nFCtLoB0iaAr0B0urlWl4
         BSFerYvvBEs/13H6wye5LbhtEnHYxsyH1Ifw9/IqLT/fS3oLEJe1MgAF1Tegp2OLNNTl
         JlCg==
X-Gm-Message-State: AOJu0YzEz/PMSFmFfExae8uQaPsnvt6mmBwAQfCAYM2TyGnd8C9Hdhvr
	Dq+5ieZr/lmElpupMTjru0BOZAfQbSt8zpio6LFPZzPjnhYLVjjH5sExpLvqK//pImLvNn0fiEc
	UioPNKGPAanLbh4RItlbW4An59w4=
X-Gm-Gg: ASbGncuO1IJ5wm3RMH4sbKGKLdG+cp902vNCkndYiLRExxgfgfANoX1CvZmDYOoDNxu
	71NIQlYlaWsXNvavmtyEiOXikDUfWJoy5zNzZSLEeXqmTGsJDzXDi4pKykgj5pXFncDeTY04FJS
	sb0a1iHzGBnWgsHJxEMxk6RMY=
X-Google-Smtp-Source: AGHT+IHql+5NRvjvR+CSdis+1ajGM27krodWg9TuyhIv4RsNT+G5yIhHAsi8T9jt9bkz//m7lI+9lu9QalinTyH2yeM=
X-Received: by 2002:a05:620a:269d:b0:7c5:55be:7bff with SMTP id
 af79cd13be357-7c555be7d12mr1179848885a.43.1741707211460; Tue, 11 Mar 2025
 08:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116105427.22307-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250116105427.22307-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 11 Mar 2025 11:33:20 -0400
X-Gm-Features: AQ5f1Jpq2WnO07m__wgbpC7hhakg5U7UpDiFlRMlo4TBXsNbxdAli-8mh4wLWmg
Message-ID: <CAP+JOzTkkjuvYF3e4Y+Gk19=vcRi7xeX4szKnA3HRnproFsRew@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: limit node depth while parsing compiled fcontexts
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Limit the node depth while parsing a pre-compiled fcontext definition to
> avoid unlimited recursions causing stack overflows.
>
> Use a sufficiently high value of 32, instead of the node depth of
> currently 3 for generating a database, to not unnecessarily limit
> custom changes.
>
> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> Reported-by: oss-fuzz (issues 388615595 and 388592303)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: add code comment
> ---
>  libselinux/src/label_file.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 56e20949..507ce0d3 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -674,12 +674,22 @@ static int load_mmap_regex_spec(struct mmap_area *m=
map_area, bool validating, bo
>  }
>
>  static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *=
path, bool validating, bool do_load_precompregex,
> -                              struct spec_node *node, bool is_root, uint=
8_t inputno, const struct context_array *ctx_array)
> +                              struct spec_node *node, const unsigned dep=
th, uint8_t inputno, const struct context_array *ctx_array)
>  {
>         uint32_t data_u32, lspec_num, rspec_num, children_num;
>         uint16_t data_u16, stem_len;
> +       const bool is_root =3D (depth =3D=3D 0);
>         int rc;
>
> +       /*
> +        * Guard against deep recursion by malicious pre-compiled fcontex=
t
> +        * definitions. The limit of 32 is chosen intuitively and should
> +        * suffice for any real world scenario. See the macro
> +        * SPEC_NODE_MAX_DEPTH for the current value used for tree buildi=
ng.
> +        */
> +       if (depth >=3D 32)
> +               return -1;
> +
>         node->from_mmap =3D true;
>
>
> @@ -794,7 +804,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>                 node->children_alloc =3D children_num;
>
>                 for (uint32_t i =3D 0; i < children_num; i++) {
> -                       rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating, do_load_precompregex, &node->children[i], false, inputno, ctx_array)=
;
> +                       rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating, do_load_precompregex, &node->children[i], depth + 1, inputno, ctx_ar=
ray);
>                         if (rc)
>                                 return -1;
>
> @@ -969,7 +979,7 @@ end_arch_check:
>
>         rc =3D load_mmap_spec_node(mmap_area, path, rec->validating,
>                                  reg_version_matches && reg_arch_matches,
> -                                root, true,
> +                                root, 0,
>                                  inputno,
>                                  &ctx_array);
>         if (rc)
> --
> 2.47.1
>
>
