Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D1C04EB9
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 23:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D8621019
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 23:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D8621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeK3K65 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:58:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36150 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3K65 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 05:58:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSW5i-0005HN-Tf; Thu, 29 Nov 2018 23:51:31 +0000
Date:   Thu, 29 Nov 2018 23:51:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     omosnace@redhat.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181129235130.GI2217@ZenIV.linux.org.uk>
References: <20181127115246.00967523@canb.auug.org.au>
 <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
 <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAHC9VhRthWKfgYenGq6Az+jVQ+76wCeBhBcMyo9zZwv+nBhy3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRthWKfgYenGq6Az+jVQ+76wCeBhBcMyo9zZwv+nBhy3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 29, 2018 at 05:23:24PM -0500, Paul Moore wrote:

> > OK, I will verify that the SELinux submount fix rebased on top of
> > vfs/work.mount in the way I suggested above passes the same testing
> > (seliinux-testsuite + NFS crossmnt reproducer). I am now building two
> > kernels (vfs/work.mount with and without the fix) to test. Let me know
> > if there is anything more to do.
> 
> Thanks.
> 
> The big thing is just making sure that we don't regress on the fix in
> selinux/next if/when David's mount rework hits Linus' tree.

FWIW, the whole thing is getting massaged/reordered/etc. and I would
like some input from you guys at some point - assuming that I recover
the ability to talk about LSM without obscenities...

Question: what *should* happen if we try to cross into a submount and find
that the thing on the other side is already mounted elsewhere, with incompatible
LSM options?  Ditto for referrals, with an extra twist - what if we are given
3 alternatives, the first two already mounted elsewhere with incompatible
options, the third one not mounted anywhere yet?

Incidentally, should smack have ->sb_clone_mnt_opts()?
