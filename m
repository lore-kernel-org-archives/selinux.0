Return-Path: <SRS0=oduP=72=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF76C433DF
	for <selinux@archiver.kernel.org>; Sat, 13 Jun 2020 20:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F602074D
	for <selinux@archiver.kernel.org>; Sat, 13 Jun 2020 20:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTBANt8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgFMUIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMUId (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Jun 2020 16:08:33 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03974C03E96F
        for <selinux@vger.kernel.org>; Sat, 13 Jun 2020 13:08:32 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b8so12182806oic.1
        for <selinux@vger.kernel.org>; Sat, 13 Jun 2020 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MU6T1TkrRAi7pY3KgJOF3MEq3oalVZpsg5vXA5m4n0w=;
        b=bTBANt8XSnalk8PWokL2qLwGd5+AV5NVnLa56/EeGMIr/I/tAJPu8octI4qdd0WgBF
         fArBZAPyyCPM7xTD9ZoA4A7kPbDGQ3UVWf0yU8wFBmhKlcZqpHStBNZtnk61Dpr1L6Pi
         /HT+WyVeD79Pd8l6kJUiGOZi6cm6KHW/MdZUn6I65fRrDMMu73kWCyK7x0WRyxzImqp8
         ZuExSWmksNE6rLbvyjg3ag2xsmtA0EiWaSA9o9DKWMNQVykZ/95e9tnRVS1FLbtt4Vac
         WBGWx0VMNkeUWHVszfrSJ13GKnFS6CRd/mAHZz0J/ZJ3CIif761W7OWl3ZlE8NwHE1f+
         AA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU6T1TkrRAi7pY3KgJOF3MEq3oalVZpsg5vXA5m4n0w=;
        b=pSwxfLC2yDf0CWB4IlRC0WTDqbUY5nd70WjRHEHI/xuA1vqbtn4/DgLsOZHKz412tT
         0znZviyT/kRg0563bI6q9xZZ2C0IrUv2j3Jpwvd5kUFKhEqaQj6QEmeLNJ1RAhCw7TWe
         nxtxaorO6vCf4mX86mRzaaaxUbQzuI1zy5QKCj6ABFlNY4HREAqCauW+BwdWbHR7A+cu
         I+I3bs0vuvgvTF791iusoHK6Kbv90N5yMr144/VswOGp4e/Capm+bTWiTckiv+TJEjAC
         nWxtStw3xhaEoefecfH/RzYd/P0Z9EYAy2it59O+JrLj5UUTDumbIwXZY4I+6kxAqDSo
         8uKg==
X-Gm-Message-State: AOAM530Hsur+ON95TkorFmuTIQKYUfm14y5FG44A2q3l8lE1qWPaQTrm
        UiLEmyhi5ZPFKZXF0k8PiZkhBBM+NFt/XS/fba/R5Cnk
X-Google-Smtp-Source: ABdhPJzVgR0EYEgzbagKwiNpX4MM4TkVpMLmdPnGFUXwPtPHLwCltnFaG43eEA4Jfk71FefF9CyLSTFqJ0/jNixaesE=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr3590654oib.160.1592078911921;
 Sat, 13 Jun 2020 13:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <237d104b-3cb4-8527-386a-dce96c85ecec@rosalinux.ru>
 <CAEjxPJ7nwA2qFLYZN-X8V9Sqbdbcx-7e=R5j9y=khHTAsbe=yA@mail.gmail.com> <7132c007-b6ce-60e2-b86a-491b43553a49@rosalinux.ru>
In-Reply-To: <7132c007-b6ce-60e2-b86a-491b43553a49@rosalinux.ru>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Sat, 13 Jun 2020 16:08:21 -0400
Message-ID: <CAEjxPJ7N16U3HS0GivOJcHPiqmkNL5wV0Nx8jpGbjBBRGeb94g@mail.gmail.com>
Subject: Re: How to off RBAC in SELinux?
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 13, 2020 at 9:44 AM Mikhail Novosyolov
<m.novosyolov@rosalinux.ru> wrote:
> I am aware of this and that is why I want to keep existing types,
> domains and labels and not break those exceptions. What I want to
> change is make the kernel not dissallow access when RBAC/TE is violated,
> unless MLS rules are violated.
>
> > What you could do is to reduce
> > the policy to just the minimal set of domains and types needed to
> > support those distinctions and leave most things labeled with the same
> > domain/type.
>
> It would require reworking the whole policy and rewriting MLS exceptions...
> It is very near to writing a policy from scratch, I think.
>
> Patching the kernel to achieve this will be OK, but, after studying the code,
> it seems that the whole selinux was first designed to block access
> when RBAC/TE rules are violated, and then MLS was added there... So it is not
> obvious which part of the code would better be changed to achieve this aim,
> and how hard it will be to achieve it.

IMHO that's not a good plan.  Consider for example what happens if you
allow a domain to override MLS constraints (ala mlstrustedsubject) and
you don't enforce TE at all.  Then what prevents a untrusted process
running at the same level from ptrace'ing that trusted domain in order
to bypass MLS, or overwriting its exec type with arbitrary code, or
any number of other things that could be used to subvert it.  That
only works if you are willing to rely entirely on DAC separation for
that kind of protection.  That's more along the lines of Smack's
model.

From an implementation point of view, it would be easy enough to
modify context_struct_compute_av() to just initialize the allowed
access vector to all-ones instead of zero, drop the nested ebitmap
loop for computing over the TE rules, and then walk the constraints
(which include the MLS constraints as a subset) to remove any
permissions that violate the MLS restrictions.  Essentially
context_struct_compute_av() reduces to just the constraint logic in
your scenario and the rest of the function can go away.  But that
leaves you open to the problem noted above.  At that point you might
as well just use Smack if that does what you need.  But understand
then that you are relying on capabilities and DAC as external
dependencies, so correct configuration and use of those is crucial and
not something under Smack's control.
