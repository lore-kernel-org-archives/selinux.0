Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA23EC07E9D
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIWRqW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiIWRqV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Sep 2022 13:46:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50D14F837
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 10:46:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d64so694077oia.9
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f0DF3PWutXQ5I+aX+UH0mBjo4GtqDyXKKEJh8EnuVPs=;
        b=zIsfFXDY2Bn4xbvM8pJZUXK6wmz6+94JfWorCve1jq9zMk/4nDtePKPrp62onEi0mY
         7a+2RR7EFSJd8gwIVXpicbez4cp4sK01JjZ76cUACxc1ZsuBhq4yxXCZmHO9J6Ptp+wt
         Ii2g/FRvCxdCzop2/q5MzOAyKv5o9BXONpIFxxdHGdkvqcPo1kdvO80FaFMqfmlGyraW
         5PQGoWUjtL9kuILbxiZxV2Ns4zKDpBuUJSXWBSpieoOpWJ6VZd3z29kFuuSbctiHOF31
         FOiZHIAfD6camGM6l8rqvNstNjy4taZ2EQC73Jf7rA8GqqfokTTEO2B0ICiMKgty2xdC
         gVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f0DF3PWutXQ5I+aX+UH0mBjo4GtqDyXKKEJh8EnuVPs=;
        b=J9mmWn811wnOM59dw4RaBsGTTWiE1mg9JIyGqnWXPji3Emxvp3cUC5UO6xhrcj1qYd
         lxKmAgR27iKGQj7ZdBGupxav/WSyMOVBt3hV8UCI//qWjMDs7dEpNY6hd7lVDSaLYJ+b
         nwk+pyUgwP/h/Ecyf6/VlazBYjw2Juv543YpcxMNXpksvAvM0S85joJA0Uud4aHwRhDB
         PuyaQwdtGY/DDYpjogrzVlCV+g5n7KezpFyyWBTf9AgVa5XmtoBI3pBZEQmKD6VIbcQS
         VNcnOj831IYDm65SMEWfXxbSjLMMpwRRAOweZXDkRhfj6PxoeCwolSurpabUQVSMWM4E
         62lA==
X-Gm-Message-State: ACrzQf3uye80/UZiA3ncnbMdMLhfaVv6iOd5NuvYHRTub4tkdE8kI3QN
        e856hQLfYvNItkC7Sh83YHo6fQgZJSMdSi/yDavBzXeGxw==
X-Google-Smtp-Source: AMsMyM5XyS+GP0I+5UaX13h8X7szpwKNb2NPR9N9EU/euLz8pCO9pGi1Em2EgVFxDKtqt81SRoBzF0FK3SdT5/x3O2U=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr9561299oiv.51.1663955180241; Fri, 23
 Sep 2022 10:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <166389782245.2164705.1324707815130435654.stgit@olly> <ae395206-b54d-ac82-5072-ee2fbc4f2dbc@schaufler-ca.com>
In-Reply-To: <ae395206-b54d-ac82-5072-ee2fbc4f2dbc@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 13:46:09 -0400
Message-ID: <CAHC9VhTjqXecJ+z=zZLaAzKTW2hHXSnAKzikS5W=iccJULGdyA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: increase the deprecation sleep for
 checkreqprot and runtime disable
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 23, 2022 at 11:25 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/22/2022 6:50 PM, Paul Moore wrote:
> > Further the checkreqprot and runtime disable deprecation efforts by
> > increasing the sleep time from 5 to 15 seconds to help make this more
> > noticeable for any users who are still using these knobs.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> To the extent it matters,
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Reviews *always* matter, even if sometimes the resulting conclusions
are determined by the majority to be flawed[1].

[1] This is not the case here, but some folks love to weaponize quotes
from the archives so I find it best to qualify absolute statements
such as this one.

-- 
paul-moore.com
