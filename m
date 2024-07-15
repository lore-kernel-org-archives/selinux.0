Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9330136E09
	for <selinux@vger.kernel.org>; Mon, 15 Jul 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076699; cv=none; b=WsdrRJgoObeAtIJwz/MoTvJTEhjPbDT07xOSEuFaPn4nOFMujoAOAFnEUrs8twToo+fhmQExkP7hnKPoGrnuWGPMZUbmI9MWYG9334cLXEY9O+gezI+aiNT3UZ/s719HKp4JCfpmvQSn8hKVE7jzbMcNihnStLs5oceU901+cjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076699; c=relaxed/simple;
	bh=Xo31Aqw4IT8rV/415OAXd+rLDRcgtSQ7OJzbNjsR5AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQNwqHRCLviQ9lsz8+Otq+EDMrMwdnxb6O707kjk/2BgsC3zSmWJl5cM3bAWhDVQWOzbT50LcByEe0nRtzxF7d8g2I3Cr8cN7pZ6NDq35uCXkGBLIgx5asNfgS0x3tTvnaDaS8yTPpsfiKMpxMHF342Spjyv2jRmkmZ0B6U/J9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZrC0KL7s; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZrC0KL7s"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64f4fd64773so53679797b3.0
        for <selinux@vger.kernel.org>; Mon, 15 Jul 2024 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721076697; x=1721681497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP4XPpxcda+s6KADCVhVD+mjGKPcMTQ3ZDUdaaRpp8g=;
        b=ZrC0KL7swFv4Gg1iwLZ7kWmPsJralKDNLY9QAiP2LpX27MJ5ADghBSQub1ET66GcGN
         HXxVu3+YGHT0fGEOBuUXPoM7cZzRh4eEWwULBjAyf/WM9jf/y2rOj8v6OAYOK+aeM/uN
         oQJFp3duFXo+0PyGuKZ4ClqAEnVaGubPHufggNfMbbucqEcAOclNO+70433VL1e4EuBF
         OLJi1YR7vT5Cc8btZPHfs7YkK0h3R546f11U34QUB+JKHicjIW6Wf17UWiVNqKQI2zKq
         Xmy0vzzgNh7wYE/ShBnXo7VAQS/WTcBCBwUV7CyiWDcGSnp5YnAG9H0Zdr28gdFSm3d9
         h/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721076697; x=1721681497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP4XPpxcda+s6KADCVhVD+mjGKPcMTQ3ZDUdaaRpp8g=;
        b=drJi5F3/F8juajtR4NiufZseKaodLRzd6DUeLrLq29E/WZSv0MEQXs1CT2nkj0uXlC
         5a5M+s15k4egQg4fdPV5Sbyaog8JaFzuouJgB4lPvw966wCSTpP/GsFmebRmwovKERfg
         ithFtX4TCMfQiJNCngfpL7l3D1pMQ9FbfN4t77/wivBATWIxH+5YGVMNAz2PxdXx5H8m
         AJJm4lyyx6Me5lPJttlYQ3S5/rQP3+PRsQQV8Cp3KGP0ejzEnScY+385jk6ELkZrk2ma
         fo+B38mW2KHGdYFyAkDT5anFeyhYbQfHw2ITFPEK/klK4cjAtxBFVPcRmUYDwVEYRp6L
         iCGg==
X-Forwarded-Encrypted: i=1; AJvYcCWrdpgANCSW9PBqtll8OxxQ+Vsgy2CJNjCFFLDnNklwk0/SDmO0GlT18fw2fySHGtUc7NJ5/MOFhmIcWdFL0oC40E1FPSWydg==
X-Gm-Message-State: AOJu0Yz3bab/nO9ZRIzx+4SqSK4tc9iCV0na4FBpaUWgmq39UfQfrvAK
	QVWWpqT34gXZ+XEtsHa1QGlmo2yKqeqwo3DINSUsGqQcujjEUDTDnlRV7kv0gmhfh1j8GtZC9m5
	NChQlz+9SOhpPN98Lwm7BMO4pq2pPAnnUv86i
