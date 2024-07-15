Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119918C180
	for <selinux@vger.kernel.org>; Mon, 15 Jul 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050510; cv=none; b=YvlVOWkswXmQ5pRrgqI2jzk4GzKhvbp86j6i7HokVTFyVQ81ehARRd0V5xgUi1504jPbtGvSEkb0fVCdkS80llTjzcPxKT/VXzWcBbq6vWpLh5pU9+7Hqr217bEyXo82XdHY+VLJMWjkrQwGrawB6T0K0pDBTYu4to4qdM5+N8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050510; c=relaxed/simple;
	bh=3pKd3/B0Ahf07Xynz1ff/PNmZ9T3Kr0HcZ+I3h0/Pjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+OAud/IJaZmsj5M4bi3pDcFg38ObhrsjLcvtqYjqYHJRgEXRA+ZQkm1BX1fqX+gFBOEglkXdUHrCmRd5St/1lW+9wBpQeRZlqBj8Ads1FpN7z58WUes9akhU2QHMgECLGSX58deuNlIO4zieEDo56ZN1dAqG2kJ5W0oPfF187U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Ifo8kpwq; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Ifo8kpwq"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WN3935hBqzjZN;
	Mon, 15 Jul 2024 15:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721050503;
	bh=tRU52QRBun9ibK+m5VqXM3KY35g6zl+4vFHQ3XwaIBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ifo8kpwqhGSHnJ0u0NVplNW+gCB2imRE/cw7USzwBjGKww/x3rx4trS3wiDB+/3Lc
	 AtdVzIqC2bAvOaamR+MvW/k7OIcBXXrVnPsqWSI1UpTfKv2RTNdjJuXQM+WotnLU1J
	 zQlBlygX/DNSetysepHteBwv8OMIWnG9nI6T3/p4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WN3931yBpzSTg;
	Mon, 15 Jul 2024 15:35:03 +0200 (CEST)
Date: Mon, 15 Jul 2024 15:35:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <20240715.uax4chahCohw@digikod.net>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 10, 2024 at 12:20:18PM -0400, Paul Moore wrote:
> On Wed, Jul 10, 2024 at 6:40 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> > > The LSM framework has an existing inode_free_security() hook which
> > > is used by LSMs that manage state associated with an inode, but
> > > due to the use of RCU to protect the inode, special care must be
> > > taken to ensure that the LSMs do not fully release the inode state
> > > until it is safe from a RCU perspective.
> > >
> > > This patch implements a new inode_free_security_rcu() implementation
> > > hook which is called when it is safe to free the LSM's internal inode
> > > state.  Unfortunately, this new hook does not have access to the inode
> > > itself as it may already be released, so the existing
> > > inode_free_security() hook is retained for those LSMs which require
> > > access to the inode.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>

> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index 22d8b7c28074..f583f8cec345 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
> > >
> > >  /* Inode hooks */
> > >
> > > -static void hook_inode_free_security(struct inode *const inode)
> > > +static void hook_inode_free_security_rcu(void *inode_sec)
> > >  {
> > > +     struct landlock_inode_security *lisec;
> >
> > Please rename "lisec" to "inode_sec" for consistency with
> > get_inode_object()'s variables.
> 
> Done.  That did conflict with the parameter name so I renamed the
> parameter everywhere to "inode_security".

Oh, I didn't see this conflict.  Using inode_security as function
argument looks good.


> > However, I'm wondering if we could backport this patch down to v5.15 .
> > I guess not, so I'll need to remove this hook implementation for
> > Landlock, backport it to v5.15, and then you'll need to re-add this
> > check with this patch.  At least it has been useful to spot this inode
> > issue, but it could still be useful to spot potential memory leaks with
> > a negligible performance impact.
> 
> Yes, it's a bit complicated with the IMA/EVM promotion happening
> fairly recently.  I'm marking the patch with a stable tag, but
> considering we're at -rc7 and this needs at least one more respin,
> testing, ACKs, etc. it might not land in Linus' tree until sometime
> post v6.11-rc1.  Considering that, I might suggest dropping the
> Landlock hook in -stable and re-adding it to Linus' tree once this fix
> lands, but that decision is up to you.

I would prefer to backport the new hook.  I can help with that.  In
fact, I tried to backport the removal of the hook for Landlock, and it
requires the same amount of work, so it would be better to work
together.  That should also ease future backports impacting the same
part of the code.

BTW, while trying to backport that to linux-5.15.y I noticed that a fix
is missing in this branch: the default return value for the
inode_init_security hook, see commit 6bcdfd2cac55 ("security: Allow all
LSMs to provide xattrs for inode_init_security hook").

> 
> > > diff --git a/security/security.c b/security/security.c
> > > index b52e81ac5526..bc6805f7332e 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
> > >
> > >  static void inode_free_by_rcu(struct rcu_head *head)
> > >  {
> > > -     /*
> > > -      * The rcu head is at the start of the inode blob
> > > -      */
> > > +     /* The rcu head is at the start of the inode blob */
> > > +     call_void_hook(inode_free_security_rcu, head);
> >
> > For this to work, we need to extend the inode blob size (lbs_inode) with
> > sizeof(struct rcu_head).  The current implementation override the
> > content of the blob with a new rcu_head.
> 
> Take a look at lsm_set_blob_sizes() and you'll see that the rcu_head
> struct is already accounted for in the inode->i_security blob.

Indeed, I was confused with the lsm_set_blob_size() name which *adds* a
size.

> 
> > > @@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *head)
> > >   * security_inode_free() - Free an inode's LSM blob
> > >   * @inode: the inode
> > >   *
> > > - * Deallocate the inode security structure and set @inode->i_security to NULL.
> > > + * Release any LSM resources associated with @inode, although due to the
> > > + * inode's RCU protections it is possible that the resources will not be
> > > + * fully released until after the current RCU grace period has elapsed.
> > > + *
> > > + * It is important for LSMs to note that despite being present in a call to
> > > + * security_inode_free(), @inode may still be referenced in a VFS path walk
> > > + * and calls to security_inode_permission() may be made during, or after,
> > > + * a call to security_inode_free().  For this reason the inode->i_security
> > > + * field is released via a call_rcu() callback and any LSMs which need to
> > > + * retain inode state for use in security_inode_permission() should only
> > > + * release that state in the inode_free_security_rcu() LSM hook callback.
> > >   */
> > >  void security_inode_free(struct inode *inode)
> > >  {
> > >       call_void_hook(inode_free_security, inode);
> > > -     /*
> > > -      * The inode may still be referenced in a path walk and
> > > -      * a call to security_inode_permission() can be made
> > > -      * after inode_free_security() is called. Ideally, the VFS
> > > -      * wouldn't do this, but fixing that is a much harder
> > > -      * job. For now, simply free the i_security via RCU, and
> > > -      * leave the current inode->i_security pointer intact.
> > > -      * The inode will be freed after the RCU grace period too.
> > > -      */
> > >       if (inode->i_security)
> > >               call_rcu((struct rcu_head *)inode->i_security,
> > >                        inode_free_by_rcu);
> >
> > We should have something like:
> > call_rcu(inode->i_security.rcu, inode_free_by_rcu);
> 
> The unfortunate side effect of that is that the patch grows
> significantly as everyone that touches inode->i_security would need to
> be updated to use inode->i_security.data or something similar.  For a
> patch that we likely want to see backported to -stable that could make
> things more difficult than needed.

Sure, this was related to my confusion with the rcu_head size addition.
