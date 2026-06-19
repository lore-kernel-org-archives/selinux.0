Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB06371D01;
	Fri, 19 Jun 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864281; cv=none; b=jk9QG1cY+K8eMf8pFTi6i3/PJWER0zv8vT6ftHfdffIlBZ6YQ+3Z+c2mzyuf9BUi92by9jjXLGLdQJK+QNgGBTB7r6hqvfbke0uX/2COb10/AQUoAUZ8ruBVpzIbT1GsuElDqDrc6Onyyte5NgThRW6Bba3TK5g3FoGL27EQ4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864281; c=relaxed/simple;
	bh=qQi7kBBFAEb6/XyAoHXmTC55k9Og2OT1CsKWKA889SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfsCzHKvFGpHJ7u+O4NTwMMo+Ew+tPDeClx8+6Ltm9fSlgz1GD5E3+r+N40ydkeh/8Syw0e+WDkmh9yva+nuuPTMoI/UphZA3ZdyTKE/eIDnrypC/qUTBL1ADmPE0eYVXULUr+Ig6/HZcMqfxOoaurWBUo4ErR6ZH0owSE38DwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEMch4df; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEMch4df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379401F00A3A;
	Fri, 19 Jun 2026 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781864279;
	bh=ae1YKTBNFcFwdCKOp1T2k7Nf8bg48XF28nQkhHxpLko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SEMch4dfpOIqK9Z2xBdzfX5bXdXEotlLZr50wbAA2Uv1mlsdsO9VZ6urRtlHyYNPI
	 wKI49Z1c6xh/T8jmJ21t3RcOhQmvKcROuanrXece92Dd5IvhPoVOrc6DLvxC/OAi8x
	 e/dqm1SgD4VnhA9llbjBdmxhNucCFQyc21+pFhrqz8JvT8lhhugAyxd5DJz18Tp6ho
	 wQNvv/Pt8dlfW8dzaDPAx1dMNpvbUZyerCvMaDZqmZIBT9i4nvLQbZeXj6Gy532zBw
	 2Az/McSvvKB0yYvv3LDUJNbankMcKY2//sIPdfHDjZ1U0ysGftFiOiG/cKC0bH1vRd
	 6ur359tJBJ1cQ==
Date: Fri, 19 Jun 2026 12:17:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, herton@canonical.com, kernel-team@meta.com
Subject: Re: [PATCH v5 7/8] vfs: Replace
 security_sb_mount/security_move_mount with granular hooks
Message-ID: <20260619-seenotrettung-gegliedert-schrank-a21d993b87d0@brauner>
References: <20260528182607.3150386-1-song@kernel.org>
 <20260528182607.3150386-8-song@kernel.org>
 <20260617-laufbahn-eifrig-charmant-a48f357a0c52@brauner>
 <CAPhsuW7Wn8GYrsrRhEFXQH5buaP+pdTKc0UV8Mn0B3OnNN-44g@mail.gmail.com>
 <178179134209.111814.12159888808546010170.b4-reply@b4>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178179134209.111814.12159888808546010170.b4-reply@b4>

On Thu, Jun 18, 2026 at 04:02:22PM +0200, Christian Brauner wrote:
> On 2026-06-18 18:56:42+08:00, Song Liu wrote:
> > On Wed, Jun 17, 2026 at 9:53 PM Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > On Thu, May 28, 2026 at 11:26:06AM -0700, Song Liu wrote:
> > 
> > [...]
> > 
> > > >
> > >
> > > This again is racy as it is called outside of the namespace semaphore:
> > >
> > >         err = security_mount_bind(&old_path, path, recurse);
> > >         if (err)
> > >                 return err;
> > >
> > >         if (mnt_ns_loop(old_path.dentry))
> > >                 return -EINVAL;
> > >
> > >         LOCK_MOUNT(mp, path);
> > >         if (IS_ERR(mp.parent))
> > >                 return PTR_ERR(mp.parent);
> > >
> > > After LOCK_MOUNT @path might point to a completely different mount then
> > > the one you performed your security checks on.
> > 
> > I thought we agreed at LSF/MM/BPF 2026 to add the LSM hooks
> > before taking namespace semaphore, so that it is possible for LSMs
> > to defend against DoS attacks on namespace semaphore? Did I
> > miss/misunderstand something?
> 
> I think there was a misunderstanding. What I pointed out was that it's a
> trade-off. If we do call security hooks under the namespace semaphore or
> mount lock than anything that's called under there must take care to not
> cause deadlocks - which is especially easy to do with mount lock and
> even with the namespace semaphore it may get hairy (automounts etc). The
> dos thing is another worry but if an LSM does stupid things we tell it
> to not do stupid things and to go away.
> 
> But as the hooks are done right now they are meaningless from a security
> perspective. You might have a policy that allows mounting on dentry_a
> and deny mounting on dentry_b: before LOCK_MOUNT*() you may see dentry_a
> and allow the mount but after LOCK_MOUNT*() someone raced you and shoved
> a dentry_b mount onto dentry_b and now you allow overmounting dentry_b

*a dentry_b mount onto dentry_a
