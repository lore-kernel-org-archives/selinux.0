Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A88C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F121F60F0F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJKX3x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJKX3x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 19:29:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF6C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:27:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so57827354edx.8
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGun7lUla1XKCZef/mYsvN4zi2lqDqu7dWbtwd/v4s4=;
        b=EbPPBwfMGbCWjiDlndCpHkyNznqyDptW8jUveOyFLnJywwmfi8x0DdeKvArx+eHI8q
         SGZ/2gq4brQ+YGrhzYg1IYdhjgfWscW0bNLEB8fgw9SuGjau1SmckRwyNf6oBSrNQy9u
         5RAfesvPuGTgu3WD3Fvl28eeWErtw4zpGDcgWUaXkaZZY9Nl2uK5w4kNmW5QOV8jaOdl
         uLXHv4xeTQlBwYMAAnzH5G3Er7H51MCxJ9GwpSAsBj6v3vtm9Wzjyfnl7+y7fqeDQmzI
         kNBJSoVpo5mMhNlMeWMh4sDvSEfE+4TvyhqH1vBB/ljg4aVZktlWITx3cbWjNFGbWhdD
         AlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGun7lUla1XKCZef/mYsvN4zi2lqDqu7dWbtwd/v4s4=;
        b=RDjmSwU3oqWMSh/HZtjnfy72snA+jOwWlCwGNFgpaHG6y2I4UTRofvcTcNWASGG5eD
         wP4sdcLppo1GsVV+3U/mxDxaHS8djHG711WVbd0A8S5SNphxYWbq5PZormcp/Kpw96ES
         NPAnLubr9TE0xsJ9IePvSNX0baaEfFD2i83eRSGiQrNYWGzY9HbXb0e1MFcrgtzX5Q7m
         vwu11I5zWVLu23Lj5euUcS1kBxPaliLxNfWGCHy47Qin670Qd2MCPTRCGvCZ/CXzF1jX
         d5TckekJ6BBlHHecItAJlELZi5pcZguHjNCxFwdYt5brwIc0pcyoxT+fRHSiuUkLWZ+s
         BnSA==
X-Gm-Message-State: AOAM53081b6aMHXqogPlPPMKVzoUqQK3CiIyV/Sxl2JmT8HGWfWhlb9C
        31iyqeshULNM++ccgj+iHWSlblcYWnNyTZpYGdk3
X-Google-Smtp-Source: ABdhPJwCGHKdpB5Bmy+3TGnom7Tc6nPbH7LHMfoEG+xPqOv0GPRzS6pdfX0v5jTJTwgWiHZgbXT10I+IumVRQS5a7xU=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr45759937edd.256.1633994870369;
 Mon, 11 Oct 2021 16:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
 <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
 <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com>
 <CAHC9VhQF9R76ojBBrAQ=WHOAgHNGKJDobY+a_qohJJCQWQDw4w@mail.gmail.com> <CAFqZXNs_hU_r6uxiUiWPGiYhJ5EzdxMWWwtbp-ZPMfaZ1rTNCg@mail.gmail.com>
In-Reply-To: <CAFqZXNs_hU_r6uxiUiWPGiYhJ5EzdxMWWwtbp-ZPMfaZ1rTNCg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Oct 2021 19:27:39 -0400
Message-ID: <CAHC9VhRQdyF0tMGLgW1dzvwrKeH32z-n49ohxbhwFQLTVghxjg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 4:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Oct 7, 2021 at 5:34 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Aug 16, 2021 at 4:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Please try to come up with a better solution that leverages proper
> > > locking primitives, and if that isn't possible please explain (in
> > > detail) why.
> >
> > It's been a little while so I wanted to check the status of this ...
> > have you spent any time on this, or is your position such that this is
> > the best you can come up with for a fix?
>
> Sorry, I had to put this on the "let me get back to this later" list
> because of other priorities and didn't get to pop it out of that list
> yet :/ I haven't yet looked at other alternatives.

Okay.  I'm going to go ahead and merge this simply because it does fix
a visible problem, but I really would like you to revisit this in the
near future to see if there is a better fix.

While I'm going to mark this with the stable tag, considering the
relatively low rate of occurrence on modern kernels and the fact that
I'm not in love with the fix, I'm going to merge this into
selinux/next and not selinux/stable-5.15.  This should give us another
couple of weeks in case you come up with a better fix in the near
term.

-- 
paul moore
www.paul-moore.com
