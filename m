Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2259290BA6
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318389; cv=none; b=VVBWQz0SliFQvizfcfHt3Ujdd2waF3nWDOTNLCy0TYATAnaPK7iwFvUaJsrbF/agSw7EKAnFSC/CE7pEjAlKjUQieq8lq+kVYLHfhj3Kl+ZRO8JnYwgDoibjMUyaGb/3Ciqbcz+ZiW+FzHLdNXrz30GI2vU3y/dVBChx20RA8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318389; c=relaxed/simple;
	bh=H0u3vX5VsY8JiV57FEEEPi314b0Fhehwq879pYiM8lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcNjC0/5ctBjGoXUS5b0pdDNXqAFLcbkxI4oW/QqGQuRqJNCvHncHTXAoAmwaWtEvmlDZQ7MfaKVaBYpZBeNc1RTJyvSAjg+yWVHA83mdL6COsH6VXnHykzGpiSDGne+WeQ369kh36K6r2gbEncLMu1B+Bt34PybdEAgsM5Fanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F/PtC338; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F/PtC338"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6df1419f94so1018375276.0
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744318385; x=1744923185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krwoQzIfIMwcctI32444l9PXwjI42QUcJLibz6Sa1no=;
        b=F/PtC338bdrBJPdlcUyRrnaMhtSu2bGeafLD7l6gCMIm1oUwOChmCswfmbMKKgMlCJ
         wfvQ1ABPJpwLuyR7txwmjZ+cz88V2QlfoWrPXMtAXjLsautFaLp9V4tWmOujGEcfHwgK
         MtkTYRFzAgCOc1eRZ2tQqcbMNkK5KHa+fbzLlg3dUfVinSrJNl8JtIAGYJis3nt9bvoN
         CSqBvdwJS1cAvcTnM1XwDx58DTs492Dugj3G/o3eo9+MunZJ7tGfYrWWlgS2XZeLwcj1
         QqrDHiEFZSmIPGL6nRwb7wB0xfS6uaqC+kASsY5ES3je/Ojzk9C1x4QoxMlRpPnaFlGj
         UXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744318385; x=1744923185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krwoQzIfIMwcctI32444l9PXwjI42QUcJLibz6Sa1no=;
        b=iTLi9sWcpOXM/r1SFlM5GwBjQa309Keq3baLX5bq0yvUsLUicdi5uDEkPM59IcdsO8
         0hXLmm7ZuPms+NGpxblUmv7zbrQ1EU7wkf/zUeVpQxTbz7uidL/bSKx4yFfEojdFhwA1
         1FzN9VMrYf4FD5UOJCrNmdiX6l27FQzAFIY4Z25LqcJc2eHjSso8rQ5tmwb7CotE3W3o
         00VW2Y0V1jPeBLzM2QpNHWSdwoPUKmLvOx0C9owQIfiMbCay8GvGYRubL1IXcFfav6nu
         9bE3dAuHB+ToUCxf2p462K+blZz0v0sWCFPRyj97DmcqMefqmgJm4Y+q3zeC0RrbH9Qi
         rmsg==
X-Forwarded-Encrypted: i=1; AJvYcCUq05vdeuFEivPjs273yN0c/lspRxh3wXCG8R3/rIpsE+NLl1ZBEImq+9yqdAj8Hr5Q2oBK2W6K@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Zb6OBQod3BQr1eLRND5r8djp53HSST/v2dxdsCHOgbORL+zl
	jH2fksNgoYmOrWoD8to4aisV/YK6HZj0a3U0evov3csawEeDqXJzKpQ1JwVhaWCiCMKNLF1r+x8
	yAg/YftLGGpTIpSNRrPB6xpTP/D90qryJVZiG
X-Gm-Gg: ASbGnctpEM+LfbrVWH5eKTCOZ4pssu4SvBWyEDt6nte9C0ZluvJNS0+B3gnfZfN1c3u
	jEf9oKDKs8v1Hb8SrSg1HcolCYiqAnbpNpB0wOfwtu8uSGO6Z0bnj02aSu8ZJ6Ky4ju52JStxvT
	bqYb2BNQtLlnKRjMQjMbjH/w==
