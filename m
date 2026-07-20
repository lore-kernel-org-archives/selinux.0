Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0B225775
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537773; cv=none; b=cJ3Bo/KUS/GaYMWi0dgTb/ZnWedclPltk275RsTtD1BgxMLImcQU0A+cStZpA1XLJQz14PnSluJ8ChkOwEHLpJesN6/DeMUChJJWhg0a+aWBDKoCUyGjhfxGDt/2gDO+8gES+YokZObDrMlmJLA7Crml+8YORjoIWYoXfnlUoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537773; c=relaxed/simple;
	bh=+S3OGcN+4WVApDY8S4UoRqDMOl9MrUK/raXAwgTPeM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rgHuHUF1vExabLpdjVcSc8QbHtjLaRmVZChB5g6yR3tYiVsNnq4g+1t5DK4ts2Knnm+70C0zvxmHZNmkyMf1fJptJ56buvXclNC+VAoHMx48VP2TFZWTeaM6QSLntQAHlfk3mmPN+3Xf89r3hW0oRuH7iigAQnoB0sowLFu/0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zF56Z9PR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qJ5LUOSt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zF56Z9PR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qJ5LUOSt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zF56Z9PR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qJ5LUOSt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zF56Z9PR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qJ5LUOSt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20D533DFC;
	Mon, 20 Jul 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784537764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xl6Wt0h2ZLRz63AJILtYGqOX7cgt41euJAUeDPasQMo=;
	b=zF56Z9PRROz8G1BPkFaV5Q1gB21AJ9mojOEd50aee0OKa1EQpzQYXrTZBc1g7iR7gb7p96
	y+gJlHUeIyev29GgxZS6jwBqDEicFpoe3ynhadesoBISawBE8wa7JNVvTjTQHxMVY0/BRx
	VL2Za1laKaq1t3xzqsUbo45BTbW94/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784537764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xl6Wt0h2ZLRz63AJILtYGqOX7cgt41euJAUeDPasQMo=;
	b=qJ5LUOStglwfXBFjFkKxiv0rKiLOFZDV0u4a6jhOggUBLrGSx2413PsLl7RD98OE6q38x/
	nrcXUt5fn4uRWeBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784537764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xl6Wt0h2ZLRz63AJILtYGqOX7cgt41euJAUeDPasQMo=;
	b=zF56Z9PRROz8G1BPkFaV5Q1gB21AJ9mojOEd50aee0OKa1EQpzQYXrTZBc1g7iR7gb7p96
	y+gJlHUeIyev29GgxZS6jwBqDEicFpoe3ynhadesoBISawBE8wa7JNVvTjTQHxMVY0/BRx
	VL2Za1laKaq1t3xzqsUbo45BTbW94/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784537764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xl6Wt0h2ZLRz63AJILtYGqOX7cgt41euJAUeDPasQMo=;
	b=qJ5LUOStglwfXBFjFkKxiv0rKiLOFZDV0u4a6jhOggUBLrGSx2413PsLl7RD98OE6q38x/
	nrcXUt5fn4uRWeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04F29779AA;
	Mon, 20 Jul 2026 08:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id krJ3O6PiXWr4AwAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Mon, 20 Jul 2026 08:56:03 +0000
Date: Mon, 20 Jul 2026 10:56:02 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Cc: Matthias Gerstner <mgerstner@suse.de>
Subject: SELinux Userspace Utilities: Local Denial-of-Service Attack Vectors
 in seunshare in release 3.10
Message-ID: <al3iovNANKgakpTt@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G135DQ0MmJfKZY1J"
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -6.40
X-Spamd-Result: default: False [-6.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,opensuse.org:url,suse.com:mid,suse.com:url,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Level: 


--G135DQ0MmJfKZY1J
Content-Type: multipart/mixed; boundary="WcFHN6HtIvL3jPgt"
Content-Disposition: inline


--WcFHN6HtIvL3jPgt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In case you missed it on OSS

----- Forwarded message from Matthias Gerstner <mgerstner@suse.de> -----

Date: Wed, 15 Jul 2026 12:48:22 +0200
=46rom: Matthias Gerstner <mgerstner@suse.de>
To: oss-security@lists.openwall.com
Reply-To: oss-security@lists.openwall.com
Subject: [oss-security] SELinux Userspace Utilities: Local Denial-of-Servic=
e Attack Vectors in seunshare in release 3.10

Hello list,

this is a report about Denial-of-Service issues in the `seunshare`
setuid-root program. We also offer a rendered HTML version of this
report on our blog [1].

Summary: seunshare is a setuid-root utility used for sandboxing
untrusted applications based on Linux namespaces and SELinux policies.
During a code review we identified two local Denial-of-Service attack
vectors in version 3.10 of the utility.

1) Introduction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The `seunshare` program [2] is part of the SELinux [3] "sandbox"
feature, which is used to confine untrusted programs using Linux mount
namespaces and restrictive SELinux policies. The program is designed to
be installed with setuid-root privileges, accessible to all users in the
system.

