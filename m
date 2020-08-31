Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CEC433E7
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2FB20707
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFuPG8Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHaOZx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHaOZw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 10:25:52 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0E8C061573
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:25:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z22so1127574oid.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e3sS1f/vhS31UXj+6sy/XX6x02XUwf0a9IYwpIH7rmE=;
        b=MFuPG8Kxsxjqn7BSy70jNXdOl4zFVo8eZmhemOXapyoKnzZwsauX/hQMjVzoNmbt7E
         jne7KTPyYkzrdsvA1KN7DIeg02Wp3x5GiHTAyRs5V2fEjQC670HJymgYzFn6H4rZNBtv
         pbbPWvvZ5ipj9AlGynzeguwkIcza4D6gMqX4X9Uov42Xg3Nx83PgN8dP3e8ZH8EYcVfG
         PF2fYpJbjN2loACZXoCTXq47CVaj7iR5WHNLHEAwkf1/WDabdrGreKZFF/k0bzqFYFmB
         6fqhs7tGNtGQvm0JwImU9v35NZJ50YJtPAQawuxsAoosp6lPOedgDuTOTeCRYxRm9TBL
         CVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e3sS1f/vhS31UXj+6sy/XX6x02XUwf0a9IYwpIH7rmE=;
        b=HOlAY3Q8ra6JlNHREsmslzgB5XPVKkAjvy8r6Aozn2cN6puuaK3wJ07HtBZIbJvSKN
         5eLcxfMFEdv+Qbwws32Vpyk/LuTksLqF+oP2ZlEuW2yxfB3Pr1EgGbLxyywqhPmYvIS7
         IiQwUgeNtg23ECn2loDyVsQcmk/ZfJTcy+0i/d+N1w062L8gxlhEqkO7edjKMsBw4oUn
         ITK/9xzpl03y+JAhIa+64PN9O/7Yhjpv6ZDu9vQybVrabZH3Z3c6pL1o4P5M1TEnwNl8
         qOhWk6x0axqQFjCgmzV4D93TCjH9D+JtVpN4vJ+tB/bOgxSDZnCM6d4HowmeiV/RyvL8
         aB9Q==
X-Gm-Message-State: AOAM533DYpPc5drXQCKt6CI9RdSgMXmbTy1JQZ4tI3nuR/EdpQe6Xsqw
        gXGC5zdUtiAcfnN2QVb12+ZI7+lCqSQ11sGCIaU=
X-Google-Smtp-Source: ABdhPJzuhvatEbMQVlfsYolXMfRWHQQ8dAdAov9HUG+bjq0H9Ft2UaMVsM+qwNFvQwi3xm4h3JgMk7Yj0bP0JPgA3lI=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr849802oih.92.1598883951447;
 Mon, 31 Aug 2020 07:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200824131841.55687-1-cgzones@googlemail.com>
 <20200825153205.224136-1-cgzones@googlemail.com> <20200825153205.224136-3-cgzones@googlemail.com>
 <CAEjxPJ5_hjhGBj+Wd1wiqAohendnXogvZHT+WmKRGBuNRpVxrA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5_hjhGBj+Wd1wiqAohendnXogvZHT+WmKRGBuNRpVxrA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 10:25:40 -0400
Message-ID: <CAEjxPJ5Hqaw4Tb9UJkoaBtZMDVw8yim2LQoRr6sfZvO6hf8wTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: initialize last_policyload in selinux_status_open()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 8:53 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 11:32 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > If not initialized to the current policyload count, an enforcing change
> > will trigger policyload-callbacks in selinux_status_updated().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Both applied.
