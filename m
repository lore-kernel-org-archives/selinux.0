Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC2474261
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628967; cv=none; b=XMnScCa9liUmNhaqfiG1OR3WAX06lJWUsBZm/h/hFYMpMGsgXOCHjOUFUGVoGtQMi9hkozuVDLUqBwkzsq2tP8y60eHAyolNKE5O2m3clgJiZu35bLFB3N80AqDN9Dvgx0imb6LNoOo72IcsPtbbs+e8WXYspOm75C4efWCfJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628967; c=relaxed/simple;
	bh=6DV80jjfz1BlyP6n1GSLDDnO5jybRi9nfrI2Be1l/68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n45MxAaIb3GWau+6EoGeh+byf1kQxE2X+BfsPR2lSn3WuKne4m/4OahjwqK/mvFtyUbLAa5Q14if2gzVaakFeKNJXJMNNaGVp6ZmuYN9wdzN5G7ZGyih+c7xSRk8+kJPV8kVvwjXE+gzphmgSxB431ZefoOICdh6UuRIO7ehj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=eGQXXnWq; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="eGQXXnWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1786628963;
	bh=6DV80jjfz1BlyP6n1GSLDDnO5jybRi9nfrI2Be1l/68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eGQXXnWqdrfQQnm3/fTD5CCd+adx4vl11m/uzSjbB/R3yDfW9vE4kvKCaCC8RlWAV
	 qfPfbeRF3jTVtYcPb55WHhE+hlzb63n4lP77Rl+oJeKUXSujsa9ceCJbMjenza0Gdh
	 r/AFl0/25hV7r3TdC775qLDYWvUcMmhXtnf/J+nQ=
