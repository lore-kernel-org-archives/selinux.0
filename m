Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B72C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 21:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7A164E13
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhBLVZy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:25:54 -0500
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:35080
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhBLVZv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Feb 2021 16:25:51 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2021 16:25:51 EST
Received: from mail-wr1-f43.google.com ([209.85.221.43])
        by :SMTPAUTH: with ESMTPA
        id Afnglcw7am2QCAfnilmBKX; Fri, 12 Feb 2021 14:16:31 -0700
X-CMAE-Analysis: v=2.4 cv=YvnK+6UX c=1 sm=1 tr=0 ts=6026f02f
 a=dFnnagVfVWeg+/bq/M6kfQ==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10
 a=QsYl2dacAAAA:8 a=oSqZqoiyAAAA:8 a=6uehwDVwuo6R3l91z2EA:9 a=QEXdDO2ut3YA:10
 a=DRj6J5qQIhcA:10 a=jVVJWZ3hHjYA:10 a=jGkiYVYK7qwcb4-OGRgL:22
 a=fw9lIXHl4l3rR_lUHM3T:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wr1-f43.google.com with SMTP id n6so847272wrv.8
        for <selinux@vger.kernel.org>; Fri, 12 Feb 2021 13:16:30 -0800 (PST)
X-Gm-Message-State: AOAM530k+0RYqaXCkc4v/C0DkLi4GwjI7Wfrz4/nN9Zc3FLSbDvd4zJN
        bxkXdH2F5U3ntk5hd98BlkkQZ24H3tmlI6onEHOfhA==
X-Google-Smtp-Source: ABdhPJwQuSGK7kPco2jvof3h3GIJGC6UGhNXNxJweVdnW3Qpdi8JWpF8oR3WS5pcUIUe6KUGfoUxk8oC3YUvVXa+u7I=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr5567489wrg.362.1613164588232;
 Fri, 12 Feb 2021 13:16:28 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
In-Reply-To: <ypjl7dndpvoy.fsf@defensec.nl>
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Fri, 12 Feb 2021 16:16:02 -0500
X-Gmail-Original-Message-ID: <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
Message-ID: <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfJXyXR/jafjUJ+btoN8yZEP7RRt+fcj2gr5JzaH9oc37dwXCq2jPusQHN7PWdYwawE4VyaR57gibiXMxQMQJXXdxWVotbiQz9VAk/jfhR6N1J53EkJSz
 KYG8i+o64K1WTk0ohPlKboV+nX9WgH/pWaoJaYwo+DaqK33j5QchiutP++Y0qQWwNlvaqD9pP2ZOPN61TxyRy0p1ewKgskl+WJzWHBsEiQ7vJu7R0ZsOBVW0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 12, 2021 at 2:58 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Dominick Grift <dominick.grift@defensec.nl> writes:
> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> >
> >>     BLUF: Logging in via SSH or directly at the console results
> >>     in "Unable to get valid context...". Help! Much info included.

Thanks to Dominick, I have made at least some progress: I can get the
role to transition,
but not the user or the process type. Details below.

> > A few things that I could find but that are needed for computing
> > contexts are:
> >
> > the login programs need to be allowed to manual transition to the user
> > type. So for example if you want to login with sshd_t:
> > allow sshd_t xferHigh2Local_t:process transition;

That rule was already present (it is the only one I really need, these
users will be coming in via SSH only).

> In relation to the above, ensure that the xferHigh2Local_t type is
> associated with the process_user_target typeattribute:
> typeattribute xferHigh2Local_t process_user_target;

I added process_user_target to the type definition, no effect:

    type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;

> > The user type needs to be a bin and shell entry type:
> > allow xferHigh2Local_t { bin_t shell_exec_t }:file entrypoint;

Also added that, after testing process_user_target, no effect. (So I
had all three suggestions active.)

I then added

    role_transition system_r sshd_exec_t CDTml_high2local_r;

and this got me my first real progress - 'id -Z' now shows:

    system_u:CDTml_high2local_r:unconfined_t:s0

> > There is probably more that i am overlooking but these, i think, are
> > important part for computation of contexts

Any other suggestions would be most welcome! I am at a loss,
especially since the
*_u "types" are not part of the policy but are defined via semanage,
and I already have
rules for the _t types, via an existing rules:

    allow { sshd_t unconfined_t } xferHigh2Local_t:process transition;

What surprises me most is that originally nothing showed up in ausearch.
I suppose this is because either PAM or SSHD is doing the computation
and not logging it in audit.log, but that is just a guess, likely misguided.

However! After that last allow, above, I finally have errors in ausearch,
many repeats of:

    libsepol.context_from_record: invalid security context:
"system_u:CDTml_high2local_r:sshd_t:s0"
    libsepol.context_from_record: could not create context structure
    libsepol.context_from_string: could not create context structure
    libsepol.sepol_context_to_sid: could not convert
system_u:CDTml_high2local_r:sshd_t:s0 to sid
    libsepol.context_from_record: invalid security context:
"system_u:CDTml_high2local_r:unconfined_t:s0"
    libsepol.context_from_record: could not create context structure
    libsepol.context_from_string: could not create context structure
    libsepol.sepol_context_to_sid: could not convert
system_u:CDTml_high2local_r:unconfined_t:s0 to sid

I then expanded the basic allow rule for the CDTml_high2local_r role:

   role CDTml_high2local_r types {
       sshd_t
       unconfined_t
       xferHigh2Local_t
       xferHigh2Local_exec_t
   };

This didn't get me any farther, though.

Do I need to widen the roles associated with CDTml_high2local_u at login?

I really am trying to keep them as tight as possible. (Which,
incidentally, is one
of the reasons I am using "old school" rules and not CIL: the M4 macros may
do more than I need them to....)

Thanks,

P

PS apologies to all for the double send of the original, user error (PEBCAD).

Peter Whittaker
Director, Business Development
www.SphyrnaSecurity.com
+1 613 864 5337
