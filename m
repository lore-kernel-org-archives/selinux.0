Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750B210EF
	for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289366; cv=none; b=lRjrCeZJdfkY+S4R6iKF9+LYf+2eX0I4K3n1mlOK0bqUIsvXXc57bSpADkOwxbEUoNTpqlTfGnbTfu6AA7fqgtCtrtqhVdBiyLLqFNvBdc+VX4TgWj9vOHXA7Q/9Y6wFeW7/+xEISWEQ4BuhHGT1+uWpnTKQU6s2xYryJbMt/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289366; c=relaxed/simple;
	bh=VWYPT8g6Jd85tJW5Xy4JfiFcSB9nSNuj8foib8RsdEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP5O5b2T1l2qPF4AUYXDJPXmB8Ha8EcBAI6gb8t7Imyv9dort3SpzJJTRQcbM4wBLCUuGpkQ0rXBkl6osywHVwviU1qbRKZha59oqfMotoJbbDyVjNL4DIgeXFyig86+vtF81fmUhyHITI9/y6zcvdt7oHX0E4tIWRpT1Kmy2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUNj7dRE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUNj7dRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706289360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgot8gnXgaT/PXNWyINqw6zO/OV0dslkn5Z+0ObOBdo=;
	b=UUNj7dRE+cggprO47dr3f9+9BW3umFlqfE0U9HIPniQdih3DVRo256DC/dH19FtfA90QEJ
	LoTe+cjvtHO8eTEB8mCvMdjwCJkN7/FM2m3/OkkiFPMtP0p9AGVk6UTrk1zfcJVTOTLr/u
	SyDHC3KxxKlxKSr/p1AUueOq8q9YHp8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-RYkLRaVuM4mD80ZT6KNIog-1; Fri, 26 Jan 2024 12:15:58 -0500
X-MC-Unique: RYkLRaVuM4mD80ZT6KNIog-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-290c6d7776eso509301a91.2
        for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 09:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289357; x=1706894157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgot8gnXgaT/PXNWyINqw6zO/OV0dslkn5Z+0ObOBdo=;
        b=H3fPFaRdSZuYhW3DR2kZaouxsKEM2oiSR0m+uODfyqBJz7KIjE1xLT/JFnjG7PYGWq
         f70E5pI/pSZr5DuTIXJi9TG5k0jSyLLEWmhXA9GEa41m0M3RknjJDCr8LDqj11eeKiiX
         5LLmXGJe6g/yS41rR/7N9FdXFpjaLio0xQnbWef4ibBFicVlaaPdx4u/hj3pkYEbahtE
         zH6EKd+5J238Xx2YjNbiLYA+m12YKBT/SwsYwrJPLvzAbyZYLel8H10wthtFha2CGBI6
         WMq40r4ahzey2pkXoN15IkqhmRdF4UaIxjHl/P60tAANxe8eDlPen4kJZrEuhRJ8xeTu
         nlrQ==
X-Gm-Message-State: AOJu0YzatF4HRh5yjQ7+CxWMb6aUpagM5yxDCxaoVbtj1Uc2AXacLU3l
	XEtqcKKeJ4JMAg9ZAboNsO993+3ktVfcjQFolO6ScoHjGhUTGiYG1ydqZOscwR6OhKjKsvzRjX2
	uFuK7e4JaWYa6CY/W+VUutmo4/GIJu+u4oN/0Nc3iTlmj7EN5/OhrM+WppXnwMrf13N4PrxYvnF
	kyy19msxKI/mzW8P3/KGbuxIYY3tM3Jw==
X-Received: by 2002:a17:90a:4089:b0:28b:9749:c5a4 with SMTP id l9-20020a17090a408900b0028b9749c5a4mr165971pjg.80.1706289356821;
        Fri, 26 Jan 2024 09:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHewnI20Y5l1grIbvylQlE/FM5X1udcmBREJcp3l0x2EQqa4JWvew4t1fEOb0ARNHWpUO2FXI+0lWH2O5j/HGo=
X-Received: by 2002:a17:90a:4089:b0:28b:9749:c5a4 with SMTP id
 l9-20020a17090a408900b0028b9749c5a4mr165963pjg.80.1706289356585; Fri, 26 Jan
 2024 09:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jan 2024 18:15:45 +0100
Message-ID: <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 26, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jan 26, 2024 at 5:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The inode_getsecctx LSM hook has previously been corrected to have
> > > -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> > > behavior. However, the call_int_hook()-generated loop in
> > > security_inode_getsecctx() was left treating 0 as the neutral value, =
so
> > > after an LSM returns 0, the loop continues to try other LSMs, and if =
one
> > > of them returns a non-zero value, the function immediately returns wi=
th
> > > said value. So in a situation where SELinux and the BPF LSMs register=
ed
> > > this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> > > returned 0.
> > >
> > > Fix this by open-coding the call_int_hook() loop and making it use th=
e
> > > correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> > > other hooks do.
> > >
> > > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_W=
h90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> > > Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecc=
tx")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> > > serious issue that Stephen reported, some of the tests are still
> > > failing under NFS (but I will presume that these are pre-existing iss=
ues
> > > not caused by the patch).
> >
> > Do you have a list of the failing tests? For me, it was hanging on
> > unix_socket and thus not getting to many of the tests. I would like to
> > triage the still-failing ones to confirm that they are in fact
> > known/expected failures for NFS.
>
> Applying your patch and removing unix_socket from the tests to be run
> (since it hangs), I get the following failures:
> mac_admin/test            (Wstat: 0 Tests: 8 Failed: 2)
>   Failed tests:  5-6
> filesystem/ext4/test      (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
>   Failed tests:  1, 64
>   Non-zero exit status: 2
> filesystem/xfs/test       (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
>   Failed tests:  1, 64
>   Non-zero exit status: 2
> filesystem/jfs/test       (Wstat: 512 (exited 2) Tests: 83 Failed: 2)
>   Failed tests:  1, 71
>   Non-zero exit status: 2
> filesystem/vfat/test      (Wstat: 512 (exited 2) Tests: 52 Failed: 2)
>   Failed tests:  1, 46
>   Non-zero exit status: 2
> fs_filesystem/ext4/test   (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
>   Failed tests:  1, 63
>   Non-zero exit status: 2
> fs_filesystem/xfs/test    (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
>   Failed tests:  1, 63
>   Non-zero exit status: 2
> fs_filesystem/jfs/test    (Wstat: 512 (exited 2) Tests: 82 Failed: 2)
>   Failed tests:  1, 70
>   Non-zero exit status: 2
> fs_filesystem/vfat/test   (Wstat: 512 (exited 2) Tests: 51 Failed: 2)
>   Failed tests:  1, 45
>   Non-zero exit status: 2
> Files=3D77, Tests=3D1256, 308 wallclock secs ( 0.30 usr  0.10 sys +  6.84
> cusr 21.78 csys =3D 29.02 CPU)

I got the same ones (I, too, removed unix_socket to allow the rest to run).

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

