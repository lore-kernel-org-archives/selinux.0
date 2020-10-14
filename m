Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C6C433E7
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D120C206D5
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 11:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVsLq7va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgJNLHd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 07:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgJNLHc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 07:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602673650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ObVtHm1uaUQKJxC2qrQ6Vet5um7Cn4+B959c30CLrc=;
        b=YVsLq7va53OG99aNFPb0NnyruSDW+NQL6gRHxBtMk3Cwvkkh2BEa/tcPavm7zNHCpJ+crV
        U2h5UBZzOxPghD1HLBfZpshYgMHIS35MwpfTEyOpNX1CwtCKWVnvGSzG8+sb3aNmRXWF3a
        POyj+UzzJ47u4BliTzp9lC/u4NHmnmw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-JM2_VQ2hO-mBiWTDRgbbDQ-1; Wed, 14 Oct 2020 07:07:28 -0400
X-MC-Unique: JM2_VQ2hO-mBiWTDRgbbDQ-1
Received: by mail-lf1-f72.google.com with SMTP id y20so361256lff.6
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2020 04:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ObVtHm1uaUQKJxC2qrQ6Vet5um7Cn4+B959c30CLrc=;
        b=dbnSOb1ZtG0NUyWtllw7Ka53OTk8mvVtq1LiaUKk0OUSl24MXzY7M5wrIPp7Q505ZF
         y7uloHp1VxwOTFAtA9cuYIxfY4DTPW5tgxs7S5YdYb6AwtLuKnb8FRsJd5ccNLQSoBKI
         fImRCZl5wnFl/KVIENyVxF/MYMBjKvEqrzmpNEqjuaTMGFpMkQR+TBbhW6L+VT4MOODo
         TE8WErP4oC1zTx3Xdghf9ow08T4sccBb5VvztWyvgJI47PnzIfrML0Vu/dCwltIbOsN0
         cAn4gVzZ/Mg4qTtQDY3ueQR9nmOk9mvDs7gyUZfeUSlLZQKDIdWrKY3dJjomBkHT6ZyN
         3u0A==
X-Gm-Message-State: AOAM5313qcVD4wyAB5jnl7qINFC81AVcJBW5jVBGlEMaRDrz7mpBO7xm
        5Gi2g+R1Sb3Uos8BCHf/f/7SfGcWqWy3AeWfpiVPGe83qFEGATVU/UZY1RQ+QHzp+EqaOGGrjI8
        BHR2XeXtQ1lC/Jxp+awlctbaXK0IGWeAkuQ==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr1515617ljc.217.1602673646524;
        Wed, 14 Oct 2020 04:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp5QDXXYPpxRgZKpOP4Of57oRVtAcOB9ZdXUHrHs9RV1ZmWNECe0x7zXj5f8P4YOUX91mmepdKH1lxrLFpcM0=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr1515609ljc.217.1602673646246;
 Wed, 14 Oct 2020 04:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200922085902.18315-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 14 Oct 2020 13:07:15 +0200
