Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082A3B6C1C
	for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835624; cv=pass; b=qstffK49znA/PNUR579tQNcpMbfaEtb1t1d/uveIwCai3fBS7xotuLdusyOYthX8Bs845XRRbFtcSk2erO4eSafgx3dJ5d/BrgA8DkJT9YGnT8ZW/mk3V1EgCZwqSbiLxN1r+jv3qBgrL3EQtJ2s93hsNssoqLQHg01GMiIB2II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835624; c=relaxed/simple;
	bh=xXOwv5xxQP+z3NMAooG7oWXJ2IstPlgwcLJ969ih5hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9qmw+PbuaBRTt8dQaVrFen48kLE1T1t5atZoIZHaZyesxZMLp7pj2a5sZ8n4JyJu9/Pl6+d9qk2wefDCYNvq8PN9FWRKyBtVN7xps0XFHFhtKahtBzD/JHxx11wQ6aybG/ehtxyv44UUFx5ODcMGYW54C3/sBO54KsT0Dj8wNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOSUbFR4; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOSUbFR4"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b941762394aso877875466b.1
        for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 05:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773835621; cv=none;
        d=google.com; s=arc-20240605;
        b=cv8J03QYM1yUBiiqMvTxLP6jjjaJZoZ4/02hOfj5MBwm47lUGgii1iPqitkoCOYlbP
         VJYY36KUI01NFlCXO6HkIthDrVvhkJN96GCHB75TL/8dBVrgFYvr25PrMwyFn2f1NGAx
         iJGbKGhnUTXhNr7VnVNkCHn84IR89fDznlK3NsrCFYMgazqdbnYT9/aj1dO5MWb/vC1E
         p1YBES3r9DoF4Mlgp7RPEL4AlsCHamyo8/pWm9812AnBmOGMQLcx6SyEyCNR1I8+z7Ei
         9M/dV9RZTiueL3onzMfd3yD4siKGSqR2N040TZMwJBA1kDsIiFIPSDySncWfb4h4BaN5
         baXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        fh=pKXXZVEG2TEjz3tMDdccN7Arxs5dtjhgNu/gTnQvHJQ=;
        b=YlqC7AEquSNmYr5giAtmkKc2fRh+5Y1haG1V2NwlUdpqjLRE4i/lVZNYeD955FColk
         XqgiValkVC9GrJF8Zmto9rXavBQKe0pfy12e9vno/ds+vndfRTJAjrjxQqWqgXsAuLxh
         kGJvGIeeuqNBESjV4VaIAMjVMhcJQh92kW8V3axR2PB4EZC6x3o2ykspOt0C5sCRmXZG
         Mx/AK7rO+yzE1koCe9aYUPoL8HKFKLsYUyPOVXDeeHJYaCZznlrM6aIfO2IgIz/Yak5x
         U7vfo9p+h5VfhpKY4C3dBcZbknI/NsA3w0bvbr14P3jjFdKJSw69LDYLfN7xzaP5SSbX
         JJlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773835621; x=1774440421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        b=bOSUbFR4pUElv87QPJby9DyIzars7OHB/G98km3AKgcAiiP3bnw8rMSGPBbPZXy4b2
         Qu1f4YM8CukZcnOdc0gnxZ8I3feTJUFtweZ6KtgPtx4wuTu82mKkIqcV9S/bndsrMtXO
         kMHyhQkTZjkqGK249wMVBYgfMnRspTcKot0ysmbQmYYitJwVRiTx7MzwHzI9lU+qLISh
         4ask/V+18+GMpF3kszuBBLztX6/mZkmrLqS5oZ8lft0UCbYXxz7qYrLZ7ZjUNzY/hSSy
         xStOL6AOAiN+qRu4h6nDAu7zyVn2hFoX1X+hY/awO/PcQ02oGqobPQDCYQp0K3qa5ffr
         2y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773835621; x=1774440421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        b=Xg0asXQ1JUq4ATt7z8bGbXkb4B9nAjN2HIqgLsa8CZHaCS+0VvgHX0+ZQxXhB/tQsR
         l+VNIftA+xoEeJz9BWtGjTMRX8eGKqts+xmlLv3U+PjuCTtxQYWf33iNS4vU2BXqyMcN
         8QvbtLiw4ou6yKP81gQ4mJDsxbIr0YPqxQmqBEDMrbBOel9B6cMhzF1magdhN9gdBzzP
         Pie/lZOQ4dzfV1I9nPX2gMr+fMfWbxvQobu46xm93HEFYKRaa6VUPLprtWMPg2VkyMao
         rBCy5IexiMbfPE5zsuCL8xXZqkbASvIPo5Rm2d8c5CBiNeKZJnzCJHw17nOZhKbz51Ie
         qFSw==
