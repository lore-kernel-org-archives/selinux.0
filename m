Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084E43CEF6
	for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749810; cv=pass; b=k7IR2ppm92HhGBeOWiLo7R9lOGSMCI4SoYV1Pp04loEGhBD+MXqsNf1O+PZGJ/5jx4+MeOp3CM0VOlUdiRQjtyePDIf4bRCUoRXomaObTHoUXAP6RMbAUaYHmI5nwkOFAF7AkYfnXh4nDHTWK7d/OEIKyv0CWYoW6+NlmbCM3XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749810; c=relaxed/simple;
	bh=7Ar/SAUu05ZPpNVCv4iwxHYUGa0soff8l61jRcCW4s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4m0Jg4xQp4HiwBsvRo9fIfQwwQzApr9OIdy2+vLFZhRsiI/A27fINAJNNHU2ExgoUUnsM5/epUVRaB0+yxMiKyat3ay6P/DBNGsFUUXb5gCDdLgPlws0mk3yinqJ0VVFHhkrZmw/f9fuyPnK4sZoMCudoSSzP3eqoI4LkKkLg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKknmtL7; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKknmtL7"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-139b5e604b9so4133312c88.0
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 09:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782749808; cv=none;
        d=google.com; s=arc-20260327;
        b=GYWvdQTsz1MOUf+lY/hTk3S0yw73QO5TjIOeS+B1g+PUnXoCN+VFVONhzrj6VaE+Fg
         VBBFxs0ZZigAaxAFVdn5Pk6kNF++2XgAYgGHZMeNFnZRPdduHBqvJRMrhs64Wb7lfAeP
         bZBxlaacFknavmW4Vvz+F4THqyQPm6RvVgVqxfsTpJSyNTRaWGGljxgC2chg9CnZz1I3
         TTJI2XLD2sX3m2q7hgqhi1BWcXecGes27lYEhx0vJ1H5De51eYnBB9ZKAI6GD/VM5AMH
         FVkxIOYCBUsiWlI46WTPoEjqJL4lw5RwMvkZEKDXVdGJSYbb02ksYz8B1GHKxdK2JxMQ
         4jhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UESxKsYG6LAGqpOa9YbRHbRt4zZd5rCwPMzVK14ioSg=;
        fh=XiDe5r/OQ/utnxoJgTrvooPs6Jx7NGeGA2wx5Y7LpmQ=;
        b=ltBdYeZ9iouApKBtGySCdhXH42u/szLy8vs+0vJo9hUL5p5Z4r0xbV0YOHnYURYZHb
         gtGw+5hc47Dq93oQVddTXZ+DSwZPVZqYaZm62auacVJyacKr2bJ8B8yM/pNQ2U2q3N/6
         Smt+A1x08zSV27FTK04yikYW9azlScmexVv9EyfRBVKER5KAo+Tk34LN5rw/cEFJflPg
         x1ZkQuhQbwa5ZtRfhQCMJ5a0fr+I1Kkb8awpEAffZlWbOydWVx4cN0QuMTQ/tVgBYuTj
         TPYXR7dHDaxNj+e6rx+he3AlireYxHSNrHESkKjSegGrIofeun6UyX1rIpJvycTNO7di
         uU2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782749808; x=1783354608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UESxKsYG6LAGqpOa9YbRHbRt4zZd5rCwPMzVK14ioSg=;
        b=rKknmtL7nJnbJbcO8i74KSSxUdGF2CClhlvg3IJWEYsf2NFyBR8i+ximsnwELCjx/G
         siEw9TgDUaU7HbIX9lon5mAZVbXrTNpE2GQGBLKRTbLoaft5MfTxylpVJUHs48Ecsit6
         b01YPZPSZOEh2QUPUnnrCupS1+lVRhqpRuReIkH4OnV7/aB73gth6RGvsYnoz2SND+Pz
         ezZSpmfiJXgaMqbcQ/aTvSduV+HV4mXJaD75cwsu7SkRS+gDIthpeyvRZP/KWOjWNICY
         0Wy43hPkMbdfgQ1UuoFOHUpqJ0Oni5Di4jdtDw0uzgr/budZuWFVmAcqab38BOKUQvmv
         QuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749808; x=1783354608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UESxKsYG6LAGqpOa9YbRHbRt4zZd5rCwPMzVK14ioSg=;
        b=I7AYUgjUAKH/II95KRDsD9JCZjD2EitM5gHDkc5LuyxBygJNAEYPWcgQ57wrEyF/jO
         4wKjXSGYQHFRv+0anl+mct24WEo6plKq3lQ0Ltb33nVWGQ1DH8S0J7mHZK0WgIxY6g7c
         fdwyBqQTKTbLjsIUeXk63DEKN0bMHt81AXeukwR3dcdSVKa97VJvII0O2xLb80o95BBt
         EH0cCiJvxzU0kkyH7EGn061iuHO0jTBK1+y/iX4reidzl1cl2JAffiQnM1X6b5VsI8Pr
         c4s+lqc9f8EWQXs+9LULI6wpNxTNcLIdOk+l5+fJfLo/C1ubPru5qS/5YB1YNKHLY+Vt
         lEmg==
