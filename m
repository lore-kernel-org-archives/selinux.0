Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF1C46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 19:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6D02075D
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 19:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6D02075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeJXD2B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:28:01 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46189 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbeJXD2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 23:28:01 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6C3B6564909
        for <selinux@vger.kernel.org>; Tue, 23 Oct 2018 20:55:05 +0200 (CEST)
Received: by mail-oi1-f171.google.com with SMTP id w81-v6so2003726oiw.9
        for <selinux@vger.kernel.org>; Tue, 23 Oct 2018 11:55:05 -0700 (PDT)
X-Gm-Message-State: ABuFfohKAbPLb0qzV1LWBWlv5h9fCGVtA66EWJnF+fOz8NFyXtoFOTN8
        bCjRqzYvI5e+ZLUhgPJu0/poisH4OXaN5lspdGI=
X-Google-Smtp-Source: ACcGV63xp4FoejRklPl9w5albS1yjP0Nf0YUxDiphv22FxezWsYVVBaxSjgO5AQWqiMk14uw4XvATvLSExwijfU/fio=
X-Received: by 2002:aca:75d4:: with SMTP id q203-v6mr28352818oic.334.1540320904305;
 Tue, 23 Oct 2018 11:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFWMVF3+Agy_98zPCUEuNWAT=K9a9nx0SWKJFZRRn1VY1Jw9eA@mail.gmail.com>
In-Reply-To: <CAFWMVF3+Agy_98zPCUEuNWAT=K9a9nx0SWKJFZRRn1VY1Jw9eA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 23 Oct 2018 20:54:52 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==mz4c+ooEz-LOY_hw+muqpchwJ1Nmk2jRXr36Wu7hQnw@mail.gmail.com>
Message-ID: <CAJfZ7==mz4c+ooEz-LOY_hw+muqpchwJ1Nmk2jRXr36Wu7hQnw@mail.gmail.com>
Subject: Re: Fix snprintf truncated error
To:     stidofficiel@gmail.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Oct 23 20:55:05 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Oct 21, 2018 at 9:22 PM Mr Stid <stidofficiel@gmail.com> wrote:
>
> Hi,
>
> You can see my pull request on :
> https://github.com/SELinuxProject/selinux/pull/106 for fix some
> snprintf errors.

Hello,
We prefer to review patches which are sent inline (for example with
"git send-email"), as it makes email review easier. Anyway your patch
looks good but it lacks a Signed-Off-By line (as I already said in a
GitHub comment). Could you please submit a patch with it, or update
your Pull Request by force-pushing a commit with a line such as this
one?

    Signed-Off-By: Mr Stid <stidofficiel@gmail.com>

If you have trouble sending patches by email, I will forward it from
the GitHub PR to the mailing list once you have updated it.

Thanks,
Nicolas

