Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141516F288;
	Sun, 22 Feb 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790305; cv=none; b=AlIYgkxkOqLjGBQESFrEuQN4uLsB4YdDUO4RuHQYxlnjems76MHQTk5GWIjCuBt2SQRI75eCIN7cdhFdt6rENgQ8nJcMG4TqNpIFL8295CiFZAgu7TQQi6duzX8plHcgnHhh4O5rKoEJos0WBYxRAIgvJ3b/yjg4uHISGlrBGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790305; c=relaxed/simple;
	bh=wEZ2iXj9fKWRKgqv3okN8kg0V6cL2BHzXcExwQymWNs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MSwJ67Ngk6ZVZkDb7SIfu6NKCSoEhFPo3/ihEKq9ltN48b2Er6/pv3cp+7FSVBzBY7Yu2zuNZMwTF56DknF1zzYDGO1+bnCc74pc6Zt2bH4Hq3Dw115xTpLiHsc84WfiUglrLQPeVxZW8Zk3UGjif9qjllxzcG5+JY2k6+KkxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SBJ+6oAl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SBJ+6oAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112FAC116D0;
	Sun, 22 Feb 2026 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771790305;
	bh=wEZ2iXj9fKWRKgqv3okN8kg0V6cL2BHzXcExwQymWNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBJ+6oAlEn3KD3oKjm0R0Qv0TZ+RgCxgFZs5XghOt3Q6e1QrG7zURCQuASPxzgpHd
	 mfQHZ7gxSHpUT+2Gpijv81i4vFcqm6/7F0y90Cdj/9GnkTPmubXRth9subktg5LFgK
	 EIi9yPWuYxw2/hUAcAfPmJPn/QLkxBppPcqifBUg=
Date: Sun, 22 Feb 2026 11:58:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using
 ns_capable_noaudit()
Message-Id: <20260222115824.37ae0de1eb183997a23669ae@linux-foundation.org>
In-Reply-To: <CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com>
References: <20260122140745.239428-1-omosnace@redhat.com>
	<CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
	<aXgZI1td0Hremulj@mail.hallyn.com>
	<CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
	<CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 17:09:40 -0500 Paul Moore <paul@paul-moore.com> wrote:

> > > > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >  kernel/ucount.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > >
> > > Looks good to me.  What tree should this go through?  Network?
> >
> > Andrew has already applied the two patches I posted into his
> > mm-nonmm-unstable branch, so I assume they are set to go through his
> > tree.
> 
> Andrew, any chance we can get a reply to these threads when you merge
> a patch into your tree?

I already spray out soooo much email.

A better approach would be for me to become more chatty.  Reply
"thanks, applied <reasons> <caveats> <etc>".  Shall do this.

