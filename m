Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2DC43332
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D24C23B02
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 19:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbhAVTT6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbhAVTDB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 14:03:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7357C06174A
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 11:02:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d22so7805945edy.1
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qPqGO6M1vE9fTgLsRl9bBFWNchSGQjZBiwtyORRYmOw=;
        b=o58fKMZc0SW8ioL1vMvt2Z7+b0CWkZQOxJRGU8u50uBf8nPbYrVYUhNF2P3euFPH00
         D8qpuqGUMuC+T5W4OJVi6GCYHAhBpg8w2q20dQaZSbz4KMquOAnFY91xxezIUWF0foJE
         Mb5d4I1CUyFumjcUe8Du5EhpLaqvAPKuEHhv84V9tysxpLLsW5C+fKTboj8M6+rn+8ix
         s34HadJxWvdc3mgB+jol0DG9OFlYkgX3FJULGNMuxDsUSP7AXlXj8inDG2t97kSlzOtO
         delXHVrTW1I4DMakYYIprXzjv0cklUsl6p2xIwTM15gpltaLTA1qHNbVCE1w+Sx8xtBm
         mS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qPqGO6M1vE9fTgLsRl9bBFWNchSGQjZBiwtyORRYmOw=;
        b=q43NBmLYicS1mYXc8QLVdnL/luaVA+E1+IFth1Jn0silN9xa0LKf30h/mYfmcY0OON
         XyYDB7sSsQOEk3QC68jOsargfTffSuoU98bcQa+z1kCxAUoxZwbzG+CO/2/cYdBkU0hz
         zRlcptmQePv2JRnwXauycQL45tgLMutrKYy9GHwa+HJDnyhFs9uJuBkkFFikx66rNedS
         eYUwu59g2zhhppUeb6cNO2KZURUignYPQUZFJnqkNKc+cloBBVtvwlQZ41WEKdZwA39f
         dN0G5nWXyj/cYsVshe7Ikq7tC96Di3dfoQgOctVmaPFkvc7FagoBzjciTf69QBFvCH86
         T9PQ==
X-Gm-Message-State: AOAM531UEIja1wBvFlQVZUCmTt8YCOLZ2h+C8H75BnPN7Qs5qld5ycZx
        6pVpvWDzV098gCADpla9KUUFGOIR8gdMn7y0+vLT
X-Google-Smtp-Source: ABdhPJx1YTmDwNPYfPyKObR51spE6ojhAa+xAEqR1QPnxEJCdxSNRMw77YHFEBJ+gVjTLkqinG2WKLYlySwUWvIXmsg=
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr4361901edx.12.1611342133436;
 Fri, 22 Jan 2021 11:02:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CKqVX6L7HGqiRGqxxTgyhrLAGbCSMvcv4NrBR_3C-Q93w@mail.gmail.com>
 <CAHC9VhSCmhkcRgWtGQNhSr8SQueHWtw3qW9SEtNnEgC=AyzVZg@mail.gmail.com> <3b5a02e0-1361-6fe5-9a2e-2a9113e99d2b@schaufler-ca.com>
In-Reply-To: <3b5a02e0-1361-6fe5-9a2e-2a9113e99d2b@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 14:02:02 -0500
Message-ID: <CAHC9VhQk3ZJ8yKoy3nVEABPMCG7Q_F4SJBvTvFqUEBGSkjmjPA@mail.gmail.com>
Subject: Re: VSOCK & getpeercon()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        selinux@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 22, 2021 at 12:13 PM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
> On 1/22/2021 8:27 AM, Paul Moore wrote:
> > On Sat, Jan 16, 2021 at 7:48 AM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> >> Hi,
> >>
> >> getpeercon() isn't implemented for VSOCK. Note, I am not very familiar
> >> with SELinux, but I was porting some applications that uses AF_UNIX to
> >> AF_VSOCK and reached that point.
> >>
> >> I found some previous discussions about VSOCK & LSM from 2013, but the
> >> reasons it was abandoned don't seem so clear or valid to me:
> >> https://lore.kernel.org/selinux/1803195.0cVPJuGAEx@sifl/
> > Hi, my apologies for the slow reply.
> >
> > The SELinux/LSM VSOCK support wasn't abandoned due to any significant
> > roadblocks, it was simply a matter of time - I seemed to be the only
> > one who was interested in working on it, and I couldn't find enough
> > time to work on it ;)
> >
> > If you are interested in spending some time on adding proper
> > LSM/SELinux VSOCK support my gut feeling is that it would still be a
> > good thing.  However, I would suggest spending some time investigating
> > the current state of things, while you may get lucky, I believe it is
> > safer to assume that anything from 2013 is horribly out of date.
>
> That's a pretty safe statement. You really have four options at
> this point:
>
> - netfilter to set the secmark
> - CIPSO/CALIPSO if the protocol supports or can support options
> - examining the peer process as is done with AF_UNIX
> - eBPF *I think* but you never really know with something that new

I don't believe CIPSO, CALIPSO, labeled IPsec and other IP-based
labeling protocols aren't really options here since VSOCK doesn't rely
on IP.  I vaguely recall thinking it was much more analogous to
UNIX/LOCAL sockets, but it has been ~seven years since I thought about
this last.

The use of secmark could be interesting assuming there are useful
labeling points for VSOCK and netfilter (secmark'ing a packet doesn't
rely on IP so it should be okay from that perspective).

Of course eBPF support would be interesting, but that is like saying
SELinux, Smack, and AppArmor support would be interesting.  I think
the important part is making sure the important objects include the
necessary opaque security blobs (we are probably okay there already),
and making sure we have the LSM hooks in the right places in the code
(also, we *may* be okay there).  Once those things are done, it's a
matter of adding the necessary support to each LSM.

> There may be something else out there that hasn't gobsmacked me
> in the stacking work, so that I wouldn't know about it.
>
> BTW: Please include the (CCed) Linux Security Module list
> <linux-security-module@vger.kernel.org> in discussions like this.

--=20
paul moore
www.paul-moore.com
