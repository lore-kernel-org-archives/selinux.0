Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216A46DFEB
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534826; cv=pass; b=d0ULWiBDL80CERPIQcuwyS5SOfsOujvU4LMPKMPc8SbAWbGID3oDZY8a4T70jYaj8teRYApc9Ej5JoRzjoqzgvGnG9DB29g/jtxM7TkRvBGzjI/0IF4zKb/JzF9Fv8jnVhMq/51j0WL3ALv1t1GXKhPmDYqLRz/ZLKvB8tHkUXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534826; c=relaxed/simple;
	bh=RycOsAx2TBGVqiZYHvFoYFub4XYcofjEkbf0KjswUFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJbCPTth+LWjvZkPDuuMfPkM9Amfhh821RB0Usje/Qp2FHLHrtqwmYqevqEj8syRI/CEgcXD9unUHrdXnO9j77avW81qP4WysVNHXjCBKWvxJe67OMq26lqw4ypfdlCiH6wJEcktVwWnerjeCBr5F0EjPooxxnlIBlpzKfwyj/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiyQzWb2; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiyQzWb2"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-499f6e0bbabso852215b6e.0
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534824; cv=none;
        d=google.com; s=arc-20260327;
        b=DvFakN+dBEHe7pBi/cMMnG487uuJsljyJ5OnvUOTcxwaHEj0A+eietEodq0WEVRT8k
         rkIeuJMBuzD0I4hufsD9ZqDg2bxOLZP7pgGlNSCgew2UAHWuhrxxc714IrOKB8jTF/i1
         F+Pgnt25vqmHZ3X2wH/N5Ag20tJ9CfwjrulN4lOl2P/hjN3oHiTjhZC9eBSFXQ2J14+N
         ePn2pyeUoJTxLKBkS/KDbhUKJFCQ0l/jYFBHxPTuemW8APP8D5QkmtGYj9xq2cU/b+1f
         sTnaiWPukVJ8JG4A2VhdNQno1BJHdI4xfT/fnq30R6+6IrbO4ycdV8RWikbdRu5iTwGU
         z5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ipyszg3PvGm3dRDJb0K+VEaCB0UNilFT38xnKdkRj5Y=;
        fh=40fFx+4osaXBi4FGYYsgKfFijKTYE9TLFR69NZRmuVo=;
        b=SgGCrtNpZI5TWik0BnYYrFSZzPfZDoNMf4WJ4rg2kNsktZAdGv4eWH9L0sXgiCFPqn
         ZGDKJk79xA1E9elLWLLkp/BEe8O58e4o2BbzA/0GT+Dap9EnNGrAUqlL/6aScfCUNqcE
         sWumc1IuK+mJ0cDnLbrxC24Xl8xV5TYH/24h5YM486p0LBucBjiABQyHdOerQ+V+WIDi
         +NVHrjG4qMkmQnsCmi8QSt+mj/oGMOHWCQVwD0AzC0hZDON8PzdUadf308dnrVLmNdDI
         Rhg5/CAr/yeor71leecyOSi0DS7D6aEgDmmoro42jdluZMrQgjnrPO1ePOU7hper1KPM
         MajA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534824; x=1789139624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ipyszg3PvGm3dRDJb0K+VEaCB0UNilFT38xnKdkRj5Y=;
        b=eiyQzWb2DV6ZUKF1tgE+Z5mf9QCo6I0R8r6F9e+vgZCYOYovD83fAF+3N6nBO5esbl
         kU829Xol7KY/538ASE3VVNKjkhP+nFuZ3TGX3CPt0oF9yI7VOvXSXPGYu5yxiL4iyuKM
         dQmVnMmCLaNLK5mk2VBuR0bGvYJKdl/uNzmMmirwxbppuX1XqxIe9itaZfa3fljWn1z7
         u8RDt1CZ3XkpjgWwJJsHJ4xycoYG7DiuakxZ06NVS0CxyCbEkt78yy6R9AM0mKK4H54Y
         cMxwj7vUzAsIvh1ICjR7ZkgnKrCRu7BwaI7UpPkyJ9hCrRay7+nf//FraYUvoH0Dt2yk
         V+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534824; x=1789139624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ipyszg3PvGm3dRDJb0K+VEaCB0UNilFT38xnKdkRj5Y=;
        b=C7HadaXGNWe0e3mfrw3iYuN2RwIGOIOWKdV5a6LpgFwWbTScRMUXDgriYq14bPzWeo
         yC4B2JOI3bynpI9I2dLf1/B8nctS1yCRM5ETWoxVZLS59a0oySO1rLzQB1gNl0QIBChs
         Qsv7YR0AF1HxJnvaNtsa7vL7NQ0vtacZ6HKM6pYT2WuQzmx+ZVoK41q1waVa5aXVkIW9
         o+0s48D08P0sZ3NpvCyHElgc6u6JUfzvdf8r85m3OJm9zIDY+5QHYBIMBRrLtrqkgMty
         JuK/x8HaC3bHGtOkHuIHnfgQ0LLNzS7Zk4984m6U3hY9OdlO30gTNU9sGTk0lSSgxB2c
         9vtA==
X-Gm-Message-State: AFuF++ll/zr+tEMwZwJZ/nS2vue8MAendiqsrd08HQOnbBE60IwhJHbD
	NDSv5yG3jGrllMiZlUUrcfCrmMuZ2SrZZvCRdo7zQWBiUUsYv7ZcYUR5T4l2tzOdEb6rfZM+y6S
	22hsUO2GItZEzSlJP+b20d1oS+FBOhIs=
