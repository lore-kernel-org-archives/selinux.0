Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76999C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80F62311A
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7q0pe2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgHFQ6p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgHFQkm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 12:40:42 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA91C0A8935;
        Thu,  6 Aug 2020 08:03:42 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 25so19562700oir.0;
        Thu, 06 Aug 2020 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QmBAkio3HqZXyLXzZvG0W5rZ+32Ncd4SFfX8CWNZXqo=;
        b=d7q0pe2LphFy3tVHJjI9V+nKk9i6A77hOJYbtyZtPx11pAdOqRtnIZWNEhzbbqzITV
         fOGz1xnFeeELtvrdZcDd6hthIcK7MLUCtyEHTZlMCfM1xtVnAcjSnMvni+uiQBmQZHEI
         4n7BWzq7sIB0IcNUmHT7PVfYhJ8YCQtnxsXcfAkwfIuDQD3/1GT2qkte991aPf1MBM+u
         FdRNdytGVqkdnuz9kOyLpjDy/DFsQybVNgEvQJxMOvArmDM2OX9jIenU5ivx9flJWXsU
         TZfMRFrskK+ByYnY7BCrrYXTPdLHYgpOf53HpqdRzlm+iWA+IPPk8iqsvnBB/LOO8sHJ
         Xh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QmBAkio3HqZXyLXzZvG0W5rZ+32Ncd4SFfX8CWNZXqo=;
        b=aUrxjRq0F8TfbSyBpopV/bCPgkJSJ32182S+hbM4ntnW2gw9Gbp52zriybz5NYBoGt
         tuvbYLKdqCU+AfcdVz0o11mxbGd31/9TLtQJaaHtKt+pfEWVGm4AbWcKuKoXjeYASuTt
         QY38JCd5/BV/Wv94hAeRgviQsbMrYMs0gZKJvItrCHaFJjGK5VuPlgDyR6M31stCR66d
         ln0OEMlkMRcF8bgg/LSLmT2+MpBRzVcCn2hXYvKf3Y49KN4+FDpWHnnApk/cVWqg0MOJ
         w2EeFz3LXcZCeQQ09vAni8FUcC2pxkpP6cXgsub/Jsv/E1y/vCnue+xS3y+zezYzgChe
         jMqA==
X-Gm-Message-State: AOAM531OgAqA54gJ3mCofbJgV2TLirunqkaR6r4OGeogXuYARuGCwMcX
        k/n2pcht7faP3gGRvKNrR4IiyUfq9vlmzUrXHTA=
X-Google-Smtp-Source: ABdhPJw/dtcEyn/5MkeX+6B9hKzdwerGRcmnrQpewRREzYTtjCtgDu/mN4S+X6UK9uqoV0cCtIuaDaCeVFm7gfjYDIw=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr7145834oic.92.1596726216077;
 Thu, 06 Aug 2020 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200806080358.3124505-1-tweek@google.com> <20200806080358.3124505-2-tweek@google.com>
 <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com> <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
 <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com> <07e2c48d-3918-6ceb-a6b2-4e2f18f9ea01@gmail.com>
 <CAEjxPJ4no_GqMp8aw43zpwmwq42Wi_1dvP+ZBs1a-mnReDt5Og@mail.gmail.com> <dfeac808-b40d-77fd-0d31-f66f279083eb@sony.com>
In-Reply-To: <dfeac808-b40d-77fd-0d31-f66f279083eb@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 6 Aug 2020 11:03:25 -0400
Message-ID: <CAEjxPJ4EaXJ88-hT=jgfn0d1WVP9QQb0w2XQi7U2YVuqN2oMsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
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

