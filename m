Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017FDC352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D651621734
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqKpZCU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390192AbgDPOVC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:21:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390158AbgDPOUt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 10:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587046847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/CddkJsu3YhrBDw1ge/FZm45Z8ycRLJ1ppjF0Odj/0=;
        b=PqKpZCU/I0fjwYlTxJQIYNK4BnXFKN6c7hT2PrL7565lOnv0tTy0JfmqxARl6KIYOGO899
        t0p+CSiDscqYIANK0v0DmnvNSr1E8MDGB5udvkNursZ+loc90E4PwKp14lGn5sscfNKynr
        mFLL+62Wb7TVCtqYpnobQmDUmXeW0E0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Q4WnOHDiNrK1QWJjO2we8A-1; Thu, 16 Apr 2020 10:20:45 -0400
X-MC-Unique: Q4WnOHDiNrK1QWJjO2we8A-1
Received: by mail-oi1-f199.google.com with SMTP id b21so6227234oie.23
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 07:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/CddkJsu3YhrBDw1ge/FZm45Z8ycRLJ1ppjF0Odj/0=;
        b=roYs2iXEMey1x+TR7wrDkZZACzwIZzwtrWXheBn6VzvQi3DdfhL9P3RLP0QxMjtPvz
         BFY7+nMfRfRbHhlXNEFfVJcutsqM4zGYhZTzorKJLTCTKxfCSkQLElemwyAPEDPemzQ3
         o0Hx3IxWNEEZ8npQecJwC05H+L7+r+fU2BDEK4xRtoQ0yObHPhzXfK8/lFhS7sUYTNWm
         cAUcaKSMkF3VDk7C4N+In6/CUqpb64sQn8J2J3TxoXQ9DFUFe+pZP+vgxMfPSsk65D5y
         U+O8AHKZiuTsl6raifp7Ny+P6HjRmmGQR/CyKWBN0wQCDFfsyUNh/1E/W2SqWwv7GPsI
         0P5A==
X-Gm-Message-State: AGi0PuZ9t/+bJ6Pc55v3jMlhy9E0KZovrPeh4IFHx3lZ/LkSiRBIZw76
        zhRr8tIg0R7eIhpWTdV7VOYzUky9M3NgY5ci3wEiPPkh12EQ5H9Iqq8MryWsfsC125OUHMPDAle
        5GocqMd1uT/RhqMnb+DCavF434Dz1Q7fy1w==
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr27295617oto.197.1587046843504;
        Thu, 16 Apr 2020 07:20:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypJGq9r+pYJb30wurvfdO/jhQbKwhIAw4iyWBG4DE04/HZAcCHFUgtZxo1ZE1rKFBTawgHFOgl93JR/wLZrTpOo=
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr27295591oto.197.1587046843173;
 Thu, 16 Apr 2020 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200327151941.95619-1-omosnace@redhat.com> <CAHC9VhRJ5Vbz+4S_33PHf-X+3tZ-VhLSSEEJ9kRRTtOoxYnSPQ@mail.gmail.com>
 <CAFqZXNvQ5GTD81E9LZdHFduCuy6gTs6MSqUS4zU4sPTUWtyS1A@mail.gmail.com> <CAHC9VhQD=65CSCFYnPam+R2ZTO_sGKbbh6yyu=smW8Sp8B-3Ew@mail.gmail.com>
In-Reply-To: <CAHC9VhQD=65CSCFYnPam+R2ZTO_sGKbbh6yyu=smW8Sp8B-3Ew@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 16:20:32 +0200
Message-ID: <CAFqZXNtY=CXv777yat4GwEJEKf+9o-MOBYdU1kLpaic83NoN6A@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement new format of filename transitions
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 3:27 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 16, 2020 at 5:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Apr 16, 2020 at 4:23 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Mar 27, 2020 at 11:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Implement a new, more space-efficient way of storing filename
> > > > transitions in the binary policy. The internal structures have already
> > > > been converted to this new representation; this patch just implements
> > > > reading/writing an equivalent represntation from/to the binary policy.
> > > >
> > > > This new format reduces the size of Fedora policy from 7.6 MB to only
> > > > 3.3 MB (with policy optimization enabled in both cases). With the
> > > > unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> > > >
> > > > The time to load policy into kernel is also shorter with the new format.
> > > > On Fedora Rawhide x86_64 it dropped from 157 ms to 106 ms; without the
> > > > unconfined module from 115 ms to 105 ms.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  security/selinux/include/security.h |   3 +-
> > > >  security/selinux/ss/policydb.c      | 212 ++++++++++++++++++++++++----
> > > >  2 files changed, 189 insertions(+), 26 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > > > index d6036c018cf2..b0e02cfe3ce1 100644
> > > > --- a/security/selinux/include/security.h
> > > > +++ b/security/selinux/include/security.h
> > > > @@ -41,10 +41,11 @@
> > > >  #define POLICYDB_VERSION_XPERMS_IOCTL  30
> > > >  #define POLICYDB_VERSION_INFINIBAND            31
> > > >  #define POLICYDB_VERSION_GLBLUB                32
> > > > +#define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transitions */
> > > >
> > > >  /* Range of policy versions we understand*/
> > > >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> > > > -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
> > > > +#define POLICYDB_VERSION_MAX   POcould still help in case of coredump analysisLICYDB_VERSION_COMP_FTRANS
>
> Errant middle mouse clicks are always fun :)

Hehe :) Weird coincidence that it occurred to me just yesterday how
easily I could accidentally paste something embarrassing in a reply
with this lousy touchpad I'm using now... I'm surprised that what
ended up there was actually somewhat insightful :) (I wanted to say
that the filename transition count could be useful if you were
analysing a core dump and looking at the struct values, but later I
changed my mind and removed it.)

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

