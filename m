Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53528C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DC02053B
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OcdWiwF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLJP6V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:58:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40176 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLJP6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 10:58:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id s22so20490502ljs.7
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEzPIee6pNHus2hM7ukA0TFs/leUR3YoNGkCo+m7X+8=;
        b=OcdWiwF2IPFEXVinDWDs9r34D/0XBAsh1i51ZzLjkBEMZ6IU+w5A5OvzU3FUT5AP6y
         EHZo0EfxBSMMisP/aeUu2gXQR9N0Mk1hrRvRsb6zio84jSEB6R87QhfAS03FOvF8jIl3
         /eJr4w4Kap6iPb2CCQqLpVd7yvu02IbbOKYnW0gAWNHYccRIDuAVZwE+/KrzYRXCm+xq
         7nVNsW5de7Z42ryhoPPRnlkedRZCGy5JMz/NMFg5ISc9+jItwy0S38S1ZoR25tmzdOnK
         m32BXquYyjkah3nQ9+xInHLP3l7ouPs+4AtSOZnIq0FS4p6X+FlhhdFxq3IQrYhOn1dS
         RvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEzPIee6pNHus2hM7ukA0TFs/leUR3YoNGkCo+m7X+8=;
        b=VG/64G8mE2kryWFchY+DqHV1JFCKHlSQ6M+xPtK3IH9IuRhcyzSVzlCHsqj0kZvOzU
         GmElP7TQrmK0l0M9+2PSm0NEaUDTS2Xh1KKlpqT4kPUND5a4ZYR6fmSIaBno4qEth8r3
         ROQq6pNM8ROcJoyT4jfK7FDFuUB0h2hzR0Ep42OLDboHVHSPXgg7BVqM8VC+6QvmgKpw
         mmiiBDPtHtOnNp/OsYUucNCOpnW6E8N4mXJ28goYyy4gLWLwhS1lurgpKq/9AKqsIXW9
         CeDyj2jMSgHhEEmGZ4kuXkh+gEfkjTMOhXMNnKGNuIxzYGxgrX7149hdzq3kLbif9P2F
         dpuw==
X-Gm-Message-State: APjAAAWthL2x3wR4KagYiA2uooON4MkbAhZKVUlY96FQKwoiJkW1J0O4
        G/MNwBeg6ZTO4Xt4Fe3aBR0J1q7Cah7qkbamrs3b
X-Google-Smtp-Source: APXvYqxXbSn/v5tMZSkgXLe21RUKVQldm8wnVs/okHayFlloRlBWnIs3FHi60D2H2iBj03JLYgmeGDbuiwUAo1b2Rc8=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr6865932ljj.243.1575993499711;
 Tue, 10 Dec 2019 07:58:19 -0800 (PST)
MIME-Version: 1.0
References: <157594493094.748324.9234611948545428995.stgit@chester>
 <285edbb5-b08e-5bdc-f951-841fe1d77521@tycho.nsa.gov> <CAHC9VhS4ksmcqBMzwQDArgd9xn_cJ+nyEBrHJcYjoiMaFzCq-Q@mail.gmail.com>
 <a11bfefc-c010-36ca-2303-35dcd4e9aa41@tycho.nsa.gov>
In-Reply-To: <a11bfefc-c010-36ca-2303-35dcd4e9aa41@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 10:58:08 -0500
Message-ID: <CAHC9VhRjs-pMWD-2ZTcF42eR3ugW7Bn7uYhmp4cQFneOtcqUkg@mail.gmail.com>
Subject: Re: [RFC PATCH] security: add an interface to lookup the lockdown reason
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, jamorris@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 10, 2019 at 10:45 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/10/19 10:04 AM, Paul Moore wrote:
> > On Tue, Dec 10, 2019 at 9:59 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/9/19 9:28 PM, Paul Moore wrote:
> >>> With CONFIG_AUDIT enabled but CONFIG_SECURITY disabled we run into
> >>> a problem where the lockdown reason table is missing.  This patch
> >>> attempts to fix this by hiding the table behind a lookup function.
> >>
> >> Shouldn't lsm_audit.c be conditional on both CONFIG_AUDIT and
> >> CONFIG_SECURITY?  When/why would we want it built without
> >> CONFIG_SECURITY enabled?
> >
> > My first thought of a fix was just that, but I remembered that the
> > capabilities code is built regardless of the CONFIG_SECURITY setting
> > and I thought there might be some value in allowing for lsm_audit to
> > be used in commoncap (although in full disclosure commoncap doesn't
> > currently make use of lsm_audit).
>
> Seems contrary to normal practice, i.e. if/when commoncap grows a
> dependency, it can be changed then.

Okay, want to submit a tested patch?  I really would like to get this
fixed before today's linux-next run.

-- 
paul moore
www.paul-moore.com