On Thu, Aug 6, 2020 at 10:51 AM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 8/6/20 3:49 PM, Stephen Smalley wrote:
> > On Thu, Aug 6, 2020 at 9:45 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On 8/6/20 8:32 AM, Stephen Smalley wrote:
> >>
> >>> On 8/6/20 8:24 AM, peter enderborg wrote:
> >>>
> >>>> On 8/6/20 2:11 PM, Stephen Smalley wrote:
> >>>>> On 8/6/20 4:03 AM, Thi=C3=A9baud Weksteen wrote:
> >>>>>
> >>>>>> From: Peter Enderborg <peter.enderborg@sony.com>
> >>>>>>
> >>>>>> Add further attributes to filter the trace events from AVC.
> >>>>> Please include sample usage and output in the description.
> >>>>>
> >>>>>
> >>>> Im not sure where you want it to be.
> >>>>
> >>>> In the commit message or in a Documentation/trace/events-avc.rst ?
> >>> I was just asking for it in the commit message / patch description.  =
I
> >>> don't know what is typical for Documentation/trace.
> >> For example, I just took the patches for a spin, running the
> >> selinux-testsuite under perf like so:
> >>
> >> sudo perf record -e avc:selinux_audited -g make test
> >>
> >> and then ran:
> >>
> >> sudo perf report -g
> >>
> >> and a snippet of sample output included:
> >>
> >>       6.40%     6.40%  requested=3D0x800000 denied=3D0x800000
> >> audited=3D0x800000 result=3D-13 ssid=3D922 tsid=3D922
> >> scontext=3Dunconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
> >> tcontext=3Dunconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
> >> tclass=3Dcapability
> > So then the question becomes how do you use the above information,
> > e.g. is that sufficient to correlate it to an actual avc: denied
> > message, how do you decode the requested/denied/audited fields (or
> > should the code do that for you and just report the string name(s) of
> > the permission(s), do you need all three of those fields separately,
> > is it useful to log the ssid/tsid at all given that you have the
> > contexts and sids are dynamically assigned, etc.
> >
> >>              |
> >>              ---0x495641000028933d
> >>                 __libc_start_main
> >>                 |
> >>                 |--4.60%--__GI___ioctl
> >>                 |          entry_SYSCALL_64
> >>                 |          do_syscall_64
> >>                 |          __x64_sys_ioctl
> >>                 |          ksys_ioctl
> >>                 |          binder_ioctl
> >>                 |          binder_set_nice
> >>                 |          can_nice
> >>                 |          capable
> >>                 |          security_capable
> >>                 |          cred_has_capability.isra.0
> >>                 |          slow_avc_audit
> >>                 |          common_lsm_audit
> >>                 |          avc_audit_post_callback
> >>                 |          avc_audit_post_callback
>
> The real cool thing happen when you enable "user-stack-trace" too.
>
>            <...>-4820  [007] .... 85878.897553: selinux_audited: requeste=
d=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000 result=3D-13 ssid=3D34=
1 tsid=3D61 scontext=3Dsystem_u:system_r:ntpd_t:s0 tcontext=3Dsystem_u:obje=
ct_r:bin_t:s0 tclass=3Dfile
>            <...>-4820  [007] .... 85878.897572: <user stack trace>
>  =3D>  <00007f07d99bb45b>
>  =3D>  <0000555ecd89ca57>
>
> The fields are useful for filter what you what to see and what you can ig=
nore.  Having the ssid and text was from the part where it is called.
> The numeric can be used for two things. When you dont have any context. S=
ame same reason as in post_callback. We need to be static
> in format so it need  be there if it ever can happen. And it is also usef=
ul for faster filtering.
>
> You can do "ssid!=3D42 && ssid!=3D43 && tsid=3D=3D666".  From my view it =
would be good to have all fields there. But they need to right typed to be =
able
> to use the filter mechanism. There must me some trade-off too where the a=
rgument filtering get bigger than the processing, but I think we can
> add a lot more before we reach that threshold.

I don't think the SIDs are useful because they are dynamically
assigned (aside from the initial SIDs for bootstrapping before policy
load) and are not exported to userspace (userspace has no way to look
them up).  It is probably a mistake that we even fall back to logging
them in the existing code and may just be a legacy of when SIDs were
exported to userspace (ancient history, before mainline merge of
SELinux).

In any event, if you were to include the sample usage and output I
provided as part of the commit message / patch description (or replace
with your own example), that would be helpful I think.  Even better
would be to also provide some hint as to how people are expected to
decode the requested/denied/audited fields (I know how to do that but
not everyone will, and ideally one would have a script or something
for doing so).
