Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EF3ACA4B
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365061; cv=pass; b=iPn9zl6UjH3z83ITVVfqi8R2epUyVlOd1epUmg0Af3AItU2faH1Yu0G6rL58sS+0zAGUMmos4yh83AzEDJB2GhpnHPSvrACLqRbpe15vxZYftrgDDKvH8vpz06ggc2XRjr58bX4dFC5yu+1xk0+b5lfAgxLmx1ReziOBURkvkk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365061; c=relaxed/simple;
	bh=JBv3+G3O/u6NFDaT1Rk6lXqvCdYMpWX3b2luip4qq1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i82mhXuQTLMsYFucQVT+qstNJTeyBGf74ZlMWI9wTjzB5O6aM4CdByhz3A00WK4WtsJvwdfzeNEGEDjvB/mf01zorGnA57awVJIHpsheG8q/ykHZDhd8tbnI8Ik+pAguaI24dz1936ccgEjzxK3RvSSJlovQ4a7GVLK0/gsGTE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyRD309D; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyRD309D"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8475eca3a66so4985857b3a.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 12:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783365057; cv=none;
        d=google.com; s=arc-20260327;
        b=g3mJPw6VbmWkq5G2AZXxvlJlNOut/kztKAKsmAhc/BS/pIYx7zC/jq82I+mCJgEHue
         aykgl5yAeq3ZP5guE9uZq4MQ1d5jML2QP9PxI5dh9hKoehR1uzyuXHP+T1TInWzklRCD
         D36go+zBjBpCHKtUaNaD26oMlYzdzNXP04rw3JZz98YPxQObIFePCZCUr0ChFTxHdMNa
         S8A2K2Y9zHJQU+QIBCay7y8QY13bUm2G6xk5Dg1DwDk4cc+aEmT8zR6VCFpA+H3ZNul3
         7kwzE7ofQLvD/hpz/eyU+3Eoq/EfGBu75a9G3wi4QfJBnqObcxhEXWnOycdPSBigi2RP
         OtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xr9n927D9qkj+2Vx9WFx0NlWy/A6Dj3zM1ksgV2TF4w=;
        fh=odjSazalfr5b2JB1U3YuDFpfQhSk/ZJ/cuPyeVRaQ+Y=;
        b=qAoUqFDsx/62FoT4+HyXLGJBkbT9/8xaXI+ryYOF5lXRXvqqwjqJmWpsfiGcx6Nbls
         5EoavohpnsB0loYPJd5xhcHE0wsbEONgnWb/PQ7+X7HArsJ7qKGUjrYtYoWR/H6W7hFi
         FLazQ/HLPsUJ9WgvpV9S/WwC7MtF1+Qw4NceWL94tYPl6J7nt/DqPiPRfLeKOJ7RzW7M
         /WFOQtUh4aqOBpz32Li9osoE6Wf4afOfSaad8E22czG8Gch4cQRM9oCvcpH5ERfik/9q
         kr3Mdr4BMo9vkaUEQMpM+IHEahvgGFfwff0ZHzd9vtmb0seR7D8M3BtLwgxci/Bi20Mb
         yTng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783365057; x=1783969857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xr9n927D9qkj+2Vx9WFx0NlWy/A6Dj3zM1ksgV2TF4w=;
        b=CyRD309DPZpztsmrKfn5ojY3LtKDfHSdvDA7lbavolHFDha4kstitYRWbJpT0ealNX
         CYQvQJBVvIbtT7tE0L41jDdZJO4kDF+4PLPPjniEPexOk1NKsg6MRAcSSD3zoOTcrgUa
         ay6OFwOBzjZaf52gVqvPogp4XbgXQAcerlc7T42ZBobiRbQh2mITFDDk0D0pIyPii9h0
         EEAOSK8TkoHwCcMUPmwt1s5pObLKDMnLXW9YBmMYGgMcX9Z5qr/sjD2NbGfH7Ah/qcJP
         0G9P+0sGUkG0Yv4tLw6n/UfsYuUa0sylLNUHUNXO5pryaylTQh5oOyEyBUj+1gv1HWVD
         Zh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365057; x=1783969857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xr9n927D9qkj+2Vx9WFx0NlWy/A6Dj3zM1ksgV2TF4w=;
        b=o2fTFD3MOyH/lAqqjGsZ5VWQM41fCzVQg8EY7rHmdBjshu61y+0z8Sa/I4c0kmyIA9
         11ihIMgdXKvrGbeTikye6yQWEPotASkaOiv38vcS6kB+BUoeUhRZXmHm+kdys4gpMsrF
         ImmmYIi7ncRYR01+osV5+8/VYqRTLMuuSrsMAJU6bghCP0rFpv3MS7E1OhBN7SIn0AzW
         kkWB+B9WHAmo/k2LREn3Dc9+BD6eisUPMpZ+85nW+F0I6obluFxP7oRAJaeaEvaGBpn7
         7nFZx5kEBqpErqZ6VJqvWUs4Q57ckZwCcL89DanlKO9Dl5oTauIF+8L7bZ+cTDt6hGHF
         iqoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoLiJZGcbJURG59ljYrvzmzI2Z9lOplpjH2vxke4BFumLva8Z9op3m0+LyjUOazaJEZfvFCAHu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8sWix5g7xVmhtWApqWlL65HNvdkk7uskVGiqno2R8HUj5Ca7e
	Mba2I+IGgkNVV9PndHv8XhculE+Dx39SHUHkfzljY8rN94Wz1GYcWCUQ0AGFAQcSFgklIExD//8
	VOJLMQ/bWQQuIdTtbn870pJ2Gs13LNtIKvGus
