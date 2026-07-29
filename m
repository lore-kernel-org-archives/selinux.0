Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11867436BD3
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332293; cv=pass; b=sBDGwMckJF6IFRQQ0a0qRkpW1sfDuVEgbBjve8x0Y0YN85La+Yug7uHfu5tN0AkH9SUR4tWVKU34/BiVSoXbPoYOdbwVLEKPmYJiuRxO3mKIGqKcwqf3j7FLRc9CSOMa2MewVE0isL5mZ+Afx3tPN94aQCGn9YKROzHunmxo8cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332293; c=relaxed/simple;
	bh=ZN0RuExn+5MdI6x5ZVlHY1UgX9fyaN8qUFfvjxIXYZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHwqQhrRqcl8z2BLkHLCRUqdzYKWKpkwZFdNntlxTlrvWnn2+4iEZU37KhTdDoDZZCzi1UikZe6WHb9b+kEnwoATbEitW8CQBIIIhQkdx6ESxgseGEfEJ+l+cB77KkL9FmuSDG+KqTey+X+Ij1/Y/gZZzZLgC542C9Ehse+vWUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=calculquebec.ca; spf=pass smtp.mailfrom=calculquebec.ca; dkim=pass (2048-bit key) header.d=calculquebec.ca header.i=@calculquebec.ca header.b=UiWBtSMQ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=calculquebec.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calculquebec.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calculquebec.ca header.i=@calculquebec.ca header.b="UiWBtSMQ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69fc856b00eso955217a12.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332283; cv=none;
        d=google.com; s=arc-20260327;
        b=Z81VfH4DQcfNVj8BkbSqFXIfu9JBw33j4Dg00QIL8WxGL44J952zbkSwDTZxCg6sLI
         xweycZ33auq4gemjFgFBXvzFxIsNXVlZJ2JECqMH/ZUdUN7j/C1ohqCQG4xaTjpMkd9u
         QSTgBpLZbo3uX6IxEdDqaM/RvG6aiT7aYmmVm+KLcb0FELtFbOgKn0UQlZpq2Y78BGSM
         S/O2IsEm7Fsld+HihR39as6MRKPfYfZUDjM21vziC63ourNIsqoajxDjY2dDwI/JAkdS
         +IMgMY9VUy0yVjzsSXBRCUtHGe1bqi/YLRrYmTSm2zTsjU2tcFa8r2ZCuSm6P3Onsil2
         4WLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFptwlCDnmlQWoJ4jDCop1mZctgFsTL2aI4ep+2EeRk=;
        fh=uGPySKRiCoSeoUCxhYGgRDlne5x97RDGzp0sp4C/4tg=;
        b=DCdMY9LGX5ZucViz52xTgRm7u1wayq2u2uBqK7zhQm4csHZrwtGNrZPcb295hj45RP
         4wTMVTVXTQYUpdnTqVvMYPNYX6MiNUYf6IQLcfeWCwqrTA0mqLR2VfzeHNmsZT/JPtBx
         j3jqSIJco7qjwdoSRGZkJJ+evMtljn5wLXzzz4LZM5otqLi+U5hDeCJOewuxTIM3NjZq
         sLtWIjiPBJKLvBevgoLidbaCyYeiF3V1e6FE7N0VeBl6BSduidFNk1Fh9FcTASvecQTM
         iwAVSelFLQk8UljPy2YB0/TWjWyKpRhrL+v3xf9zzejIGYQKNupFlhsScd5CfsFDNoQD
         6/hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calculquebec.ca; s=google; t=1785332283; x=1785937083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wFptwlCDnmlQWoJ4jDCop1mZctgFsTL2aI4ep+2EeRk=;
        b=UiWBtSMQmD2f+c9+Tug398tpFBRfxBnjiDAQ3emT9Vs30b5uak6K8Yj8TEoNtYR7tw
         FCQp8kTswf0n6iOui/q5Zr5hShIkiIbB09IhkWlvFK5y6I39H++Vt53iL2Ya0Ci6isgL
         GgNREa22LHSvNMqYwbWYUtR4O6gef6sp7bIWsJJPpKdQWx4p/t+aliK3laQZpjJwMy12
         4R+cPE0ofN+vJvb2K1yRZoltErNInilBoOz627EISzAeoRU8m8BZdP4Ltv/t7wVNzeMT
         /wDhX+0pYxRbNXp8rnZv8uYfxl+wUlqIVACtjBBYWf0QAK3z/SmKIlhrJVmlyuVaG4Aq
         ICUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332283; x=1785937083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFptwlCDnmlQWoJ4jDCop1mZctgFsTL2aI4ep+2EeRk=;
        b=ICQbHJy7ovwqJiqkuQs2sSuGMYgnCmEwFZXUFmf/bh9n/juTlJeAt7cSpI/cJvVTeh
         8/N6XNa39JH1SIvVJ+f2waqBBkEruXirokj/mkz+oKOnUQ0tbio8lIlJ8v5xEBgZZu9Y
         HIjE5rnMOOTCnK+FbPZsqmgfd4LmRqy4g4lAzjQ670IzskLwAUlA1lOtBGyva3VsRw5j
         xRO+6OvClCaOcPxLUAt92bse+F9u781t2mKMiC67yUqiYo1t70/uiGsjIO/9Tprvxery
         2CI+3UUyyz6hvujqW4dxGHtdgZqnZfn5qoHIBAuE1DFIeuitI3jwPNSGceO976vAVak8
         EhIQ==
