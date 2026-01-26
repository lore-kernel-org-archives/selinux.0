Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864946BF
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467937; cv=pass; b=lIBib2+7MVBZHpuuoO51sB1cfFAh6cv2EZhb7gcRHGvRlc5LZlhiK0WVQhjWmUxYM1o+oiuooXAjG1oJkTvmcPB+v0KBS4Kf32/CoPcF93lOGZT5QZldQl86KHXcQnakOwbL1JNiedvcxGe4cBf5e6epb8occKi6zuw1fAR25LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467937; c=relaxed/simple;
	bh=KLLQdANoINV1odBBaAJlZcMzDaqXaeKbQ8WV4WhXJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxDktd0FGSfhPWkzg8yi+q8KdfbmG+JD0+W4XMYJnNSGrIoblBIiRzZYruGrhyzqbOFoEk29HMuYWTpt8pPCT1d9bHYtGdrwcGtNAdvAdnn9/zUZasuZ6J4GhSB1pm7TFqgAbWKOuly3M9ow9ZKctDu4ztiV1Y+XoabYazUWJno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MzTc5uC2; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MzTc5uC2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a2ea96930cso31048235ad.2
        for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 14:52:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769467935; cv=none;
        d=google.com; s=arc-20240605;
        b=XOZbOwUUUbjJY2ox63RaLVVJrhxB7WXojBEVhYzZjNEMAZ+XWb75gNO85HixSzm1/Y
         RH3XvbxziMnCwqslXQcLZWO7GEQd6mkeaHyPf7CEMG4EOGda6g7G23ouN3a21Wn8xEbQ
         jO7dUmfiZeOhq3wSxmuJ6xAlbx4+mJbwT/AW/NXAtToBl/F+F8evaErA4aYeEvVXipT3
         5RxrYPab/GAm1r7uldfDJB2YLIxkLTzDBHJwHv37j3BZW8sARyY6yMw2dYfD48+kZf1H
         byfdVNwhvMF1zd8ClAsWZ4YDP/wVNpPBIs6EPrSFd0nA+Gf7qKkNhuvesq+a8ozUwLN1
         lpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4gCQ0xkA7by7eZFmx/8B6OueuRxMv1D7GSRo725dNz0=;
        fh=28iGBfHeIC0aiXmm2QNiBeAyFIpE1m8i4OZ8/QE+5Lc=;
        b=jAl3ANGUfbmqcF3mutNgO9EtILkAErG0DaHAeTyQqcLNo4a1YzZ4PgoMjZOY0kvuWc
         qo/KU5UeOufvWs5HY7m2bhn04ytuYoBAiNq+IJLwC+yAHflVQk9HKnGCMwDeRp+TOlZ1
         0LxUmajgUig7e2iOTQP+XQoOWqq8gpBNfZTtJphCIdykDUErTCEhiGd0UylZ2zlLTDm8
         vWgReh14SitgV28vOFiTQ6yIBPMEBDwbeu3+voqTS9TDlYmZZaGBeaU8kySBSqq61mAi
         3kBy0/Hm47R0/9Njr6M+ACh/z05DFqlVggkSbDEh1OneTb3oNlckI/EZYbbt5gD4fBbL
         DKmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769467935; x=1770072735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gCQ0xkA7by7eZFmx/8B6OueuRxMv1D7GSRo725dNz0=;
        b=MzTc5uC2IdT/SNfysEhiNyxYz8WsIBFeddI+uCBPLdDSdnj9MokR76vPpGD86S05Dd
         2xmc5smr9WxxRvD5+fbIZJ+PKJGChM6fY7KKi83alCM+BdSVlRh2mrdMGU5Chkt3aSzB
         nmK2kCxp5fsJBhonNCWEbZ4IqRlQphh2zI/A2BaxriUJAAhq6aTPAhcRkPkKwOJFKB9q
         FrXhdG91fe1unFPSwQhIQ6lo01JhrYTtwmmbu+11DJy3k97IF5Qwp4o+zZ707gmDGsiX
         V+nftD/5MVV2rC2fg+7jJuee5zsKLN0VdT/qZVqKleMQtr8y8MFjdKZKLBBfmCIOjDRy
         IZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467935; x=1770072735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4gCQ0xkA7by7eZFmx/8B6OueuRxMv1D7GSRo725dNz0=;
        b=pmQLL3zj5Kd3XPA3CAQVo35KEY8JXit/u33Tit2Qa2TWlDHjAAwR8BLqTm6z4E62+R
         DBZVsEnBrWbs6SpT+zJV4MK7MPCuhPJFRmJhU1woncpNzAY6TfAajSfB5GyELG5bayJs
         dir1KggYxqrKPC5G42Dx24rtmz6OgWVlL2axMwxeIHqLyHTGOkDsBTQuu/QHDxxieG0V
         JSrBqLf5SbXN7cBHYXJIvVIZ4Jx6C1LZ2Ho1KFHc+POy1Eqk5gr8xNSbACbn7cABIJbb
         1T0bVoLuHCNXfUDzdbLfjLM1PYPDsPwHuP6fG504Smn7HPZtCAXCZZlnpKz3kLOYM93G
         ZzAg==
X-Forwarded-Encrypted: i=1; AJvYcCWd35XolFdtHz4czOqW0IEoeP1MAAz5QgFeXLlwaGJXYai55KXpekBH/zNP2/EEkMFfrlwDZwfT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1B3oXffaVwWUXhaosC8C6wflr8Pvd75AziKnvuZxCT0ZuuZdx
	MsrpNn16k4CMUvSWyhpnTZTtzIK5Cn4w18p4f5z69RnqcPc1zZrWtZ3a+13zeKc87yQNqzHY9gs
	9rga2DGeLTw1uAtfJEYnsIqcFsL/Sn9ETYSCAiDVw
X-Gm-Gg: AZuq6aLC5xJK+HHHT38QjGV2nNccwaaBTtftXlR5Z+kigjjJr7ShCGArUWL4s9f0mWm
	FiGP6h2RGAP9w69AxxQQ5JutTO1IBlEc8AG0emSlupo2ScWuhgdnO7/gXlfAdHJNQOekv9WO+ut
	D3ELaEPbnbShONw0KFV7BEHLlqz40M8j+vWQYyIpPhIjuSgbGgM4aJcV+ck/CH80Y6aVuoMoQnO
	3TWU/yX/yCEYMm4xFRVKXJWLTSMngZs0IRKosbLFHFjyvtDxbZMm4ZraBFUZXCI/6252MU=
X-Received: by 2002:a17:903:3583:b0:2a7:9da7:d21d with SMTP id
 d9443c01a7336-2a8453287d9mr54528365ad.56.1769467935279; Mon, 26 Jan 2026
 14:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com>
In-Reply-To: <20260122140745.239428-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:52:03 -0500
X-Gm-Features: AZwV_QhZWJJjIz5nrzYMHWCchd4vw4_Kq_gvEnZtehjGVzYkeu1Rp5h6APCx8-A
Message-ID: <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The user.* sysctls implement the ctl_table_root::permissions hook and
> they override the file access mode based on the CAP_SYS_RESOURCE
> capability (at most rwx if capable, at most r-- if not). The capability
> is being checked unconditionally, so if an LSM denies the capability, an
> audit record may be logged even when access is in fact granted.
>
> Given the logic in the set_permissions() function in kernel/ucount.c and
> the unfortunate way the permission checking is implemented, it doesn't
> seem viable to avoid false positive denials by deferring the capability
> check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.c)
> - switch from ns_capable() to ns_capable_noaudit(), so that the check
> never logs an audit record.
>
> Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/ucount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
