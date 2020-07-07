Return-Path: <SRS0=l4yV=AS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5822BC433E0
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAF5206CD
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 20:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LlKN/nR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgGGUzd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgGGUzd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jul 2020 16:55:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6FC061755
        for <selinux@vger.kernel.org>; Tue,  7 Jul 2020 13:55:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so39832555edz.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2020 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sTm+kq/KHY4UJRXtMkJc8MAWnZYPsHEG2XUeGnRBius=;
        b=LlKN/nR04KXPL/QkuyreMBlJ4V5dVDBqyZvZaZs0ArKIp+2wDQZxq359yxQExCf/2C
         VKlMs6N1TWm7JDgo1HhCzy9mMgOlqe6xfL42ii2US1xdRApGRzku9D1xeA+1Ug26jv0l
         mZI/Zq8h8FweojGN3yCkqwHUxK6oRTh663cuaHWfpg8/2gfR1kB5rmTp/7YHnzqxZod3
         BQb/ZSHiWNdWfdIkjpaX577G/VYkWKeApCu+8kmWLXLnvMqqBNATyI1k0M8mffEoEAs3
         KGdMVYcXC+0HAwNphKe/Zwc/n5y1xgMti5oGwzb0ajykW1ILPi58gjtFOMuOq/JqR7rc
         5eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sTm+kq/KHY4UJRXtMkJc8MAWnZYPsHEG2XUeGnRBius=;
        b=SVQnD7ZBcaYcxqWorRKX0bLwutDkjvk3UDIJNCjoLWwEIURhakPDIN2gpsidpIK3i0
         OmC96rcwmhgB/D9AwHGRGSE6OYCYk3Atny4xmHLd/0hZKdGA0F2ghiSX6U2MccVDIMzN
         uYKWdMBtJhbnvxagXuyweOno8i39C1jIs24LQOiOYIBRioscoM5OTMbfZIyEnZayk4I3
         SpKg9c4kxUazIlEzWl5OVQCgE6H+R10x6E8ScEmcCtO0APSr0lgPUeJcg1ezuKEyr5lW
         ag8sKeaqAjqXqXQ8ChPj1KaA5mFMnlrQWxXK8EI1cxk8AgJ5FZNH2i04oJTGXUpGWseo
         T6Fg==
X-Gm-Message-State: AOAM533uew0EUV0pxuR+By2KNYdwwv/r2z1P0Kcsqidi2x/7GbM7mwTE
        6OStdWm97hK0gpyCdMblrWem8VdFm8Ziwvr7ycUu8SG0vw==
X-Google-Smtp-Source: ABdhPJxWc3weM8+8FU0kFl2r7lfba95FNtP1lB6EAGXDTabhgbjIA9y0k2L+wdXQgabwYS6Ho2Orr/CWtTLA+chrEnk=
X-Received: by 2002:aa7:c883:: with SMTP id p3mr65045349eds.128.1594155331590;
 Tue, 07 Jul 2020 13:55:31 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jul 2020 16:55:20 -0400
Message-ID: <CAHC9VhTuDrgzeh9mXgkW98psssUCwy5i7_=Kx6hOyinfLjcd0w@mail.gmail.com>
Subject: ANN: The SELinux Notebook in markdown on GitHub
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If you've followed the SELinux developers mailing list for a while,
you've surely heard of The SELinux Notebook.  For those of you that
haven't, The SELinux Notebook is an effort by Richard Haines to
document all the different aspects of SELinux from the kernel up
through policy.  It's an impressive piece of work, spanning ~345 pages
in the current edition.

Richard has always made The SELinux Notebook freely available, but
with the latest edition Richard has converted the entire document to
markdown and it is now available on GitHub at the link below:

* https://github.com/SELinuxProject/selinux-notebook

Richard has decided that he enjoys life enough without a GitHub
account, so I've posted it on his behalf and with his approval.
Needless to say, this is a significant gift to the SELinux community,
and we all own Richard our thanks.

I've made a few tweaks to the original import from Richard, but these
have mostly been limited to boilerplate, organization, and some
build/formatting fixes so that we could generate a reasonable PDF for
this initial "release".  The latest edition (release?) can be found at
the link below:

* https://github.com/SELinuxProject/selinux-notebook/releases/tag/20200707

It is my hope that we can treat this as a living document, keeping it
current so that it stays relevant and useful.  Those who wish to help
and contribute to the effort can do so via patches to the SELinux
mailing list or via GitHub PRs.  The CONTRIBUTING.md file in the
repository has more information.

Thank you Richard!

-- 
paul moore
www.paul-moore.com
