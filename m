Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D9DC433DB
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD8E64D9E
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 16:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNQ07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Feb 2021 11:26:59 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:58952
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhBNQ07 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Feb 2021 11:26:59 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47])
        by :SMTPAUTH: with ESMTPA
        id BKDvlIkrNxs2QBKDxlbad9; Sun, 14 Feb 2021 09:26:18 -0700
X-CMAE-Analysis: v=2.4 cv=D6aCltdj c=1 sm=1 tr=0 ts=60294f2a
 a=yTguEFSw6qQEeIF6PDpiVg==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10
 a=QsYl2dacAAAA:8 a=oSqZqoiyAAAA:8 a=wKFI2YiEW4xcx3_1XLkA:9 a=QEXdDO2ut3YA:10
 a=DRj6J5qQIhcA:10 a=jGkiYVYK7qwcb4-OGRgL:22 a=fw9lIXHl4l3rR_lUHM3T:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wr1-f47.google.com with SMTP id v14so5792132wro.7
        for <selinux@vger.kernel.org>; Sun, 14 Feb 2021 08:26:17 -0800 (PST)
X-Gm-Message-State: AOAM532iSBGptQMqM9iGPhdsaH/CdmW2EA6gKFUUDk3b5VyFncs+DvsW
        Gnjs5+SLbe0g+Ergtbsn7XbWLI4TmdUd+y9g+y5ibg==
X-Google-Smtp-Source: ABdhPJyEt/7hegIUZrGdbHW2MZ65m/yv3Ll/9CT34NtcOv0NqAU2en9XitnRxZLduXLjndvRrYfzs0BVVv6UakNDAvw=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr14825306wrw.302.1613319974995;
 Sun, 14 Feb 2021 08:26:14 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
 <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
 <ypjl35y1ot14.fsf@defensec.nl> <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
 <ypjlv9awo2iy.fsf@defensec.nl> <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
 <ypjlmtw8ne46.fsf@defensec.nl> <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
 <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
 <ypjlim6vog7a.fsf@defensec.nl> <CAGeouKF5n_HU3h7tMEOFr3S0dXAQjbhMPtgi=AB5g9i3w1s_aw@mail.gmail.com>
 <ypjleehjnm2m.fsf@defensec.nl>
In-Reply-To: <ypjleehjnm2m.fsf@defensec.nl>
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Sun, 14 Feb 2021 11:25:49 -0500
X-Gmail-Original-Message-ID: <CAGeouKFKT5dj8E7YOS-+jG0v=vO1r8HoJGi6weSy0zwRgD=4hA@mail.gmail.com>
Message-ID: <CAGeouKFKT5dj8E7YOS-+jG0v=vO1r8HoJGi6weSy0zwRgD=4hA@mail.gmail.com>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfHC6ztakSOSd0FN9eavZQkGiePxMaA0AOaOjq82PRS3JSlE/muXxvY3GyM3E0vgOH/wA5CDg2RduMHXsiHoJqZkTAlPZxegjrz6eIVC+q2p/3gtVsKZI
 PXMA2EM5U90iFlDdtLEKictDCta42OlsL3Whpp9dSyaRs0/h8+UklMxiFYGMWvtdb3vj4/qIwoXwZqCVvGjqi2ayS1nveS7Zk0AWQSAoTe3+WBS3h5vGpeKb
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 14, 2021 at 2:32 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>
> > Yes, I may need it, but at this point I want to understand why one
> > works and the other doesn't.
>
> I know that the openssh-server in red-hat based distributions has custom
> selinux patches.

Well. Just fixed it by accident. The relevant line of /etc/pam.d/sshd was

    session    required     pam_selinux.so open env_params

In an attempt to debug the problem, I changed this to

    session    required     pam_selinux.so open select_context

PAM did not ask me for a context, but did set the context correctly.

    session    required     pam_selinux.so open

also worked fine.

I need to do some research on this. The env_params option was a system
default, I dislike changing system defaults unless I understand why.

Now to figure why the auditor's context is failing to be set.

P

Peter Whittaker
Director, Business Development
www.SphyrnaSecurity.com
+1 613 864 5337
