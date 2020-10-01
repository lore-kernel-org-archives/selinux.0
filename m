Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC9C4727E
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FBD206CD
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cROI5I3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgJAVlg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVlf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 17:41:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD95C0613D0
        for <selinux@vger.kernel.org>; Thu,  1 Oct 2020 14:41:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qp15so9322639ejb.3
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGzIL//UysOeCTi3bTLbuZ90o+bEblovFYSeXeQieZ0=;
        b=cROI5I3XdmN9fqq3K2L+W+KFaWxJ1NoNuXCbm4MIgH3QD/MVTm72/q3/YueeEqXEAr
         EACJmHK2DyjD/ly/dFzrduroZ/vlEIeVY+8ZgSFfNsb6vGJrb9YfKGIpa9LTrZv3wcWC
         DN9tmjcVif9/mnXRX8wEFFQKRNg/ADQZXRzMbfjdLPpByx+yDZHGV3ciiKs9gjvXVVaz
         377ksbWjJ+TAVXCSQBv3cV0C2laKfy0jTREee3c9OyC/7AottgfVmGW1q0Ki8QgXzm9g
         dtA4Z8r+dzt55bqjYTrcQ81vPkq3+GEV9QxB9A90lJMhPGf5s2m3U2O0tEHwYMuX7btH
         ikRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGzIL//UysOeCTi3bTLbuZ90o+bEblovFYSeXeQieZ0=;
        b=s3MDWi0Qualh9fuMjqOdcOD6NXVa1Ns3Dhf4MrKC764AE7WbswS9RSXHj/SjDpR817
         aZgAEh8PjBHSoRdAIFnV9nig1gpzEMC8MrFn9vYqoTN9bmkc6yvFZehbBU2ExGzEjrI0
         SbEwvUft+DfjX8479Hco1NBcf0pDrEtAPHesVsOY9pQ9mfNQbMhI45ZqrFlSR9SRVu5y
         HW6rf/k1qCeoO1hArrRBlKOQB96RcSdsy+z974gVLnOFogBx0xhGZwV06uQqIE8cFw6Y
         4ssze+QSmFofNYgMC316SaWxPdGxeXb9eqUpVhbLcdnsIPOmBpK0rQZZ0msokSCaTEks
         G1FA==
X-Gm-Message-State: AOAM531Vw0tGtK0/QQTC82OiPYgPx6JMmI7PUvqhZ9t5cEmOJ27jHuiD
        kdl6dUYI906U5RAxylL8p0e95B521+h10aKXISqq9fUYqQ==
X-Google-Smtp-Source: ABdhPJwtlVrjBD4y+eBMDfNfkMjbCOSW375mSFy+LPxrGCNSomsMlJ+4LOsJShwLVdf/Eww64DoJxQ/EaVpmUbwjHWg=
X-Received: by 2002:a17:906:14ca:: with SMTP id y10mr10110586ejc.542.1601588494145;
 Thu, 01 Oct 2020 14:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
 <20200927094243.43673-2-rentianyue@tj.kylinos.cn> <de004adf-fde6-11f1-fab1-11289788d4ec@gmail.com>
 <CAEjxPJ6z-ZsbsbdpDtOWxJ3_rJPjREKhNXkBn5bV_pYzW7AYnQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6z-ZsbsbdpDtOWxJ3_rJPjREKhNXkBn5bV_pYzW7AYnQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Oct 2020 17:41:23 -0400
Message-ID: <CAHC9VhTjrVtqbSAfpRSNYUSYx-mCur22bKvASHNY6fByOu+pFQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?B?5Lu75aSp5oKm?= <rentianyue@tj.kylinos.cn>,
        Eric Paris <eparis@parisplace.org>,
        yangzhao <yangzhao@kylinos.cn>,
        SElinux list <selinux@vger.kernel.org>,
        Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 9:31 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Sep 29, 2020 at 8:54 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On 9/27/20 5:42 AM, rentianyue@tj.kylinos.cn wrote:
> > > From: Tianyue Ren <rentianyue@kylinos.cn>
> > >
> > > Fix to initialize isec->class with SECINITSID_UNLABELED other
> > > than the from the xattr label when then dentry is NULL when
> > > the filesystem is remounted before the policy loading.
> >
> > Looks like this was broken by commit
> > 9287aed2ad1ff1bde5eb190bcd6dccd5f1cf47d3 ("selinux: Convert isec->lock
> > into a spinlock").
>
> It appears that the broken commit assumed (wrongly) that isec->sid is
> 0 initially, sets sid = isec->sid, and then in the out: path, if (!sid
> || rc) it sets isec->initialized to LABEL_INVALID.  In fact, isec->sid
> is SECINITSID_UNLABELED initially upon selinux_inode_alloc_security(),
> so that !sid test never evaluates to true.  And changing it to compare
> with SECINITSID_UNLABELED wouldn't be safe either since it is possible
> to end up with SECINITSID_UNLABELED without it being invalid.  I think
> your fix resolves the issue with ensuring that we retry upon
> subsequent attempts to access the inode but we should likely fix up
> this code.

Beyond the patch that has already been posted, I think the fix/clean
up is probably just to change the "!sid || rc" conditional in the
"out" jump target to simply "rc".  All of the code above that appears
to set "rc" correctly on error, which is really the only time (beyond
the posted patch) that we would need to set "isec->initizalized" to
"LABEL_INVALID".

-- 
paul moore
www.paul-moore.com
