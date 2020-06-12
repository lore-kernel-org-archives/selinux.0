Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3BC433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605CB207ED
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 20:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOLCeMQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLUoN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLUoM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 16:44:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841DC03E96F
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 13:44:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id p70so9900492oic.12
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65i/mNBHlJbvi4GqFKg2tIWQ5GpsDGHbioLLErd2tCs=;
        b=uOLCeMQay16DGmxhKVNS6k4u4O0W4tAzAd7HbesrW8MkOdAbrCzbPWIPtO3d03qDV2
         OGVud6V9WP/DNPK3u4NQhmJL4/8ndOx1KRmnYwpYr+u0K/zKs/ZfEYoqKnAbw5FF9i2e
         ETjbs8mGWhgRJIFQuoPcjkgg2qeilTfpUWSIhWdFmdAr1CmFJYYby95VD+oUndjKcndw
         XI9HZ4Bs9zo+mW54b0cCX6WAl9q2FGioUKd4ns0fowoAragSHBnZjSdbA7VgOV5koluV
         HrdtooM6yQo0IF9x4deEuqmmRzbGuFnrjNuVDIAHvLp/pSyJuuVf1qYbERvIpbXPSTOT
         cr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65i/mNBHlJbvi4GqFKg2tIWQ5GpsDGHbioLLErd2tCs=;
        b=ft/exNvZ9R+vSc7GyD8l+MitKkRn1htnHU3ow6aujSTHJU2ghbtzywwMZNZ3HlPvmZ
         P70PbH2WEOpMm7sEfAuTlbW0VKGcR8q2i4hI2DZXogrz2KWbUGknUjB9BwY0hF6czRl0
         VxHiiMfad1hQiL0IHXRmai53rOVKB5v6goXuI2arDZQlKE3Zz4AuDW2H+xx9nidMr3Y1
         VsQmb0GZPYEci7p/NBePLG08NJ0flK1fCoGQM1JaC5Yq4r3RUMz6V6VRS6LdNT2ZnozL
         N+x+duv2JS5N63ilucYfSbu2u6R32GZQ6aZWN+fdabRB7R3+Uerx/QeNzGxrplULNBCo
         D0uw==
X-Gm-Message-State: AOAM533FH5JVFYmdjls+MOSTLixBlgmXHRX4I1CB848GsUxAeYe07703
        o+zPzrt5N66+YJqNzX6rxSiaktxrZ9v+8ABEYOXU/xsx
X-Google-Smtp-Source: ABdhPJxCX17j8gpJmigp/5yrqir2lSSjCJ0XnesNRHNgMUDF6OhU0vtgezWbS09RmcRNcPaoiFkkheagUMj34CzgxX4=
X-Received: by 2002:aca:3283:: with SMTP id y125mr633718oiy.140.1591994651624;
 Fri, 12 Jun 2020 13:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <237d104b-3cb4-8527-386a-dce96c85ecec@rosalinux.ru>
In-Reply-To: <237d104b-3cb4-8527-386a-dce96c85ecec@rosalinux.ru>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 12 Jun 2020 16:44:00 -0400
Message-ID: <CAEjxPJ7nwA2qFLYZN-X8V9Sqbdbcx-7e=R5j9y=khHTAsbe=yA@mail.gmail.com>
Subject: Re: How to off RBAC in SELinux?
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 12, 2020 at 4:05 PM Mikhail Novosyolov
<m.novosyolov@rosalinux.ru> wrote:
>
> Hello,
>
> Is it possible to remove any checks for RBAC (role-based access control) violations and check only against MLS/MCS rules?
>
> What I have:
> 1) a system with most files labelled correctly according to a Fedora-based SELinux policy, which in turn is based on the refpolicy;
> they will probably have to be kept to make what I want work
> 2) RBAC-based control from SELinux is not needed, e.g. it is not needed to prevent httpd from executing 3rd party binaries
> 3) MLS is needed, e.g. it is needed to verify that httpd cannot access "secret" documents
>
> If I understood correctly, main calculations are done in context_struct_compute_av() (security/selinux/ss/services.c), but it does not query MLS separately.
> Also, all actions are prohibited by default, the problem is that the policy specifies what to allow, but I would like to wise-a-versa specify what to deny, but keep MLS parts working as is.
>
> The question is: is it possible to make selinux ignore (2), either in the kernel or in policy?
>
> In other words, how to make SELinux make allow-or-deny decisions based on MLS/MCS only, without RBAC?
> The only question that must be answered is: does this action violate rules of accessing objects of different level of secrecy (sN:cM) or not.
>
> Please give a clue where to start looking for a solution. Thanks!

The problem you would quickly run into is that you always need
exceptions in any MLS policy, e.g. files that need to be readable
and/or writable in violation of the normal MLS restrictions and
processes that need to be exempted from them.  The way you do that in
SELinux is to use different TE types and domains and provide OR
clauses in the MLS constraints to exempt them.  So I doubt you truly
want to disable RBAC/TE altogether.  What you could do is to reduce
the policy to just the minimal set of domains and types needed to
support those distinctions and leave most things labeled with the same
domain/type.

If using refpolicy, you want to build with TYPE=mls rather than mcs if
you truly want MLS-style enforcement.  MCS in contrast is opt-in and
only applied to specific domains/types, not to most processes.  In
Fedora/RHEL, you want the -mls policy rather than the default targeted
policy.

Alternatively, you could create your own policy from scratch rather
than using refpolicy.  scripts/selinux/mdp will generate a relatively
minimalist policy for your kernel but then it is up to you to turn it
into something real.  You'd need to modify the stub MLS constraints it
generates, either replacing them with those from refpolicy or writing
your own.

And then there is the option of using another security module or
rolling your own if none of the above works for you.
