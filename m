Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153947D455
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628464; cv=pass; b=cqbiTy7wWSpRx2kGL3KBZTKpfrVAXorg411NhTfboAE2V00icbTmOT0tdIINn3Itf9ois+6Toaes/DtYx5XlrSyBMHyOxwXTL6kIY4ofRyhUI26vbDrcE/TeOJyKOJToXVUdqB8BjNhzuuW+ZZ/xdVD+J5rA8IEYYPRvcwRA414=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628464; c=relaxed/simple;
	bh=YmBHywhA6cdjlQpVa4O8h+u+/8fUVpS7PRA7IzQfn04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iClNpkftlx1An4Y6epFBfymDqtW4+mETF8QnNrGxz6z/w1dk7wtmD0xBywDn26WsIJ2SDYL2+udhRFtR9mHm4p70yo56iAWytI1yR91NovHAZTyZo6vqNCZCP0GHRZi8OrLutg/xIppIs1yJmhTny2CxhurDW4+/n27W8mzEeWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUc4seZZ; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUc4seZZ"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44cf70de986so361460fac.0
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 06:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786628461; cv=none;
        d=google.com; s=arc-20260327;
        b=OFpzXoFTlyYYk5lTVtVHvPEyMa4tyIJDuq4g/HSYHddokEBJdDbHA/ITulq2DzY7va
         5lPe4jYCO4hKAk4I7l+ifhoG1qNheAf/EzjV74mIb7xfh9eT1mJruyE3+8fS1k/Piko6
         UnhUGvBzBHTYXVBBOF43ZzUO6/6hnSA//Xs84NVlJO7FK6GGiYH3NUbMwjsfgJxUZW77
         Him78/GCDdw6Z5/36CKJ5DSfKRnnS5vULL/VxpRAH3hLJWUnqhwC8G2IR0tV5aqnusoL
         55AusYMUZSDsbBiNkpqC9YDgcp23fRRy0/7I/swjv/Ci5pnOE25r12es52f0BKMNJTLs
         cJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CEo+1a9TkXjdZZf88iar3JdxzoUQ99i6sCbp6VOtkac=;
        fh=G0hD2y23vWSJvWIap9PGogaxAde1wsjhvjP2cldVsSo=;
        b=kpO8pTto4mj2j2p3YSRDyZmo1gilDfgDOxN/FRNtKj3qe43mB5mG6U1H24ifIMizta
         gQSLFYq3OO7uHomvTUX2iUCUGOwaWLzh6j5PLsb0coQfGXA2loW4yGxS5z2zxHWI5WaU
         0TKbYtLFt0hG6RNw9b32ABAxOz+8TJ5/u/op0dbRUAeM2rkQ3ds7mjU8jOCuK89Y1Vyh
         bIK4o0kwY3qDKd9B/fusCBudktzF5iaQcvAQQsq7VC7oTbEglGgxyubat7TbYO6lQ+tv
         UWsGmhsbEcbZIIvbCEKbUdgbahSEGTmpfjbU4bGv4CU4/3+287VGBSKaL9VOIkxrtXG8
         umMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786628461; x=1787233261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CEo+1a9TkXjdZZf88iar3JdxzoUQ99i6sCbp6VOtkac=;
        b=IUc4seZZHW8NIqP70bR4v7ezFTwG+fDfuNLuCgQKIap5mpOzQKym2+dfHaG8WQbHsD
         sYEzx1kgujhOrDgFJD0391Glc99J8IGg7pUSBxBF9Isfmpem2ucoShbXX3VHsOSy0Pgc
         LbplBIzlOFPcKzs1+fo+37vkQ68FU6RqELbq7AFHPm4ZUZc/u5OZts6OMn77B7kVgcwo
         nZLe2kAl3/m96ZJMwfLghfHZl6G4kI3htWQwwnNW0qf1290N0NDNa3N9mZ3fiksfwWEQ
         DZPvRoFqwTOFfjrTEmH1CAw+LAOnSkpNgW+Q/akzLM/9wzP830XOlGR9li+hBQm9G5DA
         nzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628461; x=1787233261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEo+1a9TkXjdZZf88iar3JdxzoUQ99i6sCbp6VOtkac=;
        b=SnUF1Y8J+pR7QcQuVmVB4P0C5CaTKth8ti90VmE5p9L2LtNq9OSLgdCrY1Mg+bj2cc
         pA+AXK02vsHJC0JiQoY+rxkr+bOUGc7pB8eUsvKuPOZ5E6zvzwXpTyyouyNuZrgW0D/t
         +QvmTEG9+9znhglgqHcpGN8hXAmz+Z0G4aL1fL2iwZADsIObrrxSZVBePXN4iAzin7eA
         IXAbPhZyyh9pwzyf3x21DLTw4BphtTLVOHtr+vVV2VUyIHfgMpIXSVA2Wg6rJjX6nx2W
         xMGD+jGHunY28bk3Jq7zEry7ITjafMeMrCqOB8rVmCQVilCedKxnfptBkbIKTZ1ZaTRa
         PNdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0x1qpZIAj69h0ug7uRbiYIh+UIaNqRK5auqaZZ/D1RQZqmKLhuQ1FBVQbN2bs1f8mlFDRJCce@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOKff46HTSop9wJFB7AHu7x88EK96FcPOAdmeL55hRHsdcQfJ
	o/0eAZ0ZfSrZIoUU6YZutxZfkiDBPHhog7l67H1xReJxMDzC/TXTHJeaChbHcpcmCutpgk/qE2q
	NhoDfWpkQYIZAL/OqLQATZpfxJKuGavs=
