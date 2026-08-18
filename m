Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B237AA8B
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093564; cv=pass; b=QHe065co21cDi4T/dYny7P65es9eR/85oM84psU/qHVrrHXIJvhOSWkTJRBnelZraFBdb6PKee5MVNkUzfH2AYluLotD8y5k5CcZeA56gxZGi5Y/t20VSdW1HWTgXYhpCO177Qjvhj8Nqbv1PEPvDthNZJIKt+tIcWlG5SSRfmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093564; c=relaxed/simple;
	bh=oZEVUFGghPOKJGwiaBYS9UkXUIx0/8qBLFMArfsLvw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGp9PVwVIq7tM5UJa1MCs6VCp2kRKW7+xsO0haNw7Vv3rDKdAETxvQYRqSKkPfh2K3urIp65LUOZWdNnkBtKWB6+Hi/aflZxbm2+mGh0vs+zpbPXoTJ9N2D7GTuO5MHmsGEWwOfs7nII2qeIHILbWiXF7XMNcq2o+RtrnS75C7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UphuHZpv; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UphuHZpv"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-836ce6cbe1eso7068697b3.1
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 15:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787093562; cv=none;
        d=google.com; s=arc-20260327;
        b=cLX+1FDBPQLpIerw8XJPNw0AePnleJ+g+7743yp0hhWW8H23YY5kiQlO/VI6+tmOTl
         B4ZHB0Ibl0HVYdaFH2X/GBit94JyMbqYx6dTnDZ0QV1X3KZSN6kCYrG28JfYDgBSTJZk
         DkCyDW7XBJjDDNXUidTSRTddc5UMfYRonDb+o80CPetQ4jy6dPPbJDwUThwuAgeoYWoj
         qfUjujY63tsAEGNMC9kKpYNOZ11fBY/6pWyyE11C3HMoLZ0H+aN+Y4jIEmwXWRJ8zl7i
         GxP+9hfpsok0qHxJi5EbHZOW4YjGQtK9FpaSYTTlg5OYYhlKg7cPvJc/WoFWzjFNuTYY
         njFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oZEVUFGghPOKJGwiaBYS9UkXUIx0/8qBLFMArfsLvw4=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=LCtTdCIKI2dv47h7SeX67eLMFZq7Ev6F5k33z80R2ZcuTYLop17YUy5Le6tIvQv94I
         LMF9lkqM6L8BuH36lJcspNvs+UcMLBZwWWImpMeQ7YxxY0rFXNnfkRLhFksw9uC8hBGl
         Rxdpl7ht6+H23l7CHDhRFJWOgz8b+KrqGOriUyXH8ppz0CaTA6MAm3IM0Y5gDIaLn590
         2ndRfHbcjHf0vAOmwt4biBQg9l/IUFkqHJNPEmjD+bCEQzqDyRU79NZASLk5hkCYXkyF
         Kv5xwq5ZGgoUrE/9BqO2BcWBG6vaGqIC8SHnRUv+ETM1TyqL4R4DeBCt3PcfW+U5bgnq
         WKNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787093562; x=1787698362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oZEVUFGghPOKJGwiaBYS9UkXUIx0/8qBLFMArfsLvw4=;
        b=UphuHZpv+a86cCYusyQstHVBWX7Jwa6V/y4XKu37+XHgvmgshZ/vD4Yr5RHXCiHHd5
         FaVJdnwu1NYdwyZp7cYI3+Kb6EZE/aZveJKzRnhvWJL7cNJQo1pv24ontguT6PmbeA1L
         LB0LQsBNJ599bTfCU+8RJRXcuIEVxP+TNE6lCzSTIT3/wgy60PqeyvYvZnTO+5i6b/bI
         NIAEGZUt/GmBZBGkHgg6S/BvGaIcoIYrbsQvRV2jXvEeFiUndP0oUPbGzH+KqhYtAlOZ
         wUPfkCXy1xCqP99AY0YLR0q+2FkIZS5DwXFhUeCjSiEBUCfsmTj9ATKc4C27tvS8Cmh9
         DBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787093562; x=1787698362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oZEVUFGghPOKJGwiaBYS9UkXUIx0/8qBLFMArfsLvw4=;
        b=FWLPFVrW0OQKJRHRsEa+mFsbMgsSsJhSx9Mz5Q+EW32PHiKSpQxM0OYdhxd08o8YuY
         q7fQcbEDJ4xklryQpB3Yp+Y7NECMo3fcizSsRduKklPAm10NwlbusnGnWWbiltL8rYX1
         s61gLZekLM3Smkz2gnweIeYhgdYTOz7pDPB5cmBj7j8GrHAKcjTsan7KgeHYy9u8iURB
         OF+JoPhNEdm+mFHg3Wp1MQMKrtwsDSYvLHjVXXNQSQEf50kNf5Pd4ysZ4ZRCpeD6LP5t
         C1E4iZXL4CCXhs0dqc/YU+zFU57A+a45n6n9VbhasQka6Df+mMTYQQui7K96oW6qqcW8
         4srg==
X-Gm-Message-State: AOJu0YyKBsWubZxy319mV34va0npJEOyS8aWo4qIM9wI7eSNV4y5tkBp
	Q/E/E8A+kGyaIVf6F9mJkQKYSSZlahhT55JXZMXQkzYxAFDiTD9MCtmEZenWtzyEILfJRfvudjT
	xI8oZilwMn2r4Zsxy42kqmmKL85knFpq3xqE=
