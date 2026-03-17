Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FD394483
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771375; cv=pass; b=uyNUpJ7T5tcDPITPWF2femQroCTPCXE+ElSB3y0p6P635APlU8o9bIx5uqlLdAzwrOrehos7NAbJ/XydCMtsOzJnj7mjjPxCYUQsuAX3tWIRJPJEkh1OUdBd7actZTD0X97DRRDn+9JK/JhhzcDP6E10x/Fq/1eCmgT13naLqI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771375; c=relaxed/simple;
	bh=QUDC5jrmRrJojzfitd2CzM1OmZr1G8/BgX/pdKw+87I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX9yjHLkfksM//p4sKQRYCawvsFuW/rlAzBT7VKyQOEgBrGVneyRYSJvrvS9SFoLzc/yOeDvnYYpgAUQD47pi0Lw+Cvc032YuPDEpmKu29RXCaoIm3RseyngWy++qy8UWKh1AUEYsEbY97XWxW9J5JTNdlS3E2HSQBmT55e8/mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RoKUMaNJ; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RoKUMaNJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b062069f80so12500305ad.0
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 11:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773771373; cv=none;
        d=google.com; s=arc-20240605;
        b=cuMMrl7+jfdLG9bd+4jtSP8QS5+Q5SgyYDOFr+MJ5lE/zwdLZkF25QBnfavpUJ4MFA
         lajSAxjpTL5nHJCLEgkXQQj6tNNHeeSY1Cb+PqfPiSXXXCxnObWV4aHE61WUjD8QOZLT
         fuWvNpbFuc00f4/d91X2Xr0A7MFH7Fk2pXsRiGAyOVoYXI7BvwArrI3bF70iKoyt6krO
         74yuo3c1PN0SqaMU3XNyCYIx2+sNtsk8Kseba7zc543gWuLrSFXwwHqBVQn5OPjKXcPT
         KlgzbXhW9dlpDGf9wwuZCZalSTvG2jVYozaqe12bYWvWHrAiMNenkpdbk55I9oUGMxlc
         NX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
        fh=yXhoHTmzeMZd1V5cbBOJ4d/YxXO9kX237ey6v2NSzlU=;
        b=aHeJ5h6M7tsTDkh7mwJvv27TWGflwE5WU6HZyU8G/FF9Ov+mmWpFWS0VGoIKjN2eGI
         QSZZlQXxN6uk0PmkgOhupGujkjXnZRJyMHJeMsZmmuqlyblGvFqbPNaO699TJ6gHeJYo
         RGoUrswty/DqFidoN+jAfMVuQwNdkCAd8qvV4CmNa7OYIZOga63Hz5Pb5PktiUk4sslX
         KFrVRD/yCbmy8JOGg2w3UUBAJQTyrWyzZQlz8j+edhRwAtgwuCw6F+3l1aktPAHKPL+P
         c4GoX5h++flPR+6lzYb5tdYCCPmibwCfDfzL3zbhvK8kFUiapXflUAumQBC0EFmjGXDb
         A9pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773771373; x=1774376173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
        b=RoKUMaNJelxkySue1Uj+KohQ2KRnoVt9Y6p+Jo16nniijXKT9ujEGEvX7xe2mSXF62
         26nsMSxAbPUzYhJ+xUjvwEBI7dNOPm+cP2T3o0R6j+y2ltRPmSxYMLckKi7dqzF8TzJ0
         gwXxY5yGtPnvALaJcGDMt6IHjoERwpza4t6SWZcm6JkzC/c2ts7HVbgeXh38FyTBoGb/
         ktIQrKCPa05YyPFAzu7UVMTjrWMMGe7TvRMmzl7jLZV52bh1s2rVzzF1jfnwCslZAivi
         tsdIpI9gHJgo+aElfozr2o8AMaMXdpoIFTpdoUyScfJZCHu7sbvTpfBdioeCEh8e5CiR
         6XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773771373; x=1774376173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
        b=Bx9ar4fC0Sp/6icGYI6mWpJD6EOqB6aPiTvGvNEy5Z/9z5Ei1d8XU7ORHt29vcPMyT
         yE/BMPe3YrL80dCmo0xpvPUZNXKqOpOL7p8UTfPVK3gFAzLhCksobXgLxN7iK7463PBR
         VxTntueGeIWue+AZFwF+8r8k8ya/UhGnR/8GfFLNB6sZhJBV7ISF6pCAp6saoMJIA8Vu
         a0kvurVA+xR/F9eOntGoY/tfwTTRUrxi6xUhrmxqmnQXtca3/mJn1J2+QUf3u7G1PcaK
         vpkuvh9s2zcfkAzL2oYq5zQ9njaxd23svI2iOf+ZsUxq/d87l42qbSRqItwq52NtNGjN
         UC/w==
X-Forwarded-Encrypted: i=1; AJvYcCXtbX19IP5qk/D4b9kXcuICkd08TA/6u4SL3zhVblyIMr/glRs0+ZcZQVXvTqDQyZH6AX8Ngj4w@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+9fWSlnazEQNSfbxwt6W7d831bdFe5AIgT07ECfyhU8T1W/S
	oyM1HmbhOKetuhUmBxjtsMA948ae7EvBsYPHFuvshJLkFzuiHoAAjD0BZIEWFbco8RrIUJ2IW+y
	HyxbkTBibTFCoQKr0x0AJ41LAk53H0s/icrwSZUdN
