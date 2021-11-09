Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DA9C433F5
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618B6610A3
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 10:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKIKDb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:03:31 -0500
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:45495 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229845AbhKIKDa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 05:03:30 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20211109100043.JOEY8938.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 9 Nov 2021 10:00:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1636452043; 
        bh=x8yC0WvtDLG8ZtSv3HH69oSuc9mofHM1Y9s0UqxaZ2A=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=gkeo98lOIrVcOxJC55bCgOYdOqmbfVXcSDLIov5BoQslhupa0eNuYEiCNr2KH4hV1Tx/EmbnN9NUcYs3wAONDkF6PXbM4SSPJiVUTi35ft0Z/FS8bR8S93/Od6zW3Q2ga/UfFnEYNR9KPKRITO3pIxhGs4Pc6zSBh49hXOfnB7ClxwRn0uiir2N9JGzdW3LbkqDMkDZ6b1Kj+gMqQAfi/oXzDeHOUyUWulik1qzfJ+OSLRz7cVESBznN0zmc9XknaWS3LTSAa6K5PvE/TvzSdkRpIMSdk9wZOcFjLNht+a9OQ6gBfulyX0pzY+dqqegYhssVrlcaJZe1wGCpJuFoqQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A901C087580FD
X-Originating-IP: [217.42.114.162]
X-OWM-Source-IP: 217.42.114.162 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrudeggdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiudfhvdejteffjeelvdeuvdehgffflefghfefleegieejjeelkeeljeejhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedrgedvrdduudegrdduiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedvudejrdegvddruddugedrudeivddpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepohhmohhsnhgrtggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (217.42.114.162) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A901C087580FD; Tue, 9 Nov 2021 10:00:43 +0000
Message-ID: <74823199cfc693defe0cbaca3623d8245d9454d1.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] testsuite sctp: Add tests for sctp_socket
 transition rules
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Date:   Tue, 09 Nov 2021 10:00:42 +0000
In-Reply-To: <CAFqZXNvaChb_D4YFK6_WnXYVMZ3ZUpC4p9rDEbztOTa-Tb-znw@mail.gmail.com>
References: <20211107142047.32727-1-richard_c_haines@btinternet.com>
         <20211107142047.32727-2-richard_c_haines@btinternet.com>
         <CAFqZXNvaChb_D4YFK6_WnXYVMZ3ZUpC4p9rDEbztOTa-Tb-znw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2021-11-08 at 18:54 +0100, Ondrej Mosnacek wrote:
> Hi Richard,
> 
> On Sun, Nov 7, 2021 at 3:21 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > 
> > Add tests for sctp_socket type_transition rules and also using
> > setsockcreatecon(3)
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  policy/test_sctp.te              | 57
> > ++++++++++++++++++++++++++++++++
> >  tests/sctp/sctp_client.c         | 19 +++++++++--
> >  tests/sctp/sctp_common.c         | 51 ++++++++++++++++++++++++++++
> >  tests/sctp/sctp_common.h         |  2 ++
> >  tests/sctp/sctp_peeloff_client.c | 21 +++++++++---
> >  tests/sctp/sctp_peeloff_server.c | 18 ++++++++--
> >  tests/sctp/sctp_server.c         | 18 ++++++++--
> >  tests/sctp/test                  | 57
> > +++++++++++++++++++++++++++++++-
> >  8 files changed, 231 insertions(+), 12 deletions(-)
> > 
> [...]
> > diff --git a/tests/sctp/sctp_peeloff_client.c
> > b/tests/sctp/sctp_peeloff_client.c
> > index 2d42c72..5470494 100644
> > --- a/tests/sctp/sctp_peeloff_client.c
> > +++ b/tests/sctp/sctp_peeloff_client.c
> > @@ -3,13 +3,14 @@
> >  static void usage(char *progname)
> >  {
> >         fprintf(stderr,
> > -               "usage:  %s [-e expected_msg] [-v] [-n] [-x] addr
> > port\n"
> > +               "usage:  %s [-e expected_msg] [-v] [-n] [-t type] [-
> > x] addr port\n"
> >                 "\nWhere:\n\t"
> > 
> >                 "-e      Optional expected message from server e.g.
> > \"nopeer\".\n\t"
> >                 "        If not present the client context will be
> > used as a\n\t"
> >                 "        comparison with the servers reply.\n\t"
> >                 "-n      Do NOT call connect(3) or connectx(3).\n\t"
> > +               "-t      New type for setsockcreatecon(3) test.\n\t"
> >                 "-v      Print context and ip options
> > information.\n\t"
> >                 "-x      Use sctp_connectx(3) instead of
> > connect(3).\n\t"
> >                 "addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or
> > ::1).\n\t"
> > @@ -28,10 +29,10 @@ int main(int argc, char **argv)
> >         char byte = 0x41, label[1024], *expected = NULL;
> >         bool verbose = false, connectx = false, no_connects = false;
> >         bool ipv4 = false, expect_ipopt = false;
> > -       char *context;
> > +       char *context, *sock_type = NULL;
> >         struct timeval tm;
> > 
> > -       while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
> > +       while ((opt = getopt(argc, argv, "e:t:vxmni")) != -1) {
> >                 switch (opt) {
> >                 case 'e':
> >                         expected = optarg;
> > @@ -45,6 +46,9 @@ int main(int argc, char **argv)
> >                 case 'n':
> >                         no_connects = true;
> >                         break;
> > +               case 't':
> > +                       sock_type = optarg;
> > +                       break;
> >                 case 'x':
> >                         connectx = true;
> >                         break;
> > @@ -187,11 +191,20 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> > 
> > +       /* If -t option set new context for peeled off socket */
> > +       if (sock_type) {
> > +               result = set_newsock_con(sock_type, "Peeloff
> > Client");
> > +               if (result < 0) {
> > +                       fprintf(stderr, "Failed
> > setsockcreatecon(3)\n");
> > +                       exit(20);
> > +               }
> > +       }
> > +
> >         peeloff_sk = sctp_peeloff(sock, assoc_id);
> >         if (peeloff_sk < 0) {
> >                 perror("Client sctp_peeloff");
> >                 close(sock);
> > -               exit(1);
> > +               exit(21);
> >         }
> >         if (verbose) {
> >                 printf("Client sctp_peeloff(3) on sk: %d with
> > association ID: %d\n",
> 
> So are you implying that you expect the peeloff socket to get the
> label via the usual transition-or-sockcreatecon mechanism, rather than
> inheriting it from the parent socket?

No just testing the way it currently works when calling
sctp_peeloff(3). It was only the discussions on your patch series
threads that made me think of testing these various scenarios (also saw
testsuite issue #12 [1]). Once your new changes are done the tests can
be reworked.

[1] https://github.com/SELinuxProject/selinux-testsuite/issues/12

>  My current opinion is the
> opposite, motivated by the (somewhat) analogical case of sockets
> created via accept(2).

I really have no issues either way, so long as the maintainers are
happy. The only thing I would like to see is that whichever way is
chosen, it's documented (preferably in Documentation/security/SCTP.rst,
but to keep Paul full of happiness & light also in the patch
description). I think the chances of anyone having code like my peeloff
test is very remote - but you never know !!!.

>  Can you provide some arguments/use cases
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
> 
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> 

