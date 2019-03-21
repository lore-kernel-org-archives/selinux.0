Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ECFC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B821873
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="msgY9Usi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfCUTB7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:01:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46898 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCUTB7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 15:01:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so6170521lja.13
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHQG1GlW6KzM71UIvx+FDBUltqcs3lAV7Z6ZQ2XlM8o=;
        b=msgY9UsiSF/Oatb1OdAJk3L8kzOnw6B1xkQdyq/G/Brsonz3vFKpe0fisLdOYeauO+
         Zn24WKira6JY8RdCeUPsHdRcS9SIiUH2AQBNW0odIsrD84NYCU4NpeWb31waXvaa4J5c
         3Up7dKoBQe3PLf2JKKzs4Ajmts/WzTPqwTXod9rDljzxzP/8HOB+Tksed+DW0K1X6klz
         L7ssU55UcdnFSElDIUvztRWwmfuHGyhqNg2lw8oZCCJOkihzcqOStu+D1x4K6Xi9EbQE
         8hbElf7ZdfdBmkoXrAMfcjCTmENlbSfUV80k3YGx7u7F4YEbVJWEtrAVlQX3MV6RHWD6
         f5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHQG1GlW6KzM71UIvx+FDBUltqcs3lAV7Z6ZQ2XlM8o=;
        b=VEksl6huSEldQkXMt3/DTUXWcTuJhpZiPjVbB8bSJQIx31Xe6qsG9yLJfj2Ia9vNQB
         jNynur3iFakmsl4OMk281NsSa3knxIOd1SAtAzIBdhZRDNqH/ObIX4sKawuKOkTwvu84
         iRrNcLnvwGtKVp7Eq2jpyTYo56BpQ4niF++cdkDRvLt9RrrsnM3zotxiTNJ2JQs8tGcl
         S8W69srjMCGicB9XLA/eC3sjymZVWatH2oOqGe+QYENW/LCBJD5ieMVXG1UYbm6gKMHo
         pCnRFvU4ZrbHOImdAJKeoXbonpcOE1JTFayRzZVsh8x4NKNY1Sb68Y6oP128qE8ZTLvg
         8G8A==
X-Gm-Message-State: APjAAAX5EVmxt9BZBoRvTxgrxC3U5raq7e6hCWywimb5ZJsG1Fk1HExD
        eudTxIjX3yHhHRSIzifxmPxvNQN0WRUfQxXSI1nF
X-Google-Smtp-Source: APXvYqymzJELCgxrRIO+Bx8yFEu7pCpQtrcEfr+7RXrUhW9PBEd6YXBMya3vqCJ+Li3fC1mO/IRBUxDXXI4GlN5RV/M=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr2900687ljk.38.1553194916609;
 Thu, 21 Mar 2019 12:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006294c30584141805@google.com> <20190321185835.GC11352@kmo-pixel>
In-Reply-To: <20190321185835.GC11352@kmo-pixel>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Mar 2019 15:01:45 -0400
Message-ID: <CAHC9VhTvP5oXTykVEuiPQ5Wnfr_Kies1W=Ur6adtpwUwiZw84A@mail.gmail.com>
Subject: Re: general protection fault in ebitmap_destroy (2)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     syzbot <syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        dave.hansen@intel.com, Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com, peter.enderborg@sony.com, pshelar@ovn.org,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        shli@kernel.org, syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, Vlad Yasevich <vyasevich@gmail.com>,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 2:58 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> #syz test: http://evilpiepirate.org/git/bcachefs.git syzbot-fix

FYI, I just sent a PR to Linus this morning with a patch to fix this problem.

https://lore.kernel.org/selinux/CAHC9VhRoo4_A0fg+Gp-Qsn_XVkTOQhe1pUShGig-k3ELKeW7XQ@mail.gmail.com

-- 
paul moore
www.paul-moore.com
