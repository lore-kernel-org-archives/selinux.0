Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD82FD7B1
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769807284; cv=pass; b=kgBLfzMcCMD5gI+UnXLzYvSdkPEbC0DxMGdb4gVzux+HxtS63be/NP3vRd/zkPpwIpIPG3yuDbgDRHhCGtNURwUGW4N2LdlZIXr1ReWhjB7CWcjS1JOLdvFH/A3rFA3Bw6Xnf8IaIdG/tKzQFVXWtHaVwAfzKUAe0ewDE1F3RtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769807284; c=relaxed/simple;
	bh=QkfMAx+S6ug3Yi6rsDgG0kRIznhDE3DgSGSLz7KkT7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkzmulWZxjJ5oB16MiQicPALAhb0dOncjceqAO0O/NHg7dY3yQKPLklhTXpTAg4L2TkWCYwnn726qD8yXtuwqL3r/kuHH9oF8KOtPmIEOk9ZpswB/KHOX0Y1KRjucIfe6lfabISty/2ICWOMANnmWVL/+dpIvb6W9oJlFALXCkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm7EbRMS; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm7EbRMS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81dab89f286so1299139b3a.2
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 13:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769807282; cv=none;
        d=google.com; s=arc-20240605;
        b=f11tomt38FKft3lOC09HKtC5rhQdPoRARnDkG8Jgv8OwtocYMpLGiV0s9xe3JfaEI9
         cfafpVV013z9LohHFO4pW3gRhx+bP1okDqKXF40q4CTy+vofVHq0YOmTkHQgN/zd9J8t
         rH+YWJxls32NcL8tWo05GKA6dqzKIZbG+qkln9hkhifaWB3aGhow1wSErRk4HhKUSUZ0
         Q1V02WaNRs8z7zhoNUH6IuaV7uS6Ah7NCGfNprl8C0FSbhPqMgJ6NPYHZfaCU0YCW8ty
         n6S3fc7a7TfjElauszzC0ZMEWHigAvK/TogKdS4AV5H5bh3lxP9kI7LQj2ecvn9xOj27
         n67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4oS7SMdq028sJyFGZducpQ0p8aJ43ZevIiWMzdfN/fc=;
        fh=GxrV7ZFnMMacfBovoy6ZwU+yvkSdZc12KlWx/45hQP0=;
        b=YNoBrYxmtMnBUqOWBLVR91Ljd7baYTPRVSXN7APETH29LSqS8nUjsJ4vwoNb2sBB/S
         Zg3I4m92jsfeE5w17giUG75yKMHwwd6Sq2nnXjeSK3cjTmFp6z28eLjnG+bFVI33JITd
         nu7E6k60gcWFH0peUs9wkVuh0PmqTuQBMKr/oKKzpyKAXy2NHK+hUr4s1kKpFiYfUkte
         dU9RgSkMy3489fqsZ5oxgTJ1yvuzTPwJBKkBJv2Bv84xxru8dhQV0JeHOqqX0JjZgNL6
         8PyupEGvmJGj3y+dr3DnAA4wGJ/ZzMyAiYtlY6GE7FnYqzO4Aex/IRw85a/i9XZuij7/
         bVwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769807282; x=1770412082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oS7SMdq028sJyFGZducpQ0p8aJ43ZevIiWMzdfN/fc=;
        b=Jm7EbRMShxB436MklS9NzCBgEMzm/2GBnnENG5IJ7tgPYyUY3xHbx/aWuBtKmoxnTD
         JOW4R7XPxxObjmtyIvDLWUjHEfMiX7CZU5xe1r7BUSMrvaJdRRuHqd+TDRFa3fJVhyQS
         KVv5+diheJmnJKdJW32QqBEPwjMrWnoWta3xOkfJaRUOMC7BA36dunQxGYQdsjlbZ8S6
         EfocPx6cvmqiJP1nfxo0MDScl/AVxh+0SgQ32m4AGIs/9un00gYHGAlqCc8tDiq5PnOJ
         ZNkMx5WbZuzrGfxG7ka0wFhdLvP/kIYoqjuEu5vN/giipXK0lzHQ3LslO6uOinfiZXGm
         qwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769807282; x=1770412082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oS7SMdq028sJyFGZducpQ0p8aJ43ZevIiWMzdfN/fc=;
        b=J0ix3YzcwtXOJyuFw124T/OBRto/toQO7A+DScLbhzhJbhZA5AK7d7Y5+i8ISX5XVi
         KqJUqH4vUeo1VL4tnKJM4YkFfSU/5EwIJelWcP15DZi/HcMWZzwe9lrK4k899U1HDqh2
         pgTlu+CiJtlGN9dgNNG/ksRFbsiNgeZwTPpxEJupjxzuusY6NXkQZrPtDmVRXXngzkhH
         WTDiExUbQCaUsnugwC8HJGQq2mMsBqsHSCoNY+6HZTRpZUYSGbyHnX226UblSGUcQXSJ
         74bC70JWD/yMIoCYbMakOxJtg6Mgt/+zBqge8NtPstqwo/nbembGPEivZTJJ6OVgpMQP
         HWSQ==
X-Gm-Message-State: AOJu0Yx/UyOkyHWnt37k21YgRgMrmECJD936m286IW47P7DVrP32oL2T
	pxU0ZRF/c8Oy6MXda1+++nEds3ehdihf6Lwf6N0KhRXbT3gJjLWbIK5o/NwLz5oqJ5Melw5ikd8
	TgQmIll2ndBWnqFJb3OdgcjHQ1NTnv0ASrg==