X-Gm-Gg: AR+sD134PD8pHx8pSFoThsQbJMzxi7R/5sNA+8MiupzjBA/sgwBAQ/QByrrm/9nrDUG
	dg4PcygrRCMMifNvN/N/URlIf6Gr7WjUr4ZzWZzXwX9A4FjAxeu9TpSVcxF0MwpKLGSmewcaEO4
	JEveKcaRjTjy9HOq5Sp2XK9eBEEFe8YKSvn+4jOnTgt9zkEZ2bq/xdFvzafEDuwy753bBJIVGU5
	3xEY232XLfnLlsNF/4XUJxvG+AUWEnT1FNyBOoacC6MVj9wTPwLWgr+6NQEs6+1jUvS7XR5wIt3
	T/lPQq6oOTBazei2DfFk1ILrZ9oKmtjepZPvmmQf0e191enmRsqLMJjIzwvjkCKQPJTe+RCBOQ=
	=
X-Received: by 2002:a05:690c:6c8e:b0:7ff:1a93:be35 with SMTP id
 00721157ae682-844df158a81mr3351927b3.16.1787093562011; Tue, 18 Aug 2026
 15:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG94myvwFz_f2K8SLsfFv1xKDkdm_t6z0s75BLcE5Dn7OV2LBw@mail.gmail.com>
 <CAEjxPJ4DjSrYfDG5V2U8SYk+t_hQXLuytuwP04X-jLd0DMd4og@mail.gmail.com>
In-Reply-To: <CAEjxPJ4DjSrYfDG5V2U8SYk+t_hQXLuytuwP04X-jLd0DMd4og@mail.gmail.com>
From: rushikesh ghatpande <rushikesh.ghatpande@gmail.com>
Date: Tue, 18 Aug 2026 15:52:30 -0700
X-Gm-Features: AcwNN1UOIbZ7BkginNvKsu9-7kCfRyy75QeJM5IZuZ18fqaA0hNGRIh5peFLm8s
Message-ID: <CAG94myvBHohDtG4kNdMNYzYOBYAZ9-tcKPpiJb_T7bb1fuE0_Q@mail.gmail.com>
Subject: Re: [RFC/Discussion] eBPF-based runtime permission auditing tool for
 SELinux policies
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Thank you for taking a look, and for the context on the
auditallow/Android precedent. It is a helpful confirmation that the
runtime-observation angle is worth pursuing via a different mechanism.

It would be an honor to have this considered for the SELinuxProject
GitHub. I'd also like to be an active contributor to the SELinux space
more broadly, not just with this one tool. I see this as a starting
point.

On coupling: the eBPF side hooks avc_has_perm(), plus a few more
targeted LSM hooks (selinux_file_open, selinux_mmap_file,
selinux_inode_getattr). This is done via BCC. There's no dependency on
libselinux, libsepol, or policycoreutils here.

On the policy side, it currently shells out to sesearch (setools) to
extract allow rules for a given context. So there is a dependency on
setools, but not on the core userspace tree itself.

Given that, I'd lean toward a standalone repo for now. It sits next to
the existing tree, not inside it. I'm open to your view on where the
right boundary is.

I'm happy to keep improving it based on feedback. If there's anything
specific you'd like me to change or look at, let me know.

Thanks & Regards,
Rushikesh Ghatpande

On Tue, Aug 18, 2026 at 9:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 17, 2026 at 3:18=E2=80=AFPM rushikesh ghatpande
> <rushikesh.ghatpande@gmail.com> wrote:
> >
> > Hi all,
> >
> > I've been working on a small tool that uses eBPF to observe SELinux
> > AVC decisions at runtime and flag unused permissions within existing
> > allow rules. The idea is to help identify over-permissive policy that
> > audit2allow-style workflows tend to leave behind, since they only ever
> > add permissions and rarely surface which granted permissions are
> > actually exercised.
> >
> > Repo:
> > https://github.com/rushigerrard8/selinux-policy-auditor
> >
> > Briefly, how it works:
> >
> > - Hooks into the LSM layer via eBPF (BCC) to observe AVC checks for a
> > given context, without modifying the running policy (no auditallow
> > needed)
> > - Aggregates observed permission usage over a monitoring window
> > against the policy's existing allow rules
> > - Reports the unused subset per rule, e.g. an app granted { read write
> > append create unlink open } on a file class where only { read open }
> > were ever exercised
> >
> > I built this mainly to solve a problem I kept hitting in my own work
> > on distributed systems/networking (permission creep in service
> > policies over time), and it's been useful enough that I wanted to
> > bring it to this list for feedback, rather than just leave it as a
> > personal tool.
> >
> > A few things I'd appreciate input on:
> >
> > 1. Whether this overlaps with existing tooling I'm not aware of (I
> > know setroubleshoot/audit2why cover related but not identical ground)
> > 2. Whether there's interest in something like this living closer to
> > the userspace toolchain, or if it's better as a standalone project
> > 3. Any gaps in my approach. I'm relying on kernel-level PID filtering
> > to keep overhead low, but I haven't stress-tested it against
> > high-throughput services yet
>
> Thanks for sharing this. I'm not aware of existing tooling that
> overlaps with this.
> We have in the past discussed doing this kind of thing via auditallow
> rules and Android has used those at times for a very selective form of
> this, but that approach doesn't scale well.
> If others find it to be useful and it is well-maintained, we could
> consider adding it to the SELinuxProject GitHub in the future, either
> as its own repo or as an addition to the selinux userspace tree.
> Whether or not the latter would be best likely depends on how tightly
> coupled it is to other components in the selinux userspace.
