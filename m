Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415CC433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8801B20722
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 19:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhczPggS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICTmQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTmN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 15:42:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA825C061244
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 12:42:12 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x69so1322868oia.8
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPrDoOa1tf5OtHwIaebWRkJPwH3JW4W22ZJO1QrCKls=;
        b=bhczPggScCKWFx/BjurHnetqlDIo21pRRn3FiyO2r3A70M90fUkzRsCT8hrLsjsAZD
         0h7LUXDDbRtUaoKH+HFaWEW2W/ujkV/lKdrijUgQYusQmda1MWYuP8lgqcit+SG9EcHq
         tZRqOg4imNLVZVt9ZjzSCXlO1R7GqNaBs0Mp+CqqnMw56U2JZvCfz3iDeuOBkxct6FFg
         tJFJN6IrUL2uXn6BRSr4vMiI0qYhECfeq1IebGDYvFZhGTkS5u0lQXxlKwLb0Wo2ioxC
         aLddeKWhuuEn2nZrcyIWVEDogRmMcgU5Z+6rmmPPLEs/LZmRsgLBtBzr2fXQBdIwYtVZ
         CFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPrDoOa1tf5OtHwIaebWRkJPwH3JW4W22ZJO1QrCKls=;
        b=dhs6qyFGhjbC3ZILS/33Pca7LX5ifIHMzrapwdEd/f8ip3xjanhCVKUZ/GTr7IaXAr
         9pNGvY3Rcktz/+RBogSr5W5gZY5cCqr+WP1YHBr33IHbPh2Y9nSa45i62C6OJXEsMeIv
         qnboomjrrDEHUTqQRz1MB/n30lDirYV8LjtQsqZ32dB+UhZL7Qkp0hSHh6+arKBn+ojb
         ewpF2K87LNNtyVZKFcYb7V2q9RRTY7vK1pu9OQkD1Ba7UN6kfSquKFjolWhOxctNseTX
         j/NFOmD0M4lhYDJnjDuiZ6OXIAILm/lMvkk/MIDD7lkSjzaw8fAWlpfu3XDMkEn95dNU
         9Sgg==
X-Gm-Message-State: AOAM531E/LI5k7ThBi8aMgRDNmz/N0ob+IX7AAPScEtuyCW6GAp7IPZy
        8Y7A6473NYRFT1IVGr9YWPVyrTyH7VmB4D/FUkBaTDLO
X-Google-Smtp-Source: ABdhPJzjSvvHBQ561e7X4Wg7nIJYx4eBX/vv1Pk6DWGFI2etAE1ynF7BcSXdGSKTaiW92IOLtu5aLa28obsB7UCAqWA=
X-Received: by 2002:aca:4007:: with SMTP id n7mr2971919oia.160.1599162131867;
 Thu, 03 Sep 2020 12:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com>
In-Reply-To: <20200903181900.81179-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 3 Sep 2020 15:42:00 -0400
Message-ID: <CAEjxPJ4VYKom3-tFeuErzJGWZMD-E8j0D39rsu9xjsM3BLTrNg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of constraint expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries with constraint expressions exceeding
> the max depth to be created.
>
> Correctly calculate the depth of constraint expressions when building
> the AST and give an error when the max depth is exceeded.

Does a similar bug exist for conditional boolean expression depth checking?
