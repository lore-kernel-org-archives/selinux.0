Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306D33F363
	for <selinux@vger.kernel.org>; Mon,  9 Mar 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080167; cv=pass; b=pdzBMMZWpgiG5gY2n3RmK4HM4R62NZsSlhlVmmaDA+LbHgOS7DjdzNWmkBhphSAaCoDsE1gt79sa7iGT9yGeFvbu/aRm6Ci+x3xxoH6NitxxdjniU9sNqgawzJxPae2uhVE8AT12RH6UHvF6xXQXWMXHFbFwdQxavlY7lkTV4y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080167; c=relaxed/simple;
	bh=biMW06izqHwC/weF6dlF7kNuElYeXGJotcHh9VHQtgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAYjbJlw9PxB3PxSZL6isUi8YyMTzjzK50SJYH2wltzlLoH1MeeDTLtlQdl8QhovnXEzdeCsFbVrYPWKMvEI8Jwd/Zfhru/0oe56B0Z/7lcvdi7dxPb7UJj+OAJBQ4k+3VcU9jdBjvX5ZWfM1GIDzqo0IBvV+kn7Hx6AzLg0kJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih6p8PbZ; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih6p8PbZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso38084415ad.3
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2026 11:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080166; cv=none;
        d=google.com; s=arc-20240605;
        b=G1sKZXPMGqOJJ5CBmRXRCFfgXU8S0lXGbU1zyNvkaKDWZ7rUBeKoMP1NyO8yN3Mnxv
         SFV1kiUb0dIvR8LxkXLajBs91MWDHu1uQxjPM127jUBYoTJy3t2njqD9Wj4hroj79xPy
         iHrCFD+9WcWZA7nQdhkspqRQ2DjjKVVYY8mkKzD6MYDITG4jB68fWGLc9Sd5+LUEOxDq
         zoNaE336yvaC+A4pvP218yHqvihmkaGwu3HkcJzeHbIYWCm4NDbxGIrS/5SXc/khmQtI
         bt/bDM4YGGkWyMfDIykbdeUC/ni9wc7U8vezG7cakmMII1+AzE6i71wm2/hj9f3Qow1y
         847w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RsTb1dXByGvvHOMrPfAupkKkViEWmxwYD54CiX/bfHY=;
        fh=EV2x3jtjaPaD/t6BGnUZxM5PjUMEowiazkMh3auF6bg=;
        b=A41wTAK0PpSWKr6R6J/oQ+aOvrY0EalwqR2OSTSxVskMtxSGGnjhH4tFliEDMFU17a
         8jUQNYZuj6mRJ/6fNzHkaHu3XFoN6k59Q6V05XOq0R4uyODpe8RFXLPcSsBklJozOc0T
         WhfTjpE5a1UlD3DaA9XnW8vWWBTrFhIrPESYLM5QXFfxcoq0v7/DyxlccVABELBBmhqj
         zyNXP/pUAJ73QESxvIF8b6zwaAAEErf887XmFIz8gkcCEXRKwSZhT8bvLItpQzrb1L6f
         zPMiaWHPnNmCdc96RiC81/iuHWKDyOVcitHNj1kb34X5fjUEsDaf/aHY5mcGLLbyexmk
         rJ7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773080166; x=1773684966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsTb1dXByGvvHOMrPfAupkKkViEWmxwYD54CiX/bfHY=;
        b=ih6p8PbZULf3J/K+pLKPkiEfn6wGge0Dp3WQysJIJ6xHt8h8CXd/qVnFS+jMOt0LSM
         d4OBQ2PiT2FZsHCFOXQau+2tKsTJiRHhmvuwSGlsNUrumChZy5zrwxtB+WE41CSGG8XY
         By3wJesxy027IE0oI72lzSPG0f27Mev8+BRfzRYDJhJlUiBDeT36Zw5dn3Hvcd/QJFBy
         ePbkLky9Mxx8qGhdDB4zQjTfz7aGrxqGCatMlhP/Ncy+7OANoxK01lIvIEq8Ll7IPunz
         CLXLAtwfav+Nd2DCWTy2tf2yH3s80q+l1S8Rp+NM3WPtmdbPJkEwMTAM96t24mRgemR4
         c0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080166; x=1773684966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsTb1dXByGvvHOMrPfAupkKkViEWmxwYD54CiX/bfHY=;
        b=Uu3Gd2W2A18Rp3JTDk5Tm/BtcDqwsCQaigCl8MTQxIHoLgXBcgkFXeK7mAnTZkBkKC
         SS89mn6WmpS/JHZAKuVbhM9WY6rjik6NAMB8zk2UxUMEkwUHI/8lM+EdoJmsFbRgcpKJ
         2nTCVyXELgHoEkwZVZcwm8PyfXmmFq1WhG/h58ikh62fO1YeDB5jJQ6YCn6F3+3gQYHD
         GR4vBBcBnTf2DTdtZr0DAn8ZMotPY6m7yKiJ8/PfAYDVhyB0/iOf92vB+DVchkUyPGde
         Tz8o5pRweNXd4W2lAQNbMRkVPzjrJ8HM36SJticAWnOj9D5X716g+zz/6iZMjqsHFEW5
         cUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9jV/qpcjfu00tHEPvgVGbOlg+zl2ZsMxZkhpLQ0zYAiqU2eyODkA4FBVxA3/M7mFQlg36wKty@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVXEI2NqvWVlaHvGC1O33H5DiRKNhWufoaddxQwDMB/LXa/ch
	29jfTOnKMjJu2KD4yuTiD7TsMd02yUw47pEF6lltcjMCzweXFB9JrCUaRIXsAf89jULIzXMVYDG
	9/F8oJiI/CpAaTgBP4K56r4t86bJWJn0=
