Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DD349AE8
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879941; cv=pass; b=YaftWQxBW7sMGaJwFnwe1yGtrEMpmNwdCpec6Z+rG4DWIzZq1Am0njfaNWpro8ct5ynwUZPmz4Xvitw8pOCFL5PrGiWCxzFgvpeJdxM1X171a56dCSoaaEeL4qCCAPiiKQ6mSmkcHA8A9DdP4tj7nXYTB4o3wnyDpcdpNrrypAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879941; c=relaxed/simple;
	bh=8h4Kq5sYMU7Nul6/aUFs0+VrveZBFvRInCDUHY99o+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqGphkRFiHwJiUqt7xd/7r+xzQjVlU4DHeFcQKWhf470FEORi+y0HncCzHNHMQ6xO75pz8lTj3id8yYzDaDdtBP6Mzb4z1EN3SjlKQJWrCH/31FGjAJxVNBmUymTTKehpgdrFf5swQRtjYbRdgIOYIYhWBnQd+eIrfnjuPD2x+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WJultXlZ; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WJultXlZ"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649278a69c5so3357030d50.3
        for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 09:18:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769879938; cv=none;
        d=google.com; s=arc-20240605;
        b=lQDTpE1WG8hA1Ist2sbINpDQaRXOjnNl5Xm++U0qn9wn3eDs5TXKKbf6bGhrjcEqu3
         3CtHzVBTggMOJefJQNKS/yqykE6TMCHxLKsaVEiwNDnW+kyBSLE8PkQ203ieopRot8O0
         qcHU2zCEcESnWZLfCCxZWT8si6LNVEBn3NySA9QllzMCSYUVxN09ljBcdWXh3OAePvzw
         J4axX9D2VBcOtGe5Yr98yodPbhZAIpb6w9NqTHyysjpb4SXyUbbhQTAPF0q3EYBtPuhe
         iIUxmL60viKIf7SXteyIc7fEyEFlqN4eUsG0Ps6Ky4pSM+XFXzA3Bix/4BsXZ5HYjxLO
         tfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dYLahIhJVMQ3AhAI8qEKK+m+y3hA1N/KcPA2nPxrdto=;
        fh=PkcZWdIcZ81Ewm9knZxjpZf89vc9T9q3qCRFSok3Df8=;
        b=jzWlTnuljjFvEYvUryAOOWX96FJRnXU53h5pbdaU/BB8AZJlgwFtjNrZv6yDW7ExkI
         cKLxk8XV9D8G2h0Fnd0uXsFQhYpNDSF8/9N6e9YOeHtsP8e7gX4PLIgiptjHdmq7HdU+
         nAlULhW0ITpWu1rlcFdAIIfVgh/lUv95h3IBPFPHhzEvsHC5bBBInY4R5a76vpJF1LDs
         ccfC3truZdQrkxbXSVBYlAUQahnqAMZnVYpt9keztewdMt0BVNET0NnOjgQH5+EHen3m
         dTR2ggFIQzv7li52cg2bh7S7lsA6A894Rzg405HJ/V9iYKhtjnPct51gL3hLh0eCjuWw
         nDBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769879938; x=1770484738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYLahIhJVMQ3AhAI8qEKK+m+y3hA1N/KcPA2nPxrdto=;
        b=WJultXlZ0O11PDxNUqYqvWrNDrEL/Ycy2ErqWoChnCf5m5LTwyTsiZzYqeYYCkDnFI
         4jgPy+i3j52i0ZmR6mIp8FcIop4d4fuaianOc4JXMUTy1gxuU7y7ykJPa8k/aqyJ4hWo
         pbXjzwjoPtmjj/RmP18jmzSLInNobyMNiQAEWZP53+IHtsUL6k0IIrzZqBZPwxmUlIQa
         oK6IEumXsszYC8SLQVvUJeUSxxVTBu8gV3N1AACYDH+YoxX3PMrNBGCqxeWExvlXSkKO
         o9aju1FBcptTA4cGSZNAC/hiobyOg3L2b5DY47vRXQfiXKzFmHWCtE+GLX/+8XNI2RTS
         0lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769879938; x=1770484738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYLahIhJVMQ3AhAI8qEKK+m+y3hA1N/KcPA2nPxrdto=;
        b=TSVqsryTZLt/S3EdaDXAGe1hiN03NujH57Qzc6/y/UxJDkCjc2yTwCiUh3UqUkmeFc
         bp/Py1jlFbquyEBZHSG5qdqO5bvwplxjlTnWUTrRWtcevdTsdiYT0OpyNtcWJuI61gd6
         +h7wLkPk8DrCeiacu4A3E5G0/alCGt+MsOydXV1zZPadeFnewD0FItkhgCCGfbm3QpEf
         1tEzGj3PKMLvLyzpG+v6Aa8g6KSGqJCP3Elh6JNIfQGdv9RFST+x4kgSAW6Zh6WGsEpx
         OJ26e6D3Y4CLxPEGNr/QsZyXOAtu/H9PxtUZo1BRB4xUMzcxzK7lTMuu87qlp0gnhjpq
         7bhA==
