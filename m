Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E051C2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164E0214AF
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="phxPS6bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442870AbgDPQAT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895463AbgDPN1T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 09:27:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B14C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 06:27:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s3so1271144eji.6
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAKzqvw7vv9JE2PV8DY5yoSpBciLQBl11C0rYudAw/Q=;
        b=phxPS6bSb0jLj0fwDJf3itMXmrIUOVB8yTLduHk5uWRfq5sREy5/kbVjgj5rLwFFjx
         WJw4lBijV7yB8jiNzUnlWAbXZD+MoNKM4brWhIQj6OENKylG2BRpFdalKjcjiJ7gRHWr
         Dan4Ij4/o5j2hk54Fbe27AxCs4aBeK8t0DX+puhqad383UKD4XaDuIIGwrT4twBK+l6g
         gRyS1Npgk7VHQ97i4rEtadsI2AwWLRnxXFt4yUXREGjKRP233tMCV9443fm4nzvv76l+
         DFDAsHuFQjYWjndm77ownfeZOchwpufhu9C+iHyLClIYmZDFi+Dl+bL37wccvtBQch29
         h6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAKzqvw7vv9JE2PV8DY5yoSpBciLQBl11C0rYudAw/Q=;
        b=m/RSF+2GGk3576oe6yemX9I2GVOnj+Y8l8Sz84pGQwDVhz9YGEaUkp3F9HyBKPdBu8
         CGHvj8wn3Z+K57qqw/VlwDkytFi37pZOKObTz6anZ2GsgYRgobLHV9eVXS8y2WCUvCMI
         9Pebj8wWuP8XVJhptdthaAVEtdoXikvEnhJpI330vLIxa76g8AMw0JUiiZ5X+Sq+3lsb
         W6Q4EHofN5TNZWATHwlAfSoOiI9eSYHWVsuoM4SVx0NfTfc1hQ0xIEVVl/6rpNnAQbvT
         1j2fmKn7G976mwFkAzU4Wug6Dfv6Vq4yWOc+qJKNVVooRQTB/R0Kc6geSunmC/B+EnPY
         9+Jg==
X-Gm-Message-State: AGi0PuaLoZfkHUNyqaLxiphZmZtx8P7RODNPDLT7Cgzn4SNwPt/YQiHn
        dlOgXTtLnk7+9BthazvPpjCUpMdmkBjGSoamaDii
X-Google-Smtp-Source: APiQypLpCHZn13YHeMXrqy81BO2RkCwcFewH1e4diCu9eoLebtBGmZvtnqWows8IYaX5sCltvnBYoM7TU7sAFPXUAnA=
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr10092432ejb.272.1587043637330;
 Thu, 16 Apr 2020 06:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200327151941.95619-1-omosnace@redhat.com> <CAHC9VhRJ5Vbz+4S_33PHf-X+3tZ-VhLSSEEJ9kRRTtOoxYnSPQ@mail.gmail.com>
 <CAFqZXNvQ5GTD81E9LZdHFduCuy6gTs6MSqUS4zU4sPTUWtyS1A@mail.gmail.com>
In-Reply-To: <CAFqZXNvQ5GTD81E9LZdHFduCuy6gTs6MSqUS4zU4sPTUWtyS1A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Apr 2020 09:27:06 -0400
Message-ID: <CAHC9VhQD=65CSCFYnPam+R2ZTO_sGKbbh6yyu=smW8Sp8B-3Ew@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement new format of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 5:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Apr 16, 2020 at 4:23 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Mar 27, 2020 at 11:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Implement a new, more space-efficient way of storing filename
> > > transitions in the binary policy. The internal structures have already
> > > been converted to this new representation; this patch just implements
> > > reading/writing an equivalent represntation from/to the binary policy.
> > >
> > > This new format reduces the size of Fedora policy from 7.6 MB to only
> > > 3.3 MB (with policy optimization enabled in both cases). With the
> > > unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> > >
> > > The time to load policy into kernel is also shorter with the new format.
> > > On Fedora Rawhide x86_64 it dropped from 157 ms to 106 ms; without the
> > > unconfined module from 115 ms to 105 ms.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/include/security.h |   3 +-
> > >  security/selinux/ss/policydb.c      | 212 ++++++++++++++++++++++++----
> > >  2 files changed, 189 insertions(+), 26 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > > index d6036c018cf2..b0e02cfe3ce1 100644
> > > --- a/security/selinux/include/security.h
> > > +++ b/security/selinux/include/security.h
> > > @@ -41,10 +41,11 @@
> > >  #define POLICYDB_VERSION_XPERMS_IOCTL  30
> > >  #define POLICYDB_VERSION_INFINIBAND            31
> > >  #define POLICYDB_VERSION_GLBLUB                32
> > > +#define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transitions */
> > >
> > >  /* Range of policy versions we understand*/
> > >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> > > -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
> > > +#define POLICYDB_VERSION_MAX   POcould still help in case of coredump analysisLICYDB_VERSION_COMP_FTRANS

Errant middle mouse clicks are always fun :)

> > > +{
> > > +       struct filename_trans_key *ft = NULL;
> > > +       struct filename_trans_datum **dst, *datum, *first = NULL;
> > > +       char *name = NULL;
> > > +       u32 len, ttype, tclass, ndatum, i;
> > > +       __le32 buf[3];
> > > +       int rc;
> > > +
> > > +       /* length of the path component string */
> > > +       rc = next_entry(buf, fp, sizeof(u32));
> > > +       if (rc)
> > > +               return rc;
> > > +       len = le32_to_cpu(buf[0]);
> > > +
> > > +       /* path component string */
> > > +       rc = str_read(&name, GFP_KERNEL, fp, len);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       rc = next_entry(buf, fp, sizeof(u32) * 3);
> > > +       if (rc)
> > > +               goto out;
> > > +
> > > +       ttype = le32_to_cpu(buf[0]);
> > > +       tclass = le32_to_cpu(buf[1]);
> > > +
> > > +       rc = ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
> > > +       if (rc)
> > > +               goto out;
> >
> > Should we move the p->filename_trans_ttypes update to the bottom of
> > the function where we increment filename_trans_count?
>
> I think it doesn't matter in practice, since on error the whole
> policydb is just thrown away anyway, but I agree it fits there a
> little better.

Yes, it shouldn't matter purely from a functional perspective, but
from a human perspective it helps reinforce the link between those two
variables in the code and if something were to ever change in the
caller's error handling this function would be less likely to break.

> Also, looking at the filename_trans_count increment, it should be
> adding 'ndatum' instead of just 1 to match what the compat path puts
> there. (Again this doesn't matter in practice, since the policyvers
> will always stay the same and nothing will use that value, but it
> should still be consistent.)

Sounds like a good change to me.

-- 
paul moore
www.paul-moore.com
