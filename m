Return-Path: <SRS0=1Vb5=WI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69BC433FF
	for <selinux@archiver.kernel.org>; Mon, 12 Aug 2019 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D0520665
	for <selinux@archiver.kernel.org>; Mon, 12 Aug 2019 22:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MenMgjMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfHLWtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:49:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39786 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfHLWtN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Aug 2019 18:49:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so7641651ljj.6
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2019 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKtZutFBQuPl5tC1egZ2QBEwnPT1x2hfK1R2xbzKh/Q=;
        b=MenMgjMfJRu/MIUbsvz0fgsGWZmPnaPKDIiLfE1Hv7HIMZgcUM6GR1ddrt6TTPFLCm
         caUyKuCdbiNb8d/HMn3g6OpfFH8KahgRFsDUthedMyK6fTApghHr4L2H6iiT2Ikhs/XE
         n4Iq4zRh84LMbsyTIUhU6eT2whgkh8P/36xTMdVRiE+9Clw2g9MsPgtK0aUmPeBZ9t8c
         kZ6DabJI64NesKrjYpzHJaMXkq871hV6POwqey1+dEtZ9rHD6KyUlcbPlGaLVJ3jka7V
         MO8eDFb4S7Y5p2Hs2zCFz9CYqkrnXjh66jY/X/IwxnvLhw2KKlb0JMuJg8oiveAqcb++
         7Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKtZutFBQuPl5tC1egZ2QBEwnPT1x2hfK1R2xbzKh/Q=;
        b=NSXjUCCtPwHC/ZpNVwCVpbS91kNAG1MG/hIq9QAtXUxsHoGAuMrGnTrlYBg+vQ4waT
         lwrQB800u21o+EI636NxUjCy0AcUmB6ukZ9DWM9Lhujvh5/MBnN4Rej5C3mjj72goxWD
         IVkyW9DTgga7k0iBGAj6flL+h7iICZtlCLx4Rxpd/4YNt5BKv0/C1j73TzI59MVq04Qv
         Is0RM3ojmHIJyK6s6ukay7Y8cnM4oCLegoNTe0TgtJScFoXBvLGlZTAKEW//+eYAmwoM
         nrp0E7RIt4mhhV09dTfafFxeKqcU0PqUyFIgNywUeDzAzP8RD9Hd/vFLFeIHK+O+U0so
         nkNg==
X-Gm-Message-State: APjAAAX0ZCwp8c+ZsUHFL4tNa33/lELGLrAB8SeK+meUmVsCQP1xxFFS
        f9qKDzUBkekLmVNX6dCgp4VnSzZpW+Iob7IosxDU
X-Google-Smtp-Source: APXvYqzwAbO7blTD+UuhsOyPn0UdRLQsIAWMcambHmSsJcRysUG5etFuCKtlYwhnTHiES/HPlHbrWeQ6faOU5CC2sMw=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr7572385ljj.0.1565650150314;
 Mon, 12 Aug 2019 15:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111232.5589-1-richard_c_haines@btinternet.com>
 <CAHC9VhS+76AW-qVO_DRGaGdVz25mX0hbiz1V2dGAX7mEyi3yXQ@mail.gmail.com>
 <5a668ff82b2d3786ec0b816f78fc058012ee470f.camel@btinternet.com> <644be7b7811eb9d19a55af7a13602961d138cf47.camel@btinternet.com>
