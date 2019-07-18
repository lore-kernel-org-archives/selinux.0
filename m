Return-Path: <SRS0=gxH6=VP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841BBC76195
	for <selinux@archiver.kernel.org>; Thu, 18 Jul 2019 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5AC2080D
	for <selinux@archiver.kernel.org>; Thu, 18 Jul 2019 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfp1e8GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGROwY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:52:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36166 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGROwY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jul 2019 10:52:24 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so51937739iom.3
        for <selinux@vger.kernel.org>; Thu, 18 Jul 2019 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0p5KAi/bBr2sj+PfCWCrKe/dBeyCEThjbTl8O09nVTU=;
        b=vfp1e8GBvxrhSw4RGA3X8BsAaapjrHeNQiRWiJ2ft9X4Gpf3VM8qAtKkRDQu+jr0+W
         T3SA1ELAoAK3ZiUAfD91ffCVvRNhB8m5AeSSIsUpp18EC9gLSJlVGnaNpqh94+Bd7Znu
         Pp1UxmEwyYUUlvXeA2urpIDTcqTBlf4y+EHhgPDUzKP85IW7peYQhuqAIpyRjUKsLtZm
         +qvtlGpkNjqNvkmAwgqQiehZofwlO6/xzFZqHkmGlxi7KsztfjDL5024TWeDrq8bq5j4
         +iBSfGPR6BGmCWCn/ndKnzCJQL2W+Gp7b6Ck9PYbQHKHBC9vFGKW7Ki0CfAc3lcu1s8f
         HtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0p5KAi/bBr2sj+PfCWCrKe/dBeyCEThjbTl8O09nVTU=;
        b=XO91kazOcPSxRFnLsiu+OsAr1+dbpUlRHA7MrTFWoZI6hwP3vcUj5bWYh9/L3aJtz5
         rCc/+Z8fQvj6oV9ypqIYzCDPWXquBAw2PEalyRwCeKOS7mom03Vrf8PEpRKsy5gWxxAW
         oyZKq4YJMQHII+0NN7VRdebsvNxCb3vIcK1OHJCFy/5Jr5Yiqaup85JUzevvie6MRTEN
         Y6+9sCYr3+9OwY12VqGe+BUnc5HPjgh/5LiEejRhhAL3mLdNYdaj1pO4JkIZaDAffITY
         P7MKugFy/vTWHbHDUgONgVVjSGEdU2rD8OmQNXaNJHQ9m0KAZ2K/zqFez0t5kSsvA/CW
         gF7Q==
X-Gm-Message-State: APjAAAW919ioA6nz+6qqSeVbwM7B9N13DUlViO7uJHe0/jFT4VQATTug
        pIkOYyLf3HtZxcBUNglGCfOBPyKiIh9x4yO9HHc=
X-Google-Smtp-Source: APXvYqxAJ5juiWaqQAG6cQLBQVCunvY4sjkX+ot+SOrq7uXjZZO2LaHDywYPTn81R9Q79XbIszywcZSGEFXePWzap8M=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr45595540iop.293.1563461543274;
 Thu, 18 Jul 2019 07:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190715144502.30547-1-bigon@debian.org> <20190715144502.30547-3-bigon@debian.org>
 <CAFftDdpaEeCQiw6KNDQq+_RO48GNuDmLbxMAb1wxQp9ES8sEWQ@mail.gmail.com> <CAFftDdoVHYH-SGEaPa+CU8hJSEZFQ7-3hPiOnu1h2xnWG5HZzQ@mail.gmail.com>
In-Reply-To: <CAFftDdoVHYH-SGEaPa+CU8hJSEZFQ7-3hPiOnu1h2xnWG5HZzQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Jul 2019 09:52:11 -0500
Message-ID: <CAFftDdpRuWV92Dh3kSySk7VM1mxu6eDRkM-UWpN9SbnZhgvDpA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mcstrans: Add reference to setools.conf man page in
 the daemon one
To:     Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 16, 2019 at 11:28 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Staged:
> https://github.com/SELinuxProject/selinux/pull/171
>

Merged:
https://github.com/SELinuxProject/selinux/pull/171

> On Tue, Jul 16, 2019 at 10:20 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > The three in the series LGTM. Ack.
> >
> > On Mon, Jul 15, 2019 at 9:55 AM Laurent Bigonville <bigon@debian.org> w=
rote:
> > >
> > > From: Laurent Bigonville <bigon@bigon.be>
> > >
> > > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> > > ---
> > >  mcstrans/man/man8/mcstransd.8    | 2 +-
> > >  mcstrans/man/ru/man8/mcstransd.8 | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mcstrans/man/man8/mcstransd.8 b/mcstrans/man/man8/mcstra=
nsd.8
> > > index 64774a52..9a5922ba 100644
> > > --- a/mcstrans/man/man8/mcstransd.8
> > > +++ b/mcstrans/man/man8/mcstransd.8
> > > @@ -29,4 +29,4 @@ The program was enhanced/rewritten by Joe Nall <joe=
@nall.com>.
> > >  /etc/selinux/{SELINUXTYPE}/setrans.conf
> > >
> > >  .SH "SEE ALSO"
> > > -.BR mcs (8),
> > > +.BR setrans.conf (5), mcs (8)
> > > diff --git a/mcstrans/man/ru/man8/mcstransd.8 b/mcstrans/man/ru/man8/=
mcstransd.8
> > > index 90247c32..4cd68c17 100644
> > > --- a/mcstrans/man/ru/man8/mcstransd.8
> > > +++ b/mcstrans/man/ru/man8/mcstransd.8
> > > @@ -23,7 +23,7 @@ mcstransd \- =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=
=D0=BD=D0=BD=D1=8F=D1=8F =D1=81=D0=BB=D1=83=D0=B6=D0=B1=D0=B0 MCS (=D0=BC=
=D1=83=D0=BB=D1=8C=D1=82=D0=B8=D0=BA=D0=B0=D1=82=D0=B5=D0=B3=D0=BE=D1=80=D0=
=B8
> > >  /etc/selinux/{SELINUXTYPE}/setrans.conf
> > >
> > >  .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95"
> > > -.BR mcs (8)
> > > +.BR setrans.conf (5), mcs (8)
> > >
> > >  .SH "=D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB"
> > >  =D0=AD=D1=82=D0=B0 man-=D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=
=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh <dwalsh@redh=
at.com>.
> > > --
> > > 2.22.0
> > >
