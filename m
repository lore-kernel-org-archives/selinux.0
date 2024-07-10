Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C2194C69
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639755; cv=none; b=evZBVx9UPw1t3kPPVGp8XngmDq/TaFvW2pRoyaErACPNEoo35wqWbvd3ED5edlxZC73UsUg9GrYltzO2t1tfTKm8b5OtQ60X2GTXEquE52DNDCgM0Hk0hb1pG0kDYgragT2eW7/YpuupfQUZGs5ZNMgz2Yh2EWext/dWmMO9zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639755; c=relaxed/simple;
	bh=mjI62wa942qWXoEbLEv2B4Ckp+RThuq0BAl0104noeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f53bRV8sMqGy48u0dgPD91TFAuK/AcVmj2or12QRUmzkcNdq0d50vK6/T5Lv4Z8LffM9OpyniuETCgacU/wWdXpC228OpFaYPZNKeK8omEmJj5U38sxVUKPgBKMDXURiSOqqpcmbWHdM2Hgbjx+VNzEP3J0o3eEx6Tll8Av2guM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxjUjCq4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxjUjCq4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb0d88fd25so1353045ad.0
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720639754; x=1721244554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjI62wa942qWXoEbLEv2B4Ckp+RThuq0BAl0104noeY=;
        b=JxjUjCq40rumGQ7+1dCm6EKSy0sCnmnXWCuMm5fvreV5nq3a5y5qWQLuGKd5OGujwL
         iS8Riy+xCdjQhpnH8ovwU191RLSg0o9IFIBZGdInYhgDXpKYd39+BX9SGGrrSfwrWMPQ
         Nvf4IawCeMQ/IcvrQCkh3TNADfqM1WrOyJgaADmt13NAQwfGt9WFTwwm2sx8pZDXQPI2
         crSeS4zLScC4p3YB4SpfXpk0ZSuqvaryzkWzDnOFbFuVUOjr7RCvMOaOTdcuYpRxHqPG
         MHwzCR7CWH9l1Ifacg3KWPk+uRRcFlBkI0mcJkEQM1vdD5vTJ+1QjyC9KKlbZ1b8fM4H
         xRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639754; x=1721244554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjI62wa942qWXoEbLEv2B4Ckp+RThuq0BAl0104noeY=;
        b=lkzRnRHgUIC0gyEqhZ/LFoCqbDbIzQbYVe81K/LaD1waOdjzm7B4gA87FzXxuuKfFG
         tFSVCoTrFOUZQbVTJ2fgIqttn9WkM4+/d5VWGNnUhVVn4k+P/a2JquS05eVQOf8Du5UN
         1grKNSfJi7EL+3XDNnZzJPvPtRrT90f2C0Vy4I8RQkNR+HE3sjGpbYVV58OR3nS/IUWj
         XSpsU3QwcTFZqR40inkchJa/ZJM4PQBoowzpO7sw1mVzfxj8TnSW03xyHFzhpia2ffTv
         jUXSyRpsDBu+QGLhlApBkMHWpslmG3t/7TZHwU23AFwnEzD8DFZS65MiggnbK97W/CT7
         NAbg==
X-Forwarded-Encrypted: i=1; AJvYcCWV3uyuEj4wPFQA6ZWgXiF93jDFpfVwtNU4EaXh9EMgtn3ZDahvNeP8BCH1ZkFw5L19edxlta09++9Zmn8VCG7TVbZSabYMAg==
X-Gm-Message-State: AOJu0YzzkReEHe+ITdIxumXIV4GvB+HfmiQvcpgy2rmFxuhmVpGlsHyo
	4ayrukdf3bb5serNKX4Ag+zwaxcaq6NIJxNYh8rhgroCOUlYBtVneHMF3n511ls4fl8Ei/Vz2CB
	zExieu3n1uA5Z80EeZCsQUc2wooc=
X-Google-Smtp-Source: AGHT+IEx5kCmwWPayNHRYXCJ0pAL67qTI8qJamCCNI5HIKOt49LETSdZCu0vMYPQu/zn9k05kYIkSE3kbdPMWL9nLj0=
X-Received: by 2002:a17:902:ce0d:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-1fbdba5fea1mr8486925ad.28.1720639753545; Wed, 10 Jul 2024
 12:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v81d74pj.fsf@redhat.com> <CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
 <871q41jgb9.fsf@defensec.nl>
