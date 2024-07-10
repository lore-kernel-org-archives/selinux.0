Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE79193445
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625382; cv=none; b=PadCyb1RRWDwTt0WWGEeRQQMqb2ZcLlevH6b9185k3iZwkXMn+mGquBcjOYznkOna4ShQqPmxS5zjc3++UrcX1hNi/oTd/Ycpcrw50KQzsGzQwZqpP9Bt6Vqw/Yh/MWhkTqx/goy0O3bX4u9cns9Z3uxannpAIiCYpUXs4GgcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625382; c=relaxed/simple;
	bh=ZInLfOT8kWBc+GRd1ACZL2Wojvr8QcxIcD6yNNhBack=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEBpaeggIOdImQTN38qLDq5nTYINqaItyWQFGRFJozU6eO/N1lxugIKz0LO9JYlf1h8syrDJhQA19yUkZQao/fzegPY9I0swUt0If8jMhQ/6C2f06myBVngQrMDOXxdjLC0cEkw3TSDZd2KwrsD38f63dUeV4wrzIlnr7Gf7mEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nwo2s+tX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nwo2s+tX"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64e81cd12cdso8904847b3.0
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720625379; x=1721230179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbqzCfIiLO2wCE+BBhxqQ3T6m0DjUxkfqYHKCkxJcmA=;
        b=Nwo2s+tXQWPK1Q9cfhLXmUpfqaiwLKPwtNtbrnONOyummNmTZ2nUoTaaNh38ymDH2E
         aM1b6CpFPblc8XpRHPXeB8VokNhc0se1hw4dBdmjXT5Yiu+NHpxuLjtYEPeR3uxP1+oC
         eWMrIPFPc3khks6S35e41o+7E7NVrCyIeRvWuSQM1TZ/GaHQ/Fez8SLgIMjKGF/kIZ3V
         ygN4o7eADhnnHJQzxAyCvc0JpqHxswcIDYBepcFLwha7YxJhbOH/lh/RVgsBleUkpA3x
         9QL39OuJLv6OGKYMUvKDU34KCMaCx8UWVWzojhf05/JAms29sZhiZgJeBuU5em/CiHXK
         wbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625379; x=1721230179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbqzCfIiLO2wCE+BBhxqQ3T6m0DjUxkfqYHKCkxJcmA=;
        b=LyLCW75bWmwe0mcpw6d7eOci9T6vcma8TprMkg2B9mar3Ww89gajBcw5RbO4ic+dT1
         eujvBbZ8FWFeyy/g5R+pPRqY8dTLzJcGi0aCKMmhyhOZf4cMI0VxMY+EGT9bPiM76K+I
         21CDiRhNNJiF7FshIsBtRavGjCcCy2gs4mR68nn+4HrVHpg/YNF0z0Ue/sSnDsvdXP6D
         +REaGkgTZRQvLgm1wieu6CkDpKuPxmLn/lkVsR5XgzfhSX5Z3w33VxyKQTAF0GM4ONff
         bTUbqEPgHBCrXbo0O5UXiJmZ6Umz2H0MO2EvMM2nOfWgR5wSvj1XLB4hBczz22faVRKB
         X9sg==
X-Forwarded-Encrypted: i=1; AJvYcCVNJm+3f38MYio2YHrzhtA2A1a1S6a8yeXWBWUtCAlsJ2ViR1RPl1SExR17vuwY6DA2E1v6ODg3VPV7OVQB1Nd7aeHQS6HH0Q==
X-Gm-Message-State: AOJu0Yw+spwjXNSnH+nb2VQlorCBI5QIWYHL5Pg1fPExlfy7JlUAVp8D
	w/K+MHCExCqmJO+xJF3MkXIkNl00GfjOIfIakR17Z9Enu4HySzP/upbRn+ET9pDtgm00t6Nq0vP
	XNeIYWIWxPp69D1ENqyxBH2nJgW79qs6yAkAl2ayX9CO5K44=
X-Google-Smtp-Source: AGHT+IGYNOO8/Tad0ekmbC9vCiT/wf5Jo+yXkOE+s9USn5cj1z9wkykV20u2u+kEtiAm1OGxT7AfUyHF2zRm2lKoeMc=
X-Received: by 2002:a0d:c081:0:b0:618:691b:d261 with SMTP id
 00721157ae682-65ca1b2f566mr36157b3.13.1720625379351; Wed, 10 Jul 2024
 08:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v81d74pj.fsf@redhat.com> <CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 11:29:28 -0400
Message-ID: <CAHC9VhRJ8CLD7ifENG2dC6wYtXBujc9UY=WKmXx3u0-HyTx-mg@mail.gmail.com>
Subject: Re: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Hello,
> >
> > this is originally reported at
> > https://github.com/SELinuxProject/selinux/issues/437
> >
> > There a question why kernel blocks changing SELinux label to some
> > unknown label and requires CAP_MAC_ADMIN even in permissive mode?
> >
> > Reproducer:
> >
> > $ id -u
> > 1000
> >
> > $ getenforce
> > Permissive
> >
> > $ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/syste=
md/system-generators/systemd-ssh-generator
> >
> > $ chcon -t selinux_unknown_type_t /var/lib/mock/fedora-rawhide-x86_64/r=
oot/usr/lib/systemd/system-generators/systemd-ssh-generator
> > chcon: failed to change context of '/var/lib/mock/fedora-rawhide-x86_64=
/root/usr/lib/systemd/system-generators/systemd-ssh-generator' to =E2=80=98=
system_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Invalid argument
> >
> >
> > Quotes from the issue:
> >
> > This is happening on a system with SELinux in permissive mode. Applying
> > your suggestion does not change the result. I assume this is gated
> > behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
> > this work without needing root privileges?
> >
> > Hmm so the kernel blocks unknown labels unless the user has
> > CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for a
> > good reason and it would be unsafe to allow any user to do this so I
> > don't think there's anything that can be done here
> >
> > One thing that's not clear to me, why is an unprivileged user allowed t=
o
> > write labels known by the host but not labels that are not known to the
> > host? What specifically is unsafe about unknown labels that's not an
> > issue with known labels?
>
> With SELinux disabled, setting of security.* xattrs at all is gated by
> CAP_SYS_ADMIN.
> With SELinux enabled, the security.selinux xattrs can be set to valid
> security contexts without any capability if allowed by policy.
> Support for setting unknown security contexts was a later addition to
> SELinux for a specific use case (original motivation provided by Red
> Hat was to permit rpm to set contexts on files unpacked from a package
> before it inserted the corresponding policy module from %post), and
> was not expected to be used by unprivileged users.
> Smack had already introduced CAP_MAC_ADMIN at that point, and it
> seemed reasonable to use it for this purpose, since setting labels
> unknown to the policy is effectively like being the admin of the MAC
> policy.
> The policy can't make useful determinations about what to do with
> unknown labels so it can't provide any information flow guarantees.
> There may also have been a concern about the facility being abused to
> push arbitrary data into a security.selinux xattr to be fetched by
> some other privileged process later in a manner that would ultimately
> lead to a vulnerability.
> Not saying that we can't change things here, but would require a
> graceful and compatible transition path.

FWIW, we would also need to see a very compelling reason with broad
reach that doesn't have a good workaround before we consider changing
the current behavior.  The scenario described in the original GH issue
is interesting, but my suspicion is that it is fairly limited.

--=20
paul-moore.com
