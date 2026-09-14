Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209E3E8685
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389607; cv=pass; b=b61mzIksvWedfWmW7UTUhCWL4iaTQgtBJtcOaj4QVJbgWDfrxT7RvqKn1+vBjA23HwXsXYbH+8faGD52UU+AjgeiVMW53ntWTanZK1hlsDaLQ/gXQwbG6BRZuUgz8/fCobeoeEt2ZuGJvIgecCj3Y3vGNY/mRXneQroP9CPAM0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389607; c=relaxed/simple;
	bh=R9ionxYd1rHDMXZ6RU30qKjqg/xxRInngnBeZrbmVLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u124YDiwg9gxCWdPZrZoQy/gXHvPV1PK3GXEY8cQP9n23hZ6+W7vyXwS3zMeNZowDHqYqlxqkywPvlFTq9m6xNhSjzFp4p2I+ofXIk9wVsbrIWOYDDlrBy+J4FtNWTWouMMfJvrsPpTWtORb2m0+PELbWpQxusnCGdmiJ+FxeIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4xdZgfm; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4xdZgfm"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9ab667so2825264fac.0
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 05:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789389604; cv=none;
        d=google.com; s=arc-20260327;
        b=ZgnoGrKwUHLzFEfZAIMiJhk7OZoW+tfvPfT4JBrLlan7lGrvHPn1iskMy0WaCpgGXv
         LG3fUq/Cwtjw61QjewW+yed3e/nCQsq5NBLMjIqnxiv9c6DsJDMz0x1TsqWfJYLqIAip
         dLXZ3bcEJZ8JuwzoB0OSIrFGu8IdijOKVbszYYw3IZBxciG9RdTH4G+qw2Vq4pl73e16
         Xu2UZ3TbTx/bVquLgPaKYEdrKj2qbojuKt5KhbUEZRMh64fw2AhQrNrFmWHAKwE3C//0
         ZEZAfnWDMaxTZimvEe3Y9TS7M/hS78SRFKIrwFzqgYNLB7yCpGs9bbjHsdeBX5iEMuPv
         o7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yXeOjF1wh3N6Xlqaysh0VVLXqX8n/uC7zWMUWvPBxE=;
        fh=rJoL5I/OIT6MW7vxMVw2avjswjm5AGSfhXIOkPDN65U=;
        b=r4NTAiL4obFIb6NuRfIQvIR8BNjFVMh7ASOzVddTZAIAXZxkG+ZNqSNdql8fjloyN0
         WWGgs3i2JuqBMc+nwkcXK0l2KBJgAyCVUmp9f/B5Ldoa+mllb56wPduWpiOxmmdVdQhV
         hJsnTbj6fw2aCoPdsz+Ezu6yGoRFxZeIGV4SXXRlTdFCQTwTBg9SuP2f1K66rMGAJVYe
         Rdi8f1UMDjrVn+ScEKDUTNeBmhJifHqTvPXSW2qQH/bbhsqNibSqG8k7nmPoDJ7ZEuP4
         U731vXoEiqiJGpxJG22iSi0Ksw4m5VQkNTn7FprUKuEM+Ywd0kXkPW7+JG9EEt/OQJo5
         pe0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789389604; x=1789994404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6yXeOjF1wh3N6Xlqaysh0VVLXqX8n/uC7zWMUWvPBxE=;
        b=P4xdZgfmELOoUk9MVC8IvvExSiaTlVhSWFrunZoN697x8ow8eyKiDk7nyi2c9SwVrR
         iXPYU5rhEJO4Z+saQy7g3ZNaxqwR9ZnLMAOuPdAypg/GVWNnns50E3MKiRa2PrP1N1lf
         9+QYNPnC5LHfqMyncn2ZjC819MC6bSHvI3OqQbJeN24qJwKx4m5uTQxzUxNA0XQNFg+6
         TiImNaiMEaNevXKBAQfoAbGhzD+h5HQvjTo2ARVfesg9To5a76BBODf5eh6ZBGBW9dYP
         X07XmjYp0h0cNa55DGc87JmBNk1J6mJ0BOKYwC1Yk3NMmRE/NiSGgV4EjYWdzjCpjBQd
         G5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389604; x=1789994404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yXeOjF1wh3N6Xlqaysh0VVLXqX8n/uC7zWMUWvPBxE=;
        b=i2xk1derm2kcifSS7lj079WQ5y2FmeWlw7ulIW91mzjsQyMw+yg7cuf6qo1/IUsvQu
         STUREMqRLptBppmSDQI2USKXICK3dnXcgjlU1GdkrHMLYb5BSGCwhredVz9RLlfjW5po
         BXlF5+G1DgDXhURyYH8ttPdn3CzC+BnZBE6sZPQaQz0eX/cBB/oEi9DWtDLLf2EAO426
         azc7kCnre2i0NRQph6HtoZzz+WOBPhTuaXYEZqD3p6jqpH+CceMA7ChzL3teuvvNj1X8
         abSxYiuBQsgSZfv491tYt3GWkV2Cf9aMQzGWZIRflKhWGzcJg3kDCLMOuuFF0pfy9Lg5
         qxIw==
X-Gm-Message-State: AFuF++mdPkupr3l3R9eRJMoTErJvxqhvHSA1B5EkE+BspCatGSrNTk7I
	pJheekVX61ECWUZVoamV+OV6+nUl7fkvXrf6ZTSloD3xOPu6WVs8KMksWJgpVlLkzmMytksqOoi
	IH45oRbwdvX4VyK2AMUCWdULAm4YDsrVhkw==
