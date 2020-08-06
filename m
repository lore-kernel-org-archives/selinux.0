Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC1BC433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8132311A
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYFtD1vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgHFRYE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgHFREp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:04:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B5C0619CF;
        Thu,  6 Aug 2020 06:50:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e11so11993641otk.4;
        Thu, 06 Aug 2020 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SEjQBZlrTFsQloK4tn/llXwept9F2hPUgYtTajnb1LA=;
        b=MYFtD1vgNVKOxnDpEWoSNTcqVqARbDQ4iS+ttYasNnJ2A1Rymefw8vFcH2aHdZ4fye
         GG0GarjIsVRgTSxlorHMu76c0fQH4leeKMyq3Qp+mtVhv05KN0PVzAs/syXyvgvtjpA2
         SXQQJ2fdCSlmi/tWZxKRI1zoZLoa63MUWdHV+S0E1cu9rouZrjPORjmndPu05a/1Kz/+
         dy/CwGAqKZ1WG5gYYfgl86uxvWAORJ5Mx+oxIfngtOVXyH+qzhpRzl5BIW4h+NvzFPCU
         8+xW+Q5DoC8gRPMtzE4pPnwpiMY21vrjrVOuKS/p0YXelP9PTFMnP3Coh3qv116+54n3
         0dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SEjQBZlrTFsQloK4tn/llXwept9F2hPUgYtTajnb1LA=;
        b=Jvqp5xtZLZpZd5N2KzIr4AM0wCrC09IChuLOj06IEvZ00M1Elwc7ds0uN5KlTKZkxt
         Nodv+r8o4vGuHJV2p82xSDySrFUWTL3pPuhT90kkbCfUqn3/kLdd7SgFeKqMGy2NHkZo
         7rPclGILKIBJuXCLliJq8V0E1UTSpXbE4Y+pVfm7ORpKJ8xqkdw+giw0/5LG8nXFJbgy
         ptnfL4MimUnq5SscIgu6huXxi3kp+lCDRWbj19Z1qcbL0ECtSsr8epd+LjU4e6ClBnwb
         GznBWw3H6TZRLL0V6F02hpQpeHVI4M71jUZmnNl7Za38HR3h7hjZ6rgWpdkYxeTLwQhM
         LnFQ==
X-Gm-Message-State: AOAM533JpofGkhaIuR0UjfUTNL6e5pZ1T1iEfBnOrAZAHsxnmNqyUDyB
        ToHyO7jb3qfm3IB6l12whRhvCsT1V2VVdIbaQLU=
X-Google-Smtp-Source: ABdhPJw4ecP6H//vDHHZvBTuxT/QGbR+ZI3XNBXLHzPCazzTrLsqEggBwLft6DcjEwmJkWIfi5p6NHkE5D1PCLV+MYw=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr7420766otn.162.1596721798604;
 Thu, 06 Aug 2020 06:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200806080358.3124505-1-tweek@google.com> <20200806080358.3124505-2-tweek@google.com>
 <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com> <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
 <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com> <07e2c48d-3918-6ceb-a6b2-4e2f18f9ea01@gmail.com>
In-Reply-To: <07e2c48d-3918-6ceb-a6b2-4e2f18f9ea01@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 6 Aug 2020 09:49:47 -0400
Message-ID: <CAEjxPJ4no_GqMp8aw43zpwmwq42Wi_1dvP+ZBs1a-mnReDt5Og@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
To:     peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 9:45 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On 8/6/20 8:32 AM, Stephen Smalley wrote:
>
> > On 8/6/20 8:24 AM, peter enderborg wrote:
> >
> >> On 8/6/20 2:11 PM, Stephen Smalley wrote:
> >>> On 8/6/20 4:03 AM, Thi=C3=A9baud Weksteen wrote:
> >>>
> >>>> From: Peter Enderborg <peter.enderborg@sony.com>
> >>>>
> >>>> Add further attributes to filter the trace events from AVC.
> >>> Please include sample usage and output in the description.
> >>>
> >>>
> >> Im not sure where you want it to be.
> >>
> >> In the commit message or in a Documentation/trace/events-avc.rst ?
> >
> > I was just asking for it in the commit message / patch description.  I
> > don't know what is typical for Documentation/trace.
>
> For example, I just took the patches for a spin, running the
> selinux-testsuite under perf like so:
>
> sudo perf record -e avc:selinux_audited -g make test
>
> and then ran:
>
> sudo perf report -g
>
> and a snippet of sample output included:
>
>       6.40%     6.40%  requested=3D0x800000 denied=3D0x800000
> audited=3D0x800000 result=3D-13 ssid=3D922 tsid=3D922
> scontext=3Dunconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
> tcontext=3Dunconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
> tclass=3Dcapability

So then the question becomes how do you use the above information,
e.g. is that sufficient to correlate it to an actual avc: denied
message, how do you decode the requested/denied/audited fields (or
should the code do that for you and just report the string name(s) of
the permission(s), do you need all three of those fields separately,
is it useful to log the ssid/tsid at all given that you have the
contexts and sids are dynamically assigned, etc.

>              |
>              ---0x495641000028933d
>                 __libc_start_main
>                 |
>                 |--4.60%--__GI___ioctl
>                 |          entry_SYSCALL_64
>                 |          do_syscall_64
>                 |          __x64_sys_ioctl
>                 |          ksys_ioctl
>                 |          binder_ioctl
>                 |          binder_set_nice
>                 |          can_nice
>                 |          capable
>                 |          security_capable
>                 |          cred_has_capability.isra.0
>                 |          slow_avc_audit
>                 |          common_lsm_audit
>                 |          avc_audit_post_callback
>                 |          avc_audit_post_callback
