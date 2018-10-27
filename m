Return-Path: <SRS0=kiZa=NH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B3C46475
	for <selinux@archiver.kernel.org>; Sat, 27 Oct 2018 07:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1220856
	for <selinux@archiver.kernel.org>; Sat, 27 Oct 2018 07:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F1220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeJ0Qg5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:36:57 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34918 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeJ0Qg5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 27 Oct 2018 12:36:57 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3A00F5612D4
        for <selinux@vger.kernel.org>; Sat, 27 Oct 2018 09:56:49 +0200 (CEST)
Received: by mail-oi1-f172.google.com with SMTP id k19-v6so2974744oic.11
        for <selinux@vger.kernel.org>; Sat, 27 Oct 2018 00:56:49 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKX5gHoTMIZkuRrKDhgmYkmajy6Yy5NTTAU7WlKGL7xDkfzzP49
        XueA+lVvATQutW8qfsvoPOvEHEht2QzHOBCzpaY=
X-Google-Smtp-Source: AJdET5f0AZ8QckNzGJN/CBmYvOUdNQDcF0atjfYtBuf0WvNAnwsOMmVlrd/rcdARRtIkWRpptCAYyHng73pth/zngvA=
X-Received: by 2002:aca:5747:: with SMTP id l68-v6mr2586812oib.200.1540627008094;
 Sat, 27 Oct 2018 00:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181025194548.21505-1-nicolas.iooss@m4x.org>
In-Reply-To: <20181025194548.21505-1-nicolas.iooss@m4x.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 27 Oct 2018 09:56:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mo7GiNxq6Tab51psfNgRi11K1SOG_pnZZUZ-aaWmX90Q@mail.gmail.com>
Message-ID: <CAJfZ7=mo7GiNxq6Tab51psfNgRi11K1SOG_pnZZUZ-aaWmX90Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix snprintf truncated error
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct 27 09:56:49 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 25, 2018 at 9:53 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> From: Mr Stid <stidofficiel@gmail.com>
>
> Link: https://github.com/SELinuxProject/selinux/pull/106
> Signed-off-by: StidOfficial <stidofficiel@gmail.com>
> ---
>  libsepol/src/kernel_to_cil.c  | 8 ++++----
>  libsepol/src/kernel_to_conf.c | 8 ++++----
>  libsepol/src/module_to_cil.c  | 4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)

Merged.

