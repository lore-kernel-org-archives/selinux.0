Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63132C3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A9F2073D
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCXxhvw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCENqH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:46:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgCENqH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 08:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583415966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49JoyJRS5P4qQIAq9KenVktKpkLkr4hvCy1S9SC5hEM=;
        b=ZCXxhvw0xgqj2drNSzJsB+9rr26YOCqXa54/gRJ8EbpqtMZ/X0JGyHnFcSTPu2X0Zlc634
        mwp8DEaKepvGkqxLF6ciZnJ4bUco6zd9PeI8fnWlkbFV7oEIl/YZPggohAsVOXMYxuN5GK
        jcfkClqls0Gc2//eLcKAOJUmTdURCAI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-bIwS9kjoN5Sf4uth6ev4AA-1; Thu, 05 Mar 2020 08:46:02 -0500
X-MC-Unique: bIwS9kjoN5Sf4uth6ev4AA-1
Received: by mail-oi1-f198.google.com with SMTP id m66so2875697oig.13
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 05:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49JoyJRS5P4qQIAq9KenVktKpkLkr4hvCy1S9SC5hEM=;
        b=XNiprOwZXafAyYjlEvNYX+D7pe7JedOTyK4C9ByE0HqF8OL8vFaesMIBppQ2CCXL4M
         /s6vCPJtEZ4lL+Jeb9MHAxKoJ4KLNCpuOQgtg4+ZKyOJ64Pln7/187uOov3qGBFU6feh
         VxVKkABH9VPOrrgAEe+dBbaW5tyoxLUTjqJzxgrv+zOjLwEGvuIre7tC8ce6lThwwlpe
         vLDIcArS8Tbt2tbYCyWP88ndHuF4l8aFKA6sUprWaLGsYLa/cVK+Aw27IufFBlyFpMBu
         reDUaK9zrd/sxaAJOm85J/Si0ZhLyAyXZoQvYjw6HpPgYRr8ZQfHafv19FSfAhcUB2dV
         249g==
X-Gm-Message-State: ANhLgQ1+ZcPLSWQNC/b8oD/gJHn04VighqUWMDQRZLxUIfFK9ue9sUBd
        hGmg70zIgK+K8wVd+P8EiiDkMMl4jdS+gcT27DTfr4g8Joef9FZC6MfeCq9iDKjil6CKPMYbP2n
        ji55hmPpSChwgQqNDdxel4GEu4eaZF5z1XA==
X-Received: by 2002:aca:488a:: with SMTP id v132mr5734420oia.166.1583415962182;
        Thu, 05 Mar 2020 05:46:02 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtqomnzBjQhqcwml4mx9WmSAuiQ/Gg1YwWvntWMSX95y2okCzkS8ijjQUa9IzungL8WX5XEhyYKgkVAXS2YoZU=
X-Received: by 2002:aca:488a:: with SMTP id v132mr5734397oia.166.1583415961852;
 Thu, 05 Mar 2020 05:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
 <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
 <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
 <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com>
 <CAFqZXNub7i2OyqWqU2snePw+XBfJxauh-0n2zgZy_q58sZovSw@mail.gmail.com>
 <CAFqZXNunTQfLAc7JAfZyvynPS0s=ADK0fbT1rXrcUCsMiDk9HA@mail.gmail.com>
 <CAEjxPJ5-nzostsGnca1OcVT9hm6XWP9F1ceFCU3--RAzLHXERQ@mail.gmail.com> <CAP+JOzR4YKKaNw8FwF85OJfSny40tRWVu8iEJsmEx41-nHF9aQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR4YKKaNw8FwF85OJfSny40tRWVu8iEJsmEx41-nHF9aQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Mar 2020 14:45:50 +0100
Message-ID: <CAFqZXNu5213oJ_cxy7+abmOJwtxNZGbg9cJLE50NxhGrZ3ZpiA@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     James Carter <jwcart2@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 4:32 PM James Carter <jwcart2@gmail.com> wrote:
> On Wed, Mar 4, 2020 at 9:25 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Mar 4, 2020 at 4:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > I played with this a bit by recompiling the local binary policy with
> > > secilc and then comparing the CIL of both binary policies (I used this
> > > script [1]) and the results are a bit confusing... There is no
> > > difference in result between -X 0 and -X 1 [2] and in both cases it
> > > removes some unused attributes (those are only referenced from
> > > neverallow rules) that were in the original policy
> > > (/etc/selinux/targeted/policy/policy.31 from my Fedora 31 machine),
> > > but not in the one recompiled via checkpolicy -C + secilc... At least
> > > I was able to confirm that secilc -X 2 really removes the attributes
> > > that have only one type and reduces the policy size by a few
> > > kilobytes.
> > >
> > > I suspect that the reason for the unremoved attributes in the policy
> > > built by semodule are due to a bug in libsepol: It seems that when it
> > > starts with a cildb that has the neverallow rules in the input policy
> > > + has disable_neverallow set, it removes the rules but not the
> > > attributes that are used only in them. Only when it reads the policy
> > > again, it identifies these unused attributes (since there are no
> > > longer any neverallow rules in the input) and removes them
> > > unconditionally. It could be something else, but if I'm right then I
> > > think libsepol should be fixed to remove the unused attributes right
> > > away. I don't dare digging into the CIL code to investigate it, though
> > > ;)
> >
> > James will have to confirm the details but IIRC we had to keep
> > attributes in the policy
> > when they are referenced by a neverallow in order to avoid breaking
> > Android because
> > it uses the attribute definition from the policy as part of CTS
> > validation of OEM policies
> > (it extracts the neverallows from the AOSP policy, extracts the binary
> > policy from the device,
> > and checks the neverallows against the device policy).
> >
>
> Steve is correct, we keep attributes that appear in neverallow rules
> to avoid breaking Android. We also keep attributes that appear in
> typeattributesets for attributes that appear in neverallow rules.
>
> See commits 67b410e80f0917bf1b378997cac0dddf1e6406f7 (libsepol/cil:
> Keep attributes used by generated attributes in neverallow rules) and
> 0be23c3f15fdbef35a57d8586aeeae9b1f7606cc (libsepol/cil: Add ability to
> expand some attributes in binary policy) for more details.

OK, so it is actually expected behavior. Fortunately bumping the
attrs_expand_size to 2 doesn't interfere with this logic (I compared
the binary policies produced by semodule -B with and without the patch
[1] and the neverallow-only attributes were not removed).

[1] https://patchwork.kernel.org/patch/11419703/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

