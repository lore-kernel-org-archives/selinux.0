Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B154C433F5
	for <selinux@archiver.kernel.org>; Mon, 20 Sep 2021 02:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C41960F6E
	for <selinux@archiver.kernel.org>; Mon, 20 Sep 2021 02:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhITCq3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Sep 2021 22:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhITCq3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Sep 2021 22:46:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35247C061764
        for <selinux@vger.kernel.org>; Sun, 19 Sep 2021 19:45:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j13so55278953edv.13
        for <selinux@vger.kernel.org>; Sun, 19 Sep 2021 19:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3Ifk3gkF4EZgOSOMd5BgLpaHigpIrEHERLHWxDsnhms=;
        b=LVf1yeUaOvahbvnAr8QSl4J6ZtcbeULCwPTL7dt53FaJqSzp6G2JD/v8RAm+KDo8sc
         1qAdKYmaeRzsm7I3CY1R1cnpCx+XM862SyESXguq2cv13yt5vMg1VMR4JFhGE4vfhoKk
         w8FVR6rMzHt8XvuNyTW6Ztp7bihmi8Iypi1Iisxahzi1iAxmuj1yVBWgavP0uthDHohY
         lvKtLRtrDQLxh5uiOZNgN/MaR4JIYdgjHT8oMYOZiABn2JTBBFrxq0vBroAsfzZG0X3A
         o05l6ouifQ63PVw5owy9FwvYWmqGfcvrcVTtTDeJkvIMcYW7WHBeZl73sqRhvcmhAGOR
         DzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3Ifk3gkF4EZgOSOMd5BgLpaHigpIrEHERLHWxDsnhms=;
        b=px0+qppQLES07uOwS10YnKE13bcd25EYVAyELS9n1uKe6ZYTbKxBYn35m1tZmR2atJ
         30Ze4Kp0KCAxNbO3fpBP4HJrr/LjWCRxLlO7AVUjRV8e28MyJpcilDZFE7WKKc0WIOQ2
         yQZOBC8EA3xFWDaOGM1HlwYoYFSC9fdLx8IUGKsKex5z26rCMQWSYR5WwrLP9BQ07kT+
         YE4Eb6DeSuHjzpzZwmh7UgZbgtwooS66P+3I/pWxNN/N8fWv/lO6pVms7ZKSOnGSn/8G
         UGecCrLg5S3/VFzrFS8PqaxZKzP2VThxd/Qm5+Mg5U4aSZ6G9UOw9VTAdeF/Uyl+KhDT
         zM/A==
X-Gm-Message-State: AOAM530Bhbjdy37u9+wsU9d/FSaLY2GGh3m+Xm5UlZrp7pzAiB3D2uCu
        Ozo36SgB9ukDNVO2uHWAH9qXg4UsG6T90OB/q6H1
X-Google-Smtp-Source: ABdhPJw2UlastqklS4OK5FaL+3CWPBvyDVpEb1e1t4MZvuTxLVTwSniWgJwO2vosjrYuK5Il/R6vvtG2InMyHm29HSQ=
X-Received: by 2002:a50:cf48:: with SMTP id d8mr16576051edk.293.1632105901532;
 Sun, 19 Sep 2021 19:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <163172413301.88001.16054830862146685573.stgit@olly>
In-Reply-To: <163172413301.88001.16054830862146685573.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 19 Sep 2021 22:44:50 -0400
Message-ID: <CAHC9VhSn3pvUgUo5_T=TfiBXw3=f6Pn6GaAUVS=jfg-Kfr_ZEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Add LSM access controls and auditing to io_uring
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 15, 2021 at 12:49 PM Paul Moore <paul@paul-moore.com> wrote:
>
> A quick update to the v3 patchset with a small change to the audit
> record format (remove the audit login ID on io_uring records) and
> a subject line fix on the Smack patch.  I also caught a few minor
> things in the code comments and fixed those up.  All told, nothing
> significant but I really dislike merging patches that haven't hit
> the list so here ya go ...
>
> As a reminder, I'm planning to merge these in the selinux/next tree
> later this week and it would be *really* nice to get some ACKs from
> the io_uring folks; this patchset is implementing the ideas we all
> agreed to back in the v1 patchset so there shouldn't be anything
> surprising in here.
>
> For reference the v3 patchset can be found here:
> https://lore.kernel.org/linux-security-module/163159032713.470089.11728103630366176255.stgit@olly/T/#t
>
> Those who would prefer to fetch these patches directly from git can
> do so using the tree/branch below:
> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>  (checkout branch "working-io_uring")
>
> ---
>
> Casey Schaufler (1):
>       Smack: Brutalist io_uring support
>
> Paul Moore (7):
>       audit: prepare audit_context for use in calling contexts beyond syscalls
>       audit,io_uring,io-wq: add some basic audit support to io_uring
>       audit: add filtering for io_uring records
>       fs: add anon_inode_getfile_secure() similar to anon_inode_getfd_secure()
>       io_uring: convert io_uring to the secure anon inode interface
>       lsm,io_uring: add LSM hooks to io_uring
>       selinux: add support for the io_uring access controls
>
>
>  fs/anon_inodes.c                    |  29 ++
>  fs/io-wq.c                          |   4 +
>  fs/io_uring.c                       |  69 +++-
>  include/linux/anon_inodes.h         |   4 +
>  include/linux/audit.h               |  26 ++
>  include/linux/lsm_hook_defs.h       |   5 +
>  include/linux/lsm_hooks.h           |  13 +
>  include/linux/security.h            |  16 +
>  include/uapi/linux/audit.h          |   4 +-
>  kernel/audit.h                      |   7 +-
>  kernel/audit_tree.c                 |   3 +-
>  kernel/audit_watch.c                |   3 +-
>  kernel/auditfilter.c                |  15 +-
>  kernel/auditsc.c                    | 469 ++++++++++++++++++++++------
>  security/security.c                 |  12 +
>  security/selinux/hooks.c            |  34 ++
>  security/selinux/include/classmap.h |   2 +
>  security/smack/smack_lsm.c          |  46 +++
>  18 files changed, 646 insertions(+), 115 deletions(-)

With no serious objections or outstanding comments, I just merged
these patches into selinux/next.  If anyone has any follow-on patches
please base them against selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
