Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A61A08A3;
	Thu, 11 Sep 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631911; cv=none; b=RBs+ZvJ8wKybf7bEe1eqpBvbkguPhw2Wkp6XKEjQcb1j/UHlj0REic8jQ6g7j6RvhPcieddOOtQdR24rFBNi/+zsWPS+Ea1tI0SPqAHG27HHAp75WiFOcdKbeH8nvZyzwA/uBDDSNRUfjAgwUCHfUhk2r5PP0g020zpd2hWJq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631911; c=relaxed/simple;
	bh=gFDDD0WpyznxGP95sLwGd53MUAD0tWTC/LTbrcnsw6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCd4MQFv2lZb51x7StZG1q/OgKEJpHeVtZGAZp+a2CEWrbVi9WU0S7qLy7A4xrqpwD77T5GkrL0GjQT8HcB1nh4au3/9mQJBSfLhh0RMQKmD8gCJ3qdCloCvaxbYlGTJF3xvsB3ZsslHMGNRwsxTM2d7dINEu7RG29ngXn3bwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A31F19AB; Thu, 11 Sep 2025 18:05:05 -0500 (CDT)
Date: Thu, 11 Sep 2025 18:05:05 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgoettsche@seltendoof.de>,
	linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net
 sysctl  permissions
Message-ID: <aMNVoSM7PauOrCPF@mail.hallyn.com>
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
 <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>

On Thu, Sep 11, 2025 at 04:46:20PM -0400, Paul Moore wrote:
> On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> > 
> > The capability check should not be audited since it is only being used
> > to determine the inode permissions. A failed check does not indicate a
> > violation of security policy but, when an LSM is enabled, a denial audit
> > message was being generated.
> > 
> > The denial audit message can either lead to the capability being
> > unnecessarily allowed in a security policy, or being silenced potentially
> > masking a legitimate capability check at a later point in time.
> > 
> > Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> > determining net sysctl permissions")
> > 
> > Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> > CC: Christian Brauner <brauner@kernel.org>
> > CC: linux-security-module@vger.kernel.org
> > CC: selinux@vger.kernel.org
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > ---
> >  kernel/pid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks.

Acked-by: Serge Hallyn <serge@hallyn.com>

I'll queue this up in the capability tree, unless Christian wanted
it in his.

-serge
