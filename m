Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00F4A24
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661222; cv=none; b=lCv6Kqyjzye2RGRcSLupCpPDppE0Xp19CSNfg8lUCabpov007cq0LodaC5JOXk1tvkihfDkZzR6kPk47sFm68E1ulE/b9xDwz1RA3zGIjZtDd1LIaIRj9isqW9OCugTc/8ri5JxRqZFinzeFU2hkFL+DQ7MnznARAqkTFNZ9/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661222; c=relaxed/simple;
	bh=MlpMpe17byQnY8jNRMvtq9V+mEdIvFpK1rIwcJjPiJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqWJYOYDK3fWmG2pawwGRnWx1EG1O7c2wthk6GFUJmJcSclDMn1iw6ncljXnQ9fvuvwHWQ52aivXVH1yxbcKdvlimNGz3JVCaK20qGRdAxiLutL3qa1BujkoC0ySyX+ybJnMOpeI5VOAo5jXAsGIe4zo4hqzv/2PcjzeeUaCC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d6DJuzUM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d6DJuzUM"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60406302a5eso4424307b3.0
        for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 16:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706661219; x=1707266019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lB8vimWsQhN1yyZIs5jadtiNV7hhN6/jhd9OTslaDm4=;
        b=d6DJuzUM3zEaeFG5l7AM4HoW4KGiYX1BxEZsSPtcWtujojbNw82753M+pmlYoHGV3x
         NOJb80GQJjvjUWb04vgYSkPFoqWC2qR8aXKsk9uPeWJKGcLH/FqvP+r5YLZU2xoTV8qq
         kppfu2BB/ahiEZEPFelTKbfWR/i6dqgIYjQRzOpT/+ZpOyWNKPTPSDNR+QW6rcnm9aGe
         HKO5AJrqxrsKvajmIaa+7NcgEFtqKv+fm/Ajupj8GzUYHjmC8IG2OghSWVZTM4kUQ0EH
         wu/T6ekcCiIMuDQsHjgi8aeRlel+GdWBHpZcGsz/v4z6R8+0kZ3eJjg3E055W0QRhM2Y
         H6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706661219; x=1707266019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB8vimWsQhN1yyZIs5jadtiNV7hhN6/jhd9OTslaDm4=;
        b=rk4PksNYsM9OmFktP6rvvVDa42xSm1vrbBqpCPlG3lMYOnNBtYmZsmbIOsUYnPcgUG
         dlyurSiz2NgdtftME2QBbIPt9v6+p/SBCtNjQgEsNOM2E3Fq+kzRMrngKRuilRAPvLUo
         iiqiVQsg4/f7yaFcJpfIo0C61DBut7D4eAIJzgZumPpH5h/iOnKKggqA2xzNqWiJz2MW
         fmCuOrRdsGdYD8hBK69ejFEpjEUU9Zn7Tke2IgZ3dJ+lnfK/Sre3XNipj1Wu1yisYs1w
         YZm9NICJgEIdc+hYZyC4Uffgn48g+Uuth3/WHnbeMnI4A72gvam48fKRstv8jlHmLB8b
         MuvA==
X-Gm-Message-State: AOJu0YwkNqTg4M+9gZun0LCLA0c3cRGIiiCae3lcq3Xu4om2Cmot2W3U
	CoAbw25igL2fp+7+ZVdkyaNcGHVO7NqnGBi47yY0wAdoZM5Uw1Z5rNNTggpRwMS17kxxOmhVhIU
	048jFMNo7zMY+Sgz6zgk2cvXGURLwXpn65+6yFmCbCLLn/JBZ6Q==
X-Google-Smtp-Source: AGHT+IE7nf3qdroHgyYSp4bah/urChGJ62mYghWOusTIACxAYytGtfpYBkxIjGm0CJZCeFD2y+xAbrWW4AeU1HQBCt0=
X-Received: by 2002:a25:6b0a:0:b0:dc2:2b1e:4b99 with SMTP id
 g10-20020a256b0a000000b00dc22b1e4b99mr219191ybc.42.1706661219295; Tue, 30 Jan
 2024 16:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com> <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2024 19:33:28 -0500
