Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4157C433DB
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0ED860238
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 22:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBMWoA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 17:44:00 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:39772
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhBMWn7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Feb 2021 17:43:59 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53])
        by :SMTPAUTH: with ESMTPA
        id B3dElFKrZxs2QB3dGlbE27; Sat, 13 Feb 2021 15:43:19 -0700
X-CMAE-Analysis: v=2.4 cv=D6aCltdj c=1 sm=1 tr=0 ts=60285607
 a=ndY99XYjxx6PxHW8l/S7qA==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10
 a=QsYl2dacAAAA:8 a=oSqZqoiyAAAA:8 a=9_0r6wAcGZEFyufyJvUA:9 a=QEXdDO2ut3YA:10
 a=jGkiYVYK7qwcb4-OGRgL:22 a=fw9lIXHl4l3rR_lUHM3T:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wr1-f53.google.com with SMTP id n6so4204369wrv.8
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 14:43:18 -0800 (PST)
X-Gm-Message-State: AOAM532sWoY22lWp6Ylkyl6IAFzHQIAGW58x9bmfE+bimK9MG4xtFNuH
        z1fdf0eBzA+wCi7hEPgV85Np3VwSIU5s8s3bRfNiaw==
X-Google-Smtp-Source: ABdhPJzngnjx67CDq3thwnycLcauaA+7dzBEjTMRiaTp+/5ftKQURLRDJ5w6P6RxKMGAOyaulKTEzTAY7Loy3ESyEX0=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr10845036wrg.362.1613256196242;
 Sat, 13 Feb 2021 14:43:16 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
 <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
 <ypjl35y1ot14.fsf@defensec.nl> <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
 <ypjlv9awo2iy.fsf@defensec.nl> <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
 <ypjlmtw8ne46.fsf@defensec.nl> <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
 <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com> <ypjlim6vog7a.fsf@defensec.nl>
In-Reply-To: <ypjlim6vog7a.fsf@defensec.nl>
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Sat, 13 Feb 2021 17:42:50 -0500
X-Gmail-Original-Message-ID: <CAGeouKF5n_HU3h7tMEOFr3S0dXAQjbhMPtgi=AB5g9i3w1s_aw@mail.gmail.com>
Message-ID: <CAGeouKF5n_HU3h7tMEOFr3S0dXAQjbhMPtgi=AB5g9i3w1s_aw@mail.gmail.com>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfBSVn7cwBSZEKW/yViunQdRSut/sAuw/QIla/7lsboZ8W0oAXZb6zUE8jZT9s2PsyItmHxRkbWwlomEFo+6W9RDOqj82Z6jE3bhCXTeD/BIed0RLPQkQ
 sbOFHmjSBU6GuSRN/oCt1H0dHNagaqZyI1rd544gBB4fmtH90Y+nB9bC3UYyIchOLSA4xuWTe6MR8qj5QI3QFwkUDAFtcYEZoRyvwDETcf1IPbhv6CrfEYup
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 13, 2021 at 3:41 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Where is "domain"?

> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> > WRT all of what follows, I've attached the current CDTml.te; yes, it
> > misses the domain type, but at this point, I want to identify why the
> > two different types of users are treated differently. This is all
> > under permissive mode.

Yes, I may need it, but at this point I want to understand why one
works and the other doesn't.

P
