Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE38322A;
	Mon, 16 Jun 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078066; cv=none; b=qrWKm3ZOiDAboKyBklO+x6fq5K+uTB+4B2BwxEpszNDX1IAtIJZkkCEyTslZCbXL4YykbGO8nLEn+DiFftPbIUqiJGlOUR8mmcJh6iOi4L8NaOVIOrsRDgMmu47duNk9wNh3TVwrzSDerYy60S9iY1B3q0DRjANxDCSNfB75HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078066; c=relaxed/simple;
	bh=+4OYtpJMnbcG2YLmLf6YCJAPEq5lUwAr3ng9u9nALnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwMg9ugR+kxZatr5RfTSQLkcNiPT797vGSY6ogEo//j/7G2kMoAO0gbHiVk4rJqBPYSeNKF4nS8gnh1VYuGeDrOxMbK51/ZwhlEL7akoH+bkSGahCRttJhexdFBgdzR8dSVYW6RZcpiQFo+aSkTZlq2iSmC4N3ltMmV28lou31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shw6Odfo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shw6Odfo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2f11866376so3369445a12.3;
        Mon, 16 Jun 2025 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750078064; x=1750682864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AWXqr0IBsUI/FR6pLkgifGiziC0HV+3bLhyshWApw4=;
        b=Shw6Odfo80uPNX4Msbik8IMQURnFog1IylUA4AKInYgaE48gQDTJ7jXxYp7E0nTW44
         4mOxk8Q4FBFcnHrTLu8TJlXfFG1+FLH9KQW6+ojoD+0cF59cSsYvZ7banJA8NGVxEQEm
         vQrsBF2xZoMttq9ehZ3xgElLh4pUjQKMt6zJZNgvGS9E9hgyfZClJJL1RUNt9MNgGY+2
         SX7t3gd1JPQwRawwTlijX2VFgQv71tkNJhI7s0v5UdVHRCOOflveUJCqL4PkXRW3+OJ/
         ChvsBqIbkc0cZChtACV5aiRDuY5GWbkgt6PG9e0uJcuzT2TzMVu/wa+SeC3Y9TBJvQQA
         QPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750078064; x=1750682864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AWXqr0IBsUI/FR6pLkgifGiziC0HV+3bLhyshWApw4=;
        b=HhK4wDTKXEJfcIDg8b7LS8I+foy13Pu6EqmotY2SoXiY6d+8d2w+TgK9z6LIXsXzHr
         2bkgJgmFwnIC9jyaw83/TnVT/QetA19xJGLfjNJmKOjrf06b/2EXKycNAYk+5d52dvDz
         DzPpIB3vZrCVOIotR1yO9DABoq0/N+8O6q/I6zg4v0zb8ULfd8KU/KU8HJQwajf0Gsaa
         ISOJwMiEslrBt7qB+uYdN2i2MK0yGZQgrxwRsCurrMLdSqKpRNQriRbmhHSG4irllLWv
         6CM2N+ixQh7pksgSjsDQ6ANkxJHGt8DyxQmj6QajPKH9fiLsoQduSLAbjulvaCbq0h8I
         VeUA==
X-Forwarded-Encrypted: i=1; AJvYcCWAInmr019emDlOiUL775zr4g9IhnVClivdUq99UreA6KiL0YYrQ1n4mnPNBCSrdab6K9L0Fnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbH9y0xTCgkhV3o6dB/7AnEY3dtYVI8xb2p51is0gpn9MvZYIw
	rr+dluSWOG5igYL1y3MTep4ZPBOJPOds9xv6Y8CKx7Vq0voRlORj+gLGeIVeZW100iTbisbstfc
	+kjOYYWoVpw9IdSoYY38yhpsG8wIVqqgS1w==
X-Gm-Gg: ASbGncuOfXM58MxLwCWK7Ww42BYS3xLnf4IhUGTSPv/bkK6k4NjB1nZXwLPJ8SHB8dC
	e55eMJuEfrj6CCIH6MKVdKxMSyiRg24js0Ytq2ae8Vv1LITcpykxQKPGkfdkB7wmX154bBl4CBS
	8aGV+BCv5u75JTJfbUwu3Wn+h1N+w68Biuywb9LTkfn0E=
