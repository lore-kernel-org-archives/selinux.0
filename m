Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EAC55178
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 13:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A9B20790
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 13:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLZVbzaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438840AbgJUNcQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441714AbgJUNcP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 09:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603287133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JaOcoZ8kTOQ4alRafxzCRaXO22UavxKf4yX+vV4MfKQ=;
        b=fLZVbzaWnH5roQobfYik8f5N+HhuyprTdofcY/2T3t/Bgx7SGPWUGXwMOmtnueMFZHU/jw
        n9UDYZGdMZtdutqKu6SSA2FL015IUOnk3DOMJYx7BEQhFZwxXfkPgj3M6N5YnoJvDmmtnA
        pZrsuh10z0Lziw3dvnrSMo0kSST0PoY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-JdV3GZOWMLqZlEUYtLxngQ-1; Wed, 21 Oct 2020 09:32:10 -0400
X-MC-Unique: JdV3GZOWMLqZlEUYtLxngQ-1
Received: by mail-lj1-f197.google.com with SMTP id i3so1682934lja.15
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 06:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaOcoZ8kTOQ4alRafxzCRaXO22UavxKf4yX+vV4MfKQ=;
        b=TOCfC09hzB03xrcWRJozDrmVKTe9hiMRu28sPJ1sjXJR8eY77DJj0Na6ojTmKAzveZ
         c6no+uFbxppuk3FL0M0cetNy0u05iiPNcGHWGjLUZTph07dldF1gjs4P/OP3aDimXe8w
         MtB1S3Qg7t5afMpuBGMemKEkcofD+eOUipW9IfSoGltKhDvPNpV18rKTzzlAjTfSX4iV
         5ZLqC63E2mGp7Zf/7ubTjr7sJuUFLc1mup7EY6oaAXoLUBLTAfN5PwMSmcaHV5d7Q1Q4
         u/UbYPRKJG08U0SfcGFzJgJDxrUZu6wrdLyT8hrNaTiMOMIsbCXPECXPoft/s6cs6Dl2
         P40g==
X-Gm-Message-State: AOAM531/9vLrsdNghRMty2nVMFjk3M28uz44CAN9gKtkn1azV7RUYED6
        aK7P/e/bSiaVnRjTkT7oclyOXBnOWKXZk84jI+rqgjAFjTYE1UievV2IXenH+J627M8wMbHFzHE
        L94pbmPPkPh9Tt5oCa6aaDLd1gQiHRmcClA==
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr1378419ljj.38.1603287129282;
        Wed, 21 Oct 2020 06:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztoU7sWx5hmqdyIbeyYXSPn3Ohpnue8FVJdu/OOk/wLctAltY66BkYhXFTvICMHvMXT71sZZhuFrG1uF8foh8=
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr1378411ljj.38.1603287129010;
 Wed, 21 Oct 2020 06:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
 <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
 <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
 <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com>
 <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
 <CAFqZXNspQBJeM1v+aExWTc4Hk2+MZ8oFaLCUWANOusboSho2Dg@mail.gmail.com>
 <d257ed0dcdce297d1aa026773f34d27bc3d6dfba.camel@btinternet.com>
 <CAFqZXNvSPvhHtKsa7W9HwC66Bvg2NH3tfGyow3QzZJ0C3RJEpg@mail.gmail.com>
 <0697d164d1838dac05aee2b482c76caf5f5d025f.camel@btinternet.com>
 <1f11e56714519b18f25539e88fc227868a098c03.camel@btinternet.com>
 <CAFqZXNsRzKEKeJmRj+tPNb0PQ7U3+gFPV-raOC7w6hEpXScL=g@mail.gmail.com> <904b91b20152f3ca54569f57fa118552eda1c080.camel@btinternet.com>
