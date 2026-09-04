Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DA481666
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526252; cv=pass; b=FuvoKjrElo9GLk1Sgt8qHAavgZvNSx2Xdl/bYojFHkCap8vLKtxBxfrrT8ZRcUfe+cVJ3U8xGnBqA4mc9SNygXYHjxZLl/QmVz7OPSfX6EkZGWXxPaRFTbCC2z4ax/kZmQvt4tiGhP0wyxx610GgQ8IzZvMQVsmgjZ6yyoLvZ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526252; c=relaxed/simple;
	bh=/zhN0MfZvN08DSisLYI/X0L4x1pd/g9nVyGnrVAvHEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L516vKOt9YZVJASDsJk1LP3+RA9kD64YRMdMZXL/IgrdvZ0If/31lcwicuB/OUYYHzL6N6Jp7tt3XEIi4mglPQNmsgz6X7gmtNpgGF8DiEy0df6D1WAo2j2Eh8at1kVwqEushdauNGm+9sCkfJGneq+79NiM703FxKZN6velFUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gssczFyf; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gssczFyf"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-455ca262ccbso783983fac.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788526249; cv=none;
        d=google.com; s=arc-20260327;
        b=L7b3OegkHcHsfYpXvbjmv7wfLiQMb8dO3w1q6GJwmo6yL3EDsSh5ms9ibFVzGLkwdX
         aQ+J8VXk74QWy1jigNniTEnlJviC6T/HyDtfTE48XTMKpdup13LY/4dC+VlOvDBU0aj0
         5LQ9pDVRv1qXf9ChD3kE6OSHUkL8Rn8dxqO2u6nC8IXLnbrfieGIg2LRZbukjMd/YSED
         LUccORiOAlIbUF3/luowPBQX7mf5EUkkf3pYNnGNyc93VFFzQDaagIxVS7qvQ4uJD6Xd
         U2qENBnRP7etvQtmf9XSzhplpfHx+vh2Fm9XkD1J+01hw/x14qB93DoCFwK477mA0vcF
         tnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBFn3QnPtK8nLKweJO+Nnf8PeL+sxam0hNj7RSxVxQU=;
        fh=40fFx+4osaXBi4FGYYsgKfFijKTYE9TLFR69NZRmuVo=;
        b=qcFx3ffHoGq1iyjM2TqvDJKqIgwF0/R9siORFbTTUR5bxFz6Y/GLhCYWSeCz5kRQa4
         Aiq3dDlxQBJ5ItKgxdEoxIncMFyu0UuN68KSK2T4USdJ2itgYPuyTEA13/YYmUWrwkcb
         +1mljWr97iudmXu7fFtTjUI0n6nE+K9I/PBZQH1Yj3VcfCNr5cEZlO38q34V103vm62H
         TMqxvuohO+TbG2wq33iSugsKRfXce2BVTLOcQnTQuvaJy9dqDqVmDDiZVh1kIOkZgNR8
         UJQechH7dUSfhRKwtNOXHDdUAmxDG1h6UcKHvKRB3HzzYIi5UViqaU7H3zAnVRP3KX7o
         AugA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788526249; x=1789131049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBFn3QnPtK8nLKweJO+Nnf8PeL+sxam0hNj7RSxVxQU=;
        b=gssczFyfJNxCDZUg9oL0agLMIDQMIi6XIhqNiaWOA5dI5qDyTc2tSiDLq9Mg7NrhSe
         R4N199agThYv/YET2kIZ39jjlHe7dT8NHAzuXs4ebsi81Ngdc6U2fyibLveBhdPuczR/
         RoE7T3w+bna/51dbEkCuteevtJXVs/G608JBh+UUubI4gkVaviC3n4TlNBA5lHW0AR67
         J9iAiGKnMcRSkHobtO6gK83KJqv0g4BT/LHAAeV8eC96MdGoaDfT8ekm2HHkqSNbH0HJ
         1xAdYqeDyxxUqcjpRfWCNrgfenqHS0TKwycyydD+CbpRHwlHioDPYRM3Kvfka68gRpRS
         tFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788526249; x=1789131049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBFn3QnPtK8nLKweJO+Nnf8PeL+sxam0hNj7RSxVxQU=;
        b=ACnvI2iAiIRuteDqm51lEwFiLYJeKsyTdyGD6cDRxddfSs0Ifn07TJcDB+GqCgSq9c
         rNRj14wwaMapUM971qT6FXC96YFhQ8slySDjHt9dB2R7spsQDew4vy6C/epDpM600Mw+
         0ElJoOiunetlavpigi7TTS8motkJ+jUY8MlaezA/fJtr3DLMEfr1GWHg0sA/yY0yWxB4
         wW2lCULJ6Q3bUWP/j7derNg6tT15GLRCZEY96iT8uOJuPZJPIYk0dSEnN8zp2cyDT1xR
         ZWfXT8xdalJrWlDaa9MTfFnM2LlHaTmN8Q+M/k+IAM14dp7Wuwvjx2eupuzeQ8uam0Yq
         6LNw==
