Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229D190472
	for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462276; cv=none; b=HeRSXlTWG09fst/4TXvQVJODoNvjQMKQ9Nipnp2GJ2/lgG2TxSBpDfWDY/2mzWrmZ58Wqp49GPU5GEz0az1ILrwaqo+0bzdsdqYfx8bJ8OgUE7o6b5YyHsn0UK2XESoQmH9Kmjav2MUxbE0dDT6xsAGNhRjZyZR5CQr6ZKMnCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462276; c=relaxed/simple;
	bh=sUq90Sh6cl0YhbPvlnrOqL37+dCf0oAyETbneVq/h1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA3nnOCtfAviUedygaGE0PyNrI4pRbFiE+wWjv/1gLJP19jONica+DUefTsNNDHKulyse1V4Ob724rmXl6oWcFZAS2+ZtTvLiGkBAdA0VBRVuu8NoY96s43RY8UtUp86iHNGhHiOZ9JTaYaL1ZiXAZ6inOO7pvIvGkn+07feahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z2Z6akvx; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z2Z6akvx"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso1672093276.2
        for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753462272; x=1754067072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+TS3X9vskWtrzO1Cy8NLFMGD99SvsurX0COyWC4lWI=;
        b=Z2Z6akvxCs7zsjjGqlwApNHOOVFDG3Z/Wk/9THwVETAk65VYon/mc8Ymll+1shwiO1
         AgQ9Ik4kt3E90I/31RVw9RybXw1ZzQqH6V3Xvpb960WloAfoE12sc8UERkQ7xN734qyS
         k1fNV6Q/jgS8qb3ZjGTbmzWDZoigdeKUI3C3s+OPsvDd3xCEUqVuGHP2Ywva+pv5vsjf
         DTE5b0fexS5iOSkmL/uCW/mHrlKZuD0fdCI0dF5OPIgvw7Ibjiw/LJSPIwzSUO7lThfk
         NWqtu4nkyc8vChpn+PIkMRb6T12bgyWJNK40Jn3kTv+MAgBvgB/PJHS/9oQpuG/W7sed
         14QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462272; x=1754067072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+TS3X9vskWtrzO1Cy8NLFMGD99SvsurX0COyWC4lWI=;
        b=BinQmwhCB76Mw4/ndGXPHBJqYME2khBujDIPiF+ROWLOWb82spIyDXXz4nLwFIwfw/
         XqAl1vadb6Jhgd8KhPZ3o21n765KUX6xyEhNln+/KWEFYqXbbB5xXU7V+EqcBQ3uMj5W
         R9egfkiG0FSwPZ/4pJpJlZaddpSCjHGNeENpgwO0Ods4fGQLFy44n8hKC09gLnN91KO+
         0bFpNHo2wiWav10mk0f8aeYv4C9WvILpMEdJEufwhoHj4oCqZ07i8S9YHMS1iND+adJm
         gydaSYL3VSgW6oKVKh3mXZ3Wq5hGT0Y0khdbLuQ3xLSubP1mfG9bQLBBYgBr1y7QDNaE
         nYOg==
X-Forwarded-Encrypted: i=1; AJvYcCVe9UpiXQtGvRPR7hqKcbfNvlkvenSKRsx1voTkbda8XeItGXvcP2UPgFtfQG8JGda7MARYWcxV@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDnui/ZqLdX9Y8F11uWr1WP/57x5W210N3finWEPZqrhxNhbh
	Yz2gYmLq3uoYedpqFVfIR9eKXMSg6i+qSIcsbVHWeP9OWHtmtDeBGDHzU8c4C9yr16/62y4UPuD
	AnnTEsuy96PKEFtURN2qNS30wUuVe/BgxbH9IzvyJ
X-Gm-Gg: ASbGncuWQZPI9GbKJ+tA/UBkK6L+5u7KytpYjs+88qgAdG3rUwyFFKFZAK6Ka3YHkKl
	V2FBp+pPoh+V5cqoB9Zib7MjixD2Qvn8tqIAvhGcUGSuHaGIsyqrp1uv/MxzfYEjcVOqYH9aFF+
	hwu8aTvCG1Wxqfq8Er+4//lxLpw9HvdmJl8ReeVtxdAQO0peEVwQo9y0UvuEsng8yf19gMsFDbU
	bsCOqQ=
X-Google-Smtp-Source: AGHT+IHIMUcpn26HcyO0g3+tumAw+yRrAoF1TB10X+w5SEyTELp5aINmD8gCkp03hjGDmEB3Xc56OmNEC7+ABlOi7z8=
X-Received: by 2002:a05:6902:c0f:b0:e8b:d37b:86fa with SMTP id
 3f1490d57ef6-e8df121068emr2599450276.37.1753462272003; Fri, 25 Jul 2025
 09:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-66-paul@paul-moore.com>
 <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com>
In-Reply-To: <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Jul 2025 12:51:00 -0400
X-Gm-Features: Ac12FXyb2UHoFwiiWMxd4QzB2ubVseAs_bHPNy40Qx4LAoNpddjuNEjTQFYhh_o
Message-ID: <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:12=E2=80=AFAM Xiu Jianfeng
<xiujianfeng@huaweicloud.com> wrote:
> On 2025/7/22 7:21, Paul Moore wrote:
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thank you for reviewing this patch.  As you are a Lockdown maintainer,
can I change your reviewed-by into an acked-by tag?

> > ---
> >  security/lockdown/lockdown.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.=
c
> > index 4813f168ff93..8d46886d2cca 100644
> > --- a/security/lockdown/lockdown.c
> > +++ b/security/lockdown/lockdown.c
> > @@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
> >       return PTR_ERR_OR_ZERO(dentry);
> >  }
> >
> > -core_initcall(lockdown_secfs_init);
> > -
> >  #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
> >  DEFINE_EARLY_LSM(lockdown) =3D {
> >  #else
> > @@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) =3D {
> >  #endif
> >       .id =3D &lockdown_lsmid,
> >       .init =3D lockdown_lsm_init,
> > +     .initcall_core =3D lockdown_secfs_init,
> >  };

--=20
paul-moore.com
