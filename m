Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98082C64EB4
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7020867
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A7020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeLACT7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:19:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLACT7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 30 Nov 2018 21:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0D5058E4F;
        Fri, 30 Nov 2018 15:10:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCE505D782;
        Fri, 30 Nov 2018 15:10:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
References: <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com> <20181127115246.00967523@canb.auug.org.au>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11580.1543590618.1@warthog.procyon.org.uk>
Date:   Fri, 30 Nov 2018 15:10:18 +0000
Message-ID: <11581.1543590618@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 30 Nov 2018 15:10:22 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> wrote:

> - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))

It's not a bitmask, so you can't do that.  You'd need to do:

	if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT ||
	    fc->purpose == FS_CONTEXT_FOR_SUBMOUNT)

or use a switch.

David
