Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB630DD2A;
	Wed, 17 Jun 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704436; cv=none; b=Bz+vNdXAPH9AnlIb80YoKO/NaradZfqnOSSoETSVr8rTmU/NK/in6vSStF+5X8//E1CbWHUFkz+jOeuFN4Y3ahgcnic2dYjxNjkgW3UIS8A+MxL2stpRrTKYGXDMM3E8h4nrTIBMx6wugL1hkNncYkm/5sjlBInM9tjUemRuofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704436; c=relaxed/simple;
	bh=zhiyo3I4lnsfuBisfCoJPx76lFPu28y1Vtp6C7z0hmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiiPjOu1jsh+pF+ZTtCYQ0jGYegBB4GbqvALmRkWqeZuR9tN3RSgvANE2aveQuwCOKKwfTwZmxEtLtIctFuWXY6sU1NQ4LikWwzkeAX4PiHKGEb6gen74BtSnexHfMp4Zg7f77cOHXAfe4f9h9zH6e23go4qfEF5dehELx2vzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbHPGPt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbHPGPt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E311F000E9;
	Wed, 17 Jun 2026 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704435;
	bh=/hRzRcazcgW6UzRMoZOpE2oQpA4bv1K6thJ9xBlKqaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GbHPGPt7QBOO3IZKdFSPplDPlNfvpOOVuo4grFmU8zqbdkrxSFMNxe6V/uZmXD6h0
	 45q/quLEO02Fm8Hp6f5Yp7MMAvBXrE8jm6lmmHBDT9Tipq+dsXPFRM7JOMLmtzWft+
	 BgZzc7a12aAn+2oGTjdRbHVXkQRn5BVyLDRYSHaO5OP2uklxKWx7XIenuWnKRq4XNb
	 OLJt9gUwBQ1vTlbh0zioBh280s3YqtY9uEGkJPOb8YBnUBA4YwmH4HlhjxOjVN0Pem
	 SAIzaN86MykxasONdwUE64BUmas+5l7gCO6AqiAXRYH2F5mkOEwZEd6PEGMqRXTqYK
	 lAb2Zyuu3OrTQ==
Date: Wed, 17 Jun 2026 15:53:48 +0200
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
Message-ID: <20260617-laufbahn-eifrig-charmant-a48f357a0c52@brauner>
References: <20260528182607.3150386-1-song@kernel.org>
 <20260528182607.3150386-8-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528182607.3150386-8-song@kernel.org>

On Thu, May 28, 2026 at 11:26:06AM -0700, Song Liu wrote:
> Replace the monolithic security_sb_mount() call in path_mount() and
> security_move_mount() in vfs_move_mount() with the new granular mount
> hooks:
> 
> - do_loopback(): call security_mount_bind()
> - do_new_mount(): call security_mount_new()
> - do_remount(): call security_mount_remount()
> - do_reconfigure_mnt(): call security_mount_reconfigure()
> - do_move_mount_old(): call security_mount_move()
> - do_change_type(): call security_mount_change_type()
> - vfs_move_mount(): replace security_move_mount() with
>   security_mount_move()
> 
> The new hooks are called at the individual operation level with
> appropriate context (resolved paths, fs_context), rather than at
> the top of path_mount() with raw string arguments.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux only
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namespace.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..43f22c5e2bf4 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2888,6 +2888,10 @@ static int do_change_type(const struct path *path, int ms_flags)
>  	if (!type)
>  		return -EINVAL;
>  
> +	err = security_mount_change_type(path, ms_flags);
> +	if (err)
> +		return err;
> +
>  	guard(namespace_excl)();
>  
>  	err = may_change_propagation(mnt);
> @@ -3006,6 +3010,10 @@ static int do_loopback(const struct path *path, const char *old_name,
>  	if (err)
>  		return err;
>  
> +	err = security_mount_bind(&old_path, path, recurse);
> +	if (err)
> +		return err;

This again is racy as it is called outside of the namespace semaphore:

        err = security_mount_bind(&old_path, path, recurse);
        if (err)
                return err;

        if (mnt_ns_loop(old_path.dentry))
                return -EINVAL;

        LOCK_MOUNT(mp, path);
        if (IS_ERR(mp.parent))
                return PTR_ERR(mp.parent);

After LOCK_MOUNT @path might point to a completely different mount then
the one you performed your security checks on.

> +
>  	if (mnt_ns_loop(old_path.dentry))
>  		return -EINVAL;
>  
> @@ -3328,7 +3336,8 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
>   * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
>   * to mount(2).
>   */
> -static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
> +static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags,
> +			      unsigned long flags)
>  {
>  	struct super_block *sb = path->mnt->mnt_sb;
>  	struct mount *mnt = real_mount(path->mnt);
> @@ -3343,6 +3352,10 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
>  	if (!can_change_locked_flags(mnt, mnt_flags))
>  		return -EPERM;
>  
> +	ret = security_mount_reconfigure(path, mnt_flags, flags);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * We're only checking whether the superblock is read-only not
>  	 * changing it, so only take down_read(&sb->s_umount).
> @@ -3366,7 +3379,7 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
>   * on it - tough luck.
>   */
>  static int do_remount(const struct path *path, int sb_flags,
> -		      int mnt_flags, void *data)
> +		      int mnt_flags, void *data, unsigned long flags)
>  {
>  	int err;
>  	struct super_block *sb = path->mnt->mnt_sb;
> @@ -3393,6 +3406,9 @@ static int do_remount(const struct path *path, int sb_flags,
>  	fc->oldapi = true;
>  
>  	err = parse_monolithic_mount_data(fc, data);
> +	if (!err)
> +		err = security_mount_remount(fc, path, mnt_flags, flags,
> +					    data);
>  	if (!err) {
>  		down_write(&sb->s_umount);
>  		err = -EPERM;
> @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *path, const char *old_name)
>  	if (err)
>  		return err;
>  
> +	err = security_mount_move(&old_path, path);
> +	if (err)
> +		return err;

Placement of this hook suffers from the same issue as the bind mount
hook. Here it's worse because the security layer isn't even informed
about MOVE_MOUNT_BENEATH which completely alters the mount relationship.
