Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D2BC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 09:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351342073D
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 09:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz26h3V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgCDJhW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:37:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728916AbgCDJhW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583314641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAf9bE6LE+CqiNEM9+9PmjOeOu+gOh8CdTOtdC7MHKo=;
        b=gz26h3V8+cfR/fhzq5htM9+GzKmBx5gYaF6TVspMBCp3q2bPxNfMOe3ODg6tV82FiBD0S4
        AXWrYwyqVPw1k3TbpWX02y/kASK6AundEvbLwVLAJ65+qDrPs2g/E1bgiPews2zaau7y5H
        a8geJWAQf9lwrK/fjnYcTKzqBqD3vwU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-nPS_BTTaMi2xhL4UfwUltA-1; Wed, 04 Mar 2020 04:37:19 -0500
X-MC-Unique: nPS_BTTaMi2xhL4UfwUltA-1
Received: by mail-ot1-f70.google.com with SMTP id z13so725847oti.1
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 01:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAf9bE6LE+CqiNEM9+9PmjOeOu+gOh8CdTOtdC7MHKo=;
        b=EjwaEkJgqD2HI7rgyaW8z9iVCJFsU5BF8TgmSMa5lGLlOtJTFsByrte+gAIBIiATcI
         njpLCChsgavuCwKCh54U3A1Ptnm1utzXf6fWc63RKbZlXFxulCDlabEZsApcPiQcsSxQ
         Ikryr5dyVLUtd4kkTj641Zk28StUqoE74wmaxiS6knEPrNf0DNNrNzyiw0kjpsa/HE8T
         9tS+3IVvGgda44db5tCCi/WLMzTMRVBrrVX7O1hpf/3kZOF0lNa/q14M1cL4nNB7xWsm
         IMxyKEKR5jA10eWlbTjlNv7F6jjVYYw0CXqPTf4WTTILpCphih9MaeD1jvwxSUnFEs6S
         /aCA==
X-Gm-Message-State: ANhLgQ0Tulw+o7nBFjBsdUxZoNqhuO3gopem14QACmUIS9uE6RFKhtfJ
        y7iUYwcGSGRcz6QnagnD8qqbh6lhEw5qw6mJR8XRz1ZdUghW+z0R3Z4lZCRx5OXU09Iyb8u2Sd0
        HbphMsOeGgurhzhhiWDvVbcY/FaWdC2J82w==
X-Received: by 2002:aca:4987:: with SMTP id w129mr1150318oia.103.1583314638933;
        Wed, 04 Mar 2020 01:37:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtgkMpUir1dW9rieJrws+Mwu+7SZUMEtvGY6dKDRn0DkRkDHyGGDNJIUdwYodMUeClMplkDU+d+HU5H7HtEDU0=
X-Received: by 2002:aca:4987:: with SMTP id w129mr1150300oia.103.1583314638657;
 Wed, 04 Mar 2020 01:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20200303112910.147788-1-omosnace@redhat.com> <CAEjxPJ591G_wJrEb4dFSfS=DHNYWRWkWwxTqAM=AK1YL3uvN3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ591G_wJrEb4dFSfS=DHNYWRWkWwxTqAM=AK1YL3uvN3g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Mar 2020 10:37:07 +0100
Message-ID: <CAFqZXNs=hayAWPP9cPXtUCnYiwMeTdUoaWxcU=LkEb8+B=_ePg@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up error path in policydb_init()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 8:12 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Mar 3, 2020 at 6:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Commit e0ac568de1fa ("selinux: reduce the use of hard-coded hash sizes")
> > moved symtab initialization out of policydb_init(), but left the cleanup
> > of symtabs from the error path. This patch fixes the oversight.
> >
> > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 7739369f5d9a..00edcd216aaa 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -463,36 +463,28 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> >   */
> >  static int policydb_init(struct policydb *p)
> >  {
> > -       int i, rc;
> > +       int rc;
> >
> >         memset(p, 0, sizeof(*p));
> >
> >         rc = avtab_init(&p->te_avtab);
> >         if (rc)
> > -               goto out;
> > +               return rc;
> >
> >         rc = cond_policydb_init(p);
> >         if (rc)
> > -               goto out;
> > +               return rc;
>
> Looks like avtab_init() and cond_policydb_init() can no longer return
> errors, merely initialize fields to 0/NULL,
> which is already done via the memset above, and are not used anywhere
> else so those can go away entirely?

OK, but that can be done in a separate patch, right? Do you plan to
send it? Anyway, I'd prefer to keep the *_init() functions for the
sake of abstraction - I'd suggest just changing the return type to
void where possible.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

