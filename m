Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8F25B099
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410660; cv=pass; b=qGC0bHtJhdNHR8QCFti/sIsvK3XM6QQIDG9V9K8ASuIJc1oia7vC9v3i2wPKtGVxUKBy8qMvE0Uv0MALvK+Asx0Yh+hCwqzVjXR24JKkcVh46aKb4RlCgKnSjLWN9FlEBVC1w5xYWSKOe9VRBc0t5p+K6XmP3EwsCh28AI/EJ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410660; c=relaxed/simple;
	bh=UzFF5KLWAjW0lIcysjB+/coU5jxAS0I7BDIO9z7KD70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC23Ze3od/WrXcdpyoTD6GVQy3QZeHOD/LdHZ21AjYeXE8Gk/oOY/1BdsoTo1d+JBbO9fA1dbKsKPO7wRj6Na27IGviFoKfyY603XENkr3LuzGn31Ka7NQovuy1fMMVtCw13I4LYiBfsBQYdVQ7G4OxXlybebuG85H87IxL9XOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxjfxqeR; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxjfxqeR"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845b733e82cso19876b3a.2
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 11:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782410658; cv=none;
        d=google.com; s=arc-20260327;
        b=GukLVLpI2gMKbigbNpCkYqX1HZfrBKrzJFli+ckfSOepbWGLGKJdmLBMnY+M5ODcv1
         QTSu6Ia+FIds1prLfmu8YVni0jjcPICnvcG4POHNnFLGrzW85XmQCbqsEhnp6JDdURZx
         iU7ZEQl27hjEsn2Vfo8p9rUR2Z69r7ziVILalSl/A42dLmp93rY20cRMtdDb13g/BvEz
         S0jN8ZCuB87D0DJnCiTklxCzQHIeorOISRzO0JeI2Gjbc5DM3QhZjCA9Tilnax9IZV/p
         33sDRGHcZxwDhi88OU7WAlF8LR9RTQkjmnDugoyVE2Rx7GIcOXYXxSfJDQVnQCoHDjx0
         8U6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cuwl3E9AcKcPmubUAbWz/nHq1lV6Rh3pIaZNn6z7bMA=;
        fh=DbCgiLzBq+MbW1Iweay5Vpi64L9cdpNMiGVC4gHSzoM=;
        b=GtRYAk3a9p44rUDyPI6fDonOUPhY2AFLJOv2q2nS95a5TZClY606CU8Amkbacq+Gjj
         AlgBc/4E5krpBf7wc8yHpSffzrO4bMSSPnHRKkRRJ+h3eQhnAcbAzxd+ZQ7OhZDMchxt
         gRtGI3CcviYQ/jf9rw868Am+xSx3qpQMmF3oEpRGiNNyn28hOJk0p4wwBeVlqPOm/LiN
         mqzGs9TFm9pjPKcIAungpzIozqw6izIsLsgmvT+OxQ0DyjrkyLG17iMRDtwKRcrau/9d
         WCIh3ok0YtcVRdtE9PqIFObAElmUnkiAjlQZp+xg8FKjvRwIbVIQpLKi+al2CfWJmjwV
         AszA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782410658; x=1783015458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuwl3E9AcKcPmubUAbWz/nHq1lV6Rh3pIaZNn6z7bMA=;
        b=mxjfxqeRgGAm7xkuP0DY9xD0eli5VckEBnvddvYkPAaa6mJzLpotu/wCGypln/5W8z
         HWwHUZ2XL34SS/0nlBRfIEtsiVvgnI4QhVGJuHGVK8OZSrl2CDEQCHBVGKRHnYDK8Bxm
         f4uplJVcq5e++t9AFQJyz3kU4HliO0CWNgwpih3QekHOc7T/Q4t7+VBY9X1sLr8guAYm
         hTnNPvTkYTQeCYeAc6nmnccukuntAKry2tbeXR0Uwts3p4oNYNtl0AdV78xJgBVyUNrW
         mxDfWCUgqg7jtZgtUim7OlyliGdU2qPoSx7jjeNV6ro3pqGfUXdS0xetWB6RGsDWNk5B
         nBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410658; x=1783015458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuwl3E9AcKcPmubUAbWz/nHq1lV6Rh3pIaZNn6z7bMA=;
        b=Wg30e+4zDa33raR63dfg7RkJdThflTuuVbZ+BwJ5UFO8stQQLSiv69Vfs7zz5fIi+o
         JVyZDKX87HwIG+ITb6ebeJL8GQ8tX67agRTOMakxw1cI5d5BFSHhbfmiQx94mDqn8hAH
         QoCZQcgV45ceyKmei3j2e4FCGJ1KdxIJYUe+SqFlnyo3mjco5u2efGFLHUdZ5ryxgcn5
         TBwMhcKSLtziQiRD0t1BfL55MR6n1q5zwZS9MQeQtP4Q26YqRYYE+BoYbN8fMFgSvOL4
         3yKztC/XYNgULHVgUv5apOvnEuk5p1h6Q+RU0LJqP1Xl7BAgWyt+YxggIOB61NvFZwLA
         AP9w==
