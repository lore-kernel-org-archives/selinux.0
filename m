Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE0CC3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66B920882
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO+1h67F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbfISMr3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:47:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387520AbfISMr3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 08:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568897247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4Xb4Sk1xeO0T9dm5kzhIc3psSfkD136+1Ov/qjaJ4U=;
        b=iO+1h67FmpIt7kL7sa347UZ0BjRNx3waKmY0gQPLfe/7sKrKX56Ao1nEgQRcf+oYjktuZY
        Id+s/e2uFl+g5ipWgRoPSuHh6cdbUCfKT/cnZBlF4sqhs7moovL3UkM4ES+Dj8ihpJprjD
        YTjedk7gOlkOKNWorC/tBffTN9mARpU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-r2wDYROjPNCm_SNvgH8Nhw-1; Thu, 19 Sep 2019 08:47:26 -0400
Received: by mail-oi1-f200.google.com with SMTP id c18so1843914oiy.9
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 05:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ65N2hj8ZILuQ8BlZ/qpoPWzGI1RuEFHIZ/aN1MWHs=;
        b=asdGo7IESw/EtmUlKMwcaWDCkwBceA3BD663tsl4EzHOFNaROII8l54sKEO86eVa6Z
         LTrw9ZHSlKAhvasz10voIeY/9Ypkw0X07cipsA2XYMcg63e1jYvZKCBL2HMp5+dmA73V
         2Z2y2chVsDqYYqHQnm20NY9D7mYyGt1aXpc0tIcvNPlFhxaEZURsO8cpunEiKdadk7jD
         EMMZpm4h254mbcruswdy4LjVF7xWYPQllYfXeXjlw5QCzmx29q+dFOxqZAids5yORoId
         7enOnGRil7nCCbB8TDZPXfqYZMpfrn5ttIN9g3uhaSTBTsYJMfVAha32PDY6PjNmwM4i
         zaHg==
X-Gm-Message-State: APjAAAV9siGi3T2B8Fl8qWHQKJ9NKghnEEc/hSeMCMShGirKbhXhWaB/
        AYxay3lvEgH9lPEVPNNpwgjp9cxfeSPrpO4O4iiVEYjSfKo92rkcAFDgV9zYokt1sYz+R203liy
        vWDWlb9VEgX1VHHMBMTqnDOwvWFKQYj49gw==
X-Received: by 2002:a9d:625a:: with SMTP id i26mr4371854otk.43.1568897244107;
        Thu, 19 Sep 2019 05:47:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyF0tBk2h0kWxZ4JLcfWgVjfJ6Jfj1q5dnn+rAY8i/g3DVEi3Wj+DUbosr5r/k0FGqD32iEklmAfuftqleWo90=
X-Received: by 2002:a9d:625a:: with SMTP id i26mr4371838otk.43.1568897243764;
 Thu, 19 Sep 2019 05:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190918125507.10778-1-sds@tycho.nsa.gov> <CAFqZXNuZ00pFj_vyzJ3W3x2Fbs=NA+NDMCUR9fwpaerUfRU-pQ@mail.gmail.com>
 <2ac5eb4d-b44f-bbe2-58fd-8a9c1758e4b9@tycho.nsa.gov>
In-Reply-To: <2ac5eb4d-b44f-bbe2-58fd-8a9c1758e4b9@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 19 Sep 2019 14:47:12 +0200
Message-ID: <CAFqZXNuyukdZ5-tbq=n148ZCt0QyGroELA3shRwjoLGMuuKnow@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: apply perltidy to infiniband test scripts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: r2wDYROjPNCm_SNvgH8Nhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 19, 2019 at 2:17 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/19/19 3:43 AM, Ondrej Mosnacek wrote:
> > On Wed, Sep 18, 2019 at 2:55 PM Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
> >> The infiniband test scripts weren't compliant with perltidy so
> >> make check-syntax was failing.  Fix it.
> >
> > Unfortunately there is some disconnect between the perltidy version
> > available in the Travis CI environment and the newer versions
> > available in more recent distributions... See this commit in the
> > audit-testsuite [1] - the decision is to follow the Travis format as
> > the common "standard" (there is really no better way until we patch
> > the Travis script to install newer peritidy somehow...).
>
> Ok, I reverted this change. Wondering if this could be controlled
> through any of the perltidy options, or fixed by using a newer image
> e.g. bionic.

FWIW, I just checked and bionic is still not new enough:

Passed with old perltidy syntax:
https://travis-ci.org/WOnder93/selinux-testsuite/jobs/586994152
Failed with new perltidy syntax:
https://travis-ci.org/WOnder93/selinux-testsuite/builds/586996059

>
> > Just in case you don't know, anyone can easily enable Travis CI on
> > their GitHub fork - just go to https://travis-ci.org/, log in with
> > your GitHub account, and switch the corresponding project to enabled.
> > That way you can just push a branch to your fork, it will be tested
> > and you will get a report to (just) your mailbox. I.e. you can do the
> > canonical syntax check without opening a PR against the upstream repo.
> >
> > [1] https://github.com/linux-audit/audit-testsuite/commit/7ff3e434bc243=
e667ebb26a22b64176e662fddec
> >
> >>
> >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> >>   tests/infiniband_endport/test | 2 +-
> >>   tests/infiniband_pkey/test    | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/=
test
> >> index 0021e0d69af4..f071fbc18cf8 100755
> >> --- a/tests/infiniband_endport/test
> >> +++ b/tests/infiniband_endport/test
> >> @@ -40,7 +40,7 @@ ok( $result, 0 );
> >>
> >>   foreach (@denied_device_port) {
> >>       @dev_port_pair =3D split( / /, $_ );
> >> -    $result =3D system
> >> +    $result        =3D system
> >>   "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev=
_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
> >>
> >>       if ( $result >> 8 eq 0 ) {
> >> diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
> >> index 3ee4d13c8ffe..382c25913ca0 100755
> >> --- a/tests/infiniband_pkey/test
> >> +++ b/tests/infiniband_pkey/test
> >> @@ -32,7 +32,7 @@ close($f);
> >>
> >>   # The gid sysfs shows a fully expanded ipv6 address, just take the
> >>   # top half.
> >> -@tmp =3D unpack( '(a20)*', $gid );
> >> +@tmp           =3D unpack( '(a20)*', $gid );
> >>   $subnet_prefix =3D $tmp[0] . ":";
> >>
> >>   @labeled_pkeys =3D split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED=
_PKEYS} );
> >> --
> >> 2.21.0
> >>
> >
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

