Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000AC433DB
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB061493
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 17:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNRDY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Feb 2021 12:03:24 -0500
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:54537
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229740AbhBNRDX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Feb 2021 12:03:23 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54])
        by :SMTPAUTH: with ESMTPA
        id BKn9lla0Ym2QCBKnBlnSg1; Sun, 14 Feb 2021 10:02:42 -0700
X-CMAE-Analysis: v=2.4 cv=YvnK+6UX c=1 sm=1 tr=0 ts=602957b2
 a=AzFVNxfIwFHkKIYX7pJ4Tg==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10
 a=QsYl2dacAAAA:8 a=oSqZqoiyAAAA:8 a=vTr9H3xdAAAA:8 a=uYrVuNnz-Dtrhr0a65kA:9
 a=QEXdDO2ut3YA:10 a=jVVJWZ3hHjYA:10 a=jGkiYVYK7qwcb4-OGRgL:22
 a=fw9lIXHl4l3rR_lUHM3T:22 a=7PCjnrUJ-F5voXmZD6jJ:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wr1-f54.google.com with SMTP id v14so5887667wro.7
        for <selinux@vger.kernel.org>; Sun, 14 Feb 2021 09:02:41 -0800 (PST)
X-Gm-Message-State: AOAM530baYmHrNi+b9vXAcZFJgE6MFlYBtDs/Rhs/ajjUtYNJQj7pcg0
        kis5Ad6QgfpjLc4VZwfW45SBENfYHAOrOW0GcDfYgA==
X-Google-Smtp-Source: ABdhPJy19Fz4rpcIpc0sM1jlJyh6/v/GVRhmfcHa841lWmm650IOybJ7i85TzPvdBZP1qO+/XmdCy3UkBCugFLE7y5o=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr14587714wrg.362.1613322159191;
 Sun, 14 Feb 2021 09:02:39 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
 <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
 <ypjl35y1ot14.fsf@defensec.nl> <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
 <ypjlv9awo2iy.fsf@defensec.nl> <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
 <ypjlmtw8ne46.fsf@defensec.nl> <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
 <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
 <ypjlim6vog7a.fsf@defensec.nl> <CAGeouKF5n_HU3h7tMEOFr3S0dXAQjbhMPtgi=AB5g9i3w1s_aw@mail.gmail.com>
 <ypjleehjnm2m.fsf@defensec.nl> <CAGeouKFKT5dj8E7YOS-+jG0v=vO1r8HoJGi6weSy0zwRgD=4hA@mail.gmail.com>
 <ypjla6s6obit.fsf@defensec.nl> <ypjl5z2uobbg.fsf@defensec.nl>
In-Reply-To: <ypjl5z2uobbg.fsf@defensec.nl>
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Sun, 14 Feb 2021 12:02:13 -0500
X-Gmail-Original-Message-ID: <CAGeouKGTGPiJhWLnt2qJ4HqF5SSKB9F2DFE_GeBLcv2d++-2cw@mail.gmail.com>
Message-ID: <CAGeouKGTGPiJhWLnt2qJ4HqF5SSKB9F2DFE_GeBLcv2d++-2cw@mail.gmail.com>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfOBtPNmrSmEIsF1OOPyJaJkF+mMn1ELwHr/ilR3IKAq50xARLPqSeu8djrzdui+1SM4aoCCbX88wAgP6LkPtLAQc4FQdqhHfiyKMxCngqsxAQcJZkwQs
 o5Td2W3M4/2tNgabXUCmx5xDpEkyM4jdN6El4qMexpxXJAke/xW48EpnmFi3JjX52YZtMqKWTfPRTRlqjt5lT3ZuBNWO08+SMoyKbub20hFA8IhEp1tLf8Nh
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 14, 2021 at 11:39 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Dominick Grift <dominick.grift@defensec.nl> writes:
> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> >
> >>     session    required     pam_selinux.so open
> >>
> >> also worked fine.
> >
> > oh right! ... yes corner case...
> >
> > to make it work with env_params you need:
> >
> > allow xferHigh2Local_t self:context contains;
> >
> > Sorry for overlooking that

No worries! So many moving parts to keep track of.

> >> I need to do some research on this. The env_params option was a system
> >> default, I dislike changing system defaults unless I understand why.
> >>
> >> Now to figure why the auditor's context is failing to be set.
>
> I think this patch is why you need "context containts" when you have
> "env_params" set: https://src.fedoraproject.org/rpms/openssh/blob/rawhide/f/openssh-7.8p1-role-mls.patch

Interesting. This might argue for an OS upgrade....

What is driving me particularly nutty is that for this 7.9 Maipo box,
I based my rules on a working set I wrote for a 7.8 Maipo box. Among
other things, both use sshd 7.4p1.

And yet the 7.8 box has 'env_params' and no 'contains' rules, and all
SSH logins work as expected, while this 7.9 box has me clawing me at
my eyes.

P
