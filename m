Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A465C49361
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6490A61261
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhFRTek (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFRTek (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 15:34:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5AC061574
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 12:32:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hv20so11490990ejc.12
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8m1Jo5XHBJOsiD5dVMDudjRdLYx1lOMh3Kg4OH6lf8=;
        b=F6T+H3xrx4caKN6Je6Rs4nYq/ony8MO3vOuXBurqws6qL/aIo1xyZD+zqY2Eagy4cB
         WhaN7eykRad7yAssk7NucxURWQ7wMRhaX1AdID8bStK4Lk7RGsql3LPqsBHkKPF+DzwF
         jCj+JbZV8QiwaVqd/Q59t3M2qhDtaoEL+lhU+AEpMRGLgBMaTl3wVqD/7TcBkK4uiBfL
         uxjTr7rmLDcplGRKxtVAmbp6tVR32RVDJTe2v1RuFMXXR/cO9lq0C2cclf02EcU2AaM7
         EwrXWjvMO/IGnh5aWuiL0Kr6kdwd/f+132usWLDJheef+PZ1kOvjc+4Gk4VxvQlSdRfa
         YN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8m1Jo5XHBJOsiD5dVMDudjRdLYx1lOMh3Kg4OH6lf8=;
        b=W3PXbn2rWI102tqCuXTPxSaBRgVb5hxfGENw0VAcD7IAlAGz7b2Mp+hFQnClQwOA5c
         +7GpSX6x3DOLBFzmG7mN8r1Kt5HqQaJpu2j9oO3P5+ezI404zisiDdDMcdT9shZY3DLB
         oZSdZYCGFZTxBxOOMBQy7VfWtqyw4rFy0r1hK1WkeMrNuvGkP0w32UNtw3AFSu8tsPx/
         S2LVcT0LegVXGWCKPBD8+YtGJhS/VwMi7Ftz/AeAyWgc4DR0J/c+mkr8PsjuZHskk3Jc
         tZbZ1Incc9SNesjZJzTXUlfKFhnWeO3hXjWlL5oL+tiXcsffCQVi9MdfrZJkALXjlj8Q
         I5Hg==
X-Gm-Message-State: AOAM5334ykCI5HPjUWvz9skoiFR4tLEG6uFg32JLo9CBP9A6iKAQHl0B
        AgMb/MQQXUIW0fxGiqMz8XQ/zWRdJ/WzkC7wQ6Up
X-Google-Smtp-Source: ABdhPJyoL9p6xRJHJwDKkqXtH7jGIpzHuj67TMFcUYdQcr12XjIf4jGcGmvGSZkJtKnJnCMUq+diW/QjEIkzPVYb7HQ=
X-Received: by 2002:a17:907:a8f:: with SMTP id by15mr12592030ejc.91.1624044747632;
 Fri, 18 Jun 2021 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210612081403.16732-1-toiwoton@gmail.com> <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
 <44734663-73fe-5870-f39a-e3d876efbc45@gmail.com>
In-Reply-To: <44734663-73fe-5870-f39a-e3d876efbc45@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Jun 2021 15:32:17 -0400
Message-ID: <CAHC9VhQfVqRCuR4Gn7vAOrqVeZQtzE6GjuqvFhQHKVufCk_N3w@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: describe nosuid and NNP transitions
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 18, 2021 at 2:09 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 18.6.2021 6.50, Paul Moore wrote:
> > On Sat, Jun 12, 2021 at 4:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >>
> >> Describe cases where nosuid_transition or nnp_transition are needed.
> >>
> >> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> >> ---
> >>   src/computing_security_contexts.md | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
> >> index bb946b5..7bd1d87 100644
> >> --- a/src/computing_security_contexts.md
> >> +++ b/src/computing_security_contexts.md
> >> @@ -84,7 +84,14 @@ Processes inherit their security context as follows:
> >>      *default_type* (policy version 28) or if a security-aware process,
> >>      by calling ***setexeccon**(3)* if permitted by policy prior to
> >>      invoking exec.
> >> -3. At any time, a security-aware process may invoke ***setcon**(3)* to
> >> +3. If the file system is mounted with *nosuid* flag, type transitions
> >> +   require permission *nosuid_transition*. If the thread has
> >> +   *no_new_privs* attribute set, the transition requires
> >> +   *nnp_transition*. For both transitions, policy capability
> >> +   *nnp_nosuid_transition* is also required. See also
> >> +   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
> >> +   section.
> >
> > Thanks for adding this text, however I might suggest the following changes:
> >
> > "If the loaded SELinux policy has the nnp_nosuid_transition policy
> > capability enabled there are potentially two additional permissions
> > that are required to permit a domain transition: nosuid_transition for
> > nosuid mounted filesystems, and nnp_transition for for threads with
> > the no_new_privs flag."
> >
> > ... does that make sense?
>
> Yes. I'd then add:
>
> "If nnp_nosuid_transition policy capability is disabled, such domain
> transitions are denied."

In most cases, yes that is correct, but bounded domain transitions are
still allowed in the case where the nnp_nosuid_transition policy
capability is not enabled.

Did you want to respin the patch with the above changes?

-- 
paul moore
www.paul-moore.com
