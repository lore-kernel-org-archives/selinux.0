Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0394C1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9544120674
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVW1/NdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQSW0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:22:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35117 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQSW0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 14:22:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id k26so22794346otr.2
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHLCja27S7bNYLo2HhdFgb/SeRvWjuB+OzdYfuwTS2c=;
        b=tVW1/NdSKvgOmUjK4DcQn4Srhi/54Dr1pxaquv47jO10YioQyW7nii0s7+4WPb3MbH
         KSUa4GTrVMxbUxU4mYlR4XE81jPRS6E1Ayc1yLPpDmjqlLMyw6B903xstbqFOK+eC1cV
         EzRgRdlPHRn6/eKteJS6PJsuj5sQuXlUVYahWYFJAShGlolgxhUNGDbpSX2GkzR/2bTP
         ffRFpBzpKPGt9vsH9J/RHSq28ZutdpMgMPJbw7NYSptl/rS5djZQUBlgAM0QgCcLaQt8
         LTfY7San7kPZvDD48CohEprg477tmRYzdkDOyPmgXO9o49nZqBdJXwAXB25oQsLqj5p9
         GYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHLCja27S7bNYLo2HhdFgb/SeRvWjuB+OzdYfuwTS2c=;
        b=V3nccsRvoZm9R/suEgR/vzh8gupdWvSDjU7IXLE4u1NxOmhJdCsKeN8Nhr7q2lgM5z
         +Wltifrl9HFSKeigyB1Li/O4JBIzMFjRFD+8dXialTyY+wb6XbEic5JCkMJNf2xs+K26
         myD7kz9DgOX4lo7ccFjRQSY9KFQCh/3hz411KbQUgSl/HXGTgnZiq9T0rZ8UNIeolOKa
         6jF23M/clgKtCqOduwfE998YK3s22OgpUELx0tTMbWonz4nl47/hJErnFMtTuXOGCxBX
         vyHn+qc9aKku6tWW+Vh5zLWgILZNNEsOEafULWLv4aWMBA3Fb/PDo1YbY04WmO5uTZYg
         t/Hw==
X-Gm-Message-State: ANhLgQ2R+Xh4Vhc7zqb2JXd2VK22MR52WHqUF5TFc/xle6diR2TRWSww
        G2fw7fkvPWAWpTJvWqf2XHFyMwu4RuqjtEhw60Y=
X-Google-Smtp-Source: ADFU+vv+nD3l8NKbu4OFoSX+4HgaCOBMv9CaqY8dwjn5MCgfH7nb1g5/oNVLLMY2ZQoGBa2obRxx5w70YDr2WOtNtDk=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr478142otl.135.1584469343684;
 Tue, 17 Mar 2020 11:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-3-omosnace@redhat.com>
In-Reply-To: <20200227160257.340737-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 17 Mar 2020 14:22:12 -0400
Message-ID: <CAEjxPJ7cduc9M41JsCQMi60T6-jq+ijR7epjOjmK6UtoHh7ipA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: optimize inner loop in build_type_map()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Only attributes can be a superset of another attribute, so we can skip
> non-attributes right away.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
