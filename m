Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B93C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F09E2072E
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJMIT8g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFDOtO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgFDOtO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 10:49:14 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6DC08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 07:49:14 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j189so5277054oih.10
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muW3u6ZOjA4URacvYBfYgNkzOuMSh2VVjUQrov2nADg=;
        b=cJMIT8g9Q7JRhoFZ6Bxj6bOpmVuqcFvVMk6ivhPLFxKf8aAG+05suNS5IyJJJm/AVP
         CsM52snOJi18GSngulk3ejleAVBMoWNKNMzobLQsMtQx5jxewbs+DtoxJW9rZyHI522W
         UnHq7WbSNlla0FhdhAZeyHpLGhIDGYvHKvRhAnl3p/sA/J69167emJxoQB43Q1lvh0tx
         bWhv6YN8b+4p3NqKZjSB+i+1ck9Er21rRqzK/ZTySNkW20NcUgK4UhFJbQjS9v0PCgvS
         6Vp5No7W4c7X+yuOKH8D63uSKeVV+/BFxHnRLWzDAKVxqTalAO5WC21H9J6Cxxa5OjW8
         HkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muW3u6ZOjA4URacvYBfYgNkzOuMSh2VVjUQrov2nADg=;
        b=bBmZfFEPSMtaLQdNQXf4qzEfB2wWtw2WEaq1j5CiXmW8uUBOe6+R+mFQvTCDnYkEGz
         ISYyuDc99KFPkhaFZ9mQ640oSCHVyflp7uEX9PZ3TagDKsmBl0X2kIrEVR2Rlfxic39e
         oE7lC//AlUhQAZlLDJtZxfsR4M2Xy2Tq43K+Pat22lLe1XEmXe/Kq0VIsSSFCa6b2Xbn
         dRrr3GQwbRrnVHszqb56VpqGyZOLWwn8cv6ocCVKsYEHGu1YFodRNbVmeVFwr7GRChEb
         HrTwIj9MTtZp0QPKQpadWOraFr0k4JkZXVLjnvteLXrBLbWRWtR6yzVOBcCEqry4cRxj
         EHfQ==
X-Gm-Message-State: AOAM530c7QH20X3iaA1mrDCEccCiWMRt5MC2BWvkdhcDDFQrFV4owNQz
        JOMvqUNVdQqPpPs0lpUhAtedVLqy/y5EUR+xExIaTYGd6VU=
X-Google-Smtp-Source: ABdhPJzbhdp0YRy9hdmcl3UUV3YvZXDgKwjjk0B9f8C1hf2/lMcYuSSqktikyPHyrDSLTp2HQJvoKfpUIkTzjblEa4g=
X-Received: by 2002:aca:a948:: with SMTP id s69mr3374791oie.140.1591282153845;
 Thu, 04 Jun 2020 07:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester> <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
In-Reply-To: <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 10:49:02 -0400
Message-ID: <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 8:52 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Jun 2, 2020 at 8:47 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > We deprecated the SELinux runtime disable functionality in Linux
> > v5.6, add a five second sleep to anyone using it to help draw their
> > attention to the deprecation.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/selinuxfs.c |    2 ++
> >  1 file changed, 2 insertions(+)
>
> Warning: while trivial, I've done no testing beyond a quick compile
> yet.  I'm posting this now to see what everyone thinks about starting
> to make it a bit more painful to use the runtime disable
> functionality.

I'm concerned about how users will experience and respond to this
change (and Linus too).  Currently SELinux runtime disable is the
method used by distro installers (at least Fedora/RHEL and
derivatives) when SELinux-disabled is selected at install time and it
is the approach documented in distro documentation for how to disable
SELinux.  Hence, we'd be inflicting pain on the end users for what is
essentially a distro choice.  I'm not sure those end users will even
realize why they suddenly have a delay in their boot times since they
may not think to look at the kernel boot logs or miss the message
among the numerous messages logged already.  I guess the question is
whether there is precedent for adding this kind of delay to call
attention to a need for change by users; if there is, it would be good
if we could cite that precedent in the commit message to help avoid
later complaints.  It would also be good if we had a more thorough
wiki page or something that documented for users how to fix the
problem and referred users to that as part of the message (similar to
./arch/x86/kernel/cpu/bugs.c: pr_info("Reading
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html
might help you decide.\n");).  Just saying add selinux=0 in the
message might not be sufficient since users may not know how to modify
their kernel command line options, especially persistently.  Allegedly
the difficulty in updating kernel boot parameters on some platforms
was the original motivation for adding runtime disable instead of just
using selinux=0.
