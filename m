Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B2C19759
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B97206A3
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfHAQMk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:12:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55666 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbfHAQMk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 12:12:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htDh0-0003zb-98; Thu, 01 Aug 2019 16:12:39 +0000
Date:   Thu, 1 Aug 2019 17:12:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] d_walk: optionally lock also parent inode
Message-ID: <20190801161238.GY1131@ZenIV.linux.org.uk>
References: <20190801140243.24080-1-omosnace@redhat.com>
 <20190801140243.24080-2-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801140243.24080-2-omosnace@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 01, 2019 at 04:02:40PM +0200, Ondrej Mosnacek wrote:
>  rename_retry:
> -	spin_unlock(&this_parent->d_lock);
>  	rcu_read_unlock();
> +	spin_unlock(&this_parent->d_lock);
> +	if (lock_inode)
> +		inode_unlock(this_parent->d_inode);

... and while we are at it, what's to keep this_parent positive here,
now that you've dropped ->d_lock on it?  Or to prevent it becoming
negative, then posiive _again_, with an unrelated inode?