Received: from nimbus (nimbus.defensec.nl [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 8C3892E0F63;
	Thu, 13 Aug 2026 15:49:23 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jan Janasek <jjanasek@redhat.com>,  selinux@vger.kernel.org
Subject: Re: [Discussion] systemd-run0 policy issue
In-Reply-To: <CAEjxPJ6C8hcCr-WwZBehSnFRCL_5WPp5QnNWKz48Lq41wGO9uQ@mail.gmail.com>
	(Stephen Smalley's message of "Thu, 13 Aug 2026 09:40:49 -0400")
References: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
	<CAEjxPJ5-r1yNBJeVV6ouby5kCUVU6KQitv50bw=NLYEMJa9A+A@mail.gmail.com>
	<87wltup2hs.fsf@defensec.nl>
	<CAEjxPJ6C8hcCr-WwZBehSnFRCL_5WPp5QnNWKz48Lq41wGO9uQ@mail.gmail.com>
Date: Thu, 13 Aug 2026 15:49:23 +0200
Message-ID: <87se4ip1uk.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Thu, Aug 13, 2026 at 9:35=E2=80=AFAM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Thu, Aug 13, 2026 at 9:11=E2=80=AFAM Jan Janasek <jjanasek@redhat.c=
om> wrote:
>> >>
>> >> Hi everyone,
>> >>
>> >> (I originally posted this to the fedora selinux list, but was advised
>> >> that this is the proper ML for such architectural discussions.)
>> >>
>> >> We=E2=80=99ve been analyzing the integration of systemd-run0 with SEL=
inux and
>> >> hit a fundamental architectural roadblock, related to bug
>> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D2359828. Unlike sudo,
>> >> where the parent process is the user's shell (allowing PAM to easily
>> >> calculate and transition the context), run0 delegates execution via
>> >> D-Bus to PID 1 (init_t). This breaks standard SELinux PAM transitions
>> >> and creates a severe design challenge for maintaining user isolation.
>> >> (Currently, wrapping commands via run0 --via-shell acts as a temporary
>> >> workaround, but we are looking for a robust architectural fix.)
>> >>
>> >> When pam_selinux.so attempts to transition the user directly into
>> >> their target domain over a specific binary, it immediately triggers
>> >> strict policy conflicts. To demonstrate the exact mechanics of what
>> >> happens when PAM forces this transition, I wrote a Python reproducer
>> >> (labeled as bin_t and running in the unconfined_t domain) that uses
>> >> setexeccon to simulate a transition (e.g., to staff_t) and then calls
>> >> os.execl("/usr/bin/dnf5", ...). It triggers these distinct SELinux
>> >> denials:
>> >>
>> >> # 1. The Transition Denial: The kernel blocks the domain transition
>> >> type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:636) : avc:  denied  {
>> >> transition } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
>> >> dev=3D"nvme0n1p2" ino=3D146474
>> >> scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>> >> tcontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=3Dprocess
>> >> permissive=3D1
>> >>
>> >> # 2. The Entrypoint Denial: The target domain lacks entrypoint
>> >> permissions on the binary
>> >> type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:637) : avc:  denied  {
>> >> entrypoint } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
>> >> dev=3D"nvme0n1p2" ino=3D146474
>> >> scontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023
>> >> tcontext=3Dsystem_u:object_r:rpm_exec_t:s0 tclass=3Dfile permissive=
=3D1
>> >>
>> >> Fixing this purely in the Base Policy would require writing transition
>> >> and entrypoint rules for every single interactive tool a user might
>> >> run. This is unmaintainable, massively expands the attack surface, and
>> >> breaks the principle of least privilege.
>> >>
>> >> We explored a few potential ways to handle this and would like the
>> >> community's input:
>> >>
>> >> 1. SELinux-aware run0 (Upstream fix). Modify run0/systemd to be
>> >> natively SELinux-aware. Instead of relying blindly on pam_selinux.so
>> >> (which only sees init_t as the caller), run0 could dynamically
>> >> calculate the correct target context based on the originating user's
>> >> session and explicitly set it for the execution (e.g., via the
>> >> SELinuxContext=3D property of the transient unit).
>> >> 2. Leave pam_selinux.so commented out in /lib/pam.d/systemd-run0. If
>> >> we leave pam_selinux.so disabled in the run0 PAM stack, processes
>> >> simply inherit init_t. This means we would have to write static
>> >> type_transition rules into the base policy for every single
>> >> interactive binary users might run. (For example, run0 dnf only works
>> >> right now because an init_t -> rpm_exec_t transition historically
>> >> exists).
>> >> 3. Enable PAM + Explicit Default Contexts (A Flawed PoC). We tried
>> >> keeping pam_selinux.so enabled and explicitly defining the transition
>> >> path in /etc/selinux/targeted/contexts/users/unconfined_u:
>> >> system_r:init_t:s0 unconfined_r:systemd_run_t:s0
>> >> unconfined_r:unconfined_t:s0 While this correctly routes run0 payloads
>> >> into an isolated domain (systemd_run_t) without polluting init_t, it
>> >> causes unacceptable collateral damage. The SELinux get_default_context
>> >> API only sees the caller (init_t) and the user (unconfined_u). Because
>> >> run0 sessions and systemd --user sessions share these exact same
>> >> inputs, this global mapping breaks systemd --user instances by
>> >> throwing them into systemd_run_t instead of unconfined_t.
>> >>
>> >> Given that we cannot safely rely on global policy rules (which expands
>> >> PID 1's attack surface) or PAM default contexts (which breaks user
>> >> sessions), we'd love to hear your thoughts. Are there other approaches
>> >> or configuration options we might have missed? Or is pushing for run0
>> >> to become natively SELinux-aware the most viable path forward?
>> >>
>> >> Any thoughts or guidance would be greatly appreciated.
>> >
>> > Option 1 seems best to me, but this issue might also be related:
>> > https://github.com/SELinuxProject/selinux/issues/485
>>
>> Disagree because this functionality is not that much more than some
>> abstraction/wrapper around systemd's PAMName=3D functionality. In my vie=
w it would
>> be more robust to make any solution to this issue also work for the
>> underlying PAMName=3D technology it is built on.
>
> I'm perfectly willing to stand corrected by those who may know more
> about this particular area.
> I was merely basing my opinion on what the original poster provided as
> context, so feel free to
> ignore me ;)

The discussion has to start somewhere and this is a good opportunity to
clarify why this might be better fixed on a pam_selinux level. The above
argument is one but if we address this on a pam_selinux level then that
might also work out nicely for systemd-stdio-bridge.

I don't know if its technically feasible (Cow was looking into it but
went AWOL although he is still on the chat so I will ask him about it)
but otherwise it might be implemented similarly to name-based
transitions. These are pam-name-based transitions, optional too.

--=20
gpg --auto-key-locate clear,nodefault,wkd --locate-external-keys dominick.g=
rift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
