Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCB264FBD
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424195; cv=pass; b=r2NpX1v8NUJ5ZtPRo3DQ8pmARCLCpLzHnr15x3tToMEQJ5293ZPqz/ZMacak5C7CuXV3L/u+DPfvWNPf1Nl12DV4qbugMavUqFmyieSaThDJT3HkrSaZlaWFaPv8otKWjelXVwZbjOFblbyTF2iKDWmiXrzrozYa18YcP6uO7Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424195; c=relaxed/simple;
	bh=Qs9cFPWCqtqfwCSNceD61xYsMwhXvWo3DCXGh7lKjSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj7hXTPevFc2b2NdwrC7ijOj8tJG32UHwc9HAqlAmMfWEJFbnuTQmUlVUUq9bA55m3qPohYJoP8eWYxHAsXeYynibvyjXfwQPX0dcuXnbmFT9gx0WCTSoH8+StJjlDelNhMk7FeLRcRpjiZJtTq6GRUOTAZXDGRMgFEhVoJpDpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0si+9HS; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0si+9HS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81d152c1c39so275047b3.2
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 04:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783424193; cv=none;
        d=google.com; s=arc-20260327;
        b=XKVgG68qgpqh3sOIKcJT6uvA0mtKVATjvEM+q0ig4AL9MEcZufCxz2dBvxzdA2Bm0t
         tecGZrCq17LtO/OYVaXnU0alvEWIywWXTdc62VqGUoUFipexDMHW6NBpcB0R86HyTR8+
         NI4xMwkXKIyxGbA6b04oR2G544Wz5HlRrfqTp9RzhJN0/o1vJ0qpvZUwQnO4ATcD6vay
         uuyWwf0DFSRyJF4G/sG9A9yP/JXp22tkKzqsmC/QJEARPAJmAQBOLkEB5JljzcdCBITw
         DTTvPpdbZurpJfb7gtW0pN0SE8GqiV+Om0JH6e4hSjvbZ28t+gjN40SXG2ZMQ476qSzr
         WlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yH2E5FpkVURbeDLXqegftH+YinOWPeAl4GxkKT/Wwk=;
        fh=IJQlOYxLXnoUKtuuZ7g3dajCPXUywZuo0KZu8MpJpRA=;
        b=NsW5fAilhJB3CGLoX6Z1Z+axfePxKXyDJKNPGvJ3RARaxtmCRE3B53xfzeeUF1k/pc
         zG8UK5IDteOPMKFzPFzRB0Nf5wvBbp/bEjxiNgCbc3I9ii0p6OLNxi+zGsRR/v0JZyKb
         8xaNX1eiZXVfp55AWWRL/NakKBVJWJf6Un15bhuGxyomHlkPsDqUhAlM7dnmi5xuYYSA
         vg8mlUk0MSN3l9w5u0JL2BqHKlk9zBtmOd96rIxIAxIzaY6DAsnnY3dq6kJxXAR8GVFw
         WE/uwHLEdeoke7bs3Ptkox/hPrqIxzmJxfPnkS0x8PKbF6JuOM+ibsKSoQuNmVub2LbC
         ZIXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783424193; x=1784028993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yH2E5FpkVURbeDLXqegftH+YinOWPeAl4GxkKT/Wwk=;
        b=l0si+9HSjeKvhkGXFGDWsR9sNzBOlPY36cr8lOoZGHzREpQZLvMpg0IHDOH0mizmG7
         4UgGP4qqJRmrV8Pb5R1IaPhXPHQdd5w7DzQKeoloP8KYbekDqFkCMWjs4THmRJ0EBx8+
         Q4LmpFrpwDp2xNJEMt09FPlqZP/yc/vxwmGgc7mKgjAASrIbl2p+8abHZdsgxwSBx/z6
         FdS5az0C/pPORCsyRIAfeMtPVVGi/ba5qwHB569y+p2XUbv8GDQCmgA4BiQirzMk1+xq
         oV6h7TkIQxbmSc//YRdCfhry2oY8UCDwIk5ZmQYAVFxPV1cAjpWmnVccxN2cv1D1ojM+
         6ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424193; x=1784028993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yH2E5FpkVURbeDLXqegftH+YinOWPeAl4GxkKT/Wwk=;
        b=nYzClJp2i8C2wn5hcNYOKB0F0zve2JFTMzBXNS8DrNLVqSW5uGR2XEUPzuZ+Tft/V9
         /pRHjrR/GxRWMLBrIQFzfJkE3Jz7As7bYE8+8Hn8Pt0yIv5DrpsrzK/82+Nf1DxC8Mjw
         gePMloWvKEOcPeVdXH3AGcnfTfoHX/1AIDmQuBG4LFNMGnH2C8UpV/7eCIK84TwUolbi
         EcuFrZB2hp7elxMaS0HQLvkObLmXe327+RozZ4hsYS2soXffT9s4YRUYyovOSNQb91H9
         LM3A48S4TfycZXLaZuTVoco7iiOpwkruTzhxkFIk1tSAKD2/sK5tBUh8K86ys5cDrVBv
         YD8w==
