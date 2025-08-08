Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151823535F;
	Fri,  8 Aug 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654432; cv=none; b=Qj2f81r1KucxHdcLn7ADOCFM+UVRAzj3vGuPBYQq01w8CmQZ+2dGCH0n39Hnr0wkqi24Byt7NEHj5vDqGFW+/aSfh8DNFP3RzwxbFDwYyCyQHLWDMqImnTxQW6mg/AzFf/CjpHrK5TFDTKdz/8p7PLv2fr8Kh2k/ia40EgfyHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654432; c=relaxed/simple;
	bh=Awm2CVl1S46eknzxBL3TWzk0c7W8l/EuMA5R3fDDxIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpZyhiUNpHGUnOS9iAe36pNz25WJ/pqksTf8P3AomRC8b46oL/B5bClh7lIP4LYERhkPErdcBrteLA3K6BsiPPZen1CK6NrZ3ZVHkDY3MCgXPeM5xArrakTCkj8DhEY/OIeVuTC5BsKLvxPCH/EhWhsplNkbvOKnBvslWBiFLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmeMzKoi; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmeMzKoi"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so2481972a91.2;
        Fri, 08 Aug 2025 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754654431; x=1755259231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hi76Ohh79K59CceKNbPaQDs8RKv1PGUmPcWpUhNqOE=;
        b=ZmeMzKoifij67sHCZhMDvVwj5h7DcFHF+HqamUpswTouXLaQsT+BtqyUVDBa5jKSL5
         UJTR4aDi/7p3O7E0h95DMNOLUgN8ykG+a9jfnp3+D3S0dISpyvHznlz1mSZhNnbCSNxl
         Al/V43Q3k8HWIAAxNRmNfTX1QjCDmfQ0VdHAXvyZ3+Y+zuOgTFtv5YUhwoHnBH7zbZwL
         ppI+qxz9m7LEBPioWMIJwKoA9eUGV+8Wc94LGRSAqJiuYfKHrCHcvdddhfsCbju9c2Qm
         VlLmFmEFNBnxRKEeqGXEmDo/txFJg4w6QzmCaptBxD5wh2GmngevM0aKPGvo7ipWEF1f
         +Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654431; x=1755259231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hi76Ohh79K59CceKNbPaQDs8RKv1PGUmPcWpUhNqOE=;
        b=EidEuXqy0DL8MRYjz+hZs4yD9g2E9Rf6WVFqaS+zhJWtPmZ/7qu4H0FXNcbX+q4Z8+
         GCg3GnD9XkFqfIS462By6STDiaSMgUTWXJ0Yx1JOFJu/MOickj18eMl2Rrgyqr5ZiI7I
         94r/IkxVIideRGvMZr9xsSN1IhgLKweKJ7sbSRXzYC9WTnGsJsyTnRRfd7H0lr11+kOv
         iIJAv3cBar3a9kenmTW05VWT+1IpbyBv0mDfCIkAY5XvHSUuAdpXhXqiLi9XSOKlleff
         L/jUqFxURWtGtkLRDoMyKthKFyae14lFRjTwhlOjA9qon2upReYRRqHRMtxtY5Q7im5L
         z15g==
X-Forwarded-Encrypted: i=1; AJvYcCUqpdYDgVceokXsNpe1D+6ZkQyq7KInwOT1KdDQoOEW03AciaJ/weoFTdT3TvHptK8e3iDIxqS1ew==@vger.kernel.org, AJvYcCXHbMSlU45nQKrHFo9LOpw5xk3v9EHYo8XQo0VgsYzPzTH1niuKGRSB9p+KAPMkMi7WMETozQj+EzD7ryJA5BSFzBKF33sR@vger.kernel.org, AJvYcCXKk572z/vSa//nLU0sUF2OtbGwAL+1/GrBHMHhocfJVWslR5jzHiPgvzofDU+cKIaqLe8M4BwFsTQOFJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoa94ygEnhquOjMnJVQ1UdPuyN8YAHcEhew4xM/ZFIG/WyucK
	HvjUbnG5tEHZL0BP5+LbnoUOw/z6XHW8I6MJ1tUNBXNO9JrEJ+w+/yI4hhUcFEN5kFF8Uh18k4D
	mOe5t8YM9ezxlln+BE146Lj/AqlpX2w4=
X-Gm-Gg: ASbGncslvNurWRVnEpPI8TJdCUUYWLU+a4n8hY2K43JO63j6W87wsVnGvD0dMepeFKU
	Rm+588Pa6O/HgUhSBz0LFhuzwHmPGFKjNLBAVRXZTcnWrHiv0W05olY6OPMYq1yGJT5YLA9gvLP
	Qy6K413MGhENOWNWbUeaBv1JgN66ekLWjiuq2+vQ4QIHRJ3tyAPrduvPJoYF5AuRM4JyDdpStBj
	c6yfG0KfciPUjU9Bg==
X-Google-Smtp-Source: AGHT+IHi6fw0dHtVpsqB+ib1T3y9IzTsrvf1TTWV49eZqYfOGNEzc0eot/Xe28UN5RO3wnrOxgcy43UMV4rv8F3rGk4=
X-Received: by 2002:a17:90b:1f87:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-32183c46713mr4345735a91.27.1754654430569; Fri, 08 Aug 2025
 05:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807075647.755848-1-tweek@google.com>
In-Reply-To: <20250807075647.755848-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Aug 2025 08:00:19 -0400
X-Gm-Features: Ac12FXyi4-bvbpcCoKELBvxA5wUsYIy3UCyB7KojQgmh4zQHcK8f2vyyGNnU77s
Message-ID: <CAEjxPJ43YqFSLK_aczqFqtg-p35A8uE-ZCbF6v13Aqq7VxBByA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lsm: add type to security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:57=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Introduce a new enum (lsm_anon_inode_id) to identify the type of
> anonymous inode being created. This enum is passed down to the
> security_inode_init_security_anon LSM hook.

The intent was to distinguish the type of anonymous inode based on
name-based type_transition rules in the policy using the provided name
string. If that doesn't suffice, this might be justified, but the next
patch doesn't appear to justify it.

>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  fs/anon_inodes.c              | 5 +++--
>  include/linux/lsm_hook_defs.h | 3 ++-
>  include/linux/security.h      | 8 ++++++++
>  security/security.c           | 4 +++-
>  security/selinux/hooks.c      | 1 +
>  5 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 1d847a939f29..9a2f09808f86 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -21,6 +21,7 @@
>  #include <linux/magic.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/pseudo_fs.h>
> +#include <linux/security.h>
>
>  #include <linux/uaccess.h>
>
> @@ -121,8 +122,8 @@ struct inode *anon_inode_make_secure_inode(struct sup=
er_block *sb, const char *n
>                 return inode;
>         inode->i_flags &=3D ~S_PRIVATE;
>         inode->i_op =3D &anon_inode_operations;
> -       error =3D security_inode_init_security_anon(inode, &QSTR(name),
> -                                                 context_inode);
> +       error =3D security_inode_init_security_anon(inode, LSM_ANON_INODE=
_GENERIC,
> +                                                 &QSTR(name), context_in=
ode);
>         if (error) {
>                 iput(inode);
>                 return ERR_PTR(error);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index fd11fffdd3c3..1634f41f7a3c 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -119,7 +119,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struc=
t inode *inode,
>          struct inode *dir, const struct qstr *qstr, struct xattr *xattrs=
,
>          int *xattr_count)
>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> -        const struct qstr *name, const struct inode *context_inode)
> +        enum lsm_anon_inode_id type, const struct qstr *name,
> +        const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>          umode_t mode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap=
 *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 521bcb5b9717..98a97b8a1093 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -263,6 +263,12 @@ struct request_sock;
>  #define LSM_UNSAFE_PTRACE      2
>  #define LSM_UNSAFE_NO_NEW_PRIVS        4
>
> +/* anon_inode types */
> +enum lsm_anon_inode_id {
> +       LSM_ANON_INODE_GENERIC,
> +       LSM_ANON_INODE_MEMFD
> +};
> +
>  #ifdef CONFIG_MMU
>  extern int mmap_min_addr_handler(const struct ctl_table *table, int writ=
e,
>                                  void *buffer, size_t *lenp, loff_t *ppos=
);
> @@ -402,6 +408,7 @@ int security_inode_init_security(struct inode *inode,=
 struct inode *dir,
>                                  const struct qstr *qstr,
>                                  initxattrs initxattrs, void *fs_data);
>  int security_inode_init_security_anon(struct inode *inode,
> +                                     enum lsm_anon_inode_id type,
>                                       const struct qstr *name,
>                                       const struct inode *context_inode);
>  int security_inode_create(struct inode *dir, struct dentry *dentry, umod=
e_t mode);
> @@ -889,6 +896,7 @@ static inline int security_inode_init_security(struct=
 inode *inode,
>  }
>
>  static inline int security_inode_init_security_anon(struct inode *inode,
> +                                                   enum lsm_anon_inode_i=
d type,
>                                                     const struct qstr *na=
me,
>                                                     const struct inode *c=
ontext_inode)
>  {
> diff --git a/security/security.c b/security/security.c
> index ad163f06bf7a..09aa858819a2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1861,6 +1861,7 @@ EXPORT_SYMBOL(security_inode_init_security);
>  /**
>   * security_inode_init_security_anon() - Initialize an anonymous inode
>   * @inode: the inode
> + * @type: the type of anonymous inode
>   * @name: the anonymous inode class
>   * @context_inode: an optional related inode
>   *
> @@ -1871,10 +1872,11 @@ EXPORT_SYMBOL(security_inode_init_security);
>   * creation of this inode, or another -errno upon other errors.
>   */
>  int security_inode_init_security_anon(struct inode *inode,
> +                                     enum lsm_anon_inode_id type,
>                                       const struct qstr *name,
>                                       const struct inode *context_inode)
>  {
> -       return call_int_hook(inode_init_security_anon, inode, name,
> +       return call_int_hook(inode_init_security_anon, inode, type, name,
>                              context_inode);
>  }
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..8d36d5ebb6e5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2967,6 +2967,7 @@ static int selinux_inode_init_security(struct inode=
 *inode, struct inode *dir,
>  }
>
>  static int selinux_inode_init_security_anon(struct inode *inode,
> +                                           enum lsm_anon_inode_id type,
>                                             const struct qstr *name,
>                                             const struct inode *context_i=
node)
>  {
> --
> 2.50.1.703.g449372360f-goog
>
