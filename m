Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E1C6FA82
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 14:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiINOFL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiINOEw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 10:04:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA787DF7B
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 07:03:59 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127dca21a7dso41175041fac.12
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j68RpAafdgiysTuOK9XxgnfTbnb9wtCTlhIrXcQgDQ8=;
        b=1rYIc8KZrJKgU7DiPSWg8USQxcx1MJ6PXvXjBLqrTmHQbIU28lshY34KAaf959yFDm
         sICmPj7paYaH13XmVYDDH0SEkgSPEWhK8VFdVAkIy2qr4pA6wz2mz0FemH9hVLx8zBvO
         6YDAERc62AxbJDyJ1a8j9R/9r4EGnkSHxVccBfJTIBAfGPqfQcmGxqXevjIN6SsHMeY2
         1FxuHUhAjG1tsWR/zf1igvzRFkPM/2uh/FBa6e7SGElPrzPr8pcV68SQKKNbdN5GkXYI
         mpcFFiCphBvBYMGxnUthapohdNo1cL6Qo2mqnLUDz+Zzn4h2Ga0kimQ0pTU+frx/TrKK
         zXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j68RpAafdgiysTuOK9XxgnfTbnb9wtCTlhIrXcQgDQ8=;
        b=ynj5Jo0GtzcyjDaL2M/1v9PNNfS/qabaAyQEgiFiMXOKLwGBHmU9SEtKj4InI/l/wP
         uJoxfN9yVT8GUUKkNRbKojmlBTdCFYD/K+HBD49NyuCvuhVlWjghSWTptnNwnshg3Oq2
         /IkTIlv+u7RHxwdHa34VVNUVQCDIESDSUOS8ZpOoTwYSFvXo5pHhRs+04OeYFSCf8Mvo
         nxOpeWiSjaRUCGls2Ndr+BZmNBJeXW1XxjS+WtNC0f3dEG2mdF3qTNnIB3uHHVDq7fGU
         fatgmPAoF+dETeS2DzRTlPt5249RCzOL3mn+GnBc2bkzixCJrs83ODnTTtEoXvDxGX89
         Hymg==
X-Gm-Message-State: ACgBeo3WmgElqT3GGc6u5i505x8uS7iwL7RK8zYqmzzRzi9LMHk3XFZE
        aBzHA68QrS7aP5IVKBaE4AMB1pCMdFbCEOUkt+dapCT2gSV0
X-Google-Smtp-Source: AA6agR4b00eAq7y1UBbnLaSCPhVCX/Khmdx2hAt7yo8Ax5/3kTnuRVkssVoM9mD+XO3NCICIwneR4A7JZ6Qe1JKXmnI=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr2450740oap.136.1663164224417; Wed, 14
 Sep 2022 07:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
 <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
 <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com> <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com>
In-Reply-To: <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 10:03:33 -0400
Message-ID: <CAHC9VhRyaL5T_rQy+LWqFmorzCsX1UkqpoqP81y3YzsXg+Pmyw@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 12, 2022 at 9:11 AM Ted Toth <txtoth@gmail.com> wrote:
> On Thu, Sep 8, 2022 at 9:42 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
> > > On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> > > > >
> > > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > > get the context for the port if it exists and create a context using
> > > > > the returned type when calling setsockcreatecon.
> > > >
> > > > This obviously depends on how you structure and write your policy, but
> > > > I don't think you want to use a port type directly as a socket type.
> > > > I think we talked about this a little in the other thread, but for
> > > > bound/listening sockets maybe you could do a transition for new child
> > > > sockets based on the listening socket and port types.
> > >
> > > To be clear you are suggesting to call setsockcreatecon with the port
> > > type but also have a transition rule to transition the port type to a
> > > socket type?
> >
> > Two things:
> >
> > * I'm not sure you want to reuse a port type as a socket type, that
> > seems wrong to me.
>
> I was thinking I'd create an app type, port type, socket
> type and a type transition:
> type a_t;
> type a_port_t;
> type a_sock_t
> type_transition init_t a_port_t:tcp_socket a_socket_t;
>
> I'd use semanage or cil to set the port type.
> semanage port -a -p tcp -t a_port_t XXXX
> or:
> portcon ...

That seems reasonable.

> Then when systemd is creating the socket for the activated service it
> would lookup the port type in policy and call security_compute_create
> passing in systemds context, the port context and tcp_socket class
> which would return an a_socket_t context to be used in the
> setsockcreatecon call.

I guess you could do it that way, but I think the better way to do
this is via a normal type transition in the kernel when the accept()'d
child socket was created in the kernel.  Not only does it not require
userspace changes, it avoids all the potential race issues one might
have with multi-threaded applications and setsockcreatecon().

-- 
paul-moore.com