X-Google-Smtp-Source: AGHT+IFXHNys0Vus65ea3Y/4NyU5LsKY5+XwkeWSZndll+T+IMEQQ87WU9qeAi5e/zuv/55SqI008xJ/mLuSjAC3hoU=
X-Received: by 2002:a05:6902:240e:b0:e6e:1892:6288 with SMTP id
 3f1490d57ef6-e704df7a0dfmr714330276.16.1744318385560; Thu, 10 Apr 2025
 13:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-48-paul@paul-moore.com>
 <202504091406.0A86DE05@keescook>
In-Reply-To: <202504091406.0A86DE05@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 16:52:54 -0400
X-Gm-Features: ATxdqUFLySLsnQc7LikhtxNtcIk3wiotiSA5wvDMv50VG9dh8rCpFsiLKa6iTXk
Message-ID: <CAHC9VhQ=D30C4WfGCMDDvXTrTd8iX7=c8pwDW8wKF+nEydP0_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 17/29] lsm: introduce an initcall mechanism into the
 LSM framework
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:02PM -0400, Paul Moore wrote:
> > Currently the individual LSMs register their own initcalls, and while
> > this should be harmless, it can be wasteful in the case where a LSM
> > is disabled at boot as the initcall will still be executed.  This
> > patch introduces support for managing the initcalls in the LSM
> > framework, and future patches will convert the existing LSMs over to
> > this new mechanism.
> >
> > Only initcall types which are used by the current in-tree LSMs are
> > supported, additional initcall types can easily be added in the future
> > if needed.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h | 33 ++++++++++++---
> >  security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 117 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index a7ecb0791a0f..0d2c2a017ffc 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -148,13 +148,36 @@ enum lsm_order {
> >       LSM_ORDER_LAST =3D 1,     /* This is only for integrity. */
> >  };
> >
> > +/**
> > + * struct lsm_info - Define an individual LSM for the LSM framework.
> > + * @id: LSM name/ID info
> > + * @order: ordering with respect to other LSMs, optional
> > + * @flags: descriptive flags, optional
> > + * @blobs: LSM blob sharing, optional
> > + * @enabled: controlled by CONFIG_LSM, optional
> > + * @init: LSM specific initialization routine
> > + * @initcall_pure: LSM callback for initcall_pure() setup, optional
> > + * @initcall_early: LSM callback for early_initcall setup, optional
> > + * @initcall_core: LSM callback for core_initcall() setup, optional
> > + * @initcall_subsys: LSM callback for subsys_initcall() setup, optiona=
l
> > + * @initcall_fs: LSM callback for fs_initcall setup, optional
> > + * @nitcall_device: LSM callback for device_initcall() setup, optional
> > + * @initcall_late: LSM callback for late_initcall() setup, optional
> > + */
>
> Yay! Proper kerndoc. :)

 ;)

> > +/**
> > + * security_initcall_late - Run the LSM late initcalls
> > + */
> > +static int __init security_initcall_late(void)
> > +{
> > +     int rc;
> > +
> > +     rc =3D lsm_initcall(late);
> > +     lsm_pr_dbg("all enabled LSMs fully activated\n");
> > +
> > +     return rc;
> > +}
> > +late_initcall(security_initcall_late);
>
> You'd need a new place for the lsm_pr_dbg, but these are all just
> copy/paste. These could be macro-ified too?

If we didn't want to move the other LSM framework initcalls into these
initcalls (yes, I prefer it this way), or add the LSM_STARTED_ADD
event at the end, I would tend to agree with you.  Let's leave it
as-is for now, if something changes in the future wrt to any of things
above we can revisit this.

I'm also somewhat hopeful that this work will bring attention to the
different initcall types/levels that are in use by various LSMs, I
suspect there are a few LSMs which are currently using multiple
initcall types that could be consolidated into one.  That's not
something I wanted to tackle in this patchset, but if we could reduce
the number of initcall types that we use in the LSM subsystem as a
whole this may not really be an issue of any significance ...

--=20
paul-moore.com
