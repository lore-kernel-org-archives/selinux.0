Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A36C19F28
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 09:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiHCJAy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiHCJAx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Aug 2022 05:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23D096249
        for <selinux@vger.kernel.org>; Wed,  3 Aug 2022 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659517248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJL06V67IGVUXX4XQxwAK70xIPJj7eYaZFNq24oo3V8=;
        b=JefXfvzpCKRz1ebpknPk7avJPR24XMMdJLk0RrDYa9Rh9y/69wzqssLmJ2pS9lekjBfjHU
        T0gdI/dAunrHr+++AzGKtGLCzFkCOo1+7yD5QYupFpO3ZoK7m0IgJT5kRvrJnv+c+0KrYy
        armtNB9k6xTCHMIN1t/8m5ksOrSCI6c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-OxJHXB3-MIabB2L_GNUuiQ-1; Wed, 03 Aug 2022 05:00:47 -0400
X-MC-Unique: OxJHXB3-MIabB2L_GNUuiQ-1
Received: by mail-yb1-f199.google.com with SMTP id 130-20020a250188000000b006777ce7728cso4057112ybb.4
        for <selinux@vger.kernel.org>; Wed, 03 Aug 2022 02:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uJL06V67IGVUXX4XQxwAK70xIPJj7eYaZFNq24oo3V8=;
        b=NXxgiFEGOdITA2qQ371QExOH+vCICwbRqV49+lSpnqBMx96csMoG+XuydP0nIfjc7i
         8Qzwinwjd6aOpsBIegO/u/7GSjZlfnm6zPmmtmoHyf5WRu0xE6xNqhKX95nSlWxj7QNC
         SL/AQQHbgp6QS0UAGOwCli1MAvnOf4VKAW0m+P9b0w9Jaf5HytOjbl0hO+fWmsCKtex2
         2rUYWJdEs3jSY3oI5U0GMREZfZREM+XXAhdGSFjDIcXmgqyAsvSDyRewDO5XVhZo4Ajh
         koUrMlk/NRLIbVC+ZyhHJVR2MLxtU5VgiiS+qZPeY6aAhEgNKn5OMKQhdwcRNUqRggo2
         LUbw==
X-Gm-Message-State: ACgBeo2NITD8tQgFOLCrtELV13kmN/DtN9KjXKUsEwDAzL+aZiKAed6O
        KMB9B+pXFKUus/oXa6fyU6ZWeaHkXywzynIblfJNkwVEGxrmy5haudz+R0G5JCCjD7JQHrH5csX
        QyKasYutOBAxRabYqpjR/rR40P1I052T02A==
X-Received: by 2002:a5b:c84:0:b0:670:6c6f:4028 with SMTP id i4-20020a5b0c84000000b006706c6f4028mr20335967ybq.196.1659517246838;
        Wed, 03 Aug 2022 02:00:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56gy8VKv6hGikas+kqrdem0B9EPeMenwksC4LX8cslOyjFFmCH742zuewt6/+myjqhIxuYLUVcZo2kMRuAQPA=
X-Received: by 2002:a5b:c84:0:b0:670:6c6f:4028 with SMTP id
 i4-20020a5b0c84000000b006706c6f4028mr20335949ybq.196.1659517246640; Wed, 03
 Aug 2022 02:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <20220729120229.207584-22-omosnace@redhat.com>
 <0822dcba-f25d-9443-0ba8-bf518630e9a8@linux.microsoft.com>
In-Reply-To: <0822dcba-f25d-9443-0ba8-bf518630e9a8@linux.microsoft.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Aug 2022 11:00:35 +0200
Message-ID: <CAFqZXNsbEfvVOea_1WO2uWxKsAy7HrE5085OORDazf0BBneZAA@mail.gmail.com>
Subject: Re: [PATCH testsuite 21/24] tests/overlay: don't hard-code SELinux
 user of the caller
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 7:16 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> > We want to allow the testsuite caller to be other than unconfined, so
> > extract the user from current context and use it instead of hard-coding
> > unconfined_u.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   tests/overlay/setup-overlay |  2 +-
> >   tests/overlay/test          | 34 ++++++++++++++++------------------
> >   2 files changed, 17 insertions(+), 19 deletions(-)
> >
> > diff --git a/tests/overlay/setup-overlay b/tests/overlay/setup-overlay
> > index 4fcd023..3f33499 100755
> > --- a/tests/overlay/setup-overlay
> > +++ b/tests/overlay/setup-overlay
> > @@ -41,7 +41,7 @@ setup () {
> >
> >       # Create upper, work, and overlay directories per container.
> >       mkdir -p $BASEDIR/container1/upper $BASEDIR/container1/work $BASEDIR/container1/merged
> > -    chcon -R unconfined_u:object_r:test_overlay_files_ro_t:s0:c10,c20 $BASEDIR/container1
> > +    chcon -R -t test_overlay_files_ro_t -l s0:c10,c20 $BASEDIR/container1
> >
> >       # Label the container directories to match the container context.
> >       # This is simply to ensure correct label inheritance on new file
> > diff --git a/tests/overlay/test b/tests/overlay/test
> > index 2b28c47..c8367dd 100755
> > --- a/tests/overlay/test
> > +++ b/tests/overlay/test
> > @@ -5,6 +5,10 @@ BEGIN {
> >       $basedir = $0;
> >       $basedir =~ s|(.*)/[^/]*|$1|;
> >
> > +    $seuser = `id -Z`;
> > +    chop($seuser);
> > +    $seuser =~ s|^(\w+):.*$|$1|;
>
> Is chop actually needed here?  My perl is a little rusty, so there may
> be some perl regex-y reason, but you're discarding everything after the
> first ":" anyways.

Yeah, it's actually not needed, but I'd rather leave it there to
document that one needs to account for the line ending in the initial
value. Otherwise people changing the regex in the future may get
bitten by it.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