Message-ID: <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 22, 2020 at 10:59 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> The main changes have been to sctp_asconf_params_client.c and
> sctp_asconf_params_server.c to make them more reliable for running the
> client and server on different systems.
>
> Updated common code in sctp_common.c for sctp event handling and updated
> relevant programs to use handle_event()
>
> Removed obsolete code/policy.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes: Indent line, fix typo and increase timer to 3 secs as per
> Ondrej comments.
>
>  policy/test_sctp.te                    |  75 ++++-
>  tests/sctp/.gitignore                  |   1 -
>  tests/sctp/Makefile                    |   3 +-
>  tests/sctp/sctp_asconf_params_client.c | 322 ++++++++-----------
>  tests/sctp/sctp_asconf_params_server.c | 275 +++++++++-------
>  tests/sctp/sctp_common.c               | 189 ++++++++++-
>  tests/sctp/sctp_common.h               |  12 +-
>  tests/sctp/sctp_peeloff_server.c       |  42 +--
>  tests/sctp/sctp_server.c               |   4 +-
>  tests/sctp/sctp_set_peer_addr.c        | 415 -------------------------
>  tests/sctp/test                        |  70 ++++-
>  11 files changed, 623 insertions(+), 785 deletions(-)
>  delete mode 100644 tests/sctp/sctp_set_peer_addr.c
>
[...]
> diff --git a/tests/sctp/test b/tests/sctp/test
> index b4462c9..eede42f 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -50,7 +50,7 @@ BEGIN {
>          }
>
>          if ( $ipaddress[1] ne 0 and $ipaddress[0] ne $ipaddress[1] ) {
> -            $test_count += 2;
> +            $test_count += 3;
>              $test_asconf = 1;
>          }
>
> @@ -208,37 +208,77 @@ $result =
>  ok( $result >> 8 eq 2 );
>
>  #
> -######################### SET_PRI_ADDR SET_PEER_ADDR ########################
> +##################### Dynamic Address Reconfiguration #####################
> +#
> +# These tests require two non-loopback addresses.
> +#
> +# Server - setsockopt(SCTP_SET_PEER_PRIMARY_ADDR, $ipaddress[0]);
> +# net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_SET_PRIMARY
> +# Server -> Client (Set $ipaddress[0] as primary - client acks)
> +#
> +# Server - sctp_bindx(SCTP_BINDX_ADD_ADDR, $ipaddress[1]);
> +# net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP
> +# Server -> Client (Set $ipaddress[1] as primary - client acks)
> +#
> +# These are sent by the server and require bind permission. They are
> +# received by the client and the SCTP_PARAM_ADD_IP is validated when
> +# $ipaddress[1] is set for use via:
> +#    net/sctp/socket.c sctp_setsockopt_peer_primary_addr(setsockopt(SCTP_PRIMARY_ADDR))
> +# This requires the 'bind' permission, if not granted client exits with 51.
>  #
>
> -# These tests require two local non-loopback addresses.
>  if ($test_asconf) {
> -    print "# Testing asconf parameter chunk processing.\n";
>
> -    # To enable processing of incoming ASCONF parameters:
> -    # SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and SCTP_PARAM_DEL_IP,
> -    # need to set:
> +    # To enable processing of ASCONF parameters SCTP_PARAM_SET_PRIMARY
> +    # and SCTP_PARAM_ADD_IP need to set:
>      system("echo 1 > /proc/sys/net/sctp/addip_enable");
>      system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
>
> -    # Verify ASCONF params.
> +    print "Testing Dynamic Address Reconfiguration\n";
> +
> +    # Server should automatically exit after each test
> +    $pid = server_start(
> +        "-t sctp_asconf_params_server_t",
> +        "sctp_asconf_params_server",
> +        "$v $ipaddress[0] $ipaddress[1] 1035"
> +    );
> +
>      $result = system
> -"runcon -t test_sctp_set_peer_addr_t $basedir/sctp_set_peer_addr $v $ipaddress[0] $ipaddress[1] 1035";
> +"runcon -t sctp_asconf_params_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035";
>      ok( $result eq 0 );
>
> -    # Start the asconf server.
> +    server_end($pid);
> +
> +    $pid = server_start(
> +        "-t sctp_asconf_params_server_t",
> +        "sctp_asconf_params_server",
> +        "$v $ipaddress[0] $ipaddress[1] 1035"
> +    );
> +
> +    print "Testing deny SCTP_PRIMARY_ADDR\n";
> +    $result = system
> +"runcon -t sctp_asconf_deny_pri_addr_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> +    ok( $result >> 8 eq 51 );    # setsockopt(2) failed
> +
> +    server_end($pid);
> +
> +    #
> +    # This is a local only test as it's the neverallow rule that stops:
> +    #    server -> client sctp_socket { connect };
> +    #
> +    # Srv sends SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY in ASCONF's
> +    # Client returns ASCONF_ACK's with 'Request refused - no authorization'
>      $pid = server_start(
> -        "-t test_sctp_set_peer_addr_t",
> +        "-t sctp_asconf_params_server_t",
>          "sctp_asconf_params_server",
>          "$v $ipaddress[0] $ipaddress[1] 1035"
>      );
>
> -# This should fail connect permission attempting to send SCTP_PARAM_ADD_IP to client.
> +    print "Testing deny SCTP_PARAM_ADD_IP/SCTP_PARAM_SET_PRIMARY\n";
>      $result = system
> -"runcon -t test_sctp_client_t -- $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> -    ok($result);
> +"runcon -t sctp_asconf_deny_param_add_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
> +    ok( $result >> 8 eq 11 );   # Client error 'Dynamic Address Reconfiguration'

I just experimented with automatically setting up a second IPv4
address in the test (using a GRE tunnel over localhost) and this
particular test is failing for me on the current 5.8.14 Fedora 32
kernel, as well as on 5.9 in Rawhide. It seems that the command fails
with the same exit code as the previous one ($result >> 8 eq 51, not
11). Interestingly, on RHEL-8 it passes, so it seems that the behavior
has changed upstream at some point. Does anyone have any idea what
might be the cause? Is it a bug in the kernel or the test?

>
> -    # The server should automatically exit.
>      server_end($pid);
>
>      system("echo 0 > /proc/sys/net/sctp/addip_enable");
> --
> 2.26.2
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

