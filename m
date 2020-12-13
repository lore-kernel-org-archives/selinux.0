Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A111C4361B
	for <selinux@archiver.kernel.org>; Sun, 13 Dec 2020 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B41923355
	for <selinux@archiver.kernel.org>; Sun, 13 Dec 2020 16:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437112AbgLMQda (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 13 Dec 2020 11:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436880AbgLMQdV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 13 Dec 2020 11:33:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F35CC0613CF;
        Sun, 13 Dec 2020 08:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sCN3Anbx+iYXLIlE4A4UXTtS9kAtcNY8aLxN+VneAf8=; b=I3BbV0LSx7uI2niy5L1Su8dLD0
        i5YBup/v+QJYhopBj+HcOxL44MnIcBtzJIyRBhqk4aeT+r+jgb1F4i9aAwVMesN1PQbbGZiVpkNz7
        oHITJBL/WSkVs7xF6Q/NuuG0zxmZZjRnwb/L93fruFuwQ4clJmU/9SGdp+jY06HO+GVOHinPJqTed
        BvqY2ppmvKLmvuQrmWMzBKyj8qEKBrfL4LMXFD7CDj0eYKxSES5pYhrB1x+H35279h+agrv4UTA+t
        Om4qw96P4IIDHimr0Gv2qC3I/hvvMjcbd8sZzPY+1FU1oBKabGIA2G+PcFM1DTY8+uMJJABbexYUS
        oQjqtF5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koUIU-0004KX-5T; Sun, 13 Dec 2020 16:32:34 +0000
Date:   Sun, 13 Dec 2020 16:32:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20201213163234.GH2443@casper.infradead.org>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <87tusplqwf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tusplqwf.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 13, 2020 at 08:30:40AM -0600, Eric W. Biederman wrote:
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> 
> > The pid_revalidate() function requires dropping from RCU into REF lookup
> > mode. When many threads are resolving paths within /proc in parallel,
> > this can result in heavy spinlock contention as each thread tries to
> > grab a reference to the /proc dentry lock (and drop it shortly
> > thereafter).
> 
> I am feeling dense at the moment.  Which lock specifically are you
> referring to?  The only locks I can thinking of are sleeping locks,
> not spinlocks.

Stephen may have a better answer than this, but our mutex implementation
spins if the owner is still running, so he may have misspoken slightly.
He's testing on a giant system with hundreds of CPUs, so a mutex is
going to behave like a spinlock for him.

> Why do we need to test flags here at all?
> Why can't the code simply take an rcu_read_lock unconditionally and just
> pass flags into do_pid_update_inode?

Hah!  I was thinking about that possibility this morning, and I was
going to ask you that question.

