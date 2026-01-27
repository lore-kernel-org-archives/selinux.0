Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD282C8F0;
	Tue, 27 Jan 2026 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479292; cv=none; b=tPC2K/hMGqA1HbIGPlmCfEyV4m5tjvuYmFlgjfl+W1+bSrmtD90sKeZH/4+z2Z01l5iaMcfoWHYjn1TErBwOmBvBpPKIzw9Xh/0h0kq1SRDCj2hKCl3CF6i/QfucpFViJ+obZ8I5NNr+EjJt09gRS3sqfOH7drVthIaRPZJEcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479292; c=relaxed/simple;
	bh=QN4/btfx/fcl0dQBEMK6u3sMein4aBCe1JuD/E8eMW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7vgp7DFDkqBvkVO8GeOpzHrR3twfe08UwI9fsdAzhnE00NnG7K0XKdME3v/w0P396bsStrQhtQt+LI8szYrYGYck75JV09pOsmONBqSXCfcAKmnPhM0RDIDdt8Oo6tmxiFmATXBZWK98Wl5YVaLQwhEbRYbfrgIOfqkfDxG7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=jlGtltkZ; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="jlGtltkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1769479288; bh=QN4/btfx/fcl0dQBEMK6u3sMein4aBCe1JuD/E8eMW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlGtltkZi3aE92UKd2gvDnfJh4I+w4g69ym4yGM9jGIF01k//xdb+wA+wqAuwZHo8
	 C6LU08k2+cRjPdHx1nT92eC2cQLLErwqgrdhzLF96cnYyukKDGqnYAwjK/XUR9lvbi
	 l0AIZAAAvJBOLStFLJQ/vctgq7u6gG5yOUYsSS/cddHIHNwIL6Grf8PNHlImwke3xf
	 CZOZ8hIGMZbNIP18k245hfYccMiQa8AV8We2K2gFLz9dt4D0LBW+OALHdAIfBLW/Vu
	 FvRcrk/rmfSrGO0PaQLhr2+50Sjpm3BOeE4kM86Ma5BTrpTPlA1NpXABr9evG5nUG6
	 G4xOJuL/BvSMA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 02F7843D; Mon, 26 Jan 2026 20:01:27 -0600 (CST)
Date: Mon, 26 Jan 2026 20:01:27 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Serge Hallyn <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
Message-ID: <aXgcd81ktMaAHhwj@mail.hallyn.com>
References: <20260122141303.241133-1-omosnace@redhat.com>
 <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>

On Mon, Jan 26, 2026 at 05:50:12PM -0500, Paul Moore wrote:
> On Thu, Jan 22, 2026 at 9:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The IPC sysctls implement the ctl_table_root::permissions hook and
> > they override the file access mode based on the CAP_CHECKPOINT_RESTORE
> > capability, which is being checked regardless of whether any access is
> > actually denied or not, so if an LSM denies the capability, an audit
> > record may be logged even when access is in fact granted.
> >
> > It wouldn't be viable to restructure the sysctl permission logic to only
> > check the capability when the access would be actually denied if it's
> > not granted. Thus, do the same as in net_ctl_permissions()
> > (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
> > so that the check never emits an audit record.
> >
> > Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysctls at open time")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/capability.h | 6 ++++++
> >  ipc/ipc_sysctl.c           | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> This change seems reasonable to me, but I would make sure Serge has a
> chance to review/ACK this patch as it has a capability impact.

Acked-by: Serge Hallyn <serge@hallyn.com>

Thanks - looks good to me.