Message-ID: <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ba8f630610330757"

--000000000000ba8f630610330757
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Jan 29, 2024 at 8:31=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > These two hooks currently work like this:
> > 1. If no LSM registers the hook, cap_inode_{set,remove}xattr() is
> >    called.
> > 2. If an LSM hook call returns 0, the loop continues to call further
> >    LSMs (and only stops on an error return value).
> > 3. The "default" return value is 0, so e.g. the default BPF LSM hook
> >    just returns 0.
> >
> > This works if BPF LSM is enabled along with SELinux or SMACK (or not
> > enabled at all), but if it's the only LSM implementing the hook, then
> > the cap_inode_{set,remove}xattr() is erroneously skipped.
> >
> > Fix this by using 1 as the default return value and make the loop
> > recognize it as a no-op return value (i.e. if an LSM returns this value
> > it is treated as if it wasn't called at all). The final logic is simila=
r
> > to that of security_fs_context_parse_param().
> >
> > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  security/security.c           | 45 +++++++++++++++++++++++++----------
> >  2 files changed, 35 insertions(+), 14 deletions(-)
>
> Thanks for working on this Ondrej, I've got a couple of thoughts on
> the approach taken here, but we definitely need to fix this.
>
> My first thought is that we really should move the
> cap_inode_setxattr() and cap_inode_removexattr() calls in security.c
> over to using the LSM hook infrastructure just as we do with other
> capability hooks in commoncap.c:
>
>   LSM_HOOK_INIT(inode_setxattr, cap_inode_setxattr);
>   LSM_HOOK_INIT(inode_removexattr, cap_inode_removexattr);
>
> ... of course we will need to adjust cap_inode_setxattr to take (and
> ignore the idmap) parameter, but that is easy enough.  It looks like
> cap_inode_removexattr() can be used as-is.  Modifications to the only
> two LSMs, SELinux and Smack, which explicitly call out to these
> capability hooks looks rather straightforward as well.  Doing this
> should simplify the LSM hooks significantly, and lower the chance of a
> future LSM mistakenly not doing the required capability calls.  There
> should also be a slight performance bump for the few (one? two?)
> people running both SELinux and Smack in a production environment.
>
> My second thought is that we *really* need to add to the function
> header block comment/description for both these hooks.  Of course the
> details here will change depending on the bits above about the
> capability hooks, but if we need any special handling like you're
> proposing here we really should document it in the hook's header
> block.

A completely untested, other than compiling security/, patch is below
demonstrating what I was thinking.  I've also attached the same patch
in case anyone wants to actually try it out as the cut-n-paste version
below is surely whitespace damaged.  I will warn you that this was
hastily thrown together so it is very likely I screwed something up :)

diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..2d3c0af33b65 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -156,7 +156,8 @@ extern int cap_capset(struct cred *new, const
struct cred *old,
        const kernel_cap_t *inheritable,
        const kernel_cap_t *permitted);
 extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, const
