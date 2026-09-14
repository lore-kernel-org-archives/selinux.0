Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE6448BAA
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389928; cv=none; b=hEbTm+r+xoGjghZ9t2DTPOozWTgvPv+o1fkw7yjnMJ6VV38bV1xmLtvLlJsRTqcseU8zBsRC5j1RbmhD4VSVU03Rp/8XMYU/1F0oqQ8VrqigqxO+SShssBSafqO+yWwcf9d8FzG5Tceq9dLvZrWreaGt2cdH6m0PJRqSAaoI+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389928; c=relaxed/simple;
	bh=zHl+VKqDu28nyc5UYDFkdMiqDfkheZGqD9R+Qgfv84c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+jVARXHlG1k4moQoEMCD4Ubbg/lddAnyuBdWkxs3XvO2fJ9Q9zGHwPpD0OgNduRZRsC8PJp4Z68XyijR4lL5hx45XjH5YqhWrMUnhxo9zm6CBZd2i9v/zF6sfxpV3XGnTWcQ9HoArwmUIQjj46QEZyq/YqKKs482pc36nj0pF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuILa+Nx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuILa+Nx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF6E1F000FF;
	Mon, 14 Sep 2026 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789389926;
	bh=uVRWN5Ir8U8oTFxDvnT+EMpHUuRdRif8XEN0rLZMKTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QuILa+NxZ8KGTT/yJ8X8hCj1mbHbTTtEfvC5vMWZyLvIcic1IMJX7VRjPIsHshTL7
	 PWAmv7sD5+IzwaSECb+NxeGwUBRcj/cUbPg47kjLoSjOSbT5LBAy8AMVVd4qWlHOYz
	 dw+MiwKa0TYgi0/YNGT5kuXWHTI5ifa2/ZEBEiZHRry5M6WkRZ6Olte2D5YEUSQ6QQ
	 CoNdwPIUgLh41yS2Kdgj/JRx0pga+NA7Bfc1gh8oFO6GRBpuHSc8QYpiXARpvMsNAp
	 NoXM+B1MIxywSm+3A9JjRFVvUeyuppx1b/JRQu0cML4y7V1mIDJqCc33+QGK3G/xwL
	 +OgDpcoCfG0xA==
Date: Mon, 14 Sep 2026 13:45:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	jannh@google.com, jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
Message-ID: <aqfsKocaLL6O7grQ@gremlin>
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
 <aqe6QA7Gn7B_7EhB@gremlin>
 <CAEjxPJ6UebQZtOU475T0tvqnjLEY3auXcr4+QMchEa05F=73vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ6UebQZtOU475T0tvqnjLEY3auXcr4+QMchEa05F=73vg@mail.gmail.com>

On Mon, Sep 14, 2026 at 08:39:53AM -0400, Stephen Smalley wrote:
> On Mon, Sep 14, 2026 at 5:18 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > On Fri, Sep 11, 2026 at 12:37:35PM -0400, Stephen Smalley wrote:
> > > The selinuxfs "status" and "policy" files are read-only interfaces
> > > that are also mmap'd by userspace. They are created 0444 by
> > > simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> > > O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> > >
> > > Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> > > tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> > > above are rejected at the VFS layer without ever reaching the file
> > > operations. Since a writable file can no longer exist, do_mmap() clear
> >
> > Micro nit: clear -> clears.
>
> Thanks, will fix if Paul requests a re-spin.
>
> >
> > > VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> > > sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> > > MAP_PRIVATE writable mappings become permitted (they were previously
> > > -EPERM) and CoW harmlessly to a private page, matching how
> > > sel_mmap_policy() has always treated the private case.
> > >
> > > The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> > > reason; leave dropping it to the pending "selinux: reject writable
> > > opens of policy file, drop mmap shared/write check" patch so that the
> > > patches do not conflict.
> > >
> > > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > > cc: ljs@kernel.org
> > > cc: jannh@google.com
> > > cc: jack@suse.cz
> > > cc: cgzones@googlemail.com
> > > cc: brauner@kernel.org
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > With nits addressed, LGTM so:

You can keep my tag without these 2 nits addressed actually, they are so minor
as to not matter really!

> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > > ---
> > > v3 implements Jan's suggestion to mark the inodes immutable rather than
> > > implementing open-time checks.
> > >
> > >  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > > index 292302eb60f3..0941ce79ea0b 100644
> > > --- a/security/selinux/selinuxfs.c
> > > +++ b/security/selinux/selinuxfs.c
> > > @@ -247,11 +247,6 @@ static int sel_mmap_handle_status(struct file *filp,
> > >       /* only allows one page from the head */
> > >       if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
> > >               return -EIO;
> > > -     /* disallow writable mapping */
> > > -     if (vma->vm_flags & VM_WRITE)
> > > -             return -EPERM;
> > > -     /* disallow mprotect() turns it into writable */
> > > -     vm_flags_clear(vma, VM_MAYWRITE);
> > >
> > >       return remap_pfn_range(vma, vma->vm_start,
> > >                              page_to_pfn(status),
> > > @@ -1818,6 +1813,17 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
> > >
> > >  #define NULL_FILE_NAME "null"
> > >
> > > +static void sel_mark_immutable(struct dentry *root, const char *name)
> > > +{
> > > +     struct qstr q = QSTR(name);
> > > +     struct dentry *dentry = try_lookup_noperm(&q, root);
> > > +
> > > +     if (!IS_ERR_OR_NULL(dentry)) {
> > > +             d_inode(dentry)->i_flags |= S_IMMUTABLE;
> > > +             dput(dentry);
> > > +     }
> > > +}
> >
> > Hmm, maybe worth returning an error here on lookup failure? I think probably it
> > can't happen in reality right now but that'd make it consistent with the other
> > functions here.
>
> I don't think so - 1. It can't fail, and 2. if by some happenstance it
> did fail, we would
> NOT want to stop populating selinuxfs and return the error to the
> caller because that
> would turn something that is non-fatal into a fatal policy load/reload
> error and halt
> the system if this is the initial policy load and SELinux is
> configured to be enforcing.
> At most maybe a pr_err() or similar here, defer to Paul on whether that warrants
> a re-spin. Thanks.

Yup not a big deal!

As above, you can keep the tag regardless of these nits being addressed :)

>
> >
> > > +
> > >  static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
> > >  {
> > >       struct selinux_fs_info *fsi;
> > > @@ -1857,6 +1863,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       if (ret)
> > >               goto err;
> > >
> > > +     sel_mark_immutable(sb->s_root, "status");
> > > +     sel_mark_immutable(sb->s_root, "policy");
> > > +
> > >       fsi = sb->s_fs_info;
> > >       fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
> > >       if (IS_ERR(fsi->bool_dir)) {
> > > --
> > > 2.55.0
> > >
> >
> > --
> > Cheers, Lorenzo

--
Cheers, Lorenzo
