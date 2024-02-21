Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEA129A8D
	for <selinux@vger.kernel.org>; Wed, 21 Feb 2024 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558726; cv=none; b=dfIrUJtcKcyslm7GOcOCTId1zo7EahvTmryFRKWpRR9P7SeTGgV/RJNwPi2O8P9vEGqOKSjcK0uUg4pyoDSITvrfL2lulcumErLF1bJdZ3IeWyvsoeOvKuYDzxDAraRboKJZFROgv82qKG59jD3hjXIs/SD51uqDBWVpMaWyQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558726; c=relaxed/simple;
	bh=VbnWhAoLr3EeawQyolNDrQRXZNQkuXxI4yM52Iy8tIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFIEuG8fn9J7u3RSCfhTrbPmIfVNUHrF7YD+TkA9D5TxRirnUFKuojnnjUvhZRuxDKQ9sxNv4OkDvZZ4MlmF5/Az90u4P1pa6vwCKZRWv7Hp7em7Z3PsY65zIPXD39ExbkMx6j8WaeuNOkqD/s89gNZaTQ2fWUCBAEn2Tw61Gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YPmVQ38K; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YPmVQ38K"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso8012596276.3
        for <selinux@vger.kernel.org>; Wed, 21 Feb 2024 15:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708558724; x=1709163524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdOxMAkyl5yi4MjXJFORjz39p90zOjZ6/27YgpZJWJY=;
        b=YPmVQ38KfNBCioWnQH9i31aCO3qWe8g4FexNNDFGDhqNeUuG3XWPmFpEmA9awwJb5A
         XJMx1A4m8+BVZ1p3XAzZC0zKg0x2+yDBARbViUOghFqUGf+dz8CsnJ5TtGF1E2scHF+n
         V6duZxQp4Ar9bMK4gSSNOGSTRmg+5RW72XtCgnbZaFQ2Fdd7MiWjHHmP4E3GtBuFibTP
         IgYgbe2K/n8oF+Bbf6blxarTZldQ732ran3ZxPn05Tb9kRx/ux++hkqS0FRC2yAvwcXG
         pXLxyhQUGJkLQbYP71i9C14lJBPG5F27nJWtaJSiNcmk2DhBaP2K5piPo2wLFuE4tLYA
         p1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558724; x=1709163524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdOxMAkyl5yi4MjXJFORjz39p90zOjZ6/27YgpZJWJY=;
        b=EcQejdKyJzcgC4LzeuJP9hd5UT6OtvRMe8ZaQwAWmWaAm7HNv/T1byb20+eWNmYhpQ
         mfM4x2R9f9foCiovhNbBrTrnPCwsRGESDMAE760T+h/lEu2jePsVCWLfH2EZU9ULgqwm
         IfParldciIOswYpinxkVJgrXlvdr1+2/k9EsegyOSbfxNtO53RBJaecK7ozN0t3+SIzx
         5zHymZpKd/7QTzf6EKMgrutLWH5IQ+Th0SwtMrV+1dhizT+hlciH/gnLGp8yytwema5b
         VAtEDU3H3iDl8RU7Y72WH13CyyjlzhQ+e7217iWw1d+K3WUfOpPFSCOxwe+qQH9TRnYJ
         YGBw==
X-Forwarded-Encrypted: i=1; AJvYcCURbz1DYPJsIdJ0FSGBY8YcaGiZ4sFiKTORbNwE+bRfWLY6Ux7IaOICWXeR1ecXP13v4q/bYG2u8uh87rOuKuELvTGrSrx7/Q==
X-Gm-Message-State: AOJu0Ywn00ly02ClZP+Zlfjdp6N/Yq7RCRPB3krbIBvlvLFJ7zwiIJyC
	PVShUnWwVVKUDf4VVb03xeSZZz95NQFAFtgNLjWZHZP0G7s+iPJjzNPZ4CZPoumzzeTdX+W+KKs
	NyIr8mQmfb+dG0HDdV2+AU5zGUAmtJxmHm6YI
X-Google-Smtp-Source: AGHT+IHA2xpXRb1sDUe9q9FIIpvonGFzRGzz6GZyMO19EZeTrYiVFDtuhUjox8KLin5Elu441vcMmgEKrRzPPcEqg0U=
X-Received: by 2002:a5b:c85:0:b0:dc6:d2d3:a57c with SMTP id
 i5-20020a5b0c85000000b00dc6d2d3a57cmr742866ybq.59.1708558723714; Wed, 21 Feb
 2024 15:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org> <20240221-idmap-fscap-refactor-v2-12-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-12-3039364623bd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2024 18:38:33 -0500
Message-ID: <CAHC9VhTgHP=3Te4=t6chGte15CA_tMoVjFuzBwh+FxQ6Ri4mQQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] selinux: add hooks for fscaps operations
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:25=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Add hooks for set/get/remove fscaps operations which perform the same
> checks as the xattr hooks would have done for XATTR_NAME_CAPS.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  security/selinux/hooks.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a6bf90ace84c..da129a387b34 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3367,6 +3367,29 @@ static int selinux_inode_removexattr(struct mnt_id=
map *idmap,
>         return -EACCES;
>  }
>
> +static int selinux_inode_set_fscaps(struct mnt_idmap *idmap,
> +                                   struct dentry *dentry,
> +                                   const struct vfs_caps *caps, int flag=
s)
> +{
> +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> +}

The selinux_inode_setxattr() code also has a cap_inode_setxattr()
check which is missing here.  Unless you are handling this somewhere
else, I would expect the function above to look similar to
selinux_inode_remove_fscaps(), but obviously tweaked for setting the
fscaps and not removing them.

> +static int selinux_inode_get_fscaps(struct mnt_idmap *idmap,
> +                                   struct dentry *dentry)
> +{
> +       return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
> +}
> +
> +static int selinux_inode_remove_fscaps(struct mnt_idmap *idmap,
> +                                      struct dentry *dentry)
> +{
> +       int rc =3D cap_inode_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> +       if (rc)
> +               return rc;
> +
> +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> +}
> +
>  static int selinux_path_notify(const struct path *path, u64 mask,
>                                                 unsigned int obj_type)
>  {
> @@ -7165,6 +7188,9 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
>         LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
>         LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),
> +       LSM_HOOK_INIT(inode_set_fscaps, selinux_inode_set_fscaps),
> +       LSM_HOOK_INIT(inode_get_fscaps, selinux_inode_get_fscaps),
> +       LSM_HOOK_INIT(inode_remove_fscaps, selinux_inode_remove_fscaps),
>         LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
>         LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
>         LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
>
> --
> 2.43.0

--=20
paul-moore.com
