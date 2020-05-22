Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCEC433DF
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39712070A
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CF+Ys+zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgEVQMt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVQMt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 12:12:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0596C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 09:12:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d24so9617220eds.11
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCwGnMTCWUY7U3Qcg3ePyI3uctqPidc1kIGie1BlMq4=;
        b=CF+Ys+zGgNgSNc+wO9Z/MpPqJq10NdGaCI3CKWVFQbyAiLAcAYBdxGeafxUjNyNYsk
         WI2hXY0FrPGGb86u0GDPyyJ2xjLLh5C3eT9j2S3oxU7GescodLb7KU4xQsxiG+dsl86B
         GBc1nUMsLDntW5bbqOx6HyXVANpKJG6jsYtK+hOsMiM9fZ329AlLD9+5wrzvIOOdbKW/
         qIP63mp3vMzvKEPEC6lDZUe74PrKnR0yR8bW7JixohFKm+PuNALXuPUdfWQknzbnfVC6
         OHeTFZq2NC2OcT3joXxEmQ5E0wSLoHJIu6Q03CBTfQqgmRvy6Sp+ISzBHfqHlHHv508h
         5WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCwGnMTCWUY7U3Qcg3ePyI3uctqPidc1kIGie1BlMq4=;
        b=oapXGruR9F2iG4XTBObSHDR2r0m0LmFTZ1CsY4BOvwN/Kpi7RuV5uoyEdpZvFGD1Ur
         4er1Tl5cLNWxNpkOoOAKjYrfeQ9VmZGe+gu5OKQPEpGTcA15kY2olHoBxBD3s2FTpG1y
         4LkH09RzX8H1en0mnS796cxOZ4Bvj2A8iJqsNzpctgz79f+rx4Cg6VEKP2Ga1G1li8+n
         PXY3JQZDpu/9rcAGE9wLieBWeLJqfqHA0SvffaN3zq7Aiki4ARqLPIvoTAuBbuicRngx
         wcAccxlR/RmmmZANTQ8IwFzVadUuyaG9N5M7+3j52zrV624bS/kKBfRwOEpaMUl6IhDy
         0Q7Q==
X-Gm-Message-State: AOAM530DTdnZndtjJ8ppNaYjsnOxC1ayGZs39nz5LWIqSoFaZvZFNNy5
        tHI7cEt/3r1N9HV6Yr90s0JUIksj6oMtwAgku60IAd4=
X-Google-Smtp-Source: ABdhPJx0jOk9AgJW4FA/MfFI3mr9nXx6ne+MkhjG0imf0VErHkvNETxb8JGbEPj4DLYPVuP5JK1kU6t2erYOU0srxUA=
X-Received: by 2002:aa7:cb8d:: with SMTP id r13mr3534404edt.12.1590163967363;
 Fri, 22 May 2020 09:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
 <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
 <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com>
 <60438e5b407320275932f60bc10936b75c9280aa.camel@btinternet.com>
 <CAHC9VhTgXU=yLncdXHrZkyo23OGc+aLDcNZinqkTLPLiq81Ycw@mail.gmail.com>
 <321f492f19164c43104ec1fd9d699e80ad2a7380.camel@btinternet.com> <CAHC9VhSWPxODxgPC5JPTAvRbA=HVa9QcE1dYm-x4U0-a8F7_PA@mail.gmail.com>
In-Reply-To: <CAHC9VhSWPxODxgPC5JPTAvRbA=HVa9QcE1dYm-x4U0-a8F7_PA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 May 2020 12:12:36 -0400
Message-ID: <CAHC9VhQhDkcR-YKELfE5kf0ebByG30qRKfrGru-sDe8955UABA@mail.gmail.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Peter Whittaker <pww@edgekeep.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 12:10 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, May 21, 2020 at 4:57 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Tue, 2020-05-19 at 17:40 -0400, Paul Moore wrote:
> > > While I'm happy to host it, I think it might be better if we hosted
> > > it
> > > in the community GitHub repo - what would you think about creating a
> > > new repo under https://github.com/SELinuxProject?  Perhaps
> > > https://github.com/SELinuxProject/notebook?  While it might seem a
> > > bit
> > > odd to host an ODT file in a git repo, it is a good way to keep track
> > > of historical changes and there are other tools such as the issue
> > > tracker and "release" hosting which might be helpful.
> >
> > githubs sounds good, however as the document is quite large I'm
> > splitting into sections like on the wiki as it will make easier editing
> > (should anyone feel the need).
>
> That sounds like a good idea.  I imagine it would also help for people
> using it as a reference - something I personally find very helpful.
>
> > I've converted with pandoc using 'markdown_strict', where it converts
> > text to md but most tables into html (as their own md table format will
> > not render in some viewers). With firefox and the Markdown Viewer
> > Webext, the samples I've done look ok.
> >
> > As with all these conversion apps, pandoc leaves a lot of cleaning up
> > to do, so I'll be some time. I'll send you the files once I'm done.
> > Thanks for your support.
>
> Wow, that would be great!  I was thinking just posting the ODT would
> be a nice win, having it in something like Markdown so that GH can
> render it from the web UI would be a *really* nice thing to have!
>
> Once again, thanks for your help on this - documentation, especially
> good and comprehensive documentation - is so hard to find.

I forgot to add: once you have a GH account setup, ping me off-list
and I'll get you setup with write access to a notebook repo in the
SELinuxProject org.

-- 
paul moore
www.paul-moore.com
