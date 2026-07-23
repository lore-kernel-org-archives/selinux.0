Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAD3932C3
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830789; cv=pass; b=DpsuOQetsh/jM7nAEjcSs2F3B93VHCyOmDbvHhKajO/SW6Q2/BBDtzP/GwiK4PNieBx9Wy7vknm6qeTJeGMipmNfhIblfAgaOJukkSh4T6vfGX18bqGeEwN3UON67tIh3Rv82qmu9Lkzzwlpyqug2ibEHYJJQKMC6tPvD3gFFcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830789; c=relaxed/simple;
	bh=KoOUONZFpkFL8y30H5krhn2Lg30+eoFP8AtBWDYwmHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCqfXy6+q1KZZ6c8tYKtVXFUwPEOUrWkOJqhRF9hYpULJtlh+gL/BF1k2jhQYTcxIMn+tj7yH/gi3dCjuh5rsNgWlQM+Ar+THS6VOY686Srideb3hB81E7wwLBVtkhmWKJT9bcxRqQ4nrtIYPjt3Ufd0mgCHnf3ElmJ/jbL+hL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyhXJn8d; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyhXJn8d"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a652535dcso643915b3a.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 11:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784830774; cv=none;
        d=google.com; s=arc-20260327;
        b=rr2ghS2zZ86zcVCoRAuQIXniUzXx/i3v7FI2SZEmPbLYbP2tsux1QVFJcvUnvdNGqF
         8UnCELBB+SY+WuC4DwOx73EbY6QnNZh0hlEGpv2rgsI1MNtIH4vdntI0rSRzE+xTQ1uQ
         /HTiOOlxwwC1hb09cH1aq+yxtz4js58/2T/cbaAoVQ7H2fdlFrxS0OcERx+taWQ48ggr
         MP2DqA/xWwyoXIS+4Db1NGLqKd4S6v/BEhXKK2QH11xK/oJhOONlf8njwMl2QWGd2Z6O
         r3GdHxSrI9fuNkS9w7taJzMCLTK1NoNevkOY4hawOXxYjJ/tDV3iOA/wmXoqPszKu0kT
         O1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8Ijxh6rUw2j/d3urHAc58/ZVStBPQ5FDllnle4I8YE=;
        fh=o9ysly1bZXA6GIBZO9MyG8xIYSsr5spWd++bRDYi6X4=;
        b=Xqox2kRR5v5c3Fy1y5nKuCThWDUun1AFeikZ6hyub4+XRQjugxBThlBSTTMchc6wgE
         J6HhLvlKM3UsiQ4jqkJ8RAPWedff9TnUatVaELDea/usy3MupGE+hqX1V0VoLvwCfQHm
         HRvOHpwkrnwp55t7UP6Xcz+NOBFzOjhUXMgB/PKeI24hcmYpjt3cXPLXzyP1zwb83Puv
         fmcOZsc0HA0jjKMydsV8Ex+4tOKxWQ9bdpKN/XvDzWsbpGtpXh8FN/TYeTNaC3hgVQ2d
         5sc5SKt5ODprdmMXAK5ScqbjY8LDi/eKk3DApaeaCUcbbUuLR7/4Hqf6VicLiOxESMZ/
         6bdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784830774; x=1785435574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8Ijxh6rUw2j/d3urHAc58/ZVStBPQ5FDllnle4I8YE=;
        b=cyhXJn8dv72Y9q3lpKEjmXo0lBY0sGb4OYRiwyrb2YAoza54h5rxCMXtfA1rj7FRam
         sOp1wwnnFGHqid3LOJKOgkd8CeZxQbZ2ezkE9a8sx7/6Dq+5yTD41t2O2smujEFlnGih
         j7UFUvZRFEfv2yMbPA0mXJhwOLVNw/lFbcXqkHcyhkNwqrjPgVuhyBRK7WE1TtWHOR0b
         wiGgYHZnVMrzftMO6ulwGAk5gzxzxBInW/YOuyO+aylaBnHqI9QI5SHCaznaD15gUUBx
         SjRSGn6/TSo7B18MoThApJK1jU+8TokMM9QPyq18ZkTvfL3vCd7SMeqfdTgY7ui/Sgv5
         RUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784830774; x=1785435574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8Ijxh6rUw2j/d3urHAc58/ZVStBPQ5FDllnle4I8YE=;
        b=SEQEMYHnrZOtEBGGUssS2NLEoSNSBukqabFdIkz2qCyoHVOGKg4tynsFEWwhMoS+Jy
         dJeAFd3kU29mroiH5kVdhZLJFeBcM39dBdJPX5nSlF/VTZ0QrsnZvtRqRPiMmNOZd4RJ
         c8etwf2u0vN4iF8Eo9UsHgwXJEylST2zka/P9RkUqeQVbih+Ft3M5Z6LbBxXdAq/f/Ab
         byhxWdX/5pr9Hm3mCCdfvMkaxNs/6a8imQ3DO+1cO03VRS1ULEwCEQMfTaZam1pvj56G
         9GTMO+ICsyWD0/nDp01eBbVatM5tXNabJdIyk0e4zIFQgPrSYCHlf8qUqc0uqtAEARt+
         mVVw==