We have been asked to review the program's security [4] with the
intention of assigning the setuid bit to it on SUSE distributions in the
future. Fedora Linux already ships this program with setuid-root
enabled; other SELinux-enabled Linux distributions may do so as well.

During our review of the utility's code [5] in version 3.10 [6] of the
SELinux userspace utilities we identified two local Denial-of-Service
attack vectors, which will be described in detail in the following
sections. Upstream independently fixed these issues in version 3.11 [7],
without clearly marking them as security issues, however.

The rest of this report is based on version 3.10 of the codebase of
`seunshare`.

2) Design Overview
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The `seunshare` program is relatively small, consisting of about 1,000
lines of C code. The elevated `root` privileges are primarily needed to
setup a custom mount namespace for the sandbox environment.

The program accepts a range of command line arguments which, among
others, allow to request dedicated directories to be used for the
following paths inside the sandbox:

- the user's home directory.
- the `/tmp` directory.
- the `/run/user/<uid>` directory.

For the `/run` and `/tmp` directories, the source paths specified by the
user are copied into a random temporary directory in the initial mount
namespace under `/tmp/.sandbox-<label>-XXXXXX` using the `rsync`
program. These directories are then bind-mounted into the sandbox's
mount namespace to appear at the expected locations.

A lot of code in `seunshare` is concerned with securely maintaining
these temporary directories. To allow the sandbox environment to modify
the directory contents, `seunshare` assigns group write permissions for
the real group ID of the calling user, as shown in this example:

    drwxrwx--T. 2 root user 80 Jul  8 16:11 /tmp/.sandbox-user-OaxmUp/

To safely access user-provided paths, the program flips its filesystem
UID [8] to the real UID of the calling user and back to `root`, as
needed.

3) Security Issues
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Since `seunshare` is supposed to run on SELinux-enabled systems, it is
important to understand what kind of privilege escalation can be
achieved when vulnerabilities are exploited in a setuid-root binary like
this. Many SELinux-enabled systems, such as Fedora and openSUSE, ship
with the "targeted" SELinux policy by default. This policy is focused on
confining well-known system services, but assigns an unconfined SELinux
context to interactive users by default to achieve a balance between
security and usability.

There is currently no domain transition from the unconfined domain to
the more restricted `seunshare_t` defined in the SELinux policy for
`seunshare`. This means the execution of `seunshare` continues in the
unconfined domain. Thus in the context of attacks carried out by
interactive users, the impact of the vulnerabilities below will be a
root-like privilege escalation despite the system running in SELinux
enforced mode.

3.1) Local File Deletion Attack Vector in `rm_rf()`
---------------------------------------------------

The function `rm_rf()` [9] is called at the end of the utility's
execution to recursively remove temporary directory trees. While a
comment in the function suggests that no symbolic links would be
followed by this routine, the reality is that the `openat()` [10] system
call is lacking the `O_NOFOLLOW` flag. This creates a race condition
during the recursion of the `rm_rf()` function:

- first an `fstatat()` is performed for directory contents obtained from
  `readdir()` to safely determine whether an entry refers to a
  sub-directory.
- when a directory is encountered the unsafe `openat()` happens,
  allowing the unprivileged user to replace the directory entry by a
  symbolic link in the meantime. While the `O_DIRECTORY` flag is passed
  to `openat()`, symbolic links in the target are still followed, as
  long as they point to a directory.

When the user calling `seunshare` is running in the unconfined SELinux
domain, arbitrary `root`-owned files can be deleted this way. The
vulnerability does not allow to delete arbitrary files of other users,
however, because `seunshare` drops all capabilities [11] before calling
`rm_rf()`.  This leaves the process in a somewhat strange state of
privilege: it can no longer override discretionary access control (DAC)
but it is still allowed to operate on files owned by the filesystem-uid
of the privileged process, which is 0 during the invocation of
`rm_rf()`.

