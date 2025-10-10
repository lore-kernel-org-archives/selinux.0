Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E62FD1C2
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126017; cv=none; b=TDdrDVLS5U489O3j17+vfUhzMhNjrj29F3nZ04eDxil92SKdnuMVwHlkKl38KLleEJMsiQfvG8MiX9jk5KnHNq5l4l8AiHxhg8a5iEFWVRrVDuA3OOfQfqnv4gmamW5PX5UlC1XFQ/9H50sVREW6t02fEEE7r1K+FPDE6AFNJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126017; c=relaxed/simple;
	bh=N7gUJB6UefAW78mNbcInukbseR9n7I+KncrvoHMS0us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7PIlJ8MbHWaUJDWouSisCSpPZq+1qBcN5lp/Py2nex9f6xBjuADOXfye6wLCAWxf2q44P0pex6VdCZUaM9Q6YLfA+xmtSTe8qzTj7EvYumi9zbfu1n07PgVLmCvyaYMMDz9a2zPZ/7+X35bN/+fUUJJlbp0XlQNBHec3SV9HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZkN+2a4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZkN+2a4"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so2584296a91.2
        for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760126014; x=1760730814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qREn5zSA8jfbgBwqXnnzyX/we3/J+k2dWex/IpiZXwk=;
        b=CZkN+2a4j4APsTh+333fKguoEeFYTlMxKq8Oo1hbXKr7S4ReNGjZTcvi25I8Ex+qEA
         jw8aQztl80ETnSL7r6eB9fLADhlA3/C+kYMJiyAGt3sqKbXoTLkSvI4+s1PGB2g+iKtK
         0EiwCQZyrYxUnzcAzyMh6RLrkR1G5LFkx6ig7H5r3T2u3TVjxGA4jkScl/CUfe/10lKw
         9CCHJDAbZsn+31ZjA8z9go6zDafwdh91i09Qgz+YxIa5xDFUSDHyzpdDEgZ4QQcMdfYL
         Hkmzao8FJzmUjOFE/x9Ij966DRMTEI8TxB7IvZF9oscUceq48ABHTDZNZl8JcNzAuqDE
         hFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126014; x=1760730814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qREn5zSA8jfbgBwqXnnzyX/we3/J+k2dWex/IpiZXwk=;
        b=iV/vwLJAikt0OIPySPt3jWetKIfAJRj//vPl6XH58IEGo9WS/EVCoqLkqorvipjmXc
         ZPIr+pUNVvpMQy7XEWMdGj3hG+IyexwPdCOwtn9DG2j75Q31/+2+AjBI0WIkaS4ewQkD
         0u5SKE/3LFCE3vWH34wTw5Nl4t6p4qX9e/OcsdPCfy/QM2K8Jd57+R6+B2jCO1T5y2Oa
         YB0lPds3vANZd412snh1J+exH8ERXO4Jt1sf8YPL69MTWxqZdIp2LSY74N2IzX7FROhU
         Ok7yAubsGUgyZHU7Q1QpZGMoPXG+J5i8cDz960Q5wX1GDyhOmVlNnrCYpNjQ8BwfCwaa
         /Dyw==
X-Forwarded-Encrypted: i=1; AJvYcCXtHvkA4wFDaqEfHZh4YOPduFmrA9aYWcD0HPfRfVbnEuWeCqMpzj/b9DwxoNZ9YqSYWKVJ0IJr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93p+0jmIZ1UdOOeGAlfeJC4Tm73acJHE6Qiu9y3OtOYry0LZ2
	r0kD/KhkxYpHBEjBrsMN5jV/9EOjkzz8en0MgTaNokqqckm/454A8wwfig+95ZVjfoda8Uek5I2
	zfX/kqRC53LLXh7FKvxGSfVE2XCy7L3I=
X-Gm-Gg: ASbGnct7PUchbecoCSNTt2zWIyaxCsFQkilEc1Ihxw+EbeUHrOujHZXoll4QGD35crn
	ZtXdSMyOtOQJVQTYXFo51BMs+6sn76R48wazGRreQTsqaYOfNsSD+32o5u1lnorl58eFawg6rnJ
	ZGzdRHgD1x0TjRnwPPw2CzfBVf59C3qAe/C5WS0t8RCMnTkKNjG4QmSWa73ClVZE2oErtCqkGz4
	yVxemGH4bA9yWgzVVSqoMDIwfxgbEKY7zvb
X-Google-Smtp-Source: AGHT+IFz9AP73sRvYOkE9MyPCK7MNB3Y7fhi5pFDWGDyzMO++oyls7K5WL5aHFGzVG2njyYPIaL7D2b0DkmVxpndCr0=
X-Received: by 2002:a17:90b:4d0e:b0:32b:d089:5c12 with SMTP id
 98e67ed59e1d1-33b513eaaabmr17825823a91.33.1760126014434; Fri, 10 Oct 2025
 12:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com> <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
 <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com>
In-Reply-To: <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Oct 2025 15:53:23 -0400
X-Gm-Features: AS18NWAEPzo3JPjSpIHpxLuP9cGI0RMXW_8WdNQ9UmnQLyyl85BTRR5gTpK0B-Y
Message-ID: <CAEjxPJ5N+vGS4rhBJmCfoW+rUnjPm7TVAC9reRmu6YCaJWTO+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:09=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 10/9/2025 11:53 AM, Stephen Smalley wrote:
> > On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> Allow LSMs to request exclusive access to the netlabel facility.
> >> Provide mechanism for LSMs to determine if they have access to
> >> netlabel. Update the current users of netlabel, SELinux and Smack,
> >> to use and respect the exclusive use of netlabel.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >> diff --git a/security/security.c b/security/security.c
> >> index e59e3d403de6..9eca10844b56 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_=
blob_sizes *needed)
> >>                 else
> >>                         blob_sizes.lbs_secmark =3D true;
> >>         }
> >> +       if (needed->lbs_netlabel) {
> >> +               if (blob_sizes.lbs_netlabel)
> >> +                       needed->lbs_netlabel =3D false;
> >> +               else
> >> +                       blob_sizes.lbs_netlabel =3D true;
> >> +
> > Same principle here - if a LSM wants to use netlabel, it may want to
> > guarantee that it truly has exclusive access to it no matter what the
> > LSM order is.
>
> And if SELinux and Smack both shout "I gotta have it!" who wins?
> Does the system fail to boot? Do you assign it to the first requestor,
> as this patch does explicitly?
>
> If LSMs can't be equal in the eyes of the infrastructure, If one (e.g. SE=
Linux)
> always gets its way regardless of the end user intent, I have a problem w=
ith
> the whole thing.

End user intent is unlikely to be expressed as a silent side effect of
LSM order.
If a security module supports its use without the use of secmark
and/or netlabel and the end user wants to assign one or both to
another security module, that's fine.
But some security modules may not function correctly (or at all) if
secmark and/or netlabel are silently disabled on them, and the end
user needs a better way to express intent.
