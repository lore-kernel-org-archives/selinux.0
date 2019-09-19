Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E52C49ED7
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 07:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AD5206C2
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 07:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGDy7jSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfISHRi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:17:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729765AbfISHRi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 03:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568877456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD0GT/uV6D8ysY/S7Aiyx1JlyK/BNTVkbLAp6nF6E08=;
        b=IGDy7jSSLrcDvksnmQs76BiP7+ffnfSa3+DnedeXxtHFGtqle6r0FNvEgLk3N+yrbFnbad
        F/PMrdCBgtRWb914P6eY2cIcK8gPbGpSRug64hpMtDFOKOxVgoU/gf+alnCq11zUZiZqcZ
        SY9jXCD57oCNUtg3hvfyCVXie+YJfeo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-6QM4QnLWPYaFcGVE1jUPkQ-1; Thu, 19 Sep 2019 03:17:35 -0400
Received: by mail-ot1-f70.google.com with SMTP id l25so1152522otp.10
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 00:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vl/zVPDzbcV4QN6YT9d0ZvLaxZB0k66KAZBgv0lAP/Y=;
        b=PjYZd5/tZpRTVFnZRXDz0ikOqWP6w+IDeFGZfSbz9wJk5pWIKqN9TiWDI5PiLbO6Ou
         CdvHIrbb5fJgH+XcxUNZucaV18YmM8BCM4d/I6OzaJDfp7QIFaUj0nNal4CnonY8yfDo
         zy4rSp7w/RBF+0sx2PeH6DpGukE1mCtEiiMx4HX90IF3vyzwTrGBkoyIgP3dhWHKmNpK
         Oks8Jh9yXWsRlkTjYTtbT08a3T+5ULR/ZETGtft+IRQDgzEgbmuv9dtlntQqSJwzLcKK
         w1ei9QAi+GQ+FC94nVvYHWbePlYAd7Wkb0JpIWkbZy4VDdCkMPg/4FgzRyeHxtZlu6zd
         +fbg==
X-Gm-Message-State: APjAAAUBnQD2cnoiZT1Dn1QQofgQ4EfaabKtM4R5IgWBj0ex2JSzkGWs
        xfwHtsNgbNNrPfcQvevvOiHTvcF7c83CWZ3HskgVqCWl7FL6mFgf6piEseXi2k5SyOB8HLzZk5M
        C9kfOZQZH1FLdSFK+OAQ3GM4FGsw3voL/5g==
X-Received: by 2002:aca:5781:: with SMTP id l123mr1200374oib.166.1568877454594;
        Thu, 19 Sep 2019 00:17:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRiYveHHOLdcusPalaOiJihcN3F81MI+ktxrKCSEBtNY+HIH9Pvi/qTixh9HgOv/+CI9Y+H+0OGEW14eH/Ja8=
X-Received: by 2002:aca:5781:: with SMTP id l123mr1200353oib.166.1568877454329;
 Thu, 19 Sep 2019 00:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190918125251.10646-1-sds@tycho.nsa.gov>
In-Reply-To: <20190918125251.10646-1-sds@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 19 Sep 2019 09:17:23 +0200
Message-ID: <CAFqZXNvUv7V5y1CLbaO-HZKOoRnmEQzE+r9myw+o1Eg9fdrYMg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix test/file to avoid noise in test output
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 6QM4QnLWPYaFcGVE1jUPkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 18, 2019 at 2:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit ec3ea0fcf3742cba319 ("tests/file: use getfattr instead of ls -Z")
> introduced noise in the test output for the file tests because the
> context value returned by getfattr includes the terminating NUL and
> this caused the command lines to be truncated, omitting the stderr
> redirection.  Use the same technique we already use in overlay/test
> by chop()'ing off the terminating NUL.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/file/test | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/file/test b/tests/file/test
> index 8fe98f6a5b4a..5e080fc6d4e9 100755
> --- a/tests/file/test
> +++ b/tests/file/test
> @@ -51,6 +51,7 @@ system "chcon -t fileop_exec_t $basedir/wait_io 2>&1 > =
/dev/null";
>  #
>  $good_file_sid =3D
>    `getfattr --only-values -n security.selinux $basedir/temp_file`;
> +chop($good_file_sid);
>
>  #
>  # Attempt to access a restricted file as the 'good' domain.  The first t=
est
> --
> 2.21.0
>

Thanks for this patch. I agree that chop() is a more straightforward
way to do it than my tr-based solution. I hadn't thought of looking
for existing uses of getfattr in the testsuite...

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

