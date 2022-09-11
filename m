Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F28EC6FA83
	for <selinux@archiver.kernel.org>; Sun, 11 Sep 2022 11:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiIKLgA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 11 Sep 2022 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIKLgA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 11 Sep 2022 07:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587D36DD9;
        Sun, 11 Sep 2022 04:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99390B80B31;
        Sun, 11 Sep 2022 11:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC6CC4314B;
        Sun, 11 Sep 2022 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662896155;
        bh=/k/uW9QqLq6w7OC6TvZAMLBzYew0y2Xj9AqzjJq2sFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mru9sQC6gW3Fl06q7NyXDusmjvEpoqJfnNv+lxKEdLuE/e/XY8MA/OYgsnzwEQWFc
         VYPRPyOjuIq0itY/7LJioZ0kCWxdH5jn8KOSbSOUTBdioNLXmPMWgUEm+TZJzvkvHE
         byFUCSVUxWJ6qPfyJ1tDnDQIOfDvvXuSHq7+ljlo=
Date:   Sun, 11 Sep 2022 13:36:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [v5.19.y PATCH 0/3] Backport the io_uring/LSM CMD passthrough
 controls
Message-ID: <Yx3IMBh7gBcDPyx2@kroah.com>
References: <166249766105.409408.12118839467847524983.stgit@olly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166249766105.409408.12118839467847524983.stgit@olly>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 06, 2022 at 05:03:36PM -0400, Paul Moore wrote:
> The stable patch merging tools failed to automatically merge the
> io_uring/LSM CMD passthrough controls into the stable v5.19.y branch,
> so I'm doing the backport manually and submitting them directly to
> stable for the next v5.19.y release.  The backport is necessary due
> to the reorg/decomposition of the io_uring code in io_uring/ during
> the v5.19->v6.0 merge window.  Other than the differences in the
> filenames under io_uring, the code changes are pretty much the same.
> 
> I've done some basic sanity testing this afternoon with these
> patches and everything looks good to me.
> 
> If you would prefer to pull these directly from a git tree instead
> of email, they are available via the LSM tree on the stable-5.19
> branch, using the lsm-pr-20220906 tag.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>         lsm-pr-20220906
> 

Now queued up, thanks.  Note, you dropped the original signed-off-by of
the original commits, which I had to add back by hand :(

greg k-h