X-Gm-Message-State: AOJu0Yx7nz9tmHLN7eNvUzq+JAJAPR/bsV/3O1bIENalJQjqmyT0BYq+
	j///JplT4Kaq/oFsSUi37uRE3NjIr2xCJx58L+50JEdWdXAWJxJSdfrjV7is2tKSP2xy+IlggbH
	QykgIhE2VsSAx1wScKueEmmdoIlVpgivzDnZ9xbfb
X-Gm-Gg: AR+sD133vOA03hrKeMwk4deqINHkOUTUCuogq5AuARwA1cad7N5DCgOTwF0rvYmOO1Z
	6cud2BAT1TKLMN1UhdfAw09Mlc1diDjNvMf5Duvl9bhw0476T7ISyx/cz3HYisPRhZYcuhu1AIE
	BCfsnkSMZPNe3D5qWK4Zt5CLG0IUOYG2hJtG0pq2FIJQMM31Xkdk5z6j+EAhufZTew8LvL3IGsx
	b1g0ALbjVZvvYIXn1NaaPr8J2drtHL/8fLAwQYr55ynUkPtkZzfNki11a80B0mgQhLUf/ZM3PYN
	MzpJmtIcSN6KEJTgkSdM9cHq68OMP1ijMA+xKXkki5w9
X-Received: by 2002:a05:6402:21c7:b0:699:f995:14e with SMTP id
 4fb4d7f45d1cf-6a034a3947amr3335067a12.21.1785332282989; Wed, 29 Jul 2026
 06:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131203.53945-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260729131203.53945-1-stephen.smalley.work@gmail.com>
From: =?UTF-8?Q?F=C3=A9lix=2DAntoine_Fortin?= <felix-antoine.fortin@calculquebec.ca>
Date: Wed, 29 Jul 2026 09:37:52 -0400
X-Gm-Features: AUfX_mxFzStLOQiMXwa24o22RrFBcHk0d9Ot2nulbsxE3rchY4n9hc5rqeNB47k
Message-ID: <CALAjPzH8EVi_f27kpONesg=KP7VqmShxJByXmg5-7j_+8zH-LA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selinux_restorecon: avoid triggering
 auto-mounts unnecessarily
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for failing to provide an update earlier.

While implementing patch, I found out my initial analysis was wrong.
autofs entries do not have the seclabel attribute. This was not the
right cause for the automount.

What I found out was, there was a second mount on XFS with the same
path, and the seclabel attribute.
restorecon was therefore triggering automount while reading info on
another mount with the same path.

In summary: restorecon called statvfs() on the pathname of a hidden
seclabel bind mount listed in /proc/mounts.
Because that pathname is covered by a systemd autofs mount, the
pathname-based statvfs() resolves to
the topmost autofs mount and unexpectedly activates the corresponding
NFS filesystem.

If we would like to avoid restorecon triggering automount, the patch
solution I initially proposed has no effect.

