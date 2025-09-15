Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305F3431E9;
	Mon, 15 Sep 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947843; cv=none; b=frURZPqZUgbDv4WXwEkuHjyh7vAFR/wWwdG38UdTE3T9821eflmnTPKlKz60v8EhyoB9FFxUn13UXwhEHRaBSVCob1cwL54q5NnR1nbgmqhX/hRpIOi9rDIYZm4tOBDM2R2mWSE97DjESRYPBeo+5pBLP3uknzsSME9nu9QX4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947843; c=relaxed/simple;
	bh=X7joDIQOhd4EYaEdt0UM/m+z3DLeB8OZMqEr8/8P3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWVioLxi3xw8GPw0XeFOkf93+x3nEx8QrMpE/tFiUuu0AP8TeyJ/IWVYE3HYBlLK2hWdKVdqwU5avQpVodcvA0dUrRtBowf2mOEeIQyc3Noa9CfgO15NujQdB4wGrSUoeLQRQOQExbf0doPTlA0rST0NHXRkIVcDKN8LFxmmmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 04E63499; Mon, 15 Sep 2025 09:50:32 -0500 (CDT)
Date: Mon, 15 Sep 2025 09:50:32 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgoettsche@seltendoof.de>,
	linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net
 sysctl permissions
Message-ID: <aMgnuMB4ycJX5VdL@mail.hallyn.com>
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
 <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
 <aMNVoSM7PauOrCPF@mail.hallyn.com>
 <aMR2EfsdxmIXIgTW@mail.hallyn.com>
 <20250915-geldquelle-magie-eb9075a9764e@brauner>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915-geldquelle-magie-eb9075a9764e@brauner>

On Mon, Sep 15, 2025 at 04:13:16PM +0200, Christian Brauner wrote:
> On Fri, Sep 12, 2025 at 02:35:45PM -0500, Serge Hallyn wrote:
> > On Thu, Sep 11, 2025 at 06:05:05PM -0500, Serge E. Hallyn wrote:
> > > On Thu, Sep 11, 2025 at 04:46:20PM -0400, Paul Moore wrote:
> > > > On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> > > > > 
> > > > > The capability check should not be audited since it is only being used
> > > > > to determine the inode permissions. A failed check does not indicate a
> > > > > violation of security policy but, when an LSM is enabled, a denial audit
> > > > > message was being generated.
> > > > > 
> > > > > The denial audit message can either lead to the capability being
> > > > > unnecessarily allowed in a security policy, or being silenced potentially
> > > > > masking a legitimate capability check at a later point in time.
> > > > > 
> > > > > Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> > > > > determining net sysctl permissions")
> > > > > 
> > > > > Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> > > > > CC: Christian Brauner <brauner@kernel.org>
> > > > > CC: linux-security-module@vger.kernel.org
> > > > > CC: selinux@vger.kernel.org
> > > > > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > > > > ---
> > > > >  kernel/pid.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > 
> > > Thanks.
> > > 
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > 
> > > I'll queue this up in the capability tree, unless Christian wanted
> > > it in his.
> > > 
> > > -serge
> > 
> > I've included this in git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git#caps-next
> 
> What's easier for you? Just want me to stuff this in the pidfs pile?

Oh, sure - I can drop it from my tree, since it's the only thing in there
right now.
