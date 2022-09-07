Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF18ECAAD3
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIGX1R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIGX1O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 19:27:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022091093
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 16:27:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1278a61bd57so21386249fac.7
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y8pV7akYJnD8K0DTdxFamOwHfz5v4zZZrsq9l57b/+0=;
        b=XL9/A11Yx/n1BmhFVKAMhQE5J/pJB5tzQDqLd5Go+VH+8WYOBKfDMS9r7QWGqNGoSI
         vcDGjuuzz6kK1iVm6autGmGaBJnYOFQ33iDNNZeroY4kqwkxJQWs9DCr71xhmyegm3RD
         nT2dmgTohmmNLPHaQnfziDO0nqX28ijJhX7xe78g2fOiIXAMJD7yVY21F37NnMRG7C+E
         YkSA2IvrMsADY+WxojAMP1EsJOefU6L7UMS4wbvkSirP9Se8+2DFfv4zBJFUktPCDb9g
         +IpD8cy2JJn62zmmL71eURfy0zJ/JkMtECgfkPwtOb5pqazfz0wOezI05jbm9HY7CRai
         M1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y8pV7akYJnD8K0DTdxFamOwHfz5v4zZZrsq9l57b/+0=;
        b=8C+eW6SXlpOMTccGbnDDEBSZBGYovquTz3ZlRL6OhAk3oKy358tBPeJgcOsAsZcLnd
         iB5RNm+s6OuRnKdUAUDbC9BlPJUjY9F1+4Yc8PWTEXr7mUV0IJlvbKXjOjRPA1NxyGt9
         uri6Aoueti5g+dxos21wIxZO0fB5Dy56nqAlDWAWzCQJzdXNAznqUS+eFpzgmm0EXOnl
         RwGb1IPPtGo+YpumSzIKqGNTc0dhaaAr++Eicha4YjgLaDlM8LEXlEJzXoLh9mUM/kLG
         KuX2LUzdKCG5LoubcHOCmYdEb8PjQMsZe+hPr1VYIRGVI+1g5kMXYMxYyjbpFd8bLfT+
         y6Rw==
X-Gm-Message-State: ACgBeo09ybMyErbwc7JlOoUPkATAwE4040r5B76h6CX0YBdP5x9729SE
        UpOaAORVKZf8+QqUB16kKEmAql7scXM79hHg3yiY
X-Google-Smtp-Source: AA6agR6PobH+8GbO0sLljWuQrQbOCAbcCGdciKOTuq4YM86PWdsp0rSBF/mzuZjY1O45ChIGTIWubjWmdUtZiJ4oDWI=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr444587oap.136.1662593232851; Wed, 07 Sep
 2022 16:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
In-Reply-To: <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 19:27:01 -0400
Message-ID: <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 12:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/7/2022 7:41 AM, Paul Moore wrote:
> > On Tue, Sep 6, 2022 at 8:10 PM John Johansen
> > <john.johansen@canonical.com> wrote:
> >> On 9/6/22 16:24, Paul Moore wrote:
> >>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
> >>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > ..
> >
> >>> If you are running AppArmor on the host system and SELinux in a
> >>> container you are likely going to have some *very* bizarre behavior as
> >>> the SELinux policy you load in the container will apply to the entire
> >>> system, including processes which started *before* the SELinux policy
> >>> was loaded.  While I understand the point you are trying to make, I
> >>> don't believe the example you chose is going to work without a lot of
> >>> other changes.
> >> correct but the reverse does work ...
> > Sure, that doesn't surprise me, but that isn't the example Casey brought up.
>
> I said that I'm not sure how they go about doing Android on Ubuntu.
> I brought it up because I've seen it.

Addressed in the other portion of this thread, but the quick response
here is: No, you were mistaken, that was not proper Android, SELinux
was disabled.

> > I'm sympathetic that this
> > work has been going on for some time, but that is no reason to push
> > through a bad design; look at the ACKs/reviews on the combined-label
> > patches vs the others in the series, that's a pretty good indication
> > that no one is really excited about that design.
>
> The kernel developers aren't the consumers of these APIs. There
> has been considerable feedback from system application developers
> on the interfaces. This included dbus and systemd. Kernel developers
> aren't interested in these APIs because they don't care one way or
> the other. That, and as you are painfully aware, some of them are
> really busy on their own projects.

Yes, everyone is busy yet they found time to ACK/review the other
patches in the patchset.  I'm not buying the "busy" argument here.

Yes, you are also correct in that the kernel devs are not likely to be
the main consumers of any kernel/userspace API, but we do have to
support these APIs and find ways to handle the inevitable misuse and
abuse of these APIs.  Further, while I do believe that you've talked
to some application developers about the current proposed API, I'm
reasonably confident that it isn't the only API they would be happy
supporting in their applications.

As far as kernel developers not being interested in these APIs, I
think the recent conversation in this thread proves the exact opposite
;)

> Am I really happy with the "hideous" format? Yeah, because it makes
> the end user happy. Am I happy with interface_lsm? Other than the
> name, which was the result of feedback, yes, because it in the
> simplest way to accomplish the goal.
>
> I am curious about what you think is "bad" about the current design.
> The interfaces aren't exciting. They don't need to be.

I don't even know what an exciting interface would look like ... ?  I
just want an interface that is clearly defined, has reasonable
capacity to be extended in the future as needed, and is easy(ish) to
use and support over extended periods of time (both from a kernel and
userspace perspective).

The "smack_label\0apparmor_label\0selinux_label\0future_lsm_label\0"
string interface is none of these things.  It is not clearly defined
as it requires other interfaces to associate the labels with the
correct LSMs.  It has no provision for extension beyond adding a new
LSM.  The ease-of-use quality is a bit subjective, but it does need
another interface to use properly and it requires string parsing which
history has shown to be an issue time and time again (although it is
relatively simple here).

Once again, the syscall example I tossed out was a quick strawman, but
it had clearly separated and defined labels conveyed in data
structures that didn't require string parsing to find the label
associated with an LSM.  It was also self-contained in that no other
interface was needed to interpret the results of the syscall (well,
beyond the header file definitions I guess).  Finally, it made use of
flags and "reserved for future use" token values to allow for
additional data to be conveyed in the future.

-- 
paul-moore.com
