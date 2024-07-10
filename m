Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672A192B96
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628432; cv=none; b=XWzWNWt5jxNazFru2XqbUTctf0siJ4VKG77EulYOcrTbNoqYIr5O3fp4SJ9ZP7Zoqdf7AkW7UVQO5LSr8uhdayEboeUaswtddElPjuyhyHuFUdOCvlk9CP93YFNnz3ZPEeUvqsddbY5Pn8iCrcn3XIuncriISLC1Te4/2JPtpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628432; c=relaxed/simple;
	bh=Vy9toFaP5ltCCuLEZw7KxgGNAZlJizlSWnpQKR2Z7N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI34KxUZlZ+ow754s2bFLZ/gXYChLhEwaiYgfbVGqJfRORsaN6B9e7WrKT1H08UDD4jxhE50q1mEeahTNEXiZid2Qdq34zQXwM2KCF36WXfU6HwIbWRfVjpNH6m9zDzMKY/3HrxgrLwoNkTRxt7LvMqi8bo7WZiYhB58LtcZDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OpyQCA6r; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OpyQCA6r"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64b0d45a7aaso62734777b3.0
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720628429; x=1721233229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2+EQwVsAKGj3xJOlcMKcW+3pzsGNmwMn59OWEiIv/g=;
        b=OpyQCA6rg6VVixFr41h647LWEWd6IHMQRlnlWdrpzbZe8QSV2ZOXFwASsbXjPGAzTi
         wgNsheDoQmGEZSiHqdz+II/BvIOZUFZFECgkritr9uY5K5Xy/nlmcHkqJZFdqCM7yATN
         8l91WvZulie1gS8oqgMDSaTo4t0Qj8uydhrQ8lB7Bc2+st65pnp0GTgZsTl09Bf1ZxmJ
         VSpoVRruGla3jnmMjc5cbsOm8m8z04tLpnJlck9NLhgJGGnXMYE+id8lYetADVVJu2or
         iPvslHIqsWluhewpW8xsf6zp4UnJoNQ6xXgXOmi0rBHx5TgdzhrPKUD+zSSSOoqgzUU9
         4vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628429; x=1721233229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2+EQwVsAKGj3xJOlcMKcW+3pzsGNmwMn59OWEiIv/g=;
        b=GgklsnEwBDok+OyPtjgogsi4c5Dv5ONpmjU3dtZoBqzmG2wQfMEAuGjiLOiyKf0I52
         w4dmDMb3aEiujjVnmQu+9CBZxGfscn++i54uJlHObW9PALITG55d/0l2tLzHLb9Bgrc4
         wQ/uFrrCSeAU4QuYCU+Ao9YXG86hNvfkhN76FYlFDpdAecUQE8ziNjgPRCgHdDX8O+kR
         y4j1pMV8GCk9SmZbon2u7fVOI34ex6AEJz+5c+X4wiJ2wVl8MYv+W+6vl6/ewr0BETDA
         SUuZxYLkW8FX2Qtbv3Wj7pvD4PwVLNEtz8ikCDsKaqnGbF5FbC/C0E9yik9ETM390gkM
         dPIA==
X-Forwarded-Encrypted: i=1; AJvYcCWI4NHmQTWJ9XXdlL2zBro4KlXInX15C5wfVtVqfhuand8UoW68E//RDxvivsXfGIPzSxKqjW5PxsVqiy06/zsDzpJD4PqBGA==
X-Gm-Message-State: AOJu0YxBH4STjSkOxiz5xIRRUtt7bQ01znfBXCNgpRZyTqIWroi/Oe5L
	hoARsJQq3F3FxegM87r/jrv2xkGAjV4JzKUlKtbyosNKJJEGytA9TcqfX8F1hg5EixP6DFT6749
	xw982Wrzr7YfISXk+tLkSu9OuKF1d+9DTxSiU
X-Google-Smtp-Source: AGHT+IHQqcjBV2/IdlhE1L8wzI/EuSVvmW2ZqL6mVT/3QGWqnuxDQTIYMzO4odsdcJqOWu1bvNGbcm9RfOHo4PAmJnQ=
X-Received: by 2002:a81:9116:0:b0:64b:6f7f:bc29 with SMTP id
 00721157ae682-65c6a146b02mr8757297b3.16.1720628429116; Wed, 10 Jul 2024
 09:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
In-Reply-To: <20240710.peiDu2aiD1su@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 12:20:18 -0400
Message-ID: <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:40=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> > The LSM framework has an existing inode_free_security() hook which
> > is used by LSMs that manage state associated with an inode, but
> > due to the use of RCU to protect the inode, special care must be
> > taken to ensure that the LSMs do not fully release the inode state
> > until it is safe from a RCU perspective.
> >
> > This patch implements a new inode_free_security_rcu() implementation
> > hook which is called when it is safe to free the LSM's internal inode
> > state.  Unfortunately, this new hook does not have access to the inode
> > itself as it may already be released, so the existing
> > inode_free_security() hook is retained for those LSMs which require
> > access to the inode.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> I like this new hook.  It is definitely safer than the current approach.

It would be nicer to simply have a single inode free hook, but it
doesn't look like that is a possibility due to the inode
synchronization methods and differing lifetimes of inodes and their
associated LSM state.  At least the workaround isn't too ugly :)

> To make it more consistent, I think we should also rename
> security_inode_free() to security_inode_put() to highlight the fact that
> LSM implementations should not free potential pointers in this blob
> because they could still be dereferenced in a path walk.

I'd prefer to keep the naming as-is in this patch since
security_inode_free() does trigger the free'ing/release of the LSM
state associated with the inode.

> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 22d8b7c28074..f583f8cec345 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dent=
ry *const old_dentry,
> >
> >  /* Inode hooks */
> >
> > -static void hook_inode_free_security(struct inode *const inode)
> > +static void hook_inode_free_security_rcu(void *inode_sec)
> >  {
> > +     struct landlock_inode_security *lisec;
>
> Please rename "lisec" to "inode_sec" for consistency with
> get_inode_object()'s variables.

Done.  That did conflict with the parameter name so I renamed the
parameter everywhere to "inode_security".

> >       /*
> >        * All inodes must already have been untied from their object by
> >        * release_inode() or hook_sb_delete().
> >        */
> > -     WARN_ON_ONCE(landlock_inode(inode)->object);
> > +     lisec =3D inode_sec + landlock_blob_sizes.lbs_inode;
> > +     WARN_ON_ONCE(lisec->object);
> >  }
>
> This looks good to me.
>
> We can add these footers:
> Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com

Thanks, metadata added.  This was a quick RFC patch so I didn't want
to spend a lot of time chasing down metadata refs until I knew there
was some basic support for this approach.  I still want to make sure
it is okay with the IMA folks.

> However, I'm wondering if we could backport this patch down to v5.15 .
> I guess not, so I'll need to remove this hook implementation for
> Landlock, backport it to v5.15, and then you'll need to re-add this
> check with this patch.  At least it has been useful to spot this inode
> issue, but it could still be useful to spot potential memory leaks with
> a negligible performance impact.

Yes, it's a bit complicated with the IMA/EVM promotion happening
fairly recently.  I'm marking the patch with a stable tag, but
considering we're at -rc7 and this needs at least one more respin,
testing, ACKs, etc. it might not land in Linus' tree until sometime
post v6.11-rc1.  Considering that, I might suggest dropping the
Landlock hook in -stable and re-adding it to Linus' tree once this fix
lands, but that decision is up to you.

> > diff --git a/security/security.c b/security/security.c
> > index b52e81ac5526..bc6805f7332e 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
> >
> >  static void inode_free_by_rcu(struct rcu_head *head)
> >  {
> > -     /*
> > -      * The rcu head is at the start of the inode blob
> > -      */
> > +     /* The rcu head is at the start of the inode blob */
> > +     call_void_hook(inode_free_security_rcu, head);
>
> For this to work, we need to extend the inode blob size (lbs_inode) with
> sizeof(struct rcu_head).  The current implementation override the
> content of the blob with a new rcu_head.

Take a look at lsm_set_blob_sizes() and you'll see that the rcu_head
struct is already accounted for in the inode->i_security blob.

> > @@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *=
head)
> >   * security_inode_free() - Free an inode's LSM blob
> >   * @inode: the inode
> >   *
> > - * Deallocate the inode security structure and set @inode->i_security =
to NULL.
> > + * Release any LSM resources associated with @inode, although due to t=
he
> > + * inode's RCU protections it is possible that the resources will not =
be
> > + * fully released until after the current RCU grace period has elapsed=
.
> > + *
> > + * It is important for LSMs to note that despite being present in a ca=
ll to
> > + * security_inode_free(), @inode may still be referenced in a VFS path=
 walk
> > + * and calls to security_inode_permission() may be made during, or aft=
er,
> > + * a call to security_inode_free().  For this reason the inode->i_secu=
rity
> > + * field is released via a call_rcu() callback and any LSMs which need=
 to
> > + * retain inode state for use in security_inode_permission() should on=
ly
> > + * release that state in the inode_free_security_rcu() LSM hook callba=
ck.
> >   */
> >  void security_inode_free(struct inode *inode)
> >  {
> >       call_void_hook(inode_free_security, inode);
> > -     /*
> > -      * The inode may still be referenced in a path walk and
> > -      * a call to security_inode_permission() can be made
> > -      * after inode_free_security() is called. Ideally, the VFS
> > -      * wouldn't do this, but fixing that is a much harder
> > -      * job. For now, simply free the i_security via RCU, and
> > -      * leave the current inode->i_security pointer intact.
> > -      * The inode will be freed after the RCU grace period too.
> > -      */
> >       if (inode->i_security)
> >               call_rcu((struct rcu_head *)inode->i_security,
> >                        inode_free_by_rcu);
>
> We should have something like:
> call_rcu(inode->i_security.rcu, inode_free_by_rcu);

The unfortunate side effect of that is that the patch grows
significantly as everyone that touches inode->i_security would need to
be updated to use inode->i_security.data or something similar.  For a
patch that we likely want to see backported to -stable that could make
things more difficult than needed.

However, I have always thought we should add some better
structure/typing to these opaque LSM blobs both to get away from the
raw pointer math and add a marginal layer of safety.  I've envisioned
doing something like this:

  struct lsm_blob_inode {
    struct selinux_blob_inode selinux;
    struct smack_blob_inode smack;
    struct aa_blob_inode apparmor;
    ...
    struct rcu_head rcu;
  }

... with lsm_blob_inode allocated and assigned to inode->i_security.
Those LSMs that are enabled and require blob space would define their
struct with the necessary fields, those that were disabled or did not
require space would define an empty struct; some minor pre-processor
checking and header file work would be needed, but it shouldn't be too
bad.  Ideally, we would use the same approach for all of the LSM
security blobs, only with different LSM supplied structs.  Perhaps
once we land Casey's latest patchset I'll see about doing something
like that, but right now we've got bigger problems to address.

I'll hold off on posting a proper patch for this RFC until I hear back
from Mini or Roberto on the IMA changes.

--=20
paul-moore.com
