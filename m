Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E45C35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01E72084E
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA0x3De7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgBYQRS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:17:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35188 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYQRS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 11:17:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so13089385oie.2
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 08:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1B9khusdaQl3kXhhxTmOM87/7LveWocENwUJSxpMmQ=;
        b=jA0x3De7+8dFMjit6i2ovi0AJ/IEYAJiM5mRemNY/M/aloYkNZGOzfvKfI5K1OIq5i
         jTeDy9UoLQRXz8PfMMV3QXjGpyWZV+9alBW1MhzWzAf47e+FI4SvKbHMSFiLv8J4rzME
         V7fWMs33G25fC91zBkVDyzwLhoex42OJfFrk7/RFwaomS2GwI8IlyB8Y0lTWkW/ZiADA
         ZvpwQ3n0q3DGYXWZCEW3cFNLfQPmFPPDszxdicDYH5QT5AybukwLnR93pKqd2l9UhaKT
         89NxlsO3CgvEEgv0xDvJqgyntpE9ExL91x1Ft7hMVQrwWCqyZPFPua8KKZhJ7mJ+oBiz
         DVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1B9khusdaQl3kXhhxTmOM87/7LveWocENwUJSxpMmQ=;
        b=oF7tl12IXX18SfaTjgoeP0UASFSPY0VdhV22hZLPv/l2vbTA0UGFJ4V4+5xoLIpVC6
         dKKpy7uEmt1GoMO1BoopImfMf7pquzzwTOs6qn5/OEywQaEA8yqk1UDGt5mkre8MVJtC
         ru3E9SmXYKfzoVtBqyagidB/DmT6LixkAIA1RdvvzyWLLIWWwm+22uDWmy2wuwY46v0F
         1CyTTkwEMob1WqgVEBsYq8qhkC7v2VkCXJDZb3GRkthDKSyaRswby28usRAeI9OQxmYo
         JtGdYu5+sERK+UeJR2pEvey3iTIzBv78Q2GaPs7Mn4LAV03XZ3c0EywIR3jbkVwG+cHC
         uFnQ==
X-Gm-Message-State: APjAAAUVY3fFTXLFAo0uZ8KpLJxDkqd66TF7k26K0Cr+DniF5q3JI8Z+
        xA02RQ0EL8VG++IO7g0HDJ0MTEupLejZWRLOmkZeSA==
X-Google-Smtp-Source: APXvYqxzq7OuYpgDHj/Z/nTS08A4A/hbfS84DrF8ZgBf2KH7mMaqnGQ38s2x3+GIC6F86NvY7pqNZHr2yxAwKn4r6rQ=
X-Received: by 2002:aca:df88:: with SMTP id w130mr3091229oig.172.1582647436190;
 Tue, 25 Feb 2020 08:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20200224141524.407114-1-richard_c_haines@btinternet.com>
 <20200224141524.407114-2-richard_c_haines@btinternet.com> <CAEjxPJ7HXQGdWX5KHs42OEGVR9doSD_FpUAH0TR+U96DPu4ukQ@mail.gmail.com>
 <feb9aa8f41509a9f0eb4b8a8b198e73e5acdd352.camel@btinternet.com>
In-Reply-To: <feb9aa8f41509a9f0eb4b8a8b198e73e5acdd352.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Feb 2020 11:18:47 -0500
Message-ID: <CAEjxPJ55qz3m-KadVe8X1Z5Un2EcpwWkA1H8hFb3nYz7y5jKXA@mail.gmail.com>
Subject: Re: [RFC V2 PATCH 1/2] selinux-testsuite: Use native filesystem for
 tests - Part 1
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 11:04 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Mon, 2020-02-24 at 16:17 -0500, Stephen Smalley wrote:
> > On Mon, Feb 24, 2020 at 9:16 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > diff --git a/tests/filesystem/Filesystem.pm
> > > b/tests/filesystem/Filesystem.pm
> > > index a08570a..8a18ddb 100644
> > > --- a/tests/filesystem/Filesystem.pm
> > > +++ b/tests/filesystem/Filesystem.pm
> > > @@ -1,10 +1,10 @@
> > > @@ -25,15 +25,26 @@ sub check_config {
> > >      $mod_pol_vers      = `checkmodule -V | cut -f 2 -d '-'`;
> > >      $max_kernel_policy = `cat /sys/fs/selinux/policyvers`;
> > >
> > > -    if ( $mod_pol_vers >= 11 and $pol_vers >= 25 and
> > > $max_kernel_policy >= 25 )
> > > -    {
> > > -        $name_trans = 1;
> > > -        $tst_count += 2;
> > > +    if ( not $nfs_enabled and not $vfat_enabled ) {
> > > +        if (    $mod_pol_vers >= 11
> > > +            and $pol_vers >= 25
> > > +            and $max_kernel_policy >= 25 )
> > > +        {
> > > +            $name_trans = 1;
> > > +            $tst_count += 2;
> > > +        }
> > > +    }
> > > +
> > > +    $type_trans = 0;
> > > +    if ( not $nfs_enabled and not $vfat_enabled ) {
> > > +        $type_trans = 1;
> > > +        $tst_count += 1;
> > >      }
> >
> > Why is this disabled on (labeled) NFS?  type_transitions including
> > name-based ones should work there AFAICT.  vfat makes sense.
>
> I cannot get these to work on NFS at all. I've started nfs.sh with:
> mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> mount -t nfs -o
> vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
> localhost:$TESTDIR /mnt/selinux-testsuite
> mount -t nfs -o
> vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> localhost:$TESTDIR /mnt/selinux-testsuite
> And they always failed.

If you just ran the nametrans tests in the host filesystem rather than
in the separate mount, I think it would work.
This would require adjusting the type_transition rules however to
reflect the actual parent directory type (probably test_file_t).
