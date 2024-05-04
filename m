Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F641DDF5;
	Sat,  4 May 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714842650; cv=none; b=GbvMRXfFG0OI9fEcWXEQzTnOTaYsAuoCm8BtNWMOPmEumEXU3tkvGK2nEtAls50LpomLY2Tzs2qwaXw2XO89IRcKcTS5xs961Woe9pPljwhi7zxD8FTawGDAePGLL1P5pQN/saTsTff/tOhcY9Tyi1I+cY9gHRAHVHYvUVAbpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714842650; c=relaxed/simple;
	bh=rU+rvQzm+/5v+E9/+wbfXUSNzFrOfnTP1hKYG1/XORw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cYOdEnP/y79VsqQpqPy+r11AROqr/WJSQ8Si6EbZufPOldYhihfU6sE3iVCOqoiJwhS0cfTLG8/dfglwuyatAKZpmoOSlKvLjvJ24lJI5B+UCj1aiJtI1PglTHPbMPQT27h2n/5KchUBABIrxhHmDiUKGcsBMJy5+4PGBWPDh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from dummy.faircode.eu (unknown [172.56.15.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 8EB1965A;
	Sat,  4 May 2024 12:04:55 -0500 (CDT)
Date: Sat, 4 May 2024 12:04:43 -0500 (CDT)
From: Serge Hallyn <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <720925eb-98f5-4ef7-b064-14e1edf6aeaa@hallyn.com>
In-Reply-To: <20240503005850.466144-2-paul@paul-moore.com>
References: <20240503005850.466144-2-paul@paul-moore.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <720925eb-98f5-4ef7-b064-14e1edf6aeaa@hallyn.com>

May 2, 2024 19:59:11 Paul Moore <paul@paul-moore.com>:

> The current security_inode_setxattr() and security_inode_removexattr()
> hooks rely on individual LSMs to either call into the associated
> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
> return a magic value of 1 to indicate that the LSM layer itself should
> perform the capability checks.=C2=A0 Unfortunately, with the default retu=
rn
> value for these LSM hooks being 0, an individual LSM hook returning a
> 1 will cause the LSM hook processing to exit early, potentially
> skipping a LSM.=C2=A0 Thankfully, with the exception of the BPF LSM, none
> of the LSMs which currently register inode xattr hooks should end up
> returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
> executing last there should be no real harm in stopping processing of
> the LSM hooks.=C2=A0 However, the reliance on the individual LSMs to eith=
er
> call the capability hooks themselves, or signal the LSM with a return
> value of 1, is fragile and relies on a specific set of LSMs being
> enabled.=C2=A0 This patch is an effort to resolve, or minimize, these
> issues.
>
> Before we discuss the solution, there are a few observations and
> considerations that we need to take into account:
> * BPF LSM registers an implementation for every LSM hook, and that
> =C2=A0 implementation simply returns the hook's default return value, a
> =C2=A0 0 in this case.=C2=A0 We want to ensure that the default BPF LSM b=
ehavior
> =C2=A0 results in the capability checks being called.
> * SELinux and Smack do not expect the traditional capability checks
> =C2=A0 to be applied to the xattrs that they "own".
> * SELinux and Smack are currently written in such a way that the
> =C2=A0 xattr capability checks happen before any additional LSM specific
> =C2=A0 access control checks.=C2=A0 SELinux does apply SELinux specific a=
ccess
> =C2=A0 controls to all xattrs, even those not "owned" by SELinux.
> * IMA and EVM also register xattr hooks but assume that the LSM layer
> =C2=A0 and specific LSMs have already authorized the basic xattr operatio=
n.
>
> In order to ensure we perform the capability based access controls
> before the individual LSM access controls, perform only one capability
> access control check for each operation, and clarify the logic around
> applying the capability controls, we need a mechanism to determine if
> any of the enabled LSMs "own" a particular xattr and want to take
> responsibility for controlling access to that xattr.=C2=A0 The solution i=
n
> this patch is to create a new LSM hook, 'inode_xattr_skipcap', that is
> not exported to the rest of the kernel via a security_XXX() function,
> but is used by the LSM layer to determine if a LSM wants to control
> access to a given xattr and avoid the traditional capability controls.
> Registering an inode_xattr_skipcap hook is optional, if a LSM declines
> to register an implementation, or uses an implementation that simply
> returns the default value (0), there is no effect as the LSM continues
> to enforce the capability based controls (unless another LSM takes
> ownership of the xattr).=C2=A0 If none of the LSMs signal that the
> capability checks should be skipped, the capability check is performed
> and if access is granted the individual LSM xattr access control hooks
> are executed, keeping with the DAC-before-LSM convention.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
> include/linux/lsm_hook_defs.h |=C2=A0 1 +
> security/security.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 70 ++++++++++++++++++++++++-----------
> security/selinux/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++---=
-
> security/smack/smack_lsm.c=C2=A0=C2=A0=C2=A0 | 31 +++++++++++++++-
> 4 files changed, 98 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 334e00efbde4..6e54dae3256b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -144,6 +144,7 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idm=
ap, struct dentry *dentry,
> LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, int ia_valid)
> LSM_HOOK(int, 0, inode_getattr, const struct path *path)
> +LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
> LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *name, const v=
oid *value,
> =C2=A0=C2=A0=C2=A0=C2=A0 size_t size, int flags)
> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..1f5c68e2a62a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2278,7 +2278,20 @@ int security_inode_getattr(const struct path *path=
)
> =C2=A0 * @size: size of xattr value
> =C2=A0 * @flags: flags
> =C2=A0 *
> - * Check permission before setting the extended attributes.
> + * This hook performs the desired permission checks before setting the e=
xtended
> + * attributes (xattrs) on @dentry.=C2=A0 It is important to note that we=
 have some
