Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A4C433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 20:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB396127C
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhDSUZt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhDSUZs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 16:25:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D3C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 13:25:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j12so17268785edy.3
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxDL7RtZnq3IbGAkIDSuZ7dHwPh0tLLy6aLDkabdU7c=;
        b=DFjrZRQAS/fRhmWaiDyqXccfaXwCtjJD4RW2PD8lks72QxdszhcDoKUUF5M/DKuErT
         LkL7lMp4E9j3k7ZbN5mv9tQYgDvd9NzRNHB1w0zMbf08qKaWPj2rTqbd9LC0OAmXHs8y
         LBCWBmUaO/4Az38FYWxEU2Vmw5jspYht64v30KHVlOd0WmavWCnafZbptm4xK59aI4Vr
         1bA9zcgBKePDa0rqR2Vw8jofN/wfgHkWI/sbtbKNjv9Jum4shj/LTuD5NW5V4+xrIBCl
         BnbxFHVj2NmGM7nS/+mn9CufJNM8/TNEl49WiD0td0T49YgrMyAKL/i+PKLcRp1gMUhk
         s1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxDL7RtZnq3IbGAkIDSuZ7dHwPh0tLLy6aLDkabdU7c=;
        b=IvoFvl63a85E07D5/aftO9m+aztXm2LjQvpyPRqCHhFQt1Paph/lXUkRRq5Vf9E0G2
         S+ONE0nlsIj8kv4gMxF2L/JHqKVzo/nrtzOT8DpKikt8b4wBjmNRQsFnTMS2bB5rYmAG
         7PcppeULQybcD2XBwn1axMVAy5JBFtjA9059pchD1cF/mJQM8yXVdeo1gljNL2p+qzGP
         pe9vJ3Ae0KOub8/NrKyAWdKJT+Q+21Q+tClI2g0xwTp0/xbOKAiMtjoNEmHbclN+e1sl
         hB7N4oNqKpRG1q09DI28auZ5bya1yxuGXibyQlUd5OU58s9SdTK9lX3WsueSWWUDINcu
         Ci/w==
X-Gm-Message-State: AOAM533bqtSpyxkm8BwYep2qt8BvZhPaZwBj0i/8MrH3DJCB6bqta8n/
        bwiqzVORrtOHV05kyHz3EOawW/ey/xfnN+V8Zp9zYU7Pjtg=
X-Google-Smtp-Source: ABdhPJzW/Wbj8dNrmPd5W9bILLNRtKC/iOXVJxJQ/NZONGLi1L8VPKAN7aSPm5vQRcWIFGJxN8TfQaQf3joekB3SWQM=
X-Received: by 2002:a50:cc4b:: with SMTP id n11mr28164053edi.186.1618863913366;
 Mon, 19 Apr 2021 13:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQF7L_ecFzBsfG5EydnaZ7_NQeT4Yxi+aY9Q1Xj-N_0c7g@mail.gmail.com>
 <CAHC9VhRFeg2KLSy-2frtN=mBhR=5VBVUq1LXfAqjCL0VAvt=uA@mail.gmail.com>
In-Reply-To: <CAHC9VhRFeg2KLSy-2frtN=mBhR=5VBVUq1LXfAqjCL0VAvt=uA@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Mon, 19 Apr 2021 15:25:02 -0500
Message-ID: <CAFPpqQEbD-oX1C4nA7SuRHwRtOCcwht=zuBDO-03gYv1g4kAbQ@mail.gmail.com>
Subject: Re: no SELinux common criteria?
To:     Paul Moore <paul@paul-moore.com>
Cc:     SELinux <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Joe Nall <joe@nall.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 19, 2021 at 3:15 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Apr 19, 2021 at 3:43 PM Ted Toth <txtoth@gmail.com> wrote:
> >
> > Having read:
> > https://www.redhat.com/en/about/press-releases/red-hat-adds-common-criteria-certification-red-hat-enterprise-linux-8
> > and seen no mention of SELinux I/we are wondering what others are thinking/doing about the lack of certification? Are we going to have to take this on ourselves and if so what would be a good starting point (LSPP)?
>
> As a reminder, the SELinux developers list is an upstream list for the
> discussion and development of SELinux; it is not a distro specific
> list.  While the general topic of security certifications such as
> Common Criteria can be on-topic for this list, distro specific
> security certifications are likely best discussed with the individual
> distro/vendor.

The reference to RH was just an example of the lack of SELinux CC and
not meant to be a question specifically about RH my apologies.

>
> Last I checked, a CC eval of a general purpose Linux distro was a
> rather expensive undertaking, I doubt that any of the volunteer based,
> non "enterprise" distros would be able to go through such a
> certification without some form of sponsorship or corporate backing.
>
> --
> paul moore
> www.paul-moore.com
