Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A69C3F6B0
	for <selinux@archiver.kernel.org>; Wed, 24 Aug 2022 06:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiHXGMK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Aug 2022 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiHXGMI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Aug 2022 02:12:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884B2CC82;
        Tue, 23 Aug 2022 23:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E1BFB82364;
        Wed, 24 Aug 2022 06:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B1EC433C1;
        Wed, 24 Aug 2022 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661321525;
        bh=84QIg8mjZORNMQfu9+bipPUwaBkNrBOe0l0wR+6oncI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlJoPWOUHk0fOj/1KpwhE0JCisTbXyRfHla2nFRIsagkS7hXZGlqpatxwJi3mIHj9
         VbANU1x4TwtBnhjmuWA226srsSVYL8Z9e/AATLRjib1zodncuQ2ZsEsqmHkMFb4EZa
         TwUkAfaFC7XKVCXBvVu2t/o4A/cvy0cXwWWFKwyI=
Date:   Wed, 24 Aug 2022 08:12:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/3] lsm,io_uring: add LSM hooks for the new uring_cmd
 file op
Message-ID: <YwXBMmdIJu3C5dPK@kroah.com>
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120326788.369593.18304806499678048620.stgit@olly>
 <YwR5fDR0Whp0W3sG@kroah.com>
 <CAHC9VhSkmJCXbKBOLDJjnap1+pYYnSVt2CzO3iQXmV7TZ+17SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSkmJCXbKBOLDJjnap1+pYYnSVt2CzO3iQXmV7TZ+17SA@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 23, 2022 at 12:48:30PM -0400, Paul Moore wrote:
> On Tue, Aug 23, 2022 at 2:53 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Aug 22, 2022 at 05:21:07PM -0400, Paul Moore wrote:
> > > From: Luis Chamberlain <mcgrof@kernel.org>
> > >
> > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > add infrastructure for uring-cmd"), this extended the struct
> > > file_operations to allow a new command which each subsystem can use
> > > to enable command passthrough. Add an LSM specific for the command
> > > passthrough which enables LSMs to inspect the command details.
> > >
> > > This was discussed long ago without no clear pointer for something
> > > conclusive, so this enables LSMs to at least reject this new file
> > > operation.
> > >
> > > [0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com
> > >
> > > Fixes: ee692a21e9bf ("fs,io_uring: add infrastructure for uring-cmd")
> >
> > You are not "fixing" anything, you are adding new functionality.
> > Careful with using "Fixes:" for something like this, you will trigger
> > the bug-detection scripts and have to fend off stable bot emails for a
> > long time for stuff that should not be backported to stable trees.
> 
> This patch, as well as the SELinux and (soon to come) Smack hook
> implementations, fix a LSM access control regression that occured when
> the IORING_OP_URING_CMD functionality was merged in v5.19.  You may
> disagree about this being a regression Greg, but there are at least
> three people with their name on this patch that believe it is
> important: Luis (patch author), Jens (io_uring maintainer), and myself
> (LSM, SELinux maintainer).

Ok, I'll let it be, but note that "Fixes:" tags do not mean that a patch
will ever get backported to a stable tree, so I guess we don't have to
worry about it :)

thanks,

greg k-h