X-Google-Smtp-Source: AGHT+IHj9NEknWi30bGJAPBIsxlkhkDjp2euEmsA7C/oD0BseVSVM4PF/zuodqFq/DU7e7YGn7A5cjQVEgxVVc8o56Q=
X-Received: by 2002:a17:90b:4c09:b0:311:c939:c851 with SMTP id
 98e67ed59e1d1-313f1ca12edmr14107909a91.4.1750078063601; Mon, 16 Jun 2025
 05:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
 <20250610172226.1470741-28-stephen.smalley.work@gmail.com>
 <20250613141525.GG414686@horms.kernel.org> <CAEjxPJ5cZB1zz3dCUz7ix-WW4P6Q7QaeE02TjcU6zg+SOg8KLA@mail.gmail.com>
 <20250616103112.GB23708@horms.kernel.org>
In-Reply-To: <20250616103112.GB23708@horms.kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 16 Jun 2025 08:47:32 -0400
X-Gm-Features: AX0GCFumkG6yeqIS2daN64jUZE5pqcIeWyJMaCcxG3PT3oA887zQe87UOynVXDg
Message-ID: <CAEjxPJ4LpgVMHYXUEpz7i3KY+V6eg4BWc8ywR13yc9N5xWxx9A@mail.gmail.com>
Subject: Re: [PATCH v4 27/42] selinux: introduce task_obj_perm()
To: Simon Horman <horms@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:31=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Jun 13, 2025 at 02:18:54PM -0400, Stephen Smalley wrote:
> > On Fri, Jun 13, 2025 at 10:15=E2=80=AFAM Simon Horman <horms@kernel.org=
> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 01:21:58PM -0400, Stephen Smalley wrote:
> > > > Introduce task_obj_perm() for namespace-aware permission checking
> > > > between two tasks using the objective SID for both tasks and
> > > > without assuming that either task is current.
> > > >
> > > > Convert the permission checks of this form in the hook functions
> > > > to use this new helper.
> > > >
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > ...
> > >
> > > > +int task_obj_has_perm(const struct task_struct *s,
> > > > +                   const struct task_struct *t,
> > > > +                   u16 tclass, u32 requested,
> > > > +                   struct common_audit_data *ad)
> > > > +{
> > > > +     const struct cred *cred;
> > > > +     const struct task_security_struct *tsec;
> > > > +     struct selinux_state *state;
> > > > +     u32 ssid;
> > > > +     u32 tsid;
> > > > +     int rc;
> > > > +
> > > > +     state =3D current_selinux_state;
> > > > +     rcu_read_lock();
> > > > +     tsec =3D task_security(s);
> > > > +     if (tsec)
> > > > +             ssid =3D tsec->sid;
> > > > +     else
> > > > +             ssid =3D SECINITSID_UNLABELED;
> > >
> > > Hi Stephen,
> > >
> > > Above it is assumed that tsec may be NULL...
> > >
> > > > +     rcu_read_unlock();
> > > > +
> > > > +     do {
> > > > +             tsid =3D task_sid_obj_for_state(t, state);
> > > > +
> > > > +             rc =3D avc_has_perm(state, ssid, tsid, tclass, reques=
ted, ad);
> > > > +             if (rc)
> > > > +                     return rc;
> > > > +
> > > > +             cred =3D tsec->parent_cred;
> > >
> > > ... but here tsec is dereferenced without explicitly checking if it i=
s not
> > > NULL. I'm wondering if this is safe, e.g. due to the call to avc_has_=
perm().
> >
> > No, you are correct - this is a bug. Thank you, fixed via
> > https://github.com/stephensmalley/selinux-kernel/commit/85e72ed549d01a2=
da407feef6493cbdeca324f82
> > and will likely squash into this patch on next submission.
>
> Thanks.
>
> One more thing now that I look at this again.
> Does the access to tsec above need to be guarded by rcu_read_lock()?

Yes, I believe you are correct - will fix. Since there is only one
caller of this function, possibly some simplification and optimization
is possible here.

>
> >
> > >
> > > Flagged by Smatch.
> > >
> > > > +             if (!cred)
> > > > +                     break;
> > > > +
> > > > +             rcu_read_lock();
> > > > +             tsec =3D selinux_cred(cred);
> > > > +             ssid =3D tsec->sid;
> > > > +             state =3D tsec->state;
> > > > +             rcu_read_unlock();
> > > > +     } while (cred);
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > ...
> >