X-Gm-Gg: AfdE7cmAUlFMQakNYb0Q6cnNHxeQGpJjJMn7CYD1Itp37VRvbxtelWS8g+EkQDrHc1w
	UkjwPjKSCiKJL/Qt7FaKMzdVMtk/6mVMHeHGczCa5feQPXVS4zM7a7sb/FKT308i9CH6zgUcBS9
	zZAiso9JlD6a2fzdjgOzf1wLbi+fodBQRA8SwELLmL0nwqgNRMWsLjIm43XWLjlhQP/qfLj48+7
	V4uGju9F6eWQ7D7wUBhRFPAQ6xiWe7YCaBcjX8lPv9LuBZUprxr820riD5eIWJwHV/46U+x
X-Received: by 2002:a05:6a00:4398:b0:847:84a2:cda7 with SMTP id
 d2e1a72fcca58-84826c1ecc9mr1992753b3a.12.1783365057076; Mon, 06 Jul 2026
 12:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703023030.94417-1-laoar.shao@gmail.com>
In-Reply-To: <20260703023030.94417-1-laoar.shao@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Jul 2026 15:10:45 -0400
X-Gm-Features: AVVi8CeOqX9lj8y7cpPHtgGDPPSLbWNNZ4scRQq9Qq832xOiXqynKSkCPDWdTeQ
Message-ID: <CAEjxPJ4TSQh99e_Wdh0c=dzO0RB2zOaFGeeUKh6_K-jv+8t2=w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: suppress warning flood for retired DCCP
 netlink messages
To: Yafang Shao <laoar.shao@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	kuba@kernel.org, kuniyu@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:30=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> When deploying linux-6.18.y stable kernel to production servers, we
> observed kernel dmesg being flooded with SELinux warnings when running
> `ss`:
>
>   SELinux: unrecognized netlink message: protocol=3D4 nlmsg_type=3D19 \
>     sclass=3Dnetlink_tcpdiag_socket pid=3D188945 comm=3Dss
>
> The root cause is that DCCP support was retired in
> commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
> DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
> nlmsg_perm() to return -EINVAL, triggering the SELinux warning for every
> `ss -d` invocation [0].
>
> Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
> flooding.
>
> Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
> Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  security/selinux/hooks.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..9541cb674d61 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -94,6 +94,7 @@
>  #include <linux/io_uring/cmd.h>
>  #include <uapi/linux/lsm.h>
>  #include <linux/memfd.h>
> +#include <uapi/linux/inet_diag.h>
>
>  #include "initcalls.h"
>  #include "avc.h"
> @@ -6272,12 +6273,16 @@ static int selinux_netlink_send(struct sock *sk, =
struct sk_buff *skb)
>                                 return rc;
>                 } else if (rc =3D=3D -EINVAL) {
>                         /* -EINVAL is a missing msg/perm mapping */
> -                       pr_warn_ratelimited("SELinux: unrecognized netlin=
k"
> -                               " message: protocol=3D%hu nlmsg_type=3D%h=
u sclass=3D%s"
> -                               " pid=3D%d comm=3D%s\n",
> -                               sk->sk_protocol, nlh->nlmsg_type,
> -                               secclass_map[sclass - 1].name,
> -                               task_pid_nr(current), current->comm);
> +                       if (nlh->nlmsg_type =3D=3D DCCPDIAG_GETSOCK)

sashiko noted that checking DCCPDIAG_GETSOCK above without first
checking the protocol family or security class might trigger this
message on a different protocol family instead [1]

[1] https://lore.kernel.org/selinux/20260703023813.13B611F000E9@smtp.kernel=
.org/
