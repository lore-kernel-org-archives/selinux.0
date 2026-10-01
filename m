Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B9253951
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872696; cv=pass; b=iAHTAcWK95mjTdPOmnaqhpNQ+6mjd4RDzOHTJAsILxicFwkEifi/62tjh6GsItjfDri5+8RdU8Z1efpezT3c98lFj0sWE1ktehtmsE19uBVsKadvVfriZDSsaY1476MUAd+8D1JervP5ktAeaKKdhWwDObPISJN/HYUDS4IMx18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872696; c=relaxed/simple;
	bh=zTzFHP+jlHeUdEQ5vb0ZGqSBPiDfPT/kEkT+MC7FqqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6hUVRDCXPM1i65bme5Buqu2Qv1839vColOdizPwpWtdIa88a0ewbz4ryKceH0tbiS+uuGoZHeTzxa8vtAJ8segGowAiwhT+865oGOH/ARp13SpsGhhqCxoLlsatCuNlupvZAojbVMxpG1WJxyOyz/KoQ+1zTDs2GHgNahmOeK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0zwbtj2; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0zwbtj2"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so70284807b3.0
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 09:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790872694; cv=none;
        d=google.com; s=arc-20260327;
        b=CreC7+WiSCaYEPYQgP+H6gcougJP5bU68E3YYWjGwKxASwiFWVYTCTAgaopTh1LXeO
         nW1PnpcqkDCrYVdrjy7aNwRgf/yI7JpcwAG3FyPHd1CO+VTBvhbLOuOD0Ogr+51F7aDe
         q5DFhycFnKB/w9PyfZyCXeCb8kN6V2DSGX+uDgBrO7pju+cyZ80PlljwnwdnRMwZatXh
         y1ehmMhe5+GqM5xme8SXxTNJIsP9xLREV4ae3aiZPRaQ6RgCV1pnaRt8Ml9dIehBmKAc
         qvMHDDl9n31MsYAn/SoeK9kNQEe6KKQywMtUYXQVIlR3xu6JwwuA9wFyjmPnAOBZUXHO
         6Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQXuuhnfvTeYpPkQ/vLVbCwdQc1Ux1adrvIel5vGZts=;
        fh=f0d7tAu7BOkiaLEIU2lJ11FX5Nw0xORDdFfhziE/xIA=;
        b=LInlCaEpoJF9pVtWJ77B9LGqyw9kutoM3mJMJ+u+2+KDJGGNHsFALtLLLLmH2PdrnJ
         xvUSM4EcujsaMRkqPxz8D1b6ZEaSJbXsh6eheHKdg8UkVc7l4Q5d/nEJktWLkRt205a/
         AxXK6sYPfqACYG1O3Xphq991aZMra0VY79kLSLuiP6LwKhVSXkxrbVNNtdnFN3HV43hW
         YW7+ovGkFLbLXXX1sKuOkpql9egPFqO28AhMQ1mVB1HEwfIRhUHpYG75ICvx3CStd7is
         bsKRfFRuTKGbimR48WaCOD4IWZ2ZSnNvHWOT95bsXOQuAkMRH17FHszxVnXsmMkRlgvG
         q5Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872694; x=1791477494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQXuuhnfvTeYpPkQ/vLVbCwdQc1Ux1adrvIel5vGZts=;
        b=p0zwbtj2iMdxEh/A5vyx+HjgSR5La6BfqoMiH5mYCyIL7SPycfOwxsNRkKpQd6fCVR
         SAjbTLXSZC2UDWklN+JlivAc9Xtfz+y5g7IJ6onnyoG5xWsXLBNH6V/CATcWqxgQ0cB1
         AleETTEBOSE1qLEJgtMUmeWlrS7RdLXxXEUBRbkTxR4FaOL4HwIVtu13enYP98mmlfGo
         z6INaT1ysaqe5X6lVryLh90S3PiHnltipGLuak0EUm8kkGkdnpG7aE25Cb00aAUPdw4a
         zZJZh2pPi7+mBoCD1bsrC9sRR3nBrccTpdfXkQHx2hIFodzCmz0ugVpGVQ4V6gyaMU/T
         6hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872694; x=1791477494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQXuuhnfvTeYpPkQ/vLVbCwdQc1Ux1adrvIel5vGZts=;
        b=OfUno4NE2G9cx+LGlBxtUSyFCYVAq8quRHvg9QNGtyszSepVRVsGOXKd3voNboVd4/
         otLsYxKeeRqqBRJLhfotE6ShOeli1cEM886NbrKJyk3zGmh/tjx1WzWp3vjja8PAunhr
         r/Xssjw++CEMaZ4kCGR6mJx28WKuXRUy/CPj011mnVybdZJGs8WjP66Df6vAOiDCCe5/
         QvG0BjpymCOn+Bz7AkNXtcc/qV0VrFr8/WJyPo/3GwfKohdDSOJaRKbDOcbgr9mBCE0A
         H9Uo/iEKvdr0lBqjBCN5xg4ZKunHqp3CUvaR/mdBjlWkG0ZEKyKW/IRibqmrg+Q7aLdp
         GYtg==
