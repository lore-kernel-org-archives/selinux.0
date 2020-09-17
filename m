Return-Path: <SRS0=4esc=C2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC3C433E2
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC0A20665
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 07:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtazixuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIQH7K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIQH7H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Sep 2020 03:59:07 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:59:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600329541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QRFTCskYZfekIy8bElHfgSiZgLIx448bTgJ9TPQCs1c=;
        b=WtazixuOFsz1Qi91FKvF8DMhGWoWOti4/h6PW8cOVL4nssBaSwDwuMHaeRLAmQyuNNKsMl
        /1TZLFsASthjZF8YRE06n6kOvU0bJqjbJB75WrrNH4m4+BsyaYKBweGPW/TvImnu8wttFV
        QfMBbPKGx+Fa7LMmaXx8OKWhzV0kGYo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-6gyUbEO6Oga6vY6ZGc-_3g-1; Thu, 17 Sep 2020 03:52:07 -0400
X-MC-Unique: 6gyUbEO6Oga6vY6ZGc-_3g-1
Received: by mail-lf1-f71.google.com with SMTP id c194so193673lfg.14
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 00:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRFTCskYZfekIy8bElHfgSiZgLIx448bTgJ9TPQCs1c=;
        b=Q2ozljV9C5DX+Mnkwf1JCN31EdjOkewwQixp5xySJbQD+zLcXiMtIPAcpuXwjQaeDx
         uDRJW1H41ITFD94VXCkpuFBWbBRLdss2zPxlvmcr4PqSf71xt0GXAjRGGNqBqvfABUoN
         clLZxbRIUhgwNdeuvf10kLcRAGPMYx9x12oS7I+MGQSyT9bii51iZ951f2BgqgkCxJ4f
         rj36icguDlryZt8rCsM2e8SYT3h5Fp50qdU95aipv2zVGAFf6km12oo244GInj9uTjgb
         hB/Bdq2A43bF248NaJPPS5bGHahyBz3v7MyL7LRcbXBWD3Jn25fSfi+5EfXbMzYSm6vD
         aEyQ==
X-Gm-Message-State: AOAM530T4eTzkHrTpdkRQPXmASM3L0meVk6E6UDKVcEn+hvzHpkKXF3m
        afLTDws3E6/9QUnhwUp3wYJcxdXZJHaPoJro8PV/Wa+VPHLawdjs838Czn8di+ZE1Lny/TgU1Eh
        jcs3FTyrZZ3lhP+HMYKFADFxfNmn5kYVuhQ==
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr2981615ljj.77.1600329125041;
        Thu, 17 Sep 2020 00:52:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR2Kl4PO7Enl4yfZc52USjZoKHHvYw2bl3UODsIgDrUa3tax4GC6ugqWjE33b46OqJvU1rMoXFO3Z9vmog+Cw=
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr2981608ljj.77.1600329124661;
 Thu, 17 Sep 2020 00:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200826123719.26121-1-richard_c_haines@btinternet.com> <20200826123719.26121-2-richard_c_haines@btinternet.com>
In-Reply-To: <20200826123719.26121-2-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 17 Sep 2020 09:51:53 +0200
Message-ID: <CAFqZXNs5XNkM8aMYbF9eW9W0FFYV=+EJ_a+O9Dh+9tJXtk-s1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 2:37 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Reviewed the tests using kernel tree: Documentation/security/SCTP.rst, this
> added one additional test.
>
> The main changes have been to sctp_asconf_params_client.c and
> sctp_asconf_params_server.c to support the tests, and also to make them
> more reliable for running the client and server on different systems.
>
> Updated common code in sctp_common.c for sctp event handling and updated
> relevant programs to use handle_event()
>
> Removed obsolete code/policy.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
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
> diff --git a/tests/sctp/.gitignore b/tests/sctp/.gitignore
> index 8671c27..c022b11 100644
> --- a/tests/sctp/.gitignore
> +++ b/tests/sctp/.gitignore
> @@ -6,4 +6,3 @@ sctp_client
>  sctp_connectx
>  sctp_peeloff_server
>  sctp_server
> -sctp_set_peer_addr
> diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
> index f5dfdae..fbe8fb0 100644
> --- a/tests/sctp/Makefile
> +++ b/tests/sctp/Makefile
> @@ -1,4 +1,5 @@
> -TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx sctp_set_peer_addr sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
> +TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx \
> +sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server

