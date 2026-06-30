Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5F3BFE25
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814761; cv=none; b=RuuuOEzhyIN7bzRwpn50cDqa1HUTNdR/gIA7OIclS5i+t/KyU710se5LChdk7hjivRlC+hwrhAJluQneJ/fXEekCWtfACwV9I/gCZoFZBst956LklgV9M9eU/ANKN3moAoBZHGYfTSsxeChUhf0vCf5SviwLp/OBBUdwIvCr13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814761; c=relaxed/simple;
	bh=FCNMUyFUI0XEnQ4qr9VosbTrojXW42Zk8tecHcOD5ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mELjPijI+L2g85Iur/IZivlUZfOK5QFG9m1Gd4U8yfxi/7Rol3WoUYLW++CQ6TKmkRlnu4yZS03y8u+Vm1ooOuZi1PI6Gfoz32l9KMASEeG4YtaanOXf5m9/dWYYbPmIVaFTwrQ69+Sm12xokzxXK0fNLMx1zo56K6lZT2GTb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsmSoX8I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsmSoX8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782814756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ucj1W+/Zsfna9VJCFajc6fqQakgy0Ibfs/6ida6OZuQ=;
	b=EsmSoX8IPazI9tPNrdcnzuvkl/nW9yDP/WunHBsYp6pRJMIyGzl/996MV7AYNXnP0wOwi1
	kAJcwbhiXca7BmPTRbEg0pAmZgAAkZgjCPOMvOAmy0iruhc88qVoZOLskEPwxQX++0uIZ6
	KQTdGkQllNHPLkE+OCh+YILUvfI9Q6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-NFCYayn4NtqOOvHRdlrVew-1; Tue,
 30 Jun 2026 06:19:14 -0400
X-MC-Unique: NFCYayn4NtqOOvHRdlrVew-1
X-Mimecast-MFC-AGG-ID: NFCYayn4NtqOOvHRdlrVew_1782814754
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4EF11955DE8;
	Tue, 30 Jun 2026 10:19:13 +0000 (UTC)