X-Forwarded-Encrypted: i=1; AHgh+RpbkSHlsfcfTptd+MhHg8a/n7dRk6GqixAGe02q1rhTqa9HvWYa2M4y9UVHKO1Vic6JEoORH1gR@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9jR/tduaM4duy1SvgWQOJIjQW7NH2q0onyiB8sc976Jpjtqq
	YvLG2KCCMc+Xl+5wET/UEj3tpfMN+Vy2x/quwXCK+5qwBnT+kjZkYZMb3muBDr5wTJw2UPNxiYz
	AlSHg+cFxoCzL9OB8mkXTKBRuC2zSKYE=
X-Gm-Gg: AfdE7cmMXklKn6dPNtcNTJFZFFKsX45k0lfHrmavBs0ZXwW6RzfRzzEpoiC6+WniBt0
	0xDuGPKP/PCPjkuAXaHqug5UGcYU8C1VZL77LBrWvBMDCSMga+D/VXVht9j3eeiR15sxJXex19N
	mlOCt7kxuizydpvbS4dvmmGt6LfQcbiUsM4T0TDBWL+YH4nkwrCZQXB2fa7tmAmgjgs44Q39Wi7
	r6+C6VZzLiUJtqCEMxdHz8hHhdHK4f6kPzjFnLOOybNY375J4+4DXDQ9uK/fcPEaJKOjL+UGXoj
	GIt0d0MsHGpQQPiIyqzRCYSCmiyfSg==
X-Received: by 2002:a05:690c:6012:b0:80f:ddab:1cd7 with SMTP id
 00721157ae682-81be1e3d466mr38146937b3.25.1783424192708; Tue, 07 Jul 2026
 04:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703023030.94417-1-laoar.shao@gmail.com> <CAEjxPJ4TSQh99e_Wdh0c=dzO0RB2zOaFGeeUKh6_K-jv+8t2=w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4TSQh99e_Wdh0c=dzO0RB2zOaFGeeUKh6_K-jv+8t2=w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Jul 2026 19:35:55 +0800
X-Gm-Features: AVVi8CfxWRO6AQL14iVKlejIe8H7L2UGJ2iE559XsQl0zGlwFEWcBPpMHmbjbNo
Message-ID: <CALOAHbBEjH_HT=Z23aDzUfvVNHOqT-sPk_ofY=R=98jF__Xksg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: suppress warning flood for retired DCCP
 netlink messages
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	kuba@kernel.org, kuniyu@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 3:10=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 2, 2026 at 10:30=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > When deploying linux-6.18.y stable kernel to production servers, we
> > observed kernel dmesg being flooded with SELinux warnings when running
> > `ss`:
> >
> >   SELinux: unrecognized netlink message: protocol=3D4 nlmsg_type=3D19 \
> >     sclass=3Dnetlink_tcpdiag_socket pid=3D188945 comm=3Dss
> >
> > The root cause is that DCCP support was retired in
> > commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
> > DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
> > nlmsg_perm() to return -EINVAL, triggering the SELinux warning for ever=
y
> > `ss -d` invocation [0].
> >
> > Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
> > flooding.
> >
> > Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0=
]
> > Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  security/selinux/hooks.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1a713d96206f..9541cb674d61 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -94,6 +94,7 @@
> >  #include <linux/io_uring/cmd.h>
> >  #include <uapi/linux/lsm.h>
> >  #include <linux/memfd.h>
> > +#include <uapi/linux/inet_diag.h>
> >
> >  #include "initcalls.h"
> >  #include "avc.h"
> > @@ -6272,12 +6273,16 @@ static int selinux_netlink_send(struct sock *sk=
, struct sk_buff *skb)
> >                                 return rc;
> >                 } else if (rc =3D=3D -EINVAL) {
> >                         /* -EINVAL is a missing msg/perm mapping */
> > -                       pr_warn_ratelimited("SELinux: unrecognized netl=
ink"
> > -                               " message: protocol=3D%hu nlmsg_type=3D=
%hu sclass=3D%s"
> > -                               " pid=3D%d comm=3D%s\n",
> > -                               sk->sk_protocol, nlh->nlmsg_type,
> > -                               secclass_map[sclass - 1].name,
> > -                               task_pid_nr(current), current->comm);
> > +                       if (nlh->nlmsg_type =3D=3D DCCPDIAG_GETSOCK)
>
> sashiko noted that checking DCCPDIAG_GETSOCK above without first
> checking the protocol family or security class might trigger this
> message on a different protocol family instead [1]
>
> [1] https://lore.kernel.org/selinux/20260703023813.13B611F000E9@smtp.kern=
el.org/

I will update it.
Thanks for the information.

--=20
Regards
Yafang
