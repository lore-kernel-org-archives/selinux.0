Return-Path: <SRS0=pblC=5K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ED9C1975A
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691D620722
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBZ/R2c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYOzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:55:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42981 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgCYOzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Mar 2020 10:55:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id z5so1894929oth.9
        for <selinux@vger.kernel.org>; Wed, 25 Mar 2020 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVWR5rESlXuiKU/ze22I03BXPHW9zT0bnHQlu6gMR4I=;
        b=lBZ/R2c2I+e1W3w9NSGRF8yLNVw1tSD4vkG/xAeTCmHvKjmw4zQeOt8o/rH7hnorL7
         3UbX7RPYKsarZiS20HQitl2Zn1GZxeLACq6roUGcA/aM+nYj9F388xGGsAEG90AgcRdx
         xYboBItFL3TgxkBSpSgo3Kc6HnNOmjd1Dc38b7X/zg3pScvkp3gjwUyPE/qMTAXMAwN5
         LUiOBVSC9BHbhMEcp8wEzf9RhgLmrwfKMU49YhEbFyiWk4Ilsa1AjzW28dR5HlzC72TB
         9l30LrhWf/zNA52/s8M58WtgHqaPxbGOqvgjXlZ2Ye7Q8njs5LMXz+0zjyG1ChWZ4Sck
         5gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVWR5rESlXuiKU/ze22I03BXPHW9zT0bnHQlu6gMR4I=;
        b=mLBylhnkeENbPNJanhA/ADjT4maOEwUe0SObSf4WmiAMZ2LMp/FYBNghALL0NWwvcY
         Np1wUWLMPSTKx+IOvCJzU/5lnpTzurTE3Y7ACbiWzp8iDedQNM5WBQPBvpIF4yeDrA3L
         BgAz4vCXjQchBi1gH1guxMhzE/auGCE1Qk6XFjqBBvbh+DWDWsqpCbPmj9MvR03Grv31
         qCdUs++Y50hVPrJmNMhLgtCz5I4eD/Ft7p+p4uWSUDZz9QVdX4dFrVfsdR/2SI0oz5Z8
         iJeBCPiX3+07WRvwSAaIluQByiXz/DavZ7XbdSLvydMPrOhgOD8ZVQS8UwjylXP1geFJ
         e8eA==
X-Gm-Message-State: ANhLgQ0R5VqikJZSyb3YJr9JUIZuiqsdeG6dKShdKjj97vngJfSHweHU
        pB5NNqjjs3VLbmDDKhJfgQsNlKrq1z867XkPRgc=
X-Google-Smtp-Source: ADFU+vt6cAkifOXssSHkuWTNdFW/2dtz9S1KV/UR936u+WJ2zqH+4Ur2CjJsLAmd3t00WVfeYbWCFgD7m66+89nmcQE=
X-Received: by 2002:a4a:970f:: with SMTP id u15mr1486944ooi.90.1585148107406;
 Wed, 25 Mar 2020 07:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200325130900.15047-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200325130900.15047-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 25 Mar 2020 10:56:09 -0400
Message-ID: <CAEjxPJ5K7Aa=6sJ236b1Qoa9VUePpEJyY=S0bNF2cm3Gd_dqMw@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 25, 2020 at 9:09 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> If tested on the selinux-next kernel (that has the XFS patch [1]) with
> the "NFS: Ensure security label is set for root inode" patch [2], then all
> tests should pass. Anything else will give varying amounts of fails.
>
> The filesystem types tested are: ext4, xfs, vfat and nfs4.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> [2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/

Thanks, with this version of the patches, make test and ./tools/nfs.sh
pass for me on the selinux next branch.
Still need to review all the changes and confirm that it is all
functioning as expected (e.g. getting the expected permission
denials).
Ondrej, how does this fare on RHEL-8, both with respect to differences
there in policy/userspace and with respect to default use of
xfs instead of ext4?
