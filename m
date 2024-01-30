Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BFC3F9CE
	for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603411; cv=none; b=ae4mqnYZ/+rO9fBJRzwtQqqktRH6FjhuBfVkBtTVXoTVO/MLuMncRJOg0IibPmKq47TrYPx0L7I2wcov1yir1FXPBXAZF3YG0KAb3wPFqvNHDZkJ1Ub94yZBGMvPG0VecyNMn0dqTP+bbtR+4Pdn80HzpQ9hcVlp5lhDcKiQxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603411; c=relaxed/simple;
	bh=LjR7Gsvrzq5Ewv00+x+riEY8MqHMvSKxj0MF/dqkZ+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBbe+IHNggvTPlwdVl8wH4b/cfOl4F3BwFT8j6fbfVq+MLxaripzh/XOqJoLZFFLZqhXYcymXOfpINy3J/4QiWWY7V31su4Ide0pL6PUGV//YGLlc6+luTbI+wTcLKT3e8EPvdvXo/keWEyyFxD1VH8J4ne2ftUMGo5MuzCqt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBM8Y3P4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBM8Y3P4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706603408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7lkwTI3A7BzKPumUSTsEz3dMOctiT2kqnU7YgTQgYo=;
	b=TBM8Y3P44MDfHD4I2oRrDMBIHdB/YWKy7LxZPliI2Gk1NReqMidEAyDLmm+nBL6MMsuZU6
	mxx+lJprDwiAg/aNZryIEEvSdvtELsG0pt3PcpI7fAFTyUWhowHT6fihumxheLomMG1X0c
	deyrWB6f1/NoUfvYkdQuKTr858EbSTw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-bZj-dpqEM2CtpVsuxN0Z8w-1; Tue, 30 Jan 2024 03:30:06 -0500
X-MC-Unique: bZj-dpqEM2CtpVsuxN0Z8w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6df2b37e6daso146204b3a.1
        for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 00:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603405; x=1707208205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7lkwTI3A7BzKPumUSTsEz3dMOctiT2kqnU7YgTQgYo=;
        b=MfJJ0gJAgqCgMcAAP4whrJVBT/S1Z1yFOv8zdSSA6/oWxivUxJhKpqgAb57XvfYsD0
         u4RPCWB90ZwQWtIWTQxieyme63sXmQkD72t3ON+DJ07KIRTf6dJVONBB1w9cGA5uOgDV
         wopkD67KUGWS1MH4lbBtDLDi40IVBgWfsbOhWiwnig+4faHFLb/4tJeyByMSQYplSm3M
         E661RTPsYT/MLp3r0Q6dVcMCNizmp7/TZDDN64Ht46zM8ghAa339ST/Nq5a0sO1Jmuio
         HKH26UjjFPFuwQzNOjtPz4avJ+CQzWZOLrtxB/UMtwbZEtPte2R11yoDcg5Gg+ypQvzE
         5Qtw==
X-Gm-Message-State: AOJu0YwBNz2Xjg8QIjwh+VB5t588f4IirnsWbkuHkd3ylFajM019ivRj
	JLgYwWdoM3Z+t1cV16QsxQaDynq/kR5sJTV/5t4syOJJpIBvk/82JHqbITSCC9LbSsAbB/3fdgy
	SKUc2c0QCjRstqnxwpLqP+cNjJG936OX144Kp0Zan0rXLPFyx0lJmSiLdOTZIN7910oIeoPC20j
	NpfBO/3HIuh9zhka/V5LvGESpCFiTyUg==
X-Received: by 2002:a05:6a00:22cb:b0:6dd:6caa:aecc with SMTP id f11-20020a056a0022cb00b006dd6caaaeccmr4469306pfj.31.1706603405385;
        Tue, 30 Jan 2024 00:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuvPhuqZi4o89CCeq59rapmp0fwpuiDh1GF6Cc1xFBi0IyyXGeloh0xS0UmqPHuvbEOaCUEZ2l/af9qQ6fMFQ=
X-Received: by 2002:a05:6a00:22cb:b0:6dd:6caa:aecc with SMTP id
 f11-20020a056a0022cb00b006dd6caaaeccmr4469294pfj.31.1706603405053; Tue, 30
 Jan 2024 00:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126184531.1167999-1-omosnace@redhat.com> <CAHC9VhRy2uYmfoWYx57P6dRcZsJHmgCmdixi56hUoO=YvOqa5A@mail.gmail.com>
 <6e98ef30-ba98-4e99-bb03-9878c50e957b@schaufler-ca.com> <CAHC9VhRv260QHLe4RWYCD62DRv5-b7o-Davn_A9J_ZHJhMiJag@mail.gmail.com>
