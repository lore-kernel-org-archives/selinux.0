Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93F4A0C
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046294; cv=none; b=jMcG2yUBbcuwCYPoxdmqmWVojJl2lCcfuuTz0Tvw1MSvxZ+I9cf07/C0Ddnwe4VCgTawzbmjy4dFFeK99TNuvo6rzDWpfAkVqt9utstoKXqStWin+00DDkswEn/ssY7UbmMNW1c0aqKZWSMuoc6b+luL00V1PbwFaPf/9OJVoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046294; c=relaxed/simple;
	bh=FexH5DCnZGMqJLMWXzzwrkWMxsTHG7qiEwLFY7ujizY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DtNw/iU6EjDtU7n6bhHLefS43KO07XaFNpCSOKM66jFKGLyXrrTyrsVuMKIZ7l9KUYecmbYwzeZ0KLCl/HN2roYCLTMyiXsGmlxDW6hnX0a9/pSbN7rN2Yfe/GkstrEpwlGBO8Jr+GcR7zInzmcBoNNM4OMQfPI4kSlfVE/8QSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GscZTzxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GscZTzxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B611F000E9
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 02:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783046293;
	bh=GwnXN0IPmvSZu03APsHGZEBLVw20TgwWT5I2fvMDqnE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GscZTzxx4tyWyIykQJQmuwqLj7/Yoawowe8DUvRFs57A4fN/Oin4KnrEeg1TK38Pv
	 SInd7jWl/OSVHLdAY5b8SX+NnIcQmYZVzHVL3fEC/Z1j1kZg6/iTQ/DDB6gq4KYLAR
	 R5QzWcpekfJCAdvGQNV37sIh+9zfi3zH6CFyoHUAflVtlburXaYWegqRGY1TpT3LQc
	 JPtaeAf4xiCGLEU08cHeYU+KFcWgP7Q42erbkJD0ofts6bJedHbP/4NZ2hmVjLXXpP
	 e7MtxedDXmSRY6nPttxjRIzJtLcZE0wlIjKpaknEzJ+SOqTj6dP3T7bg6FqfEPIboP
	 bfy+4qOFiGDEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: suppress warning flood for retired DCCP
 netlink messages
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260703023030.94417-1-laoar.shao@gmail.com>
References: <20260703023030.94417-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:38:12 +0000
Message-Id: <20260703023813.13B611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The check for DCCPDIAG_GETSOCK does not verify the socket's prot=
ocol family or SELinux class, incorrectly intercepting invalid messages sen=
t to other netlink subsystems like NETLINK_AUDIT.
--

commit 0ed2e4bbea68b959f81f6b7c06db4d7b3ae85534
Author: Yafang Shao <laoar.shao@gmail.com>

selinux: suppress warning flood for retired DCCP netlink messages

This commit modifies the SELinux netlink send hook to suppress repeated
warnings for the retired DCCP netlink messages. It intercepts the specific
message type (DCCPDIAG_GETSOCK) and logs a warning only once, rather than
rate-limiting, to avoid log flooding from tools like ss.

Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c81..7054f9be55cfc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -6276,12 +6277,16 @@ static int selinux_netlink_send(struct sock *sk, =
struct sk_buff *skb)
>  				return rc;
>  		} else if (rc =3D=3D -EINVAL) {
>  			/* -EINVAL is a missing msg/perm mapping */
> -			pr_warn_ratelimited("SELinux: unrecognized netlink"
> -				" message: protocol=3D%hu nlmsg_type=3D%hu sclass=3D%s"
> -				" pid=3D%d comm=3D%s\n",
> -				sk->sk_protocol, nlh->nlmsg_type,
> -				secclass_map[sclass - 1].name,
> -				task_pid_nr(current), current->comm);
> +			if (nlh->nlmsg_type =3D=3D DCCPDIAG_GETSOCK)
> +				pr_warn_once("SELinux: DCCP has been removed, pid=3D%d comm=3D%s\n",
> +					     task_pid_nr(current), current->comm);

[Severity: Medium]
Will this check incorrectly match other netlink subsystems?

Since DCCPDIAG_GETSOCK evaluates to 19, if a user sends a message with
nlmsg_type 19 to an unrelated socket family (like NETLINK_AUDIT), it could
trigger this path because type 19 is unmapped for Audit sockets.

This would result in a misleading "DCCP has been removed" warning instead of
the standard "unrecognized netlink message" warning.=20

Furthermore, because pr_warn_once() is used, this one occurrence will
permanently consume the warning allowance globally, suppressing legitimate
generic warnings for type 19 across all protocols.

Should this check also verify the socket's protocol family or SELinux class
(sclass) before assuming the message is DCCPDIAG_GETSOCK?

> +			else
> +				pr_warn_ratelimited("SELinux: unrecognized netlink"
> +					" message: protocol=3D%hu nlmsg_type=3D%hu sclass=3D%s"
> +					" pid=3D%d comm=3D%s\n",
> +					sk->sk_protocol, nlh->nlmsg_type,
> +					secclass_map[sclass - 1].name,
> +					task_pid_nr(current), current->comm);
>  			if (enforcing_enabled() &&
>  			    !security_get_allow_unknown())
>  				return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703023030.9441=
7-1-laoar.shao@gmail.com?part=3D1
