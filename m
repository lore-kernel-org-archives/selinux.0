Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067573955D8
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627624; cv=none; b=Z3QI1qm4T0TjzJ5X3Rr9l/RRbNkYiIWarts2neoMOzXKuT3BcnFhCF4ApvvDy8Vyg5SAgAYuJcyhxsca5JDh/ZDSGSdhEkKgg8vyeC+Dn8UggjgwoAQdw1qe0yBgA4QFF4gFIBQQextVAiDMKR1xfQhifh9p9tdhkElTSuXqoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627624; c=relaxed/simple;
	bh=Z+TcMjmIXafsKq2XQ6sIE0QIeVc3ReARr0L8L/jtK0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IESvbCq2lcKlCYqIwVibvFkUv9goj8C0xVKW7Myp2pH0olQrVdfXYseD6pR53Eeo/JNixOPexU1ZX7AmNUO+vAcXpjNlPFXA+vm+u9yQ7VDBBGCrbZ0k094wl4L3AzdIInTL9c7s2AQifaasexvbcgoTEUX9mTLsblBmA56dIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=Kucxi6dd; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="Kucxi6dd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1786627611;
	bh=Z+TcMjmIXafsKq2XQ6sIE0QIeVc3ReARr0L8L/jtK0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kucxi6ddzQGHH90/euHKYjnYMkkjP93GPt8E9wQJMoHiqiMbAEUN4NFiqx8duF9D9
	 VOpLzbwqQYPr3fQb45h0bageTwpPwxWZTU+Om3GHm5bIoltAjgenaYsA/6U166lODj
	 2JNwdrI3ZMZP9oxsnpayaRCjfyJvosU8EI9G7qTg=
Received: from nimbus (nimbus.defensec.nl [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id E22282E0F5C;
	Thu, 13 Aug 2026 15:26:51 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Jan Janasek <jjanasek@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: [Discussion] systemd-run0 policy issue
In-Reply-To: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
	(Jan Janasek's message of "Thu, 13 Aug 2026 15:09:58 +0200")
References: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
Date: Thu, 13 Aug 2026 15:26:51 +0200
Message-ID: <871pc2qhgk.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jan Janasek <jjanasek@redhat.com> writes:

> Hi everyone,
>
> (I originally posted this to the fedora selinux list, but was advised
> that this is the proper ML for such architectural discussions.)
>
> We=E2=80=99ve been analyzing the integration of systemd-run0 with SELinux=
 and
> hit a fundamental architectural roadblock, related to bug
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2359828. Unlike sudo,
> where the parent process is the user's shell (allowing PAM to easily
> calculate and transition the context), run0 delegates execution via
> D-Bus to PID 1 (init_t). This breaks standard SELinux PAM transitions
> and creates a severe design challenge for maintaining user isolation.
> (Currently, wrapping commands via run0 --via-shell acts as a temporary
> workaround, but we are looking for a robust architectural fix.)
>
> When pam_selinux.so attempts to transition the user directly into
> their target domain over a specific binary, it immediately triggers
> strict policy conflicts. To demonstrate the exact mechanics of what
> happens when PAM forces this transition, I wrote a Python reproducer
> (labeled as bin_t and running in the unconfined_t domain) that uses
> setexeccon to simulate a transition (e.g., to staff_t) and then calls
> os.execl("/usr/bin/dnf5", ...). It triggers these distinct SELinux
> denials:
>
> # 1. The Transition Denial: The kernel blocks the domain transition
> type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:636) : avc:  denied  {
> transition } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
> dev=3D"nvme0n1p2" ino=3D146474
> scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=3Dprocess
> permissive=3D1
>
> # 2. The Entrypoint Denial: The target domain lacks entrypoint
> permissions on the binary
> type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:637) : avc:  denied  {
> entrypoint } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
> dev=3D"nvme0n1p2" ino=3D146474
> scontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023
> tcontext=3Dsystem_u:object_r:rpm_exec_t:s0 tclass=3Dfile permissive=3D1
>
> Fixing this purely in the Base Policy would require writing transition
> and entrypoint rules for every single interactive tool a user might
> run. This is unmaintainable, massively expands the attack surface, and
> breaks the principle of least privilege.
>
> We explored a few potential ways to handle this and would like the
> community's input:
>
> 1. SELinux-aware run0 (Upstream fix). Modify run0/systemd to be
> natively SELinux-aware. Instead of relying blindly on pam_selinux.so
> (which only sees init_t as the caller), run0 could dynamically
> calculate the correct target context based on the originating user's
> session and explicitly set it for the execution (e.g., via the
> SELinuxContext=3D property of the transient unit).
> 2. Leave pam_selinux.so commented out in /lib/pam.d/systemd-run0. If
> we leave pam_selinux.so disabled in the run0 PAM stack, processes
> simply inherit init_t. This means we would have to write static
> type_transition rules into the base policy for every single
> interactive binary users might run. (For example, run0 dnf only works
> right now because an init_t -> rpm_exec_t transition historically
> exists).
> 3. Enable PAM + Explicit Default Contexts (A Flawed PoC). We tried
> keeping pam_selinux.so enabled and explicitly defining the transition
> path in /etc/selinux/targeted/contexts/users/unconfined_u:
> system_r:init_t:s0 unconfined_r:systemd_run_t:s0
> unconfined_r:unconfined_t:s0 While this correctly routes run0 payloads
> into an isolated domain (systemd_run_t) without polluting init_t, it
> causes unacceptable collateral damage. The SELinux get_default_context
> API only sees the caller (init_t) and the user (unconfined_u). Because
> run0 sessions and systemd --user sessions share these exact same
> inputs, this global mapping breaks systemd --user instances by
> throwing them into systemd_run_t instead of unconfined_t.
>
> Given that we cannot safely rely on global policy rules (which expands
> PID 1's attack surface) or PAM default contexts (which breaks user
> sessions), we'd love to hear your thoughts. Are there other approaches
> or configuration options we might have missed? Or is pushing for run0
> to become natively SELinux-aware the most viable path forward?
>
> Any thoughts or guidance would be greatly appreciated.

I brought this up before too:
https://github.com/SELinuxProject/selinux/issues/485

My idea was to extend pam_selinux context configuration with a optional
"pamname" field. As far as I know that can be retrieved by libpam and then
be associated with a context based on a combination of source, target and
now also optionally pamname.

system_u:system_r:init_t:s0 user_r:user_systemd_t:s0 "systemd-user"
system_u:system_r:init_t:s0 user_r:user_t:s0 "systemd-run0"

This could then also nicely work natively with systemd's PAMName=3D
functionality.

... In theory at least and that is all that is.

>
> Best regards,
> Jan Janasek
>
>

--=20
gpg --auto-key-locate clear,nodefault,wkd --locate-external-keys dominick.g=
rift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
