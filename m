Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E195C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9EA205F4
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAFNgv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbhAFNgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:36:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945CC06135A
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 05:36:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t16so2475544wra.3
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWcOaYuU3jcFYzmmoEfu4DLJFr4aMQQhF9uphJYfTtc=;
        b=XQnxE9jQtASEPkygo8QT00eje+dYr/DVATfnLLupf0FfLlxYyPMj0McICxsB03oJcZ
         Rv7+vUBLzZLpOgvuYv743bQzT/NPvXRCjDjUWm5fc7mrdHMKqGzMdDWbI0CYyoIzKyVJ
         npC+4yDs57O9M4DfrixN7G0M4RHVAk5Zg+v2NU6shCjpl7xcD0ftleXVw8qIBZGWpq6X
         ywrIyXRVmoEijT2n2VO8BONbU/NcHwgcJtrihkpIpql04aWOJUP84rCtWWglf4IXP47R
         YHey1IFKUBJmlvOhpb8dxock2klZUEQeajllzBcTp3EnZPLsP37xhKA2Q27Og1Vfl5cS
         mCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWcOaYuU3jcFYzmmoEfu4DLJFr4aMQQhF9uphJYfTtc=;
        b=i3qT+CjsVwvZydt+Lt/Tsl3t+2y/vJgjVVrMaWNgLKm3Ap4b2vI/hpnMJzbJaYMJ5z
         QrZhcd3PL6OOoUOsvrTT8cgBF38sfscy3GLZ+l5W6hDAA8Yo7h1fwJoHl1278TNDfXft
         Fqdxmm4hpiilySIcMDFTAx038IELKZtVjOg5UKNh1FCwBymOJI4xIUG5xmSOC83Jjltl
         FMcvGum3G+x/DU2rOxECElRM1h0zLj5FnzvLlWX9PMfc6wsqSjdPrfq1JZAO+l0Gsa3Y
         SPdNU74ztqj5UjMzNNSNwXe0O647qG+eK2SC6oleCrbyRXO0MiALnWKeScoK4Ae0Awq+
         E2SQ==
X-Gm-Message-State: AOAM530t9GARFiFi+x4M7s/Un31lF5mecHAqfuftSArVEqkXUL/oNW2K
        R6llRI6Fi//O/5fm5I/xxPnYdFgpyajiUPB82oB1SU9HQ9lLQ6Fd
X-Google-Smtp-Source: ABdhPJxMnsuU+ol290iVBncIn9e72jHyJXiJxTBmjzq+4Ocvg438pxUlN5YeCY/ztdYqAitnsO4Z+5yEms9sBRa9Rh0=
X-Received: by 2002:adf:df08:: with SMTP id y8mr4277528wrl.278.1609940164477;
 Wed, 06 Jan 2021 05:36:04 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl> <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
 <ypjlv9cc50hj.fsf@defensec.nl>
In-Reply-To: <ypjlv9cc50hj.fsf@defensec.nl>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Wed, 6 Jan 2021 19:05:53 +0530
Message-ID: <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dominick ,

Thanks for the inputs above.

1) w.r.t Monolithic , i am trying refpolicy with monolithic design as suggested.

2) I am debugging on the lines you suggested , and prima facie looks like the
    busybox login is being executed here which takes
system_u:object_r:root_t as context

3) Can you please let me know which stable source code for
    a) policycoreutils-python    ( to get semanage on target )
    b) setools-console              ( to get seinfo / sesearch on target )
    Please note that we have integrated userland libraries and tools
projects from https://github.com/SELinuxProject/selinux
    But the above mentioned binaries are not present on target.

Request to please let me know input / feedback if i am missing any
obvious things here

Thanks ,
Ashish







On Mon, Jan 4, 2021 at 6:21 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ashish Mishra <ashishm@mvista.com> writes:
>
> > Hi Dominick ,
> >
> > Thanks for inputs .
> >
> > a) This is an embedded board which logs in by default as a ROOT user.
> >      Any pointers as to where can i look to debug the cause due to
> > which context is "system_u"
>
> Lack of PAM support or misconfigurated PAM config (pam_selinux needs to
> be present in the appropriate PAM stacks)
>
> >
> > b) Apologies , but can you please help method / approach / debug
> > points by which
> >     -> I can evaluate the expected contexts for root & testuser
> >     -> I can see that the labels are created using ls -alZ .
> >         Is there any other method / debug point to check filesystems
> > are labeled according to the policy.
> >         ( as i am using standard refpolicy to create an default policy
> > on board )
>
> You start by determining the current context of the login user (id -Z
> will print the context of the current shell). Then you determine the
> context of the directory in which the file is created (ls -dZ)
>
> With this information you can query:
>
> sesearch -T -s "type returned by id -Z" | grep "type returned by ls -dZ"
>
> That should return any existing "type_transition" rules where the type
> of the user is the source and the type of the destination directory is a target
>
> >
> >
> > Thanks ,
> > Ashish
>
> The question is whether you want/need IBAC/RBAC on an embedded device
> with only one user (root)
>
> In my policy for OpenWrt (which is a embedded wireless router firmare) i
> do not use IBAC/RBAC either and i just add a rule that say's when the
> login program (sshd) executes a shell then assume that this is a login
> user shell and automatically transition from the sshd context to a specified
> user context)
>
> On embedded devices "modular reference policy" does not make sense to
> use (these devices generally do not have the resources to compile/link
> policy at runtime) IMHO and the "monolithic reference policy" does not work well with
> PAM and users.
>
> But, yes, if you want modular refpolicy on a multi-user system then you
> probably want PAM
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