X-Gm-Gg: ATEYQzzUQmCo3KADXghSr4ENPiAAMXMjTh5aBHX+2k9mzlBpE0kNXC6Ojp+24BvDdE7
	tp8ePL4PonMB2rmMJtWG5mnP0lweM7JrxzFHgD5JF4fOtjQuOREvzlC/pTpe8skSjbMrHbKnTw0
	wBhve39qUwWaaK8lprLB+/d4zytr8xJZbP1eBoL+zFbBU48vBByIZjxJmHgxd0mP5F+yDHnU924
	BzqIk4G/Tc1oT0uKzdzLioUCVa7sJdnhtlBEV7D7SjOts29Iey9xClphzmT/Bs+grVP9zc+QpEa
	hE9pZEU=
X-Received: by 2002:a17:903:1447:b0:2ae:c5fc:b2ea with SMTP id
 d9443c01a7336-2b06e3d2eb0mr4770225ad.30.1773771372739; Tue, 17 Mar 2026
 11:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
 <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
In-Reply-To: <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 14:16:01 -0400
X-Gm-Features: AaiRm52ZqNJHAbRzZUAvcxik2J2qc91q1AUn-hHxOheIit1e-BlWZgjcVmBec3Q
Message-ID: <CAHC9VhQX4aDvrd9uX1ESGteWpLLGbXmH1+SVFfE06juAsSCkGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 3:26=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Mon, Mar 16, 2026 at 10:59=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:

...

> > Due to the nature of the issue, I'm going to merge this into
> > lsm/stable-7.0 in a few moments so the changes can get some testing in
> > linux-next with the idea of sending this up to Linus' later in the
> > week.  If anyone has any concerns over this patchset, please let me
> > know as soon as possible.
>
> Since previous 4 revisions were not posted to public list,
> let me repeat my concern from v4:
>
> On Fri, Mar 6, 2026 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Mar 6, 2026 at 3:24=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> ...
> > > My expectation is that the merge of this patch will be collaborated
> > > with Christian ...
> >
> > Of course, that is one reason he is on the To/CC line.  More on this
> > in my reply to your 0/4 comments.
> >
>
> I am sorry Paul. This must be a misunderstanding.
>
> My expectation for collaborating the merge of my patch with
> Christian was that an agreement would be reached regarding
> which way it would be routed to Linus.
>
> CC to Christian and sending the patch to Linus without getting any
> ACK from Christian was not the way I expected this to go.

To be honest I expected Christian to provide an ACK by now, as he
reviewed and commented on your earlier patches with the O_PATH file
approach.  He has had weeks, if not months, to comment further and/or
supply an ACK so at this point I'm proceeding ahead as I mentioned to
you (and Christian last week).  You were very anxious to bring these
patches on-list, which I did, however, now that everything is on-list
there is a responsibility to act on this quickly (this was the
motivation for discussing the solution privately at first).

Hopefully Christian will comment, and preferably ACK your patch, but
even if he does not we still need to go ahead and fix this soon in
Linus' tree.

> > > and that it will NOT be auto selected or rushed into stable.
> >
> > I haven't marked it with a 'Fixes:' tag or a stable Cc which in my
> > experience are the two quickest ways to get pulled into a stable tree.
> > I'm not sure what stable policy Al or Christian have for the VFS tree,
> > but LSM and SELinux commits are not pulled into the stable trees
> > unless explicitly marked with a stable Cc or requested by a dev after
> > the fact.
> >
> > > I don't mind if you want to route the security_mmap_backing_file() ho=
oks to
> > > stable to use it for some simpler bandaid for stable, but rushing thi=
s
> > > one to stable is not a good idea IMO.
> >
> > Once again, see my (upcoming) reply to your 0/4 comments.
>
> TBH, I don't understand the logic of placing patches in lsm/stable-7.0
> without the intent of backporting them to stable.

I'm not going to copy-n-paste my previous off-list reply, as I have a
rather strict policy about forwarding private or off-list emails to a
public list without consent.  However, the quick answer is that
inclusion in a lsm/stable-X.Y branch does not mean a patch(set) is
automatically tagged for stable, in fact you'll notice none of the
patches have a stable marking, mostly due to your previous request.
As the LSM and SELinux trees are not pulled into the stables trees
unless explicitly marked, or requested, I do not expect those patches
to be automatically backported.  I do not know the stable backport
policy for VFS patches.

> I perceive my patch as a risky patch for overlayfs and the vfs
> this is why I wanted Christian do be part of the decision if and when
> my patch is sent to Linus.

Christian has been a part of the discussion for months now, and has
already provided feedback on the VFS portions of this patchset (which
you have incorporated).  I agree, I would appreciate it if Christian
could supply his ACK, or an alternate solution, but as you strongly
encouraged us to bring this issue on-list, we now need to get a fix in
Linus' tree soon.

--=20
paul-moore.com
