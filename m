Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345931B11D;
	Mon, 15 Sep 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945601; cv=none; b=d5yaho0jA243YvmY2voeJ0YHuIO1HCl8JDBin9zS2RYaFa4Aui5Ju+L/gjRGswE2OpNo8SIGU6TCmikz3zsoMWLSBTVkXLmp8WtFkR0bIuarJrRb6l2YVSHPIeQ6vNY1H0bHNyQYr85FItE9QAesu30lLKTRSrbhzfuB9b5ZOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945601; c=relaxed/simple;
	bh=0cCPjJYK75D1WdBdZxyE8lIBFq6PCEYmqht+9Premig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI5vUfu3E0jtz1nk+I4neqlKQJD9yJ1VasfL+Ju86EjExy7aBsQymUMcuuq0rIlbyXnO/Q+PZgX4nunJlOKzTRr01O3J5qwChUvmeny1FoD18SLbBUt49y5hrX1Q/y/BoGLrDEJ4mqHvSz9uiOAIqLZSttK6D6VxAV3wdTuYf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uftcIm6J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uftcIm6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A21C4CEF1;
	Mon, 15 Sep 2025 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945600;
	bh=0cCPjJYK75D1WdBdZxyE8lIBFq6PCEYmqht+9Premig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uftcIm6Jn82EoEVC1y+tcUCF2l5MhKDLYvN2tzm0NbTgXZW5VxPFkg+UJT5mjQU4N
	 JkciRIMrAD87kb3If9lLQrhAahcHtszurbGDJGEQ2UMz4nWgff4158cvIqgRMUnlj/
	 wlvG2VIecEvEp9X4xbx55eaW4M6wuBvwPX5Y067Je6ZIzF74q/hlo70ZFIMebNnQXY
	 gyAedsneQCQUYUmkBKuH0ox588wQOYAK8vv2GANjZAEK6TujTlWpLNd1GBP5fheyT7
	 6qTs5zDrR/ZPUfMR+sgreHpk/TTXThakq5muO8hnDGIX/EQvHMbpgoTWIZ5A7sgjTo
	 RVeryGQnoxYWQ==
Date: Mon, 15 Sep 2025 16:13:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgoettsche@seltendoof.de>, linux-kernel@vger.kernel.org, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net
 sysctl permissions
Message-ID: <20250915-geldquelle-magie-eb9075a9764e@brauner>
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
 <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
 <aMNVoSM7PauOrCPF@mail.hallyn.com>
 <aMR2EfsdxmIXIgTW@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMR2EfsdxmIXIgTW@mail.hallyn.com>

On Fri, Sep 12, 2025 at 02:35:45PM -0500, Serge Hallyn wrote:
> On Thu, Sep 11, 2025 at 06:05:05PM -0500, Serge E. Hallyn wrote:
> > On Thu, Sep 11, 2025 at 04:46:20PM -0400, Paul Moore wrote:
> > > On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> > > > 
> > > > The capability check should not be audited since it is only being used
> > > > to determine the inode permissions. A failed check does not indicate a
> > > > violation of security policy but, when an LSM is enabled, a denial audit
> > > > message was being generated.
> > > > 
> > > > The denial audit message can either lead to the capability being
> > > > unnecessarily allowed in a security policy, or being silenced potentially
> > > > masking a legitimate capability check at a later point in time.
> > > > 
> > > > Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> > > > determining net sysctl permissions")
> > > > 
> > > > Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> > > > CC: Christian Brauner <brauner@kernel.org>
> > > > CC: linux-security-module@vger.kernel.org
> > > > CC: selinux@vger.kernel.org
> > > > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > > > ---
> > > >  kernel/pid.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > 
> > Thanks.
> > 
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> > 
> > I'll queue this up in the capability tree, unless Christian wanted
> > it in his.
> > 
> > -serge
> 
> I've included this in git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git#caps-next

What's easier for you? Just want me to stuff this in the pidfs pile?
