Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2126211A29;
	Tue, 25 Feb 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520761; cv=none; b=Ny1WLRbQf4xvDikHta0z1xmU9bg1TDG8RIG5EJQyegU+qnwur4qL+vanDsHaDjhFn/FTq5RrAMvzQKBIL/e8s9mu7qflzO2brwF0ORBg10PuU5HTQq7PYUKqnnm3aR434M9+POkadp/HefwXZUaHDeC0yu606uZBalRigTq4A00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520761; c=relaxed/simple;
	bh=k3ncfrBzSzEk4e3l0PwPp8uuDaQQnMOGnDx+adJQiso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anrfEQj9iUWSzFAlw+rlzhy3rnosd505gdYeSwVOrR5KsCTKP7n3XOrmUltavinfCcstfk+GOHH6hNAxI1VQ77F5jhr69jiVpLFAKrG9JnUsjscSRW9hpoLFTt0o+LQ+Mkup5MIJYe21g5Qnj8+oCtWqk5XaFFMeI3VILDly37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNJREjHr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNJREjHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2B9C4CEDD;
	Tue, 25 Feb 2025 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740520761;
	bh=k3ncfrBzSzEk4e3l0PwPp8uuDaQQnMOGnDx+adJQiso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNJREjHrwh1OskgVIKX5DsQWTc2CXp6wLiWAdnrSNnPC4jgZ3S4U2kfx4GL3GoiBu
	 U08JQWiNQQfoz7nedqt56zZvW3fnEJkmjVkwjNMRO3Omr+ogO1W6JtYk4Ns69uOwNQ
	 5D2RPkMXPA/biKIQub67KAZ9Zki/jusGxOE/yOJx9wBpO3YtSVmKxFca5T+X8kvcLv
	 5QJKZp/ByrPDLpivh4XMPonqYuJu+4u4yop+L9iEOdGlHfstQ5fQH1+nGVNfJ3sDOt
	 utZt0Fagif/KlfefjW7jEpElrpTy0FzekyUbmlKIJaZR41pVDaJHDBDpWjjzRUazxK
	 79pH2sMJzTeaA==
Date: Tue, 25 Feb 2025 22:59:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	will@kernel.org, jmorris@namei.org, serge@hallyn.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com,
	omosnace@redhat.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH linux-next 1/2] perf: Remove unnecessary parameter of
 security check
Message-ID: <Z749KuWROxQMsbnu@gmail.com>
References: <20241223070650.2810747-1-luogengkun@huaweicloud.com>
 <20241223070650.2810747-2-luogengkun@huaweicloud.com>
 <CAHC9VhRRu-UYEV_-0-QgOZ3ByVwp-ZdEphmsvy4NcdqynH_tDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRRu-UYEV_-0-QgOZ3ByVwp-ZdEphmsvy4NcdqynH_tDg@mail.gmail.com>


* Paul Moore <paul@paul-moore.com> wrote:

> On Mon, Dec 23, 2024 at 1:57 AM Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> >
> > It seems that the attr parameter was never been used in security
> > checks since it was first introduced by:
> >
> > commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> >
> > so remove it.
> >
> > Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> > ---
> >  arch/x86/events/intel/bts.c     |  2 +-
> >  arch/x86/events/intel/core.c    |  2 +-
> >  arch/x86/events/intel/p4.c      |  2 +-
> >  drivers/perf/arm_spe_pmu.c      |  4 ++--
> >  include/linux/lsm_hook_defs.h   |  2 +-
> >  include/linux/perf_event.h      | 10 +++++-----
> >  include/linux/security.h        |  5 ++---
> >  kernel/events/core.c            | 14 +++++++-------
> >  kernel/trace/trace_event_perf.c |  4 ++--
> >  security/security.c             |  5 ++---
> >  security/selinux/hooks.c        |  2 +-
> >  11 files changed, 25 insertions(+), 27 deletions(-)
> 
> This patch seems fine to me from a LSM and SELinux perspective, but
> I'd want to see an ACK from the perf folks before I merge this.

A belated:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Patch still seems to apply fine.

Thanks,

	Ingo
