Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A98C47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 23:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897D720835
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 23:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aO+Z8hcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfJGXIm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:08:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45843 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGXIm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 19:08:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so10446488lff.12
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lMvflkTdd4PTdUGeGyRTGtq0RYHD/JPRgTtr4fh+iI=;
        b=aO+Z8hcubdsvm0O5nhep4TV77yRH5Zf/rD9EGbPxvaQr2/a0epYWiHUUCZbcbjCnFK
         YDKbRw6wnCsh4bxMaQzzai5L/teAJTwmkfCSs2ICXtpmZlDKe+Y48fIy8Nv3/kVY68ss
         tgfclauO8mqZJ7PzYUbjW8JGavMNCOWYKFoTMn1AYybJzgJPBV1c3ziy/VK9QsWDjYQ8
         05CytSnUprD9QI8TnpP+fnpDuWnErROlNPYUzq8WCPQaUscY1HmCl7XWzyJCDg7h1aoD
         vgYeCZWFulYF/wXyA/LJofT7pKP9s4IpuRnaxq5JUUAjF798IWsWAEyq7L1RkhKGsx5+
         iV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lMvflkTdd4PTdUGeGyRTGtq0RYHD/JPRgTtr4fh+iI=;
        b=sAbP9JolDzkpVoZ/dDLTw8nS9kzus0tRbE+8iJpld2MuTdrR/rw70Wr487urJ4ej4E
         Q1e9EFy6iPXCdHjOmx2JK2aiyj5bRVG92Bl3Dk7wAcPVXQmzCr7Oc8ZmesquUPyU5//R
         vExkidNoUsc12CGMCpa5jBSe1XqKw98ncNDBYKYJMDQz0gESi7Bd1MG3VyPSakfDhAiy
         rHap1mBdjG2RVaHTGHAFScCjs2M4r+3adfpuoonmwgc0U6b2pwIjibDK84sGW5dL4HGU
         rSkAcLQE62Ccp9H4FMiirW/B7Ny6/T4bk1gaNYagZlcrguk25Znke/XCejsiCZ1Zn1vc
         ik3Q==
X-Gm-Message-State: APjAAAViqFKTBNnuxhlZ9cwF78ls2H/zQljYXMzSoAfuOLJ+tdOuYnk6
        Ot887Arzah5AGrxf06S0w8GlRzQoZcgjCgaorfgW
X-Google-Smtp-Source: APXvYqxbIazSTNErBkjGJpB9O4Kw5hEwqSB9cMkWUaTB9FIsA2hT4UJKuNUTGFVq6RFNFTYVNLYQIHqs5VEDjO4dsf0=
X-Received: by 2002:a19:8c14:: with SMTP id o20mr18015364lfd.158.1570489718507;
 Mon, 07 Oct 2019 16:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190909180557.8093-1-joshua.brindle@crunchydata.com>
 <0ea96cc4-11bb-5c4a-5f0a-75411a58e546@tycho.nsa.gov> <CAHC9VhQXf=h2BhaWvnwdJkLMHUdEV8F5pL4TSqAu6UkL3_FWpg@mail.gmail.com>
 <4999edd0-7b79-bc22-80cf-b45919254528@tycho.nsa.gov> <16d98abe468.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <16d98abe468.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Oct 2019 19:08:27 -0400
Message-ID: <CAHC9VhTR1=x_c9hYURFCy+DhsKZHT9RhCGM-K=UrhZBHmO39kA@mail.gmail.com>
Subject: Re: [PATCH v4] Add default_range glblub support
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        jwcart2 <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 4, 2019 at 5:27 PM Paul Moore <paul@paul-moore.com> wrote:
>
> It's in the queue. Two things have delayed things a bit this week: I'm traveling which has limited my time, and the - rc1 Rawhide kernels have been crashing at boot (it doesn't appear to be SELinux related) which has complicated testing.
>
> In general you can always check the SELinux patchwork, if the state is marked as "New" then it is in the queue.
>
> https://patchwork.kernel.org/project/selinux/list

... and now it's merged, although I did have to fix some line length
issues (hint to Josh: run scripts/checkpatch.pl next time).  Thanks
everyone.

> On October 4, 2019 2:10:31 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> > On 9/11/19 7:52 PM, Paul Moore wrote:
> >> On Tue, Sep 10, 2019 at 1:27 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> >>> On 9/9/19 2:05 PM, Joshua Brindle wrote:
> >>>> Policy developers can set a default_range default to glblub and
> >>>> computed contexts will be the intersection of the ranges of the
> >>>> source and target contexts. This can be used by MLS userspace
> >>>> object managers to find the range of clearances that two contexts
> >>>> have in common. An example usage is computing a transition between
> >>>> the network context and the context of a user logging into an MLS
> >>>> application.
> >>>>
> >>>> For example, one can add a default with
> >>>> this cil:
> >>>>
> >>>> (defaultrange db_table glblub)
> >>>>
> >>>> or in te (base module only):
> >>>>
> >>>> default_range db_table glblub;
> >>>>
> >>>> and then test using the compute_create utility:
> >>>>
> >>>> $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
> >>>> system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
> >>>>
> >>>> Some example range transitions are:
> >>>>
> >>>> User Permitted Range | Network Device Label | Computed Label
> >>>> ---------------------|----------------------|----------------
> >>>> s0-s1:c0.c12         | s0                   | s0
> >>>> s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
> >>>> s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
> >>>> s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
> >>>> s0-s4                | s2-s6                | s2-s4
> >>>> s0-s4                | s5-s8                | INVALID
> >>>> s5-s8                | s0-s4                | INVALID
> >>>>
> >>>> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> >>>
> >>> Merged.
> >>> Thanks,
> >>> Jim
> >>
> >> Thanks guys.  We're at -rc8 for the kernel right now so it's a little
> >> late to pull the corresponding kernel patch, but I'll do that after
> >> the merge window closes.
> >
> > Where does this patch stand?
>
>
>


-- 
paul moore
www.paul-moore.com
