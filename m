Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C833B6CC
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157537; cv=pass; b=mnrbabM1WhPyCQBKG3Q8kY13dI7UT/V+YzvSS8RchYbmaFCqZygiucYONcvNsUq9KVUSIHtsxErmse772Fb4qawFNECePRRIY2DNO6t1TvvlsDR3fAU+7rKfPNEsVCka9BjJrvQOvJp4CMF6bxAD2cHMF/VSWBOHhD7jqrPdPVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157537; c=relaxed/simple;
	bh=p18X4pNriMzGp1BGX0M9xmC8zufLzHR8XqBBImabqNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QioLBayKv57DarNLHoSrWRnbi4GwTtGKP/E6Vd4xRdhYWtZf1nTe2seXMipxI7JmYKtaar8KTtzYkO5q8okYuj70LPyKKlm7Ydl4UV/fmqhbHp4puh3IsHidpznt0AWx8hebwv1Ij9MlCXO/DSJI3QirJMAAwv1GpwbHAtKzKpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvJX6pYJ; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvJX6pYJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso4188192a91.2
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782157536; cv=none;
        d=google.com; s=arc-20240605;
        b=QOQOueLgtpVGbwk68+FFOubjxveD4wHQ1UJ8CuAsYLJfgE74bp1fbwbGhHE6x2SS8O
         Cw22kchMEFm6+XUZLrkYtnG1qqtYBhGr6MSU90aA4ULH6UliCI5675iF1KwrAw/2PNfM
         qRk/5/AIts2rPxt1jMwQ4LWm848pmQeq+dEj8VL4b1VaWe4MVb3P9HXMjk9jMw2vHFMT
         9gfFPY09zkhq1QT0fJrKLWE9PHgLtCujX5Dws7GPyj0ftCI3eyeQmIzlBXKBc3eaEE8/
         829ic3eYxpP7RHK9JhNuoa/mJFVkpG4tSthnuGY5koJM04Gp9uPb1WoQ+WliNkt1wtgH
         EFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YD/u4RyGopnPNLIxcn87GOipu2yHJI+Wggj89XQYKcE=;
        fh=iTQQ/KiOQzcxNclBU+WsciIiUpc5GKuUhBUZ6aw0T88=;
        b=IpfAXwvAQtPOxx52UcvUD+rdBuYr5OJjCioPXMUx+fvncYCaROdo4jzzYTELyF1jW0
         w83a4F5z1sbKfQuaw8VgOqdjB0r0WLps4x/qvCIVx72kVPpZRoUAqZpx8n9MtO3Ufij7
         zGakLQQyokS8ILBmlKiasVnsb0jUX8OejZ+MvALldGY8NeJL3KE2q3IC+1c72jpowwRm
         Zjv7wcyuM0k423JZ1fgBGT/NMZ3+YK0TTRR9U7DG24T45fKvVJbcluL0/EmzpzoORr1v
         AMkN/KRPF6fb4ktuuE028WTQaphgfjwjQdGsCN2ctao1xlT97aHco0WDlIFzi37xzmdi
         PwvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782157536; x=1782762336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD/u4RyGopnPNLIxcn87GOipu2yHJI+Wggj89XQYKcE=;
        b=bvJX6pYJfWcAq7+79WycI1QHjqzGF+/3uYoygG4X4zulofb22Sa0pQgsKKSU765j22
         5Oe0qD1U8BNG3NkGdmxpfESSJolyc7+3b3zC0cvTMi8MhOJXcmK5qhyZbS5N9Qr0AvOD
         HB1Viw+8LjhqcVLS30qSwxzkYGsyBLo7QyidPgIG2zFOUR7JDVWVmwzf36ql3yuRgWNr
         NfpTet8VxvvTtPsjFSzwshZb1HjR9DD7JBHlrzjmZ+wogyGk0OwXWmBfoC8vbLYdpuGw
         TeQ+GlvBq1W/zOMTMRy3hWDe3ERtulDttCdxB52B+Pa4BcSm6hSXBAdViguNLNUo3L7E
         GK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157536; x=1782762336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YD/u4RyGopnPNLIxcn87GOipu2yHJI+Wggj89XQYKcE=;
        b=DSbu/oE3KPcxC8R/Z82qFicRhE8U+9KYaRy6SKraA1JGCwussmdl8zh92lIaSSINce
         p4BmuLrXnCfhRtQiaaGSjL1NJU5Ty94b9GJbMU2I490lGvgfwlKe6KPgxceIM/o6cbKP
         l2trpbP7VvLG20NKWQSrLyvSw1HDJuc+TttPcPP+wTRomvayyBpJcDVjta4LNzrnsbdD
         aN8ri3Y6ZCFk+W2J58Jlvwo921ANP3wFQKrn+R7McNhDhL4l7kHAwr0yb0N1o7SSt95s
         wZl6B9g+h89LG0Fn6vzgDhcV24ggJJa3YX5/qM3INlpLHXrLWypGl9nw8kF0J8fVnqhm
         HT+w==
