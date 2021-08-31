Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB0CC432BE
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C5760FD8
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhHaLws (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241527AbhHaLws (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Aug 2021 07:52:48 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 820B1C061575
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 04:51:53 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id AAB942A0083
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 13:51:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl AAB942A0083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1630410712;
        bh=bEXY97Av4FlHlGUIAqwSdH2elT2yyqWca+Cn6navM+k=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=TKbs5duUCgOZ+blNLMcfIllokcWrRSbrAdnZg7GKzU3fv9MNpasC9DGjS8HH+o53b
         gduB+/b3hDPs1rabQtE7NV2aI5sN+tUQI2LyS/rnzjYX7J0AWqJ0kZpnmkQ/qmFjnP
         4Y0g+D+xFqqiyOvnd+KzQrZ7LmTZMEzct/eu0ef4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: libselinux issue
References: <87czpthm7x.fsf@defensec.nl>
Date:   Tue, 31 Aug 2021 13:51:50 +0200
In-Reply-To: <87czpthm7x.fsf@defensec.nl> (Dominick Grift's message of "Tue,
        31 Aug 2021 13:45:06 +0200")
Message-ID: <878s0hhlwp.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> We can get into a state where selinux is enabled without a policy.

Someone was sharp enough to notice an inconsistency in the info below. I
used "SELINUXTYPE=blah" where when I actually tested it I used
"SELINUXTYPE=dssp5".

Both are invalid and lead to the same results. So just read
s/dssp5/blah/


>
> Reproducer:
>
> cat > /etc/selinux/config <<EOF
> ELINUX=disabled
> SELINUXTYPE=blah
> EOF
>
> Further info:
>
> Reproduced on Debian Bullseye
> 5.10.0-8-amd64
> SELinux 3.1
>
> Note that *both conditions* above have to be met to trigger this.
>
> If you only have a typo "ELINUX=disabled" then SELinux will boot in
> permissive mode
>
> If you only have a type "SELINUXTYPE=blah" then SELinux will not be
> enabled because the policy cannot be found
>
> root@bullseye:~# sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             dssp5
> Current mode:                   permissive
> Mode from config file:          error (Success)
> Policy MLS status:              disabled
> Policy deny_unknown status:     denied
> Memory protection checking:     actual (secure)
> Max kernel policy version:      33
>
> root@bullseye:~# ls /sys/fs/selinux
> access                create            mls                  ss
> avc                   deny_unknown      null                 status
> booleans              disable           policy               user
> checkreqprot          enforce           policy_capabilities  validatetrans
> class                 initial_contexts  policyvers
> commit_pending_bools  load              reject_unknown
> context               member            relabel
>
> root@bullseye:~# ls /etc/selinux
> config  dssp5-debian  semanage.conf

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
