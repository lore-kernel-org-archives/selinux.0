Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83391C433E2
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C24720732
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM3w9Txj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgINRg6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgINM1S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 08:27:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C211C061A32
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 05:25:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so14657551otw.3
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POMfP86YB5WSfYuw2OT5Xv3cQhXd4h8NpiTeACat8hw=;
        b=PM3w9TxjZIBpqVg2EspOT5HmB726kCZ59n7PSDT4aiza0yHzrixnnRH6uA67F9XSoR
         3dtnlr0OZyFrroVupUYiVFRQE2TVDJr7ds7zvuo80GK+IP5MFhYSTkF4xSXglOV3g+Xl
         WoteObLOdi5gtE1PZwC6B7OlrapApB+6gNznV0WqXpjWD5wuWFcuPaS5mA2Rdbe8ukuL
         v+oXSeNzER6fg9syghQjthejI8Q8sdBiDbQCXSdOaOlNZsAypwPQUmUetkXM11Sc3uG2
         oYf2vuxqAFBc0YCLK6OASz5blbsKmGEH+apMoY/E9PCLB3loUVb2ext/jt8vfmY6Ji9v
         ktIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POMfP86YB5WSfYuw2OT5Xv3cQhXd4h8NpiTeACat8hw=;
        b=KeN1fa3jPQ81mud30qWdE99WfIDGV8ftJRse1w3Yxny9zKFnnAbfdrynCaopZq/9ns
         KlpKidJCE26ZQ5IoorCR91hVvXYI7ndoZ9LDhlo/YldUrQmy1BWUm7MqyMog8deFPGyl
         9yUxZWjzfWCOyHkGNHDAZGaigHL01OYVUPXoS6dv9Y8o85LC3MFl6vkFXCGLV3oS7A1I
         gHv0jq3UGZ1zM2+kswgpzZ2sW7IlCwdoX5re1LpPGqFJG8b2qH/YMU7f1e9yt8juNgRd
         0g+RKlKoqlQ9UA8rfNxiM+Cn2QyfR5mRIGh7nnfk1WNh8RPN4baKxo6EWQG/RG9Lre1m
         grXw==
X-Gm-Message-State: AOAM530sJdWwCA4VPPN1Hl720LepXTjf1VmPpg/0u7kAd240dabzbxqE
        z7swvmzWebQSX0zuZo9xaPOoC7CVlcP4SvHkKOs=
X-Google-Smtp-Source: ABdhPJx7DSyeqtCNYTQnGQOIF01bwifWTc2MPZRoLN4doTfEQlRoMEbxnih1yzGakDPvd8ghyz/pECwj9DrRdt4V11Y=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr8596935otn.89.1600086313196;
 Mon, 14 Sep 2020 05:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200909205712.282373-1-jwcart2@gmail.com> <CAEjxPJ7S82TPnwtdab7n+EG7mBH6oU6PJMAK_9T9GOK5tXB2Xw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7S82TPnwtdab7n+EG7mBH6oU6PJMAK_9T9GOK5tXB2Xw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 14 Sep 2020 08:25:02 -0400
Message-ID: <CAEjxPJ4zNzcwn35q8ij_4qZ_jw5Jcv6cb_J3fUqYt7hpLR-m=Q@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Validate constraint expressions before
 adding to binary policy
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 8:36 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 4:57 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL was not correctly determining the depth of constraint expressions
> > which prevented it from giving an error when the max depth was exceeded.
> > This allowed invalid policy binaries with constraint expressions exceeding
> > the max depth to be created.
> >
> > Validate the constraint expression using the same logic that is used
> > when reading the binary policy. This includes checking the depth of the
> > the expression.
> >
> > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
