Return-Path: <SRS0=nflz=SO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E535CC10F0E
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8552084D
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="l5j0PaGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDLWCm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:02:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44369 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfDLWCm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Apr 2019 18:02:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so10168220ljg.11
        for <selinux@vger.kernel.org>; Fri, 12 Apr 2019 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8zWTsP5rBl0FrZi+srvJknjZtNeZqTF3Afwbx6IcY18=;
        b=l5j0PaGlAnJIkHW7qvo1cNFKMudBvkMJtyTPtV7GHkkR+8awZDCFOsVzChcLv9QvIW
         viOCwn9++Fc4CYEh+aaDr+WgzE4EmPXDuiSQCIdedyBaGNRlaxlBEdaQ/TCvI2+JY1tv
         Z64Ws+4Zmxk/DvbwY+9HGefHzOzYakhn6R4gZNyQ3ymAtyg9zFvxCAZ1IICQhON4jANF
         wiBM1w8WOSdR+P7gHx416cvbLmEynRejfUYWvslgesU1IuLMUXZC9g8gtUPvzm8QgDYN
         R076SnDELEwcRbkovKswfuBawRW+Pkg2l+3IcbsZKrl15xS2fchtrokMj81QH5T/1nyp
         lBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8zWTsP5rBl0FrZi+srvJknjZtNeZqTF3Afwbx6IcY18=;
        b=goAdGuSNfepDlMqYPdBWGW6qPBBZ0KgSyptvEI9VFGWyYP1JOoi2KEwjHc4HQIbDGq
         voA/oK59o5KrdJu3tw1QemViICCAF4D8ixIWhRu+HUwHDJW/AOoqM6lNc4SY67UxFT2g
         TAsJr0GXOXq79OURSohJH8oS8xBYJS9R+gIzoa6Tyf2vTziQJ9pJPMYk4uO5DQqsrRBB
         5bFt4YnCQzF+yOlyUuTz1Evmxq81cYkaTCd8HVcPkLf+8VP/77dlSmRxdQEDSkZFuUqA
         oA07x+JTrs/VEyLo6RMTGD1+iJQrO00yz3uwu1xXMS/fbcBo03Ziqpyq5aByKftBFphy
         +Snw==
X-Gm-Message-State: APjAAAUuwC/VPY3afZGUXafmbVL8OZQJG8kOwlTW6IbMrJgZY+IB2IPA
        o9/Asoib7KYG6NgyfQ4kZUw15WZkZQKG5f5iW8Io
X-Google-Smtp-Source: APXvYqwkrnTxrY2u+HH0mFLHqCiLrWhBkpfLosYAq8B6d1FLJ+dsOHoFD4x3eKiooBYlfy5aAuCAtbL/2dVX6H8I6Ew=
X-Received: by 2002:a2e:9649:: with SMTP id z9mr15075112ljh.92.1555106559085;
 Fri, 12 Apr 2019 15:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
 <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
 <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
 <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
 <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
 <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
 <CAHC9VhSDzofwhqhAKaScfzB21cnus8=iir-TayjEeWfDa9h9rA@mail.gmail.com>
 <05b9c3920262f93f8f7af0058821a5301b138526.camel@btinternet.com>
 <CAHC9VhTUSm1vx_TtmrX+VRd5C56=tKOt8dP2MYwFGsKwCRfKPw@mail.gmail.com> <87mukvvx3m.fsf@gmail.com>
