Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7522C3276
	for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765926225; cv=none; b=W5/jNhiMGx2GTnYYXj+nnc+2OEnECotp+Q2gEHng6B3jiRYdbtsNBNrEAYyZgoPenlQYicW/HwFEf3iHWsNikH6szZ3RUMiJI2HliR4fTwr6qQIo9u+gwKAkpJwWJ1oPmE8aRQKRulVACa2PloeIdVSWPiq05NOFF1kaPZdeF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765926225; c=relaxed/simple;
	bh=aYuR7WGfuY3rI74yDcaZKdqPTtf0QgmL0q0Bk7KJA3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwKqcQGs5HkLs/znkAcUz+lNfiBTfezduqT4eT5zZn5qypi4WCkWbi4PvPkabkR46JwtZdNVxO896c/dRw0WiJwYoFX+MqyXJLG8LXvIVZyPWJchvlPj9v6uQzwWLBSMGNFjss12HQuINFREThkZ3zlvhkho4FJt8YiEar4UMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cm2pGcZI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cm2pGcZI"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6062340b3a.3
        for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765926223; x=1766531023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=999Ra5nNIcgIyecT2HDRGeInlGpnYwvVkDULmVpZ2ng=;
        b=Cm2pGcZIDI03EnW6hmNbgt6BYu+9iC5EW84p5aWlDNzZd10+dCnIbiXc1dD9FOehkp
         jJQq6vFWnye9szPbT6YWlX0froPI8atmpt+5Jo2HITbWZ3lCfr92hyBFSnByDx22CZJ4
         qaVZlOIVC4k0JA01NMrMei6ZmaRSLbLQHeTRYXwFVMxFSI/9ru96UMyfvfzp4mMJPOWy
         NfRnjpk2ZYWnEC+J/iGU5IAEpxRO4CluLt43Gkt2Fta+V3Gc0asECmH8ICSQo92gYC/w
         g2xorw11k82G7KBJqtb0dS2JiKJo+1Ku4ljT6d1eg/hGaPpLLbEpbj2/TGBz+ACoC+Ud
         tBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765926223; x=1766531023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=999Ra5nNIcgIyecT2HDRGeInlGpnYwvVkDULmVpZ2ng=;
        b=lCARi2GtdyyMutwYNpckrdyCzGzSS3nMOR59rLA430H0MeWLaqXN2PyBG4N12a4vVo
         fYrua5eOi/QsFxaOo1Ld8Ey01cEQkpECKWUQdzUwHl9tSLjyj4Ivo0ZkP4HaiFvHdaqQ
         jjz96Jm9gmfzK+XR2zIc17bPXIwCpjHk6Jn6tHMgTp+dVQSxcXYgRU3IwKmMrBYc+Wq9
         uTGSLJZyQzaSDrf/9uPWiShjNf0aUYlOfdA6B0soGfWq0rwgewMk1wWh1Gys/PF8kK/q
         g3BPyH5r8Ph0UKbMg/fFe2A3ZROl9pzRXwK7NkTGDhdlwz5LFzotSNuVMx9msXY6RAwQ
         nZOw==
X-Forwarded-Encrypted: i=1; AJvYcCWARyZKx6ubGSl/xftlQONEuftkECnQ+8K0SpvCqFqYt3l584/HqhUZFM47KyRszIROM/68dfiu@vger.kernel.org
X-Gm-Message-State: AOJu0YzeIoJ9nm6iT9y3RdyohsC3iLoWmoI/6b/Ciic9/WfOmfbujRCG
	KZwv4B4WrL1BUy5ViptI9r0BRBXN5/eVJcM3DN6c9cfJnOZ6VH0goK2qwC0iSOXEAqe8dQkuAs2
	TYWaKYe+7PaaQx3aVDpPYecHR8WGU+czJNPx1E2xS
X-Gm-Gg: AY/fxX7Oh1o7TViM8YynkqKrw5Cvkje1gs7CfILt1G0BtaByHQobIDRBDmkRUZJOp+g
	tPKnfjgsKMsFSea+/0EhNUiN4itm6scxu7gXdc+3bRX2puGfHJpv++qKEgrNyGlWD1yVqLdWGds
	PwmWO8Gg9Iu5h6Vge4IIVbrhdcgHTWxhWvK5Cc17MsKnVLEAzljQ1FseJWrLOpP2InNoREhej10
	Gt2PxV2EeU456FqVKgoFwl7/FveoACWIAj9LKDe20luQYayxu4l9pSLeo5RMAoLFtlixEY=
X-Google-Smtp-Source: AGHT+IHpfmnNU4elY2Ty5ORWz89amfg/6YivUBJr0NnncINJP9IfPfNCTIcEYB/tPEGFhORURxurKR9zfHVNkpEBtEY=
X-Received: by 2002:a05:6a20:12cb:b0:35f:aa1b:bc09 with SMTP id
 adf61e73a8af0-369adfb3079mr16047640637.17.1765926222635; Tue, 16 Dec 2025
 15:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 18:03:31 -0500
X-Gm-Features: AQt7F2rZw2j91MpBSQ41cc9ZofVCToHErlufY-3uD0Xl6tB9kNjXs4RkNaSU8XA
Message-ID: <CAHC9VhTnf_3QQCeWicRqANdeBgaHctSid3pTu-0iVc3BsFrtwQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: unify security_inode_listsecurity() calls
To: Stephen Smalley <stephen.smalley.work@gmail.com>, anna@kernel.org, trondmy@kernel.org
Cc: okorniev@redhat.com, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 2:58=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> security label") introduced a direct call to
> security_inode_listsecurity() in nfs4_listxattr(). However,
> nfs4_listxattr() already indirectly called
> security_inode_listsecurity() via nfs4_listxattr_nfs4_label() if
> CONFIG_NFS_V4_SECURITY_LABEL is enabled and the server has the
> NFS_CAP_SECURITY_LABEL capability enabled. This duplication was fixed
> by commit 9acb237deff7 ("NFSv4.2: another fix for listxattr") by
> making the second call conditional on NFS_CAP_SECURITY_LABEL not being
> set by the server. However, the combination of the two changes
> effectively makes one call to security_inode_listsecurity() in every
> case - which is the desired behavior since getxattr() always returns a
> security xattr even if it has to synthesize one. Further, the two
> different calls produce different xattr name ordering between
> security.* and user.* xattr names. Unify the two separate calls into a
> single call and get rid of nfs4_listxattr_nfs4_label() altogether.
>
> Link: https://lore.kernel.org/selinux/CAEjxPJ6e8z__=3DMP5NfdUxkOMQ=3DEnUF=
SjWFofP4YPwHqK=3DKi5nw@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 38 +++-----------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)

NFS folks, any thoughts on this?  We'd like to clean up the
security_inode_listsecurity() interface (see the Link: metadata
above), but we need to sort this out first.

--=20
paul-moore.com
