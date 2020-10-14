Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996CFC433E7
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D77E2222C
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH5cIBWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgJNSe1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388061AbgJNSe1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 14:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602700464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bdS6u1ehDzaM+rmQe2Uc9vqLW4YXACg/XGZvL1m7r8=;
        b=HH5cIBWln/OLqx7nixlb2SV1RK/BM0AGS1sow7P+mDOK0aUADMF8eKNYemTqI8gzDhoxUi
        cY3aAyc012u1GKlzbgMGaE4ceU3cg98WoTCSSSBKrFPlXSTLF+aTu2t7nFuhU7uQeK8wOi
        oxS/xyu/zbf5LnZgmfwM1jfYPY6DOrk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-h5uekfwxPTiTGPdRtT_K5w-1; Wed, 14 Oct 2020 14:34:22 -0400
X-MC-Unique: h5uekfwxPTiTGPdRtT_K5w-1
Received: by mail-lj1-f198.google.com with SMTP id 26so71877ljp.19
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2020 11:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bdS6u1ehDzaM+rmQe2Uc9vqLW4YXACg/XGZvL1m7r8=;
        b=nqh174DvRdwAx9I0oP3wwno4zChfx4Q17Kql7WiEW6r/QdR2ccB5IH0iuhcSpeGdBk
         Ps8OeC8yzxTrsqdiPJOoB07lU6G3Bsrc82VF47rMXUJNCFd1UGMstXWQQTrWk8vZ35vD
         5YrovXIxXcanrsNBMTJ36jUTI1PGJOKJlH3ydwaphM5JpEkdefB6IyJPbvjfwJqywohH
         Eo27BvW/fJ4oM+NkfALJxEVOcaSHtuzM8RTTuSmcaodkXds3jC06e22NXepfQ7NlNGRF
         lfOb14KrQRdERA41s017WAAOf0deJooW6CS/nqnzXrRwIca2243So3UE5oW9bD+V9w5P
         rZDw==
X-Gm-Message-State: AOAM533VPRl8oWICZNBXmom+HFzcysUep9bs6G+aUo60CUGpzM23v85J
        nmTBtLGs0ijUifkRZYs7AIWLNvb08KMxL23xiZzfpdd0kb9lTM7Pe3I2Fm1qXXfaJiVsBMNgTFW
        cEOpKln0p5C2fiMNnxLEnGj0APP88yUL4zA==
X-Received: by 2002:ac2:5501:: with SMTP id j1mr173873lfk.598.1602700460502;
        Wed, 14 Oct 2020 11:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+eHnFzlc9GUc97hMYJMHsQBcI4HIGzAn7a4xBMBQHuU1yBpAh0RgND0q2ZR0wLNWofh3btv2Zmg9lkRFms3w=
X-Received: by 2002:ac2:5501:: with SMTP id j1mr173867lfk.598.1602700460158;
 Wed, 14 Oct 2020 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
 <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com> <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
