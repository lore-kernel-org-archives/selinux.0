Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37335E936;
	Sun, 31 May 2026 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246530; cv=none; b=S4EAyQNqNEQA6KeDKWJ3jwBfzN3x7YNm5DS3botJdzl1qW6H08jnSIholSRLCc4kSXMisc0s3N7c/lYv3zQlyik/jppfKibCxCbQJfLKSvZ/3Ulf5YtezdJfzDS3Rp2S7kHWa1Jhbxr/nTpO5KL7EkXXYKMsOYiedK7WYkMICl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246530; c=relaxed/simple;
	bh=WT3HrW/9gLPLyDFgTN+QlyBw8x5vyQeMYZneYXbZ4J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYneq9KshyqdPT/P80FExCezqm71wvV1w588jNYQppmMbKJVYBGTCXVm8c7Af74qY3evCcb7xJR/ebhJ5vab70NBvhPkjTN7gPM0cJj+d9eUzME84x98TX1pdOPGPGfHpDFZH4NWUVHMCIcHJ3LW9RAkx3y9PXpoq/3bKY/ZV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akz1WPox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akz1WPox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12871F00893;
	Sun, 31 May 2026 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780246528;
	bh=3hq7tyMSASLqjd50ZjUsZ/oP679Wz/Tts2VDon61gao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Akz1WPoxPxn2UruDRl6pzGMB5PN0tsAhyOxVpySrSgRtoRSmhOlQS/GU1snsUMogU
	 LEDZdytNEQG5plXduK8Wm4FYA/WPC5ec3P6RnbZVfKhC8t4Pjl+CxTRFoZCv/6galv
	 EsP5ReqWiEa8upTOPFxVNhH3BUMS1LN2m/+uOZshcV3ENxBhG6kyN4o6Jo6am5whDy
	 T/ItkSuzswLVzL5CtlRYvB3gnn7xKUAqwCUSfX1wDxcQWmnI9M8OUcqibXeCuw+5oQ
	 LZlD4skprZiUa6TAUTkq+nG0Db7GsgJAqI6uiphE6xEvPwloBnJo0Rc0YKtXWN917G
	 T0g7P6A7Fi8bA==
Date: Sun, 31 May 2026 19:55:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: hooks: use kmalloc() to allocate path buffer
Message-ID: <ahxn-oi3BTrW45ES@kernel.org>
References: <20260531151502.1467515-1-rppt@kernel.org>
 <20260531171811.16abb087@pumpkin>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531171811.16abb087@pumpkin>

On Sun, May 31, 2026 at 05:18:11PM +0100, David Laight wrote:
> On Sun, 31 May 2026 18:15:02 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
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
> > v2 changes:
> > * explicitly use kmalloc() with PATH_MAX
> > 
> >  security/selinux/hooks.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0f704380a8c8..19493198ece1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1336,11 +1336,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
> >  	struct super_block *sb = dentry->d_sb;
> >  	char *buffer, *path;
> >  
> > -	buffer = (char *)__get_free_page(GFP_KERNEL);
> > +	buffer = kmalloc(GFP_KERNEL, PATH_MAX);
> 
> At least get the args in the right order.

oops
 

-- 
Sincerely yours,
Mike.