X-Forwarded-Encrypted: i=1; AJvYcCWiAas9ZyB2IFsKyy9hV7zv1APjTg3cok1OLq1dYC2nOGgraUHgh0e308eDnsXaem4LxE1xBuda@vger.kernel.org
X-Gm-Message-State: AOJu0YyImGK4QaB1LoymjrLfhoZ9F2xQhmxE8c/tJVMBFuitgI11d/q4
	0PC8El3lAyJBPvrYW1C0TCkJFJOKBB7hh1SM0HwFSRI8br1n8MuMMp0i3e0W+evd62ccVwR0+pE
	okasG0VroitB6gXbX4q150ZnUi0UxRBg=
X-Gm-Gg: ATEYQzyqmBWI3eGEC+OZ9p5juhEpBej2Y9SsC+0gg+wtR80QuIXlIP8D/ML87J2Pj4q
	34qdKLRViGxYOfn6r014w0asBv78Ih99qzv173v8A7HRKLCfSywMo0znssouauuKtmC8Q92HoWo
	OJFNQ//oWP510AftKNL4FbNBbpQqSt7EyPmj8A5KQdD9u0T/Eb228US7D7DL5+VAtWWQXEvlizt
	igQL2q9hJ6uGuQuyONK2Tw2hZJ5G7cqZtGCVk7ynxsq8QLZSQuVlaaAJj9pWpVw+UBtuwt/4B5c
	c7pq3t7NlrxuEQ4FLae3AdP3FfyOIRUn2aKx4QgqmvZdf0fvqhI=
X-Received: by 2002:a17:906:6a01:b0:b97:fe6d:2e4a with SMTP id
 a640c23a62f3a-b97fe6d3a3fmr112673966b.10.1773835620414; Wed, 18 Mar 2026
 05:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-6-paul@paul-moore.com>
 <20260318-einsam-sellerie-2d547dd338ee@brauner>