Minor nit: please indent the continuation line (with 1 tab).

>
>  DEPS = sctp_common.c sctp_common.h
>  CFLAGS ?= -Wall
> diff --git a/tests/sctp/sctp_asconf_params_client.c b/tests/sctp/sctp_asconf_params_client.c
> index 12522f3..ada5982 100644
> --- a/tests/sctp/sctp_asconf_params_client.c
> +++ b/tests/sctp/sctp_asconf_params_client.c
> @@ -29,11 +29,9 @@
>  static void usage(char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s [-v] [-n] addr port\n"
> +               "usage:  %s [-v] addr port\n"
>                 "\nWhere:\n\t"
>                 "-v     Print status information.\n\t"
> -               "-n     No bindx_rem will be received from server. This happens\n\t"
> -               "       when the client and server are on different systems.\n\t"
>                 "addr   IPv4 or IPv6 address (MUST NOT be loopback address).\n\t"
>                 "port   port.\n", progname);
>
> @@ -46,75 +44,90 @@ static void usage(char *progname)
>         exit(1);
>  }
>
> -static int peer_count, peer_count_err;
> -static void getpaddrs_alarm(int sig)
> -{
> -       fprintf(stderr,
> -               "Get peer address count timer expired - carry on test\n");
> -       peer_count += 1;
> -       peer_count_err = true;
> -}
> -
> -static void getprimaddr_alarm(int sig)
> -{
> -       fprintf(stderr, "Get primary address timer expired - end test.\n");
> -       exit(1);
> -}
> -
> -static void get_primaddr(char *addr_buf, int socket)
> +static int get_set_primaddr(int socket, sctp_assoc_t id, bool verbose)
>  {
>         int result;
> -       struct sctp_prim prim;
> -       struct sockaddr_in *in_addr;
> -       struct sockaddr_in6 *in6_addr;
> -       struct sockaddr *paddr;
> +       struct sctp_prim prim;  /* Defined in linux/sctp.t */

linux/sctp.t -> linux/sctp.h

>         socklen_t prim_len;
> -       const char *addr_ptr = NULL;
> +
> +       /*
> +        * At this point the new primary address is already set. To test the
> +        * bind permission, just reset the address.
> +        */
>
>         memset(&prim, 0, sizeof(struct sctp_prim));
>         prim_len = sizeof(struct sctp_prim);
> +       prim.ssp_assoc_id = id;
>
>         result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
>                             &prim, &prim_len);
>         if (result < 0) {
> -               perror("getsockopt: SCTP_PRIMARY_ADDR");
> -               exit(1);
> +               perror("Client getsockopt: SCTP_PRIMARY_ADDR");
> +               return 50;
>         }
>
> -       paddr = (struct sockaddr *)&prim.ssp_addr;
> -       if (paddr->sa_family == AF_INET) {
> -               in_addr = (struct sockaddr_in *)&prim.ssp_addr;
> -               addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
> -                                    INET6_ADDRSTRLEN);
> -       } else if (paddr->sa_family == AF_INET6) {
> -               in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
> -               addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
> -                                    INET6_ADDRSTRLEN);
> +       if (verbose)
> +               print_addr_info((struct sockaddr *)&prim.ssp_addr,
> +                               "Client getsockopt - SCTP_PRIMARY_ADDR:");
> +
> +       /*
> +        * If the new primary address is an IPv6 local link address, it will
> +        * have been received by the DAR process with a scope id of '0'.
> +        * Therefore when the setsockopt is called it will error with EINVAL.
> +        * To resolve this set scope_id=1 (first link) before the call.
> +        */
> +       struct sockaddr_in6 *addr6;
> +       struct sockaddr *sin;
> +
> +       sin = (struct sockaddr *)&prim.ssp_addr;
> +
> +       if (sin->sa_family == AF_INET6) {
> +               addr6 = (struct sockaddr_in6 *)sin;
> +               if (IN6_IS_ADDR_LINKLOCAL(&addr6->sin6_addr) &&
> +                   ((struct sockaddr_in6 *)addr6)->sin6_scope_id == 0) {
> +                       ((struct sockaddr_in6 *)addr6)->sin6_scope_id = 1;
> +                       if (verbose)
> +                               printf("Client set new Local Link primary address scope_id=1\n");
> +               }
>         }
> -       if (!addr_ptr) {
> -               perror("inet_ntop");
> -               exit(1);
> +
> +       /*
> +        * This tests the net/sctp/socket.c sctp_setsockopt_primary_addr()
> +        * SCTP_PRIMARY_ADDR function by setting policy to:
> +        *   allow sctp_asconf_params_client_t self:sctp_socket { bind };
> +        * or:
> +        *   neverallow sctp_asconf_params_client_t self:sctp_socket { bind };
> +        */
> +       result = setsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
> +                           &prim, prim_len);
> +       if (result < 0) {
> +               perror("Client setsockopt: SCTP_PRIMARY_ADDR");
> +               return 51;
>         }
> +       if (verbose)
> +               print_addr_info((struct sockaddr *)&prim.ssp_addr,
> +                               "Client set SCTP_PRIMARY_ADDR to:");
> +       return 0;
>  }
>
>  int main(int argc, char **argv)
>  {
> -       int opt, client_sock, result, len;
> +       int opt, client_sock, result, flags = 0, on = 1;
>         struct addrinfo client_hints, *client_res;
> -       struct sockaddr *paddrs;
> -       bool verbose = false, no_bindx_rem = false;
> -       char client_prim_addr1[INET6_ADDRSTRLEN];
> -       char client_prim_addr2[INET6_ADDRSTRLEN];
> -       char buffer[1024];
> -
> -       while ((opt = getopt(argc, argv, "vn")) != -1) {
> +       struct sctp_sndrcvinfo sinfo;
> +       struct sockaddr_storage sin;
> +       socklen_t sinlen = sizeof(sin);
> +       struct timeval tm;
> +       bool verbose = false;
> +       char buffer[512];
> +       char msg[] = "Send peer address";
> +       char *rcv_new_addr_buf = NULL;
> +
> +       while ((opt = getopt(argc, argv, "v")) != -1) {
>                 switch (opt) {
>                 case 'v':
>                         verbose = true;
>                         break;
> -               case 'n':
> -                       no_bindx_rem = true;
> -                       break;
>                 default:
>                         usage(argv[0]);
>                 }
> @@ -123,176 +136,117 @@ int main(int argc, char **argv)
>         if ((argc - optind) != 2)
>                 usage(argv[0]);
>
> -       /* Set up client side and connect */
>         memset(&client_hints, 0, sizeof(struct addrinfo));
> -       client_hints.ai_socktype = SOCK_STREAM;
> +       client_hints.ai_socktype = SOCK_SEQPACKET;
>         client_hints.ai_protocol = IPPROTO_SCTP;
>         result = getaddrinfo(argv[optind], argv[optind + 1],
>                              &client_hints, &client_res);
>         if (result < 0) {
> -               fprintf(stderr, "getaddrinfo - client: %s\n",
> +               fprintf(stderr, "Client getaddrinfo err: %s\n",
>                         gai_strerror(result));
>                 exit(1);
>         }
>
> -
> -       /* printf("Client scopeID: %d\n",
> -        *        ((struct sockaddr_in6 *)client_res->ai_addr)->sin6_scope_id);
> -        */
> -
>         client_sock = socket(client_res->ai_family, client_res->ai_socktype,
>                              client_res->ai_protocol);
>         if (client_sock < 0) {
> -               perror("socket");
> +               perror("Client socket");
> +               freeaddrinfo(client_res);
>                 exit(1);
>         }
>
> -       result = connect(client_sock, client_res->ai_addr,
> -                        client_res->ai_addrlen);
> +       /* Need to set a timeout if no reply from server */
> +       memset(&tm, 0, sizeof(struct timeval));
> +       tm.tv_sec = 1;

Please use a higher value here (I'd recommend at least 3 seconds) - see:
https://lore.kernel.org/selinux/20200827081100.1954467-1-omosnace@redhat.com/

[...]

Other than the minor stuff above this looks good to me. Thank you for
the patch and for bearing with my slow reviews :)

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

