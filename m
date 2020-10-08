Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B857C4363A
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8141215A4
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 12:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="CvQumVgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgJHMOA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgJHMOA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 08:14:00 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28419C061755
        for <selinux@vger.kernel.org>; Thu,  8 Oct 2020 05:14:00 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 15CF72A100B;
        Thu,  8 Oct 2020 14:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 15CF72A100B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1602159235;
        bh=a5QKuny82GKsQsGFPXBnAo1bSdAz/0m7yEDrkpJNnLw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CvQumVggYvCuEzGixBvCY6xzPi3olnUdk4Y2zbABa5aGTBpAU33hUANQKE4djSgzk
         kCljM7/gf6lJ8GREuE/ZHQkLsZlsODdIzDR4ISX+S9mKRd/VJ6EcDULQ+t4vekJI/p
         jk+DLZTQYazidTxd2FRAsb3CnybRW0Bj/Ur4SMTI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
References: <20201007095033.GB194132@fedora.redhat.com>
        <CAEjxPJ630EuLcg3PUTKM51S7y=PjO-8=AUOBMKsLOi7jboTQ_w@mail.gmail.com>
Date:   Thu, 08 Oct 2020 14:13:51 +0200
In-Reply-To: <CAEjxPJ630EuLcg3PUTKM51S7y=PjO-8=AUOBMKsLOi7jboTQ_w@mail.gmail.com>
        (Stephen Smalley's message of "Wed, 7 Oct 2020 08:35:37 -0400")
Message-ID: <ypjleem8apa8.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Oct 7, 2020 at 5:50 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>> Thanks, I'll prepare another patchset with improved commit messages.
>>
>> In the mean time I'm looking into removing deprecated symbols from libsepol as it's
>> supposed to be required only by selinux components. So far I've found that
>> deprecated sepol_check_context() is used in chkcon utility. As Fedora doesn't ship
>> this tool I incline to remove it from libsepol as well.
>
> Looks like it is also used by setfiles and sefcontext_compile at
> least.  Might have been copied into external packages as well, e.g.
> busybox.  So that one might need to stay.  The reason it was
> deprecated was because it predated the introduction of the use of
> sepol handles and relied on global state set previously via
> sepol_set_policydb_from_file(), so I think the idea was to convert
> over to using sepol_context_check() instead (but this requires a much
> longer sequence of calls, ala h = sepol_handle_create();
> sepol_policy_file_create(&pf); sepol_policy_file_set_fp(pf, fp);
> sepol_policy_file_set_handle(pf, h); sepol_policydb_create(&policydb);
> sepol_policydb_read(policydb, pf); sepol_context_from_string(h,
> string, &ctx); sepol_context_check(h, policydb, ctx);).  Probably not
> worth the trouble now.

BTW Busybox urgently could use some modernization. It might not even
work fully anymore with recent kernels. For example its a user space
object manager (for the passwd class) and it does not use
selinux_check_access()

Theres also just generally a lot old stuff that has been improved since

It still works on Linux 5.4 (I use it with OpenWrt) but compiling it
floods the screen with "deprecation notices". Most notably for
selinux_context_t

If and once OpenWrt moves to Linux 5.9 (new LTS) some functionality may
no longer work

>
>> And there's also
>>
>> /* Deprecated */
>> struct sepol_handle sepol_compat_handle = {
>>         .msg_callback = sepol_msg_default_handler,
>>         .msg_callback_arg = NULL,
>> };
>>
>> void sepol_debug(int on)
>> {
>>         sepol_compat_handle.msg_callback = (on) ?
>>             sepol_msg_default_handler : NULL;
>> }
>>
>> /* End deprecated */
>>
>> which is used on few places internally.
>>
>>
>> Later I'll check whether sssd uses any on deprecated libsemanage symbol and
>> decide what to do.
>
> The main ones in libsepol that I was referencing were the ones in
> libsepol/src/deprecated_funcs.c.

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
