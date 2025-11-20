Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B333A006
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647024; cv=none; b=t4gEp4EMDnukxTMA+hkaGd7gXW+/wmWtwBopy1LZtBXFbMMjkX/o5j3vJq61+iws7vPhs7d9iL53MOqy/M9/yul85zzgxD9WuDiwJ3cOQxO8DlDYLZYyPgWi3ez/kCEej3GP30nO2od7K7IkhpsQtuFkFYKgkPeEyk5iba/HmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647024; c=relaxed/simple;
	bh=cIjYAD/SxbrH7vlmZP3zScs84qP6I8VgZ64qaVDv2bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjAworpJ3mfBHQZb63qbiWgmaIL2q5wCo308JGFAEkTo9ZauieLQezmzwm4tOx6q19lTRIEAtYf7StIy+SMxWLZSQloiJKtkZtX73EPhvjIn5vjRxl9V0D8OsJFtf7NufDelCFXB5gXCyy1cItCWZxfT8p1dUmhssrUz1sq9RFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwuFn+4O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwuFn+4O"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297d4a56f97so13388695ad.1
        for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647022; x=1764251822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvxAceKZwSCa9W/LT4zPFW4hzV+S6LE5qeYmuje3Muc=;
        b=PwuFn+4OP9D7H6U2882e7H9Ynk+vAhz8y15/a/6BszlFkrnMwD3ROmcusU2ioRbjCX
         diG974nswqoxhw0kAJfZep5NJX1qTiWgTsYeBbBVSgAVZWyKmjXNL8a8/eP1f4Qh1/Vf
         gRcJOYNHGVZrun9tMEWua6+By+jla+TnMpi/B3rSXnJEQKMoYzGGIW6UqbtPccviq0l+
         zS0QKteHfYDjgbiFV6V/9A0dq3mDm7PmQNk+NSVIt9/7R1/u7RErT0FnVhwRDEMv5jNq
         +RRIk5J8Z80MwGxcVD32fu41czmxpwr29XZMcgAaugQy77Czz3aLKs2ZVp6vbrWamaLc
         ej/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647022; x=1764251822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kvxAceKZwSCa9W/LT4zPFW4hzV+S6LE5qeYmuje3Muc=;
        b=oWQnuCHHOfjuiE8c0sZvcwyg/U5P0XnSQOj61RFEcoBxPmzPi7D/L7VCbzOgur16Kr
         t1fjLFbNsZfqgejDhv7yPYKV5Fjv3wLiiWhPdWoSaLqwy59wAc09+FbRh1jZATndrqMF
         KGNM3SO3rzb/AVds+8u9owOVFJSVapIfb42CiL4RnYtxn5MlPl8iMtPRiZBShhxqFbwa
         jFyDHFcBKi+4dNWnLd55NpCFTY0XOC3wsu7R8U4SOeQbl9fG52a/PPQZXNmcuVU5Sgnf
         UmFO9OFle9BjKv4VKn89lSCGXYheNFi3HEMCAHubo3IEFzMMzu2iptQdnk+tlora7u84
         IR2g==
X-Gm-Message-State: AOJu0YyX6CfRUE5HTTqvDlMz6DG1lHIminjHI20iDlQV8ayd6nxBz13V
	bq/YkFucsPoURa3iv6vbKWr14SJiNWMXJ3383oF5C6h+GbWqZMszboZ2e7xccwXGKK3C4mAohS/
	y452FrPOOnJfLiWAfTsbW5+4L120/x6A=
X-Gm-Gg: ASbGncsz8EOFysioPNdMpTw24/0M6VPsk2UWZtF5/hLkEITHJsMxbykGCQ/UhY1y5Or
	TS75DzS2ERRM6ScyXIviR7Vq8hcktbshvJOFEzbwDNHjB0YEBIJeiQfU0QLJRQTrJkZqtUeYiD3
	URvtMiJevMensLAi9BCL20ekoYr7FGuJDv75I12Q8C2cqUTh1aMO1NVvDcKzdKej7PQeml1XiMr
	A4SGajfTi8bCTvk6TuUxE/IAs0gQ+85JpYY6Ou120xti3bS7cEQnlaL/fNazT241sD4KE8=
