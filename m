Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE00C433E0
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 22:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B75E20748
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 22:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzpJyzci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgEUWjn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUWjm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 18:39:42 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA2C061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 15:39:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so9394282iou.2
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJKgljPzZPW1CC03coJnQ7k/pEC2RVFmuPVj+/73hmw=;
        b=EzpJyzcixp3XebLCmCJOu2fiB35eYFCdO4HBJIDhm+O3eLFPaCYbSNP6jyivUtJzxp
         G7NW88DT9XFfu4vL2QMJgzqPt05hmTJ1Iy/jn16vcCUbS3MG0T+K8U/unKYrkLAS4jYP
         25JKvEbqyEqdLErFGjpM2uZAhbI79sCW1FYXte0lvdGXdJVNSUV4rE8zV5RXhx6i9iaR
         6LJy8IQX5xV7ccPJ5Yqw99VPuL5qKLg3pM5T8yatQ5pAbF6DW4p58hTxVvcG73uBzhZv
         /3eKpi45S+Q1gvFs1idyUSU6lToQz7Rp+ph98PtAUqtfq0oa0VYmFeE5oq4YNXNK1fmg
         PzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJKgljPzZPW1CC03coJnQ7k/pEC2RVFmuPVj+/73hmw=;
        b=juqnOQ9DFTSYIoAZ9jZoUmS2u+FsgZHE/l1qIpCwO3Nhm00TDW6IUFBiFy8dAvtoYg
         pHsmmcsyIr6Il93Bq0wbOl5OdIFX0mcgFFNfcN1Xi1rR7OoRDiNVOF76vhw4j7Ox4EqC
         +cotAfbx31Oi2pqCssN06w4lTufgBddpKejzVyKyLZq2OJ/viPPYRUZ2lKxfnZx9vv8q
         05pjwKwnT7O6fvuI1jpydDMxTEJuNa8MsC5l+O8zDH+jf+NdggpLAkyJD1iL0UnRlJHL
         ztf9lxHi0pc2MBk8edYUhG0KwKmz+IK7B1mVEWhWacx12R5+kTFdnjaOPUB7EeAh7yfn
         BaTQ==
X-Gm-Message-State: AOAM530CcuDP6DoQVeJq1oNpbKIN64rKrEbPA+rmjUG5OsNwzyNqkiFY
        /p/eWBIxz0wkxYD6gdpY/gUUnIDTAwS1UD6W6J0YzKDF
X-Google-Smtp-Source: ABdhPJxZO+0PjdhxREeYBDPfhqRPAtUk4B/doePsaZI9YrtmKiq1kZCf+McV79hIZuHTtRXi3+tMvpW2q29LvlSET8k=
X-Received: by 2002:a02:bb8a:: with SMTP id g10mr6134680jan.130.1590100780809;
 Thu, 21 May 2020 15:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAJfZ7==gpPvF5eKJLFK=ky=UEXtbnX-r6WyB1zh6NfvRFHEHtA@mail.gmail.com>
In-Reply-To: <CAJfZ7==gpPvF5eKJLFK=ky=UEXtbnX-r6WyB1zh6NfvRFHEHtA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 21 May 2020 17:39:30 -0500
Message-ID: <CAFftDdpDpAw6W0d6OaCcaWYSO6g_zguO-D8u+fLYAW45nyGukA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<snip>
> * fedora-test-runner.sh uses ~, which is expanded to /root as it does
> not make sense to run this script as non-root user. In my humble
> opinion, using /root instead of ~ makes the script even easier to
> read.

I forgot to mention this in my previous email, this is the only thing
I really don't
want to change. You could, in theory, configure any user to run this.

<snip>
