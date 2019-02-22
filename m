Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E627C4360F
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1522070D
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 12:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfBVMww (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:52:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46175 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfBVMww (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 07:52:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id c18so1707138otl.13
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 04:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZnNMftqiPAsuB1GyGpVHOn6leIPquiVq0JQBzM6kzU=;
        b=Lp2TPiDGLh5ErBMj4hwUvWfpxCFdbOuR/0f4rM/sgkOFhLODLwNRyfNwsfm+q+SUnf
         ZuGB0hRAg3JHISjlDVEQ03hl+46jX+TfUiODmeokdFAJ4ixy/5th4vVu3Ju+vhwkYpjS
         qEfB8c/J7NiM+KycKSkDNTSYdvZ0KUSU3vwr/HBxAKWTGrFPRpsbHvPxL6Ua7GhG8s99
         LC2RZadpA0pcYmn6LgKS1PFFz79HxTlt2O/z/bJGWPmLUr4NEMRZNW5NR2YMFVxBqkO+
         yUg1l4CSKNw8XluGMa/oG35CZ/DLEpnncqmSSXq1ixYJSTaYuagOoGMJiJEJPd7/gpDi
         m7IQ==
X-Gm-Message-State: AHQUAuZPQ3UGUmcWy/sRTJ6XJKqDX65mzy7YV2+ix5VM6b9iceelR/va
        HG+rstCb7DdRY6CeVDQMyYf2A81lQBehxMmaw0mZsw==
X-Google-Smtp-Source: AHgI3IZh+MhFZKokXhwn79qjP3+xjyhEnAcRDw1vqkDlDOAlxT6HqJippTVBHvuvT25WvxLViy7eLgl0bBMnZmgNUh0=
X-Received: by 2002:a9d:5889:: with SMTP id x9mr2474553otg.109.1550839971104;
 Fri, 22 Feb 2019 04:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190214095015.16032-1-omosnace@redhat.com> <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com> <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com> <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
 <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com> <CAFqZXNtJFrtAqnu=CmoSPnPM312DKF73ALkLeekMk8Me5ojntw@mail.gmail.com>
 <0942b8c9-79a3-47a9-a28d-276d322fd9e1@schaufler-ca.com> <CAFqZXNvWyBQ5g6nwD4AiePxEDXGP2DY31S0RWttqcRSa90SakA@mail.gmail.com>
 <2de9569d-2368-1dc9-f757-0a7a0a116c16@schaufler-ca.com>
In-Reply-To: <2de9569d-2368-1dc9-f757-0a7a0a116c16@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Feb 2019 13:52:39 +0100
Message-ID: <CAFqZXNutDB+3xsPOU-8H-D7bHMvACLXy16PKiKRfR6wWw93A8Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tejun Heo <tj@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 21, 2019 at 5:52 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/21/2019 1:13 AM, Ondrej Mosnacek wrote:
> > On Tue, Feb 19, 2019 at 5:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > .....
> >> The state you're maintaining is kernfs state, not LSM
> >> infrastructure state. The state should be maintained in
> >> kernfs, not in the LSM infrastructure.
> > But I'm not maintaining any state. I'm merely trying to answer the
> > query "Is there anything that will handle this hook? Do I need to
> > prepare stuff for it?", which is obviously a query about the LSM
> > state. Granted, ideally we wouldn't need to do any preparatory work at
> > all, but that would require exposing more of the kernfs internals
> > (which brings its own issues, but maybe I'll need to look into that
> > approach more...).
>
> It sounds like you're bumping up against the limitations
> of the finely honed optimized implementation of kernfs. :(
> If it where still the pre-android era, when using an LSM
> was rare, the check for an LSM might have made sense. Today,
> with the vast majority of systems using LSMs*, optimizing for
> the no LSM case is nonsensical.

I imagine it might make sense on some very minimal embedded systems
(microcontrollers?), where you almost certainly need kernfs (via sysfs
or debugfs), but you don't necessarily need advanced security controls
(you might just have a single monolithic userspace process running
there and very limited memory/CPU resources). I'm hardly an expert on
embedded platforms, but it sounds like a reasonable use case.
(Although in such cases I'd expect CONFIG_SECURITY to be simply set to
'n', so no need for runtime checks anyway...).

>
> ---
> * Android, Tizen, Fedora/RHEL, Ubuntu
>
> > ...
> > Kernfs is an important component of the kernel. So is
> > the security infrastructure. I would hope you don't want
> > to turn this into a contest to see which maintainer has
> > the biggest clout.
> > Oh, no, you misunderstood my intention. I just got a feeling that this
> > thread was turning into a discussion about perceived code ugliness
> > (and about which subsystem that ugliness ends up in), which is
> > naturally a very subjective topic, so I wanted to know what is the
> > opinion of the people that have the final decision about whether the
> > code should get in or not. Anyway, I'll try to find a more elegant
> > variant of the solution once again, hopefully I manage to get to
> > something less controversial.
>
> Thank you. I believe (which, of course, doesn't make it true)
> that when a component goes outside the general system architecture
> the way that kernfs does *even for performance reasons* that it is
> responsible for the edge cases it encounters. I know that I've had
> to do a good bit of that in Smack.

OK, so I tried taking the other approach (pass kernfs nodes and expose
necessary kernfs internals) and I'm quite happy with the result. It
turns out the only thing I actually need to expose (at least for
SELinux) is getting and setting the security xattrs, which is just two
simple functions. The rest of the attributes (uid, gid, and access
times) don't seem important and they can always be exposed by adding
more helper functions as needed. With this design the last patch now
becomes embarrassingly simple - there is just a single call that will
either call an LSM hook or do nothing at all.

I still need to do some testing on the new patches before posting. In
the meantime they are available here for the curious:

https://gitlab.com/omos/linux-public/compare/selinux-next...selinux-fix-cgroupfs-v12

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