On Wed, Jul 29, 2026 at 9:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> F=C3=A9lix-Antoine Fortin <felix-antoine.fortin@calculquebec.ca> reported
> the following bug report, quoted verbatim:
> ---<snip>---
> I encountered an unexpected side effect in restorecon: processing a
> single local file triggers unrelated automounts.
>
> Command (called during ipa-client-install):
>
>   $ restorecon /etc/krb5.conf.d/freeipa
>
> Although the target is under /etc, this causes all of the following
> NFS automounts to activate:
>
>   nfs-home.automount
>   nfs-project.automount
>   nfs-scratch.automount
>
> The journal identifies restorecon as the process that triggered each auto=
mount:
>
>   systemd[1]: nfs-home.automount: Got automount request for /nfs/home,
> triggered by 10521 (restorecon)
>   systemd[1]: Mounting /nfs/home...
>   nfsrahead[10530]: setting /nfs/home readahead to 128
>   systemd[1]: Mounted /nfs/home.
>   systemd[1]: nfs-project.automount: Got automount request for
> /nfs/project, triggered by 10521 (restorecon)
>   systemd[1]: Mounting /nfs/project...
>   nfsrahead[10533]: setting /nfs/project readahead to 128
>   systemd[1]: Mounted /nfs/project.
>   systemd[1]: nfs-scratch.automount: Got automount request for
> /nfs/scratch, triggered by 10521 (restorecon)
>   systemd[1]: Mounting /nfs/scratch...
>   nfsrahead[10536]: setting /nfs/scratch readahead to 128
>   systemd[1]: Mounted /nfs/scratch.
>
> The fstab entries are:
>
>   nfs_server:/home /nfs/home nfs4
> proto=3Dtcp,nosuid,nolock,noatime,actimeo=3D3,nfsvers=3D4.2,seclabel,_net=
dev,x-systemd.automount,x-systemd.mount-timeout=3D30
> 0 0
>   nfs_server:/project /nfs/project nfs4
> proto=3Dtcp,nosuid,nolock,noatime,actimeo=3D3,nfsvers=3D4.2,seclabel,_net=
dev,x-systemd.automount,x-systemd.mount-timeout=3D30
> 0 0
>   nfs_server:/scratch /nfs/scratch nfs4
> proto=3Dtcp,nosuid,nolock,noatime,actimeo=3D3,nfsvers=3D4.2,seclabel,_net=
dev,x-systemd.automount,x-systemd.mount-timeout=3D30
> 0 0
>
> An strace shows restorecon probing these mountpoints:
>
>   $ strace -f restorecon /etc/krb5.conf/freeipa 2>&1 | grep /nfs
>
>   statfs("/nfs/home", {f_type=3DNFS_SUPER_MAGIC, f_bsize=3D1048576,
> f_blocks=3D10172, f_bfree=3D10069, f_bavail=3D10069, f_files=3D5240832,
> f_ffree=3D5240755, f_fsid=3D{val=3D[0, 0]}, f_namelen=3D255, f_frsize=3D1=
048576,
> f_flags=3DST_VALID|ST_NOSUID|ST_NOATIME}) =3D 0
>   statfs("/nfs/project", {f_type=3DNFS_SUPER_MAGIC, f_bsize=3D1048576,
> f_blocks=3D10172, f_bfree=3D10069, f_bavail=3D10069, f_files=3D5240832,
> f_ffree=3D5240816, f_fsid=3D{val=3D[0, 0]}, f_namelen=3D255, f_frsize=3D1=
048576,
> f_flags=3DST_VALID|ST_NOSUID|ST_NOATIME}) =3D 0
>   statfs("/nfs/scratch", {f_type=3DNFS_SUPER_MAGIC, f_bsize=3D1048576,
> f_blocks=3D10172, f_bfree=3D10069, f_bavail=3D10069, f_files=3D5240832,
> f_ffree=3D5240818, f_fsid=3D{val=3D[0, 0]}, f_namelen=3D255, f_frsize=3D1=
048576,
> f_flags=3DST_VALID|ST_NOSUID|ST_NOATIME}) =3D 0
>
> My understanding is:
>
> 1. When restorecon is called without ignore mount (-m) flag, it reads
> the mount table to construct the exclusion list for filesystems
> without SELinux labeling support.
> https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinu=
x_restorecon.c#L146C14-L146C28
> 2. exclude_non_seclabel_mounts() calls file_system_count() for mounts tha=
t
> advertise the seclabel option. file_system_count() calls statvfs() on
> the mountpoint.
> https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinu=
x_restorecon.c#L343
> https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinu=
x_restorecon.c#L282
> 3. Calling statvfs() on a autofs mountpoint activates the underlying moun=
t.
> 4. The resulting file count appears to be used only for progress reportin=
g, but
> it is calculated even when neither progress nor mass-relabel reporting
> was requested.
>
> So a non-recursive restorecon operation on one local file can mount
> unrelated remote filesystems.
>
> I would expect restorecon to not activate unrelated systemd automount
> filesystems when progress reporting is not requested and the target
> does not traverse those filesystems.
>
> I think the best minimal patch would to skip calling file_system_count on
> mounts which type is autofs (mount_info[2]).
>
> ---<snip>---
>
> Fix this issue as the original reporter suggested.
>
> Reported-by: F=C3=A9lix-Antoine Fortin <felix-antoine.fortin@calculquebec=
.ca>
> Suggested-by: F=C3=A9lix-Antoine Fortin <felix-antoine.fortin@calculquebe=
c.ca>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  libselinux/src/selinux_restorecon.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 30f1b836..8bae1464 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -301,6 +301,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
>         uint64_t nfile =3D 0;
>         char *mount_info[4];
>         char *buf =3D NULL, *item, *saveptr;
> +       bool autofs =3D false;
>
>         /* Check to see if the kernel supports seclabel */
>         if (uname(&uts) =3D=3D 0 && strverscmp(uts.release, "2.6.30") < 0=
)
> @@ -335,12 +336,19 @@ static uint64_t exclude_non_seclabel_mounts(void)
>                 /* Remove pre-existing entry */
>                 remove_exclude(mount_info[1]);
>
> +               autofs =3D !strcmp(mount_info[2], "autofs");
>                 saveptr =3D NULL;
>                 item =3D strtok_r(mount_info[3], ",", &saveptr);
>                 while (item !=3D NULL) {
>                         if (strcmp(item, "seclabel") =3D=3D 0) {
>                                 found =3D 1;
> -                               nfile +=3D file_system_count(mount_info[1=
]);
> +                               /*
> +                                * Avoid triggering an auto-mount just to
> +                                * count files for progress tracking.
> +                                */
> +                               if (!autofs)
> +                                       nfile +=3D file_system_count(
> +                                               mount_info[1]);
>                                 break;
>                         }
>                         item =3D strtok_r(NULL, ",", &saveptr);
> --
> 2.55.0
>
