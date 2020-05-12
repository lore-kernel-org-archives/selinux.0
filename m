Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD11C2D0F7
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A2A20731
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgELTkj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:40:39 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39775 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbgELTki (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 15:40:38 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2827F5646C8
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 21:40:36 +0200 (CEST)
Received: by mail-ot1-f43.google.com with SMTP id t3so11502965otp.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:40:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuaXNu1Xjp2tYiO9O/PpzZJeBncQiUTNi3Jhp7nZ8JK6n5S/Oh7X
        MJSQ0dwEQj/Dgp8ZmsavGZnK4rKCMUPH9/Zwbuw=
X-Google-Smtp-Source: APiQypLUBJefQx3Cw/cgImO2YOEyZR5s6VZrVjSWQRAxFUupXs1z3Rzi+ixfzO4+BKTsXnjOpExUonxpSt/Ti9RyU6Q=
X-Received: by 2002:a9d:7082:: with SMTP id l2mr17235192otj.361.1589312435232;
 Tue, 12 May 2020 12:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200511112308.23523-1-plautrba@redhat.com>
In-Reply-To: <20200511112308.23523-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 12 May 2020 21:40:23 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nR1VpeS=mW7Pq7UHKb97mUSUcpk1LhHzqpWaBSVb=KNQ@mail.gmail.com>
Message-ID: <CAJfZ7=nR1VpeS=mW7Pq7UHKb97mUSUcpk1LhHzqpWaBSVb=KNQ@mail.gmail.com>
Subject: Re: [PATCH] semanage/test-semanage.py: Return non-zero value when
 some of unittest tests fail
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue May 12 21:40:36 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 1:23 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Previously python/semanage/test-semanage.py returned 0 even when there was a
> fail in some test and `make test` didn't indicate any problem.
>
> Fixes:
>     $ make test
>     ...
>     Ran 10 tests in 110.854s
>     FAILED (failures=4)
>     $ echo $?
>     0
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Nice catch! Thanks
Nicolas

> ---
>  python/semanage/test-semanage.py | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/python/semanage/test-semanage.py b/python/semanage/test-semanage.py
> index c8f6ec231fc2..d99e3fdaa211 100644
> --- a/python/semanage/test-semanage.py
> +++ b/python/semanage/test-semanage.py
> @@ -233,7 +233,7 @@ def semanage_custom_suite(test_list):
>
>
>  def semanage_run_test(suite):
> -    unittest.TextTestRunner(verbosity=2).run(suite)
> +    return unittest.TextTestRunner(verbosity=2).run(suite).wasSuccessful()
>
>
>  class CheckTest(argparse.Action):
> @@ -255,9 +255,9 @@ def semanage_args(args):
>          for i in semanage_test_list:
>              print(i)
>      if args.all:
> -        semanage_run_test(semanage_suite())
> +        return semanage_run_test(semanage_suite())
>      if args.test:
> -        semanage_run_test(semanage_custom_suite(args.test))
> +        return semanage_run_test(semanage_custom_suite(args.test))
>
>
>  def gen_semanage_test_args(parser):
> @@ -281,8 +281,10 @@ if __name__ == "__main__":
>          gen_semanage_test_args(parser)
>          try:
>              args = parser.parse_args()
> -            args.func(args)
> -            sys.exit(0)
> +            if args.func(args):
> +                sys.exit(0)
> +            else:
> +                sys.exit(1)
>          except ValueError as e:
>              sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
>              sys.exit(1)
> --
> 2.26.2
>

