Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A7239E6F
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562401; cv=none; b=R3/y0Pe/gPIjMXSYUrtjt8Y91GwZu4OyoU2sG/mDxFn1rAZj0XNbRtxuA8+XCPPFxVAkDLw2pU83XU9Iw9q9jpz+W2oHve5yT1fcVZ0+rkmjIhuqCO7KOlozkjm1H7mqdBcsM7yRT31ReKIlVI6UNXwg1zNh6ZK2f8SdhsezvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562401; c=relaxed/simple;
	bh=cFNTzCiHJmcuac0FQjdvPoSqKCzLqHx7to5MRNi4Nqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChJvhB/MneWIhyrRgsKsE0l2BJeNC0whWI1QdpliNlQrdUc4a2EmWN9KdzbbRqfDg3zbEjojRVJ1oDwxRV1t/QbWUhP/aqO4KDht30OWBsaCUNpNB4kdIdl46zxR1XnAtO/qT5IydBDLYITzjxnCISPrVOACMekG7AqUsk5Gus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJBoDoqb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJBoDoqb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340e525487eso4373931a91.3
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763562399; x=1764167199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAbmEc56lrW/G+PNMvpmsruQbkk6TnHTig6AzlmbVR8=;
        b=YJBoDoqbKsrSt5J3RfAWIXeP91Wy4C8Q978Qs0eq2UmQY3W1Ml5UbQ/2jRhFz/wLRf
         wJ9j3YCE6yIEUuyUcwi2feB7zjTPO1zFGRJQEZA6NuLEiPTdimb8d+hJlNtL8zvrEDOR
         ZKWELCLAC/jnW5/EbdZAI80fJSjdQT7GYnd9asF7fN8qI7hJziUQH7W4ow7gHyjABgAp
         wuwOLmZYvPtjxe8hSidNn84/OdTgV5xWku4Zvf1n0NWzNhs7KVhzGp/1HmgzqEzAL9fA
         faewbdHz5T/ipB5EMwbwE2LqE7gpKQe6XIC25pchwQFS6WhFLN+kZv5dZbzTgiUT9ByU
         D26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562399; x=1764167199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sAbmEc56lrW/G+PNMvpmsruQbkk6TnHTig6AzlmbVR8=;
        b=ISBaBRHYZJhuF+KcBofSmjLhn03LoHPZwf5j0SUkdZ6wqZju9T4LUdvk50WMdQyGYk
         Tw+TGVbZr1IP3gqNVX87cMk/iSC+HQ5D0pnvZwH7kF+t6jhBkd/BORbTMjpsaVP8yFZp
         AfHDtDghdlJiBGbyP8FBWyC9eEuoJiy6F1pcUZYq5IcaaGBcNTBEi+ZAYTgJb43sjDl9
         ZMz8YLsZZMZ8JgQikpKgeEkTPfIAXiHAiWDwaEjI7AP/T2LFxOORvo3LU38dfEBHhkTe
         m7urlVdbsnYBVlQoxDbOaLmEMXPMLr9KWLEa04YpbZtIsxr7NMTZnmqmhjxMokazmGp7
         ljYA==
X-Gm-Message-State: AOJu0YzZkrp9kBeTBYhoKyXI9bruARWdwI1XlYHxkxi/QxPWxXaD3ron
	8DQ5jiXuT4poGRU7ZHlyVWLBx83YhA2OgqnMGQiVN9o6WIMgXHmDPN/44fD2xC/Ar2JGt2vcUj9
	hUUVUytPa7NXwwELtlGtjuCFS+/2vCyA=
X-Gm-Gg: ASbGnct9+84bAG7TZ6VOBC4fAkJfvCchfIlsK9Ot/lCKd5Ou8swCMTt4HF+pa9WyvVJ
	1kkokSPlCtfo8rKCxAHtPQ+OWnS8H4+ZpjYwrZkpC0VBhJMNURNB3JquNU27VWrkO/lc0wY+iUz
	D1YrhXUsrNtt4kZs+n7+A7lCRBFXC52pXsV77JmisiclK6G8cFNzA/K8iv7Oh1d2dpr3we/4s6U
	eUICchpuCgeCOxbTgyF+hhwXVH8+Jj1LcMIJcz7KQgq77USo275f7niKplVLjteSr9hYQJ9iy0e
	+PrsGucDRBj3aSFE
