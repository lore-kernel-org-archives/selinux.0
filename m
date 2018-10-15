Return-Path: <SRS0=3j4m=M3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37BC71133
	for <selinux@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B672145D
	for <selinux@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds7SRfu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B672145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeJPBZy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:25:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35225 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeJPBZx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Oct 2018 21:25:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id 14so15731722oth.2
        for <selinux@vger.kernel.org>; Mon, 15 Oct 2018 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGkk0vU+yIYxHIntnkhbfwucsbu/6u2c3qxETpGCxBM=;
        b=ds7SRfu7PQqhbjE3EdOpq/oa9TDO6PFPC2snc1iUHRPMoDTo4yHnOer2a2sMmTa0M/
         KHGjiL1VH3tUruiqDKssTbwG6Nc6Wpojq06HMrYqMBiPdoa+fGtNHh15GXfjOIgbpSjT
         jy32LJyD34mzO7le4I1lAdEsIX1/SjzrMHCVfAYFW7iRASB/Ntn3tSotaoL6FBjmE9B3
         WhoWtzckUy2RgVPrgjGPOWwfkDoQ6HKOwaVGs4xtZBgqNrkt6agr27pkUyalPbpn7Ay4
         gzgI1d5g2aYM7x9Mu6slyJfr3vSEK7VCcUUeEVbLeK8Sjtb2yJrQvTug+EQrHlLRcue5
         Xgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGkk0vU+yIYxHIntnkhbfwucsbu/6u2c3qxETpGCxBM=;
        b=OO7IbYkPbQ3sWcHmwXTgva469ZDeHvpUgLAiVrs5e33mj7KiAv9N4mdrdzOSBOOe3D
         NXfb8DtgLC1hyCp9vueSwklFLf1LJX+iZcngssCEAi35EAvNjnPYYnMOUgFhwjHp5mdd
         z1mA7cEMVrgJDpQ0//YfLUMkCwWfneUjd0q/z0qPBweDyIBE+urich4CW6k2b65UJGU+
         +eIJVN4eOegqMoro29Xye79B33dCFHdX03O2ENY1GpXcqY86O+ruo6IKAIQsIMf1I6LD
         0CEgG5wHigK8vTJ9uFZIXz2erqEun5CEkCK/OXoe1m08gUj2NOCr7p/eo0Z9ibmww3qp
         IHGw==
X-Gm-Message-State: ABuFfojgb9g36CrUgO+EAyLtGAwi9ni3S+A2R5pp53/kGh9/+tX2LCJO
        xBko6r54yEjUMZH392iejzOx5VBkn115RJ2+XIINmTcY
X-Google-Smtp-Source: ACcGV63wPGuZJ1JJMQlHCMyb7wz9VtiECefviadoqU1UbjwcOawm0UYsQm5mQrL0FzjaZu/FvPlxdxjmUYAS9OJ4gzc=
X-Received: by 2002:a9d:7006:: with SMTP id k6mr10844216otj.370.1539625180014;
 Mon, 15 Oct 2018 10:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov> <CAFftDdrGknwW3fJCU0+BptuS69qLcuKj+5gTchgkqJapTwjCTw@mail.gmail.com>
In-Reply-To: <CAFftDdrGknwW3fJCU0+BptuS69qLcuKj+5gTchgkqJapTwjCTw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 15 Oct 2018 10:39:28 -0700
Message-ID: <CAFftDdoO498dbqH2jahatPZMtbcORaOQxa1aFSQiNzT+rwkz4A@mail.gmail.com>
Subject: Re: [PATCH 0/4] libsepol: Cleanup initial sid handling when writing
 CIL and policy.conf files
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged:
https://github.com/SELinuxProject/selinux/pull/104
On Thu, Oct 11, 2018 at 4:58 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Oct 11, 2018 at 5:37 AM James Carter <jwcart2@tycho.nsa.gov> wrote:
> >
> > [Resending because I originally only sent these to the new list]
> >
> > - Removes some redundent definitions of initial sid name strings
> > - Adds range checking when looking up an initial sid name string for an index
> > - Adds two new Xen initial sids
> >
> > James Carter (4):
> >   libsepol: Rename kernel_to_common.c stack functions
> >   libsepol: Eliminate initial sid string definitions in module_to_cil.c
> >   libsepol: Check that initial sid indexes are within the valid range
> >   libsepol: Add two new Xen initial SIDs
> >
> >  libsepol/src/kernel_to_cil.c    | 78 +++++++++++++++++++++------------
> >  libsepol/src/kernel_to_common.c | 10 ++---
> >  libsepol/src/kernel_to_common.h | 16 ++++---
> >  libsepol/src/kernel_to_conf.c   | 78 +++++++++++++++++++++------------
> >  libsepol/src/module_to_cil.c    | 78 +++++++++------------------------
> >  5 files changed, 136 insertions(+), 124 deletions(-)
>
> LGTM. I ran these locally and they seemed to be OK and I was able
> to list the new SIDs from the policy db.
>
> I staged them here to have travis run the CI as well:
> https://github.com/SELinuxProject/selinux/pull/104
>
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
