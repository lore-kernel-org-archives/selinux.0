Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C9CC54EE9
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 14:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiIHO2c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiIHO2b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 10:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1FED38F
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662647309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZUsXh4133g9CgFcVEYchZDTsjeNa5u1dJH1CieIH1M=;
        b=fPgU21Lz6FocBcWQTqN5wdpv8NlpBtb/1zEIeUXUjjMaJM3k4mU4gG8oMxqLWgdtjmi3rG
        gMoIz2ZxYM56IPmWAU89NOhThm9pb9/kh2QaS9cgYKT/JK643OsGMcrklxm8HPedTLU47y
        zSxhg8etEM9EJMcP4i+YAUmeb90kWB8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-B7pTfLtQPjurVwM0vduD1A-1; Thu, 08 Sep 2022 10:28:21 -0400
X-MC-Unique: B7pTfLtQPjurVwM0vduD1A-1
Received: by mail-pf1-f197.google.com with SMTP id cg5-20020a056a00290500b0053511889856so9395606pfb.18
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 07:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WZUsXh4133g9CgFcVEYchZDTsjeNa5u1dJH1CieIH1M=;
        b=MKbK8dKSFqQqPC0noMbl6r8MywWjikKlHqedlbJ+hv7nknBqh958cJFUELGbOfpOha
         NY00HRyAwOV06Trq43KZTYnhpy1jdSdDDRjNy98sHBLRpQBlJtcMOAraRZsa31EBEV9S
         5eIJ8ajgfXr7sHZUKeFLPfkENAifN5Lq1/i+Oc8boibuJwkSBcD9NrFQ/ZQ8nQFFpgIS
         8Qm5Pdgac3HzgGKB2kmamV+Q8VbAtQLS7Bo/xot8bVEusmb130Ot4XcahGi1bIoXfPrc
         l4pOhcH8+o+H9b80MbmrIwbjCL9cB2+IdXvK6PtKEj21aa+Lw1tHG28zwqeri4qOC70c
         2DjQ==
X-Gm-Message-State: ACgBeo2DkWv1kJPma5RAqkVUotQ/WtIkdRsMTKuar9CtlutID5VUj3N4
        JQqCOPXVgQi6sHqfz+gukcVpwK8mNKnztpQQ10v3v675vaRXHRVyRxt1wGPHIi6Ip+foX3nUmtK
        pl+VDM6l3oMfjuNFCa48cMRjI19GrOumh7w==
X-Received: by 2002:a17:90b:4b48:b0:1fd:d2cd:896c with SMTP id mi8-20020a17090b4b4800b001fdd2cd896cmr4492512pjb.120.1662647299835;
        Thu, 08 Sep 2022 07:28:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4aN3ufl40CgVRT3WHfCR1YUM3Zol203y1rzxXEKkx/bDJ/YInqiLrEPqhoUEQhrugfEVCwRqiMsC/TIVBZEuU=
X-Received: by 2002:a17:90b:4b48:b0:1fd:d2cd:896c with SMTP id
 mi8-20020a17090b4b4800b001fdd2cd896cmr4492495pjb.120.1662647299548; Thu, 08
 Sep 2022 07:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <87a67ac398.fsf@defensec.nl> <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
 <CAFPpqQGmo8zt4h3aLy7j8rkzZA4cKM8D2DbkVStBre9b17dvdg@mail.gmail.com> <CAFPpqQEoAcmpQALgD9S5ZYnd2KVSPOtsBaC67t3VLv9uS3KRbw@mail.gmail.com>
In-Reply-To: <CAFPpqQEoAcmpQALgD9S5ZYnd2KVSPOtsBaC67t3VLv9uS3KRbw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 8 Sep 2022 16:28:07 +0200
Message-ID: <CAFqZXNus2pSv4=oxm-Mj+vz0D2TDNqiG6tf_--CSo5OcExK74Q@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Ted Toth <txtoth@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 4:15 PM Ted Toth <txtoth@gmail.com> wrote:
>
> On Thu, Sep 8, 2022 at 8:43 AM Ted Toth <txtoth@gmail.com> wrote:
> >
> > On Wed, Sep 7, 2022 at 5:48 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Wed, Sep 7, 2022 at 4:56 PM Dominick Grift
> > > <dominick.grift@defensec.nl> wrote:
> > > > Ted Toth <txtoth@gmail.com> writes:
> > > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > > get the context for the port if it exists and create a context using
> > > > > the returned type when calling setsockcreatecon. Everything looks
> > > > > right i.e. the port type is retrieved, the context is created and
> > > > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > > > the listening sockets type as init_t and not the type in the
> > > > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > > > me understand why this is happening?
> > > >
> > > > It is probably the context of the process listening on the port and not
> > > > the context of the socket that binds to the port
> > >
> > > That's a good point, I would have thought it would have looked at the
> > > socket itself but perhaps it is the calling process' label.  Actually,
> > > it might be the fd's label associated with the socket; that would
> > > explain it.  Someone would need to look at the netstat sources to
> > > confirm.
> >
> > Is there an API to query the context of a socket fd?
>
> I wrote a client which connects and calls getpeercon and indeed the
> context is what was set via setsockcreatecon so that's reassuring.
> Unfortunately it seems that netstat, ss and lsof don't have a way to
> query the context of the listening socket :( I'd like to see a
> getsockcon function (taking an fd as its argument) added to libselinux
> if it can be written.

There is a way to see a socket's context, though it's a bit obscure:

ls -ZL /proc/<PID>/fd/<FD>

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

