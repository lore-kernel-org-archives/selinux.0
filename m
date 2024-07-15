Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90518413C
	for <selinux@vger.kernel.org>; Mon, 15 Jul 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050509; cv=none; b=PuHBdw9XOD0xG/bnLv1xWQa7O9QS++yWjbvDSOHwD24wEeZnGKwPqUoxKNce8drMWoAMMfeydMhO5KuMeQiPRpP5KyDYCPGfXrW7Z6OrmqhRwWBQiFCXChXCCbhhuUBPFtsY/PaxaIxoBiDBGQ0AyrbDfcdhwiman3R+B2u9sMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050509; c=relaxed/simple;
	bh=w2CZF/Sf6OZjb2TLDfur/PEyCCSgxn7S378G1bFjGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci1nauTxe1u8sdgZShGYOdv6C+x8eZ6bmLQwN0prsU8j1hfF3BiMiHVi3+8Am5+M5mB+A0+x/VT04wwrLMZhNpmt02mG70U71/U0lyBcHj5qA5AY+MB+xrnhBXOwALPXaOOpAMTHyLpW9RFK1jWE2IOsi/6Dyxb2T5ZMTVZ2UoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dz2kURt+; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dz2kURt+"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WN38t55ZyzPdB;
	Mon, 15 Jul 2024 15:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721050494;
	bh=mxiIBTixp+v73ahYycbuEAgS9J3hIAVTYJHjh2eboHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dz2kURt+a5Cw9o79F4tE/9plyG6RS8hcGtyyBe9lDjF/SF+k0TNLe/u16sO7/vL+H
	 Njli46N6aoPvJQ0HIbD9x/Zrz1JErgjrWLQVSNjbzETwx1xE8PS+u1S8z/KhDM46+z
	 HSBYrzgFV5DRl8crOiFC6kGAk5MC7KD4iIKlcm08=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WN38t1YxpzQF2;
	Mon, 15 Jul 2024 15:34:54 +0200 (CEST)
Date: Mon, 15 Jul 2024 15:34:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <20240715.aeyaiRa0quie@digikod.net>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <CAHC9VhRAHg3pjHLh8714Wwb-KYReEijfE_C3i48r72VztUmdJQ@mail.gmail.com>
 <20240710.Thoo5haishei@digikod.net>
 <CAHC9VhT=t0Y55i7fJx-HHg3sGCnsSKn=nMCiRiXskdBzs1JVvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT=t0Y55i7fJx-HHg3sGCnsSKn=nMCiRiXskdBzs1JVvQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 10, 2024 at 12:24:31PM -0400, Paul Moore wrote:
> On Wed, Jul 10, 2024 at 8:02 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Jul 09, 2024 at 10:47:45PM -0400, Paul Moore wrote:
> > > On Tue, Jul 9, 2024 at 10:40 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > The LSM framework has an existing inode_free_security() hook which
> > > > is used by LSMs that manage state associated with an inode, but
> > > > due to the use of RCU to protect the inode, special care must be
> > > > taken to ensure that the LSMs do not fully release the inode state
> > > > until it is safe from a RCU perspective.
> > > >
> > > > This patch implements a new inode_free_security_rcu() implementation
> > > > hook which is called when it is safe to free the LSM's internal inode
> > > > state.  Unfortunately, this new hook does not have access to the inode
> > > > itself as it may already be released, so the existing
> > > > inode_free_security() hook is retained for those LSMs which require
> > > > access to the inode.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h     |  1 +
> > > >  security/integrity/ima/ima.h      |  2 +-
> > > >  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> > > >  security/integrity/ima/ima_main.c |  2 +-
> > > >  security/landlock/fs.c            |  9 ++++++---
> > > >  security/security.c               | 26 +++++++++++++-------------
> > > >  6 files changed, 30 insertions(+), 30 deletions(-)
> > >
> > > FYI, this has only received "light" testing, and even that is fairly
> > > generous.  I booted up a system with IMA set to measure the TCB and
> > > ran through the audit and SELinux test suites; IMA seemed to be
> > > working just fine but I didn't poke at it too hard.  I didn't have an
> > > explicit Landlock test handy, but I'm hoping that the Landlock
> > > enablement on a modern Rawhide system hit it a little :)
> >
> > If you want to test Landlock, you can do so like this:
> >
> > cd tools/testing/selftests/landlock
> > make -C ../../../.. headers_install
> > make
> > for f in *_test; ./$f; done
> 
> Looks okay?
> 
> % for f in *_test; do ./$f; done | grep "^# Totals"
> # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> #      SKIP      overlayfs is not supported (setup)
> #      SKIP      overlayfs is not supported (setup)
> #      SKIP      this filesystem is not supported (setup)
> #      SKIP      this filesystem is not supported (setup)
> #      SKIP      this filesystem is not supported (setup)
> #      SKIP      this filesystem is not supported (setup)
> #      SKIP      this filesystem is not supported (setup)
> # Totals: pass:117 fail:0 xfail:0 xpass:0 skip:7 error:0
> # Totals: pass:84 fail:0 xfail:0 xpass:0 skip:0 error:0
> # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

It should be enough, thanks.  FYI, the minimal configuration required to
run all tests (except hostfs) is listed in
tools/testing/selftests/landlock/config
