Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13ECC41513
	for <selinux@archiver.kernel.org>; Wed, 18 Oct 2023 04:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJREfk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Oct 2023 00:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJREfk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Oct 2023 00:35:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BF593;
        Tue, 17 Oct 2023 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYQT9+blz7r7f5JPqtYLXwbpV6EPD3GUZ3EjmsXbKr0=; b=BHILHLNI4vlnIbUp1qdqp+gwBq
        RYR+gdFhNYfYF9HSxQD9uP9qUL1TxJFiZCOc1r42fzA9NtouTMvbAXBhfUime6+Tg/bIdRSDw8zcx
        tT+oRCGOrD4SbziL5UxgPqnfaJQaBCk3rQOU0aVMJPdkIe+xBZ+6nQp2vhkfKIrCkKO2o9VqxR8+q
        KH1zdHrI4nzG/kZKrED31sgdUh5Zl6EnvqptE15HIF8KGVB2AQbbVDlCUp0LRodE77LsuKZUutx6Z
        6Zf2S5rvSf+kYwXFE/fmdZmaQBpBHRVl4vf5D3aOK8awlLulEncOH1QcByq2YmSxJtC7zVGfu9NuT
        oVLyhhTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qsyHM-002Fgi-2i;
        Wed, 18 Oct 2023 04:35:33 +0000
Date:   Wed, 18 Oct 2023 05:35:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
Message-ID: <20231018043532.GS800259@ZenIV>
References: <20231016220835.GH800259@ZenIV>
 <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 17, 2023 at 04:28:53PM -0400, Paul Moore wrote:
> Thanks Al.
> 
> Giving this a very quick look, I like the code simplifications that
> come out of this change and I'll trust you on the idea that this
> approach is better from a VFS perspective.
> 
> While the reject_all() permission hammer is good, I do want to make
> sure we are covered from a file labeling perspective; even though the
> DAC/reject_all() check hits first and avoids the LSM inode permission
> hook, we still want to make sure the files are labeled properly.  It
> looks like given the current SELinux Reference Policy this shouldn't
> be a problem, it will be labeled like most everything else in
> selinuxfs via genfscon (SELinux policy construct).  I expect those
> with custom SELinux policies will have something similar in place with
> a sane default that would cover the /sys/fs/selinux/.swapover
> directory but I did add the selinux-refpol list to the CC line just in
> case I'm being dumb and forgetting something important with respect to
> policy.
> 
> The next step is to actually boot up a kernel with this patch and make
> sure it doesn't break anything.  Simply booting up a SELinux system
> and running 'load_policy' a handful of times should exercise the
> policy (re)load path, and if you want a (relatively) simple SELinux
> test suite you can find one here:
> 
> * https://github.com/SELinuxProject/selinux-testsuite
> 
> The README.md should have the instructions necessary to get it
> running.  If you can't do that, and no one else on the mailing list is
> able to test this out, I'll give it a go but expect it to take a while
> as I'm currently swamped with reviews and other stuff.

It does survive repeated load_policy (as well as semodule -d/semodule -e,
with expected effect on /booleans, AFAICS).  As for the testsuite...
No regressions compared to clean -rc5, but then there are (identical)
failures on both - "Failed 8/76 test programs. 88/1046 subtests failed."
Incomplete defconfig, at a guess...
