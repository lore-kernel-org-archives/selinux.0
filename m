Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AC1D86F2
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316133; cv=none; b=TH6noXBQYq3KtjNzZfRN/B22hKnMM7SUSIH2qHoKmE77+kU4Yr7EwGkBgVZt7i5kG7NP16R9RMjtGvP/bzlzuQ7aDnBb9zfTcfXmu59Vk6MwIu2SQhkR4kk1Ig5gFggunaOhi8dUQHSiVo5+GW0RVTPH03YFAu36635D159KsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316133; c=relaxed/simple;
	bh=tCcOUINWbZ0B6V7GAhRYbpgrM3wdU1K7HZk1jD4Iu8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTotUnWxXysLBF5KGy0QAu41Em/Ge2SsK4Kn9uRxyWgk3kPsj6jmQ/C2/g2Lvlx2QTi9Of3aU2XuLs7F/G/+ecpY5zhAXHQ5iSC7KGDKlorfwCMZtp+G4xmVnCM5kd16R57jh62EQlP3/i1llAAun8j+wg3IQtQw9OuL5sogN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzTLwsM/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzTLwsM/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30a99e2bdd4so825596a91.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747316131; x=1747920931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNg/uW6hRJ+eWfrzk4REtM2vF76XGMd0XZEwA7k5pBs=;
        b=hzTLwsM//AGE4yKNqYCCmXuw9q/jl1Jj5ljKS/521+5eIniPfKyKafZknh1ju4n+JB
         Qai2sSW1KbPoueNX2tsZ9B2HwNW5q75BSp6Wt0AlyImsHRRqDgUEheCJ22+Lah5rnG2T
         U5TS0LG/VZTW4TjKWR3HUNUgQN2l37W2yTmuaAjmOvfg6XfoVxTrMznwfdDSxIiGoyi2
         /QA+eF5RtJ9OkJoqE5ltqzIY9JBS5ZbUs6osi/41axmCFWNaibKDnzxsE7mlblnVV1fi
         1qIL3gWE1NB2FtWxvV0sitD2o/QEAc8UJLpdoFgFSE12mGaxeAL4iO95iiwEvboEXZUN
         xqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747316131; x=1747920931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNg/uW6hRJ+eWfrzk4REtM2vF76XGMd0XZEwA7k5pBs=;
        b=JXYwnDJk3qmvgyEYNSa7ZmYRX46hwvoxjkwEbq9NjWCrNwpzgGUeVwb8X6zI88zWBV
         l9XQRm9ESa3hHuhzzA4/wrCoVQaFeoFULN1FYafcrdcKM4+WnYOTTDWfTflyA1xgCb4A
         NBMU93WJENd08yuEhbcDUjhqv6tfG/1sri9SYy059KXJ9OFmyu4envJEv/KlskKYdTKr
         l6R9a4DtstNCFhrYlsSYQSNQ3dpGSk2QqUZYyXErnCMwUDhomydQ41tIMaxufBui/PX4
         WrFldeSgWo5rzDXK/IOdeiXD/4iO7nEgbx3wvxiUksN5u7bY01vuJ86eZj6wrlEAo0AL
         jOsQ==
X-Gm-Message-State: AOJu0Yz339rpqMMEETYrDuYRyCPylDN18L9S7hQZQZl/jHU90ZyIbZ6+
	A2admTneHL1mPMPpMqWb2VrfyqKBv8zwLKU/WtLs/S1CJ/FrE6bPFRiKknk1HD5CG7aJVVtqvQC
	OFt20fbLhyNfI31uZ+cIOBqlJOana15ZO
X-Gm-Gg: ASbGncvlCGyl9iS+A5cjP1HFPDxZKBuDpcf5Rp5jTo9vAtvsWW+wXRwK54cBLEpFH/J
	2gGgk5iV1oC+PH76+P/rcbMfOyaUzHAKlLPGCA6oEKQI7EprrfKr9Rb6DIKqTJior/XW/UUfKj1
	KznvyatHNWjoX26Ar4JvL8qNW8Mn/V6Jen
X-Google-Smtp-Source: AGHT+IGgpbJxsw8usBfXWG8WTabxHSHByW9knObnwFZjv3Ivsoqya0uz47QL7coaTRZ2Cd9CWxZG8A8F3/4B9xB+CXI=
X-Received: by 2002:a17:90b:2749:b0:305:2d27:7cb0 with SMTP id
 98e67ed59e1d1-30e51787597mr3304042a91.21.1747316130742; Thu, 15 May 2025
 06:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 May 2025 09:35:10 -0400
