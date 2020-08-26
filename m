Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DCC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C21214F1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr7uKhJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgHZMxl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgHZMxk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:53:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F9C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 05:53:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id e6so1398989oii.4
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tKNQ2dyiNeDduBl3W2Y9ANY1OXQS3QABwpWyECaMLlI=;
        b=rr7uKhJuF29Yjj4caCaetQ5OzCTYF56TQ1BF03mIS/YM/I4/6Jp+MuvzoFlJmV4/Zw
         CMzaGBQOFUrD0kw8NtiUIHrJFThdaqE8kY4H2+KRfS68o7DyK+pRU2Kr4gZyHwd2h43O
         0XatVFN3UBrF7RcXc0xjZy7RCx1d04Hu3hIIQPL2TWdHwdDwE5XMo7hLPMPGCoiFOWtM
         Q8Kw2X0jYRvl/qNHf7av8KRzJVe8E2SoTs2uhWkwDNnViKU0r1wywhf9P6XfXiSOq47z
         O5D8cFCYhDt5hkFzJumRCRHLFY4roPY+wuDi0ypYTqOQTGfULwz7uIg/UIp/uiVkYTed
         DCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tKNQ2dyiNeDduBl3W2Y9ANY1OXQS3QABwpWyECaMLlI=;
        b=rfWNJlkdGQGHcM4/vRrR73pzOPw8hlFfoO9FOS81mJnXVuKJ7h0811hUvHGp8mQ67B
         Ri7Ehj4fr3lYd/f/cJZSISyxG3riXYPXt/VsKQ52YPwFADms/12+wT5OWz0sm9jTiB35
         rKkO+nfCMPAuvFSyOxaBgXqC+v5xhQnSJYObaUZIVBe4vMyLhR9WkyO6Ki/k1dFOAUju
         cccSoHG9ZtWA/08i3Mda9d1wWTo4/iPUHNs4Mj3SyanBGTEqyCRJ7nv2i8jW3tnI44iP
         DvwCaXN4qSYCn3Yfk1CNnTGyHDkfNcKIJhEL6E53za/l4kLCHnfqPRbmr/EowWdtvi4O
         yXcw==
X-Gm-Message-State: AOAM5300bJCVYItVY5l+uADSX9qtl9amVHjs07CvARdyHtH2ZgjAzaIp
        5x7oOBQFLtS3cpQ+HzE0nJJ2VB/B/5K8McdqGEr4EKFo
X-Google-Smtp-Source: ABdhPJxhuR9UWiBERcG52t/sQ1wJNJNkXOsdevn16vqWmOGxEikS9lqEM43mT9ftquSTt6eMdvES1ZvtI6SnTkxL+ag=
X-Received: by 2002:a54:4817:: with SMTP id j23mr3804387oij.140.1598446420051;
 Wed, 26 Aug 2020 05:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200824131841.55687-1-cgzones@googlemail.com>
 <20200825153205.224136-1-cgzones@googlemail.com> <20200825153205.224136-3-cgzones@googlemail.com>
In-Reply-To: <20200825153205.224136-3-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 08:53:29 -0400
Message-ID: <CAEjxPJ5_hjhGBj+Wd1wiqAohendnXogvZHT+WmKRGBuNRpVxrA@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 11:32 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> If not initialized to the current policyload count, an enforcing change
> will trigger policyload-callbacks in selinux_status_updated().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
