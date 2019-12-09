Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8472CC04E30
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560D62071E
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 21:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oqcuQem8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLIVTA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:19:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37685 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVTA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 16:19:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so11896437lfc.4
        for <selinux@vger.kernel.org>; Mon, 09 Dec 2019 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etPxM7JTRJC9PaahnpBnJTghBkh947eZxG1jtsdTjI8=;
        b=oqcuQem8yozPTswlgFIKPcb4zRGL5LpvHXCuvJm2xSKwbz6hLPru1d9M7aMqOmH0qB
         CbEMCdFXR4xxv1DsPZcx3gI9B83cIExckC+uAu1EfehZCv0Ba2sqICKjtlRl2G0u7Hqd
         91AiPx0vL23VehtNaFr0T9RE4sMDIpXGQ6eu3ReONTd9NHaDjKXA91+Bm30PKl4Fgrxx
         A1YBPum7p7zwXUZSWAs0YUPAMzIHyzvaVYdvV4Zage/WejN9sdZ9+8NsV82K1q2vfohH
         YZ6Ig7pbJi4X12iGWoM96NrHDubNL9V9giaTqWw6SKxrA7Czic/l5VMjbtpxb/jR5GWN
         SM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etPxM7JTRJC9PaahnpBnJTghBkh947eZxG1jtsdTjI8=;
        b=uKzZ8o9viv0vGJmCDgAQVHgzmrmKNEuznEVYAXBFx6uubndVOx2/69doMBts+sCiWw
         3BbP5oSMmecjtVT2rJ3G4pyM7K8y2WmCFxR5EHCkB4AoYvphAbuXuWoQmu9iGUnH84N6
         Jf0Ok9ISgPNZ1LQyUPwe0MFRxG1ypoFkp4eR3iCbzezKZg128gtGE+AweIjBRdcMKH8E
         aJHqdfqxiRZRNAh3RdaHQbTYe7XktCGHkoUFyy5tLJsnnT3QoGfq3kHaPfcKz3VYADTb
         /Jt6mjLspahN4giRnbXdDcWBUvM/Ie01cEfPJTOKMbXnLQ0vyfFAHOFR2CzUZSowOEfv
         gtKw==
X-Gm-Message-State: APjAAAX/B57t3SuBWoGj80K8EXtrNGEs6EeA5+S8drURbwbQqEfpcTNa
        1BwPuexTCUjvZgLeQ9rQtEB8hBGKO0aRKxokGRsO
X-Google-Smtp-Source: APXvYqwN01WorvP4A75QXKj+g4bLf4ZZT6ACOZaQFUZ1S6zhYZI4eQs3tf0XYXVOYmW+6QeJvcAY+W25B+ONZIglVzQ=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr17054433lfh.64.1575926338811;
 Mon, 09 Dec 2019 13:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20191126135700.743238-1-omosnace@redhat.com> <7ea9d889-c226-68a3-7dfc-3c507eefa53f@tycho.nsa.gov>
 <CAHC9VhQvoMaH8ioQhExFV_noRXvcpro1yJ59vxrJCaT+-Mhzug@mail.gmail.com>
In-Reply-To: <CAHC9VhQvoMaH8ioQhExFV_noRXvcpro1yJ59vxrJCaT+-Mhzug@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 16:18:47 -0500
Message-ID: <CAHC9VhSUAtCx7Xk-tgwJCkb3A=bCYbpu57BKVF4a-3G_8-JOew@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: cache the SID -> context string translation
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 26, 2019 at 9:58 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Nov 26, 2019 at 9:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Looks good to me and tests passed.  I anticipate resolving conflicts
> > between this and the sidtab reverse lookup hash table being non-trivial
> > so it will probably require some review when/if Paul merges them both.
>
> I haven't yet looked at the latest revision of either patch, but the
> previous versions looked pretty good (my only comments were rather
> small, and for the most part everyone else seemed happy as well -
> minus the small fixes).  After I send the merge window PRs off to
> Linus (tests are passing so that should be today) I'm going to give
> these a final look and start trying to smoosh them together; I'll
> probably create a new branch ("next-queue" or something similar) once
> I'm done where people can review the merge and point out where I
> messed things up ;)

FYI, now merged into selinux/next.  Thanks everyone!

-- 
paul moore
www.paul-moore.com
