Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C773EADC
	for <selinux@vger.kernel.org>; Sat, 23 May 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494993; cv=none; b=VaEkPvLVbVgdyjbMFQJK8WOLDaEZhe0KsGnFP5F8fucfgNwVybLNXRML4lBNzUr5aOKASpBgfreDn6iLn8wNaa1nklTryooojv9dNiEedgyPgbFlVoUH/aInLl1rpdYrEKHn9XLRvK3vCaHoifISLZtfiGjK5NKSzj/9814o0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494993; c=relaxed/simple;
	bh=vJJU4GmTY9jmtg0yrZYpivbpmWBSMIctI21fyZ7o2PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t78xK/gYYM5iaYRwk44h+3kBtB20eYnsZJE24SicdR7tLRKaJ7lxcipdeeJFxHaj5Il1/QARPKV6vRm+olcQxL4iliNEqdXtZ2aJj0IsGnRKXsnyOH6WwPHDvgDWoX+6GRNkiiDtSMD+lRF4JgmxoMzRWxBKaWF8LxIJkXYPtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLz6OJ2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLz6OJ2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63E61F01564
	for <selinux@vger.kernel.org>; Sat, 23 May 2026 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779494990;
	bh=3ETkiHyHX86gwae5asX1X/o+svz9W8wf7RwScqd1OB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LLz6OJ2G5VcEwhJ2/c8K+iMqFijT6OnrEV48gzINVrS4k/r+ulK4Q7YINQvQxJaXQ
	 xrJeY31VCURhP233+u4suSIxLCh3ogsJE3FCGmaFiWWN0O+8ulzprV9okn3Ft+KLFe
	 dgmPxI0HYxlzuEVTct4whUgy7ntJl6KNaPW5PfOFx4ZJA5Vn163MRAztJYLmz59hew
	 dxijwqWdlVayWVwLLUlmWVbergjZeABI4ib5iTDnjDruK5jwReWHP92aBQIBPq66KR
	 HDZ+2aUIP9YQ3PpMClQj8zP/3f2SoXnUPDwO8M+lsu+ojg0/C9vpYJ0X1yzJNS7IfJ
	 q8YLhxPAHDDUw==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91080895355so915929385a.3
        for <selinux@vger.kernel.org>; Fri, 22 May 2026 17:09:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9lN+Pdf8N4nNr89KJC1+irxEMbz/m7jO03/veUTJuCC+YyN6dz2Ra5KP8Csa+rlbeE3JVq304c@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDQAWYcaHp2kKA007RRzW89/0j//bLkQTGCC96p+Z0t91CziH
	rh4h8EQApvBISUA2pP8+RtBDPRoQn59W8/nSn+CB3IF+keb6bW8sx39llNJVDr2cqGVr+GUmVt/
	nRoP6Ncf+C3KNu+qwC9qptft/sbDQWSA=
X-Received: by 2002:a05:620a:1a19:b0:914:c48c:4ac4 with SMTP id
 af79cd13be357-914c48c4e17mr197578085a.15.1779494989957; Fri, 22 May 2026
 17:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515200158.4081915-1-song@kernel.org> <20260515200158.4081915-2-song@kernel.org>
 <177944135249.2871055.11361892114499566606.b4-review@b4>
In-Reply-To: <177944135249.2871055.11361892114499566606.b4-review@b4>
From: Song Liu <song@kernel.org>
Date: Fri, 22 May 2026 17:09:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4BVSQ6oqyk=kExuZUkB9PWRRqUf_EJ=x3mNmtkT4oH4g@mail.gmail.com>
X-Gm-Features: AVHnY4LT2cV2r2zWcbI0oZ727WxL46ft_rV_sB6qqeKVssDd55dfD2nDOQXPZeA
Message-ID: <CAPhsuW4BVSQ6oqyk=kExuZUkB9PWRRqUf_EJ=x3mNmtkT4oH4g@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:16=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, 15 May 2026 13:01:52 -0700, Song Liu <song@kernel.org> wrote:
> > [...]
> >
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selin=
ux only
> > Signed-off-by: Song Liu <song@kernel.org>
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

