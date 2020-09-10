Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC1C433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D30208E4
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek8DYZJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgIJVm7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbgIJMhH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 08:37:07 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E726DC061757
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 05:37:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c10so5155295otm.13
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJUXOVqhjqrSfsCFvncUIFvObZY51EUmQxYJowgsTqA=;
        b=ek8DYZJBmA5OhE96HVbmZk2OLmboNNVOlq1cmfvWFNEZKY0QrRhayMHJ+QFBHmpVVh
         88n081a54+YNJt7qz0yG+yOKlNF6DEhYAegwfRJAJPOOge7ON/0lIbk1V91IGlwr/xB6
         o+oI6abula8zqu/fBv5TwT9KBVtXCeH+zibWgHM+7NUev/QJq3+6PBspvSkRj00msW/t
         7CbkBPUO8bjUw4UZXwO5wwsGTpOfjDloPngr9INsxlOFNsh009H7TBCvGwa5L+DnreRq
         WNrE20GLCk83mU+poHiyHODJ11snDhqb8cjCYayT1GH0av2K2cuahWUJ+AFP7Rh3qvOr
         gmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJUXOVqhjqrSfsCFvncUIFvObZY51EUmQxYJowgsTqA=;
        b=BtTGfcIAl5XzUZTrXR7GHd0eIm4ehzyAW3wYX36sSXtVSPCbrq9vsKuK0ypsypZQWv
         Ddvu1TpIFfMgC1hFvpCsRBrZyE+SwtqQQfqj0vCmsXtWlvvD50Oj5dVAeYqjCo4Suv70
         uUuGQFKlgWrzvTJDIPfRURXVBdYhDjC04REU0VrERgBdHknwASOdZN7rFxvUXIvyA5Nj
         Yi2RtATkOdQd4auVqLOdfufElGLUZHtCRsPqzQsOVD6BcUUZkJt+SIsYh05XrjR1hwjh
         fWwY0MjjN/emJanfwdsj9F4reSmVN3mK/uEUfVzVJEQCAyq0oeBF2l9F2QzlgaIuGiLc
         7CYg==
X-Gm-Message-State: AOAM530VgYVsqpPruOyUIjWwe6bhjaJx/gIzuXqgd4egFiDGTs1ymaRN
        eog94JEfEaoL1VgUtMA/M3K7Lx22GgvOFJ8XUpw=
X-Google-Smtp-Source: ABdhPJwW4QA4AjV8t5+QSWWsiC8wOzhrGwbTu+hGScylLRFyFD7Nu7/FyksiqsyZJ3s2boL176DwSwnVt6D7jDGHeQ0=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr3550871otn.89.1599741420802;
 Thu, 10 Sep 2020 05:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200909205712.282373-1-jwcart2@gmail.com>
In-Reply-To: <20200909205712.282373-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 10 Sep 2020 08:36:50 -0400
Message-ID: <CAEjxPJ7S82TPnwtdab7n+EG7mBH6oU6PJMAK_9T9GOK5tXB2Xw@mail.gmail.com>
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

On Wed, Sep 9, 2020 at 4:57 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of constraint expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries with constraint expressions exceeding
> the max depth to be created.
>
> Validate the constraint expression using the same logic that is used
> when reading the binary policy. This includes checking the depth of the
> the expression.
>
> Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