In-Reply-To: <871q41jgb9.fsf@defensec.nl>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Jul 2024 15:29:02 -0400
Message-ID: <CAEjxPJ4mQjwsp1KydTEc+Ot7=eFHnwUUmk2t2mSnXTHS0Vt0Vw@mail.gmail.com>
Subject: Re: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:40=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> >>
> >> Hello,
> >>
> >> this is originally reported at
> >> https://github.com/SELinuxProject/selinux/issues/437
> >>
> >> There a question why kernel blocks changing SELinux label to some
> >> unknown label and requires CAP_MAC_ADMIN even in permissive mode?
> >>
> >> Reproducer:
> >>
> >> $ id -u
> >> 1000
> >>
> >> $ getenforce
> >> Permissive
> >>
> >> $ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/syst=
emd/system-generators/systemd-ssh-generator
> >>
> >> $ chcon -t selinux_unknown_type_t /var/lib/mock/fedora-rawhide-x86_64/=
root/usr/lib/systemd/system-generators/systemd-ssh-generator
> >> chcon: failed to change context of
> >> '/var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/systemd/system-gener=
ators/systemd-ssh-generator'
> >> to =E2=80=98system_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Inva=
lid argument
> >>
> >>
> >> Quotes from the issue:
> >>
> >> This is happening on a system with SELinux in permissive mode. Applyin=
g
> >> your suggestion does not change the result. I assume this is gated
> >> behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
> >> this work without needing root privileges?
> >>
> >> Hmm so the kernel blocks unknown labels unless the user has
> >> CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for =
a
> >> good reason and it would be unsafe to allow any user to do this so I
> >> don't think there's anything that can be done here
> >>
> >> One thing that's not clear to me, why is an unprivileged user allowed =
to
> >> write labels known by the host but not labels that are not known to th=
e
> >> host? What specifically is unsafe about unknown labels that's not an
> >> issue with known labels?
> >
> > With SELinux disabled, setting of security.* xattrs at all is gated by
> > CAP_SYS_ADMIN.
> > With SELinux enabled, the security.selinux xattrs can be set to valid
> > security contexts without any capability if allowed by policy.
> > Support for setting unknown security contexts was a later addition to
> > SELinux for a specific use case (original motivation provided by Red
> > Hat was to permit rpm to set contexts on files unpacked from a package
> > before it inserted the corresponding policy module from %post), and
> > was not expected to be used by unprivileged users.
> > Smack had already introduced CAP_MAC_ADMIN at that point, and it
> > seemed reasonable to use it for this purpose, since setting labels
> > unknown to the policy is effectively like being the admin of the MAC
> > policy.
> > The policy can't make useful determinations about what to do with
> > unknown labels so it can't provide any information flow guarantees.
> > There may also have been a concern about the facility being abused to
> > push arbitrary data into a security.selinux xattr to be fetched by
> > some other privileged process later in a manner that would ultimately
> > lead to a vulnerability.
> > Not saying that we can't change things here, but would require a
> > graceful and compatible transition path.
> >
>
> The use-case for this is livecd/usb creation. For example creating an
> MLS livecd/usb on a non-MLS host.

I'm fairly sure that people have been using the unknown label support
for livecd creation successfully for quite some time. Have they just
been doing it with CAP_MAC_ADMIN enabled or otherwise as root?

> I also hit this issue on policy-developement as I am also a user of the
> mkosi tool that is referenced in the issue.
>
> mkosi is a tool that can build a source and boot an image using that
> source. If I add some module to my policy source tree and I want to test
> that in a virtual machine then I would run mkosi on the source.
>
> mkosi is not allowed to use the label that is unknown on the host on the
> filesystem. So the file ends up unlabeled in the virtual machine. So
> using mkosi for testing policy is not useful unless you run mkosi as
> root. Which is fair to be honest. There is quite a bit of functionality
> in mkosi that only works if you run it as root.

Yes, I'm not sure if this is a compelling example. For Android I just
built the support for labeling files into the filesystem image
generation tools themselves so that it could produce a fully labeled
filesystem without ever needing to mount it on the host. I think the
Yocto meta-selinux tooling also migrated toward that kind of an
approach, although I could be wrong.
