Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33A1534E6
	for <selinux@vger.kernel.org>; Wed,  3 Apr 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167995; cv=none; b=EGjJKZOD2UNKmmVBQ7eSkYgGEz8Jx644XGUoVKZeA8H5f8yPf/6ZUjotlr2O64L9EmBn4hNcQFUGTYsBzX5DKCWNdhCV4qT5nZh3SPlyt6zPWBFrsjtpq751Qqa/IKHBcUyqXWgd6t3GrPNz/PsIQn03JDyP2eLx7Aetz8assgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167995; c=relaxed/simple;
	bh=f+8LjMdVO7K0WG90wq65VPqMPCFrsCw2mVe2YokVQig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qtva6avdk1mXASGbhVxmqxMFhyb/Z5s/IuilWWoo0j5WOucMo5D1LWu5J+aJbIDDzGLAcexUBxgqWREhcGv7Afe+j0a1i+DMR6PjJ3EXLrMjNq4FDIscO7XszeDFuNvKsKfgzYmVwyxHRt7g3oWddOUTxXGb0YlMGMzyFs7fdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GZeXZX6P; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GZeXZX6P"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6151e2d037dso1482067b3.3
        for <selinux@vger.kernel.org>; Wed, 03 Apr 2024 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712167992; x=1712772792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65HXhw9ivZVZNEzuuTHRqM+1g8PgZdkCA+dRhBXvkow=;
        b=GZeXZX6PVliB2LjBpMTDrbQ/hIhwpSZvAlj7a9a+9Sk1OBHmeFsMvuwqc4LNpgAxHK
         NfBjXFlYV9pmakd9Ln+XkUEuBrgacjyaHLiF9OPOWiOLzgwzIWRtLesk2pRSSLGdp96Y
         RKrMWGNmDJ2RrrWFM41EJeEUEUJO0Kl3l2BcU743bHSwIMfP9KIjBSd84NkmFEc6xlDS
         K+WOMX+oiJ5gGH4h3B7pZIEBbhIdWiRo2+8XxF9CNaQiLtT0piN7XSkqSWSaEekoC6f1
         y6BCMhJzc2nLTTbgMQz0pkI/jFhOe8VLL1DTIeyGLgQSCtqMK82f3Csecp0GbsE9rkSj
         Fplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167992; x=1712772792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65HXhw9ivZVZNEzuuTHRqM+1g8PgZdkCA+dRhBXvkow=;
        b=f02sKu2S7GOSaRRdvYOiOI6gb7CgOJS5DVaMs22URSgsNNKeFlty979qFoFmSlXUFH
         BHTXt6+uDkq97vTPaDuPNBaDpIapa4v/nttJ2Bd8Y73SxBgZzlKQz2b5upZElvFr09ku
         gB5OsKgELcT/92CfM9JIRSESgnQV/cAsZVBrzcVsApxWVsU9oN2psf8OfJO3EsQ/HrhB
         0/mhnAwflcUsKPqekyJ0+4G+YatOnaZxuuNGkxjBiO8Uf+fseLs9J2HBPFXntdTVmaRC
         F1gJdXnxSMKYZZcYFk9ke2UPHvl40xCGrN4xh7DgwJht8jVycsQYOeir9bwoy5/7j+mj
         +6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVbvPYswZcLIRvktfHuEbE80GrJsrm5/9SRvzf+KAwOli4fUy682VCeKaqKOQyBzWXHWrnAI+wJFhBi0HI8cDaC57xMTELW1g==
X-Gm-Message-State: AOJu0YxD8prWmOWCtT+EmuPahB6WIjQjVVnIO2vgGAX2qGH94VOmuvr4
	L+egES/d3dCPmBMqs5NBmfQ69eAOftLaCfsKR48sv0h4wznf+YICBzbmZvNq2hRo90acbfOHaoN
	Qq/GW9rzaX8HpV76qW9YTAqwJ7JX/07Wpb8L8
X-Google-Smtp-Source: AGHT+IH8D2SmnbXfUy0KSSf63DzBgDDzy/L75tMAMknjUzbWNz9GFRZUS/osB4yuEw9jA896naaKejUJfVdp897Oczs=
X-Received: by 2002:a0d:e2d0:0:b0:60a:2c16:da3f with SMTP id
 l199-20020a0de2d0000000b0060a2c16da3fmr182394ywe.28.1712167992082; Wed, 03
 Apr 2024 11:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <722b90c4-1f4b-42ff-a6c2-108ea262bd10@moroto.mountain>
In-Reply-To: <722b90c4-1f4b-42ff-a6c2-108ea262bd10@moroto.mountain>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Apr 2024 14:13:01 -0400
Message-ID: <CAHC9VhRU2OC2EWNAsiLKXAqH_QHYiD9Sytu1rPObcQmofCL+Gg@mail.gmail.com>
Subject: Re: [bug report] selinux: optimize storage of filename transitions
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: omosnace@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:38=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Hello Ondrej Mosnacek,
>
> Commit c3a276111ea2 ("selinux: optimize storage of filename
> transitions") from Feb 18, 2020 (linux-next), leads to the following
> Smatch static checker warning:
>
>         security/selinux/ss/policydb.c:1953 filename_trans_read_helper_co=
mpat()
>         warn: missing error code 'rc'
>
> security/selinux/ss/policydb.c
>     1916 static int filename_trans_read_helper_compat(struct policydb *p,=
 void *fp)
>     1917 {
>     1918         struct filename_trans_key key, *ft =3D NULL;
>     1919         struct filename_trans_datum *last, *datum =3D NULL;
>     1920         char *name =3D NULL;
>     1921         u32 len, stype, otype;
>     1922         __le32 buf[4];
>     1923         int rc;
>     1924
>     1925         /* length of the path component string */
>     1926         rc =3D next_entry(buf, fp, sizeof(u32));
>     1927         if (rc)
>     1928                 return rc;
>     1929         len =3D le32_to_cpu(buf[0]);
>     1930
>     1931         /* path component string */
>     1932         rc =3D str_read(&name, GFP_KERNEL, fp, len);
>     1933         if (rc)
>     1934                 return rc;
>     1935
>     1936         rc =3D next_entry(buf, fp, sizeof(u32) * 4);
>     1937         if (rc)
>     1938                 goto out;
>     1939
>     1940         stype =3D le32_to_cpu(buf[0]);
>     1941         key.ttype =3D le32_to_cpu(buf[1]);
>     1942         key.tclass =3D le32_to_cpu(buf[2]);
>     1943         key.name =3D name;
>     1944
>     1945         otype =3D le32_to_cpu(buf[3]);
>     1946
>     1947         last =3D NULL;
>     1948         datum =3D policydb_filenametr_search(p, &key);
>     1949         while (datum) {
>     1950                 if (unlikely(ebitmap_get_bit(&datum->stypes, sty=
pe - 1))) {
>     1951                         /* conflicting/duplicate rules are ignor=
ed */
>     1952                         datum =3D NULL;
> --> 1953                         goto out;
>
> It's not clear just from looking at this, if it should return zero or an
> error code.  The way to silence these warnings in smatch is to add a
> "rc =3D 0;" within 5 lines of the goto.  Or a comment would also help
> reviewers.

Thanks Dan,

Based on the comment and rest of the function I believe the right
choice is to set @rc to zero before the 'goto'.  However, let's give
Ondrej a chance to comment and submit a patch.

--=20
paul-moore.com