X-Gm-Message-State: AOJu0Yyk59sFl0e17UnzxeAgSmbTYGcY7vEAa9/ddqWkf3RrgmF2LYnf
	AH02k5BHLFSAJSEpobfhpPXAjop8oxVm8FawukptZK0RPQaP7wTxMmgp2JXb7zYp/VNEwXYIobK
	qOL6pewjJJvIBNhbjWil2q9vkjjVoNMI=
X-Gm-Gg: AR+sD11wpAaHctVRyLBJ1Jx/0GNAOepaQ49QIZhd/8EUuWr7P506XThrE2MRJnczf17
	0jXMd6KFVuAp5nMbRpB+dQYZPzw8wrDaoDRF01feOSo5IAVx1QqeQF0NHJJOhxcn88kEYWjQNiC
	ckUdUIvVfaoUV+gh+JaHIxEvIha75H47aYF6RI+uuo/QdddgBo1W+8j/AjJehCW4fFbn82fOxO8
	6kebIGp7GGh6I/aSnZZoQV3p/duJUbJfCTY/qDMxraqz9WgVj11eK3oM4/WaA==
X-Received: by 2002:a05:6a00:6ca0:b0:848:4810:2b71 with SMTP id
 d2e1a72fcca58-84e2bbca960mr4772745b3a.51.1784830774135; Thu, 23 Jul 2026
 11:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAjPzFK-806Fu9k2sHz_sBFgordzDo=xpDSXGzJOvitj03-Xg@mail.gmail.com>
In-Reply-To: <CALAjPzFK-806Fu9k2sHz_sBFgordzDo=xpDSXGzJOvitj03-Xg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 14:19:22 -0400
X-Gm-Features: AUfX_myWvTY4KSl94Zgur9Zpz9JaCGEP7i_lvReJBGgV8QBpXoCZPYweXQW2Z_U
Message-ID: <CAEjxPJ4RC-bUj6FhE1QADtXQ2NHt=1+m3OuOVpWyhhFTrwh58w@mail.gmail.com>
Subject: Re: [BUG] restorecon of a single file can trigger systemd automounts
To: =?UTF-8?Q?F=C3=A9lix=2DAntoine_Fortin?= <felix-antoine.fortin@calculquebec.ca>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:15=E2=80=AFPM F=C3=A9lix-Antoine Fortin
<felix-antoine.fortin@calculquebec.ca> wrote:
>
> Hi,
>
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
> Environment:
>
> Distribution: AlmaLinux release 9.8 (Olive Jaguar)
> policycoreutils package: policycoreutils-3.6-5.el9.x86_64
> libselinux package: libselinux-3.6-3.el9.x86_64
> systemd package: systemd-252-67.el9_8.4.alma.1.x86_64
> Kernel: 5.14.0-687.26.1.el9_8.x86_64
>
> Let me know if I can be of further assistance.
> F=C3=A9lix-Antoine Fortin

Thanks for the report. Do you intend to submit a patch to fix this or
are you asking us to do so?
Regardless, you should also file a bug against your distribution to
ensure that it ultimately gets
fixed there.