X-Gm-Message-State: AOJu0YywWUWfgOBGNOoZH1fB7kHoCMwyfy8sc25ot3Lrotd1M9+qlclh
	svjt7FGwVe/8CX2rRj/qqJNMrSZ2NWRDQgb6mKgqzIopzLpyv3+gHhLPpfFdrinmzYRa0Q4CTBg
	C+MJTsA8wXWn1a+47sU4REXfXFU1d4V2VNUBu
X-Gm-Gg: AfdE7cmR6n81+GUgXsqFbaCH9uN8bwbWh8q0FeAabaaS89MebiAMIWMpcFx/F6Remyv
	I7UaNN2GKCyUiS6Ql0dKaw0pXUxLz2NiJygHo9bW3eSPcWeVx2rkw7yLnwb0AFkvKo9UeIuJuhA
	XPVw70ThiAdKYQT1Nij9vG1tKbKnfeDgN7bbLT5mNewUzr0cjt2YrB2vqHnHpng58iAJtNekPb7
	L3Ql5fnVr7ohc/Y8t4488ST6XuUc8gkAlcHf6dCRpTgp+QrQlfCIl+cRTOuTk6Us316q7zk
X-Received: by 2002:a05:6a00:428f:b0:842:6155:45d0 with SMTP id
 d2e1a72fcca58-845b3b0820cmr4328829b3a.43.1782410657503; Thu, 25 Jun 2026
 11:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878q83u406.fsf@redhat.com>
In-Reply-To: <878q83u406.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jun 2026 14:04:05 -0400
X-Gm-Features: AVVi8CdGywltbEiPTwSEOHPHz2upgDJTTfaPsS2GwduOptcvCBQdchCm47azLXA
Message-ID: <CAEjxPJ4xzk7Ua9qCAz0mDTYxuLRELTGWBn3G4Vfn9GGzp2xN_Q@mail.gmail.com>
Subject: Re: ANN: SELinux userspace 3.11-rc3 release
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:34=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hello!
>
> The 3.11-rc3 release for the SELinux userspace is now available at:
>
> https://github.com/SELinuxProject/selinux/releases/tag/3.11-rc3
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> I signed all tarballs using my gpg key, see .asc files.
> You can download the public key from
> https://github.com/bachradsusi.gpg
>
> Thanks to all the contributors, reviewers, testers and reporters!
>
> If you miss something important not mentioned bellow, please let me
> know.
>
> Unless something unexpected happen, 3.11 will be released
> next week. Also only important patches will be merged before the
> release.

Some items that might be worth mentioning in the 3.11 final release
notes (overall, since 3.10); feel free to edit / coalesce / reorder /
drop / add as you see fit:

