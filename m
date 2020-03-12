Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D94C10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB11206E2
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXcC3Yce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCLUVp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:21:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40788 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLUVp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 16:21:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id y71so6901972oia.7
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzEybKn5WspPB2NflLyMSjLsOnkj34W+ouhmFP1k1d0=;
        b=gXcC3YceR0A8sSlu+Xlctlu9BkLUrna2s8wNMjjaszV2emaA9NY4q8ymwP2kUr8EUj
         G0ztCqDK7MQiOCzAQI/Bg/BN1h/x9Bvfz8NWpBL9KPHWfJVnz9VRXuqjW3Au1XtdZMr1
         0vC+5R9Z5tApuO7aKTR41rUp4lxPaeHElUIsdyKqltfZTQ4eBRRR/sVXb1m7bk+MD5AD
         NFaJhJDxxMYro4og+qBjNeTjdJ8aUobjeHZhvABtKOKuZZ1syeOIRp5n2ff6AGvWAT6u
         9i0F1uzs6oSafJxj1wx0VYfKUArwFIs9Ud0XRNZY/sURVC27gUHhjriCssEgJ7I+qUHW
         LgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzEybKn5WspPB2NflLyMSjLsOnkj34W+ouhmFP1k1d0=;
        b=o6a2QixRljQrio+A9RZPVs15tU2HiTlGWpBydqDNVt8hbzSYpE2+FUhhU13J2s7xqY
         DeTTNjgnG96QJFiy0YKl3cr+EJgrvQDRSTTcZ1+qgjUd+Eek2FiRSOlO+icjjEknKH2p
         BVWYJyBJ0FPULPq0Cu+QD1uvVwkVWAJ1vkCyhTH1qnMM1htSzQgHZ6ELhcuUoEmEibIG
         E296tP6EMW3544aVSJMe4ivETS1rwL7yQ1P8rzf39hpVv+CFjJfWhaO1wwbu8OkxcK28
         wSddQnebeoVrzJAuofW5PHo340VO3R8Y5x5oZHBHAWWNr7A8OYoN2BW0wprGDnNEvLXm
         b8ew==
X-Gm-Message-State: ANhLgQ39Aqx6cgbF/5AxrNajlMmKzZq8428OC6J9UYiWj6BS1VDTVygs
        hjbaG88shKIZrbaD9oSh7QHDXJDUNh6Cg9AKgwM=
X-Google-Smtp-Source: ADFU+vvpqe8p8XtF4cQb6+M3dtC9MVuJ8Q38A1jgIcYlrPiLgQql5H6lcha2derYECf3Rz6p/mK63WvLRc3qBv4HBhE=
X-Received: by 2002:aca:b803:: with SMTP id i3mr2312096oif.92.1584044503616;
 Thu, 12 Mar 2020 13:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com> <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
In-Reply-To: <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 12 Mar 2020 16:22:38 -0400
Message-ID: <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 9:59 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> I will fix the subject and add the Fixes: #165 to the commit when I
> stage them if thats ok?

Fixes both 165 and 204 IIUC because the real underlying issue for both was the
fact that he was building with LTO and it was doing the wrong thing
with hidden_def/hidden_proto.
Otherwise works for me.  You can download the series from patchwork or
via get-lore-mbox
to pick up all the Acks automatically.
