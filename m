Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9AC432BE
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0888960724
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 11:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhHaLqK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhHaLqJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Aug 2021 07:46:09 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C342EC061575
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 04:45:13 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id E16E12A0083
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 13:45:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl E16E12A0083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1630410311;
        bh=Vg6BKP6brojc9uw4eSTQmOjqhsK5V5qCGqYYCD2Hc2o=;
        h=From:To:Subject:Date:From;
        b=dXx/I4GRNNUI1k87Mq2AXWOJeQiUozSc+1sl8uny3pIbOwFBzAfPN/Dle8m7s7Mp9
         Vkj1qU6lYGjvVg9ipSilW7BPssEG5K31vw6thwmWtrxjbstsss6AbMe/5Rrl6ASzGn
         N69oizbIFOsL400pDaB0XKSHuVOyOnMNwMxE0ldk=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: libselinux issue
Date:   Tue, 31 Aug 2021 13:45:06 +0200
Message-ID: <87czpthm7x.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


We can get into a state where selinux is enabled without a policy.

Reproducer:

cat > /etc/selinux/config <<EOF
ELINUX=disabled
SELINUXTYPE=blah
EOF

Further info:

Reproduced on Debian Bullseye
5.10.0-8-amd64
SELinux 3.1

Note that *both conditions* above have to be met to trigger this.

If you only have a typo "ELINUX=disabled" then SELinux will boot in
permissive mode

If you only have a type "SELINUXTYPE=blah" then SELinux will not be
enabled because the policy cannot be found

root@bullseye:~# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             dssp5
Current mode:                   permissive
Mode from config file:          error (Success)
Policy MLS status:              disabled
Policy deny_unknown status:     denied
Memory protection checking:     actual (secure)
Max kernel policy version:      33

root@bullseye:~# ls /sys/fs/selinux
access                create            mls                  ss
avc                   deny_unknown      null                 status
booleans              disable           policy               user
checkreqprot          enforce           policy_capabilities  validatetrans
class                 initial_contexts  policyvers
commit_pending_bools  load              reject_unknown
context               member            relabel

root@bullseye:~# ls /etc/selinux
config  dssp5-debian  semanage.conf

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