X-Gm-Features: AX0GCFsCmFz57X98YIMYpsLOFTw4cPxYCATI5MFFLs9xfszkqq_gVof-At3ARQI
Message-ID: <CAEjxPJ5Tt_xPiFQ5ftfMjRwCLZ9T-MiAaPfE8hsd3YyD5OTLZA@mail.gmail.com>
Subject: Re: [PATCH v2 00/49] SELinux namespace support
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:10=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This series introduces support for a SELinux namespace, i.e.
> the ability to namespace the SELinux policy, AVC, and
> enforcing mode. This support can be leveraged by Linux
> container runtimes to establish a private SELinux namespace
> for each container, enabling the container to load and
> enforce its own policy while still remaining bound by the
> host OS policy (if any). More information about SELinux
> namespaces can be found at the following URL:
>         https://github.com/stephensmalley/selinuxns

NB Some of the later patches could potentially be moved up and
squashed into earlier ones before merge if desired.
I've identified a few candidates below. I've left some separate for
ease of review or because they are
somewhat sticky to untangle from intermediate commits and because I
don't have a sense as to which
parts might be deemed mergeable at this time. That said, given the
performance data which I've shared
privately (happy to post on list), I don't see any performance-related
concerns with any of the patches
especially when CONFIG_SECURITY_SELINUX_NS=3Dn which would be the default.

>
> Stephen Smalley (49):
>   selinux: restore passing of selinux_state
>   selinux: introduce current_selinux_state
>   selinux: support multiple selinuxfs instances
>   selinux: dynamically allocate selinux namespace
>   netstate,selinux: create the selinux netlink socket per network
>     namespace

I likely should have copied the net namespace maintainers on this one,
will do so in later submissions.
Regardless, it would make sense to squash the later "selinux: limit
selinux netlink notifications to init namespace"
commit into this one since it addresses the concern noted in the patch
description.

>   selinux: support per-task/cred selinux namespace
>   selinux: introduce cred_selinux_state() and use it
>   selinux: add a selinuxfs interface to unshare selinux namespace
>   selinuxfs: restrict write operations to the same selinux namespace
>   selinux: introduce a global SID table
>   selinux: wrap security server interfaces to use the global SID table
>   selinux: update hook functions to use correct selinux namespace
>   selinux: introduce cred_task_has_perm()
>   selinux: introduce cred_has_extended_perms()
>   selinux: introduce cred_self_has_perm()
>   selinux: introduce cred_has_perm()
>   selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
>   selinux: introduce task_obj_perm()
>   selinux: fix selinux_lsm_getattr() check

This could be squashed into the original commit where I first convert
this check.

>   selinux: update bprm hooks for selinux namespaces
>   selinux: add kerneldoc to new permission checking functions

Could be split up and squashed into the commits that introduce those functi=
ons.

>   selinux: convert selinux_file_send_sigiotask() to namespace-aware
>     helper
>   selinux: rename cred_has_perm*() to cred_tsid_has_perm*()

Could be squashed into the original commit so that it always uses this name=
.

>   selinux: convert additional checks to cred_ssid_has_perm()
>   selinux: introduce selinux_state_has_perm()
>   selinux: annotate selinuxfs permission checks
>   selinux: annotate process transition permission checks
>   selinux: convert xfrm and netlabel permission checks
>   selinux: switch selinux_lsm_setattr() checks to current namespace

Could be squashed into earlier commits converting these checks.

>   selinux: add limits for SELinux namespaces
>   selinux: fix namespace creation

Could be squashed into the original commit introducing namespace creation.

>   selinux: limit selinux netlink notifications to init namespace
>   selinux: refactor selinux_state_create()

Could be squashed into the original commit introducing this function.

>   selinux: make open_perms namespace-aware
>   selinux: split cred_ssid_has_perm() into two cases
>   selinux: set initial SID context for init to "kernel" in global SID
>     table
>   selinux: disallow writes to /sys/fs/selinux/user in non-init
>     namespaces
>   selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
>   selinux: init inode from nearest initialized namespace
>   selinux: allow userspace to detect non-init SELinux namespace
>   selinux: exempt creation of init SELinux namespace from limits

Could be squashed into original commit introducing limits.

>   selinux: introduce a Kconfig option for SELinux namespaces
>   selinux: eliminate global SID table if !CONFIG_SECURITY_SELINUX_NS

