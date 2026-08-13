Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDF472F73
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626625; cv=pass; b=fHU2HL0V+/rd1n38OLdhniEYDsaA2cK52biwItoXg+xiy4bLEKjHuT+hyNbDo4fZZGif7Q8pZeUkkM4qbVboPhjpyHIKDZUXQg/KMkXY6H6RCDopXEjPIj1sIqkXgQRMn7v+0aiT167baiMXodIt0lwsQEcS+ZCwkkCEe3yfVjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626625; c=relaxed/simple;
	bh=cQyxbzgPk9QZHRfUcesSAAiYXg+KUU5XAs2zJ+yDFzo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SIlisQkX+2Sk+qKN3L78e5t3O2LOPmkmHjLAxZnUM/bBpTRR7Mgjm+VOcgXZIW5CUGyZSoRNak0rw4Cw9Hk7DbuDuUiYaau3s82lkJXc0koh7wKjIemDbNfC7MxQkil2iMKzdWMaA3TydQ0hsyRNBJuV5bA57Kdk/UvAqdTvX7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvQ6AyNz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+ClTbbv; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvQ6AyNz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+ClTbbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786626622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FD14+IbdkWWeNKsMZjsWHu/ThWRsPTzX6upwstYE+eM=;
	b=SvQ6AyNz5AjYAARikZqH4qQ8FQmeKMg5bC9OXetK1mq2NF+exoWtCuxBhkHGf2/rrjoXBE
	h4IgxXb/dX95Uk8wx8fuVfPBJ5vQB0VL0sQ3d+0kZl9MjIm8f2N2R+zEwMtztNIWAbQEhl
	+A6G9k3X/VDO3udOJ5tlONG90Odmyhk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-29P61CdJPv23TAShMnjHWg-1; Thu, 13 Aug 2026 09:10:12 -0400
X-MC-Unique: 29P61CdJPv23TAShMnjHWg-1
X-Mimecast-MFC-AGG-ID: 29P61CdJPv23TAShMnjHWg_1786626612
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa4e4684bso58394135ad.2
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 06:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786626611; cv=none;
        d=google.com; s=arc-20260327;
        b=ozqMrWs7AbI+gkY5SynzJm5REbNEcnvdYmOxuxSR6utqpt7B6Mo+kRo5qrWpcZxubh
         irHzXevFck9SyxVQ3MGSdAplepm+J22w/peWeAqgWMrEBq58U97raoxi/hP6fU3TdZV+
         B2qCzdlKyzlb390HAmZB4VfHW1iUWsNpPX0eagsgHwW5YrxoqSRM7O25yhD3FXeTZz2k
         K6NTl/aevUvtmWm3uf2qt+FvnC/YfRjKXpFeZOXyA5K/paDogPMnkT2JBwV2tattuDLV
         cweCBXhJo7ZfxApjtXGrCwYOaWr2pNnGVc44I4LT45pRnBrS4o0QzKOZVJtZsXhKDhSF
         oxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FD14+IbdkWWeNKsMZjsWHu/ThWRsPTzX6upwstYE+eM=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=exR+gVexqGcGGf0c3mWz5P1LTIq9mrlQhnawTlOG0UPWbFf8WCVgSRHb02lPllMboL
         Akbq7uT9JxbdOX/q0QDY32wqVah/aVayGulug+nlZKqHyLYp9DD+Ftpdrv8q48UEJe67
         fDjx7RRUefsM4+m+YcCYdjLWlNAghSHUIG4hfXwbWIaIzkc6h+wWgOvCBPLp4arWAvuP
         j98U73agV3eslu48OWEc/vIwtnoybHjlIyy+EnzUZrWHt8+9ssrfVVFp12lK7e4k2F9g
         VifvcnloV9dneS5898RaZOODcKe2CuYd0XKWP5+0en9qToQoc75yxOURMJpeFBwGcBYu
         Af8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786626611; x=1787231411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FD14+IbdkWWeNKsMZjsWHu/ThWRsPTzX6upwstYE+eM=;
        b=A+ClTbbvwH4zAujP3Dlmsj32Df2y/05cHEGKKK5C93/9LlTVVeypXgvUlxBBEeYazB
         xp36+FhwekcIe0/mRzQRRinmtXNTzVwPdy5l+JRKEmWdETYUATPIoAoacWpvZ/w5dO8E
         rxwuGklzRcLfo/sLlkPvm2WqBex+SnzDGuJDzKkVAD/e4BbDNVJUH/WWSeC+mv3KL3sw
         IyijeP2ImzfYZ2ihF6PMgb0HkIvldFJ8A/twM5mZLJ7dtkCiGzLv2ZaTTyY7hE3q6FVr
         xMxY6w4Mo5bcI2BlnlVwU15+36oN9y8ukolDuvE9YkG11tWswWPftE2FAuXRuQN/bXVK
         xM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626611; x=1787231411;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FD14+IbdkWWeNKsMZjsWHu/ThWRsPTzX6upwstYE+eM=;
        b=Wu4akHOh0EorS0KqXGPXb8JoqOsPiCqcKq/whY021O3KGhkwoV+NAdmTOtEjHij9jF
         sVud/LBJBOTh9nf+Ubw8KDABXfX9oyF0/QHDUq1wuBDTMF8/OCBXF+L+B/RAFA2eaEs7
         WNpCwNTL98RT1yyqVO3kU/amQTrdJFsHehXTjyO07XJC9NGfVZYcI/4xhddrAEyyQjQH
         S9+W5mUqUOADuKfSxib3OatMgkmANH7lpRCXEDXGMftmpr/0pWEojKdDGoB883oumGjw
         yhR7dhcICryyovIFsCgRBhmnI4unbTWFqtAdlIww1D+m3vI51vuBLijYSsfbYHBPv0vX
         l2FQ==