X-Forwarded-Encrypted: i=1; AHgh+RpGjCFASzbOiIvSNUm8MF5WxPQdXS0VEU1hTTHczVUUPWrjOb/YcBywSO5sSMGVjESnxZ/Vm0Gy@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNL3yUMqJpwfRvck351I5jk64pPSsilPh1GY4YvYIc2MrJxee
	bsCQmtor8jRgTBiKWPk+6uFvGhmn1U0Tx6Geu4gx4aggE203XYNFHdcSZZHsJrxDDxLHuZQU8Yc
	SzXt05eqQaZS7ZCyU+AZgMTjjH5fC0ho=
X-Gm-Gg: AfdE7cnepBame6RhiTb3qS0ZptJmJY/puSfsonwaQM5hIcofeQQgFl5fqYvpPdBMEgg
	Ozm4DVKvuIU3GzqOJelImroZRRuYK1DPDwOYn7upIkb5Loy4jqKzXcHGx0tiX4aGG2ewswQEZ3O
	AmTASyODlsQpOCr2LbVzylVKBjuMQhw6Ki0Z1EbSk/nCDCgEZgi+psOLl/W2TjpiGUsHBGcXQN6
	Q6vbBdav/gffCbbY2p1m5ybluf7hu09HAiKl0TUnBuqQgj5VTO35kyWu7WA7tiexSQP25NV
X-Received: by 2002:a17:90b:55c6:b0:36a:fcf5:64bd with SMTP id
 98e67ed59e1d1-37d1e82f06dmr14119057a91.2.1782157535836; Mon, 22 Jun 2026
 12:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143722.1167703-1-haoxiang_li2024@163.com>
In-Reply-To: <20260622143722.1167703-1-haoxiang_li2024@163.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:45:24 -0400
X-Gm-Features: AVVi8CdmO3k7hOSP2wRvWZ-4Buclsy_rtKYfQbczrVmB1CDiPGIvo_5GV2ZN6Rc
Message-ID: <CAEjxPJ5B8w4XTRAQ9jr-T7-k9meN5NgzWKTfwe_g_SSEMdsWxQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up selinuxfs resources on init failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:37=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.c=
om> wrote:
>
> init_sel_fs() creates the selinuxfs mount point and registers the
> filesystem before mounting selinuxfs internally. If kern_mount()
> or the subsequent lookup of the null file fails, the function
> returns without undoing the resources that were already registered.
>
> Add the missing error unwinding so the internal mount, filesystem
> registration, and sysfs mount point are released as appropriate.
>
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Any failure here is effectively fatal to SELinux regardless, but:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/selinuxfs.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 5aaaf69410bb..c7d91476971c 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1984,17 +1984,15 @@ int __init init_sel_fs(void)
>                 return err;
>
>         err =3D register_filesystem(&sel_fs_type);
> -       if (err) {
> -               sysfs_remove_mount_point(fs_kobj, "selinux");
> -               return err;
> -       }
> +       if (err)
> +               goto err_remove_mount_point;
>
>         selinux_null.mnt =3D kern_mount(&sel_fs_type);
>         if (IS_ERR(selinux_null.mnt)) {
>                 pr_err("selinuxfs:  could not mount!\n");
>                 err =3D PTR_ERR(selinux_null.mnt);
>                 selinux_null.mnt =3D NULL;
> -               return err;
> +               goto err_unregister_fs;
>         }
>
>         selinux_null.dentry =3D try_lookup_noperm(&null_name,
> @@ -2003,7 +2001,7 @@ int __init init_sel_fs(void)
>                 pr_err("selinuxfs:  could not lookup null!\n");
>                 err =3D PTR_ERR(selinux_null.dentry);
>                 selinux_null.dentry =3D NULL;
> -               return err;
> +               goto err_unmount;
>         }
>
>         /*
> @@ -2012,5 +2010,14 @@ int __init init_sel_fs(void)
>          */
>         (void) selinux_kernel_status_page();
>
> +       return 0;
> +
> +err_unmount:
> +       kern_unmount(selinux_null.mnt);
> +       selinux_null.mnt =3D NULL;
> +err_unregister_fs:
> +       unregister_filesystem(&sel_fs_type);
> +err_remove_mount_point:
> +       sysfs_remove_mount_point(fs_kobj, "selinux");
>         return err;
>  }
> --
> 2.25.1
>