X-Gm-Gg: AYBFou15dnzewc34xXTH9gPnhyZuibL1BoOfkWcQ3WREUMrEv0x0mmEdUws0WlW5yqf
	SKrEhJR+yp5YFWHyl1dziEjl1foXDo1hdO5nSLT8zkLiuSzKWsKblJ3gRCO2I0F7vludXwTSg83
	JSas9BN6BuYgQP1qXzK8DWN1iYp+/8pODk2vQ/ofL8v7g42V3aTtIfgKsq+oMag0kT8sKGEj604
	INQybOb4n0feeMzLDYJTuyLGwu7Jwa/IrVNxQnW7PmbLpWupAyp5cseF+85T562v2S3vz5xMyOF
	wfaHKcRReZLzh6gHWu8kxwp9YzwszBJcuSrcYCJ6jUQ9PQZ3YyjdrHw=
X-Received: by 2002:a05:6871:e012:b0:465:317d:1c51 with SMTP id
 586e51a60fabf-481f825f549mr1322657fac.14.1789389604000; Mon, 14 Sep 2026
 05:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com> <aqe6QA7Gn7B_7EhB@gremlin>
In-Reply-To: <aqe6QA7Gn7B_7EhB@gremlin>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 14 Sep 2026 08:39:53 -0400
X-Gm-Features: AcwNN1WYwQnTqoaGLCt6CYY0x-33N98ChEyQ9vy2HMAWBBtowkCQGhjwriIo9RU
Message-ID: <CAEjxPJ6UebQZtOU475T0tvqnjLEY3auXcr4+QMchEa05F=73vg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	jannh@google.com, jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:18=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Fri, Sep 11, 2026 at 12:37:35PM -0400, Stephen Smalley wrote:
> > The selinuxfs "status" and "policy" files are read-only interfaces
> > that are also mmap'd by userspace. They are created 0444 by
> > simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> > O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> >
> > Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> > tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> > above are rejected at the VFS layer without ever reaching the file
> > operations. Since a writable file can no longer exist, do_mmap() clear
>
> Micro nit: clear -> clears.

Thanks, will fix if Paul requests a re-spin.

>
> > VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> > sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> > MAP_PRIVATE writable mappings become permitted (they were previously
> > -EPERM) and CoW harmlessly to a private page, matching how
> > sel_mmap_policy() has always treated the private case.
> >
> > The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> > reason; leave dropping it to the pending "selinux: reject writable
> > opens of policy file, drop mmap shared/write check" patch so that the
> > patches do not conflict.
> >
> > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > cc: ljs@kernel.org
> > cc: jannh@google.com
> > cc: jack@suse.cz
> > cc: cgzones@googlemail.com
> > cc: brauner@kernel.org
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> With nits addressed, LGTM so:
>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> > ---
> > v3 implements Jan's suggestion to mark the inodes immutable rather than
> > implementing open-time checks.
> >
> >  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 292302eb60f3..0941ce79ea0b 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -247,11 +247,6 @@ static int sel_mmap_handle_status(struct file *fil=
p,
> >       /* only allows one page from the head */
> >       if (vma->vm_pgoff > 0 || size !=3D PAGE_SIZE)
> >               return -EIO;
> > -     /* disallow writable mapping */
> > -     if (vma->vm_flags & VM_WRITE)
> > -             return -EPERM;
> > -     /* disallow mprotect() turns it into writable */
> > -     vm_flags_clear(vma, VM_MAYWRITE);
> >
> >       return remap_pfn_range(vma, vma->vm_start,
> >                              page_to_pfn(status),
> > @@ -1818,6 +1813,17 @@ static struct dentry *sel_make_swapover_dir(stru=
ct super_block *sb, u64 *ino)
> >
> >  #define NULL_FILE_NAME "null"
> >
> > +static void sel_mark_immutable(struct dentry *root, const char *name)
> > +{
> > +     struct qstr q =3D QSTR(name);
> > +     struct dentry *dentry =3D try_lookup_noperm(&q, root);
> > +
> > +     if (!IS_ERR_OR_NULL(dentry)) {
> > +             d_inode(dentry)->i_flags |=3D S_IMMUTABLE;
> > +             dput(dentry);
> > +     }
> > +}
>
> Hmm, maybe worth returning an error here on lookup failure? I think proba=
bly it
> can't happen in reality right now but that'd make it consistent with the =
other
> functions here.

I don't think so - 1. It can't fail, and 2. if by some happenstance it
did fail, we would
NOT want to stop populating selinuxfs and return the error to the
caller because that
would turn something that is non-fatal into a fatal policy load/reload
error and halt
the system if this is the initial policy load and SELinux is
configured to be enforcing.
At most maybe a pr_err() or similar here, defer to Paul on whether that war=
rants
a re-spin. Thanks.

>
> > +
> >  static int sel_fill_super(struct super_block *sb, struct fs_context *f=
c)
> >  {
> >       struct selinux_fs_info *fsi;
> > @@ -1857,6 +1863,9 @@ static int sel_fill_super(struct super_block *sb,=
 struct fs_context *fc)
> >       if (ret)
> >               goto err;
> >
> > +     sel_mark_immutable(sb->s_root, "status");
> > +     sel_mark_immutable(sb->s_root, "policy");
> > +
> >       fsi =3D sb->s_fs_info;
> >       fsi->bool_dir =3D sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->l=
ast_ino);
> >       if (IS_ERR(fsi->bool_dir)) {
> > --
> > 2.55.0
> >
>
> --
> Cheers, Lorenzo