In-Reply-To: <644be7b7811eb9d19a55af7a13602961d138cf47.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Aug 2019 18:48:59 -0400
Message-ID: <CAHC9VhQixcQ2x+YLXCWZnS8Cf+wAaeTBJb9JZb8sdQR-TH97Tg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] selinux-testsuite: Add BPF tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 11, 2019 at 11:33 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2019-08-09 at 17:55 +0100, Richard Haines wrote:
> > On Fri, 2019-08-09 at 11:22 -0400, Paul Moore wrote:
> > > On Thu, Aug 1, 2019 at 7:12 AM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > This adds basic BPF tests for map and prog functions.
> > > >
> > > > The check-syntax script has been modified to exclude files listed
> > > > in tools/chk_c_exclude. This is because of macros in bpf_common.c
> > > > that get horribly reformatted by check-syntax.
> > > >
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > ---
> > > > V2 Change - Split BPF code into bpf_common.c for others to use.
> > > >
> > > >  README.md              |  4 +-
> > > >  defconfig              |  5 +++
> > > >  policy/Makefile        |  4 ++
> > > >  policy/test_bpf.te     | 77 ++++++++++++++++++++++++++++++++
> > > >  tests/Makefile         |  4 ++
> > > >  tests/bpf/.gitignore   |  2 +
> > > >  tests/bpf/Makefile     | 12 +++++
> > > >  tests/bpf/bpf_common.c | 99
> > > > ++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/bpf/bpf_test.c   | 83 +++++++++++++++++++++++++++++++++++
> > > >  tests/bpf/test         | 57 ++++++++++++++++++++++++
> > > >  tools/check-syntax     |  2 +-
> > > >  tools/chk_c_exclude    |  1 +
> > > >  12 files changed, 348 insertions(+), 2 deletions(-)
> > > >  create mode 100644 policy/test_bpf.te
> > > >  create mode 100644 tests/bpf/.gitignore
> > > >  create mode 100644 tests/bpf/Makefile
> > > >  create mode 100644 tests/bpf/bpf_common.c
> > > >  create mode 100644 tests/bpf/bpf_test.c
> > > >  create mode 100755 tests/bpf/test
> > > >  create mode 100644 tools/chk_c_exclude
> > >
> > > ...
> > >
> > > > diff --git a/tools/check-syntax b/tools/check-syntax
> > > > index 7f9768d..5b7c211 100755
> > > > --- a/tools/check-syntax
> > > > +++ b/tools/check-syntax
> > > > @@ -11,7 +11,7 @@
> > > >  #
> > > >
> > > >  CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name
> > > > "*.h")"
> > > > -CHK_C_EXCLUDE=""
> > > > +CHK_C_EXCLUDE="$(cat tools/chk_c_exclude)"
> > > >
> > > >  CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name
> > > > "test")"
> > > >  CHK_PERL_EXCLUDE=""
> > > > diff --git a/tools/chk_c_exclude b/tools/chk_c_exclude
> > > > new file mode 100644
> > > > index 0000000..20facbf
> > > > --- /dev/null
> > > > +++ b/tools/chk_c_exclude
> > > > @@ -0,0 +1 @@
> > > > +tests/bpf/bpf_common.c
> > >
> > > Why are we excluding bpf_common.c from the style checks?
> >
> > Because check-syntax reformats a macro and it is not neat and tidy
> > said Mr Neat to Mr Tidy

I was in the middle of writing a response that pushed the Mr Neat and
Mr Tidy joke to the straining point and I decided I couldn't take it
anymore ... and if I can endure my own response, how could I expect
anyone else to do it? ;)

Regardless, the problem is that style is horribly subjective, and I
really hate getting bogged down in those sorts of arguments (witness
the recent on-list discussion of comment styles) so I added the
"check-syntax" tool to settle those arguments.  You run the code
through the tool, and that's your answer.  Period.  (I suppose it
might be "full stop" for Mr Neat and/or Mr Tidy.)  Does that mean I
always like the output of the tool?  No, sometimes it makes a mess of
things[1], but I'd rather have that then on-list arguments about
style.

[1] In the past I've fixed the really bad check-syntax output by
tweaking the input code ever so slightly.

> Just a thought - The patches run the fdreceive with bpf support before
> the core bpf test. I could resubmit the patches to test core bpf first
> ?? (and allow Mr Messy to format the macros in bpf_common.c)

That gets to another thing that bothers me slightly ... I didn't
mention it earlier because of the test failure, the style issue, and
lack of time, but I'm not sure what I feel about splitting the BPF
tests up like that.  Duplicating code isn't a great solution either.
Thoughts?

-- 
paul moore
www.paul-moore.com
