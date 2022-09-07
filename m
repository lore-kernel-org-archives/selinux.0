Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729A4C6FA89
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 14:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGOmG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiIGOls (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 10:41:48 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FEC98A51
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 07:41:40 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127dca21a7dso9231027fac.12
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gkQMJ8PpL3bdaXL4hQbTakGxMZ3irutuC6f8J4clHwM=;
        b=CwJI8JkaMDZ+pv8bfiBZlkaW3kgxT2MvJNdG5hl9yuodJQTEhTAG9K7iJk04fsLnUv
         Bf2wuk99AajBAy/++6HqNtkxs3ySZmM9rZPTMnltoeU1DnBva2CoVKsWtrxCEurDLt7d
         ISvcThfoVsGTk+K4baDUL0r7UTrl3rOm3EzcFKFwMypysOzMouFbwDhNnRFmMS5Hv+yA
         OT+S8tiVPzyXEuGIDCYbm6fjuvfSNaTNKwpD3KKHxRmPMd1U2SLFDeehwyhbWBdKYq9h
         ySBX1e7b0Wpc1dt//tlK0NUT+SmKVLsH2lH1Co40HSPF4RAUuCc1hJMiW5YtzKCse1n5
         Ov4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gkQMJ8PpL3bdaXL4hQbTakGxMZ3irutuC6f8J4clHwM=;
        b=AUj5VpLqUlfJghkk2GT9jEGAGejWlPU4bYkLCirXGs+1eogTHodWYqYH31sJQYUGqL
         NWgkPTNtdceBhHLaoDIQNpczbfanxa2u1jM04C9zuGNJEf4f8+p89zBUBBybVAx8fNFM
         dbA7TLqivmtG2XBW5i+9UGhQxwVnZUGEXbOb3r+5aDfu30G8XU6NLWhWd+C9OcTQFnPO
         dkqg/7ZIhimHYzze05pNLYe2xFucL1Po3LgMSHKi9zu7UA5xONiUG5E/D+o+KmxG50Be
         fMB9pCoySDnVjiMdNBxpc8cutNiOaUQevMwOinTwEsALJHQX8nHEbcCfguWaWo1fWeuR
         bldw==
X-Gm-Message-State: ACgBeo3t99cWOmU+gNrjiWFShJd3tja4w2u3YYHkuCFolGhpN39PEE1O
        yN1JX4maGqw18o5HrBRthiys1J26p2ne3uHSwcUh
X-Google-Smtp-Source: AA6agR4Jpa6RI1QnnKQQu3JU8uYTO3MJ6XUs2GuQ/6wUp/wH1MZQX+hglvCqhjrv5lLDCsXVa80JBONNoLk4UuQM8BE=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr12443039oie.41.1662561699253; Wed, 07
 Sep 2022 07:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
In-Reply-To: <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 10:41:28 -0400
Message-ID: <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 6, 2022 at 8:10 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 9/6/22 16:24, Paul Moore wrote:
> > On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/2/2022 2:30 PM, Paul Moore wrote:
> >>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

...

> > If you are running AppArmor on the host system and SELinux in a
> > container you are likely going to have some *very* bizarre behavior as
> > the SELinux policy you load in the container will apply to the entire
> > system, including processes which started *before* the SELinux policy
> > was loaded.  While I understand the point you are trying to make, I
> > don't believe the example you chose is going to work without a lot of
> > other changes.
>
> correct but the reverse does work ...

Sure, that doesn't surprise me, but that isn't the example Casey brought up.

> >>> I think it's time to think about a proper set of LSM syscalls.
> >>
> >> At the very least we need a liblsm that preforms a number of useful
> >> functions, like identifying what security modules are available,
> >> validating "contexts", fetching "contexts" from files and processes
> >> and that sort of thing. Whether it is built on syscalls or /proc and
> >> getxattr() is a matter of debate and taste.
> >
> > Why is it a forgone conclusion that a library would be necessary for
> > basic operations?  If the kernel/userspace API is sane to begin with
> > we could probably either significantly reduce or eliminate the need
> > for additional libraries.  I really want us to attempt to come up with
> > a decent kernel/userspace API to begin with as opposed to using the
> > excuse of a userspace library to hide API sins that never should have
> > been committed.
>
> I don't think its a foregone conclusion, its just that it has been
> discussed several times, and all the interfaces have been nasty and
> prebaked userspace code would be really nice to have.
>
> There are other reasons to use a lib as well. Libs can help apps
> pickup fixes/changes automatically.

Fair point.

> > The LSM stacking work presents us with a unique opportunity to
> > modify/update/whatever the LSM kernel/userspace API, I don't want to
> > see us squander this chance on a hack.
>
> I do wish we had a better API from the beginning. I just hope it isn't
> going to take another 10 years to get the API portion done.

This really should surprise no one at this point, but I care very
little about how long something might take, or how difficult it might
be if it is something we are going to have to live with
<dramatic_voice>forever</dramatic_voice>.  I'm sympathetic that this
work has been going on for some time, but that is no reason to push
through a bad design; look at the ACKs/reviews on the combined-label
patches vs the others in the series, that's a pretty good indication
that no one is really excited about that design.

> >> The /proc interfaces interface_lsm and context are really pretty simple.
>
> > They are now, they are also a bit of a mess with legacy constraints
> > and they only get more complicated and messy with the LSM stacking
> > patches.  It is my opinion that a syscall-based API is cleaner and
> > easier for applications to use.
>
> potentially if we can get one

Let me try and remove some ambiguity from that - I'm not going to
merge any combined-label APIs.  I'm not sold on the syscall-based API,
I'm open to other ideas, but it needs to support distinct per-LSM
labels that allow applications to identify which LSMs are active and
which labels belong to each.  In addition, I do not want any changes
to the existing procfs APIs as I want there to be zero chance we will
break existing applications; if existing applications need to be made
aware of a simul-multi-LSM world then they would need to change to the
new API, whatever that may be.

> >>> Further, I think we can add the new syscall API separately from the
> >>> LSM stacking changes as they do have standalone value.
>
> what I think Paul is saying is we can move the LSM stacking patches
> forward by removing the combined label interface. They won't be as
> useful but it would be a huge step forward, and the next step could
> be the syscall API.

Whatever new LSM API we decide on, I want to see that developed and
merged first.  It obviously must be designed to support multiple,
simultaneously active LSMs.

-- 
paul-moore.com