X-Google-Smtp-Source: AGHT+IGyfunbEY0CeMn+bHaBNSBqLuo4ZxjoB58vL82KmcpjgU5yowGibXkh6+p1FMQRy5VstuMVOTcFfSCLk52h8n0=
X-Received: by 2002:a17:902:ccc7:b0:298:49db:a9c5 with SMTP id
 d9443c01a7336-29b5b136462mr36663295ad.43.1763647021536; Thu, 20 Nov 2025
 05:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119195628.184825-4-paul@paul-moore.com> <20251119195628.184825-6-paul@paul-moore.com>
In-Reply-To: <20251119195628.184825-6-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Nov 2025 08:56:50 -0500
X-Gm-Features: AWmQ_bldv7WdCqK0OnNwPRyPbrjOFfZ9VkA_oK0SsWaGIJwdiUQbVaoxmLy4y_s
Message-ID: <CAEjxPJ4cy3zarsytxGV65+mNh7ikbt_Le_4M-m8YV0QqvgdRWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: rename the cred_security_struct variables
 to "crsec"
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
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
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Just re-affirming my Acked-by since this patch did change.
I confirmed that building security/selinux/hooks.o before and after
this change produces the same result (after stripping the object
file).
Not sure how the stable maintainers are going to respond to the two
renaming patches though.

