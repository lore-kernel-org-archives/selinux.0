Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D6C43462
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 13:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5711761405
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 13:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhDVNta (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Apr 2021 09:49:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B8FC06138C
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 06:48:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so68942441ejc.4
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPXeKwdFlap14vs28Y4vSZZ6ciyFAPkqMaUPkDvcMVI=;
        b=g2Pegb2i5gH3n3l6hJjATWdi3iSRPPKWPvRDvTEh8fnjREBUy3Z+0lTtD7iRSCwtpO
         S6dk13ah5C7pNR+BxWjdF6CJEI1hJyjvHx1Excbh3MwvJEZkYb01U+PfxKwolPBMnMsv
         Uf4wboM3zz38RxIWdXdh/+f4aD7yUPbRZnGPDyct+BqSiufuihPwMrQXYU56rZ/HSMho
         hjJXDE1oQRmqQ9/P6odaumqtoOOIFhSqdg2yqS/k4Hs4Dl8RzQvdHOaurHCemzRmIpb4
         AARZ71ZmZjBKfLp2YsS4SNt/r/SQ6xa94MiIPNffXi+ZAa3e5efNCDW1v6g23jdlXSnH
         eigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPXeKwdFlap14vs28Y4vSZZ6ciyFAPkqMaUPkDvcMVI=;
        b=sSEmO2VrJtBELsBMth6wyhrDRcVTEnvLeoYoR/8WYdMcKMcMRvA5E06GmaL2/pp030
         J3RPW87jmLwgckCdl4K3ZKRFZm3mMS4RvuqQP04sqqp+St6EyOMcNrv0NMSou0hy06BD
         5t74UNcFTv3c9M3zFtLeu36I74E7ZYhIGaA8/Hf1KLnt9uIwiX9b5dMSzzHEcxPZKvTI
         GnKgMKxElly/ZoCwHD5l3xNeGa2V5zvb6dkWEWA5uyt9GQrvpwNpygPmoUKMrRjA+aua
         +M0zq2Sy4ScErPWI7VsYj+O3uEBUBQDBudx8YvSAGZaX6MA/nQVHsbCm8VaJ9/3c1duQ
         u42A==
X-Gm-Message-State: AOAM531RxSK30tc9xS4/24zN7ccGgTWSBO8F3EEMNdPqMsrCtoVooxIg
        /jspEPqApk7vOvj0eZZgD8TFOjSyZ5go9X5Z1O71
X-Google-Smtp-Source: ABdhPJzNjMPp6FcBf0oyaEMYIveL5pHdZ5Je333l9k3fLxHGpk6Jx7BPpTUP8ch+2YwXiWuNcvvo3mw84daOnYGoymk=
X-Received: by 2002:a17:907:16a3:: with SMTP id hc35mr3468498ejc.488.1619099331254;
 Thu, 22 Apr 2021 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
 <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
In-Reply-To: <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Apr 2021 09:48:41 -0400
Message-ID: <CAHC9VhS8F-3X6p2pmjvd0ripnpf=oRAA0G5bmE4yrdi-4sDyDw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 22, 2021 at 7:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Apr 21, 2021 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > This series aims to correct a design flaw in the original anon_inode
> > > SELinux support that would make it hard to write policies for anonymous
> > > inodes once more types of them are supported (currently only userfaultfd
> > > inodes are). A more detailed rationale is provided in the second patch.
> > >
> > > The first patch extends the anon_inode_getfd_secure() function to accept
> > > an additional numeric identifier that represents the type of the
> > > anonymous inode being created, which is passed to the LSMs via
> > > security_inode_init_security_anon().
> > >
> > > The second patch then introduces a new SELinux policy capability that
> > > allow policies to opt-in to have a separate class used for each type of
> > > anon inode. That means that the "old way" will still
> >
> > ... will what? :)
>
> Whoops, I thought I had gone over all the text enough times, but
> apparently not :) It should have said something along the lines of:
>
> ...will still work and will be used by default.

That's what I figured from my quick glance at the code, but I wanted
to make sure.

> > I think it would be a very good idea if you could provide some
> > concrete examples of actual policy problems encountered using the
> > current approach.  I haven't looked at these patches very seriously
> > yet, but my initial reaction is not "oh yes, we definitely need this".
>
> An example is provided in patch 2. It is a generalized problem that we
> would eventually run into in Fedora policy (at least) with the
> unconfined_domain_type attribute and so far only hypothetical future
> types of anon inodes.

Yes, I read the example you provided in patch 2, but it was still a
little too abstract for my liking.  I have the same concern that
Stephen mentioned, I was just giving you an opportunity to show that
in this case the additional object classes were warranted.

-- 
paul moore
www.paul-moore.com
