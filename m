Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD0C433E6
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 01:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F50A64E6B
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 01:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCEBcP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhCEBcP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 20:32:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC50C061756
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 17:32:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w17so364751ejc.6
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80N8FTktWaHp8/7shNAGY0Bb2p2RGTW77BNazisTaqc=;
        b=kwO3ZbQJvmoyZEcCsnZ+O5lefcSrFp4+zNeyaTxwbMuTmfsqLF3Zl3diE3rtVg3Nf5
         XWXIutDh7iwVsvz7hM2SbHDz75L4k1hdS7zjWDfGrEGtSQIalEqcvAeA+6ZMUMeIj4pe
         CMcbLw1BJUAAT79MYajlSgDqsgLNlVf56KvxaVcF6odqfB14mHAKqbBmKjnjbgbNRFkV
         /5bGDWxr9WX5/onrBYptac6azV0Lcs/AChdKXyW5sv+uplHNQIj1kdeUTSi0JzenFZwl
         FovvuSszpmZUmsiCuYj6WrEaKmUvmLlJhO0txFw323fvX3ZlpQ35xFNA7tudurvk0PjE
         Gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80N8FTktWaHp8/7shNAGY0Bb2p2RGTW77BNazisTaqc=;
        b=Gan3pOib7GpPfNamPJgjYx3YtsV6CWVu14H3TXruMPa/CceLOqM/F1q7xWAv495BjO
         GgUz1PLId33oOiBH/UHCn2ouZMHMbRBca1Ss5ePYhUS0aKY2+uty7fLXZHn+csWgqI37
         QlEcsvy1Gwenj6PgFGmxGDjSQk3QdysIWAonqIXQszmk1lPI20+2OZeyF7sc1SbVawKk
         c/Bn6LN/LJebUNMVZ+x82NtkafgGqcT7Qdm3sx4H01SFLRi2lGzZG2RaZNGQH9Ry086S
         BWkzji2cfT/hTH7pACW87C9WcebNqLd2Mrv1pZX8g9cN+05AvsG9FmWz+l/sOWrQUY9e
         Ndbw==
X-Gm-Message-State: AOAM532A1baWcFAudVhDlHaScZrGE2/QRIalScHiiZLuZg2X1EDZjxNH
        IOgIOVYd+OfIhRRt5l56CckU10Vy3XmURrOD4CiY
X-Google-Smtp-Source: ABdhPJwXTiyn3oCcRf5J9N21dl1QmjUNUXvdO1Y1u5UMG7hWl+cnxknz1WGXfqwWJgv/kNeDf6uhKrTXixDZprq98tc=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr227254ejf.431.1614907933967;
 Thu, 04 Mar 2021 17:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
In-Reply-To: <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 20:32:02 -0500
Message-ID: <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > Hi Casey,
> >
> > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> >> From: Olga Kornievskaia <kolga@netapp.com>
> >>
> >> Add a new hook that takes an existing super block and a new mount
> >> with new options and determines if new options confict with an
> >> existing mount or not.
> >>
> >> A filesystem can use this new hook to determine if it can share
> >> the an existing superblock with a new superblock for the new mount.
> >>
> >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > Do you have any other thoughts on this patch? I'm also wondering how
> > you want to handle sending it upstream.
>
> James Morris is the maintainer for the security sub-system,
> so you'll want to send this through him. He will want you to
> have an ACK from Paul Moore, who is the SELinux maintainer.

In the past I've pulled patches such as this (new LSM hook, with only
a SELinux implementation of the new hook) in via the selinux/next tree
after the other LSMs have ACK'd the new hook.  This helps limit merge
problems with other SELinux changes and allows us (the SELinux folks)
to include it in the ongoing testing that we do during the -rcX
releases.

So Anna, if you or anyone else on the NFS side of the house want to
add your ACKs/REVIEWs/etc. please do so as I don't like merging
patches that cross subsystem boundaries without having all the
associated ACKs.  Casey, James, and other LSM folks please do the
same.

-- 
paul moore
www.paul-moore.com