In-Reply-To: <904b91b20152f3ca54569f57fa118552eda1c080.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 21 Oct 2020 15:31:58 +0200
Message-ID: <CAFqZXNv39WPDX_AnpCrjA0Pvur1LQvOjmz9=8SgNXP8YcmZgyA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 21, 2020 at 12:59 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2020-10-20 at 13:55 +0200, Ondrej Mosnacek wrote:
> > On Fri, Oct 16, 2020 at 3:02 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > On Thu, 2020-10-15 at 18:04 +0100, Richard Haines wrote:
> > > > On Thu, 2020-10-15 at 16:12 +0200, Ondrej Mosnacek wrote:
> > > > > On Thu, Oct 15, 2020 at 3:49 PM Richard Haines
> > > > > <richard_c_haines@btinternet.com> wrote:
> > > > > > On Thu, 2020-10-15 at 12:28 +0200, Ondrej Mosnacek wrote:
> > > > > <snip>
> > > > > > Just a thought - have you tried running the server in one
> > > > > > terminal
> > > > > > session and the client in another (I've plugged in your
> > > > > > Fedora 32
> > > > > > addresses):
> > > > > >
> > > > > > cd ...tests/sctp
> > > > > > echo 1 > /proc/sys/net/sctp/addip_enable
> > > > > > echo 1 > /proc/sys/net/sctp/addip_noauth_enable
> > > > > > runcon -t sctp_asconf_params_server_t
> > > > > > ./sctp_asconf_params_server
> > > > > > 10.0.138.59 10.123.123.123 1035
> > > > > >
> > > > > > cd ...tests/sctp
> > > > > > runcon -t sctp_asconf_deny_param_add_client_t
> > > > > > ./sctp_asconf_params_client 10.0.138.59 1035
> > > > >
> > > > > Interesting... I just tried it a couple times and it's not
> > > > > behaving
> > > > > consistently - the first time I got "SCTP_PRIMARY_ADDR:
> > > > > Permission
> > > > > denied", then 'Dynamic Address Reconfiguration' twice in a row,
> > > > > then
> > > > > 7
> > > > > times  "SCTP_PRIMARY_ADDR: Permission denied", then 'Dynamic
> > > > > Address
> > > > > Reconfiguration' 5 times. and then again "SCTP_PRIMARY_ADDR:
> > > > > Permission denied".
> > > > >
> > > > > I tried (manually) different delays between starting the server
> > > > > and
> > > > > starting the client, but there didn't seem to be a pattern.
> > > > >
> > > >
> > > > I wonder if this test is flaky. A bit of history:
> > > > When I first produced the SCTP patches I had different
> > > > permissions
> > > > for
> > > > SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP etc. so that I could
> > > > detect
> > > > these denials with allow 'self' rules. However the maintainers
> > > > wanted
> > > > to keep things simple with just connect or bind permissions. This
> > > > made
> > > > it a bit more difficult to test this case. As it so happened
> > > > (until
> > > > now
> > > > of course), the two LSM calls for SCTP_PARAM_SET_PRIMARY and
> > > > SCTP_PARAM_ADD_IP in sm_make_chunk.c triggered the following
> > > > rule:
> > > >
> > > > allow sctp_asconf_params_server_t
> > > > sctp_asconf_deny_param_add_client_t:sctp_socket connect;
> > > >
> > > > therefore by not allowing this rule I could detect (using the
> > > > tshark
> > > > trace output "Client returns ASCONF_ACK's with 'Request refused -
> > > > no
> > > > authorization'") to prove this test case.
> > > >
> > > > If this boils down to a timing problem, then the test needs to be
> > > > removed as I can't test this scenario, because the client needs
> > > > the
> > > > connect permission to be able to connect to the server in the
> > > > first
> > > > place.
> > > >
> > >
> > > This test does have timimg issues. I put the three asconf tests in
> > > a
> > > loop of 200 iterations. Sometimes all would pass, but other times
> > > the
> > > third test would fail with the error.
> > >
> > > I guess there are two options: Revert the patch, or remove the
> > > offending test. Any views !!!
> >
> > And do you think that the timing issue can be fixed by better
> > synchronizing the client and server programs or is it inherently
> > unavoidable? If you think it could be fixed in some way (even if
> > non-trivial), then I'd prefer to just comment out the test with a
> > note
> > to revisit it in the future (leaving the code in place for now). I'll
> > try to look into it at some point, unless you're faster than me :)
>
> I do have a possible new test for the 3rd asconf test that I've run
> through 5000 interations without error, whereas the current one would
> fail between 100 to 500 interations (I changed the 'tm.tv_sec = 3;'
> client timer to 'tm.tv_usec = 50000;' so it ran faster). I hope to send
> updates late next week. Note that I've had no problems running the 1st
> and 2nd asconf tests in these loops.

I think you just hid the bug with this :) I.e. the test will almost
always timeout on the recvmsg(), so it will pass even if SELinux
doesn't deny access. I think you can verify it by uncommenting the
corresponding neverallow rule, converting it to allow, and then
re-testing. If I'm right, then the test will still pass after that.

I played a bit with it myself, adding sleep in "educatedly guessed"
places and I think I might have found the fix. I got the test to pass
by adding a sleep(1) between the server's /* Send client the new
primary address */ sctp_sendmsg() call and sctp_bindx() calls. My
theory is that the client needs to call recvmsg() and start waiting
for the message before the server switches the address, otherwise the
expected timeout doesn't happen. If I add the missing permission, then
the test fails, so this could be the right fix.

What do you think?

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

