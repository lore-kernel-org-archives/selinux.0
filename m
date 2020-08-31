Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07093C433E2
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C361420866
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Y5Av/eiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHaOYt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgHaOYs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 10:24:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBFC061575
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:24:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so8719445eje.10
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+qhaUqcMvyQWC8w2lqB+uJCSfl87x/m6VAqtEEjpA4=;
        b=Y5Av/eiJZ1lfjPOJvbN1l8iSYxHB9m9djaEEzQtgar8W/KFLz168mdNHb72hkmgW5q
         3FvaURBMk9TKmVyGZbly1Z6ag9eNLTg3VnEmpIzpQuuWKwGL43wrG8MFPRqx0BxlMuxY
         LaXrOJARzoPjVNT7XUPNc/8ryxZ9KiyktdkdKTjTYXCWYBBaQ1JOXD3xpLpnrQUBNBtK
         wH+IhaieaFXEc2XZB1NPkUrrX5u1vRF7gKKWG1iLISscMrGwB4nRBGkWADqwzlXTxSV/
         XSB5qYkjQSoKcFcbjkgsnqfRm/Y+3iBRwP1IteE8U8hDJLQhZ2/L5FgqYQAotB59gDQ8
         ah8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+qhaUqcMvyQWC8w2lqB+uJCSfl87x/m6VAqtEEjpA4=;
        b=Bs2KpUY4dC20YC6hDOZArB9JrfZC7B8Hkrz6N4w6z609x9a6fI1QnFhpDYC0a+8JF+
         l4LHKUo2Bikd9s6ZsMNIpk2jACwnBPHsRWndMakR6QHt/zsd1tJfbaRShwboZNd2Oc5V
         caK+EKRA8POGuDm5nLh6jsfOQIb7ozXsL3CC6b3A3EPAjIUCSx8Ve7E0DtKBgIyE8rpw
         HRykVMajLyiCFCc5kbHIug6jKlLQPaLnPMuUlrGYVdb6yhknkZmPWnYML0wtOnlSzMj4
         MGZ8Jxk220AMy9sYisegrKCoqAARBJ7+wApcPTtOx/XBpwnp6/wV6GAm5NldEtOASGFn
         5/4g==
X-Gm-Message-State: AOAM530c2XtFySrnlzHVFpq8r4sGFam2RYazKklqVYg55giT6RvnVKhU
        cCm68K8sgj4PmUbz2CjLQSkRZsBoU7upZI7gBywm
X-Google-Smtp-Source: ABdhPJwmaZdXJiQhOJ9shsFsM/bqB188NWYcxB0kV+xpOTQkVMqZRzl20A+Tpgp4ecio0jQLsGlshlGclkYbPYCRCMc=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr1365855ejb.91.1598883877872;
 Mon, 31 Aug 2020 07:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com> <20200824132252.31261-2-peter.enderborg@sony.com>
 <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
 <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com> <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
 <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com> <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
 <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com> <CAHC9VhRi87H2GhsKQN9iMOQeSw3g5_qwok9jpx+pfFSouQ9d5w@mail.gmail.com>
 <f0e287f6b7dd4764a5091b90cf31b02e@TECHMB.sfasu.nac>
In-Reply-To: <f0e287f6b7dd4764a5091b90cf31b02e@TECHMB.sfasu.nac>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Aug 2020 10:24:26 -0400
Message-ID: <CAHC9VhTBA3b2ipN08O2yX1uQkaXyFqDXs5DKNmnDFLDtx9=3Ug@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     Robert Judy <rjudy@sfasu.edu>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 31, 2020 at 10:19 AM Robert Judy <rjudy@sfasu.edu> wrote:
>
> I would like to unsubscribe from this group. I have sent "unsubscribe" requests to selinux-owner@vger.kernel.org as subject and in the body of the e-mail but that has not worked. Please advise me how to unsubscribe.
>
> Thank you and respectfully,

When you subscribed to the mailing list you were sent instructions on
how to unsubscribe from the mailing list.

The SELinux developer's mailing list is managed via
majordomo@vger.kernel.org, in order to unsubscribe you need to send an
email to that address with "unsubscribe selinux" in the body of the
email.

