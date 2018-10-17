Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3EECDE3B
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 22:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7544A21473
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 22:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBAZaoaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7544A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJRGCx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:02:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44322 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRGCx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 02:02:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so22374428oia.11
        for <selinux@vger.kernel.org>; Wed, 17 Oct 2018 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lne8UnwUVMEsZOActOzijWS1zFkcxFS5kQbgOFtIvvQ=;
        b=vBAZaoaPKYnAtWE1Ox6bEMbmOYQju5ds9WG9BSvFl3SSgSgNC7XbRqyHEYGsPmZfNA
         sG5iyvCGXbbLN7vdeTDD1bEJnF0HBcqYzKLK7P/1EBgWWyTm15v0ZxFi5qdarvG4eTJG
         xutgcF0LOzwSlIGohrpZwfo8QLxgBnbo0vji/8FWmnBibcWz571agqL8QIwZm6dMHlnS
         EEwuyDiRJz1SD7cbPPG+RIBLd9Nq3zrqiS4MmMxjY57zNwl1/IRnG7I83vLfMOf7pxki
         Tzz+l0j5uAseWasZQSD8WB+7gEkDpnVmmMYsObNl3JWhOyP6WVlrFNafNi8Ct7suY9Rd
         BG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lne8UnwUVMEsZOActOzijWS1zFkcxFS5kQbgOFtIvvQ=;
        b=dPhSMMNwQxaGYn61nlSgAU14YTUjjYFjzws1q75ye6wLAVT3gEqvSJECTS9+px/DNR
         JS+TUuluxQKVvas6ovgmLCEvRW62LLpy7R77oxlScVHX55KzDDT7AqpnhQSg7jTkqRRS
         walKbQpjpiPOJ5CmII/mYXgdXc559N/7O/YLMGBX7jkcx6/1fr+oStLTexLgx8h1O4RD
         VQTsBqwr1hmWxUMA0mCXthXC7ixIFSFMRTommthZFDCtr4mL1jDTeqrDiHgnwpnpnaIo
         F2z+bkSTLtp0PyUbQS33Mkfzbm4uamSWXphdlsSc//9p8TiDdYnEw7z7KG61eHiTqcBD
         mhKg==
X-Gm-Message-State: ABuFfoj4HQJbTmJkZocd7ETIQhVjtiiljrUZFcedjSJ1kMfpVLW1Nwq4
        mYjQgX/R9wcoQgZggfv1BfEQ/PZlKEC/ZAFll78=
X-Google-Smtp-Source: ACcGV60lFtcZcmZLO6yGXW5fVVaHYyf3cR7nixwTvrnh9jLKX8RJPzKhJn3XKKSWUIzWru8ndnfIfOlhVu0COLjYxok=
X-Received: by 2002:aca:59c4:: with SMTP id n187-v6mr14056169oib.279.1539813911639;
 Wed, 17 Oct 2018 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181017144659.10960-1-omosnace@redhat.com> <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
 <CAHC9VhT_npm4ix7kmN8GOOxUp8z7ySz0Z6LLKqd0VOMJPKcibA@mail.gmail.com> <ae98be54-7bcd-b501-a1ff-b9ab0ae3aa95@tycho.nsa.gov>
In-Reply-To: <ae98be54-7bcd-b501-a1ff-b9ab0ae3aa95@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 17 Oct 2018 15:05:00 -0700
Message-ID: <CAFftDdqsDxYh=QrBXhtsgnRhwSR42KGKjU+Ry_8Ygq+0kc-W4A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 17, 2018 at 2:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 10/17/2018 05:18 PM, Paul Moore wrote:
> > On Wed, Oct 17, 2018 at 12:07 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> >> On Wed, Oct 17, 2018 at 7:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >>>
> >>> We need to convert from little-endian before dong range checks on the
> >>> ibpkey port numbers, otherwise we would be checking a wrong value.
> >>>
> >>> Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
> >>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >>> ---
> >>>   libsepol/src/policydb.c | 14 ++++++++++----
> >>>   1 file changed, 10 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> >>> index a6d76ca3..dc201e2f 100644
> >>> --- a/libsepol/src/policydb.c
> >>> +++ b/libsepol/src/policydb.c
> >>> @@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >>>                                  break;
> >>>                          case OCON_IBPKEY:
> >>>                                  rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> >>> -                               if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
> >>> +                               if (rc < 0)
> >>>                                          return -1;
> >>>
> >>> +                               c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
> >>> +                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> >>
> >> Ahh you're assigning a 32 bit value to a 16 bit variable low|high_pkey. I think
> >> you need to assign them to a uint32_t if you want to actually range check them.
> >
> > If you can, give me a chance to look over the kernel changes first.  I
> > doubt I'll see anything objectionable given the review the patches
> > have already seen, but one never knows.
>
> The kernel patch has the same bug, so it will also need a re-spin.  Good
> catch.

Don't thank me, thank GCC and Travis. This compiled on my local machine
and ran the test suite just fine. I had clang set up, I guess this re-iterates
the need and benefit of Travis testing in different environments.

>
> >
> >>> +
> >>> +                               if (c->u.ibpkey.low_pkey  > 0xffff ||
> >>> +                                   c->u.ibpkey.high_pkey > 0xffff)
> >>> +                                       return -1;
> >>> +
> >>> +                               /* we want c->u.ibpkey.subnet_prefix in network
> >>> +                                * (big-endian) order, just memcpy it */
> >>>                                  memcpy(&c->u.ibpkey.subnet_prefix, buf,
> >>>                                         sizeof(c->u.ibpkey.subnet_prefix));
> >>>
> >>> -                               c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> >>> -                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> >>> -
> >>>                                  if (context_read_and_validate
> >>>                                      (&c->context[0], p, fp))
> >>>                                          return -1;
> >>> --
> >>> 2.17.2
> >>>
> >> See job: https://travis-ci.org/SELinuxProject/selinux/jobs/442750208
> >>
> >> Build fail with gcc:
> >>
> >> policydb.c:2839:31: error: comparison is always false due to limited
> >> range of data type [-Werror=type-limits]
> >>       if (c->u.ibpkey.low_pkey  > 0xffff ||
> >>                                 ^
> >> policydb.c:2840:31: error: comparison is always false due to limited
> >> range of data type [-Werror=type-limits]
> >>           c->u.ibpkey.high_pkey > 0xffff)
> >
> >
> >
>
