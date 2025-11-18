Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1D36826E
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480868; cv=none; b=kUoq7p96Q/1utB6CAqPO9Sl5rypNAs7oxmKy4PRNVF4sbn5nbPv0iivg8BbiZfgAuGMJ8F3BITamplVf218YHCnRPZ/JkO0ZJkh/HFsEMfqywhtRh/g/PtUSJWtE/NvOYIsieRZzeMfBhCqhnC+LP7rHduxAsXlEUod5eerJ0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480868; c=relaxed/simple;
	bh=vD5he4CSabHU4RLphMcD7hzDMqmfYRGPXMlzjszFF9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlZ79wfhevfNU/9RDAhpX0Yji1jWqdquoWmuK6Wv2mPqNR8aGUcntGliElcInO0LdhC2uaJdj6fVyDRQLLkKsa/yAs0sq/Yg/aqUFl3YZJWWKGW0rXDNroT11yyCgP9VUx0HgE067boTQRvUy2/7OanlpgHNHi5hO9b2QXZsuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bgIzkoHa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bgIzkoHa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2984dfae043so54062585ad.0
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763480866; x=1764085666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBLhDXq2b4Uq4vD2wbpAY57BCUq0jMCKIILSPfNe/0k=;
        b=bgIzkoHaVvxHrkFmwzbQ8QzsRBPi77hA4etnUDSYeh40OKEnKQIdcm9Axu4oQqz2JQ
         oX/yPkQ8cJ3Vb5W6C8gTgemB+73TSaC0Ovd2ZFRmuin5apdbQ0qX2p9Y/Mx86jmTBU2t
         o2Pz4Sa+bNyIvYhkhi85IDwtMBwZI/HuBGhPQi2zrBueopndD0vyGE8YSnIErlvIqh3k
         7l3CXQpHeyFOQJQ1dLiTaTw+CTNlg6RknNrMVnhceKf77d+IdSpKJ4kSn/rNoquCsHCO
         9dnbtyJzyvRe094Gm86Kfy0e10K+0uTnB6jmcEj5hxprx/b5yf94HHK9w71dGIfedZDL
         IvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480866; x=1764085666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBLhDXq2b4Uq4vD2wbpAY57BCUq0jMCKIILSPfNe/0k=;
        b=MJEIxLdpgc/DptPSZKtjHTU4kp/w4kFxYvMwJ1DNDloyAX1i47C9xrSQlL7xilgAYJ
         DHeCv5sKiC5LIytTb9ZuguseHUBdyiKSxEypJBeJ5axrnBElgR5JI3INveYhXvb0qBeN
         8ZUBAfKo6wYFGqEarfTJejIi0mHyQLTIiUKBtRbmPHj5+dMecK20HC0NpzgUfWtA5kBV
         jZHmGB+tkrvLDMP4ic9mHVTWAHfynImuHEOWpnuIsD7bJMJ8rrM1B3xudgLx/KJoNVm4
         pyzZZTmBQYtGf55RXSkdP1SE3WJvnTwjzVYVcUtukJtVaNbWOjA4IJHLGzf0UcyaxIcY
         HKdg==
X-Gm-Message-State: AOJu0YxRTn2KFObLKRLD/orAOM9lzFdvbrXROWjqED4VECXLRJoJl+6x
	osFJgzF/myAWg7bgYrLGZjS3AqL0hAXyoz3jOuyPGrsnZEXrgtOhJFpzn2+w8Zcs0p5nZ5xrPQX
	dut4U6sCLGrEr7tm/CnIy5T6MxcN3/DQHHXo1nMK5RmmL1BzVLPQ=
X-Gm-Gg: ASbGncutTqBxQarFQOmSQlm1468jmJsENpnNsdbQkNXqxOnBc4Yf3d7zBYBA4sPHJxB
	s2Ws+HvqRxDk7JY94jaYaNjmGRosS45rx23bC8+FEM36/688OTsc4uecPfh8FGHULVteNgQR4Gp
	XkhEvM0vZtBmwC0hp3+YBq/yOzbR0HLLiNRvLf9R1GXa1RHUuVu0/eTfQ5twRtMVju+kbKLXBwx
	rkU5U5LVmgair0k3cHeVsol6bKuOeqXDnxXgdsVy3dNX9PSmzcDMNClvJKMD4YaFWdd6w45BjQJ
	80o8pA==