X-Gm-Gg: AZuq6aJtiFGrnNyeQagXegFfgw1ua1copI1PZfNLockLaW+KU4y2WOTbUC+XNha8Z7t
	NlWR83Gm2ns0Sf1LvBY5odMhWtccVNH5r3J/SOj2BeYke4klA0pB4tJcANNGOxTTjeFVD5I8RuQ
	6dyh5QEbakRH7B7GAkSkRx2BEDLXGZf9KRyjJdGexNpnSEuJVmXNMuRXFhMPePN69h+JzbCZeBE
	Rboa0UQc2Hz9Hsv/ZSOAnaXpwaEV6o/ukRatsBy+UaNrjz0xT11IgGZCiQzqozEu+9EG7I=
X-Received: by 2002:a05:6a21:6f12:b0:38b:ea2a:284c with SMTP id
 adf61e73a8af0-392e001fee8mr4292525637.20.1769807282401; Fri, 30 Jan 2026
 13:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171140.90966-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260130171140.90966-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 30 Jan 2026 16:07:50 -0500
X-Gm-Features: AZwV_Qi-L29hn6OfmbN-2QMDtIVhgo3IGqtggA9JnMFwtQJo1fyn9ZdQQCTUaJE
Message-ID: <CAEjxPJ7GTB9=-rZOkKe1uiq3G4pdSzPKVcSpYBH9hrhufDq0=A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: prevent truncation of status map
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:11=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Currently the SELinux status map can be truncated, given the necessary
> permissions, leading to foreign user space processes getting a bus error
> (SIGBUS) while concurrently making use of the status map.
> For example systemd can be killed that way, see [1].
>
> Override the setattr inode handler and check for O_TRUNC in the open
> handler to prevent truncations.
>
> Link [1]: https://github.com/systemd/systemd/issues/37349
> Closes: https://github.com/SELinuxProject/selinux/issues/475
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

This issue can't be limited to just the status node, so if we care
about preventing this, we ought to do it for them all.
When would we want to allow truncation of _any_ selinuxfs file?

> ---
>  security/selinux/selinuxfs.c | 43 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 896acad1f5f7..df079a35a02d 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -214,10 +214,30 @@ static const struct file_operations sel_handle_unkn=
own_ops =3D {
>         .llseek         =3D generic_file_llseek,
>  };
>
> +static int sel_setattr_handle_status(struct mnt_idmap *idmap,
> +                                    struct dentry *dentry,
> +                                    struct iattr *iattr)
> +{
> +       /* Prevent truncation to avoid raising SIGBUS */
> +       if (iattr->ia_valid & ATTR_SIZE)
> +               return -EINVAL;
> +
> +       return simple_setattr(idmap, dentry, iattr);
> +}
> +
> +static const struct inode_operations sel_handle_status_iops =3D {
> +       .setattr        =3D sel_setattr_handle_status,
> +};
> +
>  static int sel_open_handle_status(struct inode *inode, struct file *filp=
)
>  {
> -       struct page    *status =3D selinux_kernel_status_page();
> +       struct page *status;
>
> +       /* Prevent truncation to avoid raising SIGBUS */
> +       if (filp->f_flags & O_TRUNC)
> +               return -EINVAL;
> +
> +       status =3D selinux_kernel_status_page();
>         if (!status)
>                 return -ENOMEM;
>
> @@ -1980,7 +2000,6 @@ static int sel_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>                 [SEL_CHECKREQPROT] =3D {"checkreqprot", &sel_checkreqprot=
_ops, S_IRUGO|S_IWUSR},
>                 [SEL_REJECT_UNKNOWN] =3D {"reject_unknown", &sel_handle_u=
nknown_ops, S_IRUGO},
>                 [SEL_DENY_UNKNOWN] =3D {"deny_unknown", &sel_handle_unkno=
wn_ops, S_IRUGO},
> -               [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S_IRU=
GO},
>                 [SEL_POLICY] =3D {"policy", &sel_policy_ops, S_IRUGO},
>                 [SEL_VALIDATE_TRANS] =3D {"validatetrans", &sel_transitio=
n_ops,
>                                         S_IWUGO},
> @@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *sb, =
struct fs_context *fc)
>         if (ret)
>                 goto err;
>
> +       /* Create "status" separately to assign a custom inode_operations=
 */
> +       {
> +               ret =3D -ENOMEM;
> +
> +               dentry =3D d_alloc_name(sb->s_root, "status");
> +               if (!dentry)
> +                       goto err;
> +               inode =3D new_inode(sb);
> +               if (!inode) {
> +                       dput(dentry);
> +                       goto err;
> +               }
> +               inode->i_mode =3D S_IFREG | 0444;
> +               simple_inode_init_ts(inode);
> +               inode->i_fop =3D &sel_handle_status_ops;
> +               inode->i_op =3D &sel_handle_status_iops;
> +               inode->i_ino =3D SEL_STATUS;
> +               d_add(dentry, inode);
> +       }
> +
>         fsi =3D sb->s_fs_info;
>         fsi->bool_dir =3D sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->l=
ast_ino);
>         if (IS_ERR(fsi->bool_dir)) {
> --
> 2.51.0
>
