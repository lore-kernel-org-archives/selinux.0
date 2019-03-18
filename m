Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCFC43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 23:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458E52171F
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 23:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aVQBB/49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCRXCW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:02:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39208 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCRXCV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 19:02:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so5805655ljg.6
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4bvq7tVhPygiofVHzwjueUT4qiXmTuAgEo/G+K3/j0=;
        b=aVQBB/495Cc+YcOa0hhd4tx6WQGNqdLfsL4hqnuq/t+1xH08uTltzMPK7HxHA7MeRE
         V2uB8jsLPgWLTDQtKyRr/oRU+6VXjKzaCLyEawDvQzT92A0pXgOkTwQajjsGKUWQHneS
         DxZa46aTOb+TKsZyPHIrb+pA3aSTpSVK7rtxbslINA0+2IwMrXzBwQETzVYIQcWaHhmf
         I3jvUkNa4xfzgL7vlWyvhE3sBGbn6AVGkjC82h7gCEZPGVPLGIatLhuyKopxoaT3as5S
         FIHhEaRsYnVv5FP47nVHP3nhqV3F1iU0mEVCxZcNFMAXikVWlGwU+18QXTPe1ymIf14+
         lAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4bvq7tVhPygiofVHzwjueUT4qiXmTuAgEo/G+K3/j0=;
        b=GjQZCRBbeLWDNIFwqwRWTAUwm5sWvtl498njf19BPfieOh4dDfXYgkKse+Bc7kR2Ox
         3tAdSAEApVxTQDPwOecl+ubXG0sg1FG+boNnmsTXjZ57/AkxcNSU1RZywd7w3IetNh73
         5Q194tfsdTU692RvYUqfCJoZ8vuLnZ4L5QPVx8GjxjWsLeoenRScxgjTF2EFwVJSfjY/
         pXo+gjMUHAqpAJHKHyWSAj+elRLsQfNtR8lR73difS9kKBv3oUNmdoN/MQmsfanQMBCY
         MJSjclp7iiFcUlX8fPBKV6TqJYY6rgroHB4LpgIWMccS18qs0AFkuuJJRGXXHHFz2/0B
         WFKw==
X-Gm-Message-State: APjAAAUXdY04SbrrWG5oddkUMQCFHhVOQFqSJA/z5tW7Cr3JDNNDjBnA
        e4OHQ5TmDhTd2UT2i91ESGjj4HrPUd8TvhV9t55m
X-Google-Smtp-Source: APXvYqxRUqr+XmHsjcYZIgq/Cazrl+veg1LXOJhu0PHu8HKZi7/GF9vXziV6/IgDG1tcN8JyXRyT85oQSBfvwypGtdo=
X-Received: by 2002:a2e:413:: with SMTP id 19mr11625359lje.196.1552950139728;
 Mon, 18 Mar 2019 16:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
In-Reply-To: <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Mar 2019 19:02:08 -0400
Message-ID: <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 18, 2019 at 6:51 PM Todd Kjos <tkjos@google.com> wrote:
> On Mon, Mar 18, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > Hello all.
> >
> > When running the selinux-testsuite (link below) against v5.1-rc1 I hit
> > the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
> > below).  I'm hoping this is a known issue with a fix already in the
> > works?
>
>
> Sadly, this is the first report of this, so no fix in flight. I'll try
> to get a fix up in the next few days.

No problem, thanks for letting me know.  If you need some testing
help, let me know.

-- 
paul moore
www.paul-moore.com
