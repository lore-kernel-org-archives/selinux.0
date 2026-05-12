Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9B368D42
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613493; cv=pass; b=FrUXNhdVz5I+j0RpVVma7l5QFuwH/9zvKjlCxgX+qnVbX27TZZL9230YrdH7Tl1n/yu8LvFS0V4uXApC6rDTFzUB3rrV623vjuVSBA/iRS596FKgQMYiA7CVUur875iYBfJEOFrJvvbF2qSbgYa9j5ZzY8TfPUAr5mp5tDzKe28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613493; c=relaxed/simple;
	bh=x0EJ9IIQlmLp0s2Di6cqa87rcp0GEiNnoqauM01YemM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5YX+FLFvdVw+TO+MPVi6zj0XjdUR4K/S85halxLvrJ9XPLxBTP/UzH1t0MGwls8+7tKxhb/yQPOcpDzofN8aO5/sVxuzjQEmoqN7k5cp1xIdLo9x6nxvz8owoP6dF6NGc3/LpX0czxCF0hGsvmi1xXggNfnvRfcit/kvlwYtFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VzaSG/zY; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VzaSG/zY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba6485d219so38844825ad.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 12:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613491; cv=none;
        d=google.com; s=arc-20240605;
        b=WK1qneCn9GG3/QvXuMDIwxS9CP/WjIJI7zrtK7ylx2lgywTD7H4v69PrSt/7Wy5wco
         E723L0npeKT52cYxepNC6HGjXkyICsOXeq6DkcmC9RYD2SI3ooQwoWwWm5SbHXFWOdAs
         O6p/bmPcY092C4TfcQ2Yr3goI5GBsJy2r3cAQ9ru2dkT9jID/vNl7D04bVVF+XjKyezr
         jnrPHYiOriZAwWHVXxUvjTBmymErOgn36q6RFwRIYgP6rOWPUYq5TRAKtnlRA5J0V4ql
         VRrSMGQiHfQwZMQfSvX/S70gkMDHTjJgoad6qrTsG9fbokVwaNZDtGdJJ03fYSLPOUbS
         ZPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EvRcW1Qh/576NOLilmJxxhESnWbBM64hf3VFbtNvDPg=;
        fh=t/I6j64kgHfLh5efk1GRoLkEwsHVRMCvelxj6drWAQg=;
        b=DDb+kDcqqM17Y44kUb2rxDnjlo0+ul+doxlDNA4KdqwAwmyhWIUb2B5JfuSYuABlY2
         mIwZgj6fJ3dHaoeA3uvScoIbGmhrg9fTvp5b/LpfxecpSZ8cwUqi1GSptVWIowNnGYNI
         IMNuWSreyHWmF3XfLY3lpZoXE2YPRCvrz7j0y797SY25OzDGjcG3wOpY2tFEBQaSERZ1
         J13hZhk0CgYx43JBJ17znHtk0h9JuWktLS9wAeT6prFg3IAg9ZIFczqeroa4w1keNVdc
         Yh1PlWbkNdkKrA4pECPxGTHjNSJm+jog2q0Es0oiAr3H0lfssv/4cbE0HYXN+744nYQD
         FYLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778613491; x=1779218291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvRcW1Qh/576NOLilmJxxhESnWbBM64hf3VFbtNvDPg=;
        b=VzaSG/zY21rzktdtMYdicKzLpl/YoFm7iv3uzlED+W1CLf0OX7D9vnHpRbX8v/JN8O
         0QO7LwC2GJ/CqzCCfVtawFHkZplgFF/LgAe65N/MQSGAczPaFltFEbxseJrGd5CW5W89
         rAdQJj0e/w42EuDkCHdNePJV/wlZZfSB5NjaRAkx2XXTA7lp4WXvHiUvFpsBTVbxio+/
         tSxgNoli+vuOOfFJZeAceCHCoPthBWLCqDu1NTh2y3a1RgsgOUD/AtkoDdwIHEGZndvN
         j4WtdPqsKhk7Dt8z8XNFaQ0MKF2uKSDeIa8+7uC1ZTVE1s8ZzgiK5kuAMKgZMvhAKfzC
         QPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613491; x=1779218291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvRcW1Qh/576NOLilmJxxhESnWbBM64hf3VFbtNvDPg=;
        b=Lu9A7wX9V1Edp3XL4TZ+0abWpsraoYTOHvMzD5OETXEfqK6Cgi6KbFOKwx3wM6ItqB
         HNeXtqHtd89yeNFafjgNvVWsGRRjcxQRVsq4hTukVDbB6jNar03HzvrxRaPgiTutowP0
         MvbusKtho60ld9cZ78JQI1RtKsc6AfwEtXJ7LtwE5cv2WYgbizKUEQ84S3xpS9q/+IAX
         4NXgROXkp9GdsnIC/lD2o5xyD/H4ALVnbh0V+8UvEVJpKAw7GbSMuUzwh4na4AHybLuZ
         Umxrr23568QE1aXDrAw0pBr5JDZCpKJmdSoWCCviSCKQRfb2SnmVkaAag+ybKzbDxprA
         3LLQ==
