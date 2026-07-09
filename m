Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C722D3A60
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625285; cv=pass; b=C7OohmO/eeyzb+IERAZckKgBSmQaIinMzcQ2gvczll8Jk8+Mk1ByVnj9uBweucSqE5A0qUdoUu3KmlK6f6g6MLzLJY5qvv+g3oVQ8iUPOKQ6rda2yonRABpHVi/PWEfYoL4wM4RcVoUbLrKB7d13H+Ctq+hVjigscRLdyamIIW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625285; c=relaxed/simple;
	bh=3YlX43Jh2gefWew8aezFoDQ04GeceenWlrs8Tu7do9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diRI7TK/z68RekBKHOQBCyXyc/gpr0ldic6E37TuyZVAOARiumi7myA2wnXNxTaq908QfB39rTZZuHHiteYvG/v2g+M6b/uy2eiFPHn5hn1GoXJx7yTdP9P96g/mOGj2E+fuliNlYE2qQIiCpft4k6+5YDb4PGxNbbWmkKpFiGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ3nbolg; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ3nbolg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so18227255ad.1
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 12:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783625284; cv=none;
        d=google.com; s=arc-20260327;
        b=TGuSRYNPBXNZYCekjup2FgnIi7OFKkC2dH0X5Yk7P5+LlZ6GKbeV905ci6j/Qq/JjK
         Uctr3naLJND71Bp/XuXfxVrHtWx53zRvpci6k8b3Bhx0QdBFaHDJv1sZwvlMZv/xpvUP
         9IW9/XxIDoXOqJmRljl7HIk8F/Nx2tWCBDNYT6EDJWcRnCIAjO4jsOBV6h/If80FVAuN
         H9FajWg/ZDqFX77T9apbogl5xYAmqmtUF2v4KVT4HDzrSD5aZF0pUXESyuL+DCaGjwkO
         XCCRQGh8mMk7KctR6/FA4jqYPsUaHVaYvdtA3PyJ/PU0ans+u8HFudFktprZNIoOcX4m
         JbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zb15/v0AHFmeW0kQkbL+9zs4AS8GOi3pByqyK4NR/i8=;
        fh=PeMLZ/cc+FiD+4pT5ccekHYY5uJRMZMInCaTdLSWnjc=;
        b=do+RAFCYuFPbyCL/wfirB6fidKm+hbeCFD7Yzy9QEYMQur6OTV+lJTqR2KlOy7c3Dg
         F0V6XeUNVvMN6ZfHGtsMczNCAVaGhT5alsKXxTj8cSgPpXn5OkiwYxaARIbys6E2A/ot
         TjH/SM4ZD5aiqYCLvMghelnoCp0Ihx+YIKqBSRmsMwfFzEp/fJmBrgLqScbNUo7LMVND
         tT1elShyNfIqvGFovOf3rmJBi1dafSSdU4Kg5gv9R2cAfB8fmV8rEflL2/oZ9ZO7d0Qd
         2uV7flhJNi26QG8s+eBjyekHfn3bgYE5LVmiNcCFA0qFIVqZxNS2NVi1lAuvoe4+2I3e
         38KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625284; x=1784230084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zb15/v0AHFmeW0kQkbL+9zs4AS8GOi3pByqyK4NR/i8=;
        b=fZ3nbolgBKOsOnQo3U7CLkUf6nEQMByViT2NfK3k3St0bigAnCaqm1PU5gKpyeyHqP
         4IuNthbZPrPV1hkl/vtNMB57AbMS5V6tNeF+z7/yKgdgNJcG0Kt5njC5qjgBSWfcxIKg
         KqSCxWWlfl4lfY0ejfA6blY2m+9j03CnnCiVFXS4hjgt/w85Z4hlgNiL4+tVcnSTP08I
         qSiBJXeBktgcXr/MP4vLBPM8nzE0zyDlOGA3L7rDd2ObgUUBSP7+imr+EO+I3eqKiS+Q
         jfJyeOXiybvddBeptRg4vpe6ld/Rw1K7LvP5g5im8bN2nmjZ6X14uW6kDbl2G0M8ucWv
         s2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625284; x=1784230084;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zb15/v0AHFmeW0kQkbL+9zs4AS8GOi3pByqyK4NR/i8=;
        b=eaW2vKnksgOUpRfwKtlKqs9mahoe52xmTltTjh8ZIt/5s50nkFqQVUkZ0z2mETYksf
         fgYTIGGpGBpZ8VkTSgf1sUZwfONuPDX6ZffYvxBl0l5WGLY0e77aAeZcBIsKhsgVX4/q
         oyXjr4cjyYAFhYIGlIga+fPxIx9F6Z6AzN1qrgAJK5Z80ZMewMLmcOG3Ua7lt/jkGJPm
         eFq/wTYRzc074Tgez6u5aS37A179auEXSoa3k5W+Fm6JdIFmrajl7waqtSqb0B+qAmwK
         Or7Jv0nHInvhAFoyiYjzcaR2OJ+CDx9LXPM3OIosLPRZ8eGNBq5FaEwnSRc2IuMOOfw/
         79jg==
