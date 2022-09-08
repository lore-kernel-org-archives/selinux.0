Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207E9C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 14:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIHOPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIHOP3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 10:15:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C210F5
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 07:15:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy31so38407800ejc.6
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=suPJAh7pTaj3ydD0cRfnnlDyOp5IdVQ1NjjDSWB3eJI=;
        b=BiztPyXJQSreWo5bLgz7A2O31gr+NOVFEwIqJonBUnk5DucEz+uE95SPhWDI+SNwwS
         ShNPJSO+f7Ynh1Wb2fgvbSV00ncf2sEQk8eGQuMssqyfo1yK8kRJvBV+cUvLnsWgisRf
         ylIU7H8bWknVw656Y1EzbjQvIT5NsqGuYnQdVha6Cc8IaYv33jTjdiRrEGdjqDQRaXvR
         IomBvUezZwwcBk3g+BH79Eq5T2G7mM4/KBc0gL8m3QgtEiyXbBWFnREq67UMSfr70iWW
         T3VE4ppDzBnblP0bdlzmzYfyfexjH8EjulgLrssthyfsDSXVMtf51+zGB93QS4AVwubU
         B3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=suPJAh7pTaj3ydD0cRfnnlDyOp5IdVQ1NjjDSWB3eJI=;
        b=mTI9QdAlbLWcRiCZdWNq2w8JnMfup93UzoOiNtpQqe7IYPdicIQYRhVw+IbwiVH75i
         IqYtVUJDua9H5rrAMxabljr6E0kg25rjBhBGsQBiwF4CfXHwUuT5jH17Pm54d6F7Ate0
         lJUrazo1RGXGDQWWqgRBUDxscI5Ee4HvY5DcLhIN1wmfsbsdwRTAyMydhYm4lHXiftrK
         yhT4cT+15OJ93EzDen10O8kEUTJlSGGklKM9/q1MQu4t2jIB/G0QexOKfz/TRx0NkOZf
         Diw86a9iV05UuEB0Ec4k1eIGhfBV2tl7CD74DTm+t3riSvbgLKE/0QbXb7QbvbyWubyp
         gUHg==
X-Gm-Message-State: ACgBeo2laHcZMD89ZpyKZbRSM3LEPbgEkxrmDJA7N2gJ0aEODQhvUo35
        ZKScUrnyRQrFWlzapHI4LA38/0tXLu1IGqZHAMY=
X-Google-Smtp-Source: AA6agR5Q3WN2ghn6dJJcAa//kudk3CFBVIU5l8Nqe/vL38neLy7fDFOhNnbImuWasgtih3MlLPGBUyS2ePN1To7rwiQ=
X-Received: by 2002:a17:907:3e12:b0:741:66c4:5658 with SMTP id
 hp18-20020a1709073e1200b0074166c45658mr6283595ejc.486.1662646526885; Thu, 08
 Sep 2022 07:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <87a67ac398.fsf@defensec.nl> <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
 <CAFPpqQGmo8zt4h3aLy7j8rkzZA4cKM8D2DbkVStBre9b17dvdg@mail.gmail.com>
In-Reply-To: <CAFPpqQGmo8zt4h3aLy7j8rkzZA4cKM8D2DbkVStBre9b17dvdg@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 8 Sep 2022 09:15:15 -0500
Message-ID: <CAFPpqQEoAcmpQALgD9S5ZYnd2KVSPOtsBaC67t3VLv9uS3KRbw@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 8:43 AM Ted Toth <txtoth@gmail.com> wrote:
>
> On Wed, Sep 7, 2022 at 5:48 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Sep 7, 2022 at 4:56 PM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> > > Ted Toth <txtoth@gmail.com> writes:
> > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > get the context for the port if it exists and create a context using
> > > > the returned type when calling setsockcreatecon. Everything looks
> > > > right i.e. the port type is retrieved, the context is created and
> > > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > > the listening sockets type as init_t and not the type in the
> > > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > > me understand why this is happening?
> > >
> > > It is probably the context of the process listening on the port and not
> > > the context of the socket that binds to the port
> >
> > That's a good point, I would have thought it would have looked at the
> > socket itself but perhaps it is the calling process' label.  Actually,
> > it might be the fd's label associated with the socket; that would
> > explain it.  Someone would need to look at the netstat sources to
> > confirm.
>
> Is there an API to query the context of a socket fd?

I wrote a client which connects and calls getpeercon and indeed the
context is what was set via setsockcreatecon so that's reassuring.
Unfortunately it seems that netstat, ss and lsof don't have a way to
query the context of the listening socket :( I'd like to see a
getsockcon function (taking an fd as its argument) added to libselinux
if it can be written.

>
> >
> > --
> > paul-moore.com
