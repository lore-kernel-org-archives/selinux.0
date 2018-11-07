Return-Path: <SRS0=WkJB=NS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D9C0044C
	for <selinux@archiver.kernel.org>; Wed,  7 Nov 2018 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6E2081D
	for <selinux@archiver.kernel.org>; Wed,  7 Nov 2018 20:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF6E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeKHGL6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:11:58 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:53101 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKHGL6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Nov 2018 01:11:58 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 800095600B8
        for <selinux@vger.kernel.org>; Wed,  7 Nov 2018 21:39:52 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id 192-v6so14250993oii.6
        for <selinux@vger.kernel.org>; Wed, 07 Nov 2018 12:39:52 -0800 (PST)
X-Gm-Message-State: AGRZ1gKSxHCpoD6JAdQfFmJPyXTk+KBtr7DVk/tyZSV21l1LPFelYvH8
        8ZACuNR3eY2BIM9OyA22IgNUiMfS5vh2N6e9viY=
X-Google-Smtp-Source: AJdET5dge5J77jl3rUzjzDir5K8rhi9+XEbrbApgTpbaHTfzQihphL3z/elrQUJUezNVk1c3aIOIpWomN1Iws1bPXoc=
X-Received: by 2002:aca:db05:: with SMTP id s5-v6mr1109899oig.173.1541623191451;
 Wed, 07 Nov 2018 12:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20181105210001.31499-1-nicolas.iooss@m4x.org> <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
 <ac49729e-3125-9e0d-36d3-a839ce552339@tycho.nsa.gov>
In-Reply-To: <ac49729e-3125-9e0d-36d3-a839ce552339@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 7 Nov 2018 21:39:39 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mjowLxSb70MACUN+-8kq_nMDGxsk0WO56pb3R0+P3+2A@mail.gmail.com>
Message-ID: <CAJfZ7=mjowLxSb70MACUN+-8kq_nMDGxsk0WO56pb3R0+P3+2A@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: mark permissive types when loading a binary policy
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Nov  7 21:39:53 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 6, 2018 at 8:19 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>
> On 11/6/18 11:22 AM, Stephen Smalley wrote:
> > On 11/5/18 4:00 PM, Nicolas Iooss wrote:
> >> When using checkpolicy to read a binary policy, permissive types are not
> >> written in the output file. In order to reproduce this issue, a test
> >> policy can be written from minimal.cil with the following commands:
> >>
> >>      $ cd secilc/test/
> >>      $ cp minimum.cil my_policy.cil
> >>      $ echo '(typepermissive TYPE)' >> my_policy.cil
> >>      $ secilc my_policy.cil
> >>      $ checkpolicy -bC -o /dev/stdout policy.31
> >>
> >>      # There is no "(typepermissive TYPE)" in checkpolicy output.
> >>
> >> This is because TYPE_FLAGS_PERMISSIVE is added to typdatum->flags only
> >> when loading a module, which uses the permissive flag in the type
> >> properties. A kernel policy defines permissive types in a dedicated
> >> bitmap, which gets loaded as p->permissive_map before the types are
> >> loaded. Use this bitmap to mark permissive types in the loaded policy.
> >>
> >> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
> > Or we could directly use the permissive_map in kernel_to_cil/kernel_to_conf?
>
> I think that this is the more natural way to do it.
> Jim

I agree. Please drop my patch and keep yours.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

