Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40022C27C40
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 23:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKVX7w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 18:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKVX7v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 18:59:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F2611F
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1700697585;
        bh=lZDuJYkxZIRwqOS41RqbX/Q1alXwqeDHshm1cM2r460=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZMiU225OdbinrI3vWUYlWFlOKktNPU/TwFHfPb/fez6gWXzQQO0/VqTCnnN5Q3Klr
         zMxoRwTw+HZ0x9c/QlaiyNwLmlPLRgksuX65+rhsc+/Y4rGHUazHn2TDaGDrdTqCKC
         Jnj4hwUTmwccOsaX+Iu9jZmVAbQmT7ZwRuvy8r+6IIzxBuN0pj6U8CQH1+TVv1LGgM
         lywFbN/TsR2l34birRNW1/weVx9eB0RFNzdV/i6Sg1c1M+25KiMZm3m/b0lI11haMc
         rUtY2Y7mBimLztKLrtZKmYUIyo8CWHYkN38E/2OFlzFC+e3c1PNS5pwQCyJDYN/QPr
         ZlkfUsswVA4gg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbJBn1TFyz4x1R;
        Thu, 23 Nov 2023 10:59:45 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v3] selinux: introduce an initial SID for early boot
 processes
In-Reply-To: <CAHC9VhTWYeMzr99HPOp43Q_gVrQg6JSPNWH5y11irqZB89X6eg@mail.gmail.com>
References: <20231114155116.462883-1-omosnace@redhat.com>
 <CAHC9VhTWYeMzr99HPOp43Q_gVrQg6JSPNWH5y11irqZB89X6eg@mail.gmail.com>
Date:   Thu, 23 Nov 2023 10:59:39 +1100
Message-ID: <87a5r5s5jo.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:
> On Tue, Nov 14, 2023 at 10:51=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
>>
>> Currently, SELinux doesn't allow distinguishing between kernel threads
>> and userspace processes that are started before the policy is first
>> loaded - both get the label corresponding to the kernel SID. The only
>> way a process that persists from early boot can get a meaningful label
>> is by doing a voluntary dyntransition or re-executing itself.
>>
>> Reusing the kernel label for userspace processes is problematic for
>> several reasons:
>> 1. The kernel is considered to be a privileged domain and generally
>>    needs to have a wide range of permissions allowed to work correctly,
>>    which prevents the policy writer from effectively hardening against
>>    early boot processes that might remain running unintentionally after
>>    the policy is loaded (they represent a potential extra attack surface
>>    that should be mitigated).
>> 2. Despite the kernel being treated as a privileged domain, the policy
>>    writer may want to impose certain special limitations on kernel
>>    threads that may conflict with the requirements of intentional early
>>    boot processes. For example, it is a good hardening practice to limit
>>    what executables the kernel can execute as usermode helpers and to
>>    confine the resulting usermode helper processes. However, a
>>    (legitimate) process surviving from early boot may need to execute a
>>    different set of executables.
>> 3. As currently implemented, overlayfs remembers the security context of
>>    the process that created an overlayfs mount and uses it to bound
>>    subsequent operations on files using this context. If an overlayfs
>>    mount is created before the SELinux policy is loaded, these "mounter"
>>    checks are made against the kernel context, which may clash with
>>    restrictions on the kernel domain (see 2.).
>>
>> To resolve this, introduce a new initial SID (reusing the slot of the
>> former "init" initial SID) that will be assigned to any userspace
>> process started before the policy is first loaded. This is easy to do,
>> as we can simply label any process that goes through the
>> bprm_creds_for_exec LSM hook with the new init-SID instead of
>> propagating the kernel SID from the parent.
>>
>> To provide backwards compatibility for existing policies that are
>> unaware of this new semantic of the "init" initial SID, introduce a new
>> policy capability "userspace_initial_context" and set the "init" SID to
>> the same context as the "kernel" SID unless this capability is set by
>> the policy.
>>
>> Another small backwards compatibility measure is needed in
>> security_sid_to_context_core() for before the initial SELinux policy
>> load - see the code comment for explanation.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>
>> The last version of this patch has been applied [1] and then reverted
>> [2] because of a regression breaking userspace before the policy is
>> loaded [3]. This version fixes it using Christian's suggestion [4].
>>
>> Paul's suggestion from [5] isn't really viable because both existing
>> users of security_get_initial_sid_context() need the current behavior.
>>
>> As for security_context_to_sid_core(), it doesn't seem desirable to
>> remove the ability to e.g. write "init" to /proc/self/attr/exec to
>> get the exec_sid to SECINITSID_INIT as that shouldn't affect backwards
>> compatibility. However, the caveat is that after setting something to
>> SECINITSID_INIT via "init", a query for the string form of the context
>> will return the "fake" value "kernel" instead of the expected "init".
>>
>> [1] 5b0eea835d4e ("selinux: introduce an initial SID for early boot proc=
esses")
>> [2] 817199e006e5 ("selinux: revert SECINITSID_INIT support")
>> [3] https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse/
>> [4] https://lore.kernel.org/selinux/CAJ2a_DdZHFTHiRu5+ZENAwUq1Cor-jVoE9q=
dhb2x5uSej-MaRA@mail.gmail.com/
>> [5] https://lore.kernel.org/selinux/CAHC9VhQVQv78Xr1bDoJcuT5s441Lvc8AanM=
vMh8KXG-PuPTVAQ@mail.gmail.com/
>>
>>  security/selinux/hooks.c                      | 28 +++++++++++++++++++
>>  .../selinux/include/initial_sid_to_string.h   |  2 +-
>>  security/selinux/include/policycap.h          |  1 +
>>  security/selinux/include/policycap_names.h    |  1 +
>>  security/selinux/include/security.h           |  6 ++++
>>  security/selinux/ss/policydb.c                | 27 ++++++++++++++++++
>>  security/selinux/ss/services.c                | 13 ++++++++-
>>  7 files changed, 76 insertions(+), 2 deletions(-)
>
> Ondrej or Michael, can either of you confirm that the regression found
> in previous revisions of this patch have been resolved in v3?

Yeah this works for me with the same test case that previously failed.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
