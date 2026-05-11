Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4F37E30C
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529169; cv=none; b=XJELZBybwGQHAyzIZdIlrrGAaUkL+DgeIbBZolCA5FZJJ6GYplXk8OTctFFdkbc9ZFLr6Znidx7+Kvw0Ytj/cc4oU6Ff7tmi9RQdChf84Sv5x0/bO/A39X1xvpRdWQpJ/U0cW1i/Y5imiOga47x47SvfSp6xq6gfSyyxp8cSsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529169; c=relaxed/simple;
	bh=VcQxfTFcZTn9ONn/zVhnpsD0/DB1MuCe94obAIHqHbM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KFeSKxzvB911tu92Z+GiFjXMo31RTk85PNJXqip0QMk402C9JTuW+FsVpSZAuoeHJIWABAN6R1EG+9DViXLs/8bQYGGheCtagB+VvS10IUDohPBWgfsnKyq1M005hQS3wlmsZlrnfnp0Lue4XJ33OtIHYkxZ73uj6Ox6lYkJQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O1dCdV6b; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O1dCdV6b"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90cbb2b50ccso22025785a.0
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529167; x=1779133967; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL+UPYnZCOjrePrtqK6xOAZ5G7o1QmvEfzGseYDEIaM=;
        b=O1dCdV6bVCNE0S2myy/TKrzkIxIwfCo/LphzIaKwCvVQeB+DzL4643965DQCBP4/OL
         UA2ARqxufDGtcWp73ZPeUbFdiEuAv6eaHc+UR8k/qQSQb3FKvmZQ6T1MPDkXjIRcbL/W
         e9x3gemRAy+fVWrZ1pXRYxd44F+8/HuoDe528Mxq/P9pFaQDxqAkMZ9NSMponXPGQKRw
         SXYZ+0xIMxGVKNuvOC7zOM51JfdDgEXdAmwVbXtzD2TuPhG7onHGUhCpVSMNfWarhFdG
         8o83kvZHZ9OwUNAq6CaF9Om9E+QlEL4KKmMYKwepIMqeabRywZ1/DVdgA6EelFx/f1SV
         KMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529167; x=1779133967;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL+UPYnZCOjrePrtqK6xOAZ5G7o1QmvEfzGseYDEIaM=;
        b=j9u0EVMurjugUv0m8wBQq5HYOjo/Yvp6S6LHRfiOBu3POSj7174jYwALQCgGFl/MmM
         hRXvXoZgI3Knp48n/KxsYc7zt6L5/QePiQtaHImrIVfcn8tEl6pIXKNgnWLOy9QQg8Mt
         GKalIcnsXcPyWWQFdQ39byViyqN3qYp061eeIBZKZfkZIGFcF/0vSCwZiUqrtpXcWyZ3
         spV6Da+0wt6xzY3l5kW1lIyvI8rmEsiVy9bzsZJnH0W20uSMBjEyr457ynwGfBXok/Eo
         2r+nbiOnyAGPfu564mw07xo4HHuXqAbZA+0HFMYSXrWNHOiwLX45vrfGsX3d6PurY3lM
         TlMg==
X-Forwarded-Encrypted: i=1; AFNElJ9i5qRznRAEkfrxViRGsMTkfGp7Zt8f+28xesZlmndwCH+4iZaMNXCPPAbBVB1aeeuEVaEU2kkw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64/AwcWqjRJyWS/yC4K3mNSeo8AAFctFPTJ1UHNGPhcQJ0TRH
	bb3Ih99FDF2rEfg6YOJ7+LYtP8LLEboi3don7lHf90YaEG5NHh8JuvyBTtOcwwIrhQ==
X-Gm-Gg: Acq92OHCcCFKpCvi8geFXmHTiqxZ6+f46Yp2qTZt0fri7uq/vkujZmqSpndW5YMa59I
	FtkuarQDPGOIss4yVgQu1v33va9AQ/t4ZAYRcBmXwT3+u4B3ashlM01jFBcGMBS6aVg1eJf24Ef
	MyoHexReWeadt4g2lgovsf34p6rza9ErZ899UGF9cVjOAqa91f8XrWKwOQSY1W5G3RqUDGZw+da
	dis3nNZIg3LBJ4cStrFdRvsOSk7gfZ1cYM3lqgdNMlPoOLe7geZ2+IY3S8ZiUEKQ6GESLREUkmJ
	48IYaLdsCqet9ogA80UCAzH08dEFMAYu8ltT+Asb+z1tj4ZJwIDDszgQSyu2r0LMHKxhhCpEUWt
	bCVXSCLELYaIqmCfUtsbhro2OiAJIK11qZtzMVc5nq+nI2orH9Nky6bOy4ENSADTEcL2M9Bk4dl
	ERKUpkOCBCjqTWZC8EW2+MyhE1z3Xu9utbv1KSfivEmP3vrSR9P7lwPmhWc1rbv2y076R+BxY3l
	LbN2e0=
X-Received: by 2002:a05:6214:2301:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-8c1a2531e7emr167597196d6.8.1778529166775;
        Mon, 11 May 2026 12:52:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm322404436d6.45.2026.05.11.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:45 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:44 -0400
Message-ID: <ce407923a8717656e21a9f59b45043d4@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: john.johansen@canonical.com, georgia.garcia@canonical.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 3/7] apparmor: Convert from sb_mount to granular mount  hooks
References: <20260509015208.3853132-4-song@kernel.org>
In-Reply-To: <20260509015208.3853132-4-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Replace AppArmor's monolithic apparmor_sb_mount() with granular
> mount hooks.
> 
> Key changes:
> - mount_bind: uses the pre-resolved struct path from VFS instead of
>   re-resolving dev_name via kern_path(), eliminating a TOCTOU
>   vulnerability. aa_bind_mount() now takes a struct path instead of
>   a string for the source.
> - mount_new, mount_remount: receive the original mount(2) flags and
>   data parameters for policy matching via match_mnt_flags() and
>   AA_MNT_CONT_MATCH data matching.
> - mount_reconfigure: handles MS_REMOUNT|MS_BIND (mount attribute
>   reconfiguration) which was previously handled as a remount.
> - mount_move: reuses apparmor_move_mount() which already handles
>   pre-resolved paths.
> - mount_change_type: propagation type changes.
> 
> aa_move_mount_old() is removed since move mounts now go through
> security_mount_move() with pre-resolved struct path pointers for
> both the old mount(2) and new move_mount(2) APIs.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/apparmor/include/mount.h |  5 +-
>  security/apparmor/lsm.c           | 99 ++++++++++++++++++++++++-------
>  security/apparmor/mount.c         | 37 ++----------
>  3 files changed, 83 insertions(+), 58 deletions(-)

John, Georgia, are you guys okay with this patch?

--
paul-moore.com
