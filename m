Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578942BD030
	for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625757; cv=pass; b=aNXtS/3eHJ75by4hX8kc4/peMONCGiUsBbfIOfQPKXIpZmczjQJ7abmSZf7bH3VqCWsjA0Sn8GkQQXPxlnPAlGF1QkZxjoLP80oSTyHBev+jb93j5LlljnVx+XOOC7diDLXDLeEnDua1KnaS54M0vD3S/tUR0FoKqn2K59vBI/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625757; c=relaxed/simple;
	bh=j2FvKpOUAlz++LQtlLxLTnYm0ZHmX0REwKDmOP9aiII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOnC7Ixy1jlL0sEsei6ZfXV2uqfmW27/IO2gKirElbF99+AIhtqiEChK1mfWGuqqWIHlF24kD9y9sWucCVWdy9mvTKecTAzjDreBGr2VHjNRzANFDHW31M38lxc1DQ7Kvh4cmm/MMK50hKPbBVuQXORJWDKl8Q3ENDVHEY8kj9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GxS1yFxb; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GxS1yFxb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8230f2140beso2014321b3a.1
        for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 14:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625755; cv=none;
        d=google.com; s=arc-20240605;
        b=kmNMEIzQcWlPS/uewJolhpcYWI1Uzfage+iQoF/j1VBR8HMf01Qv5rRK/Lje/YD7iE
         8PVy/MTCVkN1+ZZTkJmCA+fpYTgk7Q5Xh9SBtthIQQZ30b28d6g4PRKr/GtF/k+AT8mt
         w1m2FrQoVB5r2X7mwUXM8fLOOpFXlP2kQQjPM0iPOKhYgLGyla9OPCw1EaCBIZJ5Ptig
         kT5tvnhbkkroFGyWeQf33+xPJ67T+tB/QQ/vJwCuJewus16uEl+ZYsIhe+nonFE3RRj2
         ++lGVCzafSekg2YY3vbiNazY3EuvzETxOghUl82KGWodoADUj7+BMNJceGYK4EGCAVYN
         WmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        fh=sJHm58n+53a5f4Yvx6/+ZtfcGMmB8QDvVF1Dx66aRmI=;
        b=MfldBpvfN1MleEAZD3l86yTPK7nadnjUrem9oOk6i7SnQuP+AB18H7mba4/UMHogAb
         hNqB5J/Bel5FgKFY/BP5LOTjAlgHQWZvQuHRHl74wxRtRe+uuS9TKVwNcQ+RHLMbFSLj
         xFdxI/n4bls0SPs00sFSop/Pcuro/lIq40/sW6tjourXrHPw8aI/C4QZhYDdQ83VECwD
         BmHNAoPUCImEz73AXH25Zm3g7jOx/tT9QrUpBWEMfRgUj0smAkDvX/YURcj4WGOoiJxd
         ymM0FTC3ELsv3otkbjkgX4mEZoVPGGycS+1bWdEclFlkKCN6o0QJ0byAKk4h1DvArMxN
         m1qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771625755; x=1772230555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        b=GxS1yFxbMbDV1VgMssO4X/h5IrLqOjr9uvNzwdF4mwF5cmVoE+ZEOSFkmWaKDlKd5C
         6LnUrQ4jY4ppgMmO+EyapjaqqKVdXdteUuBTZjavR2UYT1QAYke7pzDTOZ4e1s5dkG0R
         fodiCoVW6svow+f021AA5D4XDQTlV5svzccPg1zsd9Qrd9b4DY4zmSYM4ojUGUyjjAiM
         MdzVFb0+YxL0hWDOp3DFLYTHXbKGhoDcrLYA4urKNHkDoQJxE7jdKTZWkjyCD9drPzdr
         BURLdLA9MwHAZmWZb/NN18BTSLdgjIzuCc1UIXZ1UgGYQ4U174+RTzTCbOu28JQtn/gP
         KuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625755; x=1772230555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        b=D3LED3r6oGK0I8kfXYsjKRoEwwbmLTS45nc6fugmniT2+aChlPlxk5FAkqo/KUKUz/
         y29kfykZbs5mhc/WJ1Str53PvuQjhmwqsAP4is4PAaSusyUrd5nZWOVofE8H0WEPQ3Z9
         eB35gvZUe3IHhpBfSpYKRRNDlHzZs0UGFJvq1Frq0X9x+6cckmxBWokzxgsO74RgtjSL
         or/q/rGtHDEIcIar9/PbrfqoHVSVWRescJ6USf9OOeOwx1U4WWfRKPrThW2p7CfRW5Tj
         RMJnwV9JCnS4bTq94C7sMogRuU0eV5ikNyrpZlwPVUesMAfiKGBSMl1F4SLGplXvZupK
         cj1g==
X-Forwarded-Encrypted: i=1; AJvYcCVcYBPTV9IwLHnE8I+TPNGdgo6y7ofS5QPeqQ/tK7lyaglY+BFGl9QqAW/A+D2DRmlDoht5zz2B@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfklTUKKR5igcIkiULjQlk+wYjkLW2jCgkh2TST5lfNuZPSFg
	3JTsP32wmknViibdxNiEgdgOb9xV8IyQYVmXlZ6YX/Rk68IHXVfDFgoTzWpordvHUTpUzwPzltZ
	2K5RbWKIKXc7NjxjM2YTvvvNtZdfh0tG3MgRd9PLf
X-Gm-Gg: AZuq6aKguZhQBG3ofjGSmUDuqtiHIzZsZvt8MB7/NP+KEApofoCc8YF42gOl6aiamv5
	XsepVgJtNoWwZzBYHokyDPPzSCEBQcwIZg2QvfsAUNxwIHs5PNe26O8WsrZhYV8gUht+wQbpJwB
	dr+Y0oSwzpQ7dAF7rAuf1a3ht4bFVfp9kXsYvzfoY4fw2bjZ1ds8/SG5ExrP2n1ZRAyM2dOY8mk
	t5AAOyjPwHtYTiFaw7uwuYD2ngLf9qGY7xZAEE0lYJ5FwShE4AkbkiofbW5v180te5wQfMoXaik
	3N0bFvE=
X-Received: by 2002:a17:90b:57c7:b0:354:7e46:4a8e with SMTP id
 98e67ed59e1d1-358aeacd536mr799506a91.7.1771625754671; Fri, 20 Feb 2026
 14:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-2-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-2-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:15:43 -0500
X-Gm-Features: AaiRm51NzP7pLbkxnmuQ3vMkAzifx0h6WMPLv9aK6B5e9dNw3jFzqT1KPgQ_5Xk
Message-ID: <CAHC9VhTxkgEnU5nP+7zs9eXOn18PXc7vBCUfY1vNd6qM+N5uAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 10:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> Make sure calling capable()/ns_capable() actually leads to access denied
> when false is returned, because these functions emit an audit record
> when a Linux Security Module denies the capability, which makes it
> difficult to avoid allowing/silencing unnecessary permissions in
> security policies (namely with SELinux).
>
> Where the return value just used to set a flag, use the non-auditing
> ns_capable_noaudit() instead.
>
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivi=
leged users")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
