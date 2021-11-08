Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3124DC433F5
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE06162E
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 19:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhKHTMn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhKHTMm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 14:12:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EE2C061570
        for <selinux@vger.kernel.org>; Mon,  8 Nov 2021 11:09:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m14so66093035edd.0
        for <selinux@vger.kernel.org>; Mon, 08 Nov 2021 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uz+Uur8qeZdN8vDxqN5lmhKxh1/U6VyDGbVmR6kIfks=;
        b=JdpRpC6xNItFDmsC+1OzmK9X3GPUsSYPeQ+fg+JxjrxcW4mLmTbUmLXTJXeNjJCjoe
         Ry/ipMRLYe9i4OvrhevRPgYRNjxPCUpT8Qmk4Xcm7tFaiWMOiLJ2bLQgch2zzi9GhNZg
         eykQ/uv7edi8BRwhuoHnMa2hFK7vs4MCtTIn7Pkt5U2EKlkCstvTOtvyFD25asKkkp35
         eq5PD+ltoCSrnpL02NLMV9LV068Cq4bpNiOUYhYEF2p0FJiDCNQgKFfG2sgd06KF/13k
         pe7N1vy8trqos5ePgQ05C0+n52Pd9Vhg/f7Xt0uxMkYCMm9eOHcZYTOl6YglWm9O3TnY
         awsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uz+Uur8qeZdN8vDxqN5lmhKxh1/U6VyDGbVmR6kIfks=;
        b=GqbCudtTsGpkI7DPo2mCagEbIkAhB4vhhr4rz4ZY/o25f8UdHLo+/e+IJMN8Uz1FYo
         6QW4VR+d8v3w8kaLoCTuQpgLAnAxI333SHDNRjDtl1f6ZLyfnjf2Bwyy9rmlFWBcviBf
         wi/DTn02w9GtvxnqhBK9JQDOeQEyKTmWQ8r9j63Dyf+rj+ux6wgFry45JqhvqB3lz3NS
         zKav13DLBjiEVDChLLNTknXpKl5amTmK8PdDvuyX4k5EDyQO+oZV+r/j+nzZ6njcEFFL
         2Cwr2HWM1iJhisYJ8lw5x9O1SU+pHar8n9A4ja/9Npl1jP70LJIP1jw/V04Vd5aaGcJa
         I/3A==
X-Gm-Message-State: AOAM530jjeR2fyAbOVfPccpJe+n5JBetZO+LfC4sSXpYIGfIbOaEjut8
        ePW3q9G0SYuso06kOZ6uZCL/3ZBMlZUXEd+pIRJC5vh+HQ==
X-Google-Smtp-Source: ABdhPJznmrffAA5XVLV+nak61U0vlojedY1p5Q+EN/lmmbA4OjeACYwAPo8Uxv4UMnVxkzheiCBEOifWzWa8Qxl/QSg=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr1921381ejc.24.1636398596041;
 Mon, 08 Nov 2021 11:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20211107142047.32727-1-richard_c_haines@btinternet.com>
 <20211107142047.32727-2-richard_c_haines@btinternet.com> <CAFqZXNvaChb_D4YFK6_WnXYVMZ3ZUpC4p9rDEbztOTa-Tb-znw@mail.gmail.com>
