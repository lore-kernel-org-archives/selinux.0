Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B41CCB26
	for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341063; cv=none; b=ksYBmzYE+daCM/M8EtMup84TM5hBPpMlyiAumZ7BT3M6Uam5FTAW9Vz7MBLukcn0e487fAH9HILD2inaICmL5N/FsgQgisTDldlx+f43d2HfTkKSvMVMFnlPUXvPg79cgQdnE6sAen3C1UgezFukPcZEY/3TZ/jia3/Em5xBU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341063; c=relaxed/simple;
	bh=GR2YEdUZvI41rz3BDNTbJV751JnH4gaJfDNWGJ+l5WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3naPCTHuWK1vGsN8lRFmsqXkAmqjMZP7SbdAWlUwc9Zrmo6/LhVpBm43rE9Gul5RD8S+2ltWmFHzhPACYf5S/XDixknJOMXWayKxLrGJUBdbP9DUp8G/kc1F249Ja4uN/fP+U9wY78g4xCnRO/jQFBUND/nFFMQSWy3QQFcaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juDn2WPG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juDn2WPG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso729977a91.1
        for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724341061; x=1724945861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR2YEdUZvI41rz3BDNTbJV751JnH4gaJfDNWGJ+l5WE=;
        b=juDn2WPGyz6+FjlR05tI04Iv+mXtg5hsbVzTLpl/hQoCJokGnLoia+crHsWsmCxRcR
         hWHK5hHHU9hP4rGmQJ7vw3fb8325iheb8sUU8JQtGQreMJ/VjIbFp9L8M+kLt3MB4Y2L
         AfjFRa5nQ5YHK2ztxIhF8erf5F4a7t5FnD/wPgXBQHewrH4wr+MIdQCE8jPQBNmD7j6T
         uH4JdhWrPAEYwNqgbyG33lpi+lCSUZLGmXrxTFMm6AFCTwTdM7UQUNINvQmTLd4MWhsn
         3rETVtDVpVwKyeGA7Cn3bS7QyF/nKZA37R5i8+OIMKWN+xRZUnfhoJTiC5Cod6MK6nyS
         6yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724341061; x=1724945861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GR2YEdUZvI41rz3BDNTbJV751JnH4gaJfDNWGJ+l5WE=;
        b=O0nLahcie58Q+wKnKbEIuzQKhpVyA7c6Zu+pf6rgYncDUsuKxbK2horPzRjyhbZLzs
         oGl23o2l4mJEufHcrLpiNkdtkzAx/+bAH/V7RvtKjUgFXLMP5NEQ2uVnIsImICyRQDuF
         iE4+JRs2D79Cgf7C7AAAYt/K8gg1iZNPyDD2JtBD5ono86/7/JVfZhQg/sV7Mz2AP84C
         dFxDStvvH64s6z0H0PwxbEv3Kvh+4lKDtkrZE4XjkMBAS+sSx1zX1j+ya1744aHNaae9
         tH1v2XIr1GHD+VRCT5iLA/PkD75AOxw5v0zQadNOd3hwCaNF2hl4vcwdYNgVvQKA8nEn
         E1ag==
X-Forwarded-Encrypted: i=1; AJvYcCXyFEWN/9If7Gw67Y3Z6QCiYHMHQeF0+hzR8atnZcWr9Dso+zATmiB9VLcf6h21hrMnzda7Kj6w@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdsD12tm6/a5jgADuwREO4qV7JehhjURMAXxJBtfqSCXueBXh
	CupGQESr+ND4KgLlj9Zrubtkv5UdzXXttVIA8Ieaxo5NZOwIBbiUD4PW9h697Qrw4Gh0Rqbg1Fu
	YjKbsxNO9diaT2l/8KVtwJKMJzdY=
X-Google-Smtp-Source: AGHT+IGLsRlXu2wk0YDL0zsmBpyXZ7kuodzJGumlfkn91L/x5zKxe4Ovxgz4dwdiSwMK9tsGpmqd4CiuNdjDvFPiGEI=
X-Received: by 2002:a17:90a:7e91:b0:2cf:cd53:327d with SMTP id
 98e67ed59e1d1-2d5eaa9db56mr6183662a91.36.1724341061213; Thu, 22 Aug 2024
 08:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com> <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
 <CAHC9VhQU1oEaS=bB-Kc6Bfukb_MMFv+CrhpJ4F7L=tK8j_c8Ug@mail.gmail.com>
 <CA+zpnLeoz3yuVd5EUtct-CDi2zT9u7Y61edB3s4HbiEfxLOZNQ@mail.gmail.com> <CAEjxPJ5g_9CDRi8zm_=0tPyQf4D8Tpo0q3ai13_txNW1_Wd6kw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5g_9CDRi8zm_=0tPyQf4D8Tpo0q3ai13_txNW1_Wd6kw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 22 Aug 2024 11:37:30 -0400
Message-ID: <CAEjxPJ6rCPwwJoVWHXvC8qK2vLfc2wON4ik4Wugys=uC=WypqQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 8:56=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 5:54=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Tue, Aug 20, 2024 at 2:02=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Thank you for reviving this patch.
> > > Do you have a corresponding userspace patch? And for extra credit, a
> > > selinux-testsuite patch?
> > >
> >
> > Thank you for the quick response and initial feedback. I've just sent
> > the libsepol patches for userland on this mailing list.
> > For selinux-testsuite, an issue I came across while testing is that
> > the policy capabilities cannot be updated (that is, only the
> > capabilities from the original host policy are active). I am not sure
> > if I got that right or if there is any obvious solution (except
> > toggling on the new capability in Fedora).
> > I'm still hoping to get the extra credits by: updating the selinux
> > notebook documentation as well as updating setools (for sesearch
> > support). :) I will send pull requests if these patches get accepted.
>
> With your userspace patches, can't you just do this:
> $ cat netlink_xperm.cil
> (policycap netlink_xperm)
> $ sudo semodule -i netlink_xperm.cil
>
> If so, then you can add that along with corresponding allowxperm rules
> to the test policy to exercise this.

NB you may need to also allow { domain -testsuite_domain } the new
nlmsg permission for all the netlink socket classes to avoid breaking
the other processes running on the test system
