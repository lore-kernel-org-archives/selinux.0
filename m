Return-Path: <SRS0=Dhgn=D3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FF7C433E7
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B62221FC
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqGBHArF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393872AbgJTLzj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393791AbgJTLzi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Oct 2020 07:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603194937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+K1EKgErER8jnE1pFdV8KahB7MCNsS3EvW71TrUqls=;
        b=NqGBHArFykPg/EJdfIa+8cP71Rtf5XkKAS2EQE3XMvqCxT4F48Aq3CggdSmrBs8UNcGcH7
        BSFuuvEydXW2cTqVjL3ZYjXXJ/rVmFSueF7mQDQ7xtNcaxWvAEjZPccEiNuzlu6jYsjtf5
        diKUNJIzj9vaaAtk+G73Pdcvl+mZz+0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-A7IIvcs5MTWbW-1eVBodpA-1; Tue, 20 Oct 2020 07:55:35 -0400
X-MC-Unique: A7IIvcs5MTWbW-1eVBodpA-1
Received: by mail-lj1-f200.google.com with SMTP id r15so736902ljn.16
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2020 04:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+K1EKgErER8jnE1pFdV8KahB7MCNsS3EvW71TrUqls=;
        b=IXsaZ5zyDmD5ySw7jbSPc0mIPlVzCfzk2GLH+950/bP+dyIRzeuraaXuqnEbfUgcfL
         1fvwunoyyu5zi15jvb31RzMmzyVZcS9Cag9EyDP/F3j+yPp7jLYIhZM+ImcdvduGSmpi
         pXE2ERgmFE3pdCi7e7qbqHrvNxHQOyx1zUoG5oaZEwlcfr9cT6FABWcgbA4+Izvq4H5M
         vbDcvEoRZQQw+3Dn90ottxndzj4qJV7t7YulAT7XVTgwzAdTACKqTSnG4/+ZQkW0+KNR
         Yzq7zdond2htUjYfWC80TsTKaeRzkVhce2ZkM28G+iWcadr3Zwh4cw9xtZydnOD2kJNv
         GQyg==
X-Gm-Message-State: AOAM5310qHglU0UsYSzMjKhYmvQH4gQuKRrvqmn8iYFkpUinAtNVbN3c
        vtiQDzGOZFX3MsE6E0n9CNYQMMaW5YQTtIknfYWsEZekS7ziPfPuIuqCBKvWBveBngXQf7NWuwv
        TjtKmNAPTUkaMUd5zxle0uAP++JZhwZwkjg==
X-Received: by 2002:a05:651c:124f:: with SMTP id h15mr915749ljh.123.1603194933886;
        Tue, 20 Oct 2020 04:55:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz26V0osV2yvevSE1IX8MluqLDEMDUaGkERUOexazUQx7xJIHXcWTvvyjyufBfB56TQ6czrfQYiZjFGJo+rwAo=
X-Received: by 2002:a05:651c:124f:: with SMTP id h15mr915740ljh.123.1603194933671;
 Tue, 20 Oct 2020 04:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
 <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
 <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
 <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com>
 <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
 <CAFqZXNspQBJeM1v+aExWTc4Hk2+MZ8oFaLCUWANOusboSho2Dg@mail.gmail.com>
 <d257ed0dcdce297d1aa026773f34d27bc3d6dfba.camel@btinternet.com>
 <CAFqZXNvSPvhHtKsa7W9HwC66Bvg2NH3tfGyow3QzZJ0C3RJEpg@mail.gmail.com>
 <0697d164d1838dac05aee2b482c76caf5f5d025f.camel@btinternet.com> <1f11e56714519b18f25539e88fc227868a098c03.camel@btinternet.com>
In-Reply-To: <1f11e56714519b18f25539e88fc227868a098c03.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 20 Oct 2020 13:55:22 +0200
Message-ID: <CAFqZXNsRzKEKeJmRj+tPNb0PQ7U3+gFPV-raOC7w6hEpXScL=g@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 16, 2020 at 3:02 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Thu, 2020-10-15 at 18:04 +0100, Richard Haines wrote:
> > On Thu, 2020-10-15 at 16:12 +0200, Ondrej Mosnacek wrote:
> > > On Thu, Oct 15, 2020 at 3:49 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > On Thu, 2020-10-15 at 12:28 +0200, Ondrej Mosnacek wrote:
> > > <snip>
> > > > Just a thought - have you tried running the server in one
> > > > terminal
> > > > session and the client in another (I've plugged in your Fedora 32
> > > > addresses):
> > > >
> > > > cd ...tests/sctp
> > > > echo 1 > /proc/sys/net/sctp/addip_enable
> > > > echo 1 > /proc/sys/net/sctp/addip_noauth_enable
> > > > runcon -t sctp_asconf_params_server_t ./sctp_asconf_params_server
> > > > 10.0.138.59 10.123.123.123 1035
> > > >
> > > > cd ...tests/sctp
> > > > runcon -t sctp_asconf_deny_param_add_client_t
> > > > ./sctp_asconf_params_client 10.0.138.59 1035
> > >
> > > Interesting... I just tried it a couple times and it's not behaving
> > > consistently - the first time I got "SCTP_PRIMARY_ADDR: Permission
> > > denied", then 'Dynamic Address Reconfiguration' twice in a row,
> > > then
> > > 7
> > > times  "SCTP_PRIMARY_ADDR: Permission denied", then 'Dynamic
> > > Address
> > > Reconfiguration' 5 times. and then again "SCTP_PRIMARY_ADDR:
> > > Permission denied".
> > >
> > > I tried (manually) different delays between starting the server and
> > > starting the client, but there didn't seem to be a pattern.
> > >
> >
> > I wonder if this test is flaky. A bit of history:
> > When I first produced the SCTP patches I had different permissions
> > for
> > SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP etc. so that I could detect
> > these denials with allow 'self' rules. However the maintainers wanted
> > to keep things simple with just connect or bind permissions. This
> > made
> > it a bit more difficult to test this case. As it so happened (until
> > now
> > of course), the two LSM calls for SCTP_PARAM_SET_PRIMARY and
> > SCTP_PARAM_ADD_IP in sm_make_chunk.c triggered the following rule:
> >
> > allow sctp_asconf_params_server_t
> > sctp_asconf_deny_param_add_client_t:sctp_socket connect;
> >
> > therefore by not allowing this rule I could detect (using the tshark
> > trace output "Client returns ASCONF_ACK's with 'Request refused - no
> > authorization'") to prove this test case.
> >
> > If this boils down to a timing problem, then the test needs to be
> > removed as I can't test this scenario, because the client needs the
> > connect permission to be able to connect to the server in the first
> > place.
> >
>
> This test does have timimg issues. I put the three asconf tests in a
> loop of 200 iterations. Sometimes all would pass, but other times the
> third test would fail with the error.
>
> I guess there are two options: Revert the patch, or remove the
> offending test. Any views !!!

And do you think that the timing issue can be fixed by better
synchronizing the client and server programs or is it inherently
unavoidable? If you think it could be fixed in some way (even if
non-trivial), then I'd prefer to just comment out the test with a note
to revisit it in the future (leaving the code in place for now). I'll
try to look into it at some point, unless you're faster than me :)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

