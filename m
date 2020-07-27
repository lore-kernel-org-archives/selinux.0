Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFDEC433E1
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE9B2078A
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLt26K6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgG0Nn6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgG0Nn6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 09:43:58 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507BC061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 06:43:58 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w17so14355036oie.6
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UADuZX6ICy0SJ0yfYbf8LJW0QtriRFb9GmySQxEhHKA=;
        b=GLt26K6/pkcdhgq6DbRM3v4TweYz7nceP9par9238TV6/E2/mI3eQ6cQzNZgoQ23g2
         treQsIAnqzCoV5PMa3/wZoEjwU9BcS0hzkJejmUqYxNBMi8WssvjBTbDKijCGYUppkFW
         a8GrttAKwT07JKI/U5QCYaKOzNzt5dbJIMi/5uB3PnHVAK9AW4G6+ouzUGTF4JScznpB
         EPooPh5ytF+ReykGxGHkWzB+WrH3dsGikzbfQjF1gv1mNCpIaCn7fv017IhiCPXQMH3P
         oKDt3iI9CB3lma8oCFDg5+F1S4aZ/HrJPDBDZWI+tQGo2D1yIlOHonL35yGbOleN8et+
         zNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UADuZX6ICy0SJ0yfYbf8LJW0QtriRFb9GmySQxEhHKA=;
        b=UkVo55mkkkl48j01YEfiStQ/bW9dQp2jfvGShK6dQty6lWB2Sl4HNo1rACBxqBW7yL
         U6n7vypbqZtmUJwp9Jk2m1gAYK7qSP33t760b11KH5/JfXNr+abf1dERKUMynhq3Ci2i
         UEtjtuNxn8EVIXcT5MUM1ToQrnVgnIkLpZYY5kVeXQbwoPpP3NEFCn+lL9uH6Gx/5GWl
         D5gQ1UwV1uHwtIWDTHxzRsPZOY7gygBTIzMCFE+O2zJ1H9Oryt6OULXwRv0NAVIhoNkZ
         xWYLYB4qUewopwpBOhA/bd+/qRz2Q1tGufs0e619touJPwD8WcwHlNY47eAMBRyHfOgF
         sBDA==
X-Gm-Message-State: AOAM532TlZa4CDipLAwc6BkO2LE/jq33LqY3PPRLqGEerUhIXdWv8JtY
        CWwMUy8zQNrRkPT+ypqVuHNJPJXvsXRwzkTpEYQR7g==
X-Google-Smtp-Source: ABdhPJw+JvyL99CTc+CSdPlr2mgjaFxX/WtbE4079Zi28oKEL9jacYQRXwY0dA0VBMBBJrQD361oUQOSTeigKQ2s8iY=
X-Received: by 2002:a54:4001:: with SMTP id x1mr9221396oie.140.1595857438057;
 Mon, 27 Jul 2020 06:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6twZempmDtTBQjUxs_x9PJr5eQf1aSLJ1a6OpM_1eR=g@mail.gmail.com>
 <20200723075008.2256123-1-dominick.grift@defensec.nl> <CAEjxPJ49ieRSuPcTzu=J_ZiKXYSP42bOtHJhVhmvK9htR6R51g@mail.gmail.com>
In-Reply-To: <CAEjxPJ49ieRSuPcTzu=J_ZiKXYSP42bOtHJhVhmvK9htR6R51g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Jul 2020 09:43:47 -0400
Message-ID: <CAEjxPJ7R0au42cBnx2onBOHRtJm6husvC28zU0RBPkVEt6Lqyw@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v9] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 23, 2020 at 8:00 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2020 at 3:51 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > Elaborate on labeling. Touch on the significance of the default stateme=
nt, on various av permissions related to labeling using the libselinux API,=
 and on how the kernel and unlabeled initial security identifiers are used =
to address labeling challenges in special cases such as initialization and =
failover respectively.
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
