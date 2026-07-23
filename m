Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDE23ED5E
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821118; cv=pass; b=FvnC+K2CZSSa7HPSUllimZ0DEwhuRE+1uqJO75SrUxJ2tT8Et5jKEwOV37boIsijQxr/VhRxmny+6u2nOFaZ4b3lR6StXufawLtYwg0oxuROuLl1HJ4EOX9EKu/tOjLdtLU4g0d9ZWkQe+K7aLa/Z8PEYkiwdWUddVuJ53NOmf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821118; c=relaxed/simple;
	bh=JcJ3HNC4oH0LkTu/yF3CW+3wLOkFPsobLiqmHeU3+VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAmCtZ8DUNeJc8vW3hdeu7jAta9VOw1TEJMS2+ncxnq0zvic+ghf+1IEzb3nsimY7LpCCJPkxmPD4e6kp/aAs+d2tiwi8dm9WIdpA+xl3dm7lPsCNzg6yCBH4FpLlDCWubL8/5BvEhnX4rVARkh/BNqGVz9e5Fvqk/0PCYHYpgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+dXOZ91; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+dXOZ91"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso761260a91.2
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821116; cv=none;
        d=google.com; s=arc-20260327;
        b=b7OcjG64lrm/K/ZDFqx+m+uiOKZjJHG75ANU+Rt0gvmxpOOMXStkwyUPi7r9fjg+ia
         uw7UbGVDtK1TtB+dWHJ2nAtG1iYl0D1td9XFZUcK4c7KPKG448P5ZP9TnM+dCRcDo+Wc
         Z6NF9m5dDlBSPM3vrtHnkp4lyVdhw8c2ln1FUh1jVc0VLbyl6S6eYy6thPTTV+ZWs5Ro
         LmLJxjR/TDPL004ZLfn0WYKxMpA1v2WHCb6356wesyFs8ZO0gVVreg8eXetda0ghMXQv
         6FErabCcvPcuKRQxbF5sx9LK+g9CdrRep7xwC+aLxmwQ3XayrPRFgzj1VNR1mK9/vIO8
         ibRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JcJ3HNC4oH0LkTu/yF3CW+3wLOkFPsobLiqmHeU3+VQ=;
        fh=4Epa210Bn+JqH1OsaCu0hwnczBIle3GlI/TGpZ01hXA=;
        b=RfXunMQ01hqxQJhAcci1uJ62VOHqgwdPWwT5ED3lV3Sml6Khi7VA60jLsDLrHu8yCd
         8yTioNbsAAiTX+GEX1r2wl3wzsMFIYM0yMdmlgkHhGc8SiYWjfjJKQHOoGnuvHm8kRKz
         kWOsuhU3GjE5J1XLO7GD6uWn4gk5vLOylHnSj4IPcjvY2Iqg+wSCzZ/LvdngO6NmfjCy
         5bmZxmj1DFaFT20UOEa2D+45LyIEYti5+92weeaD6JkEA/Kw6awqb4MuhSC21FFbMP21
         b2Z0J2eePuufEpEOWCfhvN0w7/Hy8Noo6DFW9x3hino7/ohZOWxPNtiC3whWg4ak4zCw
         npBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821116; x=1785425916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JcJ3HNC4oH0LkTu/yF3CW+3wLOkFPsobLiqmHeU3+VQ=;
        b=b+dXOZ91nfpEYjA/2CMXtOs2rwFaeu/n92V295lKKFnY3eDELC1yzL1P1hGPorLWdt
         yIlhIAlO1BYKMhjYUzowLs7ISvFgXrnS9iyyQluiYdNv+kf4/g7w8yNlQ57VJHxEcdsg
         ymWLhgPQVTXy8UJ3R1hepADK80AKOBgXz5E/MbFqVWsuQHUCE1mgzO/Rca6zdYU9hUPt
         k7Vvin6E4dqrUPdylyvhVmF7r6FhI37FY5kUBRlK91Erh/CxBFAZWJNnk8JqGJYp2BNH
         pJIbYoMFOyw4EwpJf2cBcyRCigYK8oBKeho4aIRTMYNKxVPiTW7fe/tpOKFxXP34BSVA
         8Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821116; x=1785425916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcJ3HNC4oH0LkTu/yF3CW+3wLOkFPsobLiqmHeU3+VQ=;
        b=LaxLKRdB+nBAWXX7T0xDUi81mLaym+Dy0/dag2yHoFU/7NFB8KI8irgQMzckj/ATTk
         twFxaf0xKoux3LKlVfTqor+67EeM5CRtnn/phv4G3MOUokbSkheOts94XGHaOXgdHQe4
         KskQ+0e/poq3n+csI3Hl8U/8/sIOykAPquz34+/f0Lcxi9a8wu+o/CBRHh3N+JfSfkpt
         KDQN+Bh09B5kMLguvQyrKugmnWppQq8KHmjPseA6/o9QOEO4hY2keHuN4SBO3o4gpGLc
         t2rdcJWE9vnfGVtDFN7Y30DtL4lb0HqfhqKOW1AYhvqfXlAgV8btt2lVcDyRXSvWLTMY
         ijrg==