In-Reply-To: <CAHC9VhRv260QHLe4RWYCD62DRv5-b7o-Davn_A9J_ZHJhMiJag@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 30 Jan 2024 09:29:53 +0100
Message-ID: <CAFqZXNtLPM7vWDM5CMeG9r+8kB=HcaFfh0ZCqAQy0jfBnE_XDg@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix default return value of the socket_getpeersec_* hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 4:01=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Jan 29, 2024 at 6:25=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > On 1/29/2024 3:02 PM, Paul Moore wrote:
> > > On Fri, Jan 26, 2024 at 1:45=E2=80=AFPM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> > >> For these hooks the true "neutral" value is -EOPNOTSUPP, which is
> > >> currently what is returned when no LSM provides this hook and what L=
SMs
> > >> return when there is no security context set on the socket. Correct =
the
> > >> value in <linux/lsm_hooks.h> and adjust the dispatch functions in
> > >> security/security.c to avoid issues when the BPF LSM is enabled.
> > >>
> > >> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > >> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >> ---
> > >>  include/linux/lsm_hook_defs.h |  4 ++--
> > >>  security/security.c           | 31 +++++++++++++++++++++++++++----
> > >>  2 files changed, 29 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_=
defs.h
> > >> index 185924c56378..76458b6d53da 100644
> > >> --- a/include/linux/lsm_hook_defs.h
> > >> +++ b/include/linux/lsm_hook_defs.h
> > >> @@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socke=
t *sock, int level, int optname)
> > >>  LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level,=
 int optname)
> > >>  LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
> > >>  LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_bu=
ff *skb)
> > >> -LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
> > >> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket=
 *sock,
> > >>          sockptr_t optval, sockptr_t optlen, unsigned int len)
> > >> -LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
> > >> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket =
*sock,
> > >>          struct sk_buff *skb, u32 *secid)
> > >>  LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gf=
p_t priority)
> > >>  LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
> > >> diff --git a/security/security.c b/security/security.c
> > >> index 6196ccaba433..3aaad75c9ce8 100644
> > >> --- a/security/security.c
> > >> +++ b/security/security.c
> > >> @@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
> > >>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_=
t optval,
> > >>                                       sockptr_t optlen, unsigned int=
 len)
> > >>  {
> > >> -       return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT,=
 sock,
> > >> -                            optval, optlen, len);
> > >> +       struct security_hook_list *hp;
> > >> +       int rc;
> > >> +
> > >> +       /*
> > >> +        * Only one module will provide a security context.
> > >> +        */
> > >> +       hlist_for_each_entry(hp, &security_hook_heads.socket_getpeer=
sec_stream,
> > >> +                            list) {
> > >> +               rc =3D hp->hook.socket_getpeersec_stream(sock, optva=
l, optlen,
> > >> +                                                      len);
> > >> +               if (rc !=3D LSM_RET_DEFAULT(socket_getpeersec_stream=
))
> > >> +                       return rc;
> > >> +       }
> > >> +       return LSM_RET_DEFAULT(socket_getpeersec_stream);
> > >>  }
> > >
> > > I'm beginning to wonder if we shouldn't update call_int_hook() so tha=
t
> > > it works for LSM_RET_DEFAULT() instead of assuming a zero/0 return
> > > value.  Thoughts?
> >
> > call_int_hook() was intended to address the "normal" case, where all
> > hooks registered would be called and the first error, if any, would
> > result in an immediate failure return. Hooks that behaved in any other
> > manner were expected to be open coded. The point of using the macros
> > was to reduce so much code duplication. I really don't want to see
> > call_int_hook() evolve into something hard to work with, or that has
> > non-obvious side effects. I think we could probably integrate
> > LSM_RET_DEFAULT() safely, but I'm wary of hiding these abnormal cases
> > in the macro.
>
> Yes, I'm not talking about modifying call_int_hook() to handle
> something like security_vm_enough_memory_mm(), I'm just talking about
> updating it use LSM_RET_DEFAULT() instead of zero.
>
> While we are at it, we should probably get rid of the second parameter
> too, @IRC, and just use the assigned LSM_RET_DEFAULT().  That always
> struck me as a bug waiting to happen if/when those two fell out of
> sync.

You're reading my mind :) I already started writing a patch that does
exactly that after I posted the security_inode_getsecctx() patch.
While working on it I gradually found two more pre-existing issues, so
I wanted to post fixes for them before the refactor for better
backportability. I should be able to post the patch today.

BTW, the IRC param removal means that a few of the existing
call_int_hook() calls have to be open-coded, but even then the patch
removes more LoC than it adds, so I think it's worth it.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