X-Gm-Message-State: AOJu0YwEmBKWJ595gTNRgFs0OHtF13TZG0KfUFjkaOJdPXoZeGHS27Kv
	HFI0RjtsEg2zicA458O2umbFVFkVZBiW8qY7DgKv3uUpuVv55bgmDhgNaFofrLtN5J5q2EKdfyk
	mnlCJUZU6LxUD3alCwgdkG1TZ4arpTUtLyE3V1yo=
X-Gm-Gg: AZuq6aLAFRaXm31aNQq+DqyjzlZk/sIWfu2MHLyF+FpS1NRCb6HOCyWQvnWR+0xTCI8
	OrmokIWiP6hQk0H8/QZfIK6ltFX6zPs7AmD5xu8E4rEhbn9lM4CD1VNdf/FQ1eXMMsi8muOkZ5q
	vk0+qVxI4CzOx/sp4xpuXwqXDPfiwdiNXa0q6dbXqxdkUnsqXBw4JRp2mJD3eSfQxpMrGRX9K8e
	JsgvL1erS9VQgXRoWD25vKeCdXpy24brw+WVZh/dgzo0RHWl2R0gA+4jPqKDQeunOU=
X-Received: by 2002:a05:690e:1c07:b0:649:3ad2:332 with SMTP id
 956f58d0204a3-649a8400a7bmr5213021d50.40.1769879938461; Sat, 31 Jan 2026
 09:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171140.90966-1-cgoettsche@seltendoof.de> <5893d15993a809a3b1b80deb0c27bf1e@paul-moore.com>
