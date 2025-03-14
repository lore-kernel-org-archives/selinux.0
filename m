Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DB2E3398;
	Fri, 14 Mar 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957295; cv=none; b=Psdpop6VmkcFGvNxpMYEnsUCf1yv9QhpKwdxXtEmM2WJ0BORPaCHCsgSWPDL11YBeSVbp51/UL2C5udNQbxDP7J2FEIVp2GqqTKKvnvYZ2daDUB5oo/W/LjWLSg3qTW+ohcierFBSrXKAk58nd8aCL+y2ot0CGxljgewieK92GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957295; c=relaxed/simple;
	bh=ZYbEiSTxUW9zcPYJMASdGlpPkwy8hihi63fLNM9eQuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgDE0aGXQdWBbCxtNlZEstbH+YedPdvAiR26tT4vRMEypD3TQOnXSeeQclliGT2HKK8rfiVo9zE6C366sUxAFjTxOHXoJzQwjvKnw701JNhi7jQgSGREp9TeXYqe+ug2G6B+b94HlAOQHChZgPwp0/s1g71d5CTpSik1O89lJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MvHdF6Hx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MvHdF6Hx"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff1e375a47so19224447b3.1;
        Fri, 14 Mar 2025 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741957293; x=1742562093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAPXe72XcrEEUjIrwHjhfqhq2Hdebc9JcP+v7OX7qPM=;
        b=MvHdF6HxPJEO4pD8uTnZeL2IxI+HlHssa4sqfH8onqPR2K8wiOX8RhQx7J+Ad2k60E
         eRcc05JnbN5G1CXvxcabicf2xo0dNVtCjTdkHex1BZZtsXiuugG7045HYjtNzj4K+Ofj
         wccuMI5Pi468ANOsob4XSjp7eaN1+n5LhmHxXRd05qqquvjHbaaTmFYmTtzfhO3Ih7CA
         8AZC29PBfIPaEh4MrKl4Qpt16oXmBHlW1n1n1sDnwJ1WmoQ3ImwvdWQDpH5LFAXiBNLw
         Ax20vaLkTkSc5q55wmRzD51h6oPTdDVsFA2qmzBymhZxW+9FJKmduRD6PJc2Ka14ztFl
         pl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741957293; x=1742562093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAPXe72XcrEEUjIrwHjhfqhq2Hdebc9JcP+v7OX7qPM=;
        b=IRx8IZCLPcQmkr5QQYTmvzN2nBp5GlEYPtIS5/9E/bTC5hq6eH5eSMdmJ/GspqQ9hr
         X6q9egB0uRRoEOnQimiWffL9NW9Dj0o+KK5gjdiJX7pY9WIBft/q8aDy+3ug/hoP6I75
         VLVhEIXZ5XCCo8sPDh4JtW6CJZ7X++tdGGJ1NmHrIpzJAVCZUT/pgIBlA7P7SDA9tlqn
         YO6GymvpYOp1F6VwTeetBZHXsVjwL4ivX8t79opIVjJufTd7tGZJnGO252dNV06ac1Rw
         Hw4kWtNKLf16hzEE63DGcXVoJfoid4VZpLiT4db5I5mwHkW8lVtw6Z18iMzNdEudWZOt
         8wxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUo2UQAKSO08//JuAQC4iYxhvlvqsH/YCj4pe5V029mgu9VX0jpF9O8wqWOYCRTI5mq+zhiA8zDfa82xk=@vger.kernel.org, AJvYcCUct3vLRDivOq+c4pvGLqqBS8gh3gbSLivWPA2HGcwrcUOGJEuh11fwPJMXpi2jzSMJeOqrZBLE2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFIqYhB/dNGmLdulyLnhPdrq7ejDXxWX/IuQDECJX4f1Qwy3l
	RM9WWiYj2RPafuRIugxW84HA0VTYl6W0cqelWD+3zV/CF+2+YikR9r8VHqU0N/IGyPdtzUyzBDI
	NnlJy/j3OpW2R7BYQFr1YUh8N3Gg=
X-Gm-Gg: ASbGncvRkfe4hRMO2vp2wZGgmJAAPzF8ImrIJ3wVJEVnGLjqoWk2aciGVR+lZdcFaov
	ZiDS62QJ0VYnLXx9nRL6wJnNUVn7vFlG9NpMUay/LatYPfLSpLnMzClZPxSYTpJ8RuLoN6ice1y
	xbnnVz5OYORSOC2xc+sZF6Tq+zc4w=
X-Google-Smtp-Source: AGHT+IFJEy6545Z2Ke+RXSWqlvWj0WWHtabSwA4+mNyaFWAcza3zu91BnUWXDfNwTTl+wEi2sEX0L/HTlaAJ1JXOh6w=
X-Received: by 2002:a05:690c:620a:b0:6ee:8363:96d3 with SMTP id
 00721157ae682-6ff46090484mr28492097b3.27.1741957292662; Fri, 14 Mar 2025
 06:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312080055.8950-1-cgoettsche@seltendoof.de> <CAEjxPJ4MAaN7P8ZtCcDhRvNt44LNyzL9azc-xNE54=tkW_4vjQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4MAaN7P8ZtCcDhRvNt44LNyzL9azc-xNE54=tkW_4vjQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 14 Mar 2025 14:01:21 +0100
X-Gm-Features: AQ5f1Jrdxpb2kIHUzQLIm-_Q7Voht1wqqaQZP0XTgxWfXabDd5_flyvbVC8lCBE
Message-ID: <CAJ2a_Dc4pNdL8bp_wydmRmQ46GXkWhcA5jTVApF3E415stcA=A@mail.gmail.com>
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy
 instead of cache
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, GUO Zihua <guozihua@huawei.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 at 14:04, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 12, 2025 at 4:01=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Retrieve the netlabel_wildcard policy capability in security_netif_sid(=
)
> > from the locked active policy instead of the cached value in
> > selinux_state.
> >
> > Fixes: 8af43b61c17e ("selinux: support wildcard network interface names=
")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Do we have tests for this feature? I didn't see any.

No.

Is there a way to retrieve the context of a network interface without
actually sending packets? (Then one could simply use `ip link add
$name_to_test type dummy`).

> > ---
> >  security/selinux/ss/services.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 1b11648d9b85..e431772c6168 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2587,14 +2587,13 @@ int security_netif_sid(const char *name, u32 *i=
f_sid)
> >                 return 0;
> >         }
> >
> > -       wildcard_support =3D selinux_policycap_netif_wildcard();
> > -
> >  retry:
> >         rc =3D 0;
> >         rcu_read_lock();
> >         policy =3D rcu_dereference(selinux_state.policy);
> >         policydb =3D &policy->policydb;
> >         sidtab =3D policy->sidtab;
> > +       wildcard_support =3D ebitmap_get_bit(&policydb->policycaps, POL=
ICYDB_CAP_NETIF_WILDCARD);
> >
> >         c =3D policydb->ocontexts[OCON_NETIF];
> >         while (c) {
> > --
> > 2.47.2
> >
