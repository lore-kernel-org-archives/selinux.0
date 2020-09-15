Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58450C433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE16206E6
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojf87OFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOSvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgIOSvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 14:51:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C3C06174A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 11:51:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m12so4296894otr.0
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BWhQ71DNq1aG0OVwxXwnfy0Ikcd3mTyiyocCBJBG3Q=;
        b=ojf87OFNzfgkSG2Eqk5k47bl7DF7fO22B251HltiqxuBxGl9MjFkLhO64cZMS5DCFV
         VMKeik8shSUglLKYxYi0MG3L+KsTq+Ml3n0vX9ayII3ioFg4DGFOv5LYKr9loDgJTL4d
         teNuX2BJJpCothL+vBuf+wtG8m4yQWeUk4zGJ6J25M6NULcDXlFY5xcoOgypS9tOzW1V
         ++i07em3Wws2d4mWTelzFXE25PEBok3L9RGspJ/hcy3RYbhyRMpIdwsjRVX88i5xfK5o
         ucXEx+oR/0pcBY4u4hm96JDoSzTqQSJVHXoPFfcw5wmOu02T/ojbMDYjsjC4GGHku5Ov
         mDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BWhQ71DNq1aG0OVwxXwnfy0Ikcd3mTyiyocCBJBG3Q=;
        b=pHiFriX0D3hlA0SrF7wTdNk0KgrOTEcIcGDdMr2T3dKWbOHOI50auHFT4Yj8lVxbdW
         thKUdoZaMhMk98JyJyAoN12n7LbBi0WdN9+iaBLLYZtSK2a1Zw6s1yC4ETz1FMopxN16
         B6RaryXgE07OJf/cbl8lIHoxDQ6Z4K4bqBo6T6Jyq0F8XP7TVKGjTxb+SRjVenh5OvHi
         Sc3CPj+YFr5JAaIo/2koa7NWedXebtnWcf309vxkggaG3ZtCPSnphNXd8TYp4+oJez/l
         E7VSv7n42VNm6FEXko0hBAacfvfXJDIa2mV5VqZNnT+Pw4p8mWsIA4fAInG4L0IYyB4N
         3Tyw==
X-Gm-Message-State: AOAM531hBPPckPaX7PBNoesy16q375Dc6Q4Vrk9WqKBwXJ8J7ZygvhMH
        TMySMXDGkDpmcQEusvLmdJhv58C1hm0VqD7Ct7lll+Sf
X-Google-Smtp-Source: ABdhPJxlOteJlqqBis8bx8W2BJZ89mMiffUVN8gbFlNUVNZkycjVpMv6CJ7eq2AEMHQq/hZBRHgj8vlyKO799VWb8ws=
X-Received: by 2002:a9d:23e2:: with SMTP id t89mr11159408otb.196.1600195870134;
 Tue, 15 Sep 2020 11:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <1c3c974b-59a6-6295-b018-c7139cc1299d@gmail.com>
In-Reply-To: <1c3c974b-59a6-6295-b018-c7139cc1299d@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 15 Sep 2020 14:50:59 -0400
Message-ID: <CAP+JOzRNTRTpMRfDBjN=67Lf-5tCjx_yAavn_UcDEzQK6Htd1A@mail.gmail.com>
Subject: Re: classmapping with empty permissionset and neverallow leads to
 invalid policy
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 12, 2020 at 7:42 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Hi,
>
> My policy makes heavy use of neverallow statements and permissionsets. I wanted to optimize it by using classmappings.
>
> I've found that calling classmapping with an anonymous permissionset that results in an empty set breaks neverallow statements using those classmaps.
> I think that this should be allowed. classmapping only ever adds permissions to a classmap, so if it is called with an empty permission set it should result in a no-op.
>
> A minimal reproducer follows:
>
> ; test.cil
>
> (user u)
> (userrole u r)
> (role r)
> (roletype r t)
> (type t)
>
> (sensitivity s0)
> (sensitivityorder (s0))
>
> (userlevel u (s0))
> (userrange u ((s0) (s0)))
>
> (sid kernel)
> (sidorder (kernel))
> (context kernel_c (u r t ((s0) (s0))))
> (sidcontext kernel kernel_c)
>
> ;; Begin interesting stuff
>
> (class file (open read))
> (class dir (getattr search))
> (classorder (unordered file dir))
>
> (type a)
> (type b)
>
> (classmap testmap (internal))
> (classmapping testmap internal (file (not (open read)))) ; results in empty set
> (classmapping testmap internal (dir (getattr)))
>
> (allow a b (testmap (internal)))
> (neverallow a b (testmap (internal)))
>
> ; Results in 'allow a b:dir getattr;' but should have failed during Neverallow checks
>

Thanks for the report. The problem was that the expansion of the
classmap was stopped when the empty classmapping was reached. I sent a
patch to the list.

Jim

> --
> bauen1
> https://dn42.bauen1.xyz/