struct file *file);
-int cap_inode_setxattr(struct dentry *dentry, const char *name,
+int cap_inode_setxattr(struct mnt_idmap *idmap,
+        struct dentry *dentry, const char *name,
         const void *value, size_t size, int flags);
 int cap_inode_removexattr(struct mnt_idmap *idmap,
    struct dentry *dentry, const char *name);
@@ -888,7 +889,7 @@ static inline int security_inode_setxattr(struct
mnt_idmap *idmap,
  struct dentry *dentry, const char *name, const void *value,
  size_t size, int flags)
 {
- return cap_inode_setxattr(dentry, name, value, size, flags);
+ return cap_inode_setxattr(idmap, dentry, name, value, size, flags);
 }

 static inline int security_inode_set_acl(struct mnt_idmap *idmap,
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..34caf0e19b2f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -975,6 +975,7 @@ int cap_bprm_creds_from_file(struct linux_binprm
*bprm, const struct file *file)

 /**
  * cap_inode_setxattr - Determine whether an xattr may be altered
+ * @idmap: idmap of the mount
  * @dentry: The inode/dentry being altered
  * @name: The name of the xattr to be changed
  * @value: The value that the xattr will be changed to
@@ -987,7 +988,8 @@ int cap_bprm_creds_from_file(struct linux_binprm
*bprm, const struct file *file)
  * This is used to make sure security xattrs don't get updated or set by t=
hose
  * who aren't privileged to do so.
  */
-int cap_inode_setxattr(struct dentry *dentry, const char *name,
+int cap_inode_setxattr(struct mnt_idmap *idmap,
+        struct dentry *dentry, const char *name,
         const void *value, size_t size, int flags)
 {
  struct user_namespace *user_ns =3D dentry->d_sb->s_user_ns;
@@ -1457,6 +1459,8 @@ static struct security_hook_list
capability_hooks[] __ro_after_init =3D {
  LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
  LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
  LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
+ LSM_HOOK_INIT(inode_setxattr, cap_inode_setxattr),
+ LSM_HOOK_INIT(inode_removexattr, cap_inode_removexattr),
  LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
  LSM_HOOK_INIT(mmap_file, cap_mmap_file),
  LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..6425d177b301 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2258,15 +2258,9 @@ int security_inode_setxattr(struct mnt_idmap *idmap,

  if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
  return 0;
- /*
- * SELinux and Smack integrate the cap call,
- * so assume that all LSMs supplying this call do so.
- */
- ret =3D call_int_hook(inode_setxattr, 1, idmap, dentry, name, value,
-     size, flags);

- if (ret =3D=3D 1)
- ret =3D cap_inode_setxattr(dentry, name, value, size, flags);
+ ret =3D call_int_hook(inode_setxattr, 0, idmap, dentry, name, value,
+     size, flags);
  if (ret)
  return ret;
  ret =3D ima_inode_setxattr(dentry, name, value, size);
@@ -2421,13 +2415,8 @@ int security_inode_removexattr(struct mnt_idmap *idm=
ap,

  if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
  return 0;
- /*
- * SELinux and Smack integrate the cap call,
- * so assume that all LSMs supplying this call do so.
- */
- ret =3D call_int_hook(inode_removexattr, 1, idmap, dentry, name);
- if (ret =3D=3D 1)
- ret =3D cap_inode_removexattr(idmap, dentry, name);
+
+ ret =3D call_int_hook(inode_removexattr, 0, idmap, dentry, name);
  if (ret)
  return ret;
  ret =3D ima_inode_removexattr(dentry, name);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..49cb331a0d84 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3193,10 +3193,6 @@ static int selinux_inode_setxattr(struct
mnt_idmap *idmap,
  int rc =3D 0;

  if (strcmp(name, XATTR_NAME_SELINUX)) {
- rc =3D cap_inode_setxattr(dentry, name, value, size, flags);
- if (rc)
- return rc;
-
  /* Not an attribute we recognize, so just check the
     ordinary setattr permission. */
  return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
@@ -3350,10 +3346,6 @@ static int selinux_inode_removexattr(struct
mnt_idmap *idmap,
       struct dentry *dentry, const char *name)
 {
  if (strcmp(name, XATTR_NAME_SELINUX)) {
- int rc =3D cap_inode_removexattr(idmap, dentry, name);
- if (rc)
- return rc;
-
  /* Not an attribute we recognize, so just check the
     ordinary setattr permission. */
  return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..34b74e442412 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1317,8 +1317,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idm=
ap,
  if (size !=3D TRANS_TRUE_SIZE ||
      strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) !=3D 0)
  rc =3D -EINVAL;
- } else
- rc =3D cap_inode_setxattr(dentry, name, value, size, flags);
+ }

  if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
  rc =3D -EPERM;
@@ -1426,12 +1425,8 @@ static int smack_inode_removexattr(struct
mnt_idmap *idmap,
      strcmp(name, XATTR_NAME_SMACKTRANSMUTE) =3D=3D 0 ||
      strcmp(name, XATTR_NAME_SMACKMMAP) =3D=3D 0) {
  if (!smack_privileged(CAP_MAC_ADMIN))
- rc =3D -EPERM;
- } else
- rc =3D cap_inode_removexattr(idmap, dentry, name);
-
- if (rc !=3D 0)
- return rc;
+ return -EPERM;
+ }

  smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
  smk_ad_setfield_u_fs_path_dentry(&ad, dentry);

--=20
paul-moore.com

--000000000000ba8f630610330757
Content-Type: text/x-patch; charset="US-ASCII"; name="01-XXX-lsm-inode_cap_fixes.patch"
Content-Disposition: attachment; filename="01-XXX-lsm-inode_cap_fixes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ls11x5d30>
X-Attachment-Id: f_ls11x5d30

bHNtLHNlbGludXgsc21hY2s6IGZpeC9jbGVhbnVwIHNlY3VyaXR5X2lub2RlX3tzZXQscmVtb3Zl
fXhhdHRyKCkKCkZyb206IFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+CgpYWFggd3Jp
dGUgYSBwcm9wZXIgY29tbWl0IGRlc2NyaXB0aW9uCgpTaWduZWQtb2ZmLWJ5OiBQYXVsIE1vb3Jl
IDxwYXVsQHBhdWwtbW9vcmUuY29tPgotLS0KIGluY2x1ZGUvbGludXgvc2VjdXJpdHkuaCAgIHwg
ICAgNSArKystLQogc2VjdXJpdHkvY29tbW9uY2FwLmMgICAgICAgfCAgICA2ICsrKysrLQogc2Vj
dXJpdHkvc2VjdXJpdHkuYyAgICAgICAgfCAgIDE5ICsrKystLS0tLS0tLS0tLS0tLS0KIHNlY3Vy
aXR5L3NlbGludXgvaG9va3MuYyAgIHwgICAgOCAtLS0tLS0tLQogc2VjdXJpdHkvc21hY2svc21h
Y2tfbHNtLmMgfCAgIDExICsrKy0tLS0tLS0tCiA1IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlv
bnMoKyksIDM0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2VjdXJp
dHkuaCBiL2luY2x1ZGUvbGludXgvc2VjdXJpdHkuaAppbmRleCBkMGViMjBmOTBiMjYuLjJkM2Mw
YWYzM2I2NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zZWN1cml0eS5oCisrKyBiL2luY2x1
ZGUvbGludXgvc2VjdXJpdHkuaApAQCAtMTU2LDcgKzE1Niw4IEBAIGV4dGVybiBpbnQgY2FwX2Nh
cHNldChzdHJ1Y3QgY3JlZCAqbmV3LCBjb25zdCBzdHJ1Y3QgY3JlZCAqb2xkLAogCQkgICAgICBj
b25zdCBrZXJuZWxfY2FwX3QgKmluaGVyaXRhYmxlLAogCQkgICAgICBjb25zdCBrZXJuZWxfY2Fw
X3QgKnBlcm1pdHRlZCk7CiBleHRlcm4gaW50IGNhcF9icHJtX2NyZWRzX2Zyb21fZmlsZShzdHJ1
Y3QgbGludXhfYmlucHJtICpicHJtLCBjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSk7Ci1pbnQgY2Fw
X2lub2RlX3NldHhhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY29uc3QgY2hhciAqbmFtZSwK
K2ludCBjYXBfaW5vZGVfc2V0eGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsCisJCSAgICAg
ICBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNvbnN0IGNoYXIgKm5hbWUsCiAJCSAgICAgICBjb25z
dCB2b2lkICp2YWx1ZSwgc2l6ZV90IHNpemUsIGludCBmbGFncyk7CiBpbnQgY2FwX2lub2RlX3Jl
bW92ZXhhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCQkJICBzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnksIGNvbnN0IGNoYXIgKm5hbWUpOwpAQCAtODg4LDcgKzg4OSw3IEBAIHN0YXRpYyBpbmxp
bmUgaW50IHNlY3VyaXR5X2lub2RlX3NldHhhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAog
CQlzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IHZvaWQgKnZh
bHVlLAogCQlzaXplX3Qgc2l6ZSwgaW50IGZsYWdzKQogewotCXJldHVybiBjYXBfaW5vZGVfc2V0
eGF0dHIoZGVudHJ5LCBuYW1lLCB2YWx1ZSwgc2l6ZSwgZmxhZ3MpOworCXJldHVybiBjYXBfaW5v
ZGVfc2V0eGF0dHIoaWRtYXAsIGRlbnRyeSwgbmFtZSwgdmFsdWUsIHNpemUsIGZsYWdzKTsKIH0K
IAogc3RhdGljIGlubGluZSBpbnQgc2VjdXJpdHlfaW5vZGVfc2V0X2FjbChzdHJ1Y3QgbW50X2lk
bWFwICppZG1hcCwKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2NvbW1vbmNhcC5jIGIvc2VjdXJpdHkv
Y29tbW9uY2FwLmMKaW5kZXggMTYyZDk2YjNhNjc2Li4zNGNhZjBlMTliMmYgMTAwNjQ0Ci0tLSBh
L3NlY3VyaXR5L2NvbW1vbmNhcC5jCisrKyBiL3NlY3VyaXR5L2NvbW1vbmNhcC5jCkBAIC05NzUs
NiArOTc1LDcgQEAgaW50IGNhcF9icHJtX2NyZWRzX2Zyb21fZmlsZShzdHJ1Y3QgbGludXhfYmlu
cHJtICpicHJtLCBjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAogLyoqCiAgKiBjYXBfaW5vZGVf
c2V0eGF0dHIgLSBEZXRlcm1pbmUgd2hldGhlciBhbiB4YXR0ciBtYXkgYmUgYWx0ZXJlZAorICog
QGlkbWFwOiBpZG1hcCBvZiB0aGUgbW91bnQKICAqIEBkZW50cnk6IFRoZSBpbm9kZS9kZW50cnkg
YmVpbmcgYWx0ZXJlZAogICogQG5hbWU6IFRoZSBuYW1lIG9mIHRoZSB4YXR0ciB0byBiZSBjaGFu
Z2VkCiAgKiBAdmFsdWU6IFRoZSB2YWx1ZSB0aGF0IHRoZSB4YXR0ciB3aWxsIGJlIGNoYW5nZWQg
dG8KQEAgLTk4Nyw3ICs5ODgsOCBAQCBpbnQgY2FwX2Jwcm1fY3JlZHNfZnJvbV9maWxlKHN0cnVj
dCBsaW51eF9iaW5wcm0gKmJwcm0sIGNvbnN0IHN0cnVjdCBmaWxlICpmaWxlKQogICogVGhpcyBp
cyB1c2VkIHRvIG1ha2Ugc3VyZSBzZWN1cml0eSB4YXR0cnMgZG9uJ3QgZ2V0IHVwZGF0ZWQgb3Ig
c2V0IGJ5IHRob3NlCiAgKiB3aG8gYXJlbid0IHByaXZpbGVnZWQgdG8gZG8gc28uCiAgKi8KLWlu
dCBjYXBfaW5vZGVfc2V0eGF0dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjb25zdCBjaGFyICpu
YW1lLAoraW50IGNhcF9pbm9kZV9zZXR4YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwKKwkJ
ICAgICAgIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY29uc3QgY2hhciAqbmFtZSwKIAkJICAgICAg
IGNvbnN0IHZvaWQgKnZhbHVlLCBzaXplX3Qgc2l6ZSwgaW50IGZsYWdzKQogewogCXN0cnVjdCB1
c2VyX25hbWVzcGFjZSAqdXNlcl9ucyA9IGRlbnRyeS0+ZF9zYi0+c191c2VyX25zOwpAQCAtMTQ1
Nyw2ICsxNDU5LDggQEAgc3RhdGljIHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3QgY2FwYWJpbGl0
eV9ob29rc1tdIF9fcm9fYWZ0ZXJfaW5pdCA9IHsKIAlMU01fSE9PS19JTklUKGlub2RlX25lZWRf
a2lsbHByaXYsIGNhcF9pbm9kZV9uZWVkX2tpbGxwcml2KSwKIAlMU01fSE9PS19JTklUKGlub2Rl
X2tpbGxwcml2LCBjYXBfaW5vZGVfa2lsbHByaXYpLAogCUxTTV9IT09LX0lOSVQoaW5vZGVfZ2V0
c2VjdXJpdHksIGNhcF9pbm9kZV9nZXRzZWN1cml0eSksCisJTFNNX0hPT0tfSU5JVChpbm9kZV9z
ZXR4YXR0ciwgY2FwX2lub2RlX3NldHhhdHRyKSwKKwlMU01fSE9PS19JTklUKGlub2RlX3JlbW92
ZXhhdHRyLCBjYXBfaW5vZGVfcmVtb3ZleGF0dHIpLAogCUxTTV9IT09LX0lOSVQobW1hcF9hZGRy
LCBjYXBfbW1hcF9hZGRyKSwKIAlMU01fSE9PS19JTklUKG1tYXBfZmlsZSwgY2FwX21tYXBfZmls
ZSksCiAJTFNNX0hPT0tfSU5JVCh0YXNrX2ZpeF9zZXR1aWQsIGNhcF90YXNrX2ZpeF9zZXR1aWQp
LApkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2VjdXJpdHkuYyBiL3NlY3VyaXR5L3NlY3VyaXR5LmMK
aW5kZXggM2FhYWQ3NWM5Y2U4Li42NDI1ZDE3N2IzMDEgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3Nl
Y3VyaXR5LmMKKysrIGIvc2VjdXJpdHkvc2VjdXJpdHkuYwpAQCAtMjI1OCwxNSArMjI1OCw5IEBA
IGludCBzZWN1cml0eV9pbm9kZV9zZXR4YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwKIAog
CWlmICh1bmxpa2VseShJU19QUklWQVRFKGRfYmFja2luZ19pbm9kZShkZW50cnkpKSkpCiAJCXJl
dHVybiAwOwotCS8qCi0JICogU0VMaW51eCBhbmQgU21hY2sgaW50ZWdyYXRlIHRoZSBjYXAgY2Fs
bCwKLQkgKiBzbyBhc3N1bWUgdGhhdCBhbGwgTFNNcyBzdXBwbHlpbmcgdGhpcyBjYWxsIGRvIHNv
LgotCSAqLwotCXJldCA9IGNhbGxfaW50X2hvb2soaW5vZGVfc2V0eGF0dHIsIDEsIGlkbWFwLCBk
ZW50cnksIG5hbWUsIHZhbHVlLAotCQkJICAgIHNpemUsIGZsYWdzKTsKIAotCWlmIChyZXQgPT0g
MSkKLQkJcmV0ID0gY2FwX2lub2RlX3NldHhhdHRyKGRlbnRyeSwgbmFtZSwgdmFsdWUsIHNpemUs
IGZsYWdzKTsKKwlyZXQgPSBjYWxsX2ludF9ob29rKGlub2RlX3NldHhhdHRyLCAwLCBpZG1hcCwg
ZGVudHJ5LCBuYW1lLCB2YWx1ZSwKKwkJCSAgICBzaXplLCBmbGFncyk7CiAJaWYgKHJldCkKIAkJ
cmV0dXJuIHJldDsKIAlyZXQgPSBpbWFfaW5vZGVfc2V0eGF0dHIoZGVudHJ5LCBuYW1lLCB2YWx1
ZSwgc2l6ZSk7CkBAIC0yNDIxLDEzICsyNDE1LDggQEAgaW50IHNlY3VyaXR5X2lub2RlX3JlbW92
ZXhhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCiAJaWYgKHVubGlrZWx5KElTX1BSSVZB
VEUoZF9iYWNraW5nX2lub2RlKGRlbnRyeSkpKSkKIAkJcmV0dXJuIDA7Ci0JLyoKLQkgKiBTRUxp
bnV4IGFuZCBTbWFjayBpbnRlZ3JhdGUgdGhlIGNhcCBjYWxsLAotCSAqIHNvIGFzc3VtZSB0aGF0
IGFsbCBMU01zIHN1cHBseWluZyB0aGlzIGNhbGwgZG8gc28uCi0JICovCi0JcmV0ID0gY2FsbF9p
bnRfaG9vayhpbm9kZV9yZW1vdmV4YXR0ciwgMSwgaWRtYXAsIGRlbnRyeSwgbmFtZSk7Ci0JaWYg
KHJldCA9PSAxKQotCQlyZXQgPSBjYXBfaW5vZGVfcmVtb3ZleGF0dHIoaWRtYXAsIGRlbnRyeSwg
bmFtZSk7CisKKwlyZXQgPSBjYWxsX2ludF9ob29rKGlub2RlX3JlbW92ZXhhdHRyLCAwLCBpZG1h
cCwgZGVudHJ5LCBuYW1lKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCXJldCA9IGltYV9p
bm9kZV9yZW1vdmV4YXR0cihkZW50cnksIG5hbWUpOwpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2Vs
aW51eC9ob29rcy5jIGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCmluZGV4IGE2YmY5MGFjZTg0
Yy4uNDljYjMzMWEwZDg0IDEwMDY0NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKKysr
IGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCkBAIC0zMTkzLDEwICszMTkzLDYgQEAgc3RhdGlj
IGludCBzZWxpbnV4X2lub2RlX3NldHhhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCWlu
dCByYyA9IDA7CiAKIAlpZiAoc3RyY21wKG5hbWUsIFhBVFRSX05BTUVfU0VMSU5VWCkpIHsKLQkJ
cmMgPSBjYXBfaW5vZGVfc2V0eGF0dHIoZGVudHJ5LCBuYW1lLCB2YWx1ZSwgc2l6ZSwgZmxhZ3Mp
OwotCQlpZiAocmMpCi0JCQlyZXR1cm4gcmM7Ci0KIAkJLyogTm90IGFuIGF0dHJpYnV0ZSB3ZSBy
ZWNvZ25pemUsIHNvIGp1c3QgY2hlY2sgdGhlCiAJCSAgIG9yZGluYXJ5IHNldGF0dHIgcGVybWlz
c2lvbi4gKi8KIAkJcmV0dXJuIGRlbnRyeV9oYXNfcGVybShjdXJyZW50X2NyZWQoKSwgZGVudHJ5
LCBGSUxFX19TRVRBVFRSKTsKQEAgLTMzNTAsMTAgKzMzNDYsNiBAQCBzdGF0aWMgaW50IHNlbGlu
dXhfaW5vZGVfcmVtb3ZleGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsCiAJCQkJICAgICBz
dHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNvbnN0IGNoYXIgKm5hbWUpCiB7CiAJaWYgKHN0cmNtcChu
YW1lLCBYQVRUUl9OQU1FX1NFTElOVVgpKSB7Ci0JCWludCByYyA9IGNhcF9pbm9kZV9yZW1vdmV4
YXR0cihpZG1hcCwgZGVudHJ5LCBuYW1lKTsKLQkJaWYgKHJjKQotCQkJcmV0dXJuIHJjOwotCiAJ
CS8qIE5vdCBhbiBhdHRyaWJ1dGUgd2UgcmVjb2duaXplLCBzbyBqdXN0IGNoZWNrIHRoZQogCQkg
ICBvcmRpbmFyeSBzZXRhdHRyIHBlcm1pc3Npb24uICovCiAJCXJldHVybiBkZW50cnlfaGFzX3Bl
cm0oY3VycmVudF9jcmVkKCksIGRlbnRyeSwgRklMRV9fU0VUQVRUUik7CmRpZmYgLS1naXQgYS9z
ZWN1cml0eS9zbWFjay9zbWFja19sc20uYyBiL3NlY3VyaXR5L3NtYWNrL3NtYWNrX2xzbS5jCmlu
ZGV4IDBmZGJmMDRjYzI1OC4uMzRiNzRlNDQyNDEyIDEwMDY0NAotLS0gYS9zZWN1cml0eS9zbWFj
ay9zbWFja19sc20uYworKysgYi9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYwpAQCAtMTMxNyw4
ICsxMzE3LDcgQEAgc3RhdGljIGludCBzbWFja19pbm9kZV9zZXR4YXR0cihzdHJ1Y3QgbW50X2lk
bWFwICppZG1hcCwKIAkJaWYgKHNpemUgIT0gVFJBTlNfVFJVRV9TSVpFIHx8CiAJCSAgICBzdHJu
Y21wKHZhbHVlLCBUUkFOU19UUlVFLCBUUkFOU19UUlVFX1NJWkUpICE9IDApCiAJCQlyYyA9IC1F
SU5WQUw7Ci0JfSBlbHNlCi0JCXJjID0gY2FwX2lub2RlX3NldHhhdHRyKGRlbnRyeSwgbmFtZSwg
dmFsdWUsIHNpemUsIGZsYWdzKTsKKwl9CiAKIAlpZiAoY2hlY2tfcHJpdiAmJiAhc21hY2tfcHJp
dmlsZWdlZChDQVBfTUFDX0FETUlOKSkKIAkJcmMgPSAtRVBFUk07CkBAIC0xNDI2LDEyICsxNDI1
LDggQEAgc3RhdGljIGludCBzbWFja19pbm9kZV9yZW1vdmV4YXR0cihzdHJ1Y3QgbW50X2lkbWFw
ICppZG1hcCwKIAkgICAgc3RyY21wKG5hbWUsIFhBVFRSX05BTUVfU01BQ0tUUkFOU01VVEUpID09
IDAgfHwKIAkgICAgc3RyY21wKG5hbWUsIFhBVFRSX05BTUVfU01BQ0tNTUFQKSA9PSAwKSB7CiAJ
CWlmICghc21hY2tfcHJpdmlsZWdlZChDQVBfTUFDX0FETUlOKSkKLQkJCXJjID0gLUVQRVJNOwot
CX0gZWxzZQotCQlyYyA9IGNhcF9pbm9kZV9yZW1vdmV4YXR0cihpZG1hcCwgZGVudHJ5LCBuYW1l
KTsKLQotCWlmIChyYyAhPSAwKQotCQlyZXR1cm4gcmM7CisJCQlyZXR1cm4gLUVQRVJNOworCX0K
IAogCXNta19hZF9pbml0KCZhZCwgX19mdW5jX18sIExTTV9BVURJVF9EQVRBX0RFTlRSWSk7CiAJ
c21rX2FkX3NldGZpZWxkX3VfZnNfcGF0aF9kZW50cnkoJmFkLCBkZW50cnkpOwo=
--000000000000ba8f630610330757--