Both could be moved earlier in the series.

>   selinux: maintain a small cache in the global SID table
>   selinux: change /sys/fs/selinux/unshare to check current process state

Could be squashed into original commit introducing /sys/fs/selinux/unshare.

>   selinux: acquire/release SELinux state properly in socket hooks

Could be squashed into original commit introducing the state field of
the sock security blob.

>   selinux: update cred_tsid_has_perm_noaudit() to return the combined
>     avd

Could be squashed into the original commit introducing this function.

>   selinux: repair security_fs_use() interface and its users

Could be squashed into the original commit introducing the wrapper function=
s.

>   selinux: style cleanups for node_sid prototypes

Could be squashed into the original commit introducing the wrapper function=
s.

>
>  include/net/net_namespace.h                   |    3 +
>  security/selinux/Kconfig                      |   65 +
>  security/selinux/Makefile                     |    1 +
>  security/selinux/avc.c                        |  782 ++++++++--
>  security/selinux/global_sidtab.c              |  810 ++++++++++
>  security/selinux/hooks.c                      | 1339 +++++++++++------
>  security/selinux/ibpkey.c                     |    2 +-
>  security/selinux/ima.c                        |   37 +-
>  security/selinux/include/audit.h              |    8 +
>  security/selinux/include/avc.h                |   77 +-
>  security/selinux/include/avc_ss.h             |    3 +-
>  security/selinux/{ss =3D> include}/avtab.h      |    0
>  security/selinux/include/classmap.h           |    2 +-
>  security/selinux/include/conditional.h        |    4 +-
>  security/selinux/{ss =3D> include}/constraint.h |    0
>  security/selinux/{ss =3D> include}/context.h    |    0
>  security/selinux/{ss =3D> include}/ebitmap.h    |    0
>  security/selinux/include/global_sidtab.h      |   26 +
>  security/selinux/{ss =3D> include}/hashtab.h    |    0
>  security/selinux/include/ima.h                |   11 +-
>  security/selinux/{ss =3D> include}/mls.h        |    0
>  security/selinux/{ss =3D> include}/mls_types.h  |    0
>  security/selinux/include/netif.h              |    4 +-
>  security/selinux/include/netlabel.h           |   14 +-
>  security/selinux/include/netnode.h            |    4 +-
>  security/selinux/include/objsec.h             |   43 +-
>  security/selinux/{ss =3D> include}/policydb.h   |    0
>  security/selinux/include/security.h           |  473 +++++-
>  security/selinux/include/selinux_ss.h         |  119 ++
>  security/selinux/{ss =3D> include}/sidtab.h     |   34 +
>  security/selinux/{ss =3D> include}/symtab.h     |    0
>  security/selinux/include/xfrm.h               |    8 +-
>  security/selinux/netif.c                      |   31 +-
>  security/selinux/netlabel.c                   |   32 +-
>  security/selinux/netlink.c                    |   42 +-
>  security/selinux/netnode.c                    |   26 +-
>  security/selinux/netport.c                    |    2 +-
>  security/selinux/selinuxfs.c                  |  551 ++++++-
>  security/selinux/ss/services.c                |  453 +++---
>  security/selinux/ss/services.h                |    1 +
>  security/selinux/ss/sidtab.c                  |  105 +-
>  security/selinux/status.c                     |   44 +-
>  security/selinux/xfrm.c                       |   47 +-
>  43 files changed, 4071 insertions(+), 1132 deletions(-)
>  create mode 100644 security/selinux/global_sidtab.c
>  rename security/selinux/{ss =3D> include}/avtab.h (100%)
>  rename security/selinux/{ss =3D> include}/constraint.h (100%)
>  rename security/selinux/{ss =3D> include}/context.h (100%)
>  rename security/selinux/{ss =3D> include}/ebitmap.h (100%)
>  create mode 100644 security/selinux/include/global_sidtab.h
>  rename security/selinux/{ss =3D> include}/hashtab.h (100%)
>  rename security/selinux/{ss =3D> include}/mls.h (100%)
>  rename security/selinux/{ss =3D> include}/mls_types.h (100%)
>  rename security/selinux/{ss =3D> include}/policydb.h (100%)
>  create mode 100644 security/selinux/include/selinux_ss.h
>  rename security/selinux/{ss =3D> include}/sidtab.h (81%)
>  rename security/selinux/{ss =3D> include}/symtab.h (100%)
>
> --
> 2.49.0
>
