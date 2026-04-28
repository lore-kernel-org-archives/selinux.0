Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8D47D938
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404393; cv=pass; b=MVOaoVhyl/xAiMUm0OsIrX5yI23RqGbSj1CWM9upPeFXtq67n+0rOI/j+j2VH1NWlSu5h9cnLeZEcgC+djsg6Wd0A8ZQz2eumSJEO+8kez60QaKtsqVnTaaMdkeoVrGlc2LVPAHC1lOJO09SXxOc4k9Ny/HEysxJAVPURo2wBXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404393; c=relaxed/simple;
	bh=U/O8kY35FSPyilg0S9fhApP710nRPp9xFdci0TwAFQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+hlc3l5hgYs5T4RGou65hIoXNNZD+M3KSWFTa3uBurlL1dm52A6MP13JaVnjf6cHShpnFa6y3tT0Z/DuclBikrsq1NsPaT0LPB1qkbkDTyVjtPLPu7kktyCBVrT6v5ifViEylh4YJYMq0IugzCCDbxoVGxeQ2HNUMrfE52Rlwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q7vwjsmM; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q7vwjsmM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so6583080b3a.3
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 12:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777404388; cv=none;
        d=google.com; s=arc-20240605;
        b=gYuPn6K/Jjam1+T78LRXvh8NcdpGKv0IlhIp7pNPTfcS9DJSIsa92C9fqQ23MCdeF2
         So/GPoTa17jYH3ZVhI8fqPNMZCq2uSopJ5KFjFx1x79Wcyh7VI+DuX08erc7L3LhFCcl
         XoD3TEKbvUm2KP+uiiQvRLtCpdDdLSlemSm7Vbz7ExHb4m+m+TZUE4aiIthUpO9eCsJL
         ez4FAkZhqNNtomrXkNdNv5zGwiUpQ35jjeUxgnyvDIoskH7wd20gwg5hLXSfMDLSHG/Q
         G1HlYZSwk2qbZnf9XPXR9kDovSkNs1TimWXB3iR7/6r9fdu3Fr8Xk36987/WkqmYIXAv
         H4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        fh=ZpjR0YBreWerwjFTOToXoZvBgPF5u0kQIBqSbLVmbQQ=;
        b=Pbb1V1r52MnddmW75DgsFz3nHr/vJG6IlqSyCLUjy1L8TgF0qxSyHOjBrTzT/fGJey
         UYYcye7G9sWf90AE0RSd3ZYDVgu9CYtI6KiRwNi9XYkgcl+TlX2/PhdqOnqLdEV0Vq5h
         YtmjR0wnyCNHe1e7mCH6KgNxp4gEbb1Z69W4sxHLPB2yK2aTYfa0UPGAOHq06beP9aHk
         LhxWrh+qvWZ5uwfqOFseYlzBczFTlp0KKeF55VAhUOL1a4rWl7i3XgTU8WF9W9OXEIrA
         7rtwBFKIUiyCswKZQkiidUhNOQ8wYpRY9b2FYwTJPnAUU5ywbc0k65HnohpUeY24dwVa
         sEuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777404388; x=1778009188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=Q7vwjsmMKcT1l9AXMv9x+KpTvpFxUKicUV6cTZMYhfBbNByB0fZF26MMPg+TFYXldO
         wAJnS+xEWXJ9B32JBTBrBIiic2/TeFFLzWJgSXX971s8U5GdjVU5swP5jQNe/htLdkI3
         ZdgeBBL205oAlmG8o0ZHP3gwEnRf6+CuAq1bnKD7K0LesxTfN2B6HATKPShdePiNxe9l
         5IKU/kkmPcPleMi63gfxcs/0a3ucVgI8dCjkUP2X6731EBcWvHp3wHrzOUzZpdkcqCUB
         hKkLZBo5SE7N74E8O4Q5Nvc3gLmrBdIjySsJTh6B0ctBuAz0XLTvOffHG0QD5sJswMLI
         q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404388; x=1778009188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=ToX4ZHEBDOzwHwPRmGyAq4rlqqD4EmenaetLjIROKp0avNb/Of9JBy68QkNIZ6hOjQ
         M7/9Ysc/mrYlq4WhwK3ztb3i6TxZs93M8Txfk9proLtOYvTLkljcp7AzI8Ugt5g0ucNI
         wfDR9pEnUcMdXN3FjwcTsz4gYwnk/Yxg61jU72rcdfil+KYWx2h6A23OOpyqr2avyrdc
         3a7hEhkIw31ks/5aCrf52DKo66g7liEhTK1kxD+Ldc1wGNAg3tVlE5vAhotkyy2u1DaZ
         HwxL8Aj7XIn0Z8AgC3pRtjyACmktn3jLspF3pYveEvdQYb2AylF46nghfPruDhRYGBsY
         m5SA==
X-Gm-Message-State: AOJu0YyO6hhxnoICDDmTb0Ivcnyfktn1+alf+8LdqGu1bZWK0D7JaCx8
	0ARIUHN8eJS8Sc+0uebje8n/z49auJDseujefN3xNgfSr6GX3Dwv/3L2ee7zVSuwbD0bZ2iaLrC
	rDx2h8ljq81YXng9547DgV4yl4IDMScai96BdKssTIFGzA8cXTeBBlw==
X-Gm-Gg: AeBDiet/A935GsSGtcliNYVp5Eo0Ci0PZYZyQaWPJ3C6P8xGl004foovzhNCKWh9Y9R
	70cO8Y51QOhnmEKhBcmAVSS4d5498MUDsk260yVa+BC0W0mTU8XnJZIVm/wpmCKzeomHVjynPAB
	AVze9sq8lpo9tIuu7KhaEUygGbnUAP2saweXM1gSsgVbrs+KrdLr8F16VFnLsJ+kVwBWoMKKiKq
	pFlR414DT7BStv5L+fmSDEf5z3arXCq2jwelNwUUDyV3fpKMLCxMQBlolvoTce9rtMqX1rYxmwb
	ZFNkWw1AGUz0InbNOQ==
X-Received: by 2002:a05:6a00:b610:b0:82f:5f2c:dc1e with SMTP id
 d2e1a72fcca58-834ddbefc48mr4513385b3a.30.1777404388228; Tue, 28 Apr 2026
 12:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20260428192119.226244-2-paul@paul-moore.com>
In-Reply-To: <20260428192119.226244-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Apr 2026 15:26:15 -0400
X-Gm-Features: AVHnY4JfXj5rdz057afaM2yOoDKKiXKQXh_FDv64DRP8yW2NVR2QdpNqmASHI1Q
Message-ID: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [PM: forward porting to bring this patch up to v7.1-rc1+]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/nfs/nfs4proc.c             |  7 ++-----
>  fs/xattr.c                    | 11 +++++++----
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  7 files changed, 29 insertions(+), 37 deletions(-)

With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
I wanted to get this patch ready for the next merge window.  As
expected, some borderline non-trivial porting was needed, so I'm
posting the ported version in case anyone wants to review the patch
again.  If I don't hear anything over the next few days, I'll plan to
merge this into lsm/dev later this week.

The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com
