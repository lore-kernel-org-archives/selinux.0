Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C4C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299C7208FE
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 21:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="f0tShOvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgESVlB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 17:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESVlB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 17:41:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AAFC08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 14:41:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z5so773396ejb.3
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lIiU6asn3acv1GpmbwGe/AHI5yhvXdxYG1yTmSRTzA=;
        b=f0tShOvfUZ3+6CbbRSoUmDHAqEofpFF3X86buJnYmBoqFNBQajw2nMlu0hMjkAvdX/
         BF0O44Jtzuqg4piCkLtpUrF0zPoGVo77qb/oUF1zvlsEKC0ZfKgxn6cKFKSYkD5O5bnO
         snDTyzp31h9b8rXW1VKhUjl8daUyyInjYiLXZx03u53BAoJYo853x3y6MnoTYmZF1hCq
         Xt75thKp+xXFoeg2sk4WNMdVLb8wFvp6zwcmBBomoHU9EGn4WOpMweC5vmuZGb3m7WBj
         vbi0/TYAWLseon3Fm+fepdY7Y9t5dmqR3pHQ9Dmm+Lig9a31QaxbauOtoO68u4LixQbj
         eWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lIiU6asn3acv1GpmbwGe/AHI5yhvXdxYG1yTmSRTzA=;
        b=Gu/16PDqyQJPbKlu46Zbg2pJqzzAdCkKD3tV5lrSQkS9Rit+m6g1j3/I8PhdjysNMx
         BzFp/XsmgF6z73K+mRhikEMUha38ZpitgTqP0JcRnxcsRMPy8Z/j/JkaA6jCaeK8o82P
         Ait6Y8NJLGJKj5X4Or3kZRlhP6sLS2PbD5Z5mYjELtTKSiLsPCwovCBidj0xm8OGxJCf
         UMfv9xTewA8d8xXu/yl7xN98hqg+HaQA9uCVAOjcAH0It3jxFTgP+m63qqt5p94bQFqj
         xMRuX5cWFMsTaCZitJGnnw4Yo9FBXaBD8s1flliUezv/vdkbxtjMP0N4+AJLT4KtWY+K
         fWBw==
X-Gm-Message-State: AOAM531FwjE5OG3mNYcLh10UyP9QdhIGyXk1/Gae50Frxf1WJF7DGxDb
        UGDa4xd1iU+95FuwwchiEf0rnIV4EvRHGtr2RdN89irlaw==
X-Google-Smtp-Source: ABdhPJyRj+1mtjqA7IOXprxA2h++tNeoKozWoIhSkx+NbOOYmqfGiFIx/Znz3qtfmJTQluzReWHToyepixv4ULxrrv8=
X-Received: by 2002:a17:906:279a:: with SMTP id j26mr1090250ejc.398.1589924459505;
 Tue, 19 May 2020 14:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
 <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
 <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com> <60438e5b407320275932f60bc10936b75c9280aa.camel@btinternet.com>
In-Reply-To: <60438e5b407320275932f60bc10936b75c9280aa.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 May 2020 17:40:48 -0400
Message-ID: <CAHC9VhTgXU=yLncdXHrZkyo23OGc+aLDcNZinqkTLPLiq81Ycw@mail.gmail.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Peter Whittaker <pww@edgekeep.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 9:50 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Sun, 2020-05-17 at 17:59 -0400, Paul Moore wrote:
> > On Sun, May 17, 2020 at 7:17 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > I update the notebook occasionally to keep track of changes for my
> > > own
> > > reference, but currently have no plans to publish a new one. If you
> > > do
> > > have comments I'm happy to take them onboard, however no guarantees
> > > to
> > > publish.
> >
> > I just wanted to say thank you once again for all your work on the
> > notebook, it's a great resource!
> Glad it's useful
>
> >
> > I understand not wanting to go through the process of generating new
> > editions of the notebook, but is the source material posted somewhere
> > online so that people who wanted an updated copy could access it?
> The source is not available anywhere that I know of (I did send it to a
> few people who wanted to translate it but never heard from them again
> !!!). I edit it with LibreOffice Writer as an odt document. It converts
> to pdf okay, but epub looks real crap.
>
> I guess I could post it somewhere, would you like to host it on your
> site ??.
>
> It needs cleaning up as I've scribbled all over it so will take a few
> weeks.

While I'm happy to host it, I think it might be better if we hosted it
in the community GitHub repo - what would you think about creating a
new repo under https://github.com/SELinuxProject?  Perhaps
https://github.com/SELinuxProject/notebook?  While it might seem a bit
odd to host an ODT file in a git repo, it is a good way to keep track
of historical changes and there are other tools such as the issue
tracker and "release" hosting which might be helpful.

However, the last thing I would want to do is put a hurdle between you
and the doc.

Let me know what you think, I'm happy to create a new repo for you on
the SELinuxProject GH org and set you up with the necessary
permissions - assuming the others don't mind, and I can't imagine they
would.

-- 
paul moore
www.paul-moore.com
