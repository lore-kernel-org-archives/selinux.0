Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A356C433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 23:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiDNXhm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 19:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiDNXhe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 19:37:34 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C333962C92
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 16:35:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2354764A6; Thu, 14 Apr 2022 19:35:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2354764A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649979308;
        bh=oaPNVO/jlMPTu9ZGrEIiIB8vkI5uuW4nbM6DeNCLwrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gymhbNoRjX6xQTE0qZjx67hnRRDuc6fQ4wJdwrzaSHx4GvkfTXWorIgwt2EBpTo8S
         j3DnEu+2SNMjyvwB05y3ocJ73Kl7gtey4lB+OVJGMZ8jTayYRXA/DoqkkuzfpjDk/x
         SD600mNnJyI2ps77fC6omZg0tXRcPNA9MkskQaq0=
Date:   Thu, 14 Apr 2022 19:35:08 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: boot failures as of "selinux: checkreqprot is deprecated, add
 some ssleep() discomfort"
Message-ID: <20220414233508.GG21485@fieldses.org>
References: <20220414184325.GD21485@fieldses.org>
 <CAHC9VhR_-Gjh0=2GPhWXEkCPcgHuK4pqxia=ZH8EDLODGe63=w@mail.gmail.com>
 <20220414205624.GF21485@fieldses.org>
 <CAHC9VhTc6ZwO0Pog1bgJq8fcdAs2w5qpWLHt8N7uPqrXYgakLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTc6ZwO0Pog1bgJq8fcdAs2w5qpWLHt8N7uPqrXYgakLw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 05:12:09PM -0400, Paul Moore wrote:
> On Thu, Apr 14, 2022 at 4:56 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 04:38:13PM -0400, Paul Moore wrote:
> > > Jokes aside, I'm sorry that caught you out, but thanks for reporting
> > > it.  I thought I tested all the combinations, but obviously I missed
> > > one.  The obvious fix is to move the ssleep() call out of
> > > checkreqprot_set() and into sel_write_checkreqprot(); you'll still get
> > > the error message on the console, but you'll only hit the sleep when
> > > toggling the flag after boot, at runtime.  It's similar to the runtime
> > > disable deprecation.  I'll work up a patch as soon as I'm done with
> > > this email.
> >
> > Sounds good.
> >
> > > However, a couple of quick questions: this looks like a custom/hand
> > > built kernel, yes?  If so, is this an old kernel config that you just
> > > keep updating via 'make oldconfig' or something similar?
> >
> > Yes, exactly, I've got scripts that take a known old kernel config and
> > run make oldconfig.
> >
> > > I'm asking
> > > not to critique your kernel config choice (although this particular
> > > Kconfig knob *is* going away), but rather I want to make sure there
> > > isn't somebody/something out there still enabling this for a large
> > > user base.
> >
> > Got it, no, these are just systems I set up for nightly regression
> > testing of the kernel's NFS client and server.
> 
> Okay, thanks, that's good to know.
> 
> Since you're already building your own kernel you should be able to
> just add the patch I just posted to your pile, it should solve your
> immediate problem.

Yep, confirmed that I can boot after applying that.

> I would also strongly encourage you to drop that
> Kconfig tweak too.

OK, done, thanks.

--b.
