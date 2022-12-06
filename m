Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6DC352A1
	for <selinux@archiver.kernel.org>; Tue,  6 Dec 2022 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLFWtl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Dec 2022 17:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLFWte (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Dec 2022 17:49:34 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02794A078
        for <selinux@vger.kernel.org>; Tue,  6 Dec 2022 14:49:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 136so14701121pga.1
        for <selinux@vger.kernel.org>; Tue, 06 Dec 2022 14:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3YOk7QmVLaqd3ISsObkMka5HE5a1QK0ooo8SO4HwCcs=;
        b=hmGCxzHgrW03n/c2L9WWEk6cmVA7AwYgzgKY1qtyGPxK84x1OFe5CMJOYLyldaGICR
         zWTyumSntW3IyYVU9cpRQw+VoqWbTHxCH++oXcKd2dnGBY/v3Vjm1vGqZkGhskFrTM3L
         k1O/yqcnPGOuT5ht7YWWNcAgi9iyRTlnZrHUcQjDdnrrTWXDWClGO0lBpy9SGMxN80Us
         zyruGxog8NFWvD7WBfgKfkPxEr4NZduX6kGm3cd9vbmBLeNNal8ifB34XsY6mk3j6C2R
         0nN3nRrhjFClruMDh1I1ko+OPd0pckr6sOGX27db4fp6CFryA2650C7x0mlmzNCHi2ng
         V1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YOk7QmVLaqd3ISsObkMka5HE5a1QK0ooo8SO4HwCcs=;
        b=oGWQsiKN0xpv5r7kdXkU1BzhlaatcCrDqhd63TG5NmZPVZGoBREv+Ucf0rqCS2MpIQ
         EztYgBzqFMbNz9ojDVPjzVY/RubWLH2Vde8zRjcs5MJsxEfhy9bF7eAV4PWPW+yLpVe6
         2H04dV3uHHsy+61Fw0AVoimTPi7335/qMFD6gDSmw0LPlH2F0m5MmeyGJzMSxtVWBYLc
         BOlS6pfl/xWMFgdFo60RE4OpNFP8vfVE7KpTWFZLHagBv1J9ukXwK84jxnGTWU0UMUC0
         cR9lvjGyfrjlSrT3t+j98jKVYFRztt0Mi7N+7Qh4r13gd0VjEFCDX+G6bLKiNIx5wv6s
         31FQ==
X-Gm-Message-State: ANoB5plR5vGK9YWHT/wu3lgA6U5sHmq+dkq7oGr1fuPZXO8XsUTNBYLr
        aFwerfKCr292EOPwnkQOrKhqFscUWk1fxxOqkmhy
X-Google-Smtp-Source: AA0mqf6E1vaC0sUCBbynMxKLx1rni5YiJ4sneJVG4eqYFn3gMyHoV3U9fo0V84xJJNqhTXzHbU50Hwnar/9szIDP41s=
X-Received: by 2002:a05:6a00:440b:b0:56b:b53f:e887 with SMTP id
 br11-20020a056a00440b00b0056bb53fe887mr71632209pfb.3.1670366972083; Tue, 06
 Dec 2022 14:49:32 -0800 (PST)
MIME-Version: 1.0
References: <202212051932088061889@zte.com.cn> <CAHC9VhQnfMkrRNmEe0FtcFis3pkPp7Xd8dUbE3cT+cSni-9qxA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnfMkrRNmEe0FtcFis3pkPp7Xd8dUbE3cT+cSni-9qxA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 17:49:21 -0500
Message-ID: <CAHC9VhTq7s4Le59LS_Ygwju_AHUiDsL-B_mAaT1Ftaj_gB=MnQ@mail.gmail.com>
Subject: Re: [PATCH security-next] selinux: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 6, 2022 at 3:26 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Dec 5, 2022 at 6:32 AM <ye.xingchen@zte.com.cn> wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> >
> > Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> > should only use sysfs_emit() or sysfs_emit_at() when formatting the
> > value to be returned to user space.
> >
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  security/selinux/avc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> SELinux uses securityfs, not sysfs, for entries under /sys/fs/selinux.

Sorry, a little mental mistake in the above, SELinux uses *selinuxfs*
and not sysfs.

Thanks to the little birdie that pointed this out :)

-- 
paul-moore.com
