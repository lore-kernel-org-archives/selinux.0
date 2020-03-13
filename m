Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31827C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E60206EB
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ9g1KOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCMQDR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:03:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37370 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMQDR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 12:03:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id w13so9918756oih.4
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjHz4/gKF6GHbjP7E+0bL3Trj0cLzPmJUFDwiLB06a8=;
        b=NQ9g1KOjDQlpKAh00anji+YeXUwzCv1zbhlVjoRPATOF1ls4UZSLtmahOc2b7agHi9
         inTDVix3Jvf9RXUenrZ3EB9V8OJhjn59X9Tcf6CLAJouZXpxRG7LosVwBDWHAiwGKjmj
         qumm0INt/HLgXyFofYX1nMpGm9fys4UclAadfad9qcr+ygHtgLvdtSC2FtH0/dq9Jgmy
         rnaAvTkUMSQceGNMzz5mTst4i5zzhm4Sobj0rZI0+qGGjBZNVENVacvLR19+73ET1+aq
         Pfc3b0bDgfnYalIrvMfEPfTj2iGFfIkho2zI6pUA48VRcyiCfrRQkB31FtZzc4KdsrG9
         85pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjHz4/gKF6GHbjP7E+0bL3Trj0cLzPmJUFDwiLB06a8=;
        b=q5If/k6APPv5Wyke/88n5RallUBLn5oqJJQFSHZdsV/c/ZXNoaYw5Re8Z8h1VNTLwj
         yruPvjDC9Obh6WKElrI2qVR9NpJwaUl0m6hcLfq9zheXW95gMgTUviejaD8zHu4lL9MG
         JTMMh90LeVJTYX08AwzINXbX/gu9c/vCQnXFc5FqdZFekrTawjK4RZHl0IbXnUTGB4+A
         +157t+vrE98p1IpsMnat9DeEeIDJr59PvXwwk0VT9zN61UXiOflJvANiXdYkNjRPsAIp
         PjVuOKAOqivcwuYJkSgJhlfsSiu+Sg2X7Vh66rWawfKUmmJXWjNaBC89cJUvwgipfe5U
         NFOw==
X-Gm-Message-State: ANhLgQ0YeGbJF02ZDHO49ZhzUr3mUbsTjTzyno7u86WzAldgXc2dCVkC
        dBYERXsXRqSeqwRenSRrWKX43X4U2G07wEtH7TfPRw==
X-Google-Smtp-Source: ADFU+vvUioNrWfW2YBZqNzgTsn2TzsfRO27btWwYYu9YLdywDvCP1V0Rio+5Ra6komeYy8s5q9gYtz3y2ocDks5QuI4=
X-Received: by 2002:aca:5191:: with SMTP id f139mr7801298oib.140.1584115396519;
 Fri, 13 Mar 2020 09:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113637.20355-1-richard_c_haines@btinternet.com> <CAEjxPJ7Ds4J=7hO9K-B1pLXUfCgx4vFbMth-3nQW9x_4xV7S0Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Ds4J=7hO9K-B1pLXUfCgx4vFbMth-3nQW9x_4xV7S0Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 12:04:10 -0400
Message-ID: <CAEjxPJ7kjzaj4bz9=_oTJrLAYmDKfMZsC_eAGDj_N7Kbxm=omg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 13, 2020 at 11:47 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 12, 2020 at 7:37 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > If you test on the selinux-next kernel (that has the XFS patch [1]) with
> > the "NFS: Ensure security label is set for root inode" patch [2], then all
> > tests should pass. Anything else will give varying amounts of fails.
> >
> > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> >
> > I've revamped the nfs.sh to handle tests that require specific mount
> > options, these plus many more are now in tests/nfs_filesystem. This only
> > gets run by nfs.sh.
> >
> > There are two minor workarounds involving multiple mounts returning EBUSY.
> > These are either bugs or features.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > [2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
>
> Still failing for me:
> filesystem/test ............. 13/27 Failed mount(2): Permission denied
> filesystem/test ............. 18/27

Sorry, that's on me.  Wrong kernel.  Will retry...
