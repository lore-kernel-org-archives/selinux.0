Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562E2F90E0
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161239; cv=pass; b=eN+F8zqLA71FMWrdGwPdWulnQlgL1tKIxnp5jKH+khR827bsUIcXuVs9JzXjsynkeWhvKOeP10rtGgaWXUednUhiz+5dNajvAszAmo1Q9GpWfAbRvl3vt7V6iI1PlbD9bgFn8Uc1At/nuEK3y5u52uLyK/uyBChEWToocgizAJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161239; c=relaxed/simple;
	bh=CBOvI1BtOA7YUgJeuHYg2Tw4UjwLBBjmDZLndMbo1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuKtZqJscyrL7Bu+dRGrFiv/eY+JZy6MXNOK8fKGt43Xj+rKHb/QwNPdnlGisf6btkVtkzMa9CRjPCjky8BMRXM/5bw6XwRZiEY/mepOZVzB6n4m5fC2YaHVAjZmiCgGB8vpYM+OR2KFkhr0uVduoP6OfA/amIG1y8hVew//fpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhSVuyq+; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhSVuyq+"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4560d6f82edso1354390fac.3
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 07:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785161236; cv=none;
        d=google.com; s=arc-20260327;
        b=XO1pC91FjKzAyNB3Wktdtyt3d3ihGtABoR0peQxw4ot/wEYRNuWJLMSq8gvInL7xZP
         zLW1cwQ+xs/AQTp/70iydBnwoq8udM86HJu3yLGeMJu85A4xNLRPDzD0gaNOUiJ/BVBT
         Gnz/ay4kmUXe1sHIW0sk9Gy9DzWJXXmus9PqcI3/S9WwiddYLhSWA5NKWhtpnAD0AWP3
         XOz7Vjt6I85ZPSsxHikqFgUUTGbvieEA+1grm0E7OVUNd5wtfGYqEHuZWhrMd5zOU2QF
         Es2U9nSL+biRY8eNWmrrfsY0elgC7qTG86qOiHfi4PJxJNg9iach1eiVcPoj9z3rpqiz
         PzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26TyGzEQOrd5z4Yqv0QtY964mBSanxHadXuOQeTsi90=;
        fh=+LT/MNFkpxGRVtC/UwpjNkpXUaVacEyeZgiYsrE6EyA=;
        b=lBZ2B4XYSOou7AUHJlaNSOYJN/jxIF/fOKMcwchBXLWfugsH10qb8etpNdvudUp4GT
         BDUqRGcPORC63AcoEH451P88KDICGp8yCu1v3MB77SUvbm1zFWHy0te3CzNv/0PMnb1N
         +XvS5wI3tEyLHkBP3LsdqY2Pzjo38XyYMldAmEl6KAt/pFYAdC43Me4W9ZUa9UzRDDmS
         ilQroKBqb3moyhq3t5b48M5ncYVEkHb5BTwhuFwKuMiyDrCg7YQ3rsBG5j2zfjgbjxut
         0az2ofOUT8VGPwQshghZMMWF6j6O3sOdZ0yZ1JybUTa4P8T7XGw5ASy8v6EO6cnNQFSF
         EsTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785161236; x=1785766036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26TyGzEQOrd5z4Yqv0QtY964mBSanxHadXuOQeTsi90=;
        b=VhSVuyq+JjqYQI4L4rfKIl819ACbt5z9ptWEAkcLrG8i2BMf9YGzzmlH0P1cmU5vtW
         DARsw2iwh2E5JdZ9EmkVQY+v5o+sbw2OIGGqSUV4YoErmDzbbVlNs3xybGRUMicS05Ax
         vjcW6XKc0W8sYXmu3ToeoFTbGW5yqn6e8fVH3Tz/jViHXgqVpXLjHzMy+BAcgFErAHM+
         nsYXHYq0P0GVnMnSSJUxyh2zOMtYp5L/8OtO0lZzl1XUGE9CSQOhHYRERUTORlVTpkHo
         dv/98V4vknJrDTDTsVcMclDWcjeU6VNUnb/kow3V4/mrUeFE7poCEa5Y5/K5hhQplzN5
         nGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161236; x=1785766036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26TyGzEQOrd5z4Yqv0QtY964mBSanxHadXuOQeTsi90=;
        b=LPrMHNs6wB1/tsb877pVQTjMNuSRunj9JwfMIiiX+OYVbCVhXlOQ1tFEaDd94tHZkV
         PyRf3gV/QeDl4+Rp+XaUPPPs4LE8iqSZDyFau6/osXw3dQT0hjo2TR9W0L9AxCecYIG8
         uouH7yxFSjyfAuaq+1oN/rV/0C5chasLGajVrD6CMIr996XIzIMCxEd56P6YE8Pqk/vk
         TkQBCwH+Y7spukf64U1qqHTkWHT+A+0z7SCjxNTDg4tx46MIwauqgyR9Hjmszj6JgVxj
         /Go5ObLa81VYyA374BkZfuqaNCUK0sCi1+0XP7h4s72yfhajcWL//S61raWD07bfQPxh
         Qmzw==
