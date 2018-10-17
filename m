Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A67ECDE32
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C282150C
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKVUaVd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C282150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQXaj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:30:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37812 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJQXai (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Oct 2018 19:30:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so21424481oib.4
        for <selinux@vger.kernel.org>; Wed, 17 Oct 2018 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oG3rJvZBtDIrXNdmKbe0tzhZcyirIA0BBBTsJEJTJ18=;
        b=sKVUaVd4+G1ZEG07tOyXcge2yOwG4S3MvrzcMw9XxbNpqGTUakkcEEpnBLWVp3A8zY
         AfJX7knQIpDbTyKG2lfEOM7Jp5DKUCRuz0fkXf15W6SLFN79QYXTMBH17Cz4gGX71k9E
         u8a4Q8ZivnAi+oEGxXNK0++fznOiwXQwhQ61CoZ2QVSPvwXmUJwyk4k+3+73Ia0Q4rk0
         I2STXmEb93B0b+LDFXS0mBpCMHDlUsF19MG9HNtVtiryRDQAutNGiTGoAb/46xJ8Leou
         okQDkukR8EMD5eiNcK+PVK8kAKTCPOa237U+mRCtrUupvRVP8dt6+K0ucQWXJJXm6Au5
         Q+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oG3rJvZBtDIrXNdmKbe0tzhZcyirIA0BBBTsJEJTJ18=;
        b=GZBRyCrPFsz46GqPOEvS06HbgIsLJW378yisPxrSakLmKOCsnW6qD9Lot/nVMu1Kwk
         0xpMpc9t0hqHAvudjAPOMEi/X9VMQ7vuQ8ehDf6o3/+3Ogweo20y/cxwi/B023gdSEJq
         AB8ZIGwiIZdzPqtfqMMyo5Cy07KwfYylAxDZGcIO2BplAzsDFv/xX49BV1I1dxBO/xyD
         ZH9EpFiyWGOzUAQtXrI0hISHK+j6wVvMx1T8/p8KTSe33YL5VEjOKWZG7IuukUrZklhp
         vBKiEvDEVRkzpO/e5NhErsV2eJ3jtEVuonZZwhvBKC2IZVSN5WT3fAF0F7ldFl3Vvko0
         fQFg==
X-Gm-Message-State: ABuFfogeFKpHG4MDu6dHWEy22+K7eIUuP7c2n6mHcJlGuOm7Vhw9LOIx
        ZTdRRQMjedm5OYPl90t67Qepym9WcnshfWANx94=
X-Google-Smtp-Source: ACcGV631FroeyQHWAlmX8lSbdd9z+Q0mX4aPlsN8rGMxP5jPGGVBL0E4D7gVqA6PpJ0+2MRpPwEcP2lEw3UYMtCNnWM=
X-Received: by 2002:aca:3b42:: with SMTP id i63-v6mr13301118oia.312.1539790463559;
 Wed, 17 Oct 2018 08:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181017144659.10960-1-omosnace@redhat.com> <61a96080-4427-bb24-9cdd-ef52a181f665@tycho.nsa.gov>
In-Reply-To: <61a96080-4427-bb24-9cdd-ef52a181f665@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 17 Oct 2018 08:34:11 -0700
Message-ID: <CAFftDdrm0QzpC9fWqzZ6v-qL7zO--K0FsVOpGHvNJ3qHfggCng@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 17, 2018 at 8:30 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 10/17/2018 10:46 AM, Ondrej Mosnacek wrote:
> > We need to convert from little-endian before dong range checks on the
> > ibpkey port numbers, otherwise we would be checking a wrong value.
> >
> > Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Stephen,
Ill stage this as a PR. Do you want to wait until the kernel changes
are in or just
the normal 24 hours?

Bill

>
> > ---
> >   libsepol/src/policydb.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index a6d76ca3..dc201e2f 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                               break;
> >                       case OCON_IBPKEY:
> >                               rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> > -                             if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
> > +                             if (rc < 0)
> >                                       return -1;
> >
> > +                             c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
> > +                             c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> > +
> > +                             if (c->u.ibpkey.low_pkey  > 0xffff ||
> > +                                 c->u.ibpkey.high_pkey > 0xffff)
> > +                                     return -1;
> > +
> > +                             /* we want c->u.ibpkey.subnet_prefix in network
> > +                              * (big-endian) order, just memcpy it */
> >                               memcpy(&c->u.ibpkey.subnet_prefix, buf,
> >                                      sizeof(c->u.ibpkey.subnet_prefix)); >
> > -                             c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> > -                             c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> > -
> >                               if (context_read_and_validate
> >                                   (&c->context[0], p, fp))
> >                                       return -1;
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
