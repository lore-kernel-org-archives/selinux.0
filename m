Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26F304BA3
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829931; cv=pass; b=LU2Vryo4BoRGai9yHvsKGzJBNZye3lsCf7DTyToTGEEUKq1W3HSQbfi+OTqeJ8DVHIe1l9oRTSXPifyLrBq0xHcIsZmnE2cpG6x5T+CxtUex2p3TmSLFaYAdxvMzodVE1i5i5zCmWS0Guayfn4y2DIt6IgH0TX4yq78epWOEp68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829931; c=relaxed/simple;
	bh=s9zN6BXitTxvE2E3vBfnI8sFQrbDSur54mh2h/Ns/k8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Z225AlvgvcWGjcDatWPP2qqd6m5/c9h8LcMOZkrRiLsb+1P8wNXX9QLH6FFc2JhPXpDKgE3V4YW7qr1sPHRNbYv+sILRaAnFOxiSAy0a3GnTs4Yl8iLUwDLhzSy/GY97BPez2R8Zbb/n2rMbkQZNMgd7ydTlKtiAQFZ86eSOVMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=calculquebec.ca; spf=pass smtp.mailfrom=calculquebec.ca; dkim=pass (2048-bit key) header.d=calculquebec.ca header.i=@calculquebec.ca header.b=GGhO4STC; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=calculquebec.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calculquebec.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calculquebec.ca header.i=@calculquebec.ca header.b="GGhO4STC"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1677c91969so107645366b.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 11:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784829928; cv=none;
        d=google.com; s=arc-20260327;
        b=lIZ4eQt68/H/98NH+BwmShYcxqrR5mughkHO8IPV/slkfSfv8NDmx5IjE3JcxIyO0L
         /GtcYBsIC4HAvECuUumOitlTtEN7vSSsbF5DeCl/I003Hfr3hUjh780HMFjeuotaHI79
         qIEOLg7kxaDMvnbA+u7wsVNKzHOPBrpGHMfav6IQ2WaMm0T+viMdRX18ZOEoo6wO/OrK
         bUUfxyNbhp2lmHmJRa/tWPKqkR5R1/LsrqZshKXFZpufoMr1n2vH/Z3SEoI/4EuX3nCy
         GGzMFPrYY4Mn8Jkq3HC1VJWGCXRJhOR1lO047QU1oZZQvAqC8KfwuFpSovO1eUBnebcw
         jdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=+xpc0YlHP4TJfJKkAQU2KQAM9ByQNXhDSEEVAsMIKSQ=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=H8g/dwxIWywVPN/DesqszConsVVvm9KhKPhSG9U46wXx/JNFtGkCYS0RmNsi0KJknT
         S4uZx2+0SQmCLoTSRoFhcEDq2Cr7aAacU9wiQlC5RC4SmOTGGRWPKbjTUcCxRRmrY042
         1K6sHbeHp98op/AbQmpepVqch83PiJIWNRTlAdX7Fft5nSbT2tQj9tAmYf+iZ4/F+Ikr
         zGico5sHdKmfo3e3OJQvgC1P2KvFUBLPF15b1Gx7ft8l/shAHb1BoRi6G/tkDTMuEwUk
         1sniksdTmLEtK5Kli2I9zIN5IKozIEsekSBKhidEJElvt8D8AyA9ZavOOiJ2J6Ptamqn
         AuGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calculquebec.ca; s=google; t=1784829928; x=1785434728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xpc0YlHP4TJfJKkAQU2KQAM9ByQNXhDSEEVAsMIKSQ=;
        b=GGhO4STCM/AmEK/EHrnJCDsvmcAUv8Mas0bcfFsJh7De/Z06WBVbWDbwKrEWGqH4jj
         oAiGLhmqRA2kuO4YiwO5lQtfcvY2c7TRt2UqD9jrA1NPZKjf27eqp/OSUjNXPNNiPEBS
         o/zA5ir19TdrzHw4wmDzx5oHkhOiXmIkJRymh1aFfnFeWj0zQsCN5zzCMhnF6L0pgkIe
         rAhqghOR//rjp/MaWEDW77G5f38/mU9dE+v+WH1cUE5Upy34IMxFH7QpsSf6OG3zmGyb
         dn+Oqg2TzSRw4QLunTGs3A0ifCLhOxKKGGdfOFrDdCQtvddQ/3GI+WnDplevYNv2F9CB
         T1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829928; x=1785434728;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+xpc0YlHP4TJfJKkAQU2KQAM9ByQNXhDSEEVAsMIKSQ=;
        b=NrfTBTcajS/MzBbrd936T+An7yjhaPaE0QdQWt7zU68vRybeb03k0IqQYNBQGvOj9Z
         yKav7AE4Kkz4NOJaamAKTgh/IMEg+sw7U85Qh2859D7dkzFYo6ZC9K1BqTzA25YgZLt0
         ow993DfaXuXNx8MNSJnKsaQ0lN1sFsdJ8+a3U4XACwP342G613lBVnDr+A0fo2ehS4k7
         gAhCZ15laCY6jM7pSXh1szxvOolmO+i/AK3BX/iFJ0gohhyTYtTfsGNUTuyr5gkcaRMW
         sGpbPt9B5Y8/3AZcwdCJNaM1LGf4xGthodRVJMx7WJu1dS8u6AaYLwTkybg7uzQFsA2d
         YNnw==