In-Reply-To: <CAFqZXNvaChb_D4YFK6_WnXYVMZ3ZUpC4p9rDEbztOTa-Tb-znw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Nov 2021 14:09:55 -0500
Message-ID: <CAHC9VhT-5PBb6R=FGWOmVySzaiADfPKQfhFgw_CZ2RmijiGDtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] testsuite sctp: Add tests for sctp_socket
 transition rules
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 8, 2021 at 12:54 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sun, Nov 7, 2021 at 3:21 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > Add tests for sctp_socket type_transition rules and also using
> > setsockcreatecon(3)
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  policy/test_sctp.te              | 57 ++++++++++++++++++++++++++++++++
> >  tests/sctp/sctp_client.c         | 19 +++++++++--
> >  tests/sctp/sctp_common.c         | 51 ++++++++++++++++++++++++++++
> >  tests/sctp/sctp_common.h         |  2 ++
> >  tests/sctp/sctp_peeloff_client.c | 21 +++++++++---
> >  tests/sctp/sctp_peeloff_server.c | 18 ++++++++--
> >  tests/sctp/sctp_server.c         | 18 ++++++++--
> >  tests/sctp/test                  | 57 +++++++++++++++++++++++++++++++-
> >  8 files changed, 231 insertions(+), 12 deletions(-)
> >
> [...]
> > diff --git a/tests/sctp/sctp_peeloff_client.c b/tests/sctp/sctp_peeloff_client.c
> > index 2d42c72..5470494 100644
> > --- a/tests/sctp/sctp_peeloff_client.c
> > +++ b/tests/sctp/sctp_peeloff_client.c
> > @@ -3,13 +3,14 @@
> >  static void usage(char *progname)
> >  {
> >         fprintf(stderr,
> > -               "usage:  %s [-e expected_msg] [-v] [-n] [-x] addr port\n"
> > +               "usage:  %s [-e expected_msg] [-v] [-n] [-t type] [-x] addr port\n"
> >                 "\nWhere:\n\t"
> >
> >                 "-e      Optional expected message from server e.g. \"nopeer\".\n\t"
> >                 "        If not present the client context will be used as a\n\t"
> >                 "        comparison with the servers reply.\n\t"
> >                 "-n      Do NOT call connect(3) or connectx(3).\n\t"
> > +               "-t      New type for setsockcreatecon(3) test.\n\t"
> >                 "-v      Print context and ip options information.\n\t"
> >                 "-x      Use sctp_connectx(3) instead of connect(3).\n\t"
> >                 "addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
> > @@ -28,10 +29,10 @@ int main(int argc, char **argv)
> >         char byte = 0x41, label[1024], *expected = NULL;
> >         bool verbose = false, connectx = false, no_connects = false;
> >         bool ipv4 = false, expect_ipopt = false;
> > -       char *context;
> > +       char *context, *sock_type = NULL;
> >         struct timeval tm;
> >
> > -       while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
> > +       while ((opt = getopt(argc, argv, "e:t:vxmni")) != -1) {
> >                 switch (opt) {
> >                 case 'e':
> >                         expected = optarg;
> > @@ -45,6 +46,9 @@ int main(int argc, char **argv)
> >                 case 'n':
> >                         no_connects = true;
> >                         break;
> > +               case 't':
> > +                       sock_type = optarg;
> > +                       break;
> >                 case 'x':
> >                         connectx = true;
> >                         break;
> > @@ -187,11 +191,20 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> >
> > +       /* If -t option set new context for peeled off socket */
> > +       if (sock_type) {
> > +               result = set_newsock_con(sock_type, "Peeloff Client");
> > +               if (result < 0) {
> > +                       fprintf(stderr, "Failed setsockcreatecon(3)\n");
> > +                       exit(20);
> > +               }
> > +       }
> > +
> >         peeloff_sk = sctp_peeloff(sock, assoc_id);
> >         if (peeloff_sk < 0) {
> >                 perror("Client sctp_peeloff");
> >                 close(sock);
> > -               exit(1);
> > +               exit(21);
> >         }
> >         if (verbose) {
> >                 printf("Client sctp_peeloff(3) on sk: %d with association ID: %d\n",
>
> So are you implying that you expect the peeloff socket to get the
> label via the usual transition-or-sockcreatecon mechanism, rather than
> inheriting it from the parent socket? My current opinion is the
> opposite, motivated by the (somewhat) analogical case of sockets
> created via accept(2). Can you provide some arguments/use cases
> showing why the SCTP peeloff socket should have this behavior? Or
> would you argue that accept(2)-ed sockets should ideally also follow
> the transition-or-sockcreatecon behavior? Should it be combined with
> inheriting the parent socket's context by default or should each
> socket get its label independently based only on the creating process?
>
> Currently, the patches that Xin Long and I posted (or plan to post)
> are heading in the direction of just inheriting the parent socket's
> context. If there are good reasons to do it another way, I'm very
> interested in hearing them.

FWIW, this is why I'm pushing to get all the fixes out on the list
with a good explanation of what we expect to happen in all of the
various SCTP operations.  There has been enough discussion about
different ways to handle this that I want to make sure we are okay
with the approach independent of the implementation details.

-- 
paul moore
www.paul-moore.com
