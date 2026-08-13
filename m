Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B74756CA
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627396; cv=pass; b=sMlsVlmg5MvWTQeiHDSFxNMJ0iLaM7of95WalWhBnpYiNrj+xRAaKVOTjfNQAgfcTpeksbMjTg6pv0oIZtEJocsgbqHSuj2yNkuHmlR+m7mlya+fkn3tfGBzRA2vSyzMV2/Isggj/fdBCK7nnPJFwEWmN1mm1NxRKzRYHdAQXxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627396; c=relaxed/simple;
	bh=NfgO+NiKbQMh04hB/kwv77G3FXPhFJCSZbJnA6il/4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzLgYybVMsR32GbaM7BxsVC+OZApOuUnbGPDSYKLi41xfx0NiZWDeDpLUQtFimDXdjqGApEuv9rUQWtOhCTlW/gEvhsyxXuFOjKFHrt1Vb+Zl30Y8++/KzFrp5Ej5G0xEwwkpLAiBdzGakEitBqlY7p5iKnSi+oj/UdrTEJjFbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owdAi/90; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owdAi/90"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4513435cdd2so1280869fac.2
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 06:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786627393; cv=none;
        d=google.com; s=arc-20260327;
        b=EmxJT6qLqBZP30M2UEkTPwhKH0i4EbncpKO9Maox5MuyF8XmtBnns3q/aOrvA9CwUD
         xpgUOhsfeNab9rac5nRndMFS3PMYF963jhgkmAXNWRDTUoV3sEGP62+hsYiWm/pAxP/q
         1YQbiyXoESvS37tht2gQbU5mKzvJZ6x5ynqRoaMCEvDzzhH49ensbtbHwDlz/zLbElIR
         YT7xJjYPvZkBkr+/aUKFU3WnbduBcwpFGcVmF5DjBmcTRknPLkgrQVHPnUEVsOcgo3rP
         FuaKyyXaHj8yPYxeJ9ZamN3TKpg0jN6Z4m5DGBngcULg8/ds5ovyJzBtw+zOp6V0AROC
         KAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+g0TY9y9rmuai2evf6Bf+PPHmLDkaLNBHxxuC+FJlLM=;
        fh=5+QJzvROxDCOLyqLZu15Mecc6E6RMVWMDE7QEnHFDSI=;
        b=p/AyFvrwCYg296En9BD+6bsxhvWLM4GHXHnYes4e8QPJkX2FZwYMmwMLvqAZJzkKLE
         jLZTO89URzLB6c7dDPHJIJHfWJaQt27/0aMFAxhhhY+QoNb8JL4wfQwhDJhL3Pb2oZgN
         JPc9zMSI7VbLu0uINjxhDZdll/Hip6HeLHdA4QD8lZckLFGq+Lzg5jscvPQsbWOZui8l
         /mpiBWESoLLIu2/bqXu9Acs2bTILrSGs4mk9Jn2HAamVyaBGON/o/KmWYB0athw6MHlS
         Nns3ZM8k/R6oyi0ylt8Q8pvqh72FKudNUZAkV7OVczeL+J+I/YAWBFxDZZg0vp6GH9kf
         100w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786627393; x=1787232193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+g0TY9y9rmuai2evf6Bf+PPHmLDkaLNBHxxuC+FJlLM=;
        b=owdAi/906e96XlDLANQYg4I1Fp58d1qr5VmIVcM899nxnDA5fu3Wg/t2z9VvASkwtW
         HgeST7TMU33bCX6MY4nD2Bjzz+laHmOcXbG+cjwHfEaevw8qRHtWbC4WxTKDEmPN57Vb
         JHYoG7dGcB62TAQY+LU9CvurgL24zw77/R4OFfPleAGxj95GoNf0WzoP8KqBP75Hqz98
         3tbdBRV2Tc1015jkCiTbnO1pzXrSjPo1FXIz4Vevm7fZbRn+wkvz3cT346rLTaAEvYgF
         IXQAOXP+MZiCpgo1Swz4MsR+Ym6FdeydYk18gkP35MqCqCY+J1cSZqYUQ4J/Iow+YItv
         uBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786627393; x=1787232193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+g0TY9y9rmuai2evf6Bf+PPHmLDkaLNBHxxuC+FJlLM=;
        b=qvCqlxoIt+11Tz5NxU4zoWf+fSxYV/zGziYzLyLZ/pRwcZhqAqprEugTloOWtANzPC
         80fReUSI1OaRSLixuPKSU1yNSAPSwzdRJlg/hFH5GRV+JzIeSO2ugtiIT9VwV+YT7pJW
         X6SaJPeh5dCWE0FT6zFMmyogOKQ498dJ/1Qoc+a55DEESKUoc43XKMLY1tSBwjO+3c/1
         VyHZeFc77b2k852IFzI8+lQ44Cncu9Pn1k6IIheDdxFuV5Vo/yXcdiyMX5qxlEm0+qW6
         wsCuSG7LAVqyZZmfZlVHTpBThNVWLqSnRmIlZeUyVHjK7EQsz80ILwRynVhGkl07ykDw
         WXnA==
X-Gm-Message-State: AOJu0Yz73YGflD59xRmxTHcmgJN0mDS8b+llXQ1BFLCanMuDN5MVTxuN
	0U/CpqcNtt3lIXi2S0TPu1MzNc/3dgmzghfQ1TI2xzKuZ8xIPl7Z28l7UW7nSlUtEjC3iQFsCf3
	m+gEOV4lDsZfRRB+auLkSkAYTjTGCLiF9uSgu
X-Gm-Gg: AR+sD10Obb6ozLrAZAmhxFPtR/DeNG2Ao6f7sZpm5uKAp4Tj/sWFanJp8BTN1CPpK65
	CKqs7d1ofSBsV4epTczbHNE1SOB6i+650hBPIi+LP9mXD02O6CnrgHc2ta1fmgVqqZ2TpVPLOUq
	lidIO2HKe/EgeOXfztzbA7v7Oil0TNFLdkXRV0d/txxP4Ir29C3YrVuI5pOh0XlmlfHL1sn561A
	dMmoH4F8iFbncRqSyfKGOOp3VlwnMz8NRPMg5Zl8iiqJvMxF8xz1T8oKcMV/Bo9iMb8ScLvXz1m
	pwGZowzEq0xR4tjgPBg+z15E/rqCKTO4Pj7w7hPmOSz8DQ==
X-Received: by 2002:a05:6870:799a:b0:451:d77d:f2d5 with SMTP id
 586e51a60fabf-45e6263a6b8mr5263212fac.13.1786627393380; Thu, 13 Aug 2026
 06:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
In-Reply-To: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 13 Aug 2026 09:23:02 -0400
X-Gm-Features: AUfX_my2gEacruUw4pdBjV6q9bd0GJtRynJz_5iCN8mi2tVW96yo1OD4LyV5WEo
Message-ID: <CAEjxPJ5-r1yNBJeVV6ouby5kCUVU6KQitv50bw=NLYEMJa9A+A@mail.gmail.com>
Subject: Re: [Discussion] systemd-run0 policy issue
To: Jan Janasek <jjanasek@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:11=E2=80=AFAM Jan Janasek <jjanasek@redhat.com> w=
rote:
>
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

Option 1 seems best to me, but this issue might also be related:
https://github.com/SELinuxProject/selinux/issues/485