X-Forwarded-Encrypted: i=1; AHgh+Rpu4aHjA6nRET8NSBUvLmKxvD9ssba08ACpQA2pXu+fpjr2jzPWCm3KAAcmjGBJBXH3+HnQjgDA@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhPoe2KB7mIRDUGJ4DlcocPbQK5KicnmA8FK22xK0Tdb3gbVR
	H927UGMXdEV+P5XEL8myCA2nzkbEw67xpxIeR/GglE8oVE8YctEXE+Yux08YTCv9zdW6nd2hiNM
	/sFpPPwB5LHgx5R597BKUh5Zqc7yqAATIMQ==
X-Gm-Gg: AfdE7clcWnu62+YoO2XUcNhvOxBP/pAHChu1OjOsFJNYZDp6WAfVk7JKULN8AuECKmP
	akZnQTMxFYHSXwqiMtGfTvsCGekPBjGO8HhN5KD2uTiJviIGVaFbHTORhGCsaQl22121+eOAgK8
	2U8fNNU/ydn5emYJeqRMUuTILFeyGhKPD/vvMz6r88ubohBiepk949DiRr0YfW7ClJILhk6cwbV
	TS4PCZVrrsU7kxs4ObZ/V/MyiOWLgxDz83dH+TrjkvKXrRT32uZi6kXbdJo5C+mRO0TruD4
X-Received: by 2002:a05:6a21:a38c:b0:3bf:6c27:38c with SMTP id
 adf61e73a8af0-3c0f131c363mr411628637.30.1783625284110; Thu, 09 Jul 2026
 12:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709063128.75873-1-laoar.shao@gmail.com>
In-Reply-To: <20260709063128.75873-1-laoar.shao@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Jul 2026 15:27:51 -0400
X-Gm-Features: AVVi8CdzfCxv_9sqXDHZIKzXUJ1_BCpFkNfTIAf8Xry2wAvXZHIqap7Tt57-o8g
Message-ID: <CAEjxPJ4-dAdgC9EaNRzm8auqTy=TAnF6Gp-q7JGqZ2VDGkvh3w@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: suppress warning flood for retired DCCP
 netlink messages
To: Yafang Shao <laoar.shao@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	kuba@kernel.org, kuniyu@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> When deploying linux-6.18.y stable kernel to production servers, we
> observed kernel dmesg being flooded with SELinux warnings when running
> `ss -l`:
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
> Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
> flooding.
>
> Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
> Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> v2->v3: check also the sclass (sashiko-bot, Stephen)
> v1->v2: use pr_warn_once for the removed DCCPDIAG_GETSOCK (Paul)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..8a9ec06e40ab 100644
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
> @@ -6272,12 +6273,17 @@ static int selinux_netlink_send(struct sock *sk, =
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
> +                       if (sclass =3D=3D SECCLASS_NETLINK_TCPDIAG_SOCKET=
 &&
> +                           nlh->nlmsg_type =3D=3D DCCPDIAG_GETSOCK)
> +                               pr_warn_once("SELinux: DCCP has been remo=
ved, pid=3D%d comm=3D%s\n",
> +                                            task_pid_nr(current), curren=
t->comm);
> +                       else
> +                               pr_warn_ratelimited("SELinux: unrecognize=
d netlink"
> +                                       " message: protocol=3D%hu nlmsg_t=
ype=3D%hu sclass=3D%s"
> +                                       " pid=3D%d comm=3D%s\n",
> +                                       sk->sk_protocol, nlh->nlmsg_type,
> +                                       secclass_map[sclass - 1].name,
> +                                       task_pid_nr(current), current->co=
mm);
>                         if (enforcing_enabled() &&
>                             !security_get_allow_unknown())
>                                 return rc;
> --
> 2.52.0
>