X-Gm-Message-State: AOJu0YxzworGljI1H8i3gc9aKnL6rxpxMR5gTrU2aKyL/y60uRRa90R/
	Tsezs4oArifLJ1jlZDjmP+zbz90RSh7C76i4SkHkJhZzZaFeV8wGa+W6Kng1Ls9NULvsAW3pwHC
	EQSEXpnQlYCYS3N7eqzi728LUsfC4JNTnwhg5
X-Gm-Gg: AR+sD12EBPdv777eGoihnGX2cE3RLVBinQDbOPRZ0LrB34RcvRtFtDCD6BAjgMY4Aei
	5t6QFuqhVR51E5Q2JaPR4VTcqu6R8LoFPbQCHc7yp8WUxI9Ubkkb4qLyCfvJrIwQvm8WKEolEgA
	nfDyMRrWbwVYYDOtsEeiTvhaUWNhSUOG3Yq1uIVYPfZe6LEj+bj9Lb+akVscu3emLWg2axPtWgP
	iny/ah2+EqaDR9uFTrcVSlVbILtgWh1qGIJ9eCEjYmR7lRV7pzuvC2GM633wg==
X-Received: by 2002:a05:6870:4cc4:b0:452:213:bd4d with SMTP id
 586e51a60fabf-457f2463d10mr7089186fac.17.1785161236295; Mon, 27 Jul 2026
 07:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <al3iovNANKgakpTt@suse.com>
In-Reply-To: <al3iovNANKgakpTt@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 10:07:05 -0400
X-Gm-Features: AUfX_mykRbBiorLY2JM-QaoSTCro6zCATg_PxIVmiym6NAf5JqrF0GfXzb_B95w
Message-ID: <CAEjxPJ64pR8QqO-+iBbUfFFajZoPz1buUsJ3ZUDnraU=rjouqg@mail.gmail.com>
Subject: Re: SELinux Userspace Utilities: Local Denial-of-Service Attack
 Vectors in seunshare in release 3.10
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org, Matthias Gerstner <mgerstner@suse.de>, 
	James Carter <jwcart2@gmail.com>, Jason Zaman <jason@perfinion.com>, 
	Petr Lautrbach <lautrbach@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, we have published upstream security advisories for these issues
on GitHub at:
https://github.com/SELinuxProject/selinux/security/advisories?state=3Dpubli=
shed

Thanks again for reporting them.

