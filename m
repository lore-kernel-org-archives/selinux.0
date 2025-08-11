Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88D20C001
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934461; cv=none; b=FpnsfXOyMdrXKtaQE+oVVsGBchddrVjZydsbiL8/gkMpUjq+AH2sPcp4i4WA/9jhRc0HH45bzNYoRVsSYPQVCh2RkXoFTMrUnL9HiRQCYs1w3FzpfOlsDI0xHThdS4zXVuGzHsO0PoeMbaP6G+yE4YwCaf0bhJ0tZchtrbN5eXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934461; c=relaxed/simple;
	bh=kOmL081mxbFj4ZngsQBdwwSRuw67N2AP7w97AWGIvtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDCJxRU9BsB10rt/MiAdvIGYsMFGuc7ApqeL1r9bOHAPgqPmcHTjwgbVTGRsc5CA+EtVb3dWTyrLacynQi4FX33NNR5oq02Rkdt519kqxzrNMOqxusfiGofrG2yhN+VcqbjQ8ukqqo/hugk+hPYYkTKBQ6gcdjXygH3GAJbbh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BNSs/rI7; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BNSs/rI7"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so2859798a12.0
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754934459; x=1755539259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7BODnYqYgp3xBmumWiQ8fQPxq8p9mdpIampz7pNYk0=;
        b=BNSs/rI7bouZVOWRIHFpq4uxFrPGAEq1lIm/yr5lP96Cx18fXBcHhvN+TohZ8T9CM/
         Z6LhM3fR9n4cEG+wPyPMjg+OPFLETHS5nuhpOmjdHx14niotO3U219503cZxRWvZiOfF
         vqHP2v6P/hxNqtXdxmfOlfy40EjfBZs+OBoDKRFQh+2VL37KNjKNEr6Qxa0ZBVfcXM/a
         /znxJh4B/GCpzOi5guBZ47WtetUuD8rhSRBY8jG48Wi3cHsTEGUTMFuY0qcWhxMt4OKa
         Ve641RMoxsmblAvSRx2I5cnxn7bEFp2nkN1YwoGSyidbiXga0g8njy4dswROfXMtiaFW
         JOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934459; x=1755539259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7BODnYqYgp3xBmumWiQ8fQPxq8p9mdpIampz7pNYk0=;
        b=s6HFqf8keGTZoZ0wNS6mi0xhNl1989/IPTtNlqviBMYkmAuqbn2Oz90v7eNCjbhs0m
         GW8YNGcUFQSnjaoN96GeBz/9dbWa29y+VtJb+ZTcxWU0vLphJYKD3h6+jxXWAIypQcfI
         8T2+PWJP/YEXxGR6BwY1jb6U0dqik888aSRqGA4EcM9PyH9vPpZ5I15eXsGLQD8ROfdm
         5zcqxoTjs1xQvyCoMhBKU/3Uv8zegPnSgirZHVVvns20Vt1VYnvANy0PokZBCXU+SXiV
         vUGeOAbkaGwaGOikILDJd2UXAaA0p9jPxnItUdgOuZHogZ4KLrqqG00ZdC9juHjH7Qsr
         4GfA==
X-Forwarded-Encrypted: i=1; AJvYcCXMAwCT+0L2KZnV3Ol4WlHqBwHFoXd+EhC8B45BzyWGJF4jfhQ2deAL0qyUWvm1dTVFx9HIfLau@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PQ2P6wA6QKSZ8IU1ZCbMDvs1FnOAcmDERDZmjJYjFym1Y+oc
	sx+SDcyzzHEFnTUgkSH+Mxdj5DvNa3e51xyBOxPuvMGUTjJlNWpBPBerw0vJLcIe1lxsOewrd93
	yefd1ezQcFYMoiFN5GL10hGNMQQahmLeovx5XVpVG1YFSnhOpLaU=
X-Gm-Gg: ASbGncta08Awl/nLAfzPXNmhkxZquqL1OZf7uRFIc35Yd1NE8SKi79/isuGHR0Ad7F4
	sVtbskxZBQ5RS70g029EEYxk5hhP1aK1ws8NDH3sdJfM9dyWhENTPxI5YO2X9zB+8boUBcUeh4u
	Tkb7Z+EVkOIBgZ48Qntso7LWNkEeSE6ym2nt/IIZIlBtcpx1fSsmr4SpnM1NwCqfSXbRjRif7x/
	W+pJno=
X-Google-Smtp-Source: AGHT+IGf4hEewi//tq9B71oOFuJzldjTdCp1+YSE7YQiepj2ju22p2oc+JO4Ih2fN8exozu1/F8cRhUuzakIMSHK/r0=
X-Received: by 2002:a17:90b:280e:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-321c09fd50amr634486a91.7.1754934458668; Mon, 11 Aug 2025
 10:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com> <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 13:47:27 -0400
X-Gm-Features: Ac12FXzh5fuSB_sPHrqVOJmkXJnKes0EEDo7P7pyhL3fMxWx_XA1nL5xBzBUP_M
Message-ID: <CAHC9VhSck4zDgsBtdBJhJ0qYtNz-tFYjj=3=as+4yX38JNTOGQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: ericsu@linux.microsoft.com, danieldurning.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Also, since you are introducing new permissions and a policy
> capability, please include instructions in the commit description for
> running your testsuite, see
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#add=
-new-permissions
> and
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#add=
ing-a-new-selinux-policy-capability
> for instructions and links to example previous commits.

I think it's fair to simply call out the new permissions and policy
capability in the patch's description along with a simple explanation
that the new behavior is gated on the new policy capability.
Including instructions on how to enable a policy capability is
something that I think we can consider "an exercise left to the
reader", with documentation located outside the patch description.
The unfortunate reality is that there is no single right way to add a
policy capability to a system, and those instructions which are distro
independent are likely to also clash with the distro supplied policy
packages.

Unfortunately, while the process around adding policy capabilities
have improved somewhat over the years, it's still and ugly thing to
have to do and I'm not sure a commit description is the best place to
document that process.  I still have hope that some of the new policy
work will improve this somewhat.

--=20
paul-moore.com