X-Forwarded-Encrypted: i=1; AFNElJ893tPuI0FYDUc/nDANzFiMXYvHo0jzdotvs1807YImoH9PdXEK0BE4xIBJl0QdI5t61LfAMmDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhB5f22D9tzOQP/iIXQCFI5GXTSrCu8S0hTDcjLDIuLpeN1r+
	i7wRn1cug5fWG6bfP6WTB0w6EH3EGrQpTSdkgSer5w7pzt3KU2WMjVvtFlqlA8gdls8v1dSLvng
	NyqWFCAkIH7cxhc01UdtMGflQLTVTPl4T66XPOKf5TheN7q8ZCTQ=
X-Gm-Gg: Acq92OHdFUXaQRRkxHnnGu39nCMwA5peIuNon0phZ132cxjai87lJmXseeUAHu+0cjd
	zSAXncZTDnkLlwxLFNBHtBZRkMCErbAkQ9RbcxX6EVWXP88wJEgFhlroKddq3subzeirKZdMUoy
	GygmSNdg0XRQmK0ngCYlYWYcJfgLkqptt3bGzve9hhO2DkGDerGxFHvhw/zPZ9uwpkQ72KRu/2F
	3RbOLa4eQtCAl+I7euYJlEZpCvx3S3ayg83b13RII8VVMKEwtDF5Al+m8NR/TQB0S1blo8DXkN/
	QN2wmls=
X-Received: by 2002:a17:902:ea0b:b0:2bc:6784:525f with SMTP id
 d9443c01a7336-2bd2711a4e2mr3804045ad.15.1778613491141; Tue, 12 May 2026
 12:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org> <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
 <agI9Rdi-72f8dNbB@altlinux.org> <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>
 <agJPqiSKvHrrg6Qn@altlinux.org> <agJajS11YK1XGB-y@altlinux.org>
In-Reply-To: <agJajS11YK1XGB-y@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 15:17:59 -0400
X-Gm-Features: AVHnY4IItDSDQ_dFikFYv9ElTowZ6XiRLaS1GWsgcMI4Py0or-SaDs883yt9alk
Message-ID: <CAHC9VhT1d6xSboPErjrNqx41YefJ-fzs+FKnF5hDAhCWCGMfdw@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:43=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
> On Tue, May 12, 2026 at 12:54:21AM +0300, Vitaly Chikunov wrote:
> > On Mon, May 11, 2026 at 05:49:39PM -0400, Paul Moore wrote:
> > > On Mon, May 11, 2026 at 5:03=E2=80=AFPM Vitaly Chikunov <vt@altlinux.=
org> wrote:
> > > > On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> > > > > On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altli=
nux.org> wrote:

...

> > > The patch below is what I had in mind (although be warned that was
> > > just a cut-n-paste into this email so it is likely whitespace
> > > damaged).  If you are able to give that a test it would be great, if
> > > not, I can throw it on the todo pile.
> > >
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_d=
efs.h
> > > index 2b8dfb35caed..12724e259900 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -298,9 +298,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned =
int attr,
> > >         struct lsm_ctx __user *ctx, u32 *size, u32 flags)
> > > LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
> > >         struct lsm_ctx *ctx, u32 size, u32 flags)
> > > -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const cha=
r *name,
> > > +LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *nam=
e,
> > >         char **value)
> > > -LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, s=
ize_t size)
> > > +LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t =
size)
> > > LSM_HOOK(int, 0, ismaclabel, const char *name)
> > > LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_con=
text *cp)
> > > LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
> >
> > We will test it and report, but this may take some time.
>
> Before trying the full system boot test, I tried to reproducer I posted
> before. With this patch applied (just ensure it's correct) over v6.12.87:
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 9eca013aa5e1..b38f6194699b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -288,9 +288,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int =
attr,
>           struct lsm_ctx __user *ctx, u32 *size, u32 flags)
>  LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
>           struct lsm_ctx *ctx, u32 size, u32 flags)
> -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *n=
ame,
> +LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
>           char **value)
> -LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_=
t size)
> +LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size=
)
>  LSM_HOOK(int, 0, ismaclabel, const char *name)
>  LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
>           u32 *seclen)
>
> 1. `cat /proc/thread-self/attr/current` does not report `kernel` as befor=
e.
> 2. `echo > /proc/thread-self/attr/fscreate` process hangs in R state, wit=
h strace
> showing infinite loop of
>   write(1, "\n", 1)                       =3D 0
>   write(1, "\n", 1)                       =3D 0
>   write(1, "\n", 1)                       =3D 0

Bummer, I was worried userspace would be expecting something, but wasn't su=
re.

Thanks for giving that a test, it looks like we'll need some special
handling for these hooks (which is okay, you'll see they already have
special handling if you look at the code).  In the meantime the
workaround would be to place the BPF LSM after SELinux in your LSM
ordering.

--=20
paul-moore.com