X-Gm-Message-State: AOJu0YwjbC6jfsODZ9wiBBGILgzCH+Z8VAgHyOe7jdACyYv10gZBZ8nE
	E0drsjNo1w5o+ywELDCnR6DDRtIdsp1nj/KES5MkXgfMrmEToM7bpMSfe+eAemgwSA0GNh5monN
	90pQ8lXayi2NQkK/4h8bXmfbIPLttDJDitBE9Z149k+zuglDwiePOQswyp/zSDN2c8PWuzOMgQD
	WonSM0W4o/q6t6F2rCbYZtuTkeuWLjCXS6dZMswUDL/qWY
X-Gm-Gg: AR+sD13RseeBMqa8gjp6EsnKavXzk3VS34WF8w89cXt4RmGrg4lysikKPwobKVoUUCS
	sYmj9qgXUw4EECRZ4zMyUpqVNLnGxIbWNzdS5dBtiBRFHjnwIcg+uxBcfXySqly2kZhLaVpfV2o
	68a6zKCFaF7ig24CI/UJUWNHVHZ3qLGmBYlgtJ1svNWgFH6ytCaWPE/1b/p98OLv6dkgx9VX80f
	psYbCmqnqX9SF5ADYU=
X-Received: by 2002:a17:903:22d1:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2d37d581fbbmr60958225ad.6.1786626611464;
        Thu, 13 Aug 2026 06:10:11 -0700 (PDT)
X-Received: by 2002:a17:903:22d1:b0:2ca:6d87:cda0 with SMTP id
 d9443c01a7336-2d37d581fbbmr60956855ad.6.1786626610714; Thu, 13 Aug 2026
 06:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jan Janasek <jjanasek@redhat.com>
Date: Thu, 13 Aug 2026 15:09:58 +0200
X-Gm-Features: AUfX_mysZrvjl7xXZ2mELtv5lTae9AKQTbCjB4c7996S2pLP0fnIhODLjP0_tBA
Message-ID: <CABd7YBF9zHnkjxbRsLZeVRSNNYqPV5z6eE8o+H_s5DzC+cW0Cw@mail.gmail.com>
Subject: [Discussion] systemd-run0 policy issue
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

