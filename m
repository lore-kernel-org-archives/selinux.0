Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF80C433DF
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0084206D4
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 13:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hh9NGfiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgG1NTk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgG1NTk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 09:19:40 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C174DC0619D2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 06:19:39 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q13so3216191vsn.9
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xf5P/odmkgL8jAtLIwR4kpxkzfJosOHK2CtNcgZH52U=;
        b=hh9NGfiDDpUg0lpNIyG0dMEobS9F5dXzIJ5zMChctPBaTnvfcXgTiZfvTdmy7Khko/
         HpsUregT2Ie0RS3kMd+uPtMx1HmmPl6TScWYp72B3G7NU6kACyRRGcv+r4bZ06I1V7VT
         JoJLF3xAczhJGwN8xUzkHoX4zi0fcPyDHSqaTk4FZPHvy08E9tmorIay6fdd8QN3mi9W
         PLZS6PppIJWoDit4YEKDNeo2v/ksdvp+Q68CumQMKKJyTUuVvQcSV+uq2wmmj6lHdNQo
         qcf8gJilXrPKrpEJhMVhFoDKRx6FCQZpcJKfzsHb4wjtucmCNlQFL0YSlQ64U3av3Cpw
         NkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xf5P/odmkgL8jAtLIwR4kpxkzfJosOHK2CtNcgZH52U=;
        b=CERW7kMAje8sr+nrVZIS23kmzPrmjdzEldLf2VJF7/cpLhKpmU6GvPDOtEdoe61oRZ
         +OMD7cDHpsy9dvd0+xUxfGv0PfVqGBilFqGq+L7/VziJkUtBJQMYR+ILlptO5+T0xS5l
         w/CQJkcrUGgLoT5UJzQjpq2CZVoAeYNPJRIk2QeyBWkmtN+fUTHejiyAJZYO2w0CwyNL
         POy8L9q/lyDHN625ZeK6ekuMuW7PgDpj/s/ZgeSzEJuudSxR+2B/po/JGhjOSZehTf12
         TrvkBXSa92VIRl0B8xlcj6HYhiSs9SYbKky4GN+o5ZsITbSQj6zqPx1nG30QFimbmHW8
         kUlA==
X-Gm-Message-State: AOAM530DZM2kS+GAEVWHnUxwo71rDaBuV0bW7mZF8//mTr1tieLcnNey
        hrXHnuWDd+SUpn7CZorncQHpXRjnYpddY/CFkultWg==
X-Google-Smtp-Source: ABdhPJyK1/rVSvn5crwvdhr04UOiWloeL7snkGyENYPyomngl8UgqU+FLf91d/V9QIYZmWwQDsa02dxVja/BrxlMyz0=
X-Received: by 2002:a67:db97:: with SMTP id f23mr20209738vsk.135.1595942378550;
 Tue, 28 Jul 2020 06:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com> <1859cc5b-2fb0-432b-2635-35ce79dbc244@gmail.com>
In-Reply-To: <1859cc5b-2fb0-432b-2635-35ce79dbc244@gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 28 Jul 2020 15:19:21 +0200
Message-ID: <CA+zpnLcYbYp3y6RF70mVfAWQj4bL106n-g-EbufUdd-xk3hOng@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 3:04 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Ok, also please use unsigned int for the fields and %u for the cls value.

Will do in v3. Thanks.
