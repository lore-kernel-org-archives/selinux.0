Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39B3BFADD;
	Thu,  4 Jun 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550977; cv=none; b=KPhtP0dh5DiFje9Jk+ZrZOlZz13o8MUP/lmIVeVi0yAWsBxXt3MYwWdxFcEw/vx4fKMUWB1BRp4t4hr1PfyZioxkB7ENBJSV17H3AZvvvW7Y9nDA8e9Q7EEDuxUzpDjxo+HqLOjCRwSD1aL8uoTM2xZJzepWgHsUGJuSUQLPXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550977; c=relaxed/simple;
	bh=4WMQgg6DPMUIZY9P7lT4fai9mXuLcC6KDBJqTXBYH1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3LX949GKjfybJdZJKkzbcKHM1SQl8bGXlTSEpk+BRm5N9fzqDLxVVaawTUp18FHJ+W0J/SblCd3p4v6q7fw27q0dsAYk7B3t8yoBJ6gbd1GvISKaU+MCYdqpHG+bVYWS0UZP//60htvniYu3d+RlcZp44FZCl8fuoKuDJatav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPVt4nxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPVt4nxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655DD1F00893;
	Thu,  4 Jun 2026 05:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780550975;
	bh=5zuxq2FpJzfF6/2M62C/sHZpioy1ojsKxf3A1jxejVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPVt4nxfOmrkYTqtguEpj9HZV5ze1O3ukV3K7vyVFhRU1phY4HL3uxXgQuBKNc/tv
	 3N9bnV0tUgoDxLngWIfR5ceHIqBK3kS7WYzYuYiezDU6qIUMzDIFbt3ElXQKU3RkXK
	 JtAhWPPgmFpYLkWgjqzI60i4GnQvY/WElDI3v6xXsuCHVQ0YrOfJu78UiL0h0DxDJx
	 WYZAXeo0BmXtICdVhNYaNNwjlCmAWIP8Cmh1Hjkevv3uUQDJdj9uhbSh1pP15Uuwoi
	 JTZfHCQGSFLVfN4mxzm2DVVOgY3gGG4Ela9vDwcmglPyEx2uGDtbPylolNPWfTy9Dz
	 L8y+wcL7LHNLg==
Date: Thu, 4 Jun 2026 08:29:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
Message-ID: <aiENOZQbUOp8MSCV@kernel.org>
References: <20260531165852.1478916-1-rppt@kernel.org>
 <CAHC9VhQ9mMhswzmy3745HbXbe_xm0aeJOmTG1PiDHtv1=zTG6A@mail.gmail.com>
 <ah6uXccHdngEUKr8@kernel.org>
 <CAHC9VhSFRyFZSxu0jeA_Wv9bU3MgmEWpQMnzP5Q=vRBXe-m++g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSFRyFZSxu0jeA_Wv9bU3MgmEWpQMnzP5Q=vRBXe-m++g@mail.gmail.com>

On Wed, Jun 03, 2026 at 12:08:04PM -0400, Paul Moore wrote:
> On Tue, Jun 2, 2026 at 6:20 AM Mike Rapoport <rppt@kernel.org> wrote:
> > On Mon, Jun 01, 2026 at 02:11:11PM -0400, Paul Moore wrote:
> > > On Sun, May 31, 2026 at 12:58 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > >
> > > > selinux_genfs_get_sid() allocates memory for a path with __get_free_page().
> > > >
> > > > Such usage does not require a "page" and the size of the buffer should
> > > > actually be PATH_MAX which may be less than PAGE_SIZE on some
> > > > architectures.
> > > >
> > > > Replace __get_free_page() for allocation of a path buffer with kmalloc()
> > > > and make it explicit that the buffer size is PATH_MAX.
> > > >
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > ---
> > > > v3:
> > > > get the args in the right order
> > > >
> > > > v2:
> > > > * explicitly use kmalloc() with PATH_MAX
> > > >
> > > >  security/selinux/hooks.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Considering the problems with the first two versions of this patch I
> > > have to ask what sort of testing you've done on this?  I know it's a
> > > trivial patch, but we're on v3 ...
> >
> > Boot of fedora on an arm64 VM with 64K page size kernel.
> 
> Given the minimal testing, the problems with the previous versions,
> and the fact that we are at -rc6, I'm going to hold this for the next
> dev cycle.

Fair enough :)
 
> -- 
> paul-moore.com

-- 
Sincerely yours,
Mike.
