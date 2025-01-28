Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817821DB361
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080542; cv=none; b=kdkC5FEQM+py9vB7GGPurksMwjhMhnD4B5h5ydjRvJFyZnk8p52HoNddAQj76aXNW2rcuFVpFlDiTrEaPPsSL4naHfecU+V6rxF0q13y6zhXNQiWiaf/f66AXdcNfd4ViVQJq5hocnY+OqB7a9wJUoyWa0wNnXNwOsjVZXdb46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080542; c=relaxed/simple;
	bh=Dn0P45VrKtJdMb5KPwpO/NtVS716d73WlS+6htsC3M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVEPjAJQtSonuQNdPlUpq4Na5AQo9J8DW+pz2XTIZxpufLSAM56o4tVzIyn7k1wgcZaRy5UwBnBj4aUpHsQjZy9wzKpB4HXAcvi01rtsCl/bopfazn/Xn7vnxyYwMHRfH9FnM3v5wIucb3dJTZhfwWJXtZv8NTfZkFKfC7iMfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f9QMIkQB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f9QMIkQB"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5773c5901aso11082086276.1
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 08:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738080539; x=1738685339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPuvl94gfBPCbR4KZpc49Kx/KlsgzgdO3rR7H34hrp0=;
        b=f9QMIkQBg2gyT2laHiH2ElTV/E6ZkgCG/Vbn88nt/DNEebNclDyhcFwWD8KrU/yPl2
         TcHF4j8xMXdGMv8JGJLypCRNM1ijJAg6Os5gXT56eSn8t9hJOs6zfOfZxj1oQ1ZJqFct
         WOIjFFrFQ1JnYHPvgxTy05REPIsxG7gdXwLG7gEI2kBZC1Z+cvO6+L1uWemZTflyk2ms
         8lX2GJNtdpywrnJkwK2ezqy+CVLcJh261nIpUOV8xD0SId04lGFtSrwg2eIMAGW+EsYH
         YiEJBhewJ1rqQwKY8WbZref+vzI8wZge/gf5EUvRbPz+dnKheD9yedf3s1+zLmg9ok78
         I7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738080539; x=1738685339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPuvl94gfBPCbR4KZpc49Kx/KlsgzgdO3rR7H34hrp0=;
        b=GGfCx+uHpiI0c4xZktwdvN1TmTU2MTqvoJVIbI9l0Jhewz6rPYYaQtDMuBSin0DhSG
         iFu9nvCLu2PlSB/hNTjdRXmgKzZx/Z39dA0tgu1uxn+O/SNS8i89UyTi856G7se+qz3U
         CXxQjZH/iLmYdifrwt/hgve/6OOEgsS2l8Sw9BklUOFJe1HpsWeQjinTN6YVh/+l0MOA
         XTPATQSe2P1htuasET8sjMnJvQYGZ3xSwmpUt353kV059zjWycHV+xfZjDwe88+L2Za3
         FSndvMeQXPV2uD+c80+cMJSfisKTFaYxL+V5I4e4rOfOtd830b9i/ENoZ/pKYi3nVysu
         /eKg==
X-Gm-Message-State: AOJu0YxyOsR73uVDh8itdBLytXjxiKL0bAFJRn1qoLkqDrRUmVID5lJN
	jZ/ZI7b/j8p0mJh6GDV0athtNLXRbValHbX9ppJ+Y7Yde/NRI2VVslDjiKzBc1TLaW5v+WStio0
	LdFOphwMzj3IZBoqI1RolOFUugG0F9a5Pqg8FChnr+2/0r6o=
X-Gm-Gg: ASbGncsIbsPE2eYfuRHYsBqJCOKOL2QoFEmH+jQCZFP/cItfRf/TGJejXGbSO9Bkk8R
	7lR19gLJJn4kTndjZgsUVyu2U4gQQ8kBsrFC+TlX67xWERb36l2VFcIczIBzvwDMsBf/Mugul7B
	/HHwCOmQ==
X-Google-Smtp-Source: AGHT+IED/Gbba9B7p/2hFPyhtW0fOM2RLr2wPghcCKJ4pIetyeP13UWaaS6GHk0rqv5KsjZcmPRzrGprGQmNMQgyzR0=
X-Received: by 2002:a05:690c:6483:b0:6e2:fcb5:52fa with SMTP id
 00721157ae682-6f79769a31cmr30457447b3.9.1738080539421; Tue, 28 Jan 2025
 08:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com>
 <CAEjxPJ6OrkBiw8yAzpV6_B7a5kusTYHgvGs=H_f-qZhNRNR-dg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6OrkBiw8yAzpV6_B7a5kusTYHgvGs=H_f-qZhNRNR-dg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jan 2025 11:08:48 -0500
X-Gm-Features: AWEUYZntZh1rQ4aAcMTn9BWT81e46OyE1Im3MluLx2BVhLwcxqq99uCDHDpaPq4
Message-ID: <CAHC9VhRj4CWBbSCEiznjNh_WaHr2vEGB-_Xem=VqRyptR=MtGw@mail.gmail.com>
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
To: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jan 28, 2025 at 10:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> >
> > Hello everyone,
> >
> > In a recent commit [1] that has already made it into the coreutils
> > package in Fedora Rawhide, ls changed the way it retrieves security
> > labels from files, which causes the SELinux label not to be displayed
> > with -Z for some files. It seems that the key difference is that it
> > now relies on the result of llistxattr(2) to determine if the label
> > should be retrieved and if security.selinux is not listed, it just
> > prints ? as if the file had no label. On some inodes on some
> > filesystems (e.g. the root inode on tmpfs or most sysfs inodes),
> > however, security.selinux is not currently returned in *listxattr(2),
> > so the labels are not shown even though they are there (and would be
> > returned in a *getxattr(2) call).
> >
> > We can of course ask coreutils to go back to fetching the label
> > unconditionally, but perhaps we should also/instead fix the
> > *listxattr(2) output to be correct? IIUC, in some cases it's a matter
> > of adding a security_inode_init_security() call, while other ones may
> > need a hook for listxattr that would inject the security.selinux entry
> > when it's not returned by the filesystem already.
> >
> > [1] https://git.savannah.gnu.org/cgit/coreutils.git/commit/?id=3D4ce432=
ad8738387f1b2e80e883dc7080df3afabe
>
> There may be other side effects of that commit, e.g. loss of context
> translation if using mcstrans or equivalent.

Out of curiosity, do we have any idea of the motivation behind that
change?  The commit description is poorly formatted, but it looks like
a number of changes that are only loosely related around xattrs with
the only motivation appearing to be in the subject: "use fewer
xattr-related syscalls".

Regardless, I think Stephen has a good point with the potential for a
loss of translation surprising some users.

> WRT to returning security.selinux, selinux_inode_listsecurity()
> already includes the SELinux xattr name so that should already be
> returned,
> unless the filesystem implements its own listxattr handler for
> security.* _and_ doesn't include the SELinux one.

I can't think of a good reason why we would ever want the *listxattr()
syscalls to not provide security.selinux, if there is an individual
filesystem that is different/broken in this regard it should be
treated as a BUG and fixed.

--=20
paul-moore.com
