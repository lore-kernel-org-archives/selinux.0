Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF5C4361B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 23:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35815238EE
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 23:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgLHXqC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgLHXqC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Dec 2020 18:46:02 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01321C0613CF
        for <selinux@vger.kernel.org>; Tue,  8 Dec 2020 15:45:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jx16so314165ejb.10
        for <selinux@vger.kernel.org>; Tue, 08 Dec 2020 15:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+tKBuNwm3EZlCxsMkbGf+EVI96ia4AUSb/DLK8+Vcw=;
        b=sfTXnr4tOaWYhaDEzNGQxI503/F70SEGUBImxG+EkrmKCP3JiQRm2frumGN830CLIZ
         x/MERHkBZHS37WJrni0jFNemf5zbmhvWxcv3YfGq1zQFsD96LDHpyhXjRNNqgnOKMZVO
         N8Pj10tO3XkSYdv2N6fiMevxMuVGYAs2NKYaE1JyzRnZZ/PF6OHSe+CfHjDD/UAe9MAJ
         o6GtPEr2kifvJKP3XdKXSq+qHFiGlAxZe6xhqR5wKZwm6qkQIrOdqCr2MDmmNYLLzagO
         dyFa4PuNpCOJIOWWYJaQiAYaiin/gkYhPmVf2t2fyTpOuY/87tx5/F2OQC8Q1Wz9eWcr
         lsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+tKBuNwm3EZlCxsMkbGf+EVI96ia4AUSb/DLK8+Vcw=;
        b=dO5jkEMna93xU0xxJNh7MXbw5JNRHew2VuIO3+akPdxoywOO1qbJWUcxRqb6YVjpih
         44C6tkBCtpeU+ZEg8VMWQYTVJxpx6M8Iwl7LjC73wZ0hNQ14PWZY21Pt7xV+Hhdq88Xm
         ztv0pIb04GcwQ0gcwVrSDTBHcIXqmlNodDtuHn0Dt3QCaxYxAWC763C8L8rb9bFt6tA3
         +MYBDbiCPfhdwDOaybSxTJaXXI7GC43vrqsiaMaOYHlhLTkBNAs20Ze92khg2JkcH9av
         w3A2diIte9iT6mQHlpAk/p2uiYUil2ZNoySv+2h9nT3Ljc5+X+00/E1kaKD2JJyeuqtu
         kuMA==
X-Gm-Message-State: AOAM531gvhQRPRzQY2dtarD84OzuGZYSgXaa6C8+HqxzpcVU7aqTj0yZ
        piehZZ79fYr4eMwDs0o3urK1KtOcnn6BByvN64GK
X-Google-Smtp-Source: ABdhPJzbgScJ1KjxWp2MOPy7rhWsLjFqueikfsA93x8keOflJqKKnGrzkxWjdg8G/jIBxPvlw6E/j0e+B/27bX6v53s=
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr101469ejz.488.1607471114504;
 Tue, 08 Dec 2020 15:45:14 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com>
In-Reply-To: <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Dec 2020 18:45:00 -0500
Message-ID: <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     James Carter <jwcart2@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 7, 2020 at 12:17 PM James Carter <jwcart2@gmail.com> wrote:
> On Mon, Dec 7, 2020 at 9:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hi everyone,
> >
> > In [1] we ran into a problem with the current handling of filesystem
> > labeling rules. Basically, it is only possible to specify either
> > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > virtiofs, certain mounts may support security xattrs, while other ones
> > may not.
> >
> > So we can't use the xattr support by adding fs_use_xattr virtiofs
> > (...); to the policy, because then a non-xattr mount will fail
> > (SELinux does a mount-time check on the root inode to make sure that
> > the xattr handler works), but we also don't want to stay on genfscon,
> > because then we can't relabel files.
> >
> > So my question is how to best address this? One option is to use a
> > similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
> > labeling, but that's ugly and requires hard-coding another FS name in
> > the selinux code. The only other alternative I could come up with is
> > to add a new FS labeling statement that would specify some kind of
> > mixed genfscon / fs_use_xattr behavior. That would be a better
> > long-term solution, but leads to more questions on how such statement
> > should actually work... Should it work the cgroupfs way, giving a
> > default label to everything and allowing to set/change labels via
> > xattrs? Or should it rather just detect xattrs support and switch
> > between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
> > on that? In the latter case, should the statement specify two contexts
> > (one for fs_use_xattr and another one for genfscon) or just one for
> > both behaviors?
>
> I don't think adding a new statement is necessary. It seems like
> allowing both fs_use_xattr and genfscon rules for the filesystem in
> policy and then using the fs_use_xattr rule if xattrs are supported
> while falling back to the genfscon rule if they are not would do what
> you need.

That seems reasonable to me so long as this ambiguity is okay with the
folks who do policy analysis.  Thinking quickly I'm not sure why it
would be a problem, but the thought did occur while I was typing up
this reply ...

-- 
paul moore
www.paul-moore.com
