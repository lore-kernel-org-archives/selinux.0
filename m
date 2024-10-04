Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB071E376B
	for <selinux@vger.kernel.org>; Fri,  4 Oct 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061709; cv=none; b=mu0LsJP6ShdkCH9lks5W6LSIogKjlQeKyHFEoMf4AOyPqURbuRvz5SdPXEDqRirKajiiPA9B0EzyyQ3ZVTEQHR6HCmOFb/McI8H2iKKXIDpbBz+rCahNWlFaRHoHMv3Peg793f/oymJbj7aJfrBoEuZsL62zxay4Jtw71xkcFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061709; c=relaxed/simple;
	bh=ILTeDCqiYTWnEQBOrsOk2BwfEvMqfcW8UA9T/z6p4vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTRhZ1wmEpHYIBUW/CFP0EhvZ+6s31GlfbtYuWw1ks9plCd5NzyIFI7UHJa1EiX2Xk7DPzUVwX1Wnzi/s56xcL7eUMGL9EtqO0otFVVhetN0MBWr9Kq50K0qP2U9S0OQX6MegVqcvqMGSChk4AyoL0JDDMpGhAmK2lvkG5qi2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exzsHQrj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exzsHQrj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b9b35c7c3so24572495ad.3
        for <selinux@vger.kernel.org>; Fri, 04 Oct 2024 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728061707; x=1728666507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APiF9aGo/RduUyLCU/uJ2fepRidnSKbEb5W/hF1PJG4=;
        b=exzsHQrjPbDuQGkU4jfx9AkMhU5mW8ipPsWcWut7pV5W/Dxah9+rPYBafpPW9JQc1Y
         Xeo8zAZ/2o1WDp+q7f5C8sPcMW/JDKX9Ckn8gvsaS1HcOXPGMto8alpE4RkFD5iwdkDR
         ETFktY7aPm+gCpWz1OLAp6sFgDCrBfO1He9dfrYDNDHozM+KNQnGkhD/Sl3TsVKJeInu
         cMuMLC4n3eGz8x9mLB6mhOiAVDKT6y1pmFqgD73KxTyDt/aIs5I9xMKtq8wVm0hGlBE5
         F0jiwFAZAF6hOv749uH8eTpJXTUrtkhXYycHH4oBZdJt46HNwY/7g95GPaz2BoNwxDMl
         3/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061707; x=1728666507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APiF9aGo/RduUyLCU/uJ2fepRidnSKbEb5W/hF1PJG4=;
        b=UYp9iaYYpThWAetlnq8L7KGyAVqpw3LZu3yGcu3a2AcFp25bb5mHBQ/U1q6gy1g+U6
         PgdcoGxf3ttHByfb+EKx2LfsXY0dozGGSmpBw1/rZxWhzIXpUcSVtmkkCkXQTtVVykrH
         Hq6P+mrZ/vQiQZLmpzmnWfAuvl++xfNKCVCuwkcbCRj+xixe1IfdoI/KKYiCBkz0XPFD
         RWHQOLyGq2Ufybtg3o8ckCEWg7FdgCEFxcl3xt9stj545Vhn3NSKuHx7gpb5pZq5D37J
         j5xvOOcNu4RTpMg02lYBbXXXViVU7775drbSryE4YhDjh4QGGAEdDUgS8GgEMyMwgbcx
         xXxw==
X-Gm-Message-State: AOJu0YyGhFDk1sUt8jjdWgrI/PSkcccNGi99yQLTkZRkp3ffNmgF2xwo
	OsUmfdtLeYN8pkaYEobOzQXN45V1K5Oc/BOZBQo29H0rvS+eUuqlGVL5BVKdaa6RaB6oTmr5xLK
	5uc7ZyGXwLdncNVqRneWMlKK/MetYzg==
X-Google-Smtp-Source: AGHT+IGZic6k7Tv/fwnxPk2gm7nBODvRqXwEZ9N1zZ1wowh+9GqlAQbIPua2RDfRKBaTp49/28v7vFrDWIqlvy4WBco=
X-Received: by 2002:a17:902:ec90:b0:207:192f:fb9 with SMTP id
 d9443c01a7336-20bff1ea9d1mr43678435ad.60.1728061707042; Fri, 04 Oct 2024
 10:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155320.16629-1-stephen.smalley.work@gmail.com> <CAHC9VhRbamWqztn3NMxuiQ51S9sVvDw=oB0U6Znrw_mukFONAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRbamWqztn3NMxuiQ51S9sVvDw=oB0U6Znrw_mukFONAQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Oct 2024 13:08:15 -0400
Message-ID: <CAEjxPJ4o8zyhZHYB5xrNyrD-MK0qDY3j91u736QWRLVvpoSa2A@mail.gmail.com>
Subject: Re: [PATCH] selinux: Deprecate /sys/fs/selinux/user
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Oct 4, 2024 at 11:53=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The only known user of this interface was libselinux and its
> > internal usage of this interface for get_ordered_context_list(3)
> > was removed in Feb 2020, with a deprecation warning added to
> > security_compute_user(3) at the same time. Add a deprecation
> > warning to the kernel and schedule it for final removal in 2025.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  Documentation/ABI/obsolete/sysfs-selinux-user | 12 ++++++++++++
> >  security/selinux/selinuxfs.c                  |  4 ++++
> >  2 files changed, 16 insertions(+)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-user
> >
> > diff --git a/Documentation/ABI/obsolete/sysfs-selinux-user b/Documentat=
ion/ABI/obsolete/sysfs-selinux-user
> > new file mode 100644
> > index 000000000000..8ab7557f283f
> > --- /dev/null
> > +++ b/Documentation/ABI/obsolete/sysfs-selinux-user
> > @@ -0,0 +1,12 @@
> > +What:          /sys/fs/selinux/user
> > +Date:          April 2005 (predates git)
> > +KernelVersion: 2.6.12-rc2 (predates git)
> > +Contact:       selinux@vger.kernel.org
> > +Description:
> > +
> > +       The selinuxfs "user" node allows userspace to request a list
> > +       of security contexts that can be reached for a given SELinux
> > +       user from a given starting context. This was used by libselinux
> > +       when various login-style programs requested contexts for
> > +       users, but libselinux stopped using it in 2020.
> > +       Kernel support will be removed no sooner than Dec 2025.
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index e172f182b65c..8117d8f6ac2d 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1069,6 +1069,10 @@ static ssize_t sel_write_user(struct file *file,=
 char *buf, size_t size)
> >         int rc;
> >         u32 i, len, nsids;
> >
> > +       pr_warn_once("SELinux: %s (%d) wrote to /sys/fs/selinux/user! T=
his "
> > +               "will not be supported in the future; please update you=
r "
> > +               "userspace.\n", current->comm, current->pid);
>
> Since this could be triggered by multiple different applications, it
> is worth using pr_warn() so users have a better list of what
> applications are causing this notice?  I understand that there is a
> risk of log spam, but considering the limited use of this API it seems
> like this is a reasonable risk?

I'd be fine switching it to pr_warn(), but in reality, I think the
only direct user was libselinux, so that's the component that actually
needs to be updated if it triggers.
