Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3EFC6FA82
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 06:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIWGrM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIWGrL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Sep 2022 02:47:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7050128727;
        Thu, 22 Sep 2022 23:47:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74FE968AFE; Fri, 23 Sep 2022 08:47:07 +0200 (CEST)
Date:   Fri, 23 Sep 2022 08:47:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
Message-ID: <20220923064707.GD16489@lst.de>
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org> <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> properly review the changes, but one thing immediately jumped out at
> me when looking at this: why is the LSM hook
> "security_inode_set_acl()" when we are passing a dentry instead of an
> inode?  We don't have a lot of them, but there are
> `security_dentry_*()` LSM hooks in the existing kernel code.

I'm no LSM expert, but isn't the inode vs dentry for if it is
related to an inode operation or dentry operation, not about that
the first argument is?