(I originally posted this to the fedora selinux list, but was advised
that this is the proper ML for such architectural discussions.)

We=E2=80=99ve been analyzing the integration of systemd-run0 with SELinux a=
nd
hit a fundamental architectural roadblock, related to bug
https://bugzilla.redhat.com/show_bug.cgi?id=3D2359828. Unlike sudo,
where the parent process is the user's shell (allowing PAM to easily
calculate and transition the context), run0 delegates execution via
D-Bus to PID 1 (init_t). This breaks standard SELinux PAM transitions
and creates a severe design challenge for maintaining user isolation.
(Currently, wrapping commands via run0 --via-shell acts as a temporary
workaround, but we are looking for a robust architectural fix.)

When pam_selinux.so attempts to transition the user directly into
their target domain over a specific binary, it immediately triggers
strict policy conflicts. To demonstrate the exact mechanics of what
happens when PAM forces this transition, I wrote a Python reproducer
(labeled as bin_t and running in the unconfined_t domain) that uses
setexeccon to simulate a transition (e.g., to staff_t) and then calls
os.execl("/usr/bin/dnf5", ...). It triggers these distinct SELinux
denials:

# 1. The Transition Denial: The kernel blocks the domain transition
type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:636) : avc:  denied  {
transition } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
dev=3D"nvme0n1p2" ino=3D146474
scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=3Dprocess
permissive=3D1

# 2. The Entrypoint Denial: The target domain lacks entrypoint
permissions on the binary
type=3DAVC msg=3Daudit(07/23/2026 09:23:00.584:637) : avc:  denied  {
entrypoint } for  pid=3D4945 comm=3Dpython3 path=3D/usr/bin/dnf5
dev=3D"nvme0n1p2" ino=3D146474
scontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023
tcontext=3Dsystem_u:object_r:rpm_exec_t:s0 tclass=3Dfile permissive=3D1

Fixing this purely in the Base Policy would require writing transition
and entrypoint rules for every single interactive tool a user might
run. This is unmaintainable, massively expands the attack surface, and
breaks the principle of least privilege.

We explored a few potential ways to handle this and would like the
community's input:

1. SELinux-aware run0 (Upstream fix). Modify run0/systemd to be
natively SELinux-aware. Instead of relying blindly on pam_selinux.so
(which only sees init_t as the caller), run0 could dynamically
calculate the correct target context based on the originating user's
session and explicitly set it for the execution (e.g., via the
SELinuxContext=3D property of the transient unit).
2. Leave pam_selinux.so commented out in /lib/pam.d/systemd-run0. If
we leave pam_selinux.so disabled in the run0 PAM stack, processes
simply inherit init_t. This means we would have to write static
type_transition rules into the base policy for every single
interactive binary users might run. (For example, run0 dnf only works
right now because an init_t -> rpm_exec_t transition historically
exists).
3. Enable PAM + Explicit Default Contexts (A Flawed PoC). We tried
keeping pam_selinux.so enabled and explicitly defining the transition
path in /etc/selinux/targeted/contexts/users/unconfined_u:
system_r:init_t:s0 unconfined_r:systemd_run_t:s0
unconfined_r:unconfined_t:s0 While this correctly routes run0 payloads
into an isolated domain (systemd_run_t) without polluting init_t, it
causes unacceptable collateral damage. The SELinux get_default_context
API only sees the caller (init_t) and the user (unconfined_u). Because
run0 sessions and systemd --user sessions share these exact same
inputs, this global mapping breaks systemd --user instances by
throwing them into systemd_run_t instead of unconfined_t.

Given that we cannot safely rely on global policy rules (which expands
PID 1's attack surface) or PAM default contexts (which breaks user
sessions), we'd love to hear your thoughts. Are there other approaches
or configuration options we might have missed? Or is pushing for run0
to become natively SELinux-aware the most viable path forward?

Any thoughts or guidance would be greatly appreciated.

Best regards,
Jan Janasek