Received: from localhost (unknown [10.44.32.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26C613000B78;
	Tue, 30 Jun 2026 10:19:12 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Subject: Re: ANN: SELinux userspace 3.11-rc3 release
In-Reply-To: <CAEjxPJ4xzk7Ua9qCAz0mDTYxuLRELTGWBn3G4Vfn9GGzp2xN_Q@mail.gmail.com>
References: <878q83u406.fsf@redhat.com>
 <CAEjxPJ4xzk7Ua9qCAz0mDTYxuLRELTGWBn3G4Vfn9GGzp2xN_Q@mail.gmail.com>
Date: Tue, 30 Jun 2026 12:19:11 +0200
Message-ID: <8733y4tjog.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Jun 24, 2026 at 3:34=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Hello!
>>
>> The 3.11-rc3 release for the SELinux userspace is now available at:
>>
>> https://github.com/SELinuxProject/selinux/releases/tag/3.11-rc3
>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>
>> I signed all tarballs using my gpg key, see .asc files.
>> You can download the public key from
>> https://github.com/bachradsusi.gpg
>>
>> Thanks to all the contributors, reviewers, testers and reporters!
>>
>> If you miss something important not mentioned bellow, please let me
>> know.
>>
>> Unless something unexpected happen, 3.11 will be released
>> next week. Also only important patches will be merged before the
>> release.
>
> Some items that might be worth mentioning in the 3.11 final release
> notes (overall, since 3.10); feel free to edit / coalesce / reorder /
> drop / add as you see fit:
>

Thanks!



> User-visible:
> - Added new libsepol interfaces and a new secilccheck program for
> checking CIL neverallows against a binary policy for use by the
> Android CTS.
> - Fixed restorecon error handling for read-only filesystems.
> -  Rewrote libselinux selinux_restorecon(3) to eliminate TOCTOU issues
> in file relabeling if /proc is available (so that it can use
> /proc/self/fd-based pathnames). If /proc is not available,
> selinux_restorecon(3) falls back to just passing the full pathname
> each time for compatibility within chroot or other environments. For
> callers that pass the SELINUX_RESTORECON_REALPATH flag, like
> restorecon(8), selinux_restorecon(3) will still follow any
> intermediate symlinks in the initial pathname as part of realpath(3)
> canonicalization. Otherwise, selinux_restorecon(3) will not follow any
> symlinks. This may yield different user-visible behavior for
> setfiles(8) and restorecond(8) but only if a path containing an
> intermediate symlink is specified on the command-line (setfiles) or
> configuration (restorecond) since they did not follow any symlinks
> found during the tree walk regardless.
> - Introduced a new SELINUX_RESTORECON_SKIP_MULTILINK flag to
> selinux_restorecon(3); if set, then selinux_restorecon(3) will refuse
> to relabel files with multiple hard links to prevent mislabeling them.
> Updated restorecond(8) to always pass this flag when relabeling files
> to prevent mislabeling hard links to files owned by others, e.g. when
> relabeling user home directories or /tmp. Note to self: we should add
> a command-line option to setfiles/restorecon for this as well.
> - Rewrote restorecond and sandbox/seunshare to eliminate TOCTOU issues
> on their other path-based operations via /proc/self/fd and the use of
> a safe_open() helper. This may yield different behavior if a path
> containing an intermediate symlink is passed to them via configuration
> (restorecond) or command-line (seunshare).
> - Dropped sandbox/seunshare -k/--kill support (unused by sandbox,
> fundamentally racy, redundant with killall -Z).
> - Fixed sandbox/seunshare getopt flags to match the actual options.
> - Fixed sandbox/seunshare remounting of /tmp and /var/tmp within the sand=
box.
> - Updated restorecond to use Type=3Dsimple in the service unit file, add
> a -F option to run in the foreground, and to not unlink the pidfile if
> not used.
> - Added a cache size cap, max client cap, receive timeout, and maxbit
> cap to mcstrans to reduce the risk of DoS from misbehaving clients.
> - Fixed mcstrans UAF on SIGHUP reload of its configuration files.
> - Fixed mcstrans translation for uncached entries.
> - Fixed sandbox interactive prompt for saving files.
> - Fixed semanage audit fd creation to avoid hitting RLIMIT_NOFILE on
> large semanage import operations (#291).
> - Fixed libsepol generation of constraint expressions with a list of
> names when writing policy.conf from CIL.
> - Fixed libsepol to generate constrain/validatetrans instead of
> mlsconstrain/mlsvalidatetrans when converting a module to CIL unless
> the constraint contains an expression based on level.
> - Fixed libsepol selection of tunableif or booleanif and to skip empty
> conditional blocks when converting a module to CIL.
> - Fixed libsepol/secilc reporting of CIL source file info.
> - Fixed libsepol to require at least one perm in a CIL classperm and
> to correctly count the number of elements in the avtab.
> - Fixed libsepol to link xperm rule permissions correctly.
> - Fixed libsepol off-by-one error in cats_ebitmap_len().
> - Fixed dispol and dismod to show all options in the -h text.
> - Fixed checkpolicy handling of out-of-range and complement at range
> boundaries for xperm rules (#530, #531).
> - Dropped legacy fscon statement support from checkpolicy - never used
> in SELinux policies for mainline kernels (#518).
> - Fixed libselinux constructor to not clobber errno (#445)
> - Fixed libselinux selabel_partial_match(3) to correctly find partial mat=
ches.
> - Fixed libselinux selinux_init_policy_load() to still try to mount
> selinuxfs on /sys/fs/selinux even if the mount of sysfs on /sys fails
> - this can occur legitimately within a user namespace.
> - Multiple documentation improvements.
>
> Other security/hardening (not user-visible):
> - Many hardening fixes spanning the entire tree (including but not
> limited to #522, #523, #525 thru #529, #532 thru #534)
>
> Build fixes:
> - Fixed libsemanage pywrap target deps for parallel builds.
> - Updated pywrap build targets for modern python builds using the
> Python3 build module.
> - Disabled build isolation for sepolicy python module.
> - Fixed build errors with glibc 2.43.
> - Fixed libselinux build for non-pthread builds.
> - Build shared libraries with -fPIC for LTO
> - Fixed uclibc build failure (#435).
> - Multiple fixes for musl/llvm-based builds, including adding a new
> EXTRA_LD_FLAGS variable that can be set for libselinux builds to pass
> --undefined-version through to lld (#511 thru #515)
>
> Coding style/format:
> - Reformatted entire tree based on .clang-format and added new
> check-format/format make targets to check and/or reformat code to
> match. This is now a requirement for new patches.
>
>
>
>>
>> User-visible changes since 3.11-rc3
>> -----------------------------------
>> - Bug fixes
>>
>> Development-relevant changes
>> ----------------------------
>>
>> - Improved CI
>> - Added EXTRA_LD_FLAGS for use by musl+llvm builds to pass --undefined-v=
ersion.
>>
>> Shortlog of the changes since 3.11-rc2 release
>> ----------------------------------------------
>> Chris PeBenito (2):
>>       CI: Fix variable use in build-userspace action.
>>       CI: Add explicit output variable for build-userspace action.
>>
>> Christian G=C3=B6ttsche (3):
>>       secilc/docs: fix wrong CIL statements
>>       secilc/docs: mention nlmsg extended permissions
>>       Makefile: avoid 0 as NULL pointer constant
>>
>> James Carter (2):
>>       libsepol: Check for proper length of addr and mask buffers
>>       secilc: Use fstat instead of stat to avoid TOCTOU issues
>>
>> Kalevi Kolttonen (16):
>>       libselinux: use null character with strings
>>       policycoreutils: use stderr for error messages
>>       policycoreutils: use null character in a string
>>       policycoreutils: use null character in strings
>>       policycoreutils: check strdup() failure
>>       policycoreutils: use null character in a string
>>       policycoreutils: use bool instead of int
>>       policycoreutils: use null character in a string
>>       policycoreutils: use bool instead of int
>>       mcstrans: use null character in strings
>>       mcstrans: use null character in strings
>>       sandbox: use bool instead of int
>>       audit2allow: make error message more helpful
>>       policycoreutils: use bool instead of int
>>       mcstrans: use sig_atomic_t and bool instead of int
>>       libsepol: Add missing comment to context.h
>>
>> Petr Lautrbach (1):
>>       Update VERSIONs to 3.11-rc3 for release.
>>
>> Stephen Smalley (2):
>>       python/semanage: do not leak an audit fd per logger instance
>>       libselinux: Add EXTRA_LD_FLAGS for musl+llvm builds
>>
>> netliomax25-code (11):
>>       libsepol: fix out-of-bounds typealias_lists access in module_to_cil
>>       libsepol: cast to unsigned char in ctype calls
>>       libsepol: null-terminate temporary buffer in mls_to_string
>>       libsepol: bound category values in mls_semantic_level_expand
>>       libsemanage: guard end of path in semanage_fc_find_meta
>>       libsepol: bound type values in type_set_expand negset loop
>>       libsepol: test type_set_expand bounds negset type values
>>       libsepol/cil: fix double free of borrowed type datum on error path
>>       mcstrans: fix out-of-bounds read in parse_raw sensitivity parsing
>>       checkpolicy: fix xperm complement at range boundaries
>>       checkpolicy: reject out-of-range extended permission values
>>
>>