User-visible:
- Added new libsepol interfaces and a new secilccheck program for
checking CIL neverallows against a binary policy for use by the
Android CTS.
- Fixed restorecon error handling for read-only filesystems.
-  Rewrote libselinux selinux_restorecon(3) to eliminate TOCTOU issues
in file relabeling if /proc is available (so that it can use
/proc/self/fd-based pathnames). If /proc is not available,
selinux_restorecon(3) falls back to just passing the full pathname
each time for compatibility within chroot or other environments. For
callers that pass the SELINUX_RESTORECON_REALPATH flag, like
restorecon(8), selinux_restorecon(3) will still follow any
intermediate symlinks in the initial pathname as part of realpath(3)
canonicalization. Otherwise, selinux_restorecon(3) will not follow any
symlinks. This may yield different user-visible behavior for
setfiles(8) and restorecond(8) but only if a path containing an
intermediate symlink is specified on the command-line (setfiles) or
configuration (restorecond) since they did not follow any symlinks
found during the tree walk regardless.
- Introduced a new SELINUX_RESTORECON_SKIP_MULTILINK flag to
selinux_restorecon(3); if set, then selinux_restorecon(3) will refuse
to relabel files with multiple hard links to prevent mislabeling them.
Updated restorecond(8) to always pass this flag when relabeling files
to prevent mislabeling hard links to files owned by others, e.g. when
relabeling user home directories or /tmp. Note to self: we should add
a command-line option to setfiles/restorecon for this as well.
- Rewrote restorecond and sandbox/seunshare to eliminate TOCTOU issues
on their other path-based operations via /proc/self/fd and the use of
a safe_open() helper. This may yield different behavior if a path
containing an intermediate symlink is passed to them via configuration
(restorecond) or command-line (seunshare).
- Dropped sandbox/seunshare -k/--kill support (unused by sandbox,
fundamentally racy, redundant with killall -Z).
- Fixed sandbox/seunshare getopt flags to match the actual options.
- Fixed sandbox/seunshare remounting of /tmp and /var/tmp within the sandbo=
x.
- Updated restorecond to use Type=3Dsimple in the service unit file, add
a -F option to run in the foreground, and to not unlink the pidfile if
not used.
- Added a cache size cap, max client cap, receive timeout, and maxbit
cap to mcstrans to reduce the risk of DoS from misbehaving clients.
- Fixed mcstrans UAF on SIGHUP reload of its configuration files.
- Fixed mcstrans translation for uncached entries.
- Fixed sandbox interactive prompt for saving files.
- Fixed semanage audit fd creation to avoid hitting RLIMIT_NOFILE on
large semanage import operations (#291).
- Fixed libsepol generation of constraint expressions with a list of
names when writing policy.conf from CIL.
- Fixed libsepol to generate constrain/validatetrans instead of
mlsconstrain/mlsvalidatetrans when converting a module to CIL unless
the constraint contains an expression based on level.
- Fixed libsepol selection of tunableif or booleanif and to skip empty
conditional blocks when converting a module to CIL.
- Fixed libsepol/secilc reporting of CIL source file info.
- Fixed libsepol to require at least one perm in a CIL classperm and
to correctly count the number of elements in the avtab.
- Fixed libsepol to link xperm rule permissions correctly.
- Fixed libsepol off-by-one error in cats_ebitmap_len().
- Fixed dispol and dismod to show all options in the -h text.
- Fixed checkpolicy handling of out-of-range and complement at range
boundaries for xperm rules (#530, #531).
- Dropped legacy fscon statement support from checkpolicy - never used
in SELinux policies for mainline kernels (#518).
- Fixed libselinux constructor to not clobber errno (#445)
- Fixed libselinux selabel_partial_match(3) to correctly find partial match=
es.
- Fixed libselinux selinux_init_policy_load() to still try to mount
selinuxfs on /sys/fs/selinux even if the mount of sysfs on /sys fails
- this can occur legitimately within a user namespace.
- Multiple documentation improvements.

Other security/hardening (not user-visible):
- Many hardening fixes spanning the entire tree (including but not
limited to #522, #523, #525 thru #529, #532 thru #534)

Build fixes:
- Fixed libsemanage pywrap target deps for parallel builds.
- Updated pywrap build targets for modern python builds using the
Python3 build module.
- Disabled build isolation for sepolicy python module.
- Fixed build errors with glibc 2.43.
- Fixed libselinux build for non-pthread builds.
- Build shared libraries with -fPIC for LTO
- Fixed uclibc build failure (#435).
- Multiple fixes for musl/llvm-based builds, including adding a new
EXTRA_LD_FLAGS variable that can be set for libselinux builds to pass
--undefined-version through to lld (#511 thru #515)

Coding style/format:
- Reformatted entire tree based on .clang-format and added new
check-format/format make targets to check and/or reformat code to
match. This is now a requirement for new patches.



>
> User-visible changes since 3.11-rc3
> -----------------------------------
> - Bug fixes
>
> Development-relevant changes
> ----------------------------
>
> - Improved CI
> - Added EXTRA_LD_FLAGS for use by musl+llvm builds to pass --undefined-ve=
rsion.
>
> Shortlog of the changes since 3.11-rc2 release
> ----------------------------------------------
> Chris PeBenito (2):
>       CI: Fix variable use in build-userspace action.
>       CI: Add explicit output variable for build-userspace action.
>
> Christian G=C3=B6ttsche (3):
>       secilc/docs: fix wrong CIL statements
>       secilc/docs: mention nlmsg extended permissions
>       Makefile: avoid 0 as NULL pointer constant
>
> James Carter (2):
>       libsepol: Check for proper length of addr and mask buffers
>       secilc: Use fstat instead of stat to avoid TOCTOU issues
>
> Kalevi Kolttonen (16):
>       libselinux: use null character with strings
>       policycoreutils: use stderr for error messages
>       policycoreutils: use null character in a string
>       policycoreutils: use null character in strings
>       policycoreutils: check strdup() failure
>       policycoreutils: use null character in a string
>       policycoreutils: use bool instead of int
>       policycoreutils: use null character in a string
>       policycoreutils: use bool instead of int
>       mcstrans: use null character in strings
>       mcstrans: use null character in strings
>       sandbox: use bool instead of int
>       audit2allow: make error message more helpful
>       policycoreutils: use bool instead of int
>       mcstrans: use sig_atomic_t and bool instead of int
>       libsepol: Add missing comment to context.h
>
> Petr Lautrbach (1):
>       Update VERSIONs to 3.11-rc3 for release.
>
> Stephen Smalley (2):
>       python/semanage: do not leak an audit fd per logger instance
>       libselinux: Add EXTRA_LD_FLAGS for musl+llvm builds
>
> netliomax25-code (11):
>       libsepol: fix out-of-bounds typealias_lists access in module_to_cil
>       libsepol: cast to unsigned char in ctype calls
>       libsepol: null-terminate temporary buffer in mls_to_string
>       libsepol: bound category values in mls_semantic_level_expand
>       libsemanage: guard end of path in semanage_fc_find_meta
>       libsepol: bound type values in type_set_expand negset loop
>       libsepol: test type_set_expand bounds negset type values
>       libsepol/cil: fix double free of borrowed type datum on error path
>       mcstrans: fix out-of-bounds read in parse_raw sensitivity parsing
>       checkpolicy: fix xperm complement at range boundaries
>       checkpolicy: reject out-of-range extended permission values
>
>
