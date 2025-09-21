Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF41B041A
	for <selinux@vger.kernel.org>; Sun, 21 Sep 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482595; cv=none; b=FCwNS5dfmqS8qpu204Xq1Fr0plpKnwZqQJ+ql+ZO0wyGaqWalWppg3SJceSCIW/iGRrp8ijw8ZPhDiz66ahnUoUi90hdJUqUMykhAHRiCwWPGejAXxpXS4qntxb7zO5N66jXmn9uayhaXuRPmd+iC0s/GJm1UiIX4h1nlRL5PZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482595; c=relaxed/simple;
	bh=zLZm2FgE4O0YYFCxnnlKENyYOeEJXDIvxEM1W1Wmm2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXQEn7WFWL9v4T17l5qTOhXJdbIZO6H7M9c2zqT1g7ybwB33VAbU7/Tgt5j+gghlYsjr+IqjAGhYPFzHfis2phpeoThPRv55rKPd5SlJBzPPjPDWJgHi+Djcm5w6zZNVOZ0Dh/6qj0A1XECXeXs/48wRdW4AGECO0eGGKQ1E6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ql3SP0xd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ql3SP0xd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so3071844a91.2
        for <selinux@vger.kernel.org>; Sun, 21 Sep 2025 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758482593; x=1759087393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejP95JhTFso+EjCzhC/+xR4WsqrG0IwVs1drcrs6+RE=;
        b=Ql3SP0xdL/hIgOz2HjGqF2XJ/+Z35VQM+IHDX5lVIE7XhkbUeqnGGLR8jptROnDRiF
         7wzAFcpw2D46JkB7Hebq+pfVQ6R3Dc5iLsYs3noPceTNxahFd5w2DKeQJHEFJPC99q1M
         C8eUFEVBX6Ru1mFCM7YpKlOfybwZz6bZ3P+nA+9/JtB7zXl5eT6Up/HuT5gPQT6yiXl0
         i9gy4c8rwqkE27IjbizKJeNGNslONlSDdcxtONwGz4+r0PixIx7lWuEKWVi/0nc0TioJ
         nJ+eff6H0HNcR6QpOx+1IzaxFGH+3rO8n3Nrb/ygjlsBp8uM3o6UsIKCPMWiuFoWseyU
         j/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758482593; x=1759087393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejP95JhTFso+EjCzhC/+xR4WsqrG0IwVs1drcrs6+RE=;
        b=jfEXSOtS7j5ZIZQaXifp4clTKcCFu1K4MEolimrPKeWE1ayZoJ8FwT8f174dAkzEeh
         wTQjsmTXnl4dzEYh6CODpdYa9g+rIhgCSkaYE7x+73+a4/VfNA9hiNsr8n1Pvc68CIHS
         cunA3ka3pddETFlwwIsNPrmOVJfVh1eG+M4Q/QRlXs+XHvUeV7fEDPI6F5v6YTkCu69S
         IsOcK4OxuT49SKv8zqWU9aiLsNFJYiu0ZbZebB/RTcnm+Z0DgWWFTQZIpx0MvIjgZuyT
         8LKD7XDhYwys3C2QnVBnayoM31XH/HyzR9pKhZftG1jnwspla39hE21xNGcJWG2x5q3w
         L+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVSKIvsct638dqvRKXfKGMDL/Khm7/ECZZQ54TrltBWUmI5HroUY7ezruEf2sfQ+HmsnRn7f1Wq@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvYDLoAGqib1fclOMjDyNts1De1WvPytgakAbkiefxJc8qhca
	vCIDM7d4qA7bhHVrruhZpcXh6cVdkGRSuBo1Q3uPjFP1VlhFjV72qCH5X+DxhZSlyH0U1f/cvR7
	MfZT09F81/uP32IjgnW2C7+2HDB3vPgWf8lyqtXxT
X-Gm-Gg: ASbGnctvViBS8/+FG+7NphzAa0zuxkoIjoef6PYHmXblNeZx8HAmOeo34qu/QxR/pBV
	EJfpvOju5Z2l8EdIzhV+fWCeG7PLjJyV4IQd2yIs7ibnlQCFtBuiWSmSu0GtFhsf9mqbZABCxuL
	QRm7wIeqhn6lZ4PAfqX2YEKCA/8cXGgm7io+BkicFxeFwbZgC/yG66gz6yhOQPssjVqGkh93Cbz
	1BVUfs=
X-Google-Smtp-Source: AGHT+IHXhcLkRhAm67NgddyngyEIqPvNnk06vbCHqpqFsCVyupjnItG+4hoPBhdKiQIQbiQv7gdx/QcSiBDizlzfeWY=
X-Received: by 2002:a17:90b:5623:b0:32e:ca03:3ba with SMTP id
 98e67ed59e1d1-3309834c0afmr11873963a91.22.1758482593127; Sun, 21 Sep 2025
 12:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-47-paul@paul-moore.com>
 <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
In-Reply-To: <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 21 Sep 2025 15:23:00 -0400
X-Gm-Features: AS18NWDmwzVP09o3NHo4I0wry9IMJ1KHEvCCSo5QOX7Cyiha1nfbdeqh7GS064g
Message-ID: <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com>
Subject: Re: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:16=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> FYI, checkpatch.pl complains of unbalanced braces, otherwise

Looks good to me?

% stg export --stdout lsm-lsm_names_cleanup | ./scripts/checkpatch.pl -
total: 0 errors, 0 warnings, 139 lines checked

Your patch has no obvious style problems and is ready for submission.

--=20
paul-moore.com