On Mon, Jul 20, 2026 at 4:56=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> In case you missed it on OSS
>
> ----- Forwarded message from Matthias Gerstner <mgerstner@suse.de> -----
>
> Date: Wed, 15 Jul 2026 12:48:22 +0200
> From: Matthias Gerstner <mgerstner@suse.de>
> To: oss-security@lists.openwall.com
> Reply-To: oss-security@lists.openwall.com
> Subject: [oss-security] SELinux Userspace Utilities: Local Denial-of-Serv=
ice Attack Vectors in seunshare in release 3.10
>
> Hello list,
>
> this is a report about Denial-of-Service issues in the `seunshare`
> setuid-root program. We also offer a rendered HTML version of this
> report on our blog [1].
>
> Summary: seunshare is a setuid-root utility used for sandboxing
> untrusted applications based on Linux namespaces and SELinux policies.
> During a code review we identified two local Denial-of-Service attack
> vectors in version 3.10 of the utility.
>
> 1) Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The `seunshare` program [2] is part of the SELinux [3] "sandbox"
> feature, which is used to confine untrusted programs using Linux mount
> namespaces and restrictive SELinux policies. The program is designed to
> be installed with setuid-root privileges, accessible to all users in the
> system.
>
> We have been asked to review the program's security [4] with the
> intention of assigning the setuid bit to it on SUSE distributions in the
> future. Fedora Linux already ships this program with setuid-root
> enabled; other SELinux-enabled Linux distributions may do so as well.
>
> During our review of the utility's code [5] in version 3.10 [6] of the
> SELinux userspace utilities we identified two local Denial-of-Service
> attack vectors, which will be described in detail in the following
> sections. Upstream independently fixed these issues in version 3.11 [7],
> without clearly marking them as security issues, however.
>
> The rest of this report is based on version 3.10 of the codebase of
> `seunshare`.
>
> 2) Design Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The `seunshare` program is relatively small, consisting of about 1,000
> lines of C code. The elevated `root` privileges are primarily needed to
> setup a custom mount namespace for the sandbox environment.
>
> The program accepts a range of command line arguments which, among
> others, allow to request dedicated directories to be used for the
> following paths inside the sandbox:
>
> - the user's home directory.
> - the `/tmp` directory.
> - the `/run/user/<uid>` directory.
>
> For the `/run` and `/tmp` directories, the source paths specified by the
> user are copied into a random temporary directory in the initial mount
> namespace under `/tmp/.sandbox-<label>-XXXXXX` using the `rsync`
> program. These directories are then bind-mounted into the sandbox's
> mount namespace to appear at the expected locations.
>
> A lot of code in `seunshare` is concerned with securely maintaining
> these temporary directories. To allow the sandbox environment to modify
> the directory contents, `seunshare` assigns group write permissions for
> the real group ID of the calling user, as shown in this example:
>
>     drwxrwx--T. 2 root user 80 Jul  8 16:11 /tmp/.sandbox-user-OaxmUp/
>
> To safely access user-provided paths, the program flips its filesystem
> UID [8] to the real UID of the calling user and back to `root`, as
> needed.
>
> 3) Security Issues
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Since `seunshare` is supposed to run on SELinux-enabled systems, it is
> important to understand what kind of privilege escalation can be
> achieved when vulnerabilities are exploited in a setuid-root binary like
> this. Many SELinux-enabled systems, such as Fedora and openSUSE, ship
> with the "targeted" SELinux policy by default. This policy is focused on
> confining well-known system services, but assigns an unconfined SELinux
> context to interactive users by default to achieve a balance between
> security and usability.
>
> There is currently no domain transition from the unconfined domain to
> the more restricted `seunshare_t` defined in the SELinux policy for
> `seunshare`. This means the execution of `seunshare` continues in the
> unconfined domain. Thus in the context of attacks carried out by
> interactive users, the impact of the vulnerabilities below will be a
> root-like privilege escalation despite the system running in SELinux
> enforced mode.
>
> 3.1) Local File Deletion Attack Vector in `rm_rf()`
> ---------------------------------------------------
>
> The function `rm_rf()` [9] is called at the end of the utility's
> execution to recursively remove temporary directory trees. While a
> comment in the function suggests that no symbolic links would be
> followed by this routine, the reality is that the `openat()` [10] system
> call is lacking the `O_NOFOLLOW` flag. This creates a race condition
> during the recursion of the `rm_rf()` function:
>
> - first an `fstatat()` is performed for directory contents obtained from
>   `readdir()` to safely determine whether an entry refers to a
>   sub-directory.
> - when a directory is encountered the unsafe `openat()` happens,
>   allowing the unprivileged user to replace the directory entry by a
>   symbolic link in the meantime. While the `O_DIRECTORY` flag is passed
>   to `openat()`, symbolic links in the target are still followed, as
>   long as they point to a directory.
>
> When the user calling `seunshare` is running in the unconfined SELinux
> domain, arbitrary `root`-owned files can be deleted this way. The
> vulnerability does not allow to delete arbitrary files of other users,
> however, because `seunshare` drops all capabilities [11] before calling
> `rm_rf()`.  This leaves the process in a somewhat strange state of
> privilege: it can no longer override discretionary access control (DAC)
> but it is still allowed to operate on files owned by the filesystem-uid
> of the privileged process, which is 0 during the invocation of
> `rm_rf()`.
>
> We developed a reproducer for this issue (attached to this email), which
> succeeds in executing the exploit quickly after some fine tuning of the
> timing for the target system. We verified that the reproducer works on
> current openSUSE Tumbleweed with policycoreutils 3.10 and the
> setuid-root bit enabled on `seunshare`. It does not work on current
> Fedora 44, as it seems Fedora backported a patch to fix this issue (it
> passes `O_NOFOLLOW` to the `openat()` call in question).
>
> Upstream fixed this issue in commit 38f0a4d9a [12] which is part of of
> the 3.11 upstream release.
>
> 3.2) Process Kill Attack Vector in `killall()`
> ----------------------------------------------
>
> `seunshare` offers `--kill` and `-Z` switches as documented in its man
> page:
>
>     -k --kill
>            Kill all processes with matching MCS level
>
>     -Z context
>            Use alternate SELinux context while running the executable
>
> Both switches combined cause the `killall()` [13] function to kill all
> processes running with the user-provided SELinux context. This does not
> fully work for arbitrary target processes due to SELinux access control;
> however, if the calling user is running in unconfined context (as
> explained previously) it allows to kill e.g. `root`-owned processes
> running also in unconfined context.  Once the algorithm reaches its own
> PID (if the context matches), it kills itself, thus it is possible that
> only a certain range of PIDs can be killed this way depending on the PID
> selection order of the algorithm in `killall()`.
>
> We have been able to reproduce the issue both on openSUSE and on Fedora
> 44 using a command line like this:
>
>     seunshare --kill -Z unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c=
1023 \
>         -t ~/some-dir/ -- /usr/bin/true
>
> Upstream fixed this issue by dropping the `--kill` switch and the
> `killall()` function in commit 572db2fa [14].
>
> 4) Remaining Concerns
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The code of `seunshare` has seen major changes between version 3.10 and
> 3.11 of the SELinux userspace utilities. The new version of the program
> improves on various aspects of the code; generally the code shows
> awareness of various filesystem-related security concerns that are
> relevant for setuid-root binaries. Still a number of concerns remain:
>
> - Data which is modified in temporary directories within the sandbox is
>   transparently copied back [15] into the calling user's source
>   directory via `rsync`. Since the program is untrusted it can
>   potentially create all kinds of dangerous files, which will now reside
>   e.g. in the user's regular home directory and could lead to security
>   issues at a later time when accessed without care.
> - The code flips the filesystem UID a lot to temporarily drop root
>   privileges for file operations. This logic is hard to follow in parts
>   and leaves the process in an unusual state of privilege, as the
>   effective UID is still 0; during the first stages of the program it
>   also still has all capabilities. Due to the filesystem UID being set
>   to the real user's UID, file operations are carried out using the
>   calling user's lower privileges, however. From a design point of view
>   it would be preferable to let the process operate in an unprivileged
>   state by default (effective UID and GID set to the real UID and GID).
>   Privileges could then be raised for the few operations that actually
>   need `root` privileges.
> - The code currently lacks some common security precautions for
>   setuid-root programs:
>   - while a new environment variable block is set up to execute the
>     untrusted target program, the privileged parent process keeps the
>     untrusted environment variables of the calling user in place. These
>     are also inherited to tools like `rsync` that are invoked for the
>     purposes of setting up the sandbox. While this is not an issue at
>     the moment, it could turn into a security issue at a later time when
>     the code changes.
>   - the `umask()` of the process is also kept unchanged, inheriting
>     whatever the unprivileged parent process configured. This can cause
>     files to receive world-readable or world-writable bits leading to
>     unexpected attack vectors.
>
> 5) CVE Assignments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We approached the upstream SELinux userspace utilities developers and
> suggested to assign CVEs for the two issues discussed above. Upstream
> informed us that they don't take care of CVE assignment themselves,
> however. Since Red Hat developers are also involved with upstream
> development, we are currently waiting for an agreement on who will
> assign CVEs to avoid duplicates.
>
> 6) Timeline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 2026-07-03: We (mistakenly) approached the SELinux kernel code maintainer=
,
>     asking for CVE assignments for these issues which have meanwhile been
>     fixed in the 3.11 upstream release.
>
> 2026-07-03: The SELinux kernel code maintainer forwarded our report to th=
e
>     maintainers of the userspace utilities.
>
> 2026-07-06: An SELinux userspace developer informed us that the project
>     is not actively assigning CVEs.
>
> 2026-07-07: We responded that we would be able to assign CVEs on our
>     end, but would like to avoid a clash with any CVE assignment plans on
>     the end of Red Hat developers working on SELinux. We thus asked for
>     clarification of who will take care of it.
>
> 2026-07-15: Publication of this report.
>
> 7) References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [1]: https://security.opensuse.org/2026/07/15/selinux-seunshare.html
> [2]: https://man7.org/linux/man-pages/man8/seunshare.8.html
> [3]: https://github.com/SELinuxProject/selinux
> [4]: https://bugzilla.suse.com/show_bug.cgi?id=3D1268256
> [5]: https://github.com/SELinuxProject/selinux/blob/3.10/sandbox/seunshar=
e.c
> [6]: https://github.com/SELinuxProject/selinux/releases/tag/3.10
> [7]: https://github.com/SELinuxProject/selinux/releases/tag/3.11
> [8]: https://man7.org/linux/man-pages/man2/setfsuid.2.html
> [9]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41d=
2499127c18ad0643f9e/sandbox/seunshare.c#L419
> [10]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41=
d2499127c18ad0643f9e/sandbox/seunshare.c#L431
> [11]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41=
d2499127c18ad0643f9e/sandbox/seunshare.c#L1069
> [12]: https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd24=
72d4502842df5d5b8255a8
> [13]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41=
d2499127c18ad0643f9e/sandbox/seunshare.c#L662
> [14]: https://github.com/SELinuxProject/selinux/commit/572db2fae9157ae620=
160e0d7b2c3f8b75fe6c1a
> [15]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41=
d2499127c18ad0643f9e/sandbox/seunshare.c#L484
>
> Best Regards
>
> Matthias
>
> --
> Matthias Gerstner <matthias.gerstner@suse.de>
> Security Engineer
> https://www.suse.com/security
> GPG Key ID: 0x14C405C971923553
>
> SUSE Software Solutions Germany GmbH
> HRB 36809, AG N=C3=BCrnberg
> Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald
>
>
>
>
>
> ----- End forwarded message -----
>
> Johannes
> --
> GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
> Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
> SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnber=
g, Germany
> www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, A=
bhinav Puri, (HRB 36809, AG N=C3=BCrnberg)
>
