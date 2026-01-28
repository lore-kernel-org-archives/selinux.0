Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D02836A6;
	Wed, 28 Jan 2026 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570815; cv=none; b=gHFQdEfN6yZHjIunnkWkxaRB34Eu0p/kr/6L88ci2YQskz6kYm1k/jyD2Yd4A4eCr7LCf8OpqvLeI+cQbCzaaRwQZUDJ9L50pvhoMcmGIciIng+WCyNIsBEkm3BjyvXsZgytevqftSFZurpvhhKE8SyB48/7mNLLV8b4NH7H/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570815; c=relaxed/simple;
	bh=WJ4THiX5Nb3E14h0OCaKfi3/fwF9XV0bf5kgr1/Tcwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhs90q2x1AKM+Ga4IflBY8ydA578F/VSlm/gnOhVgU1vzkAdCdEkHhgj+NPwnTSs4dn9Cs82IQRwEOk6QlLwbpuS9VPdY1r3LVuTiTnATUva+CgBEtDJIjhstHp6blMMIU0YIoDSidrHMkW7ne16wXpWoeOShmGxjP8NOQ3piTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=LP04l29Y; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="LP04l29Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1769570805; bh=WJ4THiX5Nb3E14h0OCaKfi3/fwF9XV0bf5kgr1/Tcwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP04l29YtSocxgfnNBrAAdN6oR0f4NknK7lA5QVJZoHUXv8FcLMJEujHWC3VZmuA/
	 FqfiipEq6S5YIK1WX3Nj7UzzPBBRtFCjbf5eJIPm5dfu/RPcv821DsCuRAfMP4s6QQ
	 g8k3fy4qJKGB6Sb/XpdbdAzdAmHvtEEcHsBQ2roQUTHX0kfshKCR2gsMPXoTlDZsSs
	 We+6348BtGIqOgIePaGG0NnFSD6Y74Zn43i1D+sGOJGL/HCtNt3ZyYo4dz9DKQzAv+
	 8mNqN2LWUdP0MxiHCFX4FcpzWjZJyPnRcA7tJG70JfhBm1APehuka2wd+BkTrV293Q
	 3kU+IXC7duoGQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 7625AAAF; Tue, 27 Jan 2026 21:26:45 -0600 (CST)
Date: Tue, 27 Jan 2026 21:26:45 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
Message-ID: <aXmB9XIzmRlwSdx4@mail.hallyn.com>
References: <20260122141303.241133-1-omosnace@redhat.com>
 <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>
 <aXgcd81ktMaAHhwj@mail.hallyn.com>
 <CAHC9VhSLi2-TBUyayML+tAuC+XF7jCAAL48oCB4qQqTrGXcMyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSLi2-TBUyayML+tAuC+XF7jCAAL48oCB4qQqTrGXcMyA@mail.gmail.com>

On Tue, Jan 27, 2026 at 05:06:47PM -0500, Paul Moore wrote:
> On Mon, Jan 26, 2026 at 9:01 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Mon, Jan 26, 2026 at 05:50:12PM -0500, Paul Moore wrote:
> > > On Thu, Jan 22, 2026 at 9:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > The IPC sysctls implement the ctl_table_root::permissions hook and
> > > > they override the file access mode based on the CAP_CHECKPOINT_RESTORE
> > > > capability, which is being checked regardless of whether any access is
> > > > actually denied or not, so if an LSM denies the capability, an audit
> > > > record may be logged even when access is in fact granted.
> > > >
> > > > It wouldn't be viable to restructure the sysctl permission logic to only
> > > > check the capability when the access would be actually denied if it's
> > > > not granted. Thus, do the same as in net_ctl_permissions()
> > > > (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
> > > > so that the check never emits an audit record.
> > > >
> > > > Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysctls at open time")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  include/linux/capability.h | 6 ++++++
> > > >  ipc/ipc_sysctl.c           | 2 +-
> > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > This change seems reasonable to me, but I would make sure Serge has a
> > > chance to review/ACK this patch as it has a capability impact.
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > Thanks - looks good to me.
> 
> I don't see a dedicated IPC maintainer/tree, do you want to take this
> via the capabilities tree Serge?

Will do.

-serge