X-Gm-Gg: ATEYQzxKdWTmBCbz8WHAxsFM1T+7+JgmS3mThggMjPPF2TXzS/FRMi9arqOwDRJcdb7
	Gs3K0FZoAjYp79wzvTvDxxha2uk78lbkYkLqqQbJtM2RnWqttrtJU2kjKnfkoxYHk3gyS9JSyQo
	aBF7669SNDSpN/I6i0wJzEER5T+rBjE5YirlRPxhSgHocqhHjDkw+inCRpEQGA++qlMRUdMh+Ft
	iBvqYagbI8hTtwoD/gRjO65VVWWA+CbkHa1H+hNQE6vTGqAwPgVdK6xMkmMm/Nea5DOKXqgTO+o
	pKQ8AsU=
X-Received: by 2002:a17:902:cec4:b0:2ae:5275:4d52 with SMTP id
 d9443c01a7336-2ae8255cfe2mr123792365ad.53.1773080165933; Mon, 09 Mar 2026
 11:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <20260306174815.GA9953@wind.enjellic.com> <ae5e9c1b-d0cd-476b-87d2-70c0bc8ba09c@schaufler-ca.com>
In-Reply-To: <ae5e9c1b-d0cd-476b-87d2-70c0bc8ba09c@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Mar 2026 14:15:54 -0400
X-Gm-Features: AaiRm52n-DeisXreA1xmhL7j8kFFiI-ZDWYWVOQBkYYMQj742vSU-nsyvi7JKCI
Message-ID: <CAEjxPJ7yuJ6sAZ-ViqT04M5WPC9O39m5UUGw2f3+GDR87tvbsA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:01=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 3/6/2026 9:48 AM, Dr. Greg wrote:
> > On Tue, Mar 03, 2026 at 11:46:53AM -0500, Paul Moore wrote:
> >
> > Good morning, I hope the week is winding down well for everyone.
> >
> >> On Tue, Mar 3, 2026 at 8:30???AM Stephen Smalley
> >>> I think my only caveat here is that your proposal is quite a bit more
> >>> complex than what I implemented here:
> >>> [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.sma=
lley.work@gmail.com/
> >>> [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.sma=
lley.work@gmail.com/
> >>> and I'm not sure the extra complexity is worth it.
> >>>
> >>> In particular:
> >>> 1. Immediately unsharing the namespace upon lsm_set_self_attr() allow=
s
> >>> the caller to immediately and unambiguously know if the operation is
> >>> supported and allowed ...
> >> Performing the unshare operation immediately looks much less like a
> >> LSM attribute and more like its own syscall.  That isn't a problem
> >> in my eyes, it just means if this is the direction we want to go we
> >> should implement a lsm_unshare(2) API, or something similar.
> > Stephen's take on this is correct, the least complicated path forward
> > is a simple call, presumably lsm_unshare(2), that instructs the LSM(s)
> > to carry out whatever is needed to create a new security namespace.
> >
> > There are only two public implementations of what can be referred to
> > as major security namespacing efforts; Stephen's work with SeLinux and
> > our TSEM implementation.
>
> Please be just a tiny bit careful before you make this sort of assertion:
>
>         https://lwn.net/Articles/645403/

I believe both AppArmor and TOMOYO also have namespacing
implementations already upstream, so SELinux is certainly not the only
one. Looks like the Smack implementation you cited above was based on
extending user namespaces rather than purely Smack-internal like the
others; is that why it wasn't ultimately merged?
