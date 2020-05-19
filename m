Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E2C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 08:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F2820809
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 08:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMVTkaYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgESILQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 04:11:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726369AbgESILQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 04:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589875874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oFHbd+EjkpzshItBZ3jkMQ0SQPoozaeJK9kQNQTiRw=;
        b=QMVTkaYremHmGDfcMJR+WBPPlCEHOPxUfoQIHpQ8RmDoGXR70q2dLiPjLgVCq/ja2Rz36D
        HOpG34Ot4LhADs+DVv8kjKVEbXzbMaJgginQoYvkbRs/QN29PHlUD7+GAgD659vE9ADrsL
        zjf/uqAz4svaRu99wvo/Q73+AAu9wL8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-cKW2jl__Mb-Xbr5aUsUW5g-1; Tue, 19 May 2020 04:11:11 -0400
X-MC-Unique: cKW2jl__Mb-Xbr5aUsUW5g-1
Received: by mail-oi1-f200.google.com with SMTP id j130so7236849oih.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 01:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oFHbd+EjkpzshItBZ3jkMQ0SQPoozaeJK9kQNQTiRw=;
        b=rO37iauvUEettyrpj4ytRwrILTFzWdNIH+4lYtAlrHTN2i+VFnfmVQOQu7TJt07bgg
         eBh2GYfq1L12v2NF7fPy7Cp/Sg9c2sDI5cog3omZS0tzOMviIaEJsKXFiFTr4QqgtaS0
         UuSJ2vJe3fAajfyEMygF4DHawlTm6rr5RR2+4OcKJd2Es069ykUBBcuuL63xl4bheoaa
         iCwXaTKpTvNz0Pwu1mHP29h4JKNw3tf6Ld1km4MuJUN9E+IkXONPn/Jo9vH7GuRr12tj
         ClWK51V3wiX3PGn6T0jZOvZRMnZ5HX7l6Mlq5i43pRIO2YbYUbXsWWNQtuFjgDP7uj+G
         KImw==
X-Gm-Message-State: AOAM533JRfVH2LqYPcGIddeqc/qxzUVRSJhxTGZogD8gZdJM/ahBPd4j
        ep53W4NnXdehMspqA4ws9i8M68MJ9Mws3tQdesmWvX3iCdNftxYColatMR6SWXZAg30nr1JOsxq
        Dc8QUcxHOPJACR4sCDG6nWP810iy56+Sthg==
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr15410568oth.66.1589875870417;
        Tue, 19 May 2020 01:11:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVzFyMTUc9nN+GhhUh/9Ff8//mJ1g4y1uLkjMAIhPzyYfiURC3vBSDgoXgndPZbeylGDuKGxIdMdlw5jHeGaM=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr15410559oth.66.1589875870110;
 Tue, 19 May 2020 01:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKHKm+Bzk6=gX_GEJc=faTB8tzwQ7txKVEhdbzK1sf-Z1A@mail.gmail.com>
In-Reply-To: <CAGeouKHKm+Bzk6=gX_GEJc=faTB8tzwQ7txKVEhdbzK1sf-Z1A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 May 2020 10:10:58 +0200
Message-ID: <CAFqZXNv1WXGOUUjb=89G4sohvztNh_J6aRusLhM6uxEN8b-VXw@mail.gmail.com>
Subject: Re: [PATCH] Add restorecon -x to not cross FS boundaries
To:     Peter Whittaker <pww@edgekeep.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 10:08 PM Peter Whittaker <pww@edgekeep.com> wrote:
> Folks, the following patch adds a -x option to restorecon to prevent
> it from crossing filesystem boundaries, as requested in
> https://github.com/SELinuxProject/selinux/issues/208.
>
> As per Stephen Smalley's suggestion, this is accomplished using
> r_opts.xdev = SELINUX_RESTORECON_XDEV;
>
> Please do let me know if there are any errors in this, it's been over
> two decades since I've lurked in majordomo lists and about as long
> since I've contributed a patch via email. (In particular, I am having
> issues with sending plaintext, so spaces in the patch are munged; any
> pointers on correcting than in the gmail web client would be more than
> welcome.)
>
> Thanks,
>
> P
>
> Peter Whittaker
> EdgeKeep Inc.
> www.edgekeep.com
> +1 613 864 5337
> +1 613 864 KEEP
>
> From: Peter Whittaker <pww@edgekeep.com>
>
> As per #208, add the option -x to prevent restorecon from cross file
> system boundaries, by setting SELINUX_RESTORECON_XDEV iff
> iamrestorecon. If setfiles, call usage().
>
> Signed-off-by: Peter Whittaker <pww@edgekeep.com>
>
> From 3a1c4a3e94f18bb240f663fb5fbcff77068e5c4a Mon Sep 17 00:00:00 2001
> From: Peter Whittaker <pww@EdgeKeep.com>
> Date: Fri, 15 May 2020 13:05:27 -0400
> Subject: [PATCH] Add restorecon -x to not cross FS boundaries
>
> As per #208, add the option -x to prevent restorecon from cross file
> system boundaries, by setting SELINUX_RESTORECON_XDEV iff
> iamrestorecon. If setfiles, call usage().

Since you are adding a new option, please also update the man page
(policycoreutils/setfiles/restorecon.8).

> ---
>  policycoreutils/setfiles/setfiles.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c
> b/policycoreutils/setfiles/setfiles.c
> index 16bd592ca..2d0224bb6 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -43,8 +43,8 @@ static __attribute__((__noreturn__)) void
> usage(const char *const name)
>  {
>   if (iamrestorecon) {
>   fprintf(stderr,
> - "usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
> - "usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
> + "usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
> + "usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
>   name, name);
>   } else {
>   fprintf(stderr,
> @@ -386,6 +386,13 @@ int main(int argc, char **argv)
>   case '0':
>   null_terminated = 1;
>   break;
> + case 'x':
> + if (iamrestorecon) {
> + r_opts.xdev = SELINUX_RESTORECON_XDEV;
> + } else {
> + usage(argv[0]);
> + }
> + break;
>   case 'h':
>   case '?':
>   usage(argv[0]);
> --
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

