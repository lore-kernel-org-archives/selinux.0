Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C5C38145
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 22:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIGWsW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIGWsV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 18:48:21 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78623A9251
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 15:48:20 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1280590722dso6257985fac.1
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8AuNhHWQ0FxNRC6l/xPA/uguXYvBej0rMGIIOupdvu4=;
        b=U/xwVQfwgbqnd3YZNQAnjP31s6lPKSJwzm9uXENkOh39fAqTraRH/m6pAwLFPZL/8m
         bOEn/ZoXDkzVh3ytSdGgEQG7mbFj1ER7tRg5gK79VNWHUgsag8BJ+6TRvh123R2nXR3C
         vgsBJaPytfpCM1akrkDPVTmLB0G3a3KOfz1YNG+e+IQ+yBdW9XVJ5BBVJYN9nI/upMXO
         zB3MbBaEKsa2GvpreJrp62P8wk9gp4BUuhmfxg9AeruBw4Fxg1Joy6CAM1XzHW9M5Fuy
         pXsifNmszgFnz4rXVMty/Up8A0TWpsDKypx0RxSHWywt/dXMdce3FrbrS1IuC09SNFHL
         AQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8AuNhHWQ0FxNRC6l/xPA/uguXYvBej0rMGIIOupdvu4=;
        b=YC9adpD2QClxI/k6oYYIFQZckPevyC+uE7ppT2PuLGspnz83n08EyfrOZb00IWkmUy
         j5Ju7K4/5qOAyGT9OW/Fx766oJphuUvQtGKi/NP1OCap8bT0MJt8oP/foU4fRQoTTran
         /iUHLF6NOPhvpMRRflzKoG7Oex//qHxac53pgnnRmBJsGswgL3CtUn69HkJyHsRqZkHZ
         44/eFq7dL9dn4vbNbRPFJIog55qNr20VgJG8/PtYIdZSpNXHFIotZeZxXR5cydK5en/D
         AoFzOAyIfdu6hbf3ztxkzaSoQouAlxSmb5h024DA7MCJpFAuoRBYrHszfUUDl4NnI3Dt
         +x2Q==
X-Gm-Message-State: ACgBeo00D4Z7R+Hk6ZgywGZm9XefBrQZUTrHRDlcJO4WPn/h2SjbmM7s
        oHEDUCJ2TaNfQg3eP4ADappX2eY5eayn9pq7gTITKVjVoQ==
X-Google-Smtp-Source: AA6agR6fDWw2RVBL4UxGkyGPofQJtNKhT1R+Mglu+o8ImO/7RXfvHjvzoAW/6Fga3vG/x3WK9bDSDRcfuwZgvslMNoQ=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr376376oap.136.1662590899742; Wed, 07 Sep
 2022 15:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <87a67ac398.fsf@defensec.nl>
In-Reply-To: <87a67ac398.fsf@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 18:48:09 -0400
Message-ID: <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ted Toth <txtoth@gmail.com>, SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 4:56 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Ted Toth <txtoth@gmail.com> writes:
> > systemd uses a helper process (sd-listen) to create sockets and pass
> > their fds back to its parent. I've patched systemd to call semanage to
> > get the context for the port if it exists and create a context using
> > the returned type when calling setsockcreatecon. Everything looks
> > right i.e. the port type is retrieved, the context is created and
> > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > the listening sockets type as init_t and not the type in the
> > setsockcreatecon call, is this the expected behavior? Can anyone help
> > me understand why this is happening?
>
> It is probably the context of the process listening on the port and not
> the context of the socket that binds to the port

That's a good point, I would have thought it would have looked at the
socket itself but perhaps it is the calling process' label.  Actually,
it might be the fd's label associated with the socket; that would
explain it.  Someone would need to look at the netstat sources to
confirm.

-- 
paul-moore.com