X-Forwarded-Encrypted: i=1; AKwUvBxxoCUzI37sHp055/82E010/1VwSXkUp+NmvcE/qhpdaWlkPEhOOMW2znq5Z4pjZKjb24disKr2@vger.kernel.org
X-Gm-Message-State: AFq9FYLmqoqTqQA+gxnWsjFnHSXo9Ba10fC6dfsRkzwWQ7AkU5YZy0+t
	UbPk1GppzeB2IRRdg9GKiNMDJ+eCJwd7iz8RQpGfkbO1V78vu8pfGgujGgPpks34VNtPxA4QQLm
	kHEZzNSf3ndWRhrDA04ZB1D0cfnUYybw=
X-Gm-Gg: AYBFou09kEb82TKo4UdFBsO00D9ioGWHRgnO0QXZi8sMC6VUxJfOX39CJy3KnQgg5EF
	uchAHEDI50tHBgR2BXid1kJE/4op1b/gN8kTDiCpOyB4IiB3GF/P8ORr3vlXIJIUWZrQf0gcGk8
	a1k4h+QbdqBKN7/7IzVuMAbh3IbzmtLA+gW+66ZWf7kHIKBFp0OJxiPvp/KRoMUoE38DZvH04Vz
	Ds28zfRkFT8A4L9YYvgHHNtNg892G2owzaXY9zINO3LXhQ5MqhMEMJmmzQq+68wbN43w87siOXZ
	jFVflgiZQf/GtGgPs2yVlU28TtMkVINfvGlsaA/UKwSToZYEEHUfXVA=
X-Received: by 2002:a05:690c:6c10:b0:873:5c6b:a310 with SMTP id
 00721157ae682-8ac948c849cmr22214287b3.62.1790872693677; Thu, 01 Oct 2026
 09:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
 <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner> <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com>
In-Reply-To: <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 12:38:02 -0400
X-Gm-Features: AclHuK96-5glJSr8F5qL1SZIZo6qNIPEama9zFWhTW_-k1WBXGLnbo55O8cQqZ8
Message-ID: <CAEjxPJ7w-8J37OjPUNzLzofbPezq41yK_GtsZJxRDNbDRZnw+A@mail.gmail.com>
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 25, 2026 at 9:58=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> > > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > added a security blob to struct ns_common and allocates it from
> > > __ns_common_init(). Most initial namespaces (init_user_ns,
> > > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > > however set up statically via NS_COMMON_INIT() and never pass through
> > > __ns_common_init(), so their ns_security pointer is left NULL for the
> > > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > > dereferences its slice on one of those namespaces (for example from
> > > the namespace_install hook when a task setns()'s back into an initial
> > > namespace) will fault.
> > >
> > > Allocate the blob and run the namespace_init hook for each of these
> > > namespaces at the end of security_init(), after all ordered LSMs have
> > > registered their hooks, so every LSM sees the initial namespaces the
> > > same way it sees init_net (which is initialized at runtime via
> > > ns_common_init(&init_net) from net_ns_init() immediately after
> > > security_init()) and does not need to special-case them in its own
> > > ->init() callback.
> > >
> > > Provide a ns_common_init_security() helper in kernel/nscommon.c so
> > > that the list of statically-defined initial namespaces and their
> > > Kconfig guards live next to the rest of the ns_common
> > > infrastructure. init_net is intentionally excluded: pre-initializing
> > > it here would leak once __ns_common_init() clears ns_security and
> > > re-allocates.
> > >
> > > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> >
> > Seems good to me,
> > Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> >
> > I'm waiting for Paul and then I would pick this into namespace-7.4.misc=
.
>
> Since we already have the other LSM/namespace patches in lsm/dev I'd
> prefer to merge this patch into lsm/dev so it is we have the core
> LSM/namespace patches rooted in one branch.  Going forward we can
> stick with the topic branch approach.
>
> Are we all okay with that for this patch?

That's fine with me.