> + * additional logic before the main LSM implementation calls to detect i=
f we
> + * need to perform an additional capability check at the LSM layer.
> + *
> + * Normally we enforce a capability check prior to executing the various=
 LSM
> + * hook implementations, but if a LSM wants to avoid this capability che=
ck,
> + * it can register a 'inode_xattr_skipcap' hook and return a value of 1 =
for
> + * xattrs that it wants to avoid the capability check, leaving the LSM f=
ully
> + * responsible for enforcing the access control for the specific xattr.=
=C2=A0 If all
> + * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' =
hook,
> + * or return a 0 (the default return value), the capability check is sti=
ll
> + * performed.=C2=A0 If no 'inode_xattr_skipcap' hooks are registered the=
 capability
> + * check is performed.
> =C2=A0 *
> =C2=A0 * Return: Returns 0 if permission is granted.
> =C2=A0 */
> @@ -2286,20 +2299,20 @@ int security_inode_setxattr(struct mnt_idmap *idm=
ap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const void *value, size_t size, int flags)
> {
> -=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0 int rc;
>
> =C2=A0=C2=A0=C2=A0 if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> -=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0 * SELinux and Smack integrate the cap call,
> -=C2=A0=C2=A0=C2=A0 * so assume that all LSMs supplying this call do so.
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 ret =3D call_int_hook(inode_setxattr, idmap, dentry, name, =
value, size,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 flags);
>
> -=C2=A0=C2=A0 if (ret =3D=3D 1)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D cap_inode_setxattr(dentry, =
name, value, size, flags);
> -=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0 /* enforce the capability checks at the lsm layer, if neede=
d */
> +=C2=A0=C2=A0 if (!call_int_hook(inode_xattr_skipcap, name)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D cap_inode_setxattr(dentry, n=
ame, value, size, flags);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 return call_int_hook(inode_setxattr, idmap, dentry, name, v=
alue, size,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 flags);
> }
>
> /**
> @@ -2452,26 +2465,39 @@ int security_inode_listxattr(struct dentry *dentr=
y)
> =C2=A0 * @dentry: file
> =C2=A0 * @name: xattr name
> =C2=A0 *
> - * Check permission before removing the extended attribute identified by=
 @name
> - * for @dentry.
> + * This hook performs the desired permission checks before setting the e=
xtended
> + * attributes (xattrs) on @dentry.=C2=A0 It is important to note that we=
 have some
> + * additional logic before the main LSM implementation calls to detect i=
f we
> + * need to perform an additional capability check at the LSM layer.
> + *
> + * Normally we enforce a capability check prior to executing the various=
 LSM
> + * hook implementations, but if a LSM wants to avoid this capability che=
ck,
> + * it can register a 'inode_xattr_skipcap' hook and return a value of 1 =
for
> + * xattrs that it wants to avoid the capability check, leaving the LSM f=
ully
> + * responsible for enforcing the access control for the specific xattr.=
=C2=A0 If all
> + * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' =
hook,
> + * or return a 0 (the default return value), the capability check is sti=
ll
> + * performed.=C2=A0 If no 'inode_xattr_skipcap' hooks are registered the=
 capability
> + * check is performed.
> =C2=A0 *
> =C2=A0 * Return: Returns 0 if permission is granted.
> =C2=A0 */
> int security_inode_removexattr(struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *nam=
e)
> {
> -=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0 int rc;
>
> =C2=A0=C2=A0=C2=A0 if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> -=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0 * SELinux and Smack integrate the cap call,
> -=C2=A0=C2=A0=C2=A0 * so assume that all LSMs supplying this call do so.
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 ret =3D call_int_hook(inode_removexattr, idmap, dentry, nam=
e);
> -=C2=A0=C2=A0 if (ret =3D=3D 1)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D cap_inode_removexattr(idmap=
, dentry, name);
> -=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0 /* enforce the capability checks at the lsm layer, if neede=
d */
> +=C2=A0=C2=A0 if (!call_int_hook(inode_xattr_skipcap, name)) {

Hm, so if it should happen that lsm 2 returns 0 (allow) but lsm 3
has skipcap return 3, and lsm 3 would have returned
1 to deny the remove, we will get an unexpected result.=C2=A0 It feels like
we need a stronger tie between the lsm which allowed and the one
saying skip the capability check.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D cap_inode_removexattr(idmap,=
 dentry, name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 return call_int_hook(inode_removexattr, idmap, dentry, name=
);
> }
>
> /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3448454c82d0..7be385ebf09b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3181,6 +3181,23 @@ static bool has_cap_mac_admin(bool audit)
> =C2=A0=C2=A0=C2=A0 return true;
> }
>
> +/**
> + * selinux_inode_xattr_skipcap - Skip the xattr capability checks?
> + * @name: name of the xattr
> + *
> + * Returns 1 to indicate that SELinux "owns" the access control rights t=
o xattrs
> + * named @name; the LSM layer should avoid enforcing any traditional
> + * capability based access controls on this xattr.=C2=A0 Returns 0 to in=
dicate that
> + * SELinux does not "own" the access control rights to xattrs named @nam=
e and is
> + * deferring to the LSM layer for further access controls, including cap=
ability
> + * based controls.
> + */
> +static int selinux_inode_xattr_skipcap(const char *name)
> +{
> +=C2=A0=C2=A0 /* require capability check if not a selinux xattr */
> +=C2=A0=C2=A0 return !strcmp(name, XATTR_NAME_SELINUX);
> +}
> +
> static int selinux_inode_setxattr(struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *value, size_t size, int flags)
> @@ -3192,15 +3209,9 @@ static int selinux_inode_setxattr(struct mnt_idmap=
 *idmap,
> =C2=A0=C2=A0=C2=A0 u32 newsid, sid =3D current_sid();
> =C2=A0=C2=A0=C2=A0 int rc =3D 0;
>
> -=C2=A0=C2=A0 if (strcmp(name, XATTR_NAME_SELINUX)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D cap_inode_setxattr(dentry, n=
ame, value, size, flags);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Not an attribute we recognize, s=
o just check the
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ordinary setattr =
permission. */
> +=C2=A0=C2=A0 /* if not a selinux xattr, only check the ordinary setattr =
perm */
> +=C2=A0=C2=A0 if (strcmp(name, XATTR_NAME_SELINUX))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dentry_has_perm(current=
_cred(), dentry, FILE__SETATTR);
> -=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0 if (!selinux_initialized())
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (inode_owner_or_capable=
(idmap, inode) ? 0 : -EPERM);
> @@ -7185,6 +7196,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_permission, selinux_inode_permissi=
on),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_setattr, selinux_inode_setattr),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_getattr, selinux_inode_getattr),
> +=C2=A0=C2=A0 LSM_HOOK_INIT(inode_xattr_skipcap, selinux_inode_xattr_skip=
cap),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_post_setxattr, selinux_inode_post_=
setxattr),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 146667937811..6e37df0465a4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1282,6 +1282,33 @@ static int smack_inode_getattr(const struct path *=
path)
> =C2=A0=C2=A0=C2=A0 return rc;
> }
>
> +/**
> + * smack_inode_xattr_skipcap - Skip the xattr capability checks?
> + * @name: name of the xattr
> + *
> + * Returns 1 to indicate that Smack "owns" the access control rights to =
xattrs
> + * named @name; the LSM layer should avoid enforcing any traditional
> + * capability based access controls on this xattr.=C2=A0 Returns 0 to in=
dicate that
> + * Smack does not "own" the access control rights to xattrs named @name =
and is
> + * deferring to the LSM layer for further access controls, including cap=
ability
> + * based controls.
> + */
> +static int smack_inode_xattr_skipcap(const char *name)
> +{
> +=C2=A0=C2=A0 if (strncmp(name, XATTR_SMACK_SUFFIX, strlen(XATTR_SMACK_SU=
FFIX)))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +
> +=C2=A0=C2=A0 if (strcmp(name, XATTR_NAME_SMACK) =3D=3D 0 ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(name, XATTR_NAME_SMACKIPIN) =
=3D=3D 0 ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(name, XATTR_NAME_SMACKIPOUT)=
 =3D=3D 0 ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(name, XATTR_NAME_SMACKEXEC) =
=3D=3D 0 ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(name, XATTR_NAME_SMACKMMAP) =
=3D=3D 0 ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(name, XATTR_NAME_SMACKTRANSM=
UTE) =3D=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> +
> +=C2=A0=C2=A0 return 0;
> +}
> +
> /**
> =C2=A0 * smack_inode_setxattr - Smack check for setting xattrs
> =C2=A0 * @idmap: idmap of the mount
> @@ -1325,8 +1352,7 @@ static int smack_inode_setxattr(struct mnt_idmap *i=
dmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size !=
=3D TRANS_TRUE_SIZE ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncm=
p(value, TRANS_TRUE, TRANS_TRUE_SIZE) !=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D=
 -EINVAL;
> -=C2=A0=C2=A0 } else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D cap_inode_setxattr(dentry, n=
ame, value, size, flags);
> +=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0 if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D -EPERM;
> @@ -5050,6 +5076,7 @@ static struct security_hook_list smack_hooks[] __ro=
_after_init =3D {
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_permission, smack_inode_permission=
),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_setattr, smack_inode_setattr),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_getattr, smack_inode_getattr),
> +=C2=A0=C2=A0 LSM_HOOK_INIT(inode_xattr_skipcap, smack_inode_xattr_skipca=
p),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_setxattr, smack_inode_setxattr),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_se=
txattr),
> =C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),
> --
> 2.45.0

