Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7211BEF8C;
	Fri, 13 Jun 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838748; cv=none; b=PEDxHg4zQMUF3cYej8B7BvNTYrFGCmzcU+32uWTIE1gLQiHeQFZwjtquxWQX+lJbtGrMP4bYytkiAFXicvIdc0iPxfuT+B6RJkexpqH/kYY6EO3w2IqtWo091W2VHcI0r4vcDGd5mmzkYe2g2lfo8oA+Y3IVNP2xNUVWjj3EP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838748; c=relaxed/simple;
	bh=ZeQcBbGTeFDIAQPmT+9xTxaEnvVae+Mt7VSBZoiYyuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqZJ7hwwm3Xhp5Goqtn9xp3ux/Q9wek8MSOSBAlM6Y+0tCop+qfayrkiIQLPTN8ByP5NdnvffuLhm6fg4sj5YG2m4gcklDgqYcTPhcfcNQXUt1QJpoLQiNHbgupEJQgXJ5208lfrB5aLEneRic39eLpI8dFvLZZYLP4ydUlgVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca42t5v3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca42t5v3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235e1d710d8so31212855ad.1;
        Fri, 13 Jun 2025 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749838746; x=1750443546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7tkrgz83yLxxWDVBammUj3el4Pcyp+zXqZfIY/vHZ4=;
        b=Ca42t5v3jPSwIchEvoVMnqAA4rAxKgguO8Vl0o0fFmJYwKv7+vO06o8WH4Zwj84mI7
         ZPdQy9VJ6pijTInnNiQyonkXl2EX8hqsGT07yZjbzNuuY3YJa4y4VDMf0YpUPHAazcG3
         M5sjhCU6dqJiCElaUR1q70tLyJpwC70LWBUstp7tf0oI328msDCBgfYKlOclRCHL6Lid
         ZkAN7ZHEGXkyTLKTCLN8cg37ppEYObNkzYWrO9WQRTs3VORs4TSJnb9bjnDiUss2KADJ
         bPwhmaV3zHV9hjIWAn1XEBJWnJ8MiWdkWU3eB6BmNmOG0M48ZcHWRzOg0cWf0fhoqNH5
         NxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749838746; x=1750443546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7tkrgz83yLxxWDVBammUj3el4Pcyp+zXqZfIY/vHZ4=;
        b=mwRI6s6y54+qYXJrJeGBjDuAmv4GFEU1ixD8AHMJKb3KSCuVHe+3aGd5jnVT+fjMtT
         l0Lj+sptAYkaKmmyeY3ewI7GLzfWTkGU4VqNqHmpBosfA3QUeCB47Tw/jzI/UTI/alY5
         HbktzQ7y95j+dBefrSChag6N5GHZHVIPlYK0WOJownd9I2ULzKxHwUpy4HvZmA7tt+Cp
         5n/7ktHX2HlELPfsBQAf21V6e8uOYPUT3xI1XFp9WLEKGq5eosI0HkNkQ4xsZH35jCWe
         CsXgWRcNN1glEF3xSZDkjxRZSxnTF04QSMkql3H60rdhGBCdg4tRka6zeYtfn24H3JUr
         hUmw==
X-Forwarded-Encrypted: i=1; AJvYcCV3x2iAqzbImxlsu1W8B/TexCKUHZL+cA/oNtzDd+vO5IacjnxOHKYQH4qo+34DzwVMvOPFwYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wy7SePYW/HuiIjGoi2PTkUDsDYolvhEsp1zZLrz99/nrH2Gu
	YiKr4O6K6j1DyOD+C+eoKzxn/5mKNoD2HqhHKuCUfzk7zq9MZDq00cSqP+EN9FH3zt8lLw1ebuZ
	gXd2aXsuI2wAMOEZfHb4XbLWxh57HZTiU+FxZ
X-Gm-Gg: ASbGnctp+mhWAAO205rqnZ6d9P1Urb+wt0A9wKlriYqAnHnum4xNV7o0L3XVTb9jFXn
	Tf6Ub7sffJkvcAzx/8TF8HFE7uF9XxBbVFenof0RdxJv5ey3H+Pb45OvvXRp+65Lf+/MoosdFuR
	hFRJeUxC1FBjLuJHk4/fWIEmrS3vO5nfLPO9bxy5DVI3Y=
X-Google-Smtp-Source: AGHT+IG1iqj4pzgcoJGopWthu7HG5sxsfF+GXWIyCZwRa2DfMSLMzI0p5bnC+CeHVz0lg5RrCvxiZLjwsYsi686yD9I=
X-Received: by 2002:a17:902:fc4f:b0:235:f459:69c7 with SMTP id
 d9443c01a7336-2366b40b7ddmr6349005ad.52.1749838746323; Fri, 13 Jun 2025
 11:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
 <20250610172226.1470741-28-stephen.smalley.work@gmail.com> <20250613141525.GG414686@horms.kernel.org>
In-Reply-To: <20250613141525.GG414686@horms.kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 14:18:54 -0400
X-Gm-Features: AX0GCFtU9Bqi-dgV9nr1_lSZ9Eb2ka_01arQqBDbHwkdU7QtouYZvFVVodljpLo
Message-ID: <CAEjxPJ5cZB1zz3dCUz7ix-WW4P6Q7QaeE02TjcU6zg+SOg8KLA@mail.gmail.com>
Subject: Re: [PATCH v4 27/42] selinux: introduce task_obj_perm()
To: Simon Horman <horms@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:15=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Jun 10, 2025 at 01:21:58PM -0400, Stephen Smalley wrote:
> > Introduce task_obj_perm() for namespace-aware permission checking
> > between two tasks using the objective SID for both tasks and
> > without assuming that either task is current.
> >
> > Convert the permission checks of this form in the hook functions
> > to use this new helper.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> ...
>
> > +int task_obj_has_perm(const struct task_struct *s,
> > +                   const struct task_struct *t,
> > +                   u16 tclass, u32 requested,
> > +                   struct common_audit_data *ad)
> > +{
> > +     const struct cred *cred;
> > +     const struct task_security_struct *tsec;
> > +     struct selinux_state *state;
> > +     u32 ssid;
> > +     u32 tsid;
> > +     int rc;
> > +
> > +     state =3D current_selinux_state;
> > +     rcu_read_lock();
> > +     tsec =3D task_security(s);
> > +     if (tsec)
> > +             ssid =3D tsec->sid;
> > +     else
> > +             ssid =3D SECINITSID_UNLABELED;
>
> Hi Stephen,
>
> Above it is assumed that tsec may be NULL...
>
> > +     rcu_read_unlock();
> > +
> > +     do {
> > +             tsid =3D task_sid_obj_for_state(t, state);
> > +
> > +             rc =3D avc_has_perm(state, ssid, tsid, tclass, requested,=
 ad);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             cred =3D tsec->parent_cred;
>
> ... but here tsec is dereferenced without explicitly checking if it is no=
t
> NULL. I'm wondering if this is safe, e.g. due to the call to avc_has_perm=
().

No, you are correct - this is a bug. Thank you, fixed via
https://github.com/stephensmalley/selinux-kernel/commit/85e72ed549d01a2da40=
7feef6493cbdeca324f82
and will likely squash into this patch on next submission.

>
> Flagged by Smatch.
>
> > +             if (!cred)
> > +                     break;
> > +
> > +             rcu_read_lock();
> > +             tsec =3D selinux_cred(cred);
> > +             ssid =3D tsec->sid;
> > +             state =3D tsec->state;
> > +             rcu_read_unlock();
> > +     } while (cred);
> > +
> > +     return 0;
> > +}
>
> ...
