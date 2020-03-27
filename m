Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAC5C43331
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6899D206F1
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DskPs/gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgC0OqZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:46:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46312 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0OqY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 10:46:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id 111so9916032oth.13
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2020 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3RmEWWM3SAvzUGv3Z9VddkhedeNbWLz66KhpLkdbI4=;
        b=DskPs/gZ9x1R2NHgS+K5pNzushhafSANP8pKQYTyYVkKfr+ua2tkuURadXHT359zoD
         xXjgEa4jXpPstySzTlOdX8cM/7TFHhrsic5ogXNvYaeocdQrU+tuidkrpcTDHLjczrSl
         MZxJ83zvQ00ZeShKrDH92JJfCtagqpfmfcLMlPh1/6sIUo/DEanYNbiiHiBkplmhFgML
         aFP6EMSs7ne+CRmW0sXOby3+yvhE4oIJ9sh0qQfsdkF09rkjs4BwbZNvgLPbxL72SWBg
         zNdYvQwdYwx5uSmcKlkSSYrZfkpRzNQhxjhduMzBEbKy1Kxn+vQFzuGlvXM9LQ/3p33s
         lFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3RmEWWM3SAvzUGv3Z9VddkhedeNbWLz66KhpLkdbI4=;
        b=C8o5+giEhigwBCStV6/6yiQ9iI6UQ1z9nGcs86r4yE6U69jmtBa25nFRiIXLFiM7tD
         UnW9IgIeBxFpatV31F8HHL/n+iJ6SL4WYlSLusSu5wnKmbhNMrvrCcUxh0c/KKtp+oEt
         hdfDOAQOwymmL7yffzVtS5XE6buZHQhUq0dg+WZoAxtjpU7Uto2L/NeuKbgqL7BxS6S8
         hNOi0YZ8tZpJqPDHgHaHnkIs8ccFsONIHXa6FbpiTfr2jXeakOc55VMZCfTyyulghUDm
         2olbpgT7aZkM2z0mvedWkpsMIYoQ6VU7XutMrh8ScEUkELtjBTZxgayqLOVDuM1IXVV6
         O4jg==
X-Gm-Message-State: ANhLgQ3DRm72/fHQxOG4VxnOiBDFFR79AtgEQqIv0uTNfI0GGf8v01H9
        Pn8JmJX+f4Xa6bQpWTVFmAJrxhipblS/ba7J7r8=
X-Google-Smtp-Source: ADFU+vvF9ZGy9UYz8ITa+6og+uuhfxQHy23IB674YzdpOHbExty4YMJGYE9Bi+FLteJTiryhGbwzDHk+zj06sj1vQYY=
X-Received: by 2002:a05:6830:1f39:: with SMTP id e25mr10698253oth.135.1585320382526;
 Fri, 27 Mar 2020 07:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
 <20200326154641.7253-1-william.c.roberts@intel.com> <CAFftDdp8Us2aSmAD5Q+MR3y6WvR2QAbC+_tFGmCwZbWh+0CBTA@mail.gmail.com>
 <CAGB+Vh5P-VKru1-ztYRBe4sr7OdeOpAzATGEBHkj6Q6i6s3mYw@mail.gmail.com>
 <CAFftDdqqjgCBgN+LsV0d0ejHz5mBhuMgLhCHankaCDexFFEY2A@mail.gmail.com> <CAFftDdrLuq3Dg+jgB=xW8e+r6WE1qB3iQrpAmLFDta2K+aUP4Q@mail.gmail.com>
In-Reply-To: <CAFftDdrLuq3Dg+jgB=xW8e+r6WE1qB3iQrpAmLFDta2K+aUP4Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 27 Mar 2020 10:47:33 -0400
Message-ID: <CAEjxPJ4HX05X=25Ose1v2jKdS8hqzPUJJaRXo9XX=inZ4Yh2oA@mail.gmail.com>
Subject: Re: cil: Fix DISABLE_SYMVER support and drop last dso.h
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 27, 2020 at 10:27 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 11:18 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > > > Josh can you run this on Mac build, I don't have one anymore.
> > > >
> > >
> > > LGTM
> > >
> > > Acked-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > Thanks!
> >
> > Staged: https://github.com/SELinuxProject/selinux/pull/214
> >
> > Will merge tomorrow afternoon unless I hear otherwise.
> Merged: https://github.com/SELinuxProject/selinux/pull/214

Please remember to update patchwork (status -> Accepted) when you merge a patch.
