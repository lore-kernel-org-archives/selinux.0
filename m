Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0023C433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 10:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521BC2145D
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 10:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts5AryEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbgJOK2y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389319AbgJOK2y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 06:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602757731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSlR9h60jGfzDPdE7nvLabVcaGVU5kH5lc4ND341PGE=;
        b=Ts5AryEwkKAjB9cYfNHGgks3qyFlKgGbNaLZW95JjmxtRyic+RdwqCrqPA+N/EMEwjtB8s
        RvxjvSSu1BoFLldVJxFDWSolCRHPNINGzbsofsYjISKZTJgm437rWaHLZc/liqqsxUhBz8
        Dy4so4L4fvTo/IRBwaMyArWWpleQhkk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-KEZ4hcpWNhueMIOCCa_mqw-1; Thu, 15 Oct 2020 06:28:47 -0400
X-MC-Unique: KEZ4hcpWNhueMIOCCa_mqw-1
Received: by mail-lj1-f200.google.com with SMTP id g15so1015483ljj.12
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 03:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSlR9h60jGfzDPdE7nvLabVcaGVU5kH5lc4ND341PGE=;
        b=XfyzRsRVjPbnYA6KD0yYBqw8vY49p++RMzdYpbadezXLHaxWxpnZDdbUl8ktLMm02E
         fS0cXIi+WFczwnEDY2L4i51+u8rWiFyyelLY+cSsd1C2U8NBqUSP9M+Irr1183QY6Fmo
         CLbAQzpyCavtjHpT2QhRVsqzdJCXyN7QDy+cyNi986iDDQNy1q07W357cZEaU3o/eCYg
         iKSU+NwaW4QyYY59WbySxNDy+x2NDsAJ+Xqq44yxaN/oVvsmzpC0QJq+KNh4G+5yxrTj
         1r8iHLdyQvA39BwAg7sGoEOz8ym1+6iR+O/ImhOnE3yiLAhr28l9bX9qpLpZibieME9k
         TEHA==
X-Gm-Message-State: AOAM530XqnYZUM+2M2WHNxCYmhTz2U0K3irWNlJX6z/1zWrVmgd6cAVV
        ouYohIuBr9XcQfup0EwbbfzGPgJWj9TJbYqQg6OD0RRyUray2uBvrP/JDub5EdE9l8PrvEKOOeU
        DJhGAn97vSUV8FmgfHtHZg77NwRBJWQmF8Q==
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr814989lfr.247.1602757726045;
        Thu, 15 Oct 2020 03:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIVv32hbdOzob91Q4dZAWAyJsCfCxh3NTvZc0QOzixj6Imc+V+wCFrOucC0+Qe3mcRSH3Dtzg+D69dHzyE+Hs=
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr814980lfr.247.1602757725638;
 Thu, 15 Oct 2020 03:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
 <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
 <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
 <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com> <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