X-Forwarded-Encrypted: i=1; AFNElJ+NrmQLpm3+C342v9HKVMeUq0Cqo4ukq9kAjRfFZDblqkfPiPaK/+CedefTHtKLTCr/kmBWBaCv@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDwpr0X2sU9cZUz16APMnMo8gF9+ODgXlFad1jTC6qqbSfNuO
	bIN3AQ2HogSzgOj2/N5wyu4xprtcGbr2CHauwa0flXPxUlwJNJM/amZNINeEf/tIec6sB4Th87l
	QL3CNylgrnPedNpoKC22c/JsuFL12hUvTVKtxBVx0
X-Gm-Gg: AfdE7cmQXYrGwf6BXmNDGu2jBYUREC3Ux7WmVZJAiKMjHasTfWDbouE3BFMyyhabAtM
	vkknknUgtEXhZuVQTbB+FX0uMxVT8GnVABo5CBl55/18rWonmR5GpOzWTSVGJTF/21YqQTzpjCK
	0AziTxN3hpLA3hrVEtArT3jb4kFMrR0QqObh1JHSzmyQI4cSgy6PhoMhysNibVAa6hWYcQuTT9l
	pUzCKplvDGi08F8MadobDQIfEzuZVnyCdJMLCISpX/RoFwt5rAThHE8wInuxn2GttmFdsaZQ18f
	cS4NaSyr0UwfURcoa5KIXakI58R7pqEiRfaAGPruJ2cos43R/xTeaFJCOOqQ21hJuaa5qg368mF
	kjs8SUVFqsuZykb7xSsVCpZwgJjK7tERs66zaB+j3mA==
X-Received: by 2002:a05:7022:6b93:b0:139:f3cd:228f with SMTP id
 a92af1059eb24-13b2a1efa43mr50043c88.50.1782749807255; Mon, 29 Jun 2026
 09:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629063005.64700-1-laoar.shao@gmail.com>
In-Reply-To: <20260629063005.64700-1-laoar.shao@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 29 Jun 2026 09:16:35 -0700
X-Gm-Features: AVVi8CdKpA08UqNxipczzMinoQHHVLU1q0S54kNRz4N_OXLwANvlPLQsJU6Ya9c
Message-ID: <CAAVpQUD4tpO7h92FCrp_phkjQv-QXXyrYBvhGRDDDG=doht1nQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: suppress warning flood for retired DCCP netlink messages
To: Yafang Shao <laoar.shao@gmail.com>
Cc: paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	casey@schaufler-ca.com, kuba@kernel.org, selinux@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 11:30=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> When deploying linux-6.18.y stable kernel to production servers, we
> observed kernel dmesg being flooded with SELinux warnings when running
> `ss -l`:

Please update ss instead of reviving dead code in kernel.


>
>   SELinux: unrecognized netlink message: protocol=3D4 nlmsg_type=3D19 \
>     sclass=3Dnetlink_tcpdiag_socket pid=3D188945 comm=3Dss
>
> The root cause is that DCCP support was retired in
> commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
> DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
> nlmsg_perm() to return -EINVAL, triggering the SELinux warning for every
> `ss -l` invocation [0].
>
> Since this is a retired feature rather than an invalid operation, return
> -ENOENT instead of -EINVAL. This suppresses the warning flood while maint=
aining
> correct error semantics for user space.
>
> Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
> Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  security/selinux/nlmsgtab.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 655d2616c9d2..812961a847bc 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -192,6 +192,9 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, =
u32 *perm)
>                                   sizeof(nlmsg_route_perms));
>                 break;
>         case SECCLASS_NETLINK_TCPDIAG_SOCKET:
> +               /* DCCPDIAG_GETSOCK has already been deprecated */
> +               if (nlmsg_type =3D=3D DCCPDIAG_GETSOCK)
> +                       return -ENOENT;
>                 if (selinux_policycap_netlink_xperm()) {
>                         *perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG;
>                         return 0;
> --
> 2.52.0
>