X-Gm-Message-State: AOJu0YwLTJPuL4cGMSH5NTUza7ymEjNJsUY0CCbe60oLOlnSrUmDYZCt
	/cFO+GJHIJgrY5PhzaWT1UdzngDallZk7pWSGFat5TdmgW3XWBYJkoxyJed1TZ/4OMWEDJNa/2a
	C5oOhjSKtoVtWBDlJBu8PO9L2bqKK5T6pxnhqbOdPusxu+4Qin+24XjA2
X-Gm-Gg: AR+sD13GME02YwSMJ/nyJcE6g1eAqL23h3S3V4+2Xi74FbVDHmtjsMy2In4pSOGONmv
	FfSxHmqDoBw5P9E4rMX38rhyepsKFyCPSn8ztFvlV4hhIjGefpd34GMt/raD2OKX8GgnYy3BM8j
	lxTwbrIzh6J3vVRSeHvLvN2ApamfOlCioPtW3FM1nJm+mobnTknMyjAKsbsIvK6zkYsqGM+qm/f
	3k5vKsRcXFOSNn3h7V9i6N/7T4R4LNRciZeL+1aX/Hr7TGJnC8CjkuyGtzTkA==
X-Received: by 2002:a17:907:72c9:b0:c16:111c:7df9 with SMTP id
 a640c23a62f3a-c1c50c5b65dmr188592266b.59.1784829927684; Thu, 23 Jul 2026
 11:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?F=C3=A9lix=2DAntoine_Fortin?= <felix-antoine.fortin@calculquebec.ca>
Date: Thu, 23 Jul 2026 14:05:16 -0400
X-Gm-Features: AUfX_mwCynLtxx_1ot92kjC2Z3_d0NDrSIVznOUdcjl53SfIsDMD78VzFz0HIyA
Message-ID: <CALAjPzFK-806Fu9k2sHz_sBFgordzDo=xpDSXGzJOvitj03-Xg@mail.gmail.com>
Subject: [BUG] restorecon of a single file can trigger systemd automounts
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I encountered an unexpected side effect in restorecon: processing a
single local file triggers unrelated automounts.

Command (called during ipa-client-install):

  $ restorecon /etc/krb5.conf.d/freeipa

Although the target is under /etc, this causes all of the following
NFS automounts to activate:

  nfs-home.automount
  nfs-project.automount
  nfs-scratch.automount

The journal identifies restorecon as the process that triggered each automo=
unt:

  systemd[1]: nfs-home.automount: Got automount request for /nfs/home,
triggered by 10521 (restorecon)
  systemd[1]: Mounting /nfs/home...
  nfsrahead[10530]: setting /nfs/home readahead to 128
  systemd[1]: Mounted /nfs/home.
  systemd[1]: nfs-project.automount: Got automount request for