^^^^^ I assume you didn't mean to add this SoB yet.

>
> Please cleanly separate the preparatory work for introducing the new
> hooks from any changes to fs/namespace.c
>
> Once you have all of the new machinery in place, switch fs/namespace.c
> over to the new hooks.

Could you please be more specific on how to arrange these changes?
Currently, we have

1/7 adds new hooks:
  lsm: Add granular mount hooks to replace security_sb_mount
2/7 through 6/7 migrate LSMs from old hooks to new hooks:
  apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
  apparmor: Convert from sb_mount to granular mount hooks
  selinux: Convert from sb_mount to granular mount hooks
  landlock: Convert from sb_mount to granular mount hooks
  tomoyo: Convert from sb_mount to granular mount hooks
7/7 removes old hooks:
  lsm: Remove security_sb_mount and security_move_mount

Some ideas to change this:

Idea #1:
Do you mean to split 1/7 and 7/7 into two patches each: one
for changes in fs/namespace.c, the other for everything else?
IOW, the set of 9 patches will look like:

1/9 adds new hooks in security/ core code
2/9 adds calls to new hooks to fs/namespace.c
3/9 through 7/9 migrate LSMs from old hooks to new hooks
8/9 removes calls to old hooks from s/namespace.c
9/9 removes old hooks from security/ core code

Idea #2:
Or do you mean all the changes to fs/namespace.c have to
stay in one commit? I am not sure how we can make the
whole patchset clean with this approach. We will probably
need 2+ commits for each of the 4 LSMs we update. IOW,
the set will look like:

Add new hooks in security core code
Add new hooks in selinux
Add new hooks in apparmor
Add new hooks in landlock
Add new hooks in tamoyo
Replace old hooks with new hooks in fs/namespace.c
Remove old hooks from selinux
Remove old hooks from apparmor
Remove old hooks from landlock
Remove old hooks from tamoyo
Remove old hooks in security core code

This will require at least 11 patches, and it is not
really clean.

Idea #3:
Did I miss any other solutions?

> This will make it way easier to review and easier to distribute the

This sentence appears to be incomplete. Do you mean to distribute
different patches in the patchset to different trees and merge them
separately?

I actually think the patchset is clean as-is.

The overall change in fs/namespace.c is really minimal:
    fs/namespace.c                    |  41 +++++++---

We can clearly see what it changed in fs/namespace.c with
"git diff HEAD~7 -- fs/" (attached below).

Therefore, I don't see a way to make the whole patchset more
clean. If I missed anything, please let me know.

Thanks,
Song


$ git diff HEAD~7 -- fs/
diff --git c/fs/namespace.c w/fs/namespace.c
index fe919abd2f01..43f22c5e2bf4 100644
--- c/fs/namespace.c
+++ w/fs/namespace.c
@@ -2888,6 +2888,10 @@ static int do_change_type(const struct path
*path, int ms_flags)
        if (!type)
                return -EINVAL;

+       err =3D security_mount_change_type(path, ms_flags);
+       if (err)
+               return err;
+
        guard(namespace_excl)();

        err =3D may_change_propagation(mnt);
