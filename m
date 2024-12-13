Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929E1DA5F
	for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125314; cv=none; b=Qh15wdMMbBPE/vkRIqnZOM/tcZGME9cY5QuCkMiaELH9wNFIDVQl9evBJxMiMEDOx1Y/9fFfO6ka0nYYmi3dSyTCp76BcjYIrbq9Vv74kZkYXNmsVy9G3dCsqMP3+C84g6TX8/RuGrG/6/6QA/ALKLZxMgjOvD9Px0ItSUkuUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125314; c=relaxed/simple;
	bh=mgUHOw4mHNhIL5gu4l3xxzaToY58Z+uwXTGMoIUJA18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1wEt+U5S7jcLhhpmHftYmU06BqwfKZhlf8PB+LsjARZN55mK/VBRHoK0DPFEnEEDsV2k18Mt7mQFKdMPnaS/PSK0jAgNpZ/W4QgP/NCvWe/2g3HuLQYT5XEj5wpcwltt+5L0JJtqUhkeFtPisdeY6LifoxrhyRCfmpbJXLmum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GHkcxZND; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GHkcxZND"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7f8acc33so21670657b3.1
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734125311; x=1734730111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxZsrq84K3gHNbGEP9p8+F27iwh6s393FgVx6aY8wQQ=;
        b=GHkcxZND0I3S3Bkmp7vGeyciyiz/KAZZPOksj9+B+PdqPSGKOzPJHoN5VEOEUsACix
         gxQFB5Wm9at+qtijdEWUraDv7nJQyzRGk9JWb8bgAq+cbTSiCunerYQxac3QOMWjhtjM
         FCg8y1v4x+L4at0rE/ECC6wVpnlJZl78Kd2URIVTLjeXj89RF0+HOmXicuHK4m+2TWNC
         N+octy5Z/PKjdlP01I6ogvA4LXvuSFTUpYIEW9rskMXCA8XpvzA5P5BRcvvxdubEsBoO
         F+PjvFI5+812cKWyfFgh4HKuCsGvNZ24RWYecj9FYdlmXj+0OOFFgGIC9+lVMfmHTIwC
         Fnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125311; x=1734730111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxZsrq84K3gHNbGEP9p8+F27iwh6s393FgVx6aY8wQQ=;
        b=s/JsL6KjfCDj75xulmoVROjC0rc7VZetFuDC/cbU1xprEMvobbsct97cWB4+b+brSg
         gbQkI3CYf9zfWqmgG5ghxenmXC5Bunntrc1j4skqSw/K1nCYK+aND+Md4OpDr3MUuDR1
         twQNmpAG2ESHJK1accJqU2Lm8NM5rPSPHSVx0NgUV/JBUTvIVOM3h+kf2NZugdD81an+
         jDzU+0HSdEOmbdeuC+WSvqwTAqwgvIc7Xi0BMASfhODK8hg2VYmsha3SbLaaxV2GSfCY
         VdWn7mo9BGJUnF3SwiL+zVj7A4ckdV6KlNvhaFY6EMXpt0BS1UOhM3kK9Ma/M+AScLUd
         esCw==
X-Forwarded-Encrypted: i=1; AJvYcCXNwAO3Q6lM4klnfAbfOaXr0UuTkGa++xdpqvdUKJCBYHGkCok7jGTxbvyS60VbSwt3G62Aem1l@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWoAMiepOcxYkWk0wbuTpJMEViZW0uxJTqoswHtVQl3o3eEJf
	PGUkPGaWdl42Xp/CnAZF9y1C6DkNkHswGYHo5GGaO55w3Kamq1yN9qkuFcjyKzOLbUOXqCRmyhr
	uB0UHHfe8M8+1cRfORBvLgXjtLbfQqVaAkDuD
X-Gm-Gg: ASbGncuyxyvm35OmUa/hAFOa9QiZtxW0yn/+rRUS5jAIPfj1RUNiC2zpwhoNDh4z8Kb
	BXgbCEGx4s07t1IeXhVshcbE+uxiLW2rNkUBd
X-Google-Smtp-Source: AGHT+IG9+d1RzEx9NYI6fYxML3tKWcq20dqiyujbotSgEYi3QpyG0sSHXiR41aGR6mEdT/7IzmdXMOOsrsa9b1/8ed8=
X-Received: by 2002:a05:690c:63c8:b0:6ef:6536:bb8c with SMTP id
 00721157ae682-6f279b23731mr37283617b3.21.1734125311386; Fri, 13 Dec 2024
 13:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022223711.3066190-1-tweek@google.com> <0aa16dcb5d0708fb926d8e8128217205@paul-moore.com>
 <CA+zpnLd_TjPxXFz8Ek80-udQzx7xhEWxxryxFpXAD2hdw4wRkg@mail.gmail.com>
In-Reply-To: <CA+zpnLd_TjPxXFz8Ek80-udQzx7xhEWxxryxFpXAD2hdw4wRkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Dec 2024 16:28:20 -0500
Message-ID: <CAHC9VhQQN651Mwj07uoO5nbevWwBWwkMKp+uDsnx=JDTr5gB8g@mail.gmail.com>
Subject: Re: [PATCH] selinux: add netlink nlmsg_type audit message
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:08=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
> > On Oct 22, 2024 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek=
@google.com> wrote:

...

> > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > index 849e832719e2..b6544024f688 100644
> > > --- a/security/lsm_audit.c
> > > +++ b/security/lsm_audit.c
> > > @@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_b=
uffer *ab,
> > >       case LSM_AUDIT_DATA_ANONINODE:
> > >               audit_log_format(ab, " anonclass=3D%s", a->u.anonclass)=
;
> > >               break;
> > > +     case LSM_AUDIT_DATA_NLMSGTYPE:
> > > +             audit_log_format(ab, " nlmsg_type=3D%hu", a->u.nlmsg_ty=
pe);
> > > +             break;
> >
> > Based on the audit field dictionary, link below, it appears that netlin=
k
> > related fields follow the "nlnk-XXX" pattern, and while I don't recall
> > any current users in the kernel, it seems like sticking with that patte=
rn
> > is probably a good idea.  With that in mind, what do you think about
> > changing "nlmsg_type" into "nlnk-msgtype"?
>
>
> Thanks Paul, I wasn't aware of this list. I found one example of a
> netlink field in kernel/audit.c (function audit_log_multicast), which
> was added in commit 9d2161bed4e39. The field is 'nl-mcgrp'. The name
> was changed from nlnk-grp between v4 and v5 of the patch, but I can't
> seem to find the reasoning.

I suspect there was a concern about the size of the record.  There are
some audit folks that are extremely sensitive about audit record sizes
due to heavy logging, processing, and retention issues.  I'm not
overly convinced that a few bytes in an infrequent record are that big
of a deal, but who knows ...

The bigger issue is that we have some actual precedence in the code
for using "nl-XXX", which seems as good a reason as any to use
"nl-msgtype".

> Do you know if 'nlnk-fam' and 'nlnk-pid' were deprecated/removed at some =
point?

I can't say for certain without really digging through the git
history.  For whatever it is worth, I just did a quick search for
"nlnk" in the 'git log -p kernel/audit.c' and didn't see anything.

> I don't mind either way. If you think 'nlnk-msgtype' (or 'nl-msgtype')
> is more consistent with the other audit fields, I'm happy to send an
> updated version.

Based on what you found, I think "nl-msgtype" is the right answer,
I'll follow up on your v2 patch posting.

--=20
paul-moore.com
