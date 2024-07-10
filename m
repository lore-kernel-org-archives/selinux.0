Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696220312
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628685; cv=none; b=hgQ0FYqwcH6p2jMWHNL1JRL3ULNllwcXnhcHiY58u+B7hSezlXa0lncD37HcJYnu5WhGxuSFz5ZG9aQlFhiMrMmWhkkMh4L5QufIZ3Mugbd0AVSDsRCjpnEFDI26IitWLxGtMmD2GIZfRy/Qs8Qli4QG0iMTyfvYoFsKlzQfjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628685; c=relaxed/simple;
	bh=bBHwskz2Kv2HiE5nZdqv+Ep15jgGS7tWJEF5IDzKrSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rimIAZAdvnkCkdvw++Qk1z/ENNSe+fWYjmL0d3oXhgKELWcVoTp4+aGPKGdBNTV7E6CDonPNKHzK4u9AFH1CImQCQuXBc6YRvaW7ABpyNYZIN1BU1Cq0v2kmjeUdT8rSjlevUoNHWYG/C/UnwC8kzvlbtfktF7P+PXZsUW47Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wb3I6GR3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wb3I6GR3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64f4fd64773so77933897b3.0
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720628682; x=1721233482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHJEDyhZkEBOLzqLiqf8UJkvMgL6YkYtZlbBX6NuJxY=;
        b=Wb3I6GR3BHvvdIeymEuapjVBZrcjactlqw5PNCXrG0dQNdp+1g/IOSPoN+kBGLg4Ag
         EjmBOve+DN9J8aQaCFMvMXFt6Fb9Qx09MEl4cPjb1OR0Ga4Q4LypHeZH+2ZCKGoku9uw
         5GqbHBHWZDN5SJsLACnZJzQHUu8vbBfjEMpMjNEyU0X5ewLuRdHYByVRww/qqvDJTPYR
         qVl53KJkFNET2uTl/ogNaug9taUaf50p6bwC+TpbeSE5w3CYsfexi3NLW2z1V4IXLDqU
         w7s2p4gMNs0H8eIO2MeSCC+helFoX5SInic5dstsiLtL1ayrX1arxPgt7o/JwyHsj6Hx
         Gg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628682; x=1721233482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHJEDyhZkEBOLzqLiqf8UJkvMgL6YkYtZlbBX6NuJxY=;
        b=a4/wn0XqI4d/LeBGWMwKv8vL6X5tnMKjzqWEL6swQIZeGen7gy2zPcF74Y+92t73Q8
         /wuAWqSIMd/6fGnHNkgSO2vMxOgBQAzScfg56w0OIfXrGkZhOc8lYvF5Kj/lmNqlyh5P
         vrJezFM+XRLPjv/a3pS7VVKADW1kFtcG6AUW0d8Hx9IxJDB9shfVKOnzhJfOp5jJH8nS
         Aa6BTBUB1fabp3CEP9DJNkKi5iDNpWVOVmuSCvrvdJJQ5mssOIZNaK0aUyCp3eE+hJON
         9ow1utwHSLoVYJMfSyWts6sbBIt+eaP66UsnY0/ghdxU8eYTwft5eQvvmpoBu+TnwXLH
         2reg==
X-Forwarded-Encrypted: i=1; AJvYcCXPf3DFntOu/dd5r84HqTb1wzE/oicmxc90rOKh/Pt/PqXmjeYnrB8ZIREtOqMLWdpCqAgRGnCX79oPp235xE/C7MIKGXtuDA==
X-Gm-Message-State: AOJu0YybAcaqJhKWUEX/A8oLiM0RgglznBkpIBlEWR2B1pG5yqy7vX9s
	gbJ+9vXbqMhl1RBzJs+0MhJfEOmZPj00u0ilHsTg3fi9BOGSTZG0CTYreRU1Nojcd+R2TToUvKS
	6DXhHjqlOKJXukv8tezUXt0NZDkx4YcF74l8E
X-Google-Smtp-Source: AGHT+IE/iOygnlzIazB+u+vaLVWpfctckgP/y9w/gIZoc7BtSpxOmymXgInavv6nvMPnCY09wjXFKLSv1t4E9a4u750=
X-Received: by 2002:a81:9145:0:b0:651:a724:dcf9 with SMTP id
 00721157ae682-658ee7914ecmr72001207b3.1.1720628682432; Wed, 10 Jul 2024
 09:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <CAHC9VhRAHg3pjHLh8714Wwb-KYReEijfE_C3i48r72VztUmdJQ@mail.gmail.com>
 <20240710.Thoo5haishei@digikod.net>
In-Reply-To: <20240710.Thoo5haishei@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 12:24:31 -0400
Message-ID: <CAHC9VhT=t0Y55i7fJx-HHg3sGCnsSKn=nMCiRiXskdBzs1JVvQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:02=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Jul 09, 2024 at 10:47:45PM -0400, Paul Moore wrote:
> > On Tue, Jul 9, 2024 at 10:40=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > The LSM framework has an existing inode_free_security() hook which
> > > is used by LSMs that manage state associated with an inode, but
> > > due to the use of RCU to protect the inode, special care must be
> > > taken to ensure that the LSMs do not fully release the inode state
> > > until it is safe from a RCU perspective.
> > >
> > > This patch implements a new inode_free_security_rcu() implementation
> > > hook which is called when it is safe to free the LSM's internal inode
> > > state.  Unfortunately, this new hook does not have access to the inod=
e
> > > itself as it may already be released, so the existing
> > > inode_free_security() hook is retained for those LSMs which require
> > > access to the inode.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h     |  1 +
> > >  security/integrity/ima/ima.h      |  2 +-
> > >  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> > >  security/integrity/ima/ima_main.c |  2 +-
> > >  security/landlock/fs.c            |  9 ++++++---
> > >  security/security.c               | 26 +++++++++++++-------------
> > >  6 files changed, 30 insertions(+), 30 deletions(-)
> >
> > FYI, this has only received "light" testing, and even that is fairly
> > generous.  I booted up a system with IMA set to measure the TCB and
> > ran through the audit and SELinux test suites; IMA seemed to be
> > working just fine but I didn't poke at it too hard.  I didn't have an
> > explicit Landlock test handy, but I'm hoping that the Landlock
> > enablement on a modern Rawhide system hit it a little :)
>
> If you want to test Landlock, you can do so like this:
>
> cd tools/testing/selftests/landlock
> make -C ../../../.. headers_install
> make
> for f in *_test; ./$f; done

Looks okay?

% for f in *_test; do ./$f; done | grep "^# Totals"
# Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
#      SKIP      overlayfs is not supported (setup)
#      SKIP      overlayfs is not supported (setup)
#      SKIP      this filesystem is not supported (setup)
#      SKIP      this filesystem is not supported (setup)
#      SKIP      this filesystem is not supported (setup)
#      SKIP      this filesystem is not supported (setup)
#      SKIP      this filesystem is not supported (setup)
# Totals: pass:117 fail:0 xfail:0 xpass:0 skip:7 error:0
# Totals: pass:84 fail:0 xfail:0 xpass:0 skip:0 error:0
# Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

--=20
paul-moore.com