X-Gm-Gg: AYBFou3Xund7rjFLomnpAw2QBqzZ5NLC7/FEjuA26OsuSHkbV1IuX8frC3yBfqi6Gt4
	JBLkRnhhBVaPkYq123gdYto0ViQRZ3/cz31hUFcBceOrCqRaegaNbuNRwi2ffMdjwYUVMlhcD9J
	EBydxbK8gJLQbXu8bxZ2hxaN05G+dPTf2jQpuaEpjbJDpl79SVyvQkhrUqai50qktP7OeuOb2eY
	aiMRfm9kwXxNWGHgUGydv296OJHF0teadlxuwMWiSZnUpzER/hBLbYYxAb62XqQLKYtAgc2xzqK
	LXXXrMHhH5BGJBQxq3TE+BcCSbXxG1VIANRoPtKYRs1S8W7s0cNpJQk=
X-Received: by 2002:a05:6808:1b23:b0:4b9:e5fa:890e with SMTP id
 5614622812f47-4b9e5fa8dfdmr2251372b6e.33.1788534823762; Fri, 04 Sep 2026
 08:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
 <9b2939c5-7935-4d2a-b628-6c3ba961e16f@suse.de> <CAEjxPJ43LV4CHSCLc9mxvBJEOAY=+hYMZ8+8-cRvpWDTPmqqRQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ43LV4CHSCLc9mxvBJEOAY=+hYMZ8+8-cRvpWDTPmqqRQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:13:32 -0400
X-Gm-Features: AcwNN1UwXGqreUINifJiCLBsWcyiiQiK6A9CrWDTTf-Ws6nowKrvjL8HAAm70jQ
Message-ID: <CAEjxPJ5203DeJ_38pT9Kw86FFACh00z3YegMDzedvv9OcpG1qQ@mail.gmail.com>
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before xperms_ioctl/xen_devicetree
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, jason@perfinion.com, paul@paul-moore.com, 
	Johannes Segitz <jsegitz@suse.de>, Russell Coker <russell@coker.com.au>, 
	Laurent Bigonville <bigon@debian.org>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 1, 2026 at 4:40=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > On 8/31/26 8:01 PM, Stephen Smalley wrote:
> > > On Thu, Aug 27, 2026 at 9:49=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >>
> > >> Drop support for kernel and module policy versions before the
> > >> xperms_ioctl support (SELinux kernel policy version 30, modular poli=
cy
> > >> version 18) and xen_devicetree support (Xen policy version 30). Kern=
el
> > >> policy version 30 was first supported in Linux v4.3, Xen 4.6, and
> > >> libsepol 2.5 (20160223). Modular policy version 18 was first support=
ed
> > >> in libsepol 2.7 (20170804).
> > >>
> > >> RHEL >=3D 8, Debian >=3D 10, Ubuntu >=3D 18.04, and SUSE/SLES >=3D 1=
5 have
> > >> libsepol >=3D 2.7+.
> > >
> > > Would appreciate any feedback from distro package maintainers on
> > > how/if this change would
> > > impact them. Link to the original patch for those who weren't cc'd on=
 it:
> > > https://lore.kernel.org/selinux/20260827125511.19408-2-stephen.smalle=
y.work@gmail.com/T/#u
> > >
> > > This would break e.g. RHEL 7, Debian 9, Ubuntu 16.04, or SUSE/SLES 12
> > > if they ever updated to a version of libsepol with this change but I
> > > think that's unlikely.
> >
> > SLES should be fine:
> > - SLES 12: version bumps are unlikely, only backporting of patches beca=
use everything else is too risky
> > - SLES 15: everything besides 15.0 has libsepol >2.7 and also unlikely =
that we bump the libsepol version in 15
> >
> > > The greater risk is if you have any lingering binary modules compiled
> > > with versions < 18 inherited across multiple upgrades (e.g. RHEL-7 to
> > > RHEL-8), then those modules will break and probably in a not-very-nic=
e
> > > way (libsepol suddenly won't be able to parse them and therefore any
> > > semodule/semanage operations will fail and you might have to delete
> > > them manually from the policy module store).
> >
> > We did not support the policy that long, so I think it should be okay:
> > SLES:
> > - 12 -> 15 no policy update will happen because in SLES 15 there is no =
distro policy shipped or supported
> > - everything else has libsepol >2.7
> > It might be that 1 person drags their SLE12 policy to 16, but I think t=
hat is not a supported use case
> >
> > SLE Micro:
> > - started with libsepol >=3D3.1, so should be fine
> >
> > But generally our built distro policies are unlikely to be inherited be=
tween versions from SLE >=3D16 + SLE Micro >=3D6 on, on upgrade it will be =
migrated to the one that is built for the upgrade target
> >
> > >
> > > I'm fine with deferring this change to a future libsepol release afte=
r
> > > 3.12 (e.g. 3.13 or later) if that would be safer for the distros.
> >
> > I don't think it is necessary to delay from our side, thanks for the no=
tification.
> >
> > Let me know in case I am misunderstanding something, thanks!
>
> Having heard no objections,  I plan to re-base and merge this today.

This is now merged but can be reverted if distros report problems.