X-Gm-Message-State: AOJu0YxLJFYUGw6+mUght3cYaQ+kHZzLKxHfevOh9zcJ/z5DE+Yuf1zS
	YhRJSJOkkHNJqVOSHrTyXHevLxGS+icFXadk3N5l5anbJPVHKhKOZ/AoS/uWSPnkoCOiMH0eUyo
	Rfom/pDiTp0FrYwk2HiUit/9cV106Ows=
X-Gm-Gg: AR+sD12+ZSDeH8PFwggdvya0TC7/qERr35id9zI8IeZ+8cYC7pvzGpWK3aAWhIFSCPF
	eyPGvMFKZqu7w6LfWsLoGq0B4D1uDh7OqAjmooa9dMjG1D8YMI2sVtcIC0zfK3MqN/+WUTxGn+z
	sOJdAbAR77ocmbqLdVqmmxk6lVXnww1+DyuwUGUh8Nx7fGKY5z3GYKJQANpUvUkKTei73IRdOXs
	yUipoU77qSfmcb2PtZ0yjVhfgClZu4H/44ssgLkAD4VWy7ADNxasQkacLMroiQ+bQcIgROf
X-Received: by 2002:a17:90b:5205:b0:38e:500:3975 with SMTP id
 98e67ed59e1d1-38ec651cb9emr3998298a91.18.1784821115709; Thu, 23 Jul 2026
 08:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amHW-fFHM3pw-g3y@suse.com> <CAEjxPJ5KfidbsqrUe07F8sdssdqEtEUsBUDgGqn4dm4RZUcyOw@mail.gmail.com>
 <amIxkNuNJcxhtkOR@suse.com>
In-Reply-To: <amIxkNuNJcxhtkOR@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 11:38:24 -0400
X-Gm-Features: AUfX_mwcOgMZLisjtvxZpt3ZE7UBkBT5Bv6ABkiJxZEIcGwaWGNVazKTpH5YCCo
Message-ID: <CAEjxPJ6oS-W+5e6G-KqSr60CP+GTU3G_A6d0nLpFHQMPnqccGg@mail.gmail.com>
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
To: Johannes Segitz <jsegitz@suse.de>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Jason Zaman <jason@perfinion.com>, 
	James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:21=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> =
wrote:
>
> On Thu, Jul 23, 2026 at 10:55:48AM -0400, Stephen Smalley wrote:
> > On Thu, Jul 23, 2026 at 4:56=E2=80=AFAM Johannes Segitz <jsegitz@suse.d=
e> wrote:
> > >
> > > All other failures are handled gracefully. Directory cycles can e.g.
> > > happen on BTRFS filesystems with subvolumes. Skip them and continue
> > > instead of exiting
> >
> > This is a user-visible behavior change so we should note it; restorecon=
 -R
> > on a tree with a bind mount of an ancestor will now complete with rc 0 =
and
> > only a WARNING rather than aborting with ELOOP.
>
> Okay, I can write something up. But in general you would be fine with the
> behavior change?

I am (although other maintainers are free to disagree).

> > Missing Signed-off-by line and the patch still doesn't apply for me
> > (did you send it using git send-email and against current selinux/main?=
)
> > but also see comment below on the code.
>
> I start feel like an idiot. The first time I used this old repo with the
> wrong branch, but this time I made sure it applies, but didn't use
> git send-mail.
>
> I did
> # git format-patch -1 HEAD
> 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
>
> which for me then applies:
> # git checkout main
> Already on 'main'
> Your branch is up to date with 'origin/main'.
> # git rev-parse --short HEAD
> 84d424b8
> # git am 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
> Applying: selinux_restorecon: Do not exit on directory cycles
>
> Maybe my manual inclusion in the mail breaks it? I attach it now to the
> mail

Yes, unfortunately mail clients are unforgiving of inline patches
these days so we recommend
using git send-email,
https://github.com/SELinuxProject/selinux/wiki/Contributing#contributing-co=
de

We still prefer inline patches for ease of review and inline commenting.