In-Reply-To: <5893d15993a809a3b1b80deb0c27bf1e@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sat, 31 Jan 2026 18:18:47 +0100
X-Gm-Features: AZwV_QijXBJSZfYOs8k2ZfLPm6YDSj_XgO6YC9qEHmydKoV_VsRoB-w5Qlu_yAw
Message-ID: <CAJ2a_Dddd=u9zGB0KB2-YeAbteByVa__4+S21mYxcPJi0DFm3g@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: prevent truncation of status map
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 at 21:46, Paul Moore <paul@paul-moore.com> wrote:
>
> On Jan 30, 2026 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoettsc=
he@seltendoof.de> wrote:
> >
> > Currently the SELinux status map can be truncated, given the necessary
> > permissions, leading to foreign user space processes getting a bus erro=
r
> > (SIGBUS) while concurrently making use of the status map.
> > For example systemd can be killed that way, see [1].
> >
> > Override the setattr inode handler and check for O_TRUNC in the open
> > handler to prevent truncations.
> >
> > Link [1]: https://github.com/systemd/systemd/issues/37349
> >
> > Closes: https://github.com/SELinuxProject/selinux/issues/475
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/selinuxfs.c | 43 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 896acad1f5f7..df079a35a02d 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -214,10 +214,30 @@ static const struct file_operations sel_handle_un=
known_ops =3D {
> >       .llseek         =3D generic_file_llseek,
> >  };
> >
> > +static int sel_setattr_handle_status(struct mnt_idmap *idmap,
> > +                                  struct dentry *dentry,
> > +                                  struct iattr *iattr)
> > +{
> > +     /* Prevent truncation to avoid raising SIGBUS */
> > +     if (iattr->ia_valid & ATTR_SIZE)
> > +             return -EINVAL;
>
> Do we want this as -EINVAL or -EPERM?  However, see my comments below
> about how to handle the ATTR_SIZE case.

I did not choose EPERM because it is not a matter of missing
permissions of the caller.
The status page should just not support truncation and EINVAL seemed
more natural than ENOTSUP.

>
> > +     return simple_setattr(idmap, dentry, iattr);
> > +}
> > +
> > +static const struct inode_operations sel_handle_status_iops =3D {
> > +     .setattr        =3D sel_setattr_handle_status,
> > +};
> > +
> >  static int sel_open_handle_status(struct inode *inode, struct file *fi=
lp)
> >  {
> > -     struct page    *status =3D selinux_kernel_status_page();
> > +     struct page *status;
> >
> > +     /* Prevent truncation to avoid raising SIGBUS */
> > +     if (filp->f_flags & O_TRUNC)
> > +             return -EINVAL;
>
> Same as above, should this be -EPERM?
>
> > +     status =3D selinux_kernel_status_page();
> >       if (!status)
> >               return -ENOMEM;
> >
> > @@ -1980,7 +2000,6 @@ static int sel_fill_super(struct super_block *sb,=
 struct fs_context *fc)
> >               [SEL_CHECKREQPROT] =3D {"checkreqprot", &sel_checkreqprot=
_ops, S_IRUGO|S_IWUSR},
> >               [SEL_REJECT_UNKNOWN] =3D {"reject_unknown", &sel_handle_u=
nknown_ops, S_IRUGO},
> >               [SEL_DENY_UNKNOWN] =3D {"deny_unknown", &sel_handle_unkno=
wn_ops, S_IRUGO},
> > -             [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S_IRU=
GO},
> >               [SEL_POLICY] =3D {"policy", &sel_policy_ops, S_IRUGO},
> >               [SEL_VALIDATE_TRANS] =3D {"validatetrans", &sel_transitio=
n_ops,
> >                                       S_IWUGO},
> > @@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >       if (ret)
> >               goto err;
> >
> > +     /* Create "status" separately to assign a custom inode_operations=
 */
> > +     {
> > +             ret =3D -ENOMEM;
> > +
> > +             dentry =3D d_alloc_name(sb->s_root, "status");
> > +             if (!dentry)
> > +                     goto err;
> > +             inode =3D new_inode(sb);
> > +             if (!inode) {
> > +                     dput(dentry);
> > +                     goto err;
> > +             }
> > +             inode->i_mode =3D S_IFREG | 0444;
> > +             simple_inode_init_ts(inode);
> > +             inode->i_fop =3D &sel_handle_status_ops;
> > +             inode->i_op =3D &sel_handle_status_iops;
> > +             inode->i_ino =3D SEL_STATUS;
> > +             d_add(dentry, inode);
> > +     }
>
> I worry a little about duplicating and open coding the per-file loop from
> simple_fill_super(), I can see things slowly getting out of sync and bad
> things happening.  Unfortunately, I don't see anything in libfs that woul=
d
> allow us to supply our own inode_operations either.

We could ask the FS people if they would be fine with the following patch:


diff --git a/fs/libfs.c b/fs/libfs.c
index 9264523be85c..76f7fec136cb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1089,6 +1089,7 @@ int simple_fill_super(struct super_block *s,
unsigned long magic,
               }
               inode->i_mode =3D S_IFREG | files->mode;
               simple_inode_init_ts(inode);
+               inode->i_op =3D files->iops;
               inode->i_fop =3D files->ops;
               inode->i_ino =3D i;
               d_make_persistent(dentry, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d..9f1a9f0a9b48 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3225,7 +3225,7 @@ extern const struct file_operations simple_dir_operat=
ions;
extern const struct inode_operations simple_dir_inode_operations;
extern void make_empty_dir_inode(struct inode *inode);
extern bool is_empty_dir_inode(struct inode *inode);
-struct tree_descr { const char *name; const struct file_operations
*ops; int mode; };
+struct tree_descr { const char *name; const struct file_operations
*ops; int mode; const struct inode_operations *iops; };
struct dentry *d_alloc_name(struct dentry *, const char *);
extern int simple_fill_super(struct super_block *, unsigned long,
                            const struct tree_descr *);


and then adding the hook would just be

-               [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S_IRUGO=
},
+               [SEL_STATUS] =3D {"status", &sel_handle_status_ops,
S_IRUGO, &sel_handle_status_iops},

>
> What do you think about using selinux_inode_setattr() as shown below,
> would this work?
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index feda34b18d83..8e4374f22a18 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -106,6 +106,7 @@
>  #include "netlabel.h"
>  #include "audit.h"
>  #include "avc_ss.h"
> +#include "selinuxfs.h"
>
>  #define SELINUX_INODE_INIT_XATTRS 1
>
> @@ -3291,6 +3292,12 @@ static int selinux_inode_setattr(struct mnt_idmap =
*idmap, struct dentry *dentry,
>                         return 0;
>         }
>
> +       if (inode->i_sb->s_magic =3D=3D SELINUX_MAGIC) {
> +               int rc =3D selinuxfs_inode_setattr(idmap, inode, iattr);
> +               if (rc)
> +                       return rc;
> +       }
> +

I don't like that approach, since up to now selinux_inode_setattr() is
only for SELinux permission checking and this would add some behavior
modification into it.

>         if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
>                         ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET)=
)
>                 return dentry_has_perm(cred, dentry, FILE__SETATTR);
> diff --git a/security/selinux/include/selinuxfs.h b/security/selinux/incl=
ude/selinuxfs.h
> new file mode 100644
> index 000000000000..f5e6da02833b
> --- /dev/null
> +++ b/security/selinux/include/selinuxfs.h
> @@ -0,0 +1,2 @@
> +int selinuxfs_inode_setattr(struct mnt_idmap *idmap, struct inode *inode=
,
> +                            struct iattr *iattr);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 896acad1f5f7..5af5e1dee743 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -43,6 +43,7 @@
>  #include "objsec.h"
>  #include "conditional.h"
>  #include "ima.h"
> +#include "selinuxfs.h"
>
>  enum sel_inos {
>         SEL_ROOT_INO =3D 2,
> @@ -1954,6 +1955,20 @@ static struct dentry *sel_make_swapover_dir(struct=
 super_block *sb,
>         return dentry;  // borrowed
>  }
>
> +int selinuxfs_inode_setattr(struct mnt_idmap *idmap, struct inode *inode=
,
> +                           struct iattr *iattr)
> +{
> +       switch (inode->i_ino) {
> +       case SEL_STATUS:
> +               if (iattr->ia_valid & ATTR_SIZE)
> +                       return -EPERM;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
>
> --
> paul-moore.com
