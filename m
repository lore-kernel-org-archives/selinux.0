Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BA3ECBE4;
	Thu, 18 Jun 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791351; cv=none; b=eykZ2NyqJf8L4BO8Aev4ajzp6SktNxjnXdqesRTNyMzUgsow6babm2SBNBxbO8hmbXtHI6+UgGC4szlGzERWakn5pjRemyOW7j1JeI8D4GBkZ6/eEkVoPFkTztdp9Rw2/5yYCJinpNnQrfWIrGIUlj9edgDgnToG23pJbji6JzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791351; c=relaxed/simple;
	bh=k916pKxaOf7B4P3yVTWLlngVhVyPkDIXI52B9aGPc2I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mu6edqh2ffhmVScuI6Ie0PdoBe7fJqL2JJpUS0fVY914PWf5I5iatc7fxMB05KkWTi4QoS5Cj/qOfGcwfP/BCj+RBTskp9KeajQ4BrJTv7mx4J+Tm3o6CRKHhu6pmILt6vgGt1lvWWUqZoHg+1vBYa9dRC779+NF5l9mMkxvVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkPjyfEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkPjyfEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E061F000E9;
	Thu, 18 Jun 2026 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781791349;
	bh=h1CrjMVgL61vHQAx/k3CKSIoS+lyuffNF+8YaZzYJCU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=SkPjyfEd483/P4oAEKKdfulBkJCesajLx1yvEchJNOpmI0OYmMXwKuMGiLwhC6JPG
	 wrdV3lG/GXsNtgm1AnZ9gJ455vGwp2LDMTAJpIKdM51+qwtF/TuPfv75nhq1SpzMH+
	 jmf0xK+HgWk7YkhpMaQyB1ZZHRO/YeFB0cj5enxH8K7LL5JmtEGlszCU5/+7rx7E0I
	 Ougi6eKHe8+HdcE1HZx4GRy9oT0lvK7aEVZoDjyOpDjSgoDToadlsY13Nj/fNNizrj
	 doz1Ev+vlIMiu76T92za6fX3tMVz0Zk8JZTwfEMkkYV3PzmPqwzaE+I/AklevIvxXy
	 Vhwie4wT6MWPA==
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 7/8] vfs: Replace
 security_sb_mount/security_move_mount with granular hooks
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
 jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
 john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
 omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
 takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
 herton@canonical.com, kernel-team@meta.com
In-Reply-To: <CAPhsuW7Wn8GYrsrRhEFXQH5buaP+pdTKc0UV8Mn0B3OnNN-44g@mail.gmail.com>
References: <20260528182607.3150386-1-song@kernel.org>
 <20260528182607.3150386-8-song@kernel.org>
 <20260617-laufbahn-eifrig-charmant-a48f357a0c52@brauner>
 <CAPhsuW7Wn8GYrsrRhEFXQH5buaP+pdTKc0UV8Mn0B3OnNN-44g@mail.gmail.com>
Date: Thu, 18 Jun 2026 16:02:22 +0200
Message-Id: <178179134209.111814.12159888808546010170.b4-reply@b4>
X-Mailer: b4 0.16-dev-0da26
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k916pKxaOf7B4P3yVTWLlngVhVyPkDIXI52B9aGPc2I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZ/yow6Ga3kMuWmrPTxLe7b9H59axHFWxW88/YuycrV
 e72CmX+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk4tDD8rxds9eNp5fLjyxZ2
 u+ay/eXhTSq+lwVWr7ZRn8VufDhgKiPDvVWiUetmq3U9/cNY4S4sniIZ92axwwnxl8+Vdqzj2vO
 REwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-18 18:56:42+08:00, Song Liu wrote:
> On Wed, Jun 17, 2026 at 9:53 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> > On Thu, May 28, 2026 at 11:26:06AM -0700, Song Liu wrote:
> 
> [...]
> 
> > >
> >
> > This again is racy as it is called outside of the namespace semaphore:
> >
> >         err = security_mount_bind(&old_path, path, recurse);
> >         if (err)
> >                 return err;
> >
> >         if (mnt_ns_loop(old_path.dentry))
> >                 return -EINVAL;
> >
> >         LOCK_MOUNT(mp, path);
> >         if (IS_ERR(mp.parent))
> >                 return PTR_ERR(mp.parent);
> >
> > After LOCK_MOUNT @path might point to a completely different mount then
> > the one you performed your security checks on.
> 
> I thought we agreed at LSF/MM/BPF 2026 to add the LSM hooks
> before taking namespace semaphore, so that it is possible for LSMs
> to defend against DoS attacks on namespace semaphore? Did I
> miss/misunderstand something?

I think there was a misunderstanding. What I pointed out was that it's a
trade-off. If we do call security hooks under the namespace semaphore or
mount lock than anything that's called under there must take care to not
cause deadlocks - which is especially easy to do with mount lock and
even with the namespace semaphore it may get hairy (automounts etc). The
dos thing is another worry but if an LSM does stupid things we tell it
to not do stupid things and to go away.

But as the hooks are done right now they are meaningless from a security
perspective. You might have a policy that allows mounting on dentry_a
and deny mounting on dentry_b: before LOCK_MOUNT*() you may see dentry_a
and allow the mount but after LOCK_MOUNT*() someone raced you and shoved
a dentry_b mount onto dentry_b and now you allow overmounting dentry_b
which your policy didn't allow -> hosed.

> > Placement of this hook suffers from the same issue as the bind mount
> > hook. Here it's worse because the security layer isn't even informed
> > about MOVE_MOUNT_BENEATH which completely alters the mount relationship.
> 
> Current hook security_move_mount doesn't handle
> MOVE_MOUNT_BENEATH. But we can add mflags to security_mount_move().
> Do we need anything other than mflags?

I think you either need to pass three mounts (source, target, top_mnt)
where for non-mount beneath target == top_mnt or you need two separate
hooks. Because for MOVE_MOUNT_BENEATH you may want to have a tri-part
policy: source, target, top_mnt.

