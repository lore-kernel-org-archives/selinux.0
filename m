Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9974BC433DF
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571C92070A
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 16:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QGJvmDML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgEVQKn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgEVQKm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 12:10:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051F7C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 09:10:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so13619273ejd.8
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9c1SoynSc571s6g5FqpcXv5A62c5UDAYe/dfm3uHXk=;
        b=QGJvmDML5jZUBaOFCiF9J6EUIPSJ4USqY5U0qBOPeJRy6hbimL9KQgwPEwsXYQEpW+
         tLJxJ64B6hUtOB5SWtq3ILu5+EFs3NsjqDmXDyQe+uJEVaR2gns/w77VkibR+w8aD1HZ
         fQS2VjZnxM+k0lU6ZF6h/V5sELh7mRIlb5i9YKGwQz1OxGhwF7taOa7mFpah0ZY8bjMr
         y92tcRVTbNj7h7chruoNMgD1JldpoNNkAFs77J5w//T2q5u2em2LlT89/YUuDwKHb1n+
         LNBrZt6BdPWCO72ITiOch6O89NZLOYzyPS2AQuxVE71axsuAnfE2ZMwb2Exst5zwsATP
         wBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9c1SoynSc571s6g5FqpcXv5A62c5UDAYe/dfm3uHXk=;
        b=kvgeOj/qtUE0Rfh0HTrZ6zhEWyoCkE5Ms2XP9fAKmsTO+9Ycw+zRY6f31eapLs/aai
         cwW3bULYIoKjCtHIx6X84dwZHUa4C/terYf/mG6xz4DWyFlO7tYsCbXYtzj5vIX+NSQ9
         qR38ZxRTmkxB5ZfgWJSYU0sRtUuvHQEe9dr4HIpUyqIMijORl4f78p3Hni/1PoIcb8Br
         PT5Dg737APrIYOOkzvvhZE5Mg+DirM42JM61JFSbmNEz6HspumfPPlT4SOU77G3snori
         DhxGrYTt4s3bzixmouEkvh+FUcnjPTrCrRJkFUOR1mvPqEcqa5Lpwxz6/oX2WdF/kGFT
         HK7g==
X-Gm-Message-State: AOAM532+epWP8SeBf7bEgFoC5zLrL5WfRrfHLC1WOLRyOq/f7Xi2jrzz
        iaBd56oNsDhLwFbU6TxKzATJVqkBlUldinbQXCA7uM4=
X-Google-Smtp-Source: ABdhPJzSW1XRyLhl4eHpiI4YnMh8KPZcxVUJmROcpWNl95yzemRPnSnt/ofZw3OIe6DWXfITP4BkIybgqmMXMkpibpI=
X-Received: by 2002:a17:906:279a:: with SMTP id j26mr8391756ejc.398.1590163840581;
 Fri, 22 May 2020 09:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
 <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
 <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com>
 <60438e5b407320275932f60bc10936b75c9280aa.camel@btinternet.com>
 <CAHC9VhTgXU=yLncdXHrZkyo23OGc+aLDcNZinqkTLPLiq81Ycw@mail.gmail.com> <321f492f19164c43104ec1fd9d699e80ad2a7380.camel@btinternet.com>
In-Reply-To: <321f492f19164c43104ec1fd9d699e80ad2a7380.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 May 2020 12:10:29 -0400
Message-ID: <CAHC9VhSWPxODxgPC5JPTAvRbA=HVa9QcE1dYm-x4U0-a8F7_PA@mail.gmail.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Peter Whittaker <pww@edgekeep.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 4:57 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2020-05-19 at 17:40 -0400, Paul Moore wrote:
> > While I'm happy to host it, I think it might be better if we hosted
> > it
> > in the community GitHub repo - what would you think about creating a
> > new repo under https://github.com/SELinuxProject?  Perhaps
> > https://github.com/SELinuxProject/notebook?  While it might seem a
> > bit
> > odd to host an ODT file in a git repo, it is a good way to keep track
> > of historical changes and there are other tools such as the issue
> > tracker and "release" hosting which might be helpful.
>
> githubs sounds good, however as the document is quite large I'm
> splitting into sections like on the wiki as it will make easier editing
> (should anyone feel the need).

That sounds like a good idea.  I imagine it would also help for people
using it as a reference - something I personally find very helpful.

> I've converted with pandoc using 'markdown_strict', where it converts
> text to md but most tables into html (as their own md table format will
> not render in some viewers). With firefox and the Markdown Viewer
> Webext, the samples I've done look ok.
>
> As with all these conversion apps, pandoc leaves a lot of cleaning up
> to do, so I'll be some time. I'll send you the files once I'm done.
> Thanks for your support.

Wow, that would be great!  I was thinking just posting the ODT would
be a nice win, having it in something like Markdown so that GH can
render it from the web UI would be a *really* nice thing to have!

Once again, thanks for your help on this - documentation, especially
good and comprehensive documentation - is so hard to find.

-- 
paul moore
www.paul-moore.com
