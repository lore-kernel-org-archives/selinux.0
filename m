Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB4FC38145
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 22:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIGWqh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGWqg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 18:46:36 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D7ACA1B
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 15:46:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1225219ee46so39806154fac.2
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Mx87jbTPvwU89jN6ckpNoLI7Yf44eOzkNAqFyZSwui4=;
        b=w3KbZlnjcPyUPFf1GWzRgwFe4h/q0uNJ4i96ybzpTedle+2TjWIEkW1dDEiNzsG5iD
         cSHwcYpfVsoXVQiObS6ACm6XefvmM8cPlryBGQ0JRp1KLUrpszevekmqDEaeTS+k25Tp
         FxJWFIussvgD6uUzCxqaeUdcfrPUPEiKuVdkiSkAnvZRTviG+xVoblHgTLdB0P4z+BTY
         COFg5EsLQ+SRCrmiSgm+/Ayr2j4kt5G7FUmZ2ZVqHnt2F7bfr8B//kPuVJecxyA/82K4
         xEYFBMwEJaLc0Ye0cMDNc44jqVmNpnHorqtctA8WepHRQAsOqiu+gLZ/BW2ZyfUinDmH
         m0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Mx87jbTPvwU89jN6ckpNoLI7Yf44eOzkNAqFyZSwui4=;
        b=azICq/g4VNrxKwNbW0+41GHtMeDaMX5TDTvwU/8d4A5Yh8svRlEuUIeT6M+05N2o3z
         w/0u0MZebDzHCSKPLLaQJp5NpP1oWaYJFmf2de/bQgDNlLfw0TJHAry/w98Gm3FGjx6q
         wDmzCqTocV1S4Tv9E5vy2ynT1n4lwqDoy1xE3oJLRdpgWMqXmunp5UcBBGD7CsKZzCMs
         PgReV6NDJKBMOTi2ftmYh+pxmfwQHqsi5oiOj7Wc5v5FVUyIaVCXRyVStv/y/zaNXAQf
         GWdTw9o5D7xUf0seqBOZWqdWVNnDBlWuBQQyhGk5vz375QuWY3OVI+f89R36PKsvMzI1
         AiEg==
X-Gm-Message-State: ACgBeo3rCfkQ/tgTy4hKJduh2Ygm/nsp1UrZS4ugcndwmh6CcZjDXSHn
        8TvMc05O+3o+TomBq24py6jWDrtvP+9LpiZyEmIK4lP2rg==
X-Google-Smtp-Source: AA6agR79UfEdR9uDrcXp3yc0BqZxvrNTP9Ag1PCtLQzniHVUJ4FLL0zcq5vt9PHqLzg3PkxN9Nhv6U5cWRFxG307/tM=
X-Received: by 2002:a05:6871:796:b0:11e:b92e:731e with SMTP id
 o22-20020a056871079600b0011eb92e731emr355481oap.41.1662590792184; Wed, 07 Sep
 2022 15:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
In-Reply-To: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 18:46:21 -0400
Message-ID: <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
>
> systemd uses a helper process (sd-listen) to create sockets and pass
> their fds back to its parent. I've patched systemd to call semanage to
> get the context for the port if it exists and create a context using
> the returned type when calling setsockcreatecon.

This obviously depends on how you structure and write your policy, but
I don't think you want to use a port type directly as a socket type.
I think we talked about this a little in the other thread, but for
bound/listening sockets maybe you could do a transition for new child
sockets based on the listening socket and port types.

> Everything looks
> right i.e. the port type is retrieved, the context is created and
> setsockcreatecon is called without errors. However 'netstat -Z' shows
> the listening sockets type as init_t and not the type in the
> setsockcreatecon call, is this the expected behavior? Can anyone help
> me understand why this is happening?

You're calling setsockcreatecon() before you create the listening
socket, right?  I wouldn't expect this to work properly if you create
the listening socket and then call setsockcreatecon() hoping to have
the new label applied to the new child sockets.

-- 
paul-moore.com
