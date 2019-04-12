Return-Path: <SRS0=nflz=SO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0546CC10F0E
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5452075B
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nZsxNS/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDLTVA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:21:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46776 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLTVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Apr 2019 15:21:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so9823521ljk.13
        for <selinux@vger.kernel.org>; Fri, 12 Apr 2019 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WUP8kIiT7VoJeJlkuQnpQFxXRHpKr+qndzF0RHKLCD4=;
        b=nZsxNS/3QFMlqCVjf0sPI2nSH4nE0Gkc7sI9mlNmSL3Qc8dZPzAfuzRSdYaAYcUbeU
         +qPTKTngXj3IUihV3tkb8Kdc5q9HSKoztPLSkA2ByzNr1bmbyI93yeLpuPhaYOSwGq5Y
         9DlziNjlJDNDUrU+TYR7SBHqSJ8lLFFn5wiEnurSuZH5M/OoxiVpSRjK7A2EOr0iP6K0
         Z2Bf1nBWP2aUNWHcU2pR+NjCy79qqA04amLYLD9jdUf0oezULa4C1PvItTGtvbOMP3L3
         LofkjgKR1XfXGR3CdWj3gT8YAdJ3YOutt/CzMXGWY7eIqjl068rAOR2Vg4FbAJsltKb/
         4Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUP8kIiT7VoJeJlkuQnpQFxXRHpKr+qndzF0RHKLCD4=;
        b=tlZMIDakUrADXDv7DEa052+nRTbge/6odyYdZxcdF1+2a91khohpnez2IKbRxQZ+LP
         TWKxCVbqHnz3BJWWdt7N7DFr84p8z/vcQ9qwQv7VvFG6Tc1NgFhhqKQl6tM/RAtrpvtQ
         yamsZxDmye0jrD2XCK0dsVcRaC9mrAaAxoc5ozHEWPNyWFmpEswXrvfw0TpG+dyZ7yc2
         EZIAdhkxah7t8SqLSbYgB/z/vGU7oEZmwc4QlRHJcNCHraj2PHXzogDVfGbHSSK2tnsH
         Sh5XkgJgzYmdprY7vttReZR7o2LV4UtkzBNc+r/YLrKVO/VaFP6BEZsoCENciSHB1kCS
         89yg==
X-Gm-Message-State: APjAAAXFqD034BvxPyhktPDLVApPW2ga1jQaNIE1ptATiYc6XyESGcmx
        j9H6ZAatzxHn/UkoKdcfWilHZHCm1BK3coQn8zre
X-Google-Smtp-Source: APXvYqyXOwGmzo+c127v+NYC6Th+NKiSMvx8zZQcE6O2vsyGfGC2FQ5Mv7LuJCMW21qFOGcWacxg1/5x2pVwsDP2QSE=
X-Received: by 2002:a05:651c:114:: with SMTP id a20mr16236543ljb.53.1555096857711;
 Fri, 12 Apr 2019 12:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
 <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
 <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
 <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
 <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
 <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
 <CAHC9VhSDzofwhqhAKaScfzB21cnus8=iir-TayjEeWfDa9h9rA@mail.gmail.com> <05b9c3920262f93f8f7af0058821a5301b138526.camel@btinternet.com>
In-Reply-To: <05b9c3920262f93f8f7af0058821a5301b138526.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Apr 2019 15:20:46 -0400
Message-ID: <CAHC9VhTUSm1vx_TtmrX+VRd5C56=tKOt8dP2MYwFGsKwCRfKPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 12, 2019 at 12:37 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2019-04-12 at 10:46 -0400, Paul Moore wrote:
> > On Thu, Apr 11, 2019 at 6:07 PM Paul Moore <paul@paul-moore.com>
> > wrote:
> > > On the negative side I realized when playing with your test changes
> > > that I wasn't building BINDERFS in my test kernels - oops.  I'm
> > > fixing
> > > that now, but I might not get a chance to do another test until
> > > tomorrow; at least I can verify that your BINDERFS testing logic
> > > works
> > > :)
> >
> > I rebuilt my test kernel (the latest "secnext" builds have it) with
> > BINDERFS only to realize that Fedora Rawhide doesn't seem to ship
> > /usr/include/linux/android/binderfs.h so I manually copied the file
> > from the kernel-devel package only to run into this when building the
> > new binder tests:
> >
> > # make
> > cc -DHAVE_BINDERFS    check_binder.c binder_common.c binder_common.h
> > -lselinux -lrt -o check_binder
> > binder_common.c: In function =E2=80=98cmd_name=E2=80=99:
> > binder_common.c:35:7: error: =E2=80=98BR_TRANSACTION_SEC_CTX=E2=80=99 u=
ndeclared
> > (first use in t
> > his function); did you mean =E2=80=98BC_TRANSACTION_SG=E2=80=99?
> >   35 |  case BR_TRANSACTION_SEC_CTX:
> >      |       ^~~~~~~~~~~~~~~~~~~~~~
> >      |       BC_TRANSACTION_SG
> > binder_common.c:35:7: note: each undeclared identifier is reported
> > only once for
> > each function it appears in
> > binder_common.c: In function =E2=80=98print_trans_data=E2=80=99:
> > binder_common.c:126:23: error: =E2=80=98FLAT_BINDER_FLAG_TXN_SECURITY_C=
TX=E2=80=99
> > undeclared (f
> > irst use in this function)
> >  126 |          obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ?
> > "YES" : "NO");
> >      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > make: *** [<builtin>: check_binder] Error 1
> > # grep "BR_TRANSACTION_SEC_CTX" *
> > binder_common.c:        case BR_TRANSACTION_SEC_CTX:
> > binder_common.c:                return "BR_TRANSACTION_SEC_CTX";
> > service_provider.c:             case BR_TRANSACTION_SEC_CTX: {
> > # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binderfs.h
> > # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binder.h
> >
> > ... and that's when I stopped playing with this.  If it helps, I
> > pulled my binderfs.h file from a current Rawhide kernel.  What are
> > you
> > using to run these tests?
> >
> > At the very least, I'm thinking we'll also want to include some notes
> > in the README.md file under the "Optional Prerequisites" section
> > about
> > how to get this running with BINDERFS.
>
> The BR_TRANSACTION_SEC_CTX is defined in an updated binder.h file, so
> you need both binder.h and binderfs.h from devel.
>
> I guess I must have copied them over by hand as I tested on rawhide.
> I'll add a note in the README.md file.

Okay, that solved the problem, thanks.

I just noticed that the kernel-headers package on my Rawhide systems
are *really* old.  I suspect this may be due to the fact that I'm not
running Fedora Rawhide kernels and thus my currently installed kernel
packages don't match what is present in the main Rawhide repos; this
problem might be limited to just me (and anyone exclusively running
the secnext kernels on their system).

Can anyone with a Rawhide system confirm if they have the
/usr/include/linux/android/binderfs.h header file?

--=20
paul moore
www.paul-moore.com
