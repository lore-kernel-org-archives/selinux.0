Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067A6C433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE17205ED
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hghD4EcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgEMPxL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPxL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:53:11 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E411C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 08:53:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id x5so9470324ioh.6
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7mHcvEO3JlA8nqJZtXchOByRYB/n5+h9VpIH7v0yIY=;
        b=hghD4EcUjJ4iBxUVtMFiJKMyFJnIpunVNR/opeKihfVvDkthFGe4x905SW9R4JAgYL
         6+FI/P+Tm4DYODPgbJnocz+hPjlb2cjRRbRfNDiJk/6za6fte1TVmOVuWTFaKajclBdQ
         cgpGnlEacECHUwWYbk6e7FOmPg7n85e3aZwD7ZasyuOvYpI4pjWGTyJ9A5HwxM9u8meR
         y1y/UVyRSf/SnhMj4cAdU2ApFRAf1sSEEvHUnMlidN9mlJvhPqWkUL7mFigN1NgHvbK3
         FNSK7K3fIPFtVsT9QX3PZvVyw0WtMs6vPaf9kcRpq+i/3vggNMEdaF6PuD2XinzCmCoi
         6lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7mHcvEO3JlA8nqJZtXchOByRYB/n5+h9VpIH7v0yIY=;
        b=NUYHL8H98YTRTBYJXkDvrm7TwHIoIv8wsqNsVfRDhg02xQfZDBa43IeybT2hzfBfGR
         KgLQGdsFJUqgO7uq5faXi11LPTevJfSC5NzAvLqSoGjcAXflDoeDri8ZQCDW+Az1UU9x
         hh/a9phqZJjwcgiQDaoPQKT2hEjUXOfdu54m72h4+14UuJwNfGs27+bxEFulU5C/YKGS
         9meco/5ICMBsadkjN3846PaxBN5aFsjwps0/mk/KoisItIKHfvdpFTX88TcFnwGJaL14
         QEpZlFBh/K+dez76kPcgjr/KUJ3d9b9OXXQesXtKhRsidtEv7U/yxpmZMJ/+3RZkARX2
         w0PA==
X-Gm-Message-State: AGi0PuYNe9AFBUMEHAuIKo038q5EVFecAKTJWp2RR4orwVd6anyDrSC5
        /cJVHDYXEmrxJT4oUfwjMGzGGeGeiK6JmW70ISI=
X-Google-Smtp-Source: APiQypK0KvhyVqxHfUG8KRXJmRgAy1XwYZRDLArupEjaowbYDWoY2trlzt5rKhLUQTuLrTTBLVyHPc+z5xSujWibS04=
X-Received: by 2002:a02:cce6:: with SMTP id l6mr212139jaq.116.1589385190349;
 Wed, 13 May 2020 08:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <6f2dc066-1f5b-1ea8-be48-73ae2b977b44@gmail.com> <20200513151202.GA184264@workstation>
In-Reply-To: <20200513151202.GA184264@workstation>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 13 May 2020 10:52:58 -0500
Message-ID: <CAFftDdqx_dVeT4yw9zFNfhpMfrurv8FATFQWBsV21cyLA6PSoQ@mail.gmail.com>
Subject: Re: [PATCH] mcstransd: fix memory leak in new_context_str
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux <selinux@vger.kernel.org>, bauen1 <j2468h@googlemail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 10:13 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Tue, May 12, 2020 at 07:52:54PM +0200, bauen1 wrote:
> > The return value of context_new needs to be free with context_free.
> >
> > Signed-off-by: bauen1 <j2468h@gmail.com>
> > Acked-by: William Roberts <william.c.roberts@intel.com>
>
> Applied.

I updated the state to accepted in Patchwork

>
> > ---
> >  mcstrans/src/mcstrans.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> > index 96bdbdff..2116b161 100644
> > --- a/mcstrans/src/mcstrans.c
> > +++ b/mcstrans/src/mcstrans.c
> > @@ -919,6 +919,7 @@ new_context_str(const security_context_t incon, const char *range) {
> >       }
> >       context_range_set(con, range);
> >       rcon = strdup(context_str(con));
> > +     context_free(con);
> >       if (!rcon) {
> >               goto exit;
> >       }
>
> --
> ()  ascii ribbon campaign - against html e-mail
> /\  www.asciiribbon.org   - against proprietary attachments
