Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E198C64EB4
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 01:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF7A20868
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 01:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF7A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3Mo0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:44:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37482 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3Mo0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 07:44:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSXjd-0000B1-L1; Fri, 30 Nov 2018 01:36:49 +0000
Date:   Fri, 30 Nov 2018 01:36:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181130013648.GL2217@ZenIV.linux.org.uk>
References: <20181127115246.00967523@canb.auug.org.au>
 <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
 <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAHC9VhRthWKfgYenGq6Az+jVQ+76wCeBhBcMyo9zZwv+nBhy3A@mail.gmail.com>
 <20181129235130.GI2217@ZenIV.linux.org.uk>
 <84796ec6-2603-7957-b159-e4c8b1e7362c@schaufler-ca.com>
 <20181130012707.GK2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130012707.GK2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 30, 2018 at 01:27:07AM +0000, Al Viro wrote:

> And then there's sb_mount, with 3 instances and arseloads of
> races in 2 out of 3.

PS: the 3rd one (in selinux) is, AFAICS, TOCTOU-free, because
it ignores everything except the mountpoint, which is already
looked up by the caller.  No idea what any out-of-tree ones do,
of course, but judging by the in-tree sample...