@@ -3006,6 +3010,10 @@ static int do_loopback(const struct path *path,
const char *old_name,
        if (err)
                return err;

+       err =3D security_mount_bind(&old_path, path, recurse);
+       if (err)
+               return err;
+
        if (mnt_ns_loop(old_path.dentry))
                return -EINVAL;

@@ -3328,7 +3336,8 @@ static void mnt_warn_timestamp_expiry(const
struct path *mountpoint,
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS=
_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_fl=
ags)
+static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_fl=
ags,
+                             unsigned long flags)
 {
        struct super_block *sb =3D path->mnt->mnt_sb;
        struct mount *mnt =3D real_mount(path->mnt);
@@ -3343,6 +3352,10 @@ static int do_reconfigure_mnt(const struct path
*path, unsigned int mnt_flags)
        if (!can_change_locked_flags(mnt, mnt_flags))
                return -EPERM;

+       ret =3D security_mount_reconfigure(path, mnt_flags, flags);
+       if (ret)
+               return ret;
+
        /*
         * We're only checking whether the superblock is read-only not
         * changing it, so only take down_read(&sb->s_umount).
@@ -3366,7 +3379,7 @@ static int do_reconfigure_mnt(const struct path
*path, unsigned int mnt_flags)
  * on it - tough luck.
  */
 static int do_remount(const struct path *path, int sb_flags,
-                     int mnt_flags, void *data)
+                     int mnt_flags, void *data, unsigned long flags)
 {
        int err;
        struct super_block *sb =3D path->mnt->mnt_sb;
@@ -3393,6 +3406,9 @@ static int do_remount(const struct path *path,
int sb_flags,
        fc->oldapi =3D true;

        err =3D parse_monolithic_mount_data(fc, data);
+       if (!err)
+               err =3D security_mount_remount(fc, path, mnt_flags, flags,
+                                           data);
        if (!err) {
                down_write(&sb->s_umount);
                err =3D -EPERM;
@@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path
*path, const char *old_name)
        if (err)
                return err;

+       err =3D security_mount_move(&old_path, path);
+       if (err)
+               return err;
+
        return do_move_mount(&old_path, path, 0);
 }

@@ -3786,7 +3806,7 @@ static int do_new_mount_fc(struct fs_context
*fc, const struct path *mountpoint,
  */
 static int do_new_mount(const struct path *path, const char *fstype,
                        int sb_flags, int mnt_flags,
-                       const char *name, void *data)
+                       const char *name, void *data, unsigned long flags)
 {
        struct file_system_type *type;
        struct fs_context *fc;
@@ -3830,6 +3850,9 @@ static int do_new_mount(const struct path *path,
const char *fstype,
                err =3D parse_monolithic_mount_data(fc, data);
        if (!err && !mount_capable(fc))
                err =3D -EPERM;
+
+       if (!err)
+               err =3D security_mount_new(fc, path, mnt_flags, flags, data=
);
        if (!err)
                err =3D do_new_mount_fc(fc, path, mnt_flags);

@@ -4080,7 +4103,6 @@ int path_mount(const char *dev_name, const
struct path *path,
                const char *type_page, unsigned long flags, void *data_page=
)
 {
        unsigned int mnt_flags =3D 0, sb_flags;
-       int ret;

        /* Discard magic */
        if ((flags & MS_MGC_MSK) =3D=3D MS_MGC_VAL)
@@ -4093,9 +4115,6 @@ int path_mount(const char *dev_name, const
struct path *path,
        if (flags & MS_NOUSER)
                return -EINVAL;

-       ret =3D security_sb_mount(dev_name, path, type_page, flags, data_pa=
ge);
-       if (ret)
-               return ret;
        if (!may_mount())
                return -EPERM;
        if (flags & SB_MANDLOCK)
@@ -4141,9 +4160,9 @@ int path_mount(const char *dev_name, const
struct path *path,
                            SB_I_VERSION);

        if ((flags & (MS_REMOUNT | MS_BIND)) =3D=3D (MS_REMOUNT | MS_BIND))
-               return do_reconfigure_mnt(path, mnt_flags);
+               return do_reconfigure_mnt(path, mnt_flags, flags);
        if (flags & MS_REMOUNT)
-               return do_remount(path, sb_flags, mnt_flags, data_page);
+               return do_remount(path, sb_flags, mnt_flags, data_page, fla=
gs);
        if (flags & MS_BIND)
                return do_loopback(path, dev_name, flags & MS_REC);
        if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
@@ -4152,7 +4171,7 @@ int path_mount(const char *dev_name, const
struct path *path,
                return do_move_mount_old(path, dev_name);

        return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
-                           data_page);
+                           data_page, flags);
 }

 int do_mount(const char *dev_name, const char __user *dir_name,
@@ -4545,7 +4564,7 @@ static inline int vfs_move_mount(const struct
path *from_path,
 {
        int ret;

-       ret =3D security_move_mount(from_path, to_path);
+       ret =3D security_mount_move(from_path, to_path);
        if (ret)
                return ret;