In-Reply-To: <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 14 Oct 2020 20:34:09 +0200
Message-ID: <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 14, 2020 at 8:14 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2020-10-14 at 13:07 +0200, Ondrej Mosnacek wrote:
> > On Tue, Sep 22, 2020 at 10:59 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > The main changes have been to sctp_asconf_params_client.c and
> > > sctp_asconf_params_server.c to make them more reliable for running
> > > the
> > > client and server on different systems.
> > >
> > > Updated common code in sctp_common.c for sctp event handling and
> > > updated
> > > relevant programs to use handle_event()
> > >
> > > Removed obsolete code/policy.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > > V2 Changes: Indent line, fix typo and increase timer to 3 secs as
> > > per
> > > Ondrej comments.
> > >
> > >  policy/test_sctp.te                    |  75 ++++-
> > >  tests/sctp/.gitignore                  |   1 -
> > >  tests/sctp/Makefile                    |   3 +-
> > >  tests/sctp/sctp_asconf_params_client.c | 322 ++++++++-----------
> > >  tests/sctp/sctp_asconf_params_server.c | 275 +++++++++-------
> > >  tests/sctp/sctp_common.c               | 189 ++++++++++-
> > >  tests/sctp/sctp_common.h               |  12 +-
> > >  tests/sctp/sctp_peeloff_server.c       |  42 +--
> > >  tests/sctp/sctp_server.c               |   4 +-
> > >  tests/sctp/sctp_set_peer_addr.c        | 415 -------------------
> > > ------
> > >  tests/sctp/test                        |  70 ++++-
> > >  11 files changed, 623 insertions(+), 785 deletions(-)
> > >  delete mode 100644 tests/sctp/sctp_set_peer_addr.c
> > >
> > [...]
> > > diff --git a/tests/sctp/test b/tests/sctp/test
> > > index b4462c9..eede42f 100755
> > > --- a/tests/sctp/test
> > > +++ b/tests/sctp/test
> > > @@ -50,7 +50,7 @@ BEGIN {
> > >          }
> > >
> > >          if ( $ipaddress[1] ne 0 and $ipaddress[0] ne $ipaddress[1]
> > > ) {
> > > -            $test_count += 2;
> > > +            $test_count += 3;
> > >              $test_asconf = 1;
> > >          }
> > >
> > > @@ -208,37 +208,77 @@ $result =
> > >  ok( $result >> 8 eq 2 );
> > >
> > >  #
> > > -######################### SET_PRI_ADDR SET_PEER_ADDR
> > > ########################
> > > +##################### Dynamic Address Reconfiguration
> > > #####################
> > > +#
> > > +# These tests require two non-loopback addresses.
> > > +#
> > > +# Server - setsockopt(SCTP_SET_PEER_PRIMARY_ADDR, $ipaddress[0]);
> > > +# net/sctp/sm_make_chunk.c sctp_process_asconf_param()
> > > SCTP_PARAM_SET_PRIMARY
> > > +# Server -> Client (Set $ipaddress[0] as primary - client acks)
> > > +#
> > > +# Server - sctp_bindx(SCTP_BINDX_ADD_ADDR, $ipaddress[1]);
> > > +# net/sctp/sm_make_chunk.c sctp_process_asconf_param()
> > > SCTP_PARAM_ADD_IP
> > > +# Server -> Client (Set $ipaddress[1] as primary - client acks)
> > > +#
> > > +# These are sent by the server and require bind permission. They
> > > are
> > > +# received by the client and the SCTP_PARAM_ADD_IP is validated
> > > when
> > > +# $ipaddress[1] is set for use via:
> > > +#    net/sctp/socket.c
> > > sctp_setsockopt_peer_primary_addr(setsockopt(SCTP_PRIMARY_ADDR))
> > > +# This requires the 'bind' permission, if not granted client exits
> > > with 51.
> > >  #
> > >
> > > -# These tests require two local non-loopback addresses.
> > >  if ($test_asconf) {
> > > -    print "# Testing asconf parameter chunk processing.\n";
> > >
> > > -    # To enable processing of incoming ASCONF parameters:
> > > -    # SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and
> > > SCTP_PARAM_DEL_IP,
> > > -    # need to set:
> > > +    # To enable processing of ASCONF parameters
> > > SCTP_PARAM_SET_PRIMARY
> > > +    # and SCTP_PARAM_ADD_IP need to set:
> > >      system("echo 1 > /proc/sys/net/sctp/addip_enable");
> > >      system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
> > >
> > > -    # Verify ASCONF params.
> > > +    print "Testing Dynamic Address Reconfiguration\n";
> > > +
> > > +    # Server should automatically exit after each test
> > > +    $pid = server_start(
> > > +        "-t sctp_asconf_params_server_t",
> > > +        "sctp_asconf_params_server",
> > > +        "$v $ipaddress[0] $ipaddress[1] 1035"
> > > +    );
> > > +
> > >      $result = system
> > > -"runcon -t test_sctp_set_peer_addr_t $basedir/sctp_set_peer_addr
> > > $v $ipaddress[0] $ipaddress[1] 1035";
> > > +"runcon -t sctp_asconf_params_client_t
> > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035";
> > >      ok( $result eq 0 );
> > >
> > > -    # Start the asconf server.
> > > +    server_end($pid);
> > > +
> > > +    $pid = server_start(
> > > +        "-t sctp_asconf_params_server_t",
> > > +        "sctp_asconf_params_server",
> > > +        "$v $ipaddress[0] $ipaddress[1] 1035"
> > > +    );
> > > +
> > > +    print "Testing deny SCTP_PRIMARY_ADDR\n";
> > > +    $result = system
> > > +"runcon -t sctp_asconf_deny_pri_addr_client_t
> > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> > > +    ok( $result >> 8 eq 51 );    # setsockopt(2) failed
> > > +
> > > +    server_end($pid);
> > > +
> > > +    #
> > > +    # This is a local only test as it's the neverallow rule that
> > > stops:
> > > +    #    server -> client sctp_socket { connect };
> > > +    #
> > > +    # Srv sends SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY in
> > > ASCONF's
> > > +    # Client returns ASCONF_ACK's with 'Request refused - no
> > > authorization'
> > >      $pid = server_start(
> > > -        "-t test_sctp_set_peer_addr_t",
> > > +        "-t sctp_asconf_params_server_t",
> > >          "sctp_asconf_params_server",
> > >          "$v $ipaddress[0] $ipaddress[1] 1035"
> > >      );
> > >
> > > -# This should fail connect permission attempting to send
> > > SCTP_PARAM_ADD_IP to client.
> > > +    print "Testing deny
> > > SCTP_PARAM_ADD_IP/SCTP_PARAM_SET_PRIMARY\n";
> > >      $result = system
> > > -"runcon -t test_sctp_client_t --
> > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> > > -    ok($result);
> > > +"runcon -t sctp_asconf_deny_param_add_client_t
> > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> > > +    ok( $result >> 8 eq 11 );   # Client error 'Dynamic Address
> > > Reconfiguration'
> >
> > I just experimented with automatically setting up a second IPv4
> > address in the test (using a GRE tunnel over localhost) and this
> > particular test is failing for me on the current 5.8.14 Fedora 32
> > kernel, as well as on 5.9 in Rawhide. It seems that the command fails
> > with the same exit code as the previous one ($result >> 8 eq 51, not
> > 11). Interestingly, on RHEL-8 it passes, so it seems that the
> > behavior
> > has changed upstream at some point. Does anyone have any idea what
> > might be the cause? Is it a bug in the kernel or the test?
>
> Could you detail how you set up the second IPv4/GRE please so that I
> can test this. It seems like the kernel from what you say, although I
> couldn't see any major changes in the sm_make_chunk.c area. The test
> should fail well before the error 51 because of:
>
> # net/sctp/sm_make_chunk.c sctp_process_asconf_param()
> SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
> # neverallow sctp_asconf_params_server_t
> sctp_asconf_deny_param_add_client_t:sctp_socket { connect };

I used basically this patch:
https://github.com/WOnder93/selinux-testsuite/commit/3216dc361540f16eac0439fc73ebccf8e70fefc9.patch

>
> >
> > > -    # The server should automatically exit.
> > >      server_end($pid);
> > >
> > >      system("echo 0 > /proc/sys/net/sctp/addip_enable");
> > > --
> > > 2.26.2
> > >
>


-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

