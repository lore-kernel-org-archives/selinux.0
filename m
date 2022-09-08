Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18AEC54EE9
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 13:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIHNni (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIHNnh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 09:43:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF80ED38D
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 06:43:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy31so38182960ejc.6
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3nYwNQdYhJYGnugfgdWUSybhLWAgWV1ZqS3RigCRWBc=;
        b=EDhCcAHifJU5YkZgqOVH72T3dgSz3Iptg61Mb6WnioJl9BWJCnqGgu91cuINz5WGc0
         TZMLU21tW1iqRDKm3KCdqM+pRSXVnSsCmXDo6UAagoFuOHm0MKZOe3ACX+GktkiD7Vyb
         JjqHZuV77Ssg+/gMI7hBAOuyP3aa384mJ3yQvK8LR5uX/HGn6s0ZqZAjCKsPEfJSo6IB
         +nBEP1Qt4Wf+XYsEtb31kKELiLeij8DUUogjZNfTIncAgEF64oQVsD8hkp1I5Glq8zgX
         KPKRzfiSkIJgaCW4gkyBWoQlf9yS96pFKe973qBzlUNbrtD35VMjW1JYz7qCp29rdpQI
         Xkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3nYwNQdYhJYGnugfgdWUSybhLWAgWV1ZqS3RigCRWBc=;
        b=OEWULCOpegplXDDJyjZIaVfR1Wrk7qqDiXCBBmy/u4DneAPB+27+09QoTvqxA8okKu
         90n2rGOuxzKiKwui1cOIfbBwSmpcUx6/8Phe28LMEupB39Zl08KDOiVhd9QO+TzSSCkT
         Vdgy9RlUKb0HHPX74XAVWICGn9M/drLqlRFogRUle4IkeQheSskfHreh1+REkOnHCkRy
         x/P/ziZ2FVrhLao4qy3VJpNgVNU42MhU4XDMnscWeXWC95hj1P1oDBfalSLz4Lu9Kp3c
         FM0qDVfAk1VKcyP4/VuIPVzmQCoPMjJrdnYR+rRHNZhXItmz1R7RnOw9TthBuqs87YZY
         nkKw==
X-Gm-Message-State: ACgBeo0+l2Ti+0YYFs5quFiPAs11ZKAq3j7cEDUpohsDixj4p2IvK8mQ
        IztzDVq6laJV2pdJsW32WqcKvjdQa7rqWQuDw2b7W4sD
X-Google-Smtp-Source: AA6agR7OLIrYidNYzmToAgmAhaTtO6e5FTkukpvUtCpLz9cMha+npWI/G4VreIkHZHFDl+GEbYFFszr10MtqhLQsZTo=
X-Received: by 2002:a17:906:cc5d:b0:73f:e0cd:9e64 with SMTP id
 mm29-20020a170906cc5d00b0073fe0cd9e64mr5961168ejb.536.1662644615154; Thu, 08
 Sep 2022 06:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <87a67ac398.fsf@defensec.nl> <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 8 Sep 2022 08:43:24 -0500
Message-ID: <CAFPpqQGmo8zt4h3aLy7j8rkzZA4cKM8D2DbkVStBre9b17dvdg@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 5:48 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Sep 7, 2022 at 4:56 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> > Ted Toth <txtoth@gmail.com> writes:
> > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > their fds back to its parent. I've patched systemd to call semanage to
> > > get the context for the port if it exists and create a context using
> > > the returned type when calling setsockcreatecon. Everything looks
> > > right i.e. the port type is retrieved, the context is created and
> > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > the listening sockets type as init_t and not the type in the
> > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > me understand why this is happening?
> >
> > It is probably the context of the process listening on the port and not
> > the context of the socket that binds to the port
>
> That's a good point, I would have thought it would have looked at the
> socket itself but perhaps it is the calling process' label.  Actually,
> it might be the fd's label associated with the socket; that would
> explain it.  Someone would need to look at the netstat sources to
> confirm.

Is there an API to query the context of a socket fd?

>
> --
> paul-moore.com