X-Google-Smtp-Source: AGHT+IHcl/kgKxk0o/k6md2rPz/Ry7N896tsojyKSEEIYWU+Ezb5zCP9DT7PdIMkP0gy9AdEaoi/UJ6k7I/2eSUsbHs=
X-Received: by 2002:a17:90b:58ef:b0:343:eb40:8dca with SMTP id
 98e67ed59e1d1-343fa6377b5mr21002300a91.19.1763562398322; Wed, 19 Nov 2025
 06:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119020334.521449-4-paul@paul-moore.com> <20251119020334.521449-6-paul@paul-moore.com>
In-Reply-To: <20251119020334.521449-6-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Nov 2025 09:26:27 -0500
X-Gm-Features: AWmQ_bnPRm1yRv8j6FbOzL48yscyoKmmc-XtDeSpvPtPZHI0hPGVn0ZK-RnQUU0
Message-ID: <CAEjxPJ7bpvNFY5EAZyS7UDbVfc5y_84qv28mbztLLNvk8ROo5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: rename the cred_security_struct variables to "crsec"
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Along with the renaming from task_security_struct to cred_security_struct=
,
> rename the local variables to "crsec" from "tsec".  This both fits with
> existing conventions and helps distinguish between task and cred related
> variables.
>
> No functional changes.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Did you mean to leave the tsec variable in current_sid() in objsec.h
and the old_tsec/new_tsec variables used in various places unchanged?
Not looking forward to re-basing the working-selinuxns branch on top of thi=
s.
Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  security/selinux/hooks.c | 154 +++++++++++++++++++--------------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0ac4b05eb56c..49f5720a144c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -210,12 +210,12 @@ static int selinux_lsm_notifier_avc_callback(u32 ev=
ent)
>   */
>  static void cred_init_security(void)
>  {
> -       struct cred_security_struct *tsec;
> +       struct cred_security_struct *crsec;
>
>         /* NOTE: the lsm framework zeros out the buffer on allocation */
>
> -       tsec =3D selinux_cred(unrcu_pointer(current->real_cred));
> -       tsec->osid =3D tsec->sid =3D SECINITSID_KERNEL;
> +       crsec =3D selinux_cred(unrcu_pointer(current->real_cred));
> +       crsec->osid =3D crsec->sid =3D SECINITSID_KERNEL;
>  }
>
>  /*
> @@ -223,10 +223,10 @@ static void cred_init_security(void)
>   */
>  static inline u32 cred_sid(const struct cred *cred)
>  {
> -       const struct cred_security_struct *tsec;
> +       const struct cred_security_struct *crsec;
>
> -       tsec =3D selinux_cred(cred);
> -       return tsec->sid;
> +       crsec =3D selinux_cred(cred);
> +       return crsec->sid;
>  }
>
>  static void __ad_net_init(struct common_audit_data *ad,
> @@ -437,15 +437,15 @@ static int may_context_mount_sb_relabel(u32 sid,
>                         struct superblock_security_struct *sbsec,
>                         const struct cred *cred)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(cred);
> +       const struct cred_security_struct *crsec =3D selinux_cred(cred);
>         int rc;
>
> -       rc =3D avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +       rc =3D avc_has_perm(crsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
>                           FILESYSTEM__RELABELFROM, NULL);
>         if (rc)
>                 return rc;
>
> -       rc =3D avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
> +       rc =3D avc_has_perm(crsec->sid, sid, SECCLASS_FILESYSTEM,
>                           FILESYSTEM__RELABELTO, NULL);
>         return rc;
>  }
> @@ -454,9 +454,9 @@ static int may_context_mount_inode_relabel(u32 sid,
>                         struct superblock_security_struct *sbsec,
>                         const struct cred *cred)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(cred);
> +       const struct cred_security_struct *crsec =3D selinux_cred(cred);
>         int rc;
> -       rc =3D avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +       rc =3D avc_has_perm(crsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
>                           FILESYSTEM__RELABELFROM, NULL);
>         if (rc)
>                 return rc;
> @@ -1788,7 +1788,7 @@ static int file_has_perm(const struct cred *cred,
>   * Determine the label for an inode that might be unioned.
>   */
>  static int
> -selinux_determine_inode_label(const struct cred_security_struct *tsec,
> +selinux_determine_inode_label(const struct cred_security_struct *crsec,
>                                  struct inode *dir,
>                                  const struct qstr *name, u16 tclass,
>                                  u32 *_new_isid)
> @@ -1800,11 +1800,11 @@ selinux_determine_inode_label(const struct cred_s=
ecurity_struct *tsec,
>             (sbsec->behavior =3D=3D SECURITY_FS_USE_MNTPOINT)) {
>                 *_new_isid =3D sbsec->mntpoint_sid;
>         } else if ((sbsec->flags & SBLABEL_MNT) &&
> -                  tsec->create_sid) {
> -               *_new_isid =3D tsec->create_sid;
> +                  crsec->create_sid) {
> +               *_new_isid =3D crsec->create_sid;
>         } else {
>                 const struct inode_security_struct *dsec =3D inode_securi=
ty(dir);
> -               return security_transition_sid(tsec->sid,
> +               return security_transition_sid(crsec->sid,
>                                                dsec->sid, tclass,
>                                                name, _new_isid);
>         }
> @@ -1817,7 +1817,7 @@ static int may_create(struct inode *dir,
>                       struct dentry *dentry,
>                       u16 tclass)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         struct inode_security_struct *dsec;
>         struct superblock_security_struct *sbsec;
>         u32 sid, newsid;
> @@ -1827,7 +1827,7 @@ static int may_create(struct inode *dir,
>         dsec =3D inode_security(dir);
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> -       sid =3D tsec->sid;
> +       sid =3D crsec->sid;
>
>         ad.type =3D LSM_AUDIT_DATA_DENTRY;
>         ad.u.dentry =3D dentry;
> @@ -1838,7 +1838,7 @@ static int may_create(struct inode *dir,
>         if (rc)
>                 return rc;
>
> -       rc =3D selinux_determine_inode_label(tsec, dir, &dentry->d_name, =
tclass,
> +       rc =3D selinux_determine_inode_label(crsec, dir, &dentry->d_name,=
 tclass,
>                                            &newsid);
>         if (rc)
>                 return rc;
> @@ -2529,12 +2529,12 @@ static void selinux_bprm_committing_creds(const s=
truct linux_binprm *bprm)
>   */
>  static void selinux_bprm_committed_creds(const struct linux_binprm *bprm=
)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         u32 osid, sid;
>         int rc;
>
> -       osid =3D tsec->osid;
> -       sid =3D tsec->sid;
> +       osid =3D crsec->osid;
> +       sid =3D crsec->sid;
>
>         if (sid =3D=3D osid)
>                 return;
> @@ -2911,7 +2911,7 @@ static int selinux_dentry_create_files_as(struct de=
ntry *dentry, int mode,
>  {
>         u32 newsid;
>         int rc;
> -       struct cred_security_struct *tsec;
> +       struct cred_security_struct *crsec;
>
>         rc =3D selinux_determine_inode_label(selinux_cred(old),
>                                            d_inode(dentry->d_parent), nam=
e,
> @@ -2920,8 +2920,8 @@ static int selinux_dentry_create_files_as(struct de=
ntry *dentry, int mode,
>         if (rc)
>                 return rc;
>
> -       tsec =3D selinux_cred(new);
> -       tsec->create_sid =3D newsid;
> +       crsec =3D selinux_cred(new);
> +       crsec->create_sid =3D newsid;
>         return 0;
>  }
>
> @@ -2929,7 +2929,7 @@ static int selinux_inode_init_security(struct inode=
 *inode, struct inode *dir,
>                                        const struct qstr *qstr,
>                                        struct xattr *xattrs, int *xattr_c=
ount)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         struct superblock_security_struct *sbsec;
>         struct xattr *xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         u32 newsid, clen;
> @@ -2939,9 +2939,9 @@ static int selinux_inode_init_security(struct inode=
 *inode, struct inode *dir,
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> -       newsid =3D tsec->create_sid;
> +       newsid =3D crsec->create_sid;
>         newsclass =3D inode_mode_to_security_class(inode->i_mode);
> -       rc =3D selinux_determine_inode_label(tsec, dir, qstr, newsclass, =
&newsid);
> +       rc =3D selinux_determine_inode_label(crsec, dir, qstr, newsclass,=
 &newsid);
>         if (rc)
>                 return rc;
>
> @@ -3660,7 +3660,7 @@ static void selinux_inode_getlsmprop(struct inode *=
inode, struct lsm_prop *prop)
>  static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
>  {
>         struct lsm_prop prop;
> -       struct cred_security_struct *tsec;
> +       struct cred_security_struct *crsec;
>         struct cred *new_creds =3D *new;
>
>         if (new_creds =3D=3D NULL) {
> @@ -3669,10 +3669,10 @@ static int selinux_inode_copy_up(struct dentry *s=
rc, struct cred **new)
>                         return -ENOMEM;
>         }
>
> -       tsec =3D selinux_cred(new_creds);
> +       crsec =3D selinux_cred(new_creds);
>         /* Get label from overlay inode and set it in create_sid */
>         selinux_inode_getlsmprop(d_inode(src), &prop);
> -       tsec->create_sid =3D prop.selinux.secid;
> +       crsec->create_sid =3D prop.selinux.secid;
>         *new =3D new_creds;
>         return 0;
>  }
> @@ -3698,7 +3698,7 @@ static int selinux_inode_copy_up_xattr(struct dentr=
y *dentry, const char *name)
>  static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
>                                         struct kernfs_node *kn)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         u32 parent_sid, newsid, clen;
>         int rc;
>         char *context;
> @@ -3726,8 +3726,8 @@ static int selinux_kernfs_init_security(struct kern=
fs_node *kn_dir,
>         if (rc)
>                 return rc;
>
> -       if (tsec->create_sid) {
> -               newsid =3D tsec->create_sid;
> +       if (crsec->create_sid) {
> +               newsid =3D crsec->create_sid;
>         } else {
>                 u16 secclass =3D inode_mode_to_security_class(kn->mode);
>                 const char *kn_name;
> @@ -3738,7 +3738,7 @@ static int selinux_kernfs_init_security(struct kern=
fs_node *kn_dir,
>                 q.name =3D kn_name;
>                 q.hash_len =3D hashlen_string(kn_dir, kn_name);
>
> -               rc =3D security_transition_sid(tsec->sid,
> +               rc =3D security_transition_sid(crsec->sid,
>                                              parent_sid, secclass, &q,
>                                              &newsid);
>                 if (rc)
> @@ -4166,9 +4166,9 @@ static int selinux_cred_prepare(struct cred *new, c=
onst struct cred *old,
>                                 gfp_t gfp)
>  {
>         const struct cred_security_struct *old_tsec =3D selinux_cred(old)=
;
> -       struct cred_security_struct *tsec =3D selinux_cred(new);
> +       struct cred_security_struct *crsec =3D selinux_cred(new);
>
> -       *tsec =3D *old_tsec;
> +       *crsec =3D *old_tsec;
>         return 0;
>  }
>
> @@ -4178,9 +4178,9 @@ static int selinux_cred_prepare(struct cred *new, c=
onst struct cred *old,
>  static void selinux_cred_transfer(struct cred *new, const struct cred *o=
ld)
>  {
>         const struct cred_security_struct *old_tsec =3D selinux_cred(old)=
;
> -       struct cred_security_struct *tsec =3D selinux_cred(new);
> +       struct cred_security_struct *crsec =3D selinux_cred(new);
>
> -       *tsec =3D *old_tsec;
> +       *crsec =3D *old_tsec;
>  }
>
>  static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
> @@ -4199,7 +4199,7 @@ static void selinux_cred_getlsmprop(const struct cr=
ed *c, struct lsm_prop *prop)
>   */
>  static int selinux_kernel_act_as(struct cred *new, u32 secid)
>  {
> -       struct cred_security_struct *tsec =3D selinux_cred(new);
> +       struct cred_security_struct *crsec =3D selinux_cred(new);
>         u32 sid =3D current_sid();
>         int ret;
>
> @@ -4208,10 +4208,10 @@ static int selinux_kernel_act_as(struct cred *new=
, u32 secid)
>                            KERNEL_SERVICE__USE_AS_OVERRIDE,
>                            NULL);
>         if (ret =3D=3D 0) {
> -               tsec->sid =3D secid;
> -               tsec->create_sid =3D 0;
> -               tsec->keycreate_sid =3D 0;
> -               tsec->sockcreate_sid =3D 0;
> +               crsec->sid =3D secid;
> +               crsec->create_sid =3D 0;
> +               crsec->keycreate_sid =3D 0;
> +               crsec->sockcreate_sid =3D 0;
>         }
>         return ret;
>  }
> @@ -4223,7 +4223,7 @@ static int selinux_kernel_act_as(struct cred *new, =
u32 secid)
>  static int selinux_kernel_create_files_as(struct cred *new, struct inode=
 *inode)
>  {
>         struct inode_security_struct *isec =3D inode_security(inode);
> -       struct cred_security_struct *tsec =3D selinux_cred(new);
> +       struct cred_security_struct *crsec =3D selinux_cred(new);
>         u32 sid =3D current_sid();
>         int ret;
>
> @@ -4233,7 +4233,7 @@ static int selinux_kernel_create_files_as(struct cr=
ed *new, struct inode *inode)
>                            NULL);
>
>         if (ret =3D=3D 0)
> -               tsec->create_sid =3D isec->sid;
> +               crsec->create_sid =3D isec->sid;
>         return ret;
>  }
>
> @@ -4748,15 +4748,15 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_s=
id, u32 *conn_sid)
>
>  /* socket security operations */
>
> -static int socket_sockcreate_sid(const struct cred_security_struct *tsec=
,
> +static int socket_sockcreate_sid(const struct cred_security_struct *crse=
c,
>                                  u16 secclass, u32 *socksid)
>  {
> -       if (tsec->sockcreate_sid > SECSID_NULL) {
> -               *socksid =3D tsec->sockcreate_sid;
> +       if (crsec->sockcreate_sid > SECSID_NULL) {
> +               *socksid =3D crsec->sockcreate_sid;
>                 return 0;
>         }
>
> -       return security_transition_sid(tsec->sid, tsec->sid,
> +       return security_transition_sid(crsec->sid, crsec->sid,
>                                        secclass, NULL, socksid);
>  }
>
> @@ -4801,7 +4801,7 @@ static int sock_has_perm(struct sock *sk, u32 perms=
)
>  static int selinux_socket_create(int family, int type,
>                                  int protocol, int kern)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         u32 newsid;
>         u16 secclass;
>         int rc;
> @@ -4810,17 +4810,17 @@ static int selinux_socket_create(int family, int =
type,
>                 return 0;
>
>         secclass =3D socket_type_to_security_class(family, type, protocol=
);
> -       rc =3D socket_sockcreate_sid(tsec, secclass, &newsid);
> +       rc =3D socket_sockcreate_sid(crsec, secclass, &newsid);
>         if (rc)
>                 return rc;
>
> -       return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, =
NULL);
> +       return avc_has_perm(crsec->sid, newsid, secclass, SOCKET__CREATE,=
 NULL);
>  }
>
>  static int selinux_socket_post_create(struct socket *sock, int family,
>                                       int type, int protocol, int kern)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         struct inode_security_struct *isec =3D inode_security_novalidate(=
SOCK_INODE(sock));
>         struct sk_security_struct *sksec;
>         u16 sclass =3D socket_type_to_security_class(family, type, protoc=
ol);
> @@ -4828,7 +4828,7 @@ static int selinux_socket_post_create(struct socket=
 *sock, int family,
>         int err =3D 0;
>
>         if (!kern) {
> -               err =3D socket_sockcreate_sid(tsec, sclass, &sid);
> +               err =3D socket_sockcreate_sid(crsec, sclass, &sid);
>                 if (err)
>                         return err;
>         }
> @@ -6530,37 +6530,37 @@ static void selinux_d_instantiate(struct dentry *=
dentry, struct inode *inode)
>  static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
>                                char **value)
>  {
> -       const struct cred_security_struct *tsec;
> +       const struct cred_security_struct *crsec;
>         int error;
>         u32 sid;
>         u32 len;
>
>         rcu_read_lock();
> -       tsec =3D selinux_cred(__task_cred(p));
> +       crsec =3D selinux_cred(__task_cred(p));
>         if (p !=3D current) {
> -               error =3D avc_has_perm(current_sid(), tsec->sid,
> +               error =3D avc_has_perm(current_sid(), crsec->sid,
>                                      SECCLASS_PROCESS, PROCESS__GETATTR, =
NULL);
>                 if (error)
>                         goto err_unlock;
>         }
>         switch (attr) {
>         case LSM_ATTR_CURRENT:
> -               sid =3D tsec->sid;
> +               sid =3D crsec->sid;
>                 break;
>         case LSM_ATTR_PREV:
> -               sid =3D tsec->osid;
> +               sid =3D crsec->osid;
>                 break;
>         case LSM_ATTR_EXEC:
> -               sid =3D tsec->exec_sid;
> +               sid =3D crsec->exec_sid;
>                 break;
>         case LSM_ATTR_FSCREATE:
> -               sid =3D tsec->create_sid;
> +               sid =3D crsec->create_sid;
>                 break;
>         case LSM_ATTR_KEYCREATE:
> -               sid =3D tsec->keycreate_sid;
> +               sid =3D crsec->keycreate_sid;
>                 break;
>         case LSM_ATTR_SOCKCREATE:
> -               sid =3D tsec->sockcreate_sid;
> +               sid =3D crsec->sockcreate_sid;
>                 break;
>         default:
>                 error =3D -EOPNOTSUPP;
> @@ -6585,7 +6585,7 @@ static int selinux_lsm_getattr(unsigned int attr, s=
truct task_struct *p,
>
>  static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  {
> -       struct cred_security_struct *tsec;
> +       struct cred_security_struct *crsec;
>         struct cred *new;
>         u32 mysid =3D current_sid(), sid =3D 0, ptsid;
>         int error;
> @@ -6671,11 +6671,11 @@ static int selinux_lsm_setattr(u64 attr, void *va=
lue, size_t size)
>            operation.  See selinux_bprm_creds_for_exec for the execve
>            checks and may_create for the file creation checks. The
>            operation will then fail if the context is not permitted. */
> -       tsec =3D selinux_cred(new);
> +       crsec =3D selinux_cred(new);
>         if (attr =3D=3D LSM_ATTR_EXEC) {
> -               tsec->exec_sid =3D sid;
> +               crsec->exec_sid =3D sid;
>         } else if (attr =3D=3D LSM_ATTR_FSCREATE) {
> -               tsec->create_sid =3D sid;
> +               crsec->create_sid =3D sid;
>         } else if (attr =3D=3D LSM_ATTR_KEYCREATE) {
>                 if (sid) {
>                         error =3D avc_has_perm(mysid, sid,
> @@ -6683,22 +6683,22 @@ static int selinux_lsm_setattr(u64 attr, void *va=
lue, size_t size)
>                         if (error)
>                                 goto abort_change;
>                 }
> -               tsec->keycreate_sid =3D sid;
> +               crsec->keycreate_sid =3D sid;
>         } else if (attr =3D=3D LSM_ATTR_SOCKCREATE) {
> -               tsec->sockcreate_sid =3D sid;
> +               crsec->sockcreate_sid =3D sid;
>         } else if (attr =3D=3D LSM_ATTR_CURRENT) {
>                 error =3D -EINVAL;
>                 if (sid =3D=3D 0)
>                         goto abort_change;
>
>                 if (!current_is_single_threaded()) {
> -                       error =3D security_bounded_transition(tsec->sid, =
sid);
> +                       error =3D security_bounded_transition(crsec->sid,=
 sid);
>                         if (error)
>                                 goto abort_change;
>                 }
>
>                 /* Check permissions for the transition. */
> -               error =3D avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
> +               error =3D avc_has_perm(crsec->sid, sid, SECCLASS_PROCESS,
>                                      PROCESS__DYNTRANSITION, NULL);
>                 if (error)
>                         goto abort_change;
> @@ -6713,7 +6713,7 @@ static int selinux_lsm_setattr(u64 attr, void *valu=
e, size_t size)
>                                 goto abort_change;
>                 }
>
> -               tsec->sid =3D sid;
> +               crsec->sid =3D sid;
>         } else {
>                 error =3D -EINVAL;
>                 goto abort_change;
> @@ -6880,14 +6880,14 @@ static int selinux_inode_getsecctx(struct inode *=
inode, struct lsm_context *cp)
>  static int selinux_key_alloc(struct key *k, const struct cred *cred,
>                              unsigned long flags)
>  {
> -       const struct cred_security_struct *tsec;
> +       const struct cred_security_struct *crsec;
>         struct key_security_struct *ksec =3D selinux_key(k);
>
> -       tsec =3D selinux_cred(cred);
> -       if (tsec->keycreate_sid)
> -               ksec->sid =3D tsec->keycreate_sid;
> +       crsec =3D selinux_cred(cred);
> +       if (crsec->keycreate_sid)
> +               ksec->sid =3D crsec->keycreate_sid;
>         else
> -               ksec->sid =3D tsec->sid;
> +               ksec->sid =3D crsec->sid;
>
>         return 0;
>  }
> --
> 2.52.0
>
