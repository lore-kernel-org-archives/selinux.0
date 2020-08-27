Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD7C433E1
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 13:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9449422CB1
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 13:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BnewPwO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgH0Nax (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgH0Nal (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 09:30:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7270C06123B
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:30:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d11so7594121ejt.13
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3bZHQbkUK7ru+mSIlVCeklpmkkabE1NV08rauGz/SA=;
        b=BnewPwO81kBvVFqomm9QXypRQ1vKnYBm3Xuds0ivqXpKN6sew0LIMekfam22SF/fZF
         ucvahfcOXZOCnVhnEJXEHozHM8Yg3MAzKX/Dlc2etkqT9cT67PAgKlx5jSY3w4Vc7UP/
         lA3xGIcK8+LhYi2uldqLp0dH4t2gv5tLikb6a2HDm/dyQxVTBpngvVTgdZd9gKq6Gn/t
         jHoyRFQRNFNA+TseGZYKIsSYd4K/zk+Mn+LvlMRPwmXNo/Xe+A+tge1nVKqRGYohjCRE
         LKfWAuXpyZnKZSiojtR/FVgGa3Qkiof15CDWFMvtTLK1jIgm5Y6A/Pt4nRnHsJ2IHL6u
         /Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3bZHQbkUK7ru+mSIlVCeklpmkkabE1NV08rauGz/SA=;
        b=o7BzGtFtHLXCpY87KwUIzw5VvCQIXy++9dZblBA3cRM2ZpQ+PJbSC+vITW9ipaLU66
         hZPA8BsYJdLUYQJROcT1vpqNjUHiDQcirnocHXFrvuRdKOgc75PQ5O30T+pzhRd0uwux
         mXmYWAi6jmPicMwIa0RtALnolwxe/AOLGBCh2MrTvy0OmlGVz8R1nhMOBmOoJnEc9ITv
         mRptfRMqwQGu/Pym97TrBTlf8rRYzR7Q/buR7gHldvANoxopl5vpjPethTMV5wQMjMHF
         RDYbZcByVsXbTaePONIPNLBAPnCn+XCkwTRlXrbgZ/d+hygHIKOAn8Ir7RUlymC1IcvP
         WrRw==
X-Gm-Message-State: AOAM530l5wMLPZMOTrxtfKYZZT9y/eK3uGPJSNo1O09EBCgQyVr/HX5x
        uF0SXyh03IHBs3rTwMeCN1gVOyg07ogUPF7P13HS
X-Google-Smtp-Source: ABdhPJxjQNf2tUYMG8mTbfyZlnlvWwxh2T296na0R444Fnqj3QwzjsW5Kea1i/+9tcu0OeYYDuxkPOxpkx+bIs7B5pc=
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr20387671ejp.178.1598535017320;
 Thu, 27 Aug 2020 06:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com> <20200824132252.31261-2-peter.enderborg@sony.com>
 <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
 <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com> <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
 <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com>
In-Reply-To: <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 09:30:05 -0400
Message-ID: <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:06 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 8/26/20 4:45 PM, Paul Moore wrote:
> > On Wed, Aug 26, 2020 at 10:34 AM peter enderborg
> > <peter.enderborg@sony.com> wrote:
> >> On 8/26/20 3:42 PM, Paul Moore wrote:
> >>> On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
> >>> <peter.enderborg@sony.com> wrote:
> >>>> This adds tracing of all denies. They are grouped with trace_seq for
> >>>> each audit.
> >>>>
> >>>> A filter can be inserted with a write to it's filter section.
> >>>>
> >>>> echo "permission==\"entrypoint\"" > events/avc/selinux_denied/filter
> >>>>
> >>>> A output will be like:
> >>>>           runcon-1046  [002] .N..   156.351738: selinux_denied:
> >>>>           trace_seq=2 result=-13
> >>>>           scontext=system_u:system_r:cupsd_t:s0-s0:c0.
> >>>>           c1023 tcontext=system_u:object_r:bin_t:s0
> >>>>           tclass=file permission=entrypoint
> >>>>
> >>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >>>> ---
> >>>>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
> >>>>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
> >>>>  2 files changed, 62 insertions(+), 2 deletions(-)
> >>> My most significant comment is that I don't think we want, or need,
> >>> two trace points in the avc_audit_post_callback() function.  Yes, I
> >>> understand they are triggered slightly differently, but from my
> >>> perspective there isn't enough difference between the two tracepoints
> >>> to warrant including both.  However, while the tracepoints may be
> >> We tried that but that was problematic too.
> > My apologies if I was on that thread, but can you remind me why it was
> > a problem?  Why can't we use a single tracepoint to capture the AVC
> > information?
>
> The problem is parsing the event.
>
> https://lkml.org/lkml/2020/8/18/842
>
> https://lkml.org/lkml/2020/8/21/526
>
> and the "single list" version
>
> https://lkml.org/lkml/2020/8/17/1346
>
> With this patch we follow standard message format so no plugin should be needed.

I'm evidently missing something very fundamental (likely), and/or I'm
just not communicating very clearly (also likely), because the above
links don't appear to make any sense with respect to my question.

Let me try a reset ... Why can't we basically take the
"selinux_denied" TRACE_EVENT implementation in your patch and use it
to replace the "selinux_audited" TRACE_EVENT in the selinux/next tree
(of course with the necessary changes to the AVC callback code)?

If the "selinux_denied" implementation is valid from a tracing point
of view, why can we not do this?  Of course if the "selinux_denied"
implementation is not a valid TRACE_EVENT then I'm not sure why this
was suggested for SELinux :)

-- 
paul moore
www.paul-moore.com
