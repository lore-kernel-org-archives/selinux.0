Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58572C433EF
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3959161458
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhKHR5J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhKHR5I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 12:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636394062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHDFIOV3CXI6Wsaje4Kv070SM/Mjpt2tTuWevlrYVFo=;
        b=OJUm6lIN9kD+u8izTDL6gaWI2lvsLCK5Q7HXExA3Aunb473MV0oFlj7DGOLu6IiOEz0o58
        y+2xVjVpPnZPj/BtZ5/obETPe5dfO5icsklN0KtJClddqCugIUTK/WTbcaUCIqix3OmRmJ
        Otc0+hwIvKgCayZgmxLAE7FZe/I5JQ4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-IlzjrT48MAK6LLJnYLvC_g-1; Mon, 08 Nov 2021 12:54:19 -0500
X-MC-Unique: IlzjrT48MAK6LLJnYLvC_g-1
Received: by mail-yb1-f197.google.com with SMTP id d8-20020a253608000000b005c202405f52so26343045yba.7
        for <selinux@vger.kernel.org>; Mon, 08 Nov 2021 09:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHDFIOV3CXI6Wsaje4Kv070SM/Mjpt2tTuWevlrYVFo=;
        b=axBDqimHs24dqT4ydNimHKJZSXFIA+jr7J0vq3jeOxZ4I9fUi/QhR+1cfjZcTPXwGP
         DvuqvqstGy+QCuU/ZxuBehBdOHflcJhg1fBnLp0rP08fiiPhkk6rJzxoBHduw9OIH2VI
         5qTyEy2beZe6wcr5zUHEOq1ETZupU0lAMi6ZBq+lzL1s0GjC3DGV0BTDBtGnCFTiECbL
         v+xmVS/f90CzlIcNK/Pq/MmAOm56cNiE/OTEXXK63w/T9gdhVRW0E3rhvIcvQX9enJik
         z9hNNDsCBqyMiPusu3Zdxa62sCO4po63SXSpRZVgVc5NP85pq3OPfcuaUILiGxhiczn/
         8d4g==
X-Gm-Message-State: AOAM531L58QB90DistaGGlGxENRxU4eQt/3J+iXNAQ6VxsnzZg0DDzt5
        Cy09yZhvZYBt6cWsNeA3ff/nyK38sMgalputJkesRTpJ5LbSlta5ehWLWiPEZKSbqVxJxOeX0cy
        nJ03xqLrZtAb5/CSTzoPR1vYd5jBwZkA/UQ==
X-Received: by 2002:a25:8205:: with SMTP id q5mr1240281ybk.256.1636394058986;
        Mon, 08 Nov 2021 09:54:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyruxOYmFGhUlgt5PlE166kHSmsRvJMm9NbIxYIMdSENTRMn6QjHq1rhFjTAmcv8JrFylVI+OH8Rhe9rulG/+g=
X-Received: by 2002:a25:8205:: with SMTP id q5mr1240235ybk.256.1636394058721;
 Mon, 08 Nov 2021 09:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20211107142047.32727-1-richard_c_haines@btinternet.com> <20211107142047.32727-2-richard_c_haines@btinternet.com>
In-Reply-To: <20211107142047.32727-2-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 8 Nov 2021 18:54:09 +0100
Message-ID: <CAFqZXNvaChb_D4YFK6_WnXYVMZ3ZUpC4p9rDEbztOTa-Tb-znw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] testsuite sctp: Add tests for sctp_socket
 transition rules
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Richard,

On Sun, Nov 7, 2021 at 3:21 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add tests for sctp_socket type_transition rules and also using
> setsockcreatecon(3)
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  policy/test_sctp.te              | 57 ++++++++++++++++++++++++++++++++
>  tests/sctp/sctp_client.c         | 19 +++++++++--
>  tests/sctp/sctp_common.c         | 51 ++++++++++++++++++++++++++++
>  tests/sctp/sctp_common.h         |  2 ++
>  tests/sctp/sctp_peeloff_client.c | 21 +++++++++---
>  tests/sctp/sctp_peeloff_server.c | 18 ++++++++--
>  tests/sctp/sctp_server.c         | 18 ++++++++--
>  tests/sctp/test                  | 57 +++++++++++++++++++++++++++++++-
>  8 files changed, 231 insertions(+), 12 deletions(-)
>
[...]
> diff --git a/tests/sctp/sctp_peeloff_client.c b/tests/sctp/sctp_peeloff_client.c
> index 2d42c72..5470494 100644
> --- a/tests/sctp/sctp_peeloff_client.c
> +++ b/tests/sctp/sctp_peeloff_client.c
> @@ -3,13 +3,14 @@
>  static void usage(char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s [-e expected_msg] [-v] [-n] [-x] addr port\n"
> +               "usage:  %s [-e expected_msg] [-v] [-n] [-t type] [-x] addr port\n"
>                 "\nWhere:\n\t"
>
>                 "-e      Optional expected message from server e.g. \"nopeer\".\n\t"
>                 "        If not present the client context will be used as a\n\t"
>                 "        comparison with the servers reply.\n\t"
>                 "-n      Do NOT call connect(3) or connectx(3).\n\t"
> +               "-t      New type for setsockcreatecon(3) test.\n\t"
>                 "-v      Print context and ip options information.\n\t"
>                 "-x      Use sctp_connectx(3) instead of connect(3).\n\t"
>                 "addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
> @@ -28,10 +29,10 @@ int main(int argc, char **argv)
>         char byte = 0x41, label[1024], *expected = NULL;
>         bool verbose = false, connectx = false, no_connects = false;
>         bool ipv4 = false, expect_ipopt = false;
> -       char *context;
> +       char *context, *sock_type = NULL;
>         struct timeval tm;
>
> -       while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
> +       while ((opt = getopt(argc, argv, "e:t:vxmni")) != -1) {
>                 switch (opt) {
>                 case 'e':
>                         expected = optarg;
> @@ -45,6 +46,9 @@ int main(int argc, char **argv)
>                 case 'n':
>                         no_connects = true;
>                         break;
> +               case 't':
> +                       sock_type = optarg;
> +                       break;
>                 case 'x':
>                         connectx = true;
>                         break;
> @@ -187,11 +191,20 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       /* If -t option set new context for peeled off socket */
> +       if (sock_type) {
> +               result = set_newsock_con(sock_type, "Peeloff Client");
> +               if (result < 0) {
> +                       fprintf(stderr, "Failed setsockcreatecon(3)\n");
> +                       exit(20);
> +               }
> +       }
> +
>         peeloff_sk = sctp_peeloff(sock, assoc_id);
>         if (peeloff_sk < 0) {
>                 perror("Client sctp_peeloff");
>                 close(sock);
> -               exit(1);
> +               exit(21);
>         }
>         if (verbose) {
>                 printf("Client sctp_peeloff(3) on sk: %d with association ID: %d\n",

So are you implying that you expect the peeloff socket to get the
label via the usual transition-or-sockcreatecon mechanism, rather than
inheriting it from the parent socket? My current opinion is the
opposite, motivated by the (somewhat) analogical case of sockets
created via accept(2). Can you provide some arguments/use cases
showing why the SCTP peeloff socket should have this behavior? Or
would you argue that accept(2)-ed sockets should ideally also follow
the transition-or-sockcreatecon behavior? Should it be combined with
inheriting the parent socket's context by default or should each
socket get its label independently based only on the creating process?

Currently, the patches that Xin Long and I posted (or plan to post)
are heading in the direction of just inheriting the parent socket's
context. If there are good reasons to do it another way, I'm very
interested in hearing them.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

