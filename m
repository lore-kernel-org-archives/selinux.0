Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A40C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 02:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C7622CF7
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 02:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xkKdSxZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHGCXM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgHGCXL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 22:23:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC89C061575
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 19:23:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so427602ejb.11
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgzNrADqzmOr0n80iYHzzjjMlgmpS1/Gs1L13/e0S0M=;
        b=xkKdSxZ/YeWppyWC41wNCev1Hlc6V2GbZYCKi04KJcQA2xlABK3jHBb55CII9kdLkB
         lwF1l3xjePmejor8JDViPAKMSYmfJMazdFURokNdeblwnOFelt6FAryAvZJTOK7Q2Q+i
         ikXRvpcROlw8/3BPTvfNY5bxBxFFKitUKLwSaO/T+JWGgWRMPTDdN05VVUKwWwNAs2yt
         1Ai2iIjmlYVGcqW+qIQJmPNFXQCdUkkkg9yLsCXbpu5pmTHrpT9tK7B6Yx/ePXOKdzr2
         9w9o0QIyPj/0KBojAGRrVEdVdSeDo5sJRbJlQg8JOiZUUeOQJTK0TDXDx+S4PSbT3tpS
         sYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgzNrADqzmOr0n80iYHzzjjMlgmpS1/Gs1L13/e0S0M=;
        b=jbPXzQjbl2DiqQA4STQNq5nTsz4QTgqBqEeqHvPLEWMQblUpbNZ3ip8drnwouGI2KD
         fzD7WKtC8DhPXNQ+7wzlVGRnuBtwv/C7i3Acbm6F6S/Vprutw2UJHwxYxzoPKJV3qL1Z
         TNvTHG1qyfmLjxUcnIlIUCBGXViO6mNM7Vm0W85AtSq3EBQfICCiBpW3Mf9n/AOKdptB
         jymRQsjthBXdkHgZim5/RQ+QmG/6KqpNWDk6y/ZD4eU+2Go2qGnBcjs6fc+BOqtIWMPg
         CfhXmt9Pgme7JmmZwBvdyzBI7dOQ+7DzqFz+WOzsPhlAtKcjHFXP0QrcZcEvdAUN6o7N
         s/Vw==
X-Gm-Message-State: AOAM530Z0y5dR8MEXijmnVbrDpB4nvF3Doy59xPTQVdfQqZYg2Gjr8DF
        0Rp2m43jvt/7b3sIUb9IyfSgguzwzIB/njpLflbG
X-Google-Smtp-Source: ABdhPJxYMiDo8RtvN3CXEECww50UvDjUBbfOPaqI3Inev+STXp5CcSBgW3wJZjTdxBDyskuyHGC2ibHVKOcefgjLOOI=
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr7106172ejo.178.1596766988566;
 Thu, 06 Aug 2020 19:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200806080358.3124505-1-tweek@google.com> <20200806080358.3124505-2-tweek@google.com>
 <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com> <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
 <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com> <20200806123748.2285944b@oasis.local.home>
In-Reply-To: <20200806123748.2285944b@oasis.local.home>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 22:22:57 -0400
Message-ID: <CAHC9VhQ5AK_16EeCLqDJO3iCscMMKWYqVZbbj-MtpXfqoEpc5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 12:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 6 Aug 2020 08:32:38 -0400
> Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> > >
> > > In the commit message or in a Documentation/trace/events-avc.rst ?
> >
> > I was just asking for it in the commit message / patch description.  I
> > don't know what is typical for Documentation/trace.
>
> No, the Documentation/trace is for generic tracing documentation. Not
> for individual events.

As I've said many times in the past, I've never rejected a patch
because the patch description was too verbose, but I have rejected
patches where the description hasn't provided enough useful
information.

I would really like to see the commit description show an example
where you setup/load/etc. the event into the kernel, trigger and
capture the event information, and then show how the event output can
be parsed/processed into something meaningful by a user.  I'm
essentially looking for a "hello world" version of the SELinux
tracepoint, does that make sense?

-- 
paul moore
www.paul-moore.com
