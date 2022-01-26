Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06364C5DF62
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 20:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiAZU1b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAZU1a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 15:27:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4CDC06173B
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:27:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j23so787378edp.5
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7fKMSKo+zYB6l0bcCRLZSEvmbTEgZGQHcFcWTESB/8=;
        b=T8XsmF7/RkWSoa1Uofykc8YgJ4ksfOBVQ1W3E/PAqloI2DNVWNHR8DK4/+nARWFYwQ
         HAqBsXl7/U8MFdaDgmNL53zfIDS+/owDmCBKF+Vr/VI7Rb191veqqQzedmj5eEuR+AhJ
         7jkOnAW4G7iRcOb9YrTFFIP89YB37hE+6K+lR+DuhHrBkITgBEoUXNbj7HJ4pISDixZS
         gSNotfzQG9YKFtGdg6IhR1+rAUXSFvxT20JTgRF4IiMTidXOZGyz+kCMa2/SuLniPvJi
         SfDjxssD0L+wzJXmgpw4hRDBZsJvI9PwLlcfj5LEn6l9IDXKjPdOidn/R4LtViAq9a1o
         wd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7fKMSKo+zYB6l0bcCRLZSEvmbTEgZGQHcFcWTESB/8=;
        b=YHFtupkrVr1NCfsLT8c2PBWAJgYJBMzZvEsEFU1MMnO4VZOcSQAGlp/6OrHk4XMTsD
         VVuhMUIwTi9Wv5EBYOG6oE6kqzgAV0nAa1oF5Tl+jvadS8qTay4RIooc9hJ/kda30OAZ
         PQZf82TK9uq2EiF1TMd+ZXJAGVLzbgFgH3VMrtyT/MTFq/rAW+6ot1cVvuYMaqfMjf+8
         mX1FFk3ZkXL/lITjmKUImmeZQsmBt4PwyuARl+8GwmvPG4hWKSEAcDP8+SEjOQhCnJ1s
         qxgrJFdw6dHlrcEUDU5p4UK1gKGTqVeIuL+3b1hOhhA7jetZwEnQoMLTUROYc6szwFS6
         hVPg==
X-Gm-Message-State: AOAM533rztlCTpuP3NnJ77pmtoSm14TvkOg8E8OUj1u/imFU1T1szpbK
        G0mJOqZMFgtdX3yvNbQr2CbSUQ0jjhnsaTVCQtEj
X-Google-Smtp-Source: ABdhPJwpLDsxPl9dSCn/6ZhjVdqQvY+qo0gszHugbTZ1j/RmIs9yltE48w5RGwnPuintOLFvvMDgAvBG1ksxt3bQg78=
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr604716edd.405.1643228848645;
 Wed, 26 Jan 2022 12:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-4-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-4-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:27:17 -0500
Message-ID: <CAHC9VhSqp-PCp4rLc9Mgco6_3j5JLuym0EZU1xAvzbtt5O87fA@mail.gmail.com>
Subject: Re: [PATCH 5/9] selinux: drop cast to same type
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Both the lvalue scontextp and rvalue scontext are of the type char*.
> Drop the redundant explicit cast not needed since commit 9a59daa03df7
> ("SELinux: fix sleeping allocation in security_context_to_sid"), where
> the type of scontext changed from const char* to char*.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

--=20
paul-moore.com
