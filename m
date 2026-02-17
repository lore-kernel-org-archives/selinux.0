Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5C32C33D;
	Tue, 17 Feb 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329697; cv=none; b=eYc6IJn7PSswlf6bBd9lZyg3iXWPXReEq7SgPpUxzkSOs+AoX4rMqr9eXmMr1pFFJveRibTHbw6ztoCVqcvN5WEvlViC+jZwGmNM1ajrsbekJE18Ebfkdz8puGihM2ryHmsJFIzWCgp0NV+KKRtAkTPtXGlRmq76tC7Jnr5xlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329697; c=relaxed/simple;
	bh=87110GAXLqxdBCfG4XAbyUPM+jV4Yr/SrlSTRgKoWfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ0si+hht5Y0dHKxX8pduvq7jb67DWUOBBQ4q3K5Eke+OEtnoyZJlyvJ+BLDPqX2WNliXqAV7AfvnN9pzKq0QpplTiYtCBUeB2ICCFSIGJyNR5vwD0UOqrvHItvwKlq4eakeCpm+df3RGpPJew7/brWCzC0pIH5SzWpKvFCmepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSF4Dk0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSF4Dk0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBF1C4CEF7;
	Tue, 17 Feb 2026 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771329696;
	bh=87110GAXLqxdBCfG4XAbyUPM+jV4Yr/SrlSTRgKoWfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSF4Dk0ouulB3cq0WIY+q9T9iqcGGzYebmI8MIRNB2OGqzK5YZm7DwqCxatf9JXrz
	 B2ev5fDIrI7xEDQvmHxbCHSL1juJ4xIk769kkcmXvJjMlxbUu+4eN991G+RF9W2CFF
	 ES5ItpPvf90w5K9ogzdXnEkRBPx3UEgm/9U11C3mtJouO5P0pATiEXkGlgUZ2vj5/K
	 416KGlIX5BQxc/DUlv61Ze25otA2I6m4WP4wDYthPC13977XfhJbZqnEBtf0e+GoNw
	 6Tjpcce+stT2IBHiwfu24s78mXpUREB2PyJTGYgfzzTRYtfiXhKf8oZb+F+QA/LYCm
	 o9M8lz/SWOhoA==
Date: Tue, 17 Feb 2026 13:01:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
Message-ID: <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
References: <20260206180248.12418-1-danieldurning.work@gmail.com>
 <20260209-spanplatten-zerrt-73851db30f18@brauner>
 <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>

On Wed, Feb 11, 2026 at 02:43:21PM -0500, Daniel Durning wrote:
> On Mon, Feb 9, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wrote:
> > > From: Daniel Durning <danieldurning.work@gmail.com>
> > >
> > > Added a permission check to pidfd_info(). Originally, process info
> > > could be retrieved with a pidfd even if proc was mounted with hidepid
> > > enabled, allowing pidfds to be used to bypass those protections. We
> > > now call ptrace_may_access() to perform some DAC checking as well
> > > as call the appropriate LSM hook.
> > >
> > > The downside to this approach is that there are now more restrictions
> > > on accessing this info from a pidfd than when just using proc (without
> > > hidepid). I am open to suggestions if anyone can think of a better way
> > > to handle this.
> >
> > This isn't really workable since this would regress userspace quite a
> > bit. I think we need a different approach. I've given it some thought
> > and everything's kinda ugly but this might work.
> >
> > In struct pid_namespace record whether anyone ever mounted a procfs
> > with hidepid turned on for this pidns. In pidfd_info() we check whether
> > hidepid was ever turned on. If it wasn't we're done and can just return
> > the info. This will be the common case. If hidepid was ever turned on
> > use kern_path("/proc") to lookup procfs. If not found check
> > ptrace_may_access() to decide whether to return the info or not. If
> > /proc is found check it's hidepid settings and make a decision based on
> > that.
> >
> > You can probably reorder this to call ptrace_may_access() first and then
> > do the procfs lookup dance. Thoughts?
> 
> Thanks for the feedback. I think your solution makes sense.
> 
> Unfortunately, it seems like systemd mounts procfs with hidepid enabled on
> boot for services with the ProtectProc option enabled. This means that
> procfs will always have been mounted with hidepid in the init pid namespace.
> Do you think it would be viable to record whether or not procfs was mounted
> with hidepid enabled in the mount namespace instead?

I guess we can see what it looks like.
