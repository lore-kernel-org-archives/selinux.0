Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD01C2D0F7
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8780920740
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofqc1vlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgELT6A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELT57 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 15:57:59 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622FC061A0C
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:57:59 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x16so2982952oop.13
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMB8l6+vLGenBmtxlND4Gu6muq258ij+v8r3ZECnnsg=;
        b=Ofqc1vlqoYuRAsLqkPLixlXseDDS/YPHcnMZghsXkSOTbrWdBjIM9q/vUIe82D5jc6
         bCI17KfdzxDo+uARytIMAgnrEEnXFNPUwD/tIGE4J+WBKgIVg7O304V18ISAdKiOBssz
         ZIjYRCUeIZKkvnqZ0D0wQ22OhPYLK++o/ulB1rrRP3vd7UtKlJ/Z/YMTG7Kd6S5/FjKx
         vUPkEHnVPjlFSb8CeBjc1Dkm7Wo0H6lLCIcuOC0AwCPgSvS1rODNfjtkn9stWI/j+h2L
         Z0SEa9wcMvkuHyIiu+cpsA9JSWJtY3N1KkD3EIqdsa/IjWM1k947iC6YxTcPnNHYqDa6
         dlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMB8l6+vLGenBmtxlND4Gu6muq258ij+v8r3ZECnnsg=;
        b=oDX/CQwWxkEzokkMewBBzOR6zDMMKKz3kDxHuvOJqGRB13gSGzW1MP+ly65lVNYVCr
         2XFuVc5noMzM+NnEpiYf3bfW1ed0+wsu3OsV+9uN8VNn4+TgZnf9XHXTxtUKz7VUh44X
         6Qxh62fyENxg22rYLUkHxQ8ypaSs5fxXK/Imj6uwAllgb2IvqqTqhp5kNM9oa0Qz6fyS
         TbcPwAHZoQiMH0jjNBRn71O2hR55UyQHXP3+wZe9eR7G6sfdaqPLZJWAuAdCeQKI5hjW
         3HsDZ4F8M7VLY7zJZ/3NJ1AK4X7ab6hBIFs9hrrfpx1tHDaSBOv66CIQO1155jlflLXx
         o3hQ==
X-Gm-Message-State: AGi0PuaILNIvE1KZcvuibnceAb62OVOOlngsKLaQFjUShWndbGH7G9DI
        cNXbmjXvprjm6EhCiA1QNb0HGxmmdfs7hnGtVDQ=
X-Google-Smtp-Source: APiQypIJc5HUJ5dM4J5tOP/mu1M88931JFaZFiyaaglh8YM4omCeA0I3DarRkbft9Ph9n8TdKcOHAsg6fEKNI9im/D8=
X-Received: by 2002:a4a:b78f:: with SMTP id a15mr19426442oop.59.1589313479340;
 Tue, 12 May 2020 12:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <20200511122703.GA26404@workstation>
 <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
 <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com>
 <CAEjxPJ7Px-LkZPGk_Oe=G6HZP_Yu1a=nWDBPc6i=oNOMf0nG9A@mail.gmail.com>
 <CAP+JOzTX3tFUAeheUUDB4br+nLhqCUP+EPY_XuTugDoqpwNGVg@mail.gmail.com>
 <20200512171605.GK108209@workstation> <CAEjxPJ7f-N7uOOjcrYUJe73-WaikP40O=ibi43tYbsiJ6M1m7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7f-N7uOOjcrYUJe73-WaikP40O=ibi43tYbsiJ6M1m7Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 May 2020 15:57:48 -0400
Message-ID: <CAP+JOzQyqeQBXOaaV-W3c9FLJ9TzroVHMs7LY2Dn8LyonXT1HQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 12, 2020 at 1:27 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>


> I think we should revert the change prior to release since it breaks
> selinux userspace.

This has been reverted.
Jim