We developed a reproducer for this issue (attached to this email), which
succeeds in executing the exploit quickly after some fine tuning of the
timing for the target system. We verified that the reproducer works on
current openSUSE Tumbleweed with policycoreutils 3.10 and the
setuid-root bit enabled on `seunshare`. It does not work on current
Fedora 44, as it seems Fedora backported a patch to fix this issue (it
passes `O_NOFOLLOW` to the `openat()` call in question).

Upstream fixed this issue in commit 38f0a4d9a [12] which is part of of
the 3.11 upstream release.

3.2) Process Kill Attack Vector in `killall()`
----------------------------------------------

`seunshare` offers `--kill` and `-Z` switches as documented in its man
page:

    -k --kill
           Kill all processes with matching MCS level
   =20
    -Z context
           Use alternate SELinux context while running the executable

Both switches combined cause the `killall()` [13] function to kill all
processes running with the user-provided SELinux context. This does not
fully work for arbitrary target processes due to SELinux access control;
however, if the calling user is running in unconfined context (as
explained previously) it allows to kill e.g. `root`-owned processes
running also in unconfined context.  Once the algorithm reaches its own
PID (if the context matches), it kills itself, thus it is possible that
only a certain range of PIDs can be killed this way depending on the PID
selection order of the algorithm in `killall()`.

We have been able to reproduce the issue both on openSUSE and on Fedora
44 using a command line like this:

    seunshare --kill -Z unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c10=
23 \
        -t ~/some-dir/ -- /usr/bin/true

Upstream fixed this issue by dropping the `--kill` switch and the
`killall()` function in commit 572db2fa [14].

4) Remaining Concerns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The code of `seunshare` has seen major changes between version 3.10 and
3.11 of the SELinux userspace utilities. The new version of the program
improves on various aspects of the code; generally the code shows
awareness of various filesystem-related security concerns that are
relevant for setuid-root binaries. Still a number of concerns remain:

- Data which is modified in temporary directories within the sandbox is
  transparently copied back [15] into the calling user's source
  directory via `rsync`. Since the program is untrusted it can
  potentially create all kinds of dangerous files, which will now reside
  e.g. in the user's regular home directory and could lead to security
  issues at a later time when accessed without care.
- The code flips the filesystem UID a lot to temporarily drop root
  privileges for file operations. This logic is hard to follow in parts
  and leaves the process in an unusual state of privilege, as the
  effective UID is still 0; during the first stages of the program it
  also still has all capabilities. Due to the filesystem UID being set
  to the real user's UID, file operations are carried out using the
  calling user's lower privileges, however. From a design point of view
  it would be preferable to let the process operate in an unprivileged
  state by default (effective UID and GID set to the real UID and GID).
  Privileges could then be raised for the few operations that actually
  need `root` privileges.
- The code currently lacks some common security precautions for
  setuid-root programs:
  - while a new environment variable block is set up to execute the
    untrusted target program, the privileged parent process keeps the
    untrusted environment variables of the calling user in place. These
    are also inherited to tools like `rsync` that are invoked for the
    purposes of setting up the sandbox. While this is not an issue at
    the moment, it could turn into a security issue at a later time when
    the code changes.
  - the `umask()` of the process is also kept unchanged, inheriting
    whatever the unprivileged parent process configured. This can cause
    files to receive world-readable or world-writable bits leading to
    unexpected attack vectors.

5) CVE Assignments
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We approached the upstream SELinux userspace utilities developers and
suggested to assign CVEs for the two issues discussed above. Upstream
informed us that they don't take care of CVE assignment themselves,
however. Since Red Hat developers are also involved with upstream
development, we are currently waiting for an agreement on who will
assign CVEs to avoid duplicates.

6) Timeline
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

2026-07-03: We (mistakenly) approached the SELinux kernel code maintainer,
    asking for CVE assignments for these issues which have meanwhile been
    fixed in the 3.11 upstream release.

2026-07-03: The SELinux kernel code maintainer forwarded our report to the
    maintainers of the userspace utilities.

2026-07-06: An SELinux userspace developer informed us that the project
    is not actively assigning CVEs.

