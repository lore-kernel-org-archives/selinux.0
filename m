Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA5C3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1511A2072D
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ui3jmDWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgCDJH1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:07:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387752AbgCDJH0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 04:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583312845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngB3marMf7APreHVZNTtvzfr01VAsxiRMeLZhhXsHjI=;
        b=Ui3jmDWQ0qHjdo9SrT5XfdJko2cJ56LEwYMmDfKyovNULcUVh5nk8pZm5/QF98yQNVsgPj
        X0VwHbESuiC3xiwMawLWUyBHqMBZoJ4s28Da40unWUgaGmAGJXDiryTmaZfc5yacbJA22v
        ydb0+dAeAiDYiHCICoT1wYCIsraRrnY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-vBBUtgg3MrmIDO6RjdPVMw-1; Wed, 04 Mar 2020 04:07:23 -0500
X-MC-Unique: vBBUtgg3MrmIDO6RjdPVMw-1
Received: by mail-ot1-f69.google.com with SMTP id t16so685526otc.3
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 01:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngB3marMf7APreHVZNTtvzfr01VAsxiRMeLZhhXsHjI=;
        b=P5pS/AszKdUGUqSRYn3JY64FAM7xufr2p10DCGSUi3aX3z7Pp0Zp+21musYiUMN58L
         hsFcMXjBjOWt3yEB7kDBqe6fqzR+OpFVDmRewgbD+a30XLDD+shx1Fbd8DhGn7pLRm0N
         kNUlUR3D3UbY+m7O+GpRrEnEleA8h4scVpMgAeKCeflOsOrIMayl0tlcHIQ1DSczEawF
         sQJpurbwsfSpmVWRg9ia3e5dbeBYY1+awHqzoaHk5oWRU7vG3AlI2EqRcyN8wyEWnYHR
         hFj4ep386XlrkEmhgQq0WcrCMEAGkz0zazFcsJ+U05vuMx9V1VYoHFgGRr3SevHuCB9m
         U74Q==
X-Gm-Message-State: ANhLgQ2CqGbMnVgEjHcpvpWubp+qpjYN1Vhps7+Wh1YfDUXD2X1CrYG5
        cvBwLyo4T65Cbf+We2KQa64cFqG/2RAaZ/uZnGCR0OEl7v1SQGNirW8/Vn9EhBoYI0LHdE0WUyd
        wSHiqz8PMi92ICNaxx9s9qISQHOBU8kjpxA==
X-Received: by 2002:aca:574c:: with SMTP id l73mr1062670oib.156.1583312842563;
        Wed, 04 Mar 2020 01:07:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuv4spSq+Mbjq4urq4n4j/O0bpFTS1y3E/6d26UjYj9mmcogN3P8ekomdi7m4SL8jmaGJjn186+rDGI8xv9eBI=
X-Received: by 2002:aca:574c:: with SMTP id l73mr1062654oib.156.1583312842256;
 Wed, 04 Mar 2020 01:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
 <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
 <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
 <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com> <CAFqZXNub7i2OyqWqU2snePw+XBfJxauh-0n2zgZy_q58sZovSw@mail.gmail.com>
In-Reply-To: <CAFqZXNub7i2OyqWqU2snePw+XBfJxauh-0n2zgZy_q58sZovSw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Mar 2020 10:07:11 +0100
Message-ID: <CAFqZXNunTQfLAc7JAfZyvynPS0s=ADK0fbT1rXrcUCsMiDk9HA@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 10:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Mar 2, 2020 at 9:22 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Mar 2, 2020 at 1:45 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
[...]
> > > secilc has -G and -X options for controlling expansion of attributes, but
> > > there aren't equivalent settings in semanage.conf to control when
> > > building modular policies.
> > > Internally it all uses the libsepol CIL support so it ought to be fixable.
> > > Looks like the default is 1 in cil_db_init() so it only happens when
> > > the attribute has no types by default?
[...]
> >
> > Apparently that was to eliminate attributes that have no types at all.
> > Seems like we could add new options to semanage.conf to provide equivalents
> > to secilc -G and -X, and have semanage_direct_commit() call
> > cil_set_attrs_expand_generated()
> > and cil_set_attrs_expand_size() in the same manner as secilc does based on those
> > semanage.conf settings.
> >
> > Could also look at increasing the default size to 5 or something and
> > see what impact that has on
> > Fedora policies.
>
> Well, for a start we could increase the default to 2, which should
> only remove those attributes that have only one type. That has
> practically no downsides (other than making it a bit harder to trace
> the rule back to source policy) and would be just enough to make the
> optimization work nicely.

I played with this a bit by recompiling the local binary policy with
secilc and then comparing the CIL of both binary policies (I used this
script [1]) and the results are a bit confusing... There is no
difference in result between -X 0 and -X 1 [2] and in both cases it
removes some unused attributes (those are only referenced from
neverallow rules) that were in the original policy
(/etc/selinux/targeted/policy/policy.31 from my Fedora 31 machine),
but not in the one recompiled via checkpolicy -C + secilc... At least
I was able to confirm that secilc -X 2 really removes the attributes
that have only one type and reduces the policy size by a few
kilobytes.

I suspect that the reason for the unremoved attributes in the policy
built by semodule are due to a bug in libsepol: It seems that when it
starts with a cildb that has the neverallow rules in the input policy
+ has disable_neverallow set, it removes the rules but not the
attributes that are used only in them. Only when it reads the policy
again, it identifies these unused attributes (since there are no
longer any neverallow rules in the input) and removes them
unconditionally. It could be something else, but if I'm right then I
think libsepol should be fixed to remove the unused attributes right
away. I don't dare digging into the CIL code to investigate it, though
;)

[1] https://gitlab.com/omos/selinux-misc/-/blob/master/diffexpand.sh
[2] Okay, this part is not really confusing, sonce semodule should
already build the policy with an equivalent of -X 1, so -X 0 should
yield the same result.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