X-Gm-Gg: AR+sD11JueryJULKP7fuI5gDIQBZ0fk65CsVXQ5feSPev/C4blNxOy8xXhAYkhRDINc
	ZxL2Sjb0vkGn5k4jA/Qn5apfhNC5/JCSgdRqN0zuMyw69crpsQeD94ho0tKgX+OrISdjFYhob8E
	XnP0kq+16T0uvHgzJF3jnVIk3yMkgp9TQ73oNV/U5Vw14duw7btrlipT7kdt9PPXMi+79t8RXBh
	J8vpC0UTOMSb7MZOa8qoSg+DTeRhOkdHXih1MRVs8dhGt6hj8dCTInDlR+1cWGl0GCqQChRqW3y
	4UIdGNhPlciembHuhjB5zk0z35XS/zqiqrC7ATOsscFk
X-Received: by 2002:a05:6870:6ec6:b0:456:b7c1:8f2 with SMTP id
 586e51a60fabf-45e621d1d2bmr5155864fac.2.1786628461294; Thu, 13 Aug 2026
 06:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
 <CAEjxPJ5-r1yNBJeVV6ouby5kCUVU6KQitv50bw=NLYEMJa9A+A@mail.gmail.com> <87wltup2hs.fsf@defensec.nl>
In-Reply-To: <87wltup2hs.fsf@defensec.nl>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 13 Aug 2026 09:40:49 -0400
X-Gm-Features: AUfX_mykw33m53KIO7oAmJjjD0_n666QmWIpsdLNdQNpLZaKnn33yfMaJDoy-A8
Message-ID: <CAEjxPJ6C8hcCr-WwZBehSnFRCL_5WPp5QnNWKz48Lq41wGO9uQ@mail.gmail.com>
Subject: Re: [Discussion] systemd-run0 policy issue
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: Jan Janasek <jjanasek@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:35=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Thu, Aug 13, 2026 at 9:11=E2=80=AFAM Jan Janasek <jjanasek@redhat.co=
m> wrote:
> >>
> >> Hi everyone,
> >>
> >> (I originally posted this to the fedora selinux list, but was advised
> >> that this is the proper ML for such architectural discussions.)
> >>
> >> We=E2=80=99ve been analyzing the integration of systemd-run0 with SELi=
nux and
> >> hit a fundamental architectural roadblock, related to bug
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D2359828. Unlike sudo,
> >> where the parent process is the user's shell (allowing PAM to easily
> >> calculate and transition the context), run0 delegates execution via
> >> D-Bus to PID 1 (init_t). This breaks standard SELinux PAM transitions
> >> and creates a severe design challenge for maintaining user isolation.
> >> (Currently, wrapping commands via run0 --via-shell acts as a temporary
> >> workaround, but we are looking for a robust architectural fix.)
> >>
> >> When pam_selinux.so attempts to transition the user directly into
> >> their target domain over a specific binary, it immediately triggers
> >> strict policy conflicts. To demonstrate the exact mechanics of what
> >> happens when PAM forces this transition, I wrote a Python reproducer
> >> (labeled as bin_t and running in the unconfined_t domain) that uses
> >> setexeccon to simulate a transition (e.g., to staff_t) and then calls
> >> os.execl("/usr/bin/dnf5", ...). It triggers these distinct SELinux
> >> denials:
> >>
> >> # 1. The Transition Denial: The kernel blocks the domain transition
> >> type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:636) : avc:  denied  {
> >> transition } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
> >> dev=3D"nvme0n1p2" ino=3D146474
> >> scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >> tcontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=3Dprocess
> >> permissive=3D1
> >>
> >> # 2. The Entrypoint Denial: The target domain lacks entrypoint
> >> permissions on the binary
> >> type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:637) : avc:  denied  {
> >> entrypoint } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
> >> dev=3D"nvme0n1p2" ino=3D146474
> >> scontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023
> >> tcontext=3Dsystem_u:object_r:rpm_exec_t:s0 tclass=3Dfile permissive=3D=
1
> >>
> >> Fixing this purely in the Base Policy would require writing transition
> >> and entrypoint rules for every single interactive tool a user might
> >> run. This is unmaintainable, massively expands the attack surface, and
> >> breaks the principle of least privilege.
> >>
> >> We explored a few potential ways to handle this and would like the
> >> community's input:
> >>
> >> 1. SELinux-aware run0 (Upstream fix). Modify run0/systemd to be
> >> natively SELinux-aware. Instead of relying blindly on pam_selinux.so
> >> (which only sees init_t as the caller), run0 could dynamically
> >> calculate the correct target context based on the originating user's
> >> session and explicitly set it for the execution (e.g., via the
> >> SELinuxContext=3D property of the transient unit).
> >> 2. Leave pam_selinux.so commented out in /lib/pam.d/systemd-run0. If
> >> we leave pam_selinux.so disabled in the run0 PAM stack, processes
> >> simply inherit init_t. This means we would have to write static
> >> type_transition rules into the base policy for every single
> >> interactive binary users might run. (For example, run0 dnf only works
> >> right now because an init_t -> rpm_exec_t transition historically
> >> exists).
> >> 3. Enable PAM + Explicit Default Contexts (A Flawed PoC). We tried
> >> keeping pam_selinux.so enabled and explicitly defining the transition
> >> path in /etc/selinux/targeted/contexts/users/unconfined_u:
> >> system_r:init_t:s0 unconfined_r:systemd_run_t:s0
> >> unconfined_r:unconfined_t:s0 While this correctly routes run0 payloads
> >> into an isolated domain (systemd_run_t) without polluting init_t, it
> >> causes unacceptable collateral damage. The SELinux get_default_context
> >> API only sees the caller (init_t) and the user (unconfined_u). Because
> >> run0 sessions and systemd --user sessions share these exact same
> >> inputs, this global mapping breaks systemd --user instances by
> >> throwing them into systemd_run_t instead of unconfined_t.
> >>
> >> Given that we cannot safely rely on global policy rules (which expands
> >> PID 1's attack surface) or PAM default contexts (which breaks user
> >> sessions), we'd love to hear your thoughts. Are there other approaches
> >> or configuration options we might have missed? Or is pushing for run0
> >> to become natively SELinux-aware the most viable path forward?
> >>
> >> Any thoughts or guidance would be greatly appreciated.
> >
> > Option 1 seems best to me, but this issue might also be related:
> > https://github.com/SELinuxProject/selinux/issues/485
>
> Disagree because this functionality is not that much more than some
> abstraction/wrapper around systemd's PAMName=3D functionality. In my view=
 it would
> be more robust to make any solution to this issue also work for the
> underlying PAMName=3D technology it is built on.

I'm perfectly willing to stand corrected by those who may know more
about this particular area.
I was merely basing my opinion on what the original poster provided as
context, so feel free to
ignore me ;)