X-Gm-Message-State: AFuF++msdNV4qj4Ns1ervsr4h4fyczrmoRtY3jr3IHwptDCzTBgscJON
	T44Nej7AseCEnjOo/ji3XGVsBBej4rEjzlgoTTIi1/zgk599tuCpVgNbSRiH72FUWcgskz2xvo9
	3lnA19LDRQzAqX9wPSNu3EpDoy5Jan8s=
X-Gm-Gg: AYBFou1lL0TBAkQQgu4X74W7/JyAc9Zbty37OQTiQkZybZPpe3sduAZcVbOLVCj1ePy
	C5fpNj/FZZUDsJ4XG+aZdO+u6Wsu+YscJKzmv+nQqeagCGCd39dhBm1+QkSHzyJDOPvIYP9cLP7
	n3ADEo1NhoHRDwQgwJDZvodNmXwpXbBoU3nAX51dd20GV87WX+nsiz9uU1VG3L2iMhUvoIeu/CT
	zqNS2l7jQeW6KV1neDgOsd7XHoekTM/OiguW8gmmZD5NWezbSFwbNCq0ucP2EYzfSb6D2uzKxPy
	/l+o4SwEKD2dRbMPj4KsAahK5l3oZvhilV23HavGkiYfD4KwpRmNYTw=
X-Received: by 2002:a05:6871:a861:b0:459:f9c0:995a with SMTP id
 586e51a60fabf-47551709b76mr4535051fac.14.1788526249280; Fri, 04 Sep 2026
 05:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com> <9b2939c5-7935-4d2a-b628-6c3ba961e16f@suse.de>
In-Reply-To: <9b2939c5-7935-4d2a-b628-6c3ba961e16f@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:50:37 -0400
X-Gm-Features: AcwNN1Vu9jpv3XPapEDmpAYNuTsptjmdvcXpMXKKvuAHBUNTzJ0o96tvPlnx0k8
Message-ID: <CAEjxPJ43LV4CHSCLc9mxvBJEOAY=+hYMZ8+8-cRvpWDTPmqqRQ@mail.gmail.com>
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before xperms_ioctl/xen_devicetree
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, jason@perfinion.com, paul@paul-moore.com, 
	Johannes Segitz <jsegitz@suse.de>, Russell Coker <russell@coker.com.au>, 
	Laurent Bigonville <bigon@debian.org>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:40=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> On 8/31/26 8:01 PM, Stephen Smalley wrote:
> > On Thu, Aug 27, 2026 at 9:49=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> Drop support for kernel and module policy versions before the
> >> xperms_ioctl support (SELinux kernel policy version 30, modular policy
> >> version 18) and xen_devicetree support (Xen policy version 30). Kernel
> >> policy version 30 was first supported in Linux v4.3, Xen 4.6, and
> >> libsepol 2.5 (20160223). Modular policy version 18 was first supported
> >> in libsepol 2.7 (20170804).
> >>
> >> RHEL >=3D 8, Debian >=3D 10, Ubuntu >=3D 18.04, and SUSE/SLES >=3D 15 =
have
> >> libsepol >=3D 2.7+.
> >
> > Would appreciate any feedback from distro package maintainers on
> > how/if this change would
> > impact them. Link to the original patch for those who weren't cc'd on i=
t:
> > https://lore.kernel.org/selinux/20260827125511.19408-2-stephen.smalley.=
work@gmail.com/T/#u
> >
> > This would break e.g. RHEL 7, Debian 9, Ubuntu 16.04, or SUSE/SLES 12
> > if they ever updated to a version of libsepol with this change but I
> > think that's unlikely.
>
> SLES should be fine:
> - SLES 12: version bumps are unlikely, only backporting of patches becaus=
e everything else is too risky
> - SLES 15: everything besides 15.0 has libsepol >2.7 and also unlikely th=
at we bump the libsepol version in 15
>
> > The greater risk is if you have any lingering binary modules compiled
> > with versions < 18 inherited across multiple upgrades (e.g. RHEL-7 to
> > RHEL-8), then those modules will break and probably in a not-very-nice
> > way (libsepol suddenly won't be able to parse them and therefore any
> > semodule/semanage operations will fail and you might have to delete
> > them manually from the policy module store).
>
> We did not support the policy that long, so I think it should be okay:
> SLES:
> - 12 -> 15 no policy update will happen because in SLES 15 there is no di=
stro policy shipped or supported
> - everything else has libsepol >2.7
> It might be that 1 person drags their SLE12 policy to 16, but I think tha=
t is not a supported use case
>
> SLE Micro:
> - started with libsepol >=3D3.1, so should be fine
>
> But generally our built distro policies are unlikely to be inherited betw=
een versions from SLE >=3D16 + SLE Micro >=3D6 on, on upgrade it will be mi=
grated to the one that is built for the upgrade target
>
> >
> > I'm fine with deferring this change to a future libsepol release after
> > 3.12 (e.g. 3.13 or later) if that would be safer for the distros.
>
> I don't think it is necessary to delay from our side, thanks for the noti=
fication.
>
> Let me know in case I am misunderstanding something, thanks!

Having heard no objections,  I plan to re-base and merge this today.