> -----Original Message-----
> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On Behalf Of Paul Moore
> Sent: Monday, August 31, 2020 9:16 AM
> To: peter enderborg <peter.enderborg@sony.com>
> Cc: linux-kernel@vger.kernel.org; SElinux list <selinux@vger.kernel.org>; Steven Rostedt <rostedt@goodmis.org>; Stephen Smalley <stephen.smalley.work@gmail.com>
> Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
>
> On Thu, Aug 27, 2020 at 10:04 AM peter enderborg <peter.enderborg@sony.com> wrote:
> >
> > On 8/27/20 3:30 PM, Paul Moore wrote:
> > > On Wed, Aug 26, 2020 at 11:06 AM peter enderborg
> > > <peter.enderborg@sony.com> wrote:
> > >> On 8/26/20 4:45 PM, Paul Moore wrote:
> > >>> On Wed, Aug 26, 2020 at 10:34 AM peter enderborg
> > >>> <peter.enderborg@sony.com> wrote:
> > >>>> On 8/26/20 3:42 PM, Paul Moore wrote:
> > >>>>> On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
> > >>>>> <peter.enderborg@sony.com> wrote:
> > >>>>>> This adds tracing of all denies. They are grouped with
> > >>>>>> trace_seq for each audit.
> > >>>>>>
> > >>>>>> A filter can be inserted with a write to it's filter section.
> > >>>>>>
> > >>>>>> echo "permission==\"entrypoint\"" >
> > >>>>>> events/avc/selinux_denied/filter
> > >>>>>>
> > >>>>>> A output will be like:
> > >>>>>>           runcon-1046  [002] .N..   156.351738: selinux_denied:
> > >>>>>>           trace_seq=2 result=-13
> > >>>>>>           scontext=system_u:system_r:cupsd_t:s0-s0:c0.
> > >>>>>>           c1023 tcontext=system_u:object_r:bin_t:s0
> > >>>>>>           tclass=file permission=entrypoint
> > >>>>>>
> > >>>>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > >>>>>> ---
> > >>>>>>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
> > >>>>>>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
> > >>>>>>  2 files changed, 62 insertions(+), 2 deletions(-)
> > >>>>> My most significant comment is that I don't think we want, or
> > >>>>> need, two trace points in the avc_audit_post_callback()
> > >>>>> function.  Yes, I understand they are triggered slightly
> > >>>>> differently, but from my perspective there isn't enough
> > >>>>> difference between the two tracepoints to warrant including
> > >>>>> both.  However, while the tracepoints may be
> > >>>> We tried that but that was problematic too.
> > >>> My apologies if I was on that thread, but can you remind me why it
> > >>> was a problem?  Why can't we use a single tracepoint to capture
> > >>> the AVC information?
> > >> The problem is parsing the event.
> > >>
> > >> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_
> > >> 2020_8_18_842&d=DwIBaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4c
> > >> c&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=qmi2ROWsLC_0mLLhH
> > >> kpb71j1YoicydLh-7l4cOsLYcY&s=iS3eZr3TFrN5I7BbnvPFYOKd6DfW1FHTFcwI7j
> > >> oS_fk&e=
> > >>
> > >> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_
> > >> 2020_8_21_526&d=DwIBaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4c
> > >> c&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=qmi2ROWsLC_0mLLhH
> > >> kpb71j1YoicydLh-7l4cOsLYcY&s=9OsLN0Y5mUWxEAAqUE6K4PS57Pn1XyZz7GXak6
> > >> uc_Ls&e=
> > >>
> > >> and the "single list" version
> > >>
> > >> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_
> > >> 2020_8_17_1346&d=DwIBaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4
> > >> cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=qmi2ROWsLC_0mLLh
> > >> Hkpb71j1YoicydLh-7l4cOsLYcY&s=tWSY2ry2IT6RcT5BIUwMuqBL_yPObDE1VljbL
> > >> qI1zrA&e=
> > >>
> > >> With this patch we follow standard message format so no plugin should be needed.
> > > I'm evidently missing something very fundamental (likely), and/or
> > > I'm just not communicating very clearly (also likely), because the
> > > above links don't appear to make any sense with respect to my question.
> > >
> > > Let me try a reset ... Why can't we basically take the
> > > "selinux_denied" TRACE_EVENT implementation in your patch and use it
> > > to replace the "selinux_audited" TRACE_EVENT in the selinux/next
> > > tree (of course with the necessary changes to the AVC callback code)?
> > >
> > > If the "selinux_denied" implementation is valid from a tracing point
> > > of view, why can we not do this?  Of course if the "selinux_denied"
> > > implementation is not a valid TRACE_EVENT then I'm not sure why this
> > > was suggested for SELinux :)
> >
> > Im happly fine with replacing the selinux_audited with selinux_denied.  However it is the case where there are more than one denial at the same time. Im not sure how and when it might happen.
>
> One thing I wondered about was why not build up a single string with all of the permissions instead of generating multiple trace events?
> In the previous discussion it was implied that this was due to limitations in the tracing subsystem's filtering, and based on the discussion thus far I'm guessing there is little desire for this information if it can't be filtered on?
>
> If that's the case then I think we are stuck with the tracing code that currently lives in selinux/next, as I currently have little desire to add more than one tracepoint in the SELinux permission checking codepath.
>
> > When that happen we got more than one event. I have no problems with that, but im not sure if the debug tools and perf can make sense of that.
> >
> > A other feature with the selinux_audited event it might be inserted on other places in the code too.  A denial is sort of final.
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
