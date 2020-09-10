Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C54C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5459208E4
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2X6gJDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgIJVm7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgIJMiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 08:38:10 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63324C061573
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 05:38:03 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id y25so1398956oog.4
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+Pyuww+297Elmt16F2LvHC9BOkXwqlKoSNCcxtr598=;
        b=r2X6gJDS6sgLKkUmGywFRQvATVE17ImJxE/Tz0XtOBhmL5FgC6zjFgrTZZvZRGozBD
         KjnZxZlqgsR046khVLbj68H4DR35Vyu9lkYtNS2zL2quj31aPMGoYyFhZSsMBwYLxO1/
         JIHsv2ttY2u1Bw+QXC06hiPMikNyOUCEWzDU1sc77qvt6h5E6/OpyXblnS3youl7LcWS
         HdTvP2PFR2fF3c5M9K0n9+CS8n6RmJ0H87gMCj/khsBa8gsZqj5sjqusiSAYV247NJWL
         leb8L2ihyPel24I7oFfEfXmlOh2Bf9ViW9Xj8S38wx8UOQaZNGmO+IrQKjsYHIXCE/Fp
         E7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+Pyuww+297Elmt16F2LvHC9BOkXwqlKoSNCcxtr598=;
        b=lJB710u66pg0Xs5XLhHVDoYf1CrzJHR+J5YCcUPKCQn5q35hrC2X4nF32gTGIQsvX8
         0+QFBStexZFEjzlXONThrVL3vVHB2sZgNu+4aQ9gBHVup0di5BPKIErKQQzVQdv14pme
         ThDzn2iDXIMcJMS8IMnO+t09LyesxPWUxRQ3YlX2TW8G3OeAyySNhUXW90cAj3aj8O9Q
         kVBUqSoGNoMgwcWlgzM0YPJBs/cPzNFehaU8DtI4M6bl0QsyANtSMbl1gfe8WpQNXssJ
         V72NhZ6ZC650lImP6TG4iNSIy1Mouy3wouakKteE/NmGcBGmLN4g5VyIPD1Nn80I6YKZ
         DHVA==
X-Gm-Message-State: AOAM5319T5FTioo2NBjYPa6OtPAgG7oCxir0uaQSNyL0GTno8ksdx/ST
        WSKdiuXi09dvrtRQbKbXIJyXfctq8sONIdj0eJM=
X-Google-Smtp-Source: ABdhPJyQr0jN7hrwjFvzG2DebAZl7kEVx/GzLHGu7CecC8tnnyGck11bJ/r9nLXx+IjPSZuhS1AczmLDLZMhotlCw0c=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr4267907ooq.13.1599741482565;
 Thu, 10 Sep 2020 05:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200909205702.282311-1-jwcart2@gmail.com>
In-Reply-To: <20200909205702.282311-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 10 Sep 2020 08:37:51 -0400
Message-ID: <CAEjxPJ6nTgnJhYoi8gwpRTsku50pMfqaDTg44fcZfCbfCoGfNQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Validate conditional expressions before
 adding to binary policy
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 4:58 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of conditional expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries to be created.
>
> Validate the conditional expression using the same logic that is used
> when evaluating a conditional expression. This includes checking the
> depth of the expression.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
