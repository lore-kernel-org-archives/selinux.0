Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F623C433F5
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJEOko (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJEOkn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:40:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E53340D
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:40:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a26so6992390pfg.7
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0TZmZYrv6LvK1dp/PfTVsbza8AUs4FXru4tXA1Ul+LI=;
        b=DUyzgAu0+5e2kwmYrpaPW237M2GuC40dNBAkU5kj/S4idIzIlkGYmQ0TthiOnFJmED
         BnDrWDONlsUD0fB0L+sdH817Kx7bAktE9gU0P/iYJIy7MiESD5YtjLtes80OS+GulVsp
         KAe935MKO5eJkB2glpwX5fh9RinvUlpyK+nSzauM46Pdoz6aqj/F3CMvs2uAiJgIuube
         5aZlVAoOJMoMawz4vm70rzPW27UhDd3zFWWMLQ01BlW+tYl5c0PN6TyivDLvlq9p+vfF
         hhWwjgFjPpSL2Xj94HLODdBR+Z175oTBe8oyNyzNRYSovCzBzj9YmFOy09rxzWEiI850
         DvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0TZmZYrv6LvK1dp/PfTVsbza8AUs4FXru4tXA1Ul+LI=;
        b=i2diZcAFyBlHU5yAKaqkju1c6CuRVrzrL5tWKYPVvKtjGbSS53LFqxTT/wBALJypKw
         xgRADTjMkt9f1/gC7BAIKnvc9Dfvgb4Yy8Plxae7qH0xCHcdJ4yaRnsDyvLqgB/2cHTP
         WfnrhjYF9x0EzZEXthfPtvv5IQgwajRK5lFrp0nFdjtOhN2UatK8ZF5ztlLesmyiPa9w
         Tou2b9Rvxi/hnwoprnUPZWEab4xnuxQgBaY19I5o1n2xTYkauHyV/1JLmlc7RDg2HxWv
         Jb+diMKYST8wyu5YvWiT12AlkLQUUyL+srxJVphyQlVtdmk8iako1+Sizg/2SeTzmtCA
         9Hbg==
X-Gm-Message-State: ACrzQf2x0zvW1TECFKK/i945unVDbCbFw8SwwN9LenKOI/IusUX+LdMr
        t1mB55SXdx7kQRb7EqJ74wsN3zfXH3ka5X4pMcTHtZni
X-Google-Smtp-Source: AMsMyM6vPWQsQg3Ox6Slfy4gBLo8Klr24L+COyndkZWAbRNcsLBVegCHiZ8/enmHbJFfHMMQRkYPSPtU5p6ZPGPjoCY=
X-Received: by 2002:aa7:86cf:0:b0:561:4b7b:4745 with SMTP id
 h15-20020aa786cf000000b005614b7b4745mr151175pfo.29.1664980842292; Wed, 05 Oct
 2022 07:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRNJjzGSbQgcTeP=GcUyAHTn__KDz-r02zSs-xcQFO-gg@mail.gmail.com>
 <CAP+JOzS-tit_5wLgYGBGBgWSzLvx8zDsb8mts76GsP673x9Xvw@mail.gmail.com>
In-Reply-To: <CAP+JOzS-tit_5wLgYGBGBgWSzLvx8zDsb8mts76GsP673x9Xvw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Oct 2022 10:40:31 -0400
Message-ID: <CAP+JOzTHCKfzfznjyq370_BSYmmQ-dh0=sxd94C7pSdPVCh6-g@mail.gmail.com>
Subject: Re: [PATCH] docs: provide a top level LICENSE file
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 3, 2022 at 10:59 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Sep 30, 2022 at 11:05 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Okay, so this email isn't really a patch, but it does point to one :)
> >
> > * https://github.com/SELinuxProject/selinux/pull/370
> >
> > While the PR referenced above is quite large, too large for email in
> > fact, it is that size because of the number of renamed files
> > (COPYING->LICENSE).  The only new addition, a top level LICENSE file,
> > is quite small.
> >
> > Please review and merge into the SELinux userspace repo.
> >
> > --
> > paul-moore.com
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim
