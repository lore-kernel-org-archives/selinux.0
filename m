Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F82EBBA4
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750434; cv=none; b=TCim/xb9KBGTX5QFZaYj2NsBN+Q0JOnkWknb1sSrYCvsWZ8k55M7MsdDxWyQrSCOi0S2qtKOlr2zx9hSv5lUG5peDjqL9CqsO7keJxKcfrhDWaQYmA+UL2pqv+11/B0SRjdxHLDnzMCmnqWG04xPfiiv4gAzZwac/bJz1V5KvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750434; c=relaxed/simple;
	bh=f8Fhr45tAG7sziLg9U37nK1+JBvIXcz4AelF+jGe5oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU+CpyuL/7NhiHRcLFAgQBWZf5wFAINwgqxEPnEJP+kIeIZpSk+9Zow0rGAsLgoOD4XjwD1OF3r9uf1qpwXQuvrKILt/Suy+yZ0lggBBlzaLq1Is26cUuCqUF38B3Twl31u9vPU4BPLT+xelV7idD10mIc1f6flwDoJ4Q0yoSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPXLDd17; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPXLDd17"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so12639a91.2
        for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750431; x=1762355231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IfYIDKxJGGNldyfSmZN9xBlg4Ge86/H8w7OAL6l3zA=;
        b=jPXLDd173Mmm/1ZA8/62Litwf1jppoXunEBdw455/oB0ucPgz/zgb5S9Ig21/R9A83
         zDl/M5gysr9P+fkQwOLRn8Nc93ZomVRC0bmPuHLPjeGepoBI06SWq1YE484MytHwSLlb
         4dwkHgWXlShtqjfBEVZS0uTM5g1kp4llTyzLktE6VRZ+86UnW8Fk08ywhJzo+o670TEd
         fBtgMsa0FYuUeroCTBX6EiOYZ8iHQnELdjSyCiUzabXF6mX8GH0xfMj1C18t6ZPdfKAf
         Y7WcPyRl4QKv5WXCIattR6fCUu2UoNrxf2YFU7G6nQc1uSb0v9TebfZWQzUa9NtSTICl
         hxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750431; x=1762355231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IfYIDKxJGGNldyfSmZN9xBlg4Ge86/H8w7OAL6l3zA=;
        b=V6R7Ft2CgXpt2yCFlaMO9HsUGE7odzLEoHrs/jAHkyZo3j9dT0dyqyJiBADUVKF/Kk
         BRuFUPg4bgUDjp1ICfxAyoKIJeWf7PyKQqw3ZWaQegATH2/VubbrZSxGVUVouERVmAoo
         N8bBJ6eyXFzNlNLwlLrJInbzeg0oElSW8bIQUOLVTrehHDwE75GPPcA2HB9FuuK3/Psa
         jkGzVOcfys2QPGwo28FGFxAjVGRos9fRunf3tFAKCD4nA/JVPITE9Nf86AUEbaQOECKF
         lwR1KTj9zDuJmu79X9nOMKhB73ruex/htWbxNXANa81h0NGfc/71w8eQv4h5UqtrhF15
         hm4w==
X-Forwarded-Encrypted: i=1; AJvYcCU5oU0UKjvYq4HwUj0cko4pyMhHpYUggZyikBKFfdkSa9ajYIUPlQIe+F+Rr16iVnXpNfkIIMz4@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgIJt4K9ZCmK0vLNiruA6zsKapQZib6ylDAkxsH9Hn61/iPiF
	PqHvLVjugVM5mbGnk27tdoAXyeu+WF94xf/F0rxFCsEI8QBbvjpsfRo9/2bBgPZ9xeopZnJ3DoJ
	fdIEbR9wje5dHSXYPNIE8CfWpgxaaimo=
X-Gm-Gg: ASbGncujdnk6TUstXP50D84ugyLnRMvFJxPOfsl7c5SAs3/DAt893PaQwvMNI71GuTM
	0OtRnyKS1XF0YHIeekGllAUIF2O2lNeyR1F7NjgtjQ4eGiC40v6UDXnbwtW3iiQgpgG5cP20pe4
	XprY3M33Y7ampxj0GHTnbbthd9TT6K5y0wS72B5YaWLMueP6omyCmqAPXjuT2W1NyXfYNltQa1+
	QR43+/y/EnElYeWx9kQpUaaNvHyOWqlD7YRbg9J+hdwIMPUBfYS2FX9PeCep3M9jwLs/Kg=
X-Google-Smtp-Source: AGHT+IFVqO8ewpIAf0wvRQFGIOOwuq6fD8Gg5dHkMSFcg7AR9XFXs/odOiaOENp+NesUqtIMC2BHNrgVUxHGzL0/CTY=
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-3403a28efb0mr3676582a91.27.1761750430698; Wed, 29 Oct 2025
 08:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-36-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-36-viro@zeniv.linux.org.uk>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Oct 2025 11:06:58 -0400
X-Gm-Features: AWmQ_blCWCRSlgnSUoNEZRYW0rUX4EVkF7hJCMWu9E3EunP63rWoSyVWbO7_enY
Message-ID: <CAEjxPJ53wJEK4bzt0VMbY=G9gkzuZZA_XtrT+acwPys3p0byBA@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Tree has invariant part + two subtrees that get replaced upon each
> policy load.  Invariant parts stay for the lifetime of filesystem,
> these two subdirs - from policy load to policy load (serialized
> on lock_rename(root, ...)).
>
> All object creations are via d_alloc_name()+d_add() inside selinuxfs,
> all removals are via simple_recursive_removal().
>
> Turn those d_add() into d_make_persistent()+dput() and that's mostly it.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I took this series for a spin and didn't see any problems with the
selinux-testsuite.
Also re-based my WIP selinux namespaces patch series [1] on top, which
introduces multiple selinuxfs instances (one per selinux namespace),
and didn't see any problems.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

[1] https://lore.kernel.org/selinux/20250814132637.1659-1-stephen.smalley.w=
ork@gmail.com/

> ---
>  security/selinux/selinuxfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f088776dbbd3..eae565358db4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1205,7 +1205,8 @@ static struct dentry *sel_attach(struct dentry *par=
ent, const char *name,
>                 iput(inode);
>                 return ERR_PTR(-ENOMEM);
>         }
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
> +       dput(dentry);
>         return dentry;
>  }
>
> @@ -1934,10 +1935,11 @@ static struct dentry *sel_make_swapover_dir(struc=
t super_block *sb,
>         /* directory inodes start off with i_nlink =3D=3D 2 (for "." entr=
y) */
>         inc_nlink(inode);
>         inode_lock(sb->s_root->d_inode);
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
>         inc_nlink(sb->s_root->d_inode);
>         inode_unlock(sb->s_root->d_inode);
> -       return dentry;
> +       dput(dentry);
> +       return dentry;  // borrowed
>  }
>
>  #define NULL_FILE_NAME "null"
> @@ -2080,7 +2082,7 @@ static int sel_init_fs_context(struct fs_context *f=
c)
>  static void sel_kill_sb(struct super_block *sb)
>  {
>         selinux_fs_info_free(sb);
> -       kill_litter_super(sb);
> +       kill_anon_super(sb);
>  }
>
>  static struct file_system_type sel_fs_type =3D {
> --
> 2.47.3
>
>
