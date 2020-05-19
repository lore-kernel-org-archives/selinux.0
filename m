Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9CC433DF
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFF220825
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="g34zwnet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgESPAW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgESPAW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 11:00:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B1C08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:00:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f189so15460473qkd.5
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkQO/WtFoMjqwBdRRwYcbGgEEww5ZEB4//3USuMfv8U=;
        b=g34zwnethZ2yq8nmIVCqGfzHHAG/3DqRlrOlgObY2lMk6zMbl/Beq/hDQ70iQHngK1
         0QRm5DLKc/WdI4XcTYjjnn+47pZ4vopgtm75m4r8LPySMDYgDx8dXeC58SCkEg9GIirO
         wX0rOLc7DG1gzR9Q/voZHqJBZCoCKg6FhQ736afOg2HY5yTuFrF087HxgkI7DsV0G0Sx
         uJ0WkECcaIudV9SXGCZa+0FCSYbai+kQ7IMkHkMNyqVjAKrOD7svTq1Htq4FZXjKLv47
         Wfr9gnHlAuYFf3U3xYfOqSSnfznu1y/YYCZZKfP+IC7R9D5vjspX5g0Xfsk5BdAz+P04
         RNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkQO/WtFoMjqwBdRRwYcbGgEEww5ZEB4//3USuMfv8U=;
        b=mlmfCjB/tNfw0LR7W3Ktdhd759HZnMiC24ZPNd5j0L917Jo0NyosLyuj4dD+HEh3O1
         iLf/4flGHlbWOsfe2h6C01uONpDIrMvxnEVZ/fHwCR8CZ2CvTaCuVwb6L/CW8x4zalX5
         6J90e0eDNKp7LNenlP4uP56tGipUkY3rriCZCjKXyMIc6GlmHeFpKiht8u9CyPtl/pci
         P1nSHU+DRIekkKMgRi3x8wLygJEgxe4KyrEyX7DaJg9JfVMjunJzTBrOLL4KFGOu/WJA
         XQBWW0V53Dwy1je4rhQ43DzuPBuZR/6KGRODUhCkSeAdooV+nXJeoIm6JUCQnQv/LE3W
         ofag==
X-Gm-Message-State: AOAM533+0fTSYMBkn7TBN+MgiHfKLXNrRq4U6joJ5lySouXTGLL8el0n
        yBOb4rrIj+6qVlSBOanZ9UnMZQkg9TkJc0eYcuX79Q==
X-Google-Smtp-Source: ABdhPJyv4y8JWyBlJlamHT/LRCzafK2Y2nCTh3wxbwJrXvmMoMd4CEc52ZIvHWCUEmpxctN0l/YKmlm7eP/TAnZiLyg=
X-Received: by 2002:a37:a886:: with SMTP id r128mr20481193qke.148.1589900421011;
 Tue, 19 May 2020 08:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKHKm+Bzk6=gX_GEJc=faTB8tzwQ7txKVEhdbzK1sf-Z1A@mail.gmail.com>
 <CAFqZXNv1WXGOUUjb=89G4sohvztNh_J6aRusLhM6uxEN8b-VXw@mail.gmail.com>
In-Reply-To: <CAFqZXNv1WXGOUUjb=89G4sohvztNh_J6aRusLhM6uxEN8b-VXw@mail.gmail.com>
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Tue, 19 May 2020 11:01:22 -0400
Message-ID: <CAGeouKEn7+7GSnYZe=MAAFxj66LNNPJco_i+fL1-=Seh=5j1pw@mail.gmail.com>
Subject: Re: [PATCH] Add restorecon -x to not cross FS boundaries
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've got those changes standing by - I'll do a full clone, apply the
changes I made online to my tree, and submit the pair using git
send-mail. It'll be later this week, long weekend over, work getting
in the way again....

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP

On Tue, May 19, 2020 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 10:08 PM Peter Whittaker <pww@edgekeep.com> wrote:
> > Folks, the following patch adds a -x option to restorecon to prevent
> > it from crossing filesystem boundaries, as requested in
> > https://github.com/SELinuxProject/selinux/issues/208.
> >
> > As per Stephen Smalley's suggestion, this is accomplished using
> > r_opts.xdev = SELINUX_RESTORECON_XDEV;
> >
> > Please do let me know if there are any errors in this, it's been over
> > two decades since I've lurked in majordomo lists and about as long
> > since I've contributed a patch via email. (In particular, I am having
> > issues with sending plaintext, so spaces in the patch are munged; any
> > pointers on correcting than in the gmail web client would be more than
> > welcome.)
> >
> > Thanks,
> >
> > P
> >
> > Peter Whittaker
> > EdgeKeep Inc.
> > www.edgekeep.com
> > +1 613 864 5337
> > +1 613 864 KEEP
> >
> > From: Peter Whittaker <pww@edgekeep.com>
> >
> > As per #208, add the option -x to prevent restorecon from cross file
> > system boundaries, by setting SELINUX_RESTORECON_XDEV iff
> > iamrestorecon. If setfiles, call usage().
> >
> > Signed-off-by: Peter Whittaker <pww@edgekeep.com>
> >
> > From 3a1c4a3e94f18bb240f663fb5fbcff77068e5c4a Mon Sep 17 00:00:00 2001
> > From: Peter Whittaker <pww@EdgeKeep.com>
> > Date: Fri, 15 May 2020 13:05:27 -0400
> > Subject: [PATCH] Add restorecon -x to not cross FS boundaries
> >
> > As per #208, add the option -x to prevent restorecon from cross file
> > system boundaries, by setting SELINUX_RESTORECON_XDEV iff
> > iamrestorecon. If setfiles, call usage().
>
> Since you are adding a new option, please also update the man page
> (policycoreutils/setfiles/restorecon.8).
>
> > ---
> >  policycoreutils/setfiles/setfiles.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/policycoreutils/setfiles/setfiles.c
> > b/policycoreutils/setfiles/setfiles.c
> > index 16bd592ca..2d0224bb6 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -43,8 +43,8 @@ static __attribute__((__noreturn__)) void
> > usage(const char *const name)
> >  {
> >   if (iamrestorecon) {
> >   fprintf(stderr,
> > - "usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
> > - "usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
> > + "usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
> > + "usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
> >   name, name);
> >   } else {
> >   fprintf(stderr,
> > @@ -386,6 +386,13 @@ int main(int argc, char **argv)
> >   case '0':
> >   null_terminated = 1;
> >   break;
> > + case 'x':
> > + if (iamrestorecon) {
> > + r_opts.xdev = SELINUX_RESTORECON_XDEV;
> > + } else {
> > + usage(argv[0]);
> > + }
> > + break;
> >   case 'h':
> >   case '?':
> >   usage(argv[0]);
> > --
> >
>
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
