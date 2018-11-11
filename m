Return-Path: <SRS0=1+jG=NW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF5C43441
	for <selinux@archiver.kernel.org>; Sun, 11 Nov 2018 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8533B20869
	for <selinux@archiver.kernel.org>; Sun, 11 Nov 2018 20:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8533B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeKLGi1 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:38:27 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43811 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeKLGi1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Nov 2018 01:38:27 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C834656122B
        for <selinux@vger.kernel.org>; Sun, 11 Nov 2018 21:48:48 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id q1so6249105otk.0
        for <selinux@vger.kernel.org>; Sun, 11 Nov 2018 12:48:48 -0800 (PST)
X-Gm-Message-State: AGRZ1gIaZg0bQ3WmWshOoR769MF1Te3I5BsKaae0MMDl5+xxOkykUYKz
        DE6MQAsX0MARHPmiXqq5sx0tBbQIAieJ4R421U0=
X-Google-Smtp-Source: AJdET5chC/zIs1QPKRSNfG63NOBDNYI8sx9uyQchKA3Nj0yPrq1kcfo05cYLj56cnzUa3B+BuJ6dPcZvHQMu/tZY5W4=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr9535621otj.301.1541969327920;
 Sun, 11 Nov 2018 12:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20181105205710.15548-1-nicolas.iooss@m4x.org> <cd516a2d-1d18-ea4b-ec7b-4180dde81806@tycho.nsa.gov>
In-Reply-To: <cd516a2d-1d18-ea4b-ec7b-4180dde81806@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 11 Nov 2018 21:48:36 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nKi_5o_+Gozt_L4jFsUiUOB4r8mooUHiRKFYOZns7LkQ@mail.gmail.com>
Message-ID: <CAJfZ7=nKi_5o_+Gozt_L4jFsUiUOB4r8mooUHiRKFYOZns7LkQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: selinux_restorecon: fix printf format
 string specifier for uint64_t
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Nov 11 21:48:49 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 6, 2018 at 5:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/5/18 3:57 PM, Nicolas Iooss wrote:
> > fc_count is defined as uint64_t, which needs to be printed with PRIu64
> > (it is "llu" on x86 and "lu" on x86-64). Otherwise, building with
> > 'CC="gcc -m32"' fails with:
> >
> >      selinux_restorecon.c: In function ‘restorecon_sb’:
> >      selinux_restorecon.c:633:26: error: format ‘%lu’ expects argument of
> >      type ‘long unsigned int’, but argument 3 has type ‘uint64_t’ {aka
> >      ‘long long unsigned int’} [-Werror=format=]
> >           fprintf(stdout, "\r%luk", fc_count / STAR_COUNT);
> >                              ~~^
> >                              %llu
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged.

Nicolas

