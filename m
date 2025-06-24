Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A849222571
	for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769006; cv=none; b=tkDVs0y+PA2rEE/T84s7M9IKPpbJi+Vim/9xpcMwtr29PQlVoJ0lXxSQj8pkrnxZI6XawPBatftFbBfAxhl7gen5pr250uHN4qX5+At7dHIGqAWgfbouMGgynKwUK82uCP4TG51DZ0D9iwRqzeHEXatKVgGSAyhKRlX40CluIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769006; c=relaxed/simple;
	bh=SPA7gHgstSqmCTWMjOPCDat/0jNKPZ95eCUt43/m8S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCSaqJfaq21bXwj7miBTGBb7GfZacSrchf3vUHFcB1XwMc5QTBy/W6x6yqn1QqfqprwcvefOM5enUQN5nk5bOIwWWRMAP7dxW+b/UhROx+5RUd9i3r8XQxufa2rGsHIddA4esd6Fe6quXGUHQEjmnTH2XUlhTS+7pVBO8sW3+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqEwfTDA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqEwfTDA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122a63201bso3792122a91.0
        for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750769004; x=1751373804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPA7gHgstSqmCTWMjOPCDat/0jNKPZ95eCUt43/m8S4=;
        b=YqEwfTDAInoCFgjo9kdTvGL+KaX6bMw2Vo30lwryHKx6x3J748uqh5mgKYVQZ2gkWb
         d+qaAqKtcfhJ3EEgzTM1fgoMRYE6o8Sltc6W+Lnjk0tZ1DeT5g00d8Wl/J57NtzaGe+3
         XvkrlxOImoOIeg21pME6vkVmTkIgROI7dAw7hQB4i9Uve7mnfSgluWqq1y5tFDb2cUmR
         nomBmVKch5I+JG6IxkEM4SicaghtStfkVDbxXKriREFODV3rISr/ePaGnHZFtKPuzKo/
         uEbpBAIKLV+ZPemyHeY+pOEDGQqyY/BbPxOes8tL9U6SNSV3dWAjGKprLW1Sml/QKak4
         NL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769004; x=1751373804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPA7gHgstSqmCTWMjOPCDat/0jNKPZ95eCUt43/m8S4=;
        b=QlZ30tK2laPgt5LtoUiyjJ2bLt79s1aa2ka59/iUPFdl9DDmlPFycP+IKendNhcUdc
         9o03fIJx5BZ564+zwgmVa2Z6r632DbfL1AIeQp1dvi6M7aTUNMAq897g+MgpiYw0KbLZ
         UM5Q/wsHM3lmLzTMXnv2g9xfEKUMiXku12y05EODjXNIc61T3cw1UqjNC8Yv96PmvB+G
         WDt0XhTuPXOcDhAWUvIWdTkSVOZgYR3Sfe6eyFAM5HddABwgzYS2kLXC5pcwGDX9Lrk4
         XLcodor1ifr93NLSaO07HDu27Pw2ZBmeLH8to6OgrOgcqXYPYeRRLuyfcVwXuOCEWDEj
         xUyQ==
X-Gm-Message-State: AOJu0YwdrYKELMu3u/XBFhiGkYCnKFAaZveF60a2d0cAlZHw0lpv/1nO
	UL8ztl2o/MhWIaCksL00LQF4vJe+LXsmPsvwMZfKwWfcDHxR3WH9FgSCounHlt3h+dec3iQ09MA
	W5VvrgE1GY4BTS2XxK8JiiUgql9xhhRda7w==
X-Gm-Gg: ASbGncsPzO8xWOQ1hXlaX7IOcOMVGlzymCsF6DnYKLBe9PnIiSiGTgKZAJn7ezuPaWr
	DxtKSjY2UwmBNsTO8/P+Mex3Vm6RMl8H+GzLck9KPNL5jXd2RUeOFKrG+j86eHYuOdH9TOLT1I+
	NQ38apr8QPDCVZt0X22Dghtac1kaWX4cFms9L+FZ1cukM=
X-Google-Smtp-Source: AGHT+IEx85uB8nqeKlZawFrToVayM6JCSpGcc6D/7QUcejVG3t0v4pAPoHOx4YkwKX1iK9W8Z2VlRJag6cv306zrL6E=
X-Received: by 2002:a17:90a:f94f:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-3159d8dab59mr25664176a91.28.1750769004207; Tue, 24 Jun 2025
 05:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com> <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
In-Reply-To: <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 24 Jun 2025 08:43:12 -0400
X-Gm-Features: AX0GCFus114fILNTRpNph7jwz1OTN7o7G5b8wnu9Ix6Cey0IqwYlP2poQuqEPjI
Message-ID: <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:44=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco.c=
om> wrote:
>
> On Mon, Jun 23, 2025 at 08:09:34AM -0400, Stephen Smalley wrote:
> > On Mon, Jun 23, 2025 at 7:37=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cis=
co.com> wrote:
> > >
> > > Good day.
> > >
> > > I have been looking a bit on your SELinux Namespace work, as we have =
a
> > > usecase for it where it will be necessary. Basically we're running
> > > Android in a lxc container.
> > >
> > > Currently we just have a single label for everything happening inside
> > > the container, and disabled every SELinux handling from the Android s=
ide,
> > > as that doesn't work.
> > >
> > > So we're looking into if your namespace patches will allow us to let
> > > Android do its own SELinux handling, and it seems very promising, so
> > > thanks a lot.
> > >
> > > My question is about user namespaces and the selinux namespace. I see
> > > you very consciously have not linked the two, and I was wondering if
> > > the problem I'm seeing might be due to that?
> > >
> > > What I try to do is, as root in the init usernamespace:
> > >
> > > ```
> > > # unshare -m -n -U --map-root-user
> > > # mount --make-rprivate /
> > > # echo 1 > /sys/fs/selinux/unshare
> > > # umount /sys/fs/selinux
> > > # mount -t selinuxfs selinux /sys/fs/selinux
> > > ```
> > >
> > > The problem is in the umount step, it returns with:
> > >
> > > `umount: /sys/fs/selinux: not mounted.`
> > >
> > > Do you know if there's a way I can make this work? Or is this a
> > > limitation of the current implementation? Seems like the flow today h=
as
> > > to be to first unshare and remount the selinuxfs, and then enter the
> > > user namespace.
> >
> > So, first, unless your email contains proprietary information, I would
> > recommend cc'ing the selinux mailing list.
> > Then, with regard to your question, the above doesn't appear to be due
> > to anything in SELinux itself, as the same
> > behavior occurs even if I don't unshare the SELinux namespace and even
> > if SELinux is permissive.
> > I would have to look further into what unshare -m -n -U
> > --map-root-user and mount --make-rprivate / does that is causing this
> > behavior but it doesn't seem like it is something in SELinux itself.
>
> Thank you for the reply.
>
> You're correct. I was assuming it was due to the SELinux namespace, but
> testing without the patches at all shows the same behaviour. I'll dig
> into that and see what I can find then. Thank you.

On further thought, I think that you aren't allowed to unmount or
otherwise modify a mount for a filesystem that was mounted by a
different user namespace, so when you unshare the user namespace, you
can no longer unmount the old selinuxfs mount. Hence, it does appear
that you would need to unshare the SELinux namespace first, then the
user namespace.