In-Reply-To: <87mukvvx3m.fsf@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Apr 2019 18:02:27 -0400
Message-ID: <CAHC9VhRhngMQLubtymTx1fV=6vJjoTPCEBF_JKtY9qMqF=EyVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 12, 2019 at 3:31 PM Dominick Grift <dac.override@gmail.com> wro=
te:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Fri, Apr 12, 2019 at 12:37 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> >> On Fri, 2019-04-12 at 10:46 -0400, Paul Moore wrote:
> >> > On Thu, Apr 11, 2019 at 6:07 PM Paul Moore <paul@paul-moore.com>
> >> > wrote:
> >> > > On the negative side I realized when playing with your test change=
s
> >> > > that I wasn't building BINDERFS in my test kernels - oops.  I'm
> >> > > fixing
> >> > > that now, but I might not get a chance to do another test until
> >> > > tomorrow; at least I can verify that your BINDERFS testing logic
> >> > > works
> >> > > :)
> >> >
> >> > I rebuilt my test kernel (the latest "secnext" builds have it) with
> >> > BINDERFS only to realize that Fedora Rawhide doesn't seem to ship
> >> > /usr/include/linux/android/binderfs.h so I manually copied the file
> >> > from the kernel-devel package only to run into this when building th=
e
> >> > new binder tests:
> >> >
> >> > # make
> >> > cc -DHAVE_BINDERFS    check_binder.c binder_common.c binder_common.h
> >> > -lselinux -lrt -o check_binder
> >> > binder_common.c: In function =E2=80=98cmd_name=E2=80=99:
> >> > binder_common.c:35:7: error: =E2=80=98BR_TRANSACTION_SEC_CTX=E2=80=
=99 undeclared
> >> > (first use in t
> >> > his function); did you mean =E2=80=98BC_TRANSACTION_SG=E2=80=99?
> >> >   35 |  case BR_TRANSACTION_SEC_CTX:
> >> >      |       ^~~~~~~~~~~~~~~~~~~~~~
> >> >      |       BC_TRANSACTION_SG
> >> > binder_common.c:35:7: note: each undeclared identifier is reported
> >> > only once for
> >> > each function it appears in
> >> > binder_common.c: In function =E2=80=98print_trans_data=E2=80=99:
> >> > binder_common.c:126:23: error: =E2=80=98FLAT_BINDER_FLAG_TXN_SECURIT=
Y_CTX=E2=80=99
> >> > undeclared (f
> >> > irst use in this function)
> >> >  126 |          obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ?
> >> > "YES" : "NO");
> >> >      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> > make: *** [<builtin>: check_binder] Error 1
> >> > # grep "BR_TRANSACTION_SEC_CTX" *
> >> > binder_common.c:        case BR_TRANSACTION_SEC_CTX:
> >> > binder_common.c:                return "BR_TRANSACTION_SEC_CTX";
> >> > service_provider.c:             case BR_TRANSACTION_SEC_CTX: {
> >> > # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binderfs.=
h
> >> > # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binder.h
> >> >
> >> > ... and that's when I stopped playing with this.  If it helps, I
> >> > pulled my binderfs.h file from a current Rawhide kernel.  What are
> >> > you
> >> > using to run these tests?
> >> >
> >> > At the very least, I'm thinking we'll also want to include some note=
s
> >> > in the README.md file under the "Optional Prerequisites" section
> >> > about
> >> > how to get this running with BINDERFS.
> >>
> >> The BR_TRANSACTION_SEC_CTX is defined in an updated binder.h file, so
> >> you need both binder.h and binderfs.h from devel.
> >>
> >> I guess I must have copied them over by hand as I tested on rawhide.
> >> I'll add a note in the README.md file.
> >
> > Okay, that solved the problem, thanks.
> >
> > I just noticed that the kernel-headers package on my Rawhide systems
> > are *really* old.  I suspect this may be due to the fact that I'm not
> > running Fedora Rawhide kernels and thus my currently installed kernel
> > packages don't match what is present in the main Rawhide repos; this
> > problem might be limited to just me (and anyone exclusively running
> > the secnext kernels on their system).
> >
> > Can anyone with a Rawhide system confirm if they have the
> > /usr/include/linux/android/binderfs.h header file?
>
> [root@brutus ~]# rpm -qf /usr/include/linux/android/binderfs.h
> kernel-headers-5.1.0-0.rc2.git1.1.fc31.x86_64

Thanks.

I realized today that last summer Fedora changed how they package the
kernel headers and thus I need to update how I build my test kernels.
As an aside, I don't get why the change was made, this new process for
building the kernel-headers package is *really* convoluted ... and
broken if you are using a custom %buildid (which I do for "secnext"
builds), but that's a different issue.

--=20
paul moore
www.paul-moore.com