In-Reply-To: <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 15 Oct 2020 12:28:34 +0200
Message-ID: <CAFqZXNspQBJeM1v+aExWTc4Hk2+MZ8oFaLCUWANOusboSho2Dg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 11:06 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2020-10-14 at 20:34 +0200, Ondrej Mosnacek wrote:
> > On Wed, Oct 14, 2020 at 8:14 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > On Wed, 2020-10-14 at 13:07 +0200, Ondrej Mosnacek wrote:
> > > > On Tue, Sep 22, 2020 at 10:59 AM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > > The main changes have been to sctp_asconf_params_client.c and
> > > > > sctp_asconf_params_server.c to make them more reliable for
> > > > > running
> > > > > the
> > > > > client and server on different systems.
> > > > >
> > > > > Updated common code in sctp_common.c for sctp event handling
> > > > > and
> > > > > updated
> > > > > relevant programs to use handle_event()
> > > > >
> > > > > Removed obsolete code/policy.
> > > > >
> > > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > > ---
> > > > > V2 Changes: Indent line, fix typo and increase timer to 3 secs
> > > > > as
> > > > > per
> > > > > Ondrej comments.
> > > > >
> > > > >  policy/test_sctp.te                    |  75 ++++-
> > > > >  tests/sctp/.gitignore                  |   1 -
> > > > >  tests/sctp/Makefile                    |   3 +-
> > > > >  tests/sctp/sctp_asconf_params_client.c | 322 ++++++++---------
> > > > > --
> > > > >  tests/sctp/sctp_asconf_params_server.c | 275 +++++++++-------
> > > > >  tests/sctp/sctp_common.c               | 189 ++++++++++-
> > > > >  tests/sctp/sctp_common.h               |  12 +-
> > > > >  tests/sctp/sctp_peeloff_server.c       |  42 +--
> > > > >  tests/sctp/sctp_server.c               |   4 +-
> > > > >  tests/sctp/sctp_set_peer_addr.c        | 415 ---------------
> > > > > ----
> > > > > ------
> > > > >  tests/sctp/test                        |  70 ++++-
> > > > >  11 files changed, 623 insertions(+), 785 deletions(-)
> > > > >  delete mode 100644 tests/sctp/sctp_set_peer_addr.c
> > > > >
> > > > [...]
> > > > > diff --git a/tests/sctp/test b/tests/sctp/test
> > > > > index b4462c9..eede42f 100755
> > > > > --- a/tests/sctp/test
> > > > > +++ b/tests/sctp/test
> > > > > @@ -50,7 +50,7 @@ BEGIN {
> > > > >          }
> > > > >
> > > > >          if ( $ipaddress[1] ne 0 and $ipaddress[0] ne
> > > > > $ipaddress[1]
> > > > > ) {
> > > > > -            $test_count += 2;
> > > > > +            $test_count += 3;
> > > > >              $test_asconf = 1;
> > > > >          }
> > > > >
> > > > > @@ -208,37 +208,77 @@ $result =
> > > > >  ok( $result >> 8 eq 2 );
> > > > >
> > > > >  #
> > > > > -######################### SET_PRI_ADDR SET_PEER_ADDR
> > > > > ########################
> > > > > +##################### Dynamic Address Reconfiguration
> > > > > #####################
> > > > > +#
> > > > > +# These tests require two non-loopback addresses.
> > > > > +#
> > > > > +# Server - setsockopt(SCTP_SET_PEER_PRIMARY_ADDR,
> > > > > $ipaddress[0]);
> > > > > +# net/sctp/sm_make_chunk.c sctp_process_asconf_param()
> > > > > SCTP_PARAM_SET_PRIMARY
> > > > > +# Server -> Client (Set $ipaddress[0] as primary - client
> > > > > acks)
> > > > > +#
> > > > > +# Server - sctp_bindx(SCTP_BINDX_ADD_ADDR, $ipaddress[1]);
> > > > > +# net/sctp/sm_make_chunk.c sctp_process_asconf_param()
> > > > > SCTP_PARAM_ADD_IP
> > > > > +# Server -> Client (Set $ipaddress[1] as primary - client
> > > > > acks)
> > > > > +#
> > > > > +# These are sent by the server and require bind permission.
> > > > > They
> > > > > are
> > > > > +# received by the client and the SCTP_PARAM_ADD_IP is
> > > > > validated
> > > > > when
> > > > > +# $ipaddress[1] is set for use via:
> > > > > +#    net/sctp/socket.c
> > > > > sctp_setsockopt_peer_primary_addr(setsockopt(SCTP_PRIMARY_ADDR)
> > > > > )
> > > > > +# This requires the 'bind' permission, if not granted client
> > > > > exits
> > > > > with 51.
> > > > >  #
> > > > >
> > > > > -# These tests require two local non-loopback addresses.
> > > > >  if ($test_asconf) {
> > > > > -    print "# Testing asconf parameter chunk processing.\n";
> > > > >
> > > > > -    # To enable processing of incoming ASCONF parameters:
> > > > > -    # SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and
> > > > > SCTP_PARAM_DEL_IP,
> > > > > -    # need to set:
> > > > > +    # To enable processing of ASCONF parameters
> > > > > SCTP_PARAM_SET_PRIMARY
> > > > > +    # and SCTP_PARAM_ADD_IP need to set:
> > > > >      system("echo 1 > /proc/sys/net/sctp/addip_enable");
> > > > >      system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
> > > > >
> > > > > -    # Verify ASCONF params.
> > > > > +    print "Testing Dynamic Address Reconfiguration\n";
> > > > > +
> > > > > +    # Server should automatically exit after each test
> > > > > +    $pid = server_start(
> > > > > +        "-t sctp_asconf_params_server_t",
> > > > > +        "sctp_asconf_params_server",
> > > > > +        "$v $ipaddress[0] $ipaddress[1] 1035"
> > > > > +    );
> > > > > +
> > > > >      $result = system
> > > > > -"runcon -t test_sctp_set_peer_addr_t
> > > > > $basedir/sctp_set_peer_addr
> > > > > $v $ipaddress[0] $ipaddress[1] 1035";
> > > > > +"runcon -t sctp_asconf_params_client_t
> > > > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035";
> > > > >      ok( $result eq 0 );
> > > > >
> > > > > -    # Start the asconf server.
> > > > > +    server_end($pid);
> > > > > +
> > > > > +    $pid = server_start(
> > > > > +        "-t sctp_asconf_params_server_t",
> > > > > +        "sctp_asconf_params_server",
> > > > > +        "$v $ipaddress[0] $ipaddress[1] 1035"
> > > > > +    );
> > > > > +
> > > > > +    print "Testing deny SCTP_PRIMARY_ADDR\n";
> > > > > +    $result = system
> > > > > +"runcon -t sctp_asconf_deny_pri_addr_client_t
> > > > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> > > > > +    ok( $result >> 8 eq 51 );    # setsockopt(2) failed
> > > > > +
> > > > > +    server_end($pid);
> > > > > +
> > > > > +    #
> > > > > +    # This is a local only test as it's the neverallow rule
> > > > > that
> > > > > stops:
> > > > > +    #    server -> client sctp_socket { connect };
> > > > > +    #
> > > > > +    # Srv sends SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
> > > > > in
> > > > > ASCONF's
> > > > > +    # Client returns ASCONF_ACK's with 'Request refused - no
> > > > > authorization'
> > > > >      $pid = server_start(
> > > > > -        "-t test_sctp_set_peer_addr_t",
> > > > > +        "-t sctp_asconf_params_server_t",
> > > > >          "sctp_asconf_params_server",
> > > > >          "$v $ipaddress[0] $ipaddress[1] 1035"
> > > > >      );
> > > > >
> > > > > -# This should fail connect permission attempting to send
> > > > > SCTP_PARAM_ADD_IP to client.
> > > > > +    print "Testing deny
> > > > > SCTP_PARAM_ADD_IP/SCTP_PARAM_SET_PRIMARY\n";
> > > > >      $result = system
> > > > > -"runcon -t test_sctp_client_t --
> > > > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> > > > > -    ok($result);
> > > > > +"runcon -t sctp_asconf_deny_param_add_client_t
> > > > > $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> > > > > +    ok( $result >> 8 eq 11 );   # Client error 'Dynamic
> > > > > Address
> > > > > Reconfiguration'
> > > >
> > > > I just experimented with automatically setting up a second IPv4
> > > > address in the test (using a GRE tunnel over localhost) and this
> > > > particular test is failing for me on the current 5.8.14 Fedora 32
> > > > kernel, as well as on 5.9 in Rawhide. It seems that the command
> > > > fails
> > > > with the same exit code as the previous one ($result >> 8 eq 51,
> > > > not
> > > > 11). Interestingly, on RHEL-8 it passes, so it seems that the
> > > > behavior
> > > > has changed upstream at some point. Does anyone have any idea
> > > > what
> > > > might be the cause? Is it a bug in the kernel or the test?
> > >
> > > Could you detail how you set up the second IPv4/GRE please so that
> > > I
> > > can test this. It seems like the kernel from what you say, although
> > > I
> > > couldn't see any major changes in the sm_make_chunk.c area. The
> > > test
> > > should fail well before the error 51 because of:
> > >
> > > # net/sctp/sm_make_chunk.c sctp_process_asconf_param()
> > > SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
> > > # neverallow sctp_asconf_params_server_t
> > > sctp_asconf_deny_param_add_client_t:sctp_socket { connect };
> >
> > I used basically this patch:
> > https://github.com/WOnder93/selinux-testsuite/commit/3216dc361540f16eac0439fc73ebccf8e70fefc9.patch
>
>
> I haven't been able to simulate this problem on my Fedora 32 WS using
> 5.8.13-200.fc32.x86_64.
>
> To be able to use the new address I had to switch off wifi. I then ran
> the test adding a 'print "$ipaddress_list\n";' statement that shows:
>
> 4: virbr0    inet 192.168.122.1/24 brd 192.168.122.255 scope global
> virbr0\       valid_lft forever preferred_lft forever
> 23: mygre    inet 10.123.123.123/32 scope global mygre\       valid_lft
> forever preferred_lft forever
>
> Then running the tests
> 1..99
> ipaddress[0]: 192.168.122.1 ipaddress[1]: 10.123.123.123
> Testing deny SCTP_PARAM_ADD_IP/SCTP_PARAM_SET_PRIMARY
> Client error 'Dynamic Address Reconfiguration'
> ok 17
>
> I did switch the addresses over, however still passed.

That's strange, I'll try to investigate it a bit more on my end... If
it helps, this is (the relevant part of) the strace from the test
binary (Fedora 32):
```
socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 3
setsockopt(3, SOL_SOCKET, SO_RCVTIMEO_OLD,
"\4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) = 0
setsockopt(3, SOL_SOCKET, SO_SNDTIMEO_OLD,
"\4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.0.138.59")}, 16) = 0
setsockopt(3, SOL_SCTP, SCTP_EVENTS, "\1\1\1\0\0\1", 6) = 0
sendmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.0.138.59")}, msg_namelen=16,
msg_iov=[{iov_base="Send peer address\0", iov_len=18}], msg_iovlen=1,
msg_control=[{cmsg_len=48, cmsg_level=SOL_SCTP, cmsg
_type=0x1}], msg_controllen=48, msg_flags=0}, 0) = 18
recvmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.123.123.123")}, msg_namelen=128->16,
msg_iov=[{iov_base="\2\200\0\0\224\0\0\0\2\0\4\v\n\0\212;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
iov_len=512}], msg_
iovlen=1, msg_controllen=0, msg_flags=MSG_EOR|MSG_MORE}, 0) = 148
recvmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.0.138.59")}, msg_namelen=16,
msg_iov=[{iov_base="10.123.123.123", iov_len=512}], msg_iovlen=1,
msg_control=[{cmsg_len=48, cmsg_level=SOL_SCTP, cmsg_typ
e=0x1}], msg_controllen=48, msg_flags=MSG_EOR}, MSG_EOR|MSG_MORE) = 14
recvmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.123.123.123")}, msg_namelen=16,
msg_iov=[{iov_base="\2\200\0\0\224\0\0\0\2\0\4\v\n{{{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
iov_len=512}], msg_iovlen=1,
msg_controllen=0, msg_flags=MSG_EOR|MSG_MORE}, MSG_EOR) = 148
recvmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.123.123.123")}, msg_namelen=16,
msg_iov=[{iov_base="\2\200\0\0\224\0\0\0\2\0\4\v\n{{{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
iov_len=512}], msg_iovlen=1,
msg_controllen=0, msg_flags=MSG_EOR|MSG_MORE}, MSG_EOR|MSG_MORE) = 148
getsockopt(3, SOL_SCTP, SCTP_PRIMARY_ADDR,
"\21\1\0\0\2\0\4\v\n{{{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
[132]) = 0
setsockopt(3, SOL_SCTP, SCTP_PRIMARY_ADDR,
"\21\1\0\0\2\0\4\v\n{{{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
132) = -1 EACCES (Permission denied)
dup(2)                                  = 4
fcntl(4, F_GETFL)                       = 0x1 (flags O_WRONLY)
close(4)                                = 0
write(2, "Client setsockopt: SCTP_PRIMARY_"..., 56Client setsockopt:
SCTP_PRIMARY_ADDR: Permission denied
) = 56
close(3)                                = 0
exit_group(51)                          = ?
```

And here is the same from RHEL-8:
```
socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 3
setsockopt(3, SOL_SOCKET, SO_RCVTIMEO_OLD,
"\4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) = 0
setsockopt(3, SOL_SOCKET, SO_SNDTIMEO_OLD,
"\4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.0.139.83")}, 16) = 0
setsockopt(3, SOL_SCTP, SCTP_EVENTS, "\1\1\1\0\0\1", 6) = 0
sendmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.0.139.83")}, msg_namelen=16,
msg_iov=[{iov_base="Send peer address\0", iov_len=18}], msg_iovlen=1,
msg_control=[{cmsg_len=48, cmsg_level=SOL_SCTP, cmsg
_type=0x1}], msg_controllen=48, msg_flags=0}, 0) = 18
recvmsg(3, {msg_name={sa_family=AF_INET, sin_port=htons(1035),
sin_addr=inet_addr("10.0.139.83")}, msg_namelen=128->16,
msg_iov=[{iov_base="10.123.123.123", iov_len=512}], msg_iovlen=1,
msg_control=[{cmsg_len=48, cmsg_level=SOL_SCTP, cms
g_type=0x1}], msg_controllen=48, msg_flags=MSG_EOR}, 0) = 14
recvmsg(3, {msg_namelen=16}, MSG_EOR)   = -1 EAGAIN (Resource
temporarily unavailable)
write(2, "Client error 'Dynamic Address Re"..., 47Client error
'Dynamic Address Reconfiguration'
) = 47
close(3)                                = 0
exit_group(11)                          = ?
```

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

