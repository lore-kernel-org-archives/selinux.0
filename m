Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87E361667;
	Mon, 23 Mar 2026 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260990; cv=none; b=b/7b70htTS1S3s2bzPZSrhhbb32rD9lNYmQb3M+ddmwL21PlzIf0DR+DahcJJDQWwaE+m6NOA7Ln8zGYUw4+KIQEXnTvfz/2KT2rWiYtlAUBoRHn4iHtboWBHpSIJ4OWOJLlx0WpxoKuE+WBReIXNmcpx3/dOkyeIKNB1DVd11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260990; c=relaxed/simple;
	bh=dQ+XJeUBxU2ECoBCOmU1p9/Q6avsSxDQDUGdBMesKTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AghqlHJclAgstbESM+1L6MlWLuDKNpJC05Vc0x6jQZSeWKVC2v7Zy+C5EzuOU2DcpB301poAoXRO5FKQSMaJy9kvKkLlIqWUbzYIrhd9nPQY19PR/JzqgmqTzK8ej9ZQ0mZ/y+oQi0G4f6pzrG5uybYLpZ749mxbgUzCeF5BiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/PFJqSu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/PFJqSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2965EC4CEF7;
	Mon, 23 Mar 2026 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774260989;
	bh=dQ+XJeUBxU2ECoBCOmU1p9/Q6avsSxDQDUGdBMesKTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/PFJqSufEi0U5zbotkjJegfSLBtIqK+5upQokMTrxEhjPXnhy5msB/ev2cAx/h8m
	 wY5lUmW0g4VJ6WK2XNk0PJIL9QhfcBGSz1qhOq/umKTcKpRvam1DaP+tBKltUkyUQm
	 0wOQSH5C6QwA059b/jhabN04SaWSSg397v855bulQNglsGjUhsyARM+Se6NJe2XhMg
	 LdpQBH8xo3/Ozj3JogkYI6UZ5VdlWn5dZwC2ZD8kJayCXkvlA+J6jyG0La7G7PbPbo
	 Of4Csj8t4vckaLGuxQvtazsmAoPFRVHONmS1NYYZmF3PVQusSD3ZPN5OyCmAhn9f2g
	 N/IeGBlQAcoog==
Date: Mon, 23 Mar 2026 11:16:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, Song Liu <song@kernel.org>, 
	"paul@paul-moore.com" <paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, "jack@suse.cz" <jack@suse.cz>, 
	"john.johansen@canonical.com" <john.johansen@canonical.com>, 
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, "omosnace@redhat.com" <omosnace@redhat.com>, 
	"mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>, 
	"takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>, "herton@canonical.com" <herton@canonical.com>, 
	Kernel Team <kernel-team@meta.com>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
Message-ID: <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
References: <20260318184400.3502908-1-song@kernel.org>
 <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
 <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com>
 <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
 <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com>

On Mon, Mar 23, 2026 at 03:32:14AM +0000, Song Liu wrote:
> 
> 
> > On Mar 22, 2026, at 3:46 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > 
> > On 2026/03/22 10:06, Song Liu wrote:
> >>>> @@ -70,6 +70,7 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
> >>>> * @dir:      Pointer to "struct path".
> >>>> * @type:     Name of filesystem type.
> >>>> * @flags:    Mount options.
> >>>> + * @dev_path: Pre-resolved device/source path. Maybe NULL.
> >>> 
> >>> I guess that we can avoid passing maybe-NULL dev_name if Al Viro can accept
> >>> resolving maybe-NULL dev_path argument before calling LSM hooks.
> >> 
> >> If I understand the code correctly, tomoyo records requested_dev_name for
> >> new mount. namespace.c, OTOH, does NOT do kern_path() for new mount. This 
> >> is why we keep the maybe-NULL dev_name here. I personally think this is 
> >> the best approach without changing tomoyo behavior.
> > 
> > Well, namespace.c does kern_path() for new mount, but it happens a bit later after
> > security_mount_new() was called.
> > 
> >  do_new_mount_fc() => fc_mount() => vfs_get_tree() => fc->ops->get_tree() == e.g. ext4_get_tree()
> >  => get_tree_bdev() => get_tree_bdev_flags() => lookup_bdev() => kern_path()
> > 
> > @@ -3835,6 +3855,9 @@ static int do_new_mount(const struct path *path, const char *fstype,
> > err = parse_monolithic_mount_data(fc, data);
> > if (!err && !mount_capable(fc))
> > err = -EPERM;
> > +
> > + if (!err)
> > + err = security_mount_new(fc, path, mnt_flags, flags, data);
> > if (!err)
> > err = do_new_mount_fc(fc, path, mnt_flags);
> > 
> > 
> > Since not all filesystems need to resolve dev_name argument, conversion from dev_name
> > to "struct path" is up to individual filesystem. If we can use a flag like FS_REQUIRES_DEV
> > that tells whether that filesystem will resolve dev_name argument, I think we can resolve
> > the dev_name argument before security_mount_new() is called (and can avoid TOCTOU).
> 
> I guess we can add dev_path to fs_context?

No, when and how the path is resolved is entirely up to the individual
filesystem and we're not hoisting the block-based specific path lookup
up into the VFS while leaving the other stuff per-filesystem. And it's
not as trivial as you want it to be either.
