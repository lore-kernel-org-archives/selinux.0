Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719223D7DC;
	Tue,  2 Jun 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395620; cv=none; b=FPZC2Aq/GkVEFgOvP0dpzDvEx6zrl09u/PiuQl6i4GFluNRKjr5PcxNiyphq53L+4B05zKkIY4laSA3XqzaPr4OEKfffZQI1SYr6LrHLCsJGywEf7px6zIk+1kefrj2FWyeXH67SV71JoaY/CYGL1l06FYoqVrY87kK2P////sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395620; c=relaxed/simple;
	bh=YDdS5uYllEtBChgaMSSRlIkpBGYUTeSA6at/xWZahoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP1EszyBYCgeiHdEnqRJxFCrzajaNNB2B6QUmMrjiJndAAK/kFsGXk6PA3yFkTj5HYPfjnyoBRlWpHM2EH07KCzS3O/mTZTc1j3d2Oda1Ppuyuo8JpG6lFaFP+sdjXkmeJgUuAS3B/XvK5hQCiTA++GPHRJrDcsJtveO3WO+fSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEb/8NEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEb/8NEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D81F00893;
	Tue,  2 Jun 2026 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395618;
	bh=If9GAHrLf11lvjIs6Epp8CEFexswmvL6Idi2KBgSHNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lEb/8NEFixCHIsdcA9Dn4wrh7XwrLS3qQNN04i7t44vuZiJSppU12ubTZMvGXl3Fv
	 TlgcYy4hhgwOBsvsm5gipYtUyCiJCndE5EJ3UdUBwLNxzA2ylToyQRbDw/EqWHr+Fv
	 W4aE8IbLcrrs59Vx6lE2ElTBFF09ZFFzzYs7Zm/90hPqDRJDcbENqMghfFRNo4eVU7
	 cDL7l9QGMHwWYXZoA1/cydJP5Jo9D4OyUCLE7/RHHLiavUWtEGGuHUwv8JKRZ7bSuD
	 lyyPVwAgJ46X3IEunwyj05YyDNmxn6UV0XfOB3igQp0njUPHC2FGqYI1+ppbuNKucn
	 cBJmWCNxQ9n/Q==
Date: Tue, 2 Jun 2026 13:20:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
Message-ID: <ah6uXccHdngEUKr8@kernel.org>
References: <20260531165852.1478916-1-rppt@kernel.org>
 <CAHC9VhQ9mMhswzmy3745HbXbe_xm0aeJOmTG1PiDHtv1=zTG6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ9mMhswzmy3745HbXbe_xm0aeJOmTG1PiDHtv1=zTG6A@mail.gmail.com>

On Mon, Jun 01, 2026 at 02:11:11PM -0400, Paul Moore wrote:
> On Sun, May 31, 2026 at 12:58 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > selinux_genfs_get_sid() allocates memory for a path with __get_free_page().
> >
> > Such usage does not require a "page" and the size of the buffer should
> > actually be PATH_MAX which may be less than PAGE_SIZE on some
> > architectures.
> >
> > Replace __get_free_page() for allocation of a path buffer with kmalloc()
> > and make it explicit that the buffer size is PATH_MAX.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> > v3:
> > get the args in the right order
> >
> > v2:
> > * explicitly use kmalloc() with PATH_MAX
> >
> >  security/selinux/hooks.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Considering the problems with the first two versions of this patch I
> have to ask what sort of testing you've done on this?  I know it's a
> trivial patch, but we're on v3 ...

Boot of fedora on an arm64 VM with 64K page size kernel.
 
> -- 
> paul-moore.com

-- 
Sincerely yours,
Mike.