/nfs/project, triggered by 10521 (restorecon)
  systemd[1]: Mounting /nfs/project...
  nfsrahead[10533]: setting /nfs/project readahead to 128
  systemd[1]: Mounted /nfs/project.
  systemd[1]: nfs-scratch.automount: Got automount request for
/nfs/scratch, triggered by 10521 (restorecon)
  systemd[1]: Mounting /nfs/scratch...
  nfsrahead[10536]: setting /nfs/scratch readahead to 128
  systemd[1]: Mounted /nfs/scratch.

The fstab entries are:

  nfs_server:/home /nfs/home nfs4
proto=3Dtcp,nosuid,nolock,noatime,actimeo=3D3,nfsvers=3D4.2,seclabel,_netde=
v,x-systemd.automount,x-systemd.mount-timeout=3D30
0 0
  nfs_server:/project /nfs/project nfs4
proto=3Dtcp,nosuid,nolock,noatime,actimeo=3D3,nfsvers=3D4.2,seclabel,_netde=
v,x-systemd.automount,x-systemd.mount-timeout=3D30
0 0
  nfs_server:/scratch /nfs/scratch nfs4
proto=3Dtcp,nosuid,nolock,noatime,actimeo=3D3,nfsvers=3D4.2,seclabel,_netde=
v,x-systemd.automount,x-systemd.mount-timeout=3D30
0 0

An strace shows restorecon probing these mountpoints:

  $ strace -f restorecon /etc/krb5.conf/freeipa 2>&1 | grep /nfs

  statfs("/nfs/home", {f_type=3DNFS_SUPER_MAGIC, f_bsize=3D1048576,
f_blocks=3D10172, f_bfree=3D10069, f_bavail=3D10069, f_files=3D5240832,
f_ffree=3D5240755, f_fsid=3D{val=3D[0, 0]}, f_namelen=3D255, f_frsize=3D104=
8576,
f_flags=3DST_VALID|ST_NOSUID|ST_NOATIME}) =3D 0
  statfs("/nfs/project", {f_type=3DNFS_SUPER_MAGIC, f_bsize=3D1048576,
f_blocks=3D10172, f_bfree=3D10069, f_bavail=3D10069, f_files=3D5240832,
f_ffree=3D5240816, f_fsid=3D{val=3D[0, 0]}, f_namelen=3D255, f_frsize=3D104=
8576,
f_flags=3DST_VALID|ST_NOSUID|ST_NOATIME}) =3D 0
  statfs("/nfs/scratch", {f_type=3DNFS_SUPER_MAGIC, f_bsize=3D1048576,
f_blocks=3D10172, f_bfree=3D10069, f_bavail=3D10069, f_files=3D5240832,
f_ffree=3D5240818, f_fsid=3D{val=3D[0, 0]}, f_namelen=3D255, f_frsize=3D104=
8576,
f_flags=3DST_VALID|ST_NOSUID|ST_NOATIME}) =3D 0

My understanding is:

1. When restorecon is called without ignore mount (-m) flag, it reads
the mount table to construct the exclusion list for filesystems
without SELinux labeling support.
https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_=
restorecon.c#L146C14-L146C28
2. exclude_non_seclabel_mounts() calls file_system_count() for mounts that
advertise the seclabel option. file_system_count() calls statvfs() on
the mountpoint.
https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_=
restorecon.c#L343
https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_=
restorecon.c#L282
3. Calling statvfs() on a autofs mountpoint activates the underlying mount.
4. The resulting file count appears to be used only for progress reporting,=
 but
it is calculated even when neither progress nor mass-relabel reporting
was requested.

So a non-recursive restorecon operation on one local file can mount
unrelated remote filesystems.

I would expect restorecon to not activate unrelated systemd automount
filesystems when progress reporting is not requested and the target
does not traverse those filesystems.

Environment:

Distribution: AlmaLinux release 9.8 (Olive Jaguar)
policycoreutils package: policycoreutils-3.6-5.el9.x86_64
libselinux package: libselinux-3.6-3.el9.x86_64
systemd package: systemd-252-67.el9_8.4.alma.1.x86_64
Kernel: 5.14.0-687.26.1.el9_8.x86_64

Let me know if I can be of further assistance.
F=C3=A9lix-Antoine Fortin