X-Google-Smtp-Source: AGHT+IG8FbAUT6F5Mhn39bu7I383ezv5GsDNIGwSG3usc5OWsmgYiVkHQ10cUsGOpIFy8eMsNBxr37Pts6h4iHL3EpM=
X-Received: by 2002:a17:90b:4d0c:b0:343:6108:1712 with SMTP id
 98e67ed59e1d1-343fa52879fmr19428715a91.18.1763480866012; Tue, 18 Nov 2025
 07:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTponNBYJ=YEE447XKSLrHc8kKwVBxMuiQPNrzjKZ=GXA@mail.gmail.com>
 <CAEjxPJ5=GJ5aTxk2xTAiLCiJc41RMo2Wtfp4VJ1XBAdzzEGW6Q@mail.gmail.com>
 <CAHC9VhRtgQkvpY=Sa+4VNtg6PRnVVEBNLk+Q3FoWoSApqWjHYg@mail.gmail.com> <CAEjxPJ6hFwZBW=WBUmubhSzjyna7XAQUdTvMCnPDaZ0a2HyN7w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6hFwZBW=WBUmubhSzjyna7XAQUdTvMCnPDaZ0a2HyN7w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Nov 2025 10:47:33 -0500
X-Gm-Features: AWmQ_blCfS0yQuwAh8GDSMKwawUJYs0F4UeGFjPAscbKunDAo9seCS9TE87x0bI
Message-ID: <CAHC9VhTC0h-3yOPeGpeRBTMkfR-MSU89zWm64qqw4rQ4yAjM+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: move avdcache to per-task security blob
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Nov 17, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Nov 17, 2025 at 4:26=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Mon, Nov 17, 2025 at 2:55=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 12:45=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > The SELinux task_security_struct was originally per-task but late=
r
> > > > > migrated to per-cred when creds were first introduced to Linux. T=
he
> > > > > avdcache was meant to be per-task rather than per-cred; move it t=
o a
> > > > > new task_selinux_struct that is allocated per-task.
> > > > >
> > > > > Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce=
 path walk overhead")
> > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > ---
> > > > >  security/selinux/hooks.c          | 35 +++++++++++++++++++------=
------
> > > > >  security/selinux/include/objsec.h | 13 ++++++++++--
> > > > >  2 files changed, 33 insertions(+), 15 deletions(-)
> > > >
> > > > Apologies for the delay, I was away the past few days.
> > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index a22b1920242f..0eea43e4a90c 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -212,11 +212,15 @@ static int selinux_lsm_notifier_avc_callbac=
k(u32 event)
> > > > >  static void cred_init_security(void)
> > > > >  {
> > > > >         struct task_security_struct *tsec;
> > > > > +       struct task_selinux_struct *tsel;
> > > >
> > > > I know we had a brief discussion about this off-list before you pos=
ted
> > > > the patchset and I asked you to move the task/cred renaming patch
> > > > after this one, but looking at the results in cred_init_security() =
I'm
> > > > regretting that comment; the naming is just too ugly otherwise.
> > >
> > > I'm not 100% sure that setting avdcache.sid in cred_init_security() i=
s
> > > even necessary since it should be set whenever the avdcache is first
> > > populated and there is nothing else being initialized in the avdcache=
.
> > > So if that's the only ugly part we could just drop it. I only include=
d
> > > it since it was being done previously. It wasn't in my original
> > > patches.
> > >
> > > > As this patch shuffling is my fault, I'll go ahead and re-arrange t=
hem
> > > > and follow up with a reply when they are in the stable-6.18 tree so
> > > > you can verify everything is still okay with you.
> > >
> > > In that case I'd be inclined to revert to the original patches since
> > > they are already ordered correctly and they don't introduce the extra
> > > task_selinux_struct name since it isn't needed.
> >
> > I'd want to go back and look at those patches again, but I don't
> > recall anything jumping out at me during the quick review.  I did just
> > check and they do have your sign-off, do you have a problem if I merge
> > those (adding the fixes tag, etc.)?  I'll resend them to the list
> > simply so we have a record of that beyond just the git repo.  Or did
> > you want to change anything in there first?
>
> That's fine with me.

Okay, expect that later today.

--=20
paul-moore.com