X-Google-Smtp-Source: AGHT+IEzDPYnAEEW+mEYcxFvm2kRQh5n8kdxgzDi1NzSB7qthJNOAx0+WLT/k7W9T96c4W5c6jwYA6iY1qBdi7FxPVk=
X-Received: by 2002:a0d:c584:0:b0:615:bb7:d59c with SMTP id
 00721157ae682-6637fd633d7mr1847247b3.22.1721076696495; Mon, 15 Jul 2024
 13:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <CAHC9VhRAHg3pjHLh8714Wwb-KYReEijfE_C3i48r72VztUmdJQ@mail.gmail.com>
 <20240710.Thoo5haishei@digikod.net> <CAHC9VhT=t0Y55i7fJx-HHg3sGCnsSKn=nMCiRiXskdBzs1JVvQ@mail.gmail.com>
 <20240715.aeyaiRa0quie@digikod.net>
In-Reply-To: <20240715.aeyaiRa0quie@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jul 2024 16:51:25 -0400
Message-ID: <CAHC9VhSbgD3axJ=0WMenj2HL3=jy8+_0aGQbuZT0hAYrUuXXhw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:34=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Jul 10, 2024 at 12:24:31PM -0400, Paul Moore wrote:
> > On Wed, Jul 10, 2024 at 8:02=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Jul 09, 2024 at 10:47:45PM -0400, Paul Moore wrote:
> > > > On Tue, Jul 9, 2024 at 10:40=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > The LSM framework has an existing inode_free_security() hook whic=
h
> > > > > is used by LSMs that manage state associated with an inode, but
> > > > > due to the use of RCU to protect the inode, special care must be
> > > > > taken to ensure that the LSMs do not fully release the inode stat=
e
> > > > > until it is safe from a RCU perspective.
> > > > >
> > > > > This patch implements a new inode_free_security_rcu() implementat=
ion
> > > > > hook which is called when it is safe to free the LSM's internal i=
node
> > > > > state.  Unfortunately, this new hook does not have access to the =
inode
> > > > > itself as it may already be released, so the existing
> > > > > inode_free_security() hook is retained for those LSMs which requi=
re
> > > > > access to the inode.
> > > > >
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h     |  1 +
> > > > >  security/integrity/ima/ima.h      |  2 +-
> > > > >  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> > > > >  security/integrity/ima/ima_main.c |  2 +-
> > > > >  security/landlock/fs.c            |  9 ++++++---
> > > > >  security/security.c               | 26 +++++++++++++------------=
-
> > > > >  6 files changed, 30 insertions(+), 30 deletions(-)
> > > >
> > > > FYI, this has only received "light" testing, and even that is fairl=
y
> > > > generous.  I booted up a system with IMA set to measure the TCB and
> > > > ran through the audit and SELinux test suites; IMA seemed to be
> > > > working just fine but I didn't poke at it too hard.  I didn't have =
an
> > > > explicit Landlock test handy, but I'm hoping that the Landlock
> > > > enablement on a modern Rawhide system hit it a little :)
> > >
> > > If you want to test Landlock, you can do so like this:
> > >
> > > cd tools/testing/selftests/landlock
> > > make -C ../../../.. headers_install
> > > make
> > > for f in *_test; ./$f; done
> >
> > Looks okay?
> >
> > % for f in *_test; do ./$f; done | grep "^# Totals"
> > # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> > #      SKIP      overlayfs is not supported (setup)
> > #      SKIP      overlayfs is not supported (setup)
> > #      SKIP      this filesystem is not supported (setup)
> > #      SKIP      this filesystem is not supported (setup)
> > #      SKIP      this filesystem is not supported (setup)
> > #      SKIP      this filesystem is not supported (setup)
> > #      SKIP      this filesystem is not supported (setup)
> > # Totals: pass:117 fail:0 xfail:0 xpass:0 skip:7 error:0
> > # Totals: pass:84 fail:0 xfail:0 xpass:0 skip:0 error:0
> > # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> It should be enough, thanks.  FYI, the minimal configuration required to
> run all tests (except hostfs) is listed in
> tools/testing/selftests/landlock/config

Thanks, I'll try to remember to add that to my test builds.

--=20
paul-moore.com