In-Reply-To: <20260318-einsam-sellerie-2d547dd338ee@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Mar 2026 13:06:48 +0100
X-Gm-Features: AaiRm52zvCWb40EW5edB_L-EubZhlbZT4WB8o_i5sTfBey92Yh1WyoQQt0_imPE
Message-ID: <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The only caller of file_ref_init() is now open coded, so the helper
> > is removed.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> > Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/backing-file.c            | 20 ++++++++------
> >  fs/erofs/ishare.c            |  6 ++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     | 10 -------
> >  9 files changed, 90 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > index 45da8600d564..acabeea7efff 100644
> > --- a/fs/backing-file.c
> > +++ b/fs/backing-file.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/backing-file.h>
> >  #include <linux/splice.h>
> > +#include <linux/uio.h>
> >  #include <linux/mm.h>
> >
> >  #include "internal.h"
> > @@ -18,9 +19,10 @@
> >  /**
> >   * backing_file_open - open a backing file for kernel internal use
> >   * @user_path:       path that the user reuqested to open
> > + * @user_cred:       credentials that the user used for open
> >   * @flags:   open flags
> >   * @real_path:       path of the backing file
> > - * @cred:    credentials for open
> > + * @cred:    credentials for open of the backing file
> >   *
> >   * Open a backing file for a stackable filesystem (e.g., overlayfs).
> >   * @user_path may be on the stackable filesystem and @real_path on the
> > @@ -29,19 +31,19 @@
> >   * returned file into a container structure that also stores the stack=
ed
> >   * file's path, which can be retrieved using backing_file_user_path().
> >   */
> > -struct file *backing_file_open(const struct path *user_path, int flags=
,
> > +struct file *backing_file_open(const struct path *user_path,
> > +                            const struct cred *user_cred, int flags,
> >                              const struct path *real_path,
> >                              const struct cred *cred)
> >  {
> >       struct file *f;
> >       int error;
> >
> > -     f =3D alloc_empty_backing_file(flags, cred);
> > +     f =3D alloc_empty_backing_file(flags, cred, user_cred);
> >       if (IS_ERR(f))
> >               return f;
> >
> > -     path_get(user_path);
> > -     backing_file_set_user_path(f, user_path);
> > +     backing_file_open_user_path(f, user_path);
> >       error =3D vfs_open(real_path, f);
> >       if (error) {
> >               fput(f);
> > @@ -52,7 +54,8 @@ struct file *backing_file_open(const struct path *use=
r_path, int flags,
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_open);
> >
> > -struct file *backing_tmpfile_open(const struct path *user_path, int fl=
ags,
> > +struct file *backing_tmpfile_open(const struct path *user_path,
> > +                               const struct cred *user_cred, int flags=
,
> >                                 const struct path *real_parentpath,
> >                                 umode_t mode, const struct cred *cred)
> >  {
> > @@ -60,12 +63,11 @@ struct file *backing_tmpfile_open(const struct path=
 *user_path, int flags,
> >       struct file *f;
> >       int error;
> >
> > -     f =3D alloc_empty_backing_file(flags, cred);
> > +     f =3D alloc_empty_backing_file(flags, cred, user_cred);
> >       if (IS_ERR(f))
> >               return f;
> >
> > -     path_get(user_path);
> > -     backing_file_set_user_path(f, user_path);
> > +     backing_file_open_user_path(f, user_path);
> >       error =3D vfs_tmpfile(real_idmap, real_parentpath, f, mode);
> >       if (error) {
> >               fput(f);
> > diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> > index 829d50d5c717..17a4941d4518 100644
> > --- a/fs/erofs/ishare.c
> > +++ b/fs/erofs/ishare.c
> > @@ -106,15 +106,15 @@ static int erofs_ishare_file_open(struct inode *i=
node, struct file *file)
> >
> >       if (file->f_flags & O_DIRECT)
> >               return -EINVAL;
> > -     realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred());
> > +     realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred(),
> > +                                         file->f_cred);
> >       if (IS_ERR(realfile))
> >               return PTR_ERR(realfile);
> >       ihold(sharedinode);
> >       realfile->f_op =3D &erofs_file_fops;
> >       realfile->f_inode =3D sharedinode;
> >       realfile->f_mapping =3D sharedinode->i_mapping;
> > -     path_get(&file->f_path);
> > -     backing_file_set_user_path(realfile, &file->f_path);
> > +     backing_file_open_user_path(realfile, &file->f_path);
> >
> >       file_ra_state_init(&realfile->f_ra, file->f_mapping);
> >       realfile->private_data =3D EROFS_I(inode);
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..b7dc94656c44 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/task_work.h>
> >  #include <linux/swap.h>
> >  #include <linux/kmemleak.h>
> > +#include <linux/backing-file.h>
> >
> >  #include <linux/atomic.h>
> >
> > @@ -43,11 +44,11 @@ static struct kmem_cache *bfilp_cachep __ro_after_i=
nit;
> >
> >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> >
> > -/* Container for backing file with optional user path */
> > +/* Container for backing file with optional user path file */
> >  struct backing_file {
> >       struct file file;
> >       union {
> > -             struct path user_path;
> > +             struct file user_path_file;
> >               freeptr_t bf_freeptr;
> >       };
> >  };
> > @@ -56,24 +57,44 @@ struct backing_file {
> >
> >  const struct path *backing_file_user_path(const struct file *f)
> >  {
> > -     return &backing_file(f)->user_path;
> > +     return &backing_file(f)->user_path_file.f_path;
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_user_path);
> >
> > -void backing_file_set_user_path(struct file *f, const struct path *pat=
h)
> > +const struct file *backing_file_user_path_file(const struct file *f)
> >  {
> > -     backing_file(f)->user_path =3D *path;
> > +     return &backing_file(f)->user_path_file;
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> > +
> > +void backing_file_open_user_path(struct file *f, const struct path *pa=
th)
>
> I think this is a bad idea. This should return an error but still
> WARN_ON(). Just make callers handle that error just like we do
> everywhere else.

OK.

>
> > +{
> > +     /* open an O_PATH file to reference the user path - cannot fail *=
/
> > +     WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> > +
> > +static void destroy_file(struct file *f)
> > +{
> > +     security_file_free(f);
> > +     put_cred(f->f_cred);
>
> Note that calling destroy_file() in this way bypasses
> security_file_release(). Presumably this doesn't matter because no LSM
> does a security_alloc_file() for this but it adds a nother wrinkly into
> the cleanup path.
>

This is for Paul to comment on.
The way I see it, security_file_open() was not called on the user path file=
,
so no reason to call security_file_release()?

It is very much a possibility that LSM would want to allocate security
context for the user path file during backing_file_mmap, when both files
are available in context, so that later mprotect() will have this stored
information in the user path file security context.

But in this case, wouldn't security_file_free() be enough?

>
> >  }
> > -EXPORT_SYMBOL_GPL(backing_file_set_user_path);
> >
> >  static inline void file_free(struct file *f)
> >  {
> > -     security_file_free(f);
> > +     destroy_file(f);
> >       if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
> >               percpu_counter_dec(&nr_files);
> > -     put_cred(f->f_cred);
> >       if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -             path_put(backing_file_user_path(f));
> > +             struct file *user_path_file =3D &backing_file(f)->user_pa=
th_file;
> > +
> > +             /*
> > +              * no refcount on the user_path_file - they die together,
> > +              * so __fput() is not called for user_path_file. path_put=
()
> > +              * is the only relevant cleanup from __fput().
> > +              */
> > +             destroy_file(user_path_file);
> > +             path_put(&user_path_file->__f_path);
> >               kmem_cache_free(bfilp_cachep, backing_file(f));
> >       } else {
> >               kmem_cache_free(filp_cachep, f);
> > @@ -201,7 +222,7 @@ static int init_file(struct file *f, int flags, con=
st struct cred *cred)
> >        * fget-rcu pattern users need to be able to handle spurious
> >        * refcount bumps we should reinitialize the reused file first.
> >        */
> > -     file_ref_init(&f->f_ref, 1);
> > +     atomic_long_set(&f->f_ref.refcnt, FILE_REF_ONEREF);
>
> No, please don't open-code this. The point is to stop any open-access to
> f_ref. And also below you introduce another atomic_long_set() open-coded
> call as well. Simply adapt file_ref_init() to not do the -1 subtraction
> and use the constants directly.
>

OK.

> >       return 0;
> >  }
> >
> > @@ -290,7 +311,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                   const struct cred *user_cred)
> >  {
> >       struct backing_file *ff;
> >       int error;
> > @@ -305,6 +327,15 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >               return ERR_PTR(error);
> >       }
> >
> > +     error =3D init_file(&ff->user_path_file, O_PATH, user_cred);
> > +     /* user_path_file is not refcounterd - it dies with the backing f=
ile */
> > +     atomic_long_set(&ff->user_path_file.f_ref.refcnt, FILE_REF_DEAD);
>
> Please massage this and send that patch. I'll stuff it into a stable vfs
> branch that both Paul and I can merge. Paul can then send his PR.

Sure. I'll try to send it later today.

Thanks,
Amir.
