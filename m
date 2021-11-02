Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB531C433EF
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D960EE9
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhKBDQW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Nov 2021 23:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhKBDQV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Nov 2021 23:16:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6492AC061766
        for <selinux@vger.kernel.org>; Mon,  1 Nov 2021 20:13:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g14so8917268edz.2
        for <selinux@vger.kernel.org>; Mon, 01 Nov 2021 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImR1y3JaphUdqd3JeYTiTRE42eA3JabgzCrov3HxDTY=;
        b=PPpQn+f1YtZ8r3/iKBf2PkbvIFzo0gyycxMIKfe3JMofdLmSmLn++xD45P9f+2hzzl
         Zf8N1F3ToUi/7ntOft+Ylfm13qKKQOxHzdx8W/X05R50WhVf993YoX/yrpZN87t9AzQ3
         eOFaONyZei33zzAf9jEjITngbt5KhcQ/Ns17PbUk2z56fpOKIf/XwmYWAxE8OPlblqr0
         ZD0+NTl2iag7fmq+LiuAPDSBjssXY+7Dp36t14hADh2CP4juDSkX6rQkMR98xEUf/aPP
         +LwqM6enOwTYj9fImxSMiFRiTkFBLMxIbkbVGSQX7chfyzMIOEUxaCGjWosA7pmhTH+0
         D4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImR1y3JaphUdqd3JeYTiTRE42eA3JabgzCrov3HxDTY=;
        b=hGXWAG3Vi7xmtgxnBY9xLHKSVgOJfF0GiDmAIUFECR6VzudjOhmhatvUITMFPP8dJu
         xUDDPDtwxN1ufdSp7wnIrSJplMaGuFr+OEFExmLjgRuhdhfqPCVmZWJobh9aSuXHqAw2
         TPxINhoKrUH6iTIE2HbJMQAeahaS2JKQJMyVjE9ydsQcHEHxp4jX1k1+tesIR5qIDcI/
         FCN/ev7W+JzYRthnrKb5FjDB+3kFv7XR7rbvKqavdsPz8LHqNCPHFEgw/hChIduFIB1F
         JY7fy+EdCkTJLhrE9OpMELvI6gJwOYl9ihkMDAxcsohHs+zM/Ji5CHBjaVUssWiwWCRK
         mZrw==
X-Gm-Message-State: AOAM531Sjt2fwNKC+NpEaz7rddt4fDOAn3wLrGnlgKQ9lHR0vKrSE+yJ
        y+oMhczHi4ythzluKTr/97DTYElfcKi9KLRFqEGs
X-Google-Smtp-Source: ABdhPJweZhd8VLpBDfIfGU08rhV+YbiCX45grDUpmBIyS1bXzq26rwbOdLe0Fv7/r92eLdJQlhhjrpb5X9iny9ckbnM=
X-Received: by 2002:a17:906:f90c:: with SMTP id lc12mr32433055ejb.104.1635822825835;
 Mon, 01 Nov 2021 20:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
In-Reply-To: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Nov 2021 23:13:35 -0400
Message-ID: <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 1, 2021 at 8:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 1, 2021 at 4:59 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Add LSM/SELinux/Smack controls and auditing for io-uring.
>
> I started doing the merge resolution, and then I noted that there is
> no sign that this has been discussed with the io_uring developers at
> all.

I felt I addressed that in the pull request cover letter, although it
appears not in a way that you found adequate.  More on this below, but
here is the discussion history, with lore links:

*** Initial Draft (RFC) (May 2021)
https://lore.kernel.org/linux-security-module/162163367115.8379.8459012634106035341.stgit@sifl/

In the initial RFC you will see a lot of discussion with Jens Axboe
and Pavel Begunkov discussing the patchset and potential changes to
the solution.  Jens summarized his opinion on resolving this in the
message below, you'll note Jens approach is what was implemented and
sent to you via PR.

* Jens' Summary
https://lore.kernel.org/linux-security-module/46381e4e-a65d-f217-1d0d-43d1fa8a99aa@kernel.dk/

  "Sorry for the lack of response here, but to sum up my
   order of preference:

   1) It's probably better to just make the audit an opt-out
      in io_op_defs for each opcode, and avoid needing boiler
      plate code for each op handler. The opt-out would ensure
      that new opcodes get it by default it someone doesn't
      know what it is, and the io_op_defs addition would mean
      that it's in generic code rather then in the handlers.
      Yes it's a bit slower, but it's saner imho.

   2) With the above, I'm fine with adding this to io_uring.
      I don't think going the route of mutual exclusion in
      kconfig helps anyone, it'd be counter productive to
      both sides."

*** Second Revision (RFC) (Aug 2021)
https://lore.kernel.org/linux-security-module/162871480969.63873.9434591871437326374.stgit@olly/

This patchset implemented the approach described by Jens as well as
incorporated all of the feedback from the initial RFC.  There was some
additional discussion among the LSM/audit crowd but no additional
comments from the io-uring devs despite being on the To/CC line and
the cover letter explicitly asking for their ACKs.

*** Third Revision (Sept 2021)
https://lore.kernel.org/linux-security-module/163159032713.470089.11728103630366176255.stgit@olly/

The third revision only had minor changes compared to the second, no
direct comments to this revision although related comments continued
to be made on prevision revisions.  The io-uring developers continue
to be on the To/CC line, with no comments.

*** Fourth Revision (Sept 2021)
https://lore.kernel.org/linux-security-module/163172413301.88001.16054830862146685573.stgit@olly/

The fourth revision also only had minor changes.  The patchset
continued to keep the io_uring devs on the To/CC line and there was an
explicit plea to ask for their review/ACK/etc. but none was ever sent.

> Maybe there have been extensive discussions. I wouldn't know. There's
> no acks, no links, no nothing in the commit messages.
>
> So I ended up deciding not to pull at all after all.
>
> You really can't just decide "let's add random audit hooks to this"
> without talking to the maintainers.

*sigh*

I can promise you I've never done that, nor would I ever consider it.

> And if you _did_ talk to maintainers, and got the go-ahead, why is
> there absolutely zero sign of that in the commits?

I felt the comment in the pull request was sufficient, however based
on your response it clearly isn't.  Would you like me to edit the
commits to add various discussion tags, is this follow-up sufficient,
or would you like me to do something else?  Just let me know what you
need to feel good about merging this pull request.

-- 
paul moore
www.paul-moore.com
