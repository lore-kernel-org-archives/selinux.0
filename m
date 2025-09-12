Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F42820CE;
	Fri, 12 Sep 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705750; cv=none; b=ZPrJl/5suzOaqJrbZAfKFyw9K1eOxw4YndBUQSwoNY4HfFnvQdlOZjcbf5gAfud+31vY1B8TkpnjL6f0DSxEBKhff0kts+kUpGlytagS7DasI1CujVf36vysoe88WUbASCMnBdwnUIf8Rzx8lKQZMhjeymmICSv3Xytd4FOpW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705750; c=relaxed/simple;
	bh=SjJ0VcWCjt0u1EFNc4qhH5k6zxfmE8RxTEhGLkBCWz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDA3HdQXuGY2L/bNlPYo8P4KJg33S99yCJ/li19nHMAT7O5GH9/QTc7k0hjE1bZ7Q8eoC25njXCT3TI1uuvqdg+yXXvjJofnk/7uwxqLp4DDj9DV+MDnbPTp2UCF1NAz3Qm+cNnrBZhOvSy81I5YLG0fUtHnIIEXL4hX8PbC0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 42D4FB2A; Fri, 12 Sep 2025 14:35:45 -0500 (CDT)
Date: Fri, 12 Sep 2025 14:35:45 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgoettsche@seltendoof.de>,
	linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net
 sysctl  permissions
Message-ID: <aMR2EfsdxmIXIgTW@mail.hallyn.com>
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
 <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
 <aMNVoSM7PauOrCPF@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMNVoSM7PauOrCPF@mail.hallyn.com>

On Thu, Sep 11, 2025 at 06:05:05PM -0500, Serge E. Hallyn wrote:
> On Thu, Sep 11, 2025 at 04:46:20PM -0400, Paul Moore wrote:
> > On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> > > 
> > > The capability check should not be audited since it is only being used
> > > to determine the inode permissions. A failed check does not indicate a
> > > violation of security policy but, when an LSM is enabled, a denial audit
> > > message was being generated.
> > > 
> > > The denial audit message can either lead to the capability being
> > > unnecessarily allowed in a security policy, or being silenced potentially
> > > masking a legitimate capability check at a later point in time.
> > > 
> > > Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> > > determining net sysctl permissions")
> > > 
> > > Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> > > CC: Christian Brauner <brauner@kernel.org>
> > > CC: linux-security-module@vger.kernel.org
> > > CC: selinux@vger.kernel.org
> > > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > > ---
> > >  kernel/pid.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> Thanks.
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> I'll queue this up in the capability tree, unless Christian wanted
> it in his.
> 
> -serge

I've included this in git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git#caps-next

thanks,
-serge