2026-07-07: We responded that we would be able to assign CVEs on our
    end, but would like to avoid a clash with any CVE assignment plans on
    the end of Red Hat developers working on SELinux. We thus asked for
    clarification of who will take care of it.

2026-07-15: Publication of this report.

7) References
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[1]: https://security.opensuse.org/2026/07/15/selinux-seunshare.html
[2]: https://man7.org/linux/man-pages/man8/seunshare.8.html
[3]: https://github.com/SELinuxProject/selinux
[4]: https://bugzilla.suse.com/show_bug.cgi?id=3D1268256
[5]: https://github.com/SELinuxProject/selinux/blob/3.10/sandbox/seunshare.c
[6]: https://github.com/SELinuxProject/selinux/releases/tag/3.10
[7]: https://github.com/SELinuxProject/selinux/releases/tag/3.11
[8]: https://man7.org/linux/man-pages/man2/setfsuid.2.html
[9]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41d24=
99127c18ad0643f9e/sandbox/seunshare.c#L419
[10]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41d2=
499127c18ad0643f9e/sandbox/seunshare.c#L431
[11]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41d2=
499127c18ad0643f9e/sandbox/seunshare.c#L1069
[12]: https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472=
d4502842df5d5b8255a8
[13]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41d2=
499127c18ad0643f9e/sandbox/seunshare.c#L662
[14]: https://github.com/SELinuxProject/selinux/commit/572db2fae9157ae62016=
0e0d7b2c3f8b75fe6c1a
[15]: https://github.com/SELinuxProject/selinux/blob/ca10fc4204ed60540d41d2=
499127c18ad0643f9e/sandbox/seunshare.c#L484

Best Regards

Matthias

--=20
Matthias Gerstner <matthias.gerstner@suse.de>
Security Engineer
https://www.suse.com/security
GPG Key ID: 0x14C405C971923553
=20
SUSE Software Solutions Germany GmbH
HRB 36809, AG N=FCrnberg
Gesch=E4ftsf=FChrer: Jochen Jaser, Andrew McDonald





----- End forwarded message -----

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=FCrnberg, Ge=
rmany
www.suse.com, Gesch=E4ftsf=FChrer: Jochen Jaser, Andrew McDonald, Abhinav P=
uri, (HRB 36809, AG N=FCrnberg)


--WcFHN6HtIvL3jPgt
Content-Type: application/gzip
Content-Disposition: attachment; filename=seunshare-reproducer.tar.gz
Content-Transfer-Encoding: base64

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

--WcFHN6HtIvL3jPgt--

--G135DQ0MmJfKZY1J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpd4qIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mGhQQALobhBLsBgTFg84GedQv
mtnHnjBBYhOw9+VJG6ZCM1wLwyrgeLBTFzu1ViSg/IUQ3/bAydEO8LSrzt+gWVKH
aMfg8IDdQVQjYIz64poVQDhsznIjaiXs+3lTX8Mic3tbHkIb0Ft+r3R7BBzNHaPP
QIPjYm019SOvdO4gDDp+kaNYZMB9exoDdTlKWskTp4NY4X7esu2lS1PZeSkWdVuP
pLjXym1juL8rmORWw5AMsaZPb/AXtMpeoFLeZHwuhbjVAkpM5O+QK33Q9IPEFed1
H/vH7Fr35Jmu7tLBpp5YZNVIvb3eK7nK3CDrpss73WzG16vI2NIq9s3ugL4EAYKo
Gr03rryqT8QjWAP795sFudBhHGEiLG9JAo3DIpRg2gBSlXHDSICOvMICnrqtCwEh
Sxnii/XxZ9lkBAuyyu/Zm35duX46mHrLcL851w0s8+D68+/QGVzkZVbMeElSPdRm
chRZxkKke0c+Gy4TeOOm5i8RlnqTXGw+M1OeFZtM0uxEg9afx1qJjMu0PGGR5Fx2
GERvZMUj6esWcI0IKp/Ynz3gLCTZW5D8FYiTrVR91YrAaFhYsXyYVqp9RcH8xnu5
sXAxsnOWM9TWBkNlT5E/dsXLHTbkLMqIwOm4m2twEwD4+C1GDp2kBm7nDx6SSs+N
umbiU1UVdxbVT3zCVp14q3BH
=HZ0+
-----END PGP SIGNATURE-----

--G135DQ0MmJfKZY1J--
