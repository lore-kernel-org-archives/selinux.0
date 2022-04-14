Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70900C433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiDNU6z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiDNU6y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 16:58:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C955CD648
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:56:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E4E04713E; Thu, 14 Apr 2022 16:56:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E4E04713E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649969784;
        bh=fHaz5qjooEO5/x02jRU2YUwyhpBQgt/pMBCWn0eTzDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVTPNfEhzFKX91vlRuRcFSHuWS8fkzGEGUj0umaF1vm4WM5FgE+gVWDbAXw/pvW1O
         4nJOpDLAcsUAS4WJthN9SvVLi6vpXl/aV+Yd5P3sT6Jq3g2gzx/TxZmGg6X8ZtftA4
         SA51Us/F0cLOEymNWcHTrj/E6Ol7jgi+VWd8O0ic=
Date:   Thu, 14 Apr 2022 16:56:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: boot failures as of "selinux: checkreqprot is deprecated, add
 some ssleep() discomfort"
Message-ID: <20220414205624.GF21485@fieldses.org>
References: <20220414184325.GD21485@fieldses.org>
 <CAHC9VhR_-Gjh0=2GPhWXEkCPcgHuK4pqxia=ZH8EDLODGe63=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR_-Gjh0=2GPhWXEkCPcgHuK4pqxia=ZH8EDLODGe63=w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 04:38:13PM -0400, Paul Moore wrote:
> Jokes aside, I'm sorry that caught you out, but thanks for reporting
> it.  I thought I tested all the combinations, but obviously I missed
> one.  The obvious fix is to move the ssleep() call out of
> checkreqprot_set() and into sel_write_checkreqprot(); you'll still get
> the error message on the console, but you'll only hit the sleep when
> toggling the flag after boot, at runtime.  It's similar to the runtime
> disable deprecation.  I'll work up a patch as soon as I'm done with
> this email.

Sounds good.

> However, a couple of quick questions: this looks like a custom/hand
> built kernel, yes?  If so, is this an old kernel config that you just
> keep updating via 'make oldconfig' or something similar?

Yes, exactly, I've got scripts that take a known old kernel config and
run make oldconfig.

> I'm asking
> not to critique your kernel config choice (although this particular
> Kconfig knob *is* going away), but rather I want to make sure there
> isn't somebody/something out there still enabling this for a large
> user base.

Got it, no, these are just systems I set up for nightly regression
testing of the kernel's NFS client and server.

--b.
