Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D7C61D88
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 01:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjKUBf7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 20:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUBf6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 20:35:58 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09BBC
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 17:35:54 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso4623212276.0
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 17:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700530553; x=1701135353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1RxUEjkil3TwuSEOXIqrbla3JNIOI3lPEhx5cHI+eE=;
        b=XXsCjcHWWLq57yJDoftKl2UPbsmkbJusKfjbYoUwqsO90bHxt2ki2t1UfmoUTZ7cxc
         pW4OzoEQebFIsFAOx+FN8AJ9293UacPzEBEFnmr/bVXIT3hsKFthvUOLzGj2Fe/Q9AuH
         4dut2I7ywAZeDHCEVFGx65gPzdOtI9FYSwKt2tJOnM7+JoYGC4uDKdKImq3wipwVRPdh
         +r2CIxNZUavcnRFo4B+V7GwSsDSM8ivG9k6DcRWPySS4LNNqezAjGwZEf/2KCsPvknc5
         +eFCtH4BP+3vRzGGOnoUpKTyPrXXMzaEgIFTZSMtrUoqpb7FbU6flzR0l/Uc21YfCha0
         Fj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530553; x=1701135353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1RxUEjkil3TwuSEOXIqrbla3JNIOI3lPEhx5cHI+eE=;
        b=EGoYCW5lEIWqatEEzVjWSWMFXf2SgTHr3DjDT25V9olsPuLTUadVkLNziqWjTWwwC1
         4e3CZ26QUOPHxozwHhQ6njBibnsjQlOGoqlGhCbGg/Z85cGV3dFMC4qLYwHBAs4buM3e
         fLtepObMzx/LVG+2/ZtjjVB878UbON+Vk0c+2X2fcHGMXZUQjPOsFSeqBthOqHSTEenN
         N9DZUASENUozaXqVQjn7j8up79zjO1u/GAn+wc7Om8ymOwcv18KwRoDXoRyG/0SiRzm4
         YAK20yCVJpA0QGJX9q2c3+LQZ0PUjh3c5bgY3hNAlctDoOATXAHQWcDPyV5GIJnnZR3X
         ik7w==
X-Gm-Message-State: AOJu0YyAaQzy7EW4bYuutvMPPBgZBUm8pvhPFoprP350ZR9Mb3i020Fs
        k3+L9Iu1MzCQ7R+6nGT2YVbJgDXdbeEquqP9DoNr
X-Google-Smtp-Source: AGHT+IGG3cAHAdXACH5yofGcnZoa2SUX0MapBvfd+UU/KJHnqyRWg4oN50ET712DRi3L0PeQCQCX5/VStM43KaLJICo=
X-Received: by 2002:a25:ab31:0:b0:da0:3ffd:8026 with SMTP id
 u46-20020a25ab31000000b00da03ffd8026mr8949005ybi.19.1700530553379; Mon, 20
 Nov 2023 17:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20231114155116.462883-1-omosnace@redhat.com>
In-Reply-To: <20231114155116.462883-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Nov 2023 20:35:42 -0500
Message-ID: <CAHC9VhTWYeMzr99HPOp43Q_gVrQg6JSPNWH5y11irqZB89X6eg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 10:51=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> Currently, SELinux doesn't allow distinguishing between kernel threads
> and userspace processes that are started before the policy is first
> loaded - both get the label corresponding to the kernel SID. The only
> way a process that persists from early boot can get a meaningful label
> is by doing a voluntary dyntransition or re-executing itself.
>
> Reusing the kernel label for userspace processes is problematic for
> several reasons:
> 1. The kernel is considered to be a privileged domain and generally
>    needs to have a wide range of permissions allowed to work correctly,
>    which prevents the policy writer from effectively hardening against
>    early boot processes that might remain running unintentionally after
>    the policy is loaded (they represent a potential extra attack surface
>    that should be mitigated).
> 2. Despite the kernel being treated as a privileged domain, the policy
>    writer may want to impose certain special limitations on kernel
>    threads that may conflict with the requirements of intentional early
>    boot processes. For example, it is a good hardening practice to limit
>    what executables the kernel can execute as usermode helpers and to
>    confine the resulting usermode helper processes. However, a
>    (legitimate) process surviving from early boot may need to execute a
>    different set of executables.
> 3. As currently implemented, overlayfs remembers the security context of
>    the process that created an overlayfs mount and uses it to bound
>    subsequent operations on files using this context. If an overlayfs
>    mount is created before the SELinux policy is loaded, these "mounter"
>    checks are made against the kernel context, which may clash with
>    restrictions on the kernel domain (see 2.).
>
> To resolve this, introduce a new initial SID (reusing the slot of the
> former "init" initial SID) that will be assigned to any userspace
> process started before the policy is first loaded. This is easy to do,
> as we can simply label any process that goes through the
> bprm_creds_for_exec LSM hook with the new init-SID instead of
> propagating the kernel SID from the parent.
>
> To provide backwards compatibility for existing policies that are
> unaware of this new semantic of the "init" initial SID, introduce a new
> policy capability "userspace_initial_context" and set the "init" SID to
> the same context as the "kernel" SID unless this capability is set by
> the policy.
>
> Another small backwards compatibility measure is needed in
> security_sid_to_context_core() for before the initial SELinux policy
> load - see the code comment for explanation.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> The last version of this patch has been applied [1] and then reverted
> [2] because of a regression breaking userspace before the policy is
> loaded [3]. This version fixes it using Christian's suggestion [4].
>
> Paul's suggestion from [5] isn't really viable because both existing
> users of security_get_initial_sid_context() need the current behavior.
>
> As for security_context_to_sid_core(), it doesn't seem desirable to
> remove the ability to e.g. write "init" to /proc/self/attr/exec to
> get the exec_sid to SECINITSID_INIT as that shouldn't affect backwards
> compatibility. However, the caveat is that after setting something to
> SECINITSID_INIT via "init", a query for the string form of the context
> will return the "fake" value "kernel" instead of the expected "init".
>
> [1] 5b0eea835d4e ("selinux: introduce an initial SID for early boot proce=
sses")
> [2] 817199e006e5 ("selinux: revert SECINITSID_INIT support")
> [3] https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse/
> [4] https://lore.kernel.org/selinux/CAJ2a_DdZHFTHiRu5+ZENAwUq1Cor-jVoE9qd=
hb2x5uSej-MaRA@mail.gmail.com/
> [5] https://lore.kernel.org/selinux/CAHC9VhQVQv78Xr1bDoJcuT5s441Lvc8AanMv=
Mh8KXG-PuPTVAQ@mail.gmail.com/
>
>  security/selinux/hooks.c                      | 28 +++++++++++++++++++
>  .../selinux/include/initial_sid_to_string.h   |  2 +-
>  security/selinux/include/policycap.h          |  1 +
>  security/selinux/include/policycap_names.h    |  1 +
>  security/selinux/include/security.h           |  6 ++++
>  security/selinux/ss/policydb.c                | 27 ++++++++++++++++++
>  security/selinux/ss/services.c                | 13 ++++++++-
>  7 files changed, 76 insertions(+), 2 deletions(-)

Ondrej or Michael, can either of you confirm that the regression found
in previous revisions of this patch have been resolved in v3?

--=20
paul-moore.com