> ---
>  security/selinux/hooks.c          | 230 +++++++++++++++---------------
>  security/selinux/include/objsec.h |   4 +-
>  2 files changed, 117 insertions(+), 117 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0ac4b05eb56c..e713291db873 100644
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
> @@ -2251,8 +2251,8 @@ static u32 ptrace_parent_sid(void)
>  }
>
>  static int check_nnp_nosuid(const struct linux_binprm *bprm,
> -                           const struct cred_security_struct *old_tsec,
> -                           const struct cred_security_struct *new_tsec)
> +                           const struct cred_security_struct *old_crsec,
> +                           const struct cred_security_struct *new_crsec)
>  {
>         int nnp =3D (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
>         int nosuid =3D !mnt_may_suid(bprm->file->f_path.mnt);
> @@ -2262,7 +2262,7 @@ static int check_nnp_nosuid(const struct linux_binp=
rm *bprm,
>         if (!nnp && !nosuid)
>                 return 0; /* neither NNP nor nosuid */
>
> -       if (new_tsec->sid =3D=3D old_tsec->sid)
> +       if (new_crsec->sid =3D=3D old_crsec->sid)
>                 return 0; /* No change in credentials */
>
>         /*
> @@ -2277,7 +2277,7 @@ static int check_nnp_nosuid(const struct linux_binp=
rm *bprm,
>                         av |=3D PROCESS2__NNP_TRANSITION;
>                 if (nosuid)
>                         av |=3D PROCESS2__NOSUID_TRANSITION;
> -               rc =3D avc_has_perm(old_tsec->sid, new_tsec->sid,
> +               rc =3D avc_has_perm(old_crsec->sid, new_crsec->sid,
>                                   SECCLASS_PROCESS2, av, NULL);
>                 if (!rc)
>                         return 0;
> @@ -2288,8 +2288,8 @@ static int check_nnp_nosuid(const struct linux_binp=
rm *bprm,
>          * i.e. SIDs that are guaranteed to only be allowed a subset
>          * of the permissions of the current SID.
>          */
> -       rc =3D security_bounded_transition(old_tsec->sid,
> -                                        new_tsec->sid);
> +       rc =3D security_bounded_transition(old_crsec->sid,
> +                                        new_crsec->sid);
>         if (!rc)
>                 return 0;
>
> @@ -2305,8 +2305,8 @@ static int check_nnp_nosuid(const struct linux_binp=
rm *bprm,
>
>  static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
>  {
> -       const struct cred_security_struct *old_tsec;
> -       struct cred_security_struct *new_tsec;
> +       const struct cred_security_struct *old_crsec;
> +       struct cred_security_struct *new_crsec;
>         struct inode_security_struct *isec;
>         struct common_audit_data ad;
>         struct inode *inode =3D file_inode(bprm->file);
> @@ -2315,18 +2315,18 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
>         /* SELinux context only depends on initial program or script and =
not
>          * the script interpreter */
>
> -       old_tsec =3D selinux_cred(current_cred());
> -       new_tsec =3D selinux_cred(bprm->cred);
> +       old_crsec =3D selinux_cred(current_cred());
> +       new_crsec =3D selinux_cred(bprm->cred);
>         isec =3D inode_security(inode);
>
>         /* Default to the current task SID. */
> -       new_tsec->sid =3D old_tsec->sid;
> -       new_tsec->osid =3D old_tsec->sid;
> +       new_crsec->sid =3D old_crsec->sid;
> +       new_crsec->osid =3D old_crsec->sid;
>
>         /* Reset fs, key, and sock SIDs on execve. */
> -       new_tsec->create_sid =3D 0;
> -       new_tsec->keycreate_sid =3D 0;
> -       new_tsec->sockcreate_sid =3D 0;
> +       new_crsec->create_sid =3D 0;
> +       new_crsec->keycreate_sid =3D 0;
> +       new_crsec->sockcreate_sid =3D 0;
>
>         /*
>          * Before policy is loaded, label any task outside kernel space
> @@ -2335,26 +2335,26 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
>          * (if the policy chooses to set SECINITSID_INIT !=3D SECINITSID_=
KERNEL).
>          */
>         if (!selinux_initialized()) {
> -               new_tsec->sid =3D SECINITSID_INIT;
> +               new_crsec->sid =3D SECINITSID_INIT;
>                 /* also clear the exec_sid just in case */
> -               new_tsec->exec_sid =3D 0;
> +               new_crsec->exec_sid =3D 0;
>                 return 0;
>         }
>
> -       if (old_tsec->exec_sid) {
> -               new_tsec->sid =3D old_tsec->exec_sid;
> +       if (old_crsec->exec_sid) {
> +               new_crsec->sid =3D old_crsec->exec_sid;
>                 /* Reset exec SID on execve. */
> -               new_tsec->exec_sid =3D 0;
> +               new_crsec->exec_sid =3D 0;
>
>                 /* Fail on NNP or nosuid if not an allowed transition. */
> -               rc =3D check_nnp_nosuid(bprm, old_tsec, new_tsec);
> +               rc =3D check_nnp_nosuid(bprm, old_crsec, new_crsec);
>                 if (rc)
>                         return rc;
>         } else {
>                 /* Check for a default transition on this program. */
> -               rc =3D security_transition_sid(old_tsec->sid,
> +               rc =3D security_transition_sid(old_crsec->sid,
>                                              isec->sid, SECCLASS_PROCESS,=
 NULL,
> -                                            &new_tsec->sid);
> +                                            &new_crsec->sid);
>                 if (rc)
>                         return rc;
>
> @@ -2362,34 +2362,34 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
>                  * Fallback to old SID on NNP or nosuid if not an allowed
>                  * transition.
>                  */
> -               rc =3D check_nnp_nosuid(bprm, old_tsec, new_tsec);
> +               rc =3D check_nnp_nosuid(bprm, old_crsec, new_crsec);
>                 if (rc)
> -                       new_tsec->sid =3D old_tsec->sid;
> +                       new_crsec->sid =3D old_crsec->sid;
>         }
>
>         ad.type =3D LSM_AUDIT_DATA_FILE;
>         ad.u.file =3D bprm->file;
>
> -       if (new_tsec->sid =3D=3D old_tsec->sid) {
> -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> +       if (new_crsec->sid =3D=3D old_crsec->sid) {
> +               rc =3D avc_has_perm(old_crsec->sid, isec->sid,
>                                   SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, =
&ad);
>                 if (rc)
>                         return rc;
>         } else {
>                 /* Check permissions for the transition. */
> -               rc =3D avc_has_perm(old_tsec->sid, new_tsec->sid,
> +               rc =3D avc_has_perm(old_crsec->sid, new_crsec->sid,
>                                   SECCLASS_PROCESS, PROCESS__TRANSITION, =
&ad);
>                 if (rc)
>                         return rc;
>
> -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> +               rc =3D avc_has_perm(new_crsec->sid, isec->sid,
>                                   SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
>                 if (rc)
>                         return rc;
>
>                 /* Check for shared state */
>                 if (bprm->unsafe & LSM_UNSAFE_SHARE) {
> -                       rc =3D avc_has_perm(old_tsec->sid, new_tsec->sid,
> +                       rc =3D avc_has_perm(old_crsec->sid, new_crsec->si=
d,
>                                           SECCLASS_PROCESS, PROCESS__SHAR=
E,
>                                           NULL);
>                         if (rc)
> @@ -2401,7 +2401,7 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>                 if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
>                         u32 ptsid =3D ptrace_parent_sid();
>                         if (ptsid !=3D 0) {
> -                               rc =3D avc_has_perm(ptsid, new_tsec->sid,
> +                               rc =3D avc_has_perm(ptsid, new_crsec->sid=
,
>                                                   SECCLASS_PROCESS,
>                                                   PROCESS__PTRACE, NULL);
>                                 if (rc)
> @@ -2415,7 +2415,7 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>                 /* Enable secure mode for SIDs transitions unless
>                    the noatsecure permission is granted between
>                    the two SIDs, i.e. ahp returns 0. */
> -               rc =3D avc_has_perm(old_tsec->sid, new_tsec->sid,
> +               rc =3D avc_has_perm(old_crsec->sid, new_crsec->sid,
>                                   SECCLASS_PROCESS, PROCESS__NOATSECURE,
>                                   NULL);
>                 bprm->secureexec |=3D !!rc;
> @@ -2483,12 +2483,12 @@ static inline void flush_unauthorized_files(const=
 struct cred *cred,
>   */
>  static void selinux_bprm_committing_creds(const struct linux_binprm *bpr=
m)
>  {
> -       struct cred_security_struct *new_tsec;
> +       struct cred_security_struct *new_crsec;
>         struct rlimit *rlim, *initrlim;
>         int rc, i;
>
> -       new_tsec =3D selinux_cred(bprm->cred);
> -       if (new_tsec->sid =3D=3D new_tsec->osid)
> +       new_crsec =3D selinux_cred(bprm->cred);
> +       if (new_crsec->sid =3D=3D new_crsec->osid)
>                 return;
>
>         /* Close files for which the new task SID is not authorized. */
> @@ -2507,7 +2507,7 @@ static void selinux_bprm_committing_creds(const str=
uct linux_binprm *bprm)
>          * higher than the default soft limit for cases where the default=
 is
>          * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
>          */
> -       rc =3D avc_has_perm(new_tsec->osid, new_tsec->sid, SECCLASS_PROCE=
SS,
> +       rc =3D avc_has_perm(new_crsec->osid, new_crsec->sid, SECCLASS_PRO=
CESS,
>                           PROCESS__RLIMITINH, NULL);
>         if (rc) {
>                 /* protect against do_prlimit() */
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
> @@ -4165,10 +4165,10 @@ static int selinux_task_alloc(struct task_struct =
*task,
>  static int selinux_cred_prepare(struct cred *new, const struct cred *old=
,
>                                 gfp_t gfp)
>  {
> -       const struct cred_security_struct *old_tsec =3D selinux_cred(old)=
;
> -       struct cred_security_struct *tsec =3D selinux_cred(new);
> +       const struct cred_security_struct *old_crsec =3D selinux_cred(old=
);
> +       struct cred_security_struct *crsec =3D selinux_cred(new);
>
> -       *tsec =3D *old_tsec;
> +       *crsec =3D *old_crsec;
>         return 0;
>  }
>
> @@ -4177,10 +4177,10 @@ static int selinux_cred_prepare(struct cred *new,=
 const struct cred *old,
>   */
>  static void selinux_cred_transfer(struct cred *new, const struct cred *o=
ld)
>  {
> -       const struct cred_security_struct *old_tsec =3D selinux_cred(old)=
;
> -       struct cred_security_struct *tsec =3D selinux_cred(new);
> +       const struct cred_security_struct *old_crsec =3D selinux_cred(old=
);
> +       struct cred_security_struct *crsec =3D selinux_cred(new);
>
> -       *tsec =3D *old_tsec;
> +       *crsec =3D *old_crsec;
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
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 00804562c2c3..8fc3de5234ac 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -217,9 +217,9 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
>   */
>  static inline u32 current_sid(void)
>  {
> -       const struct cred_security_struct *tsec =3D selinux_cred(current_=
cred());
> +       const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>
> -       return tsec->sid;
> +       return crsec->sid;
>  }
>
>  static inline struct superblock_security_struct *
> --
> 2.52.0
>
