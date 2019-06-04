Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B296C282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 21:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14646207E0
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 21:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BtD13m1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFDV3f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:29:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39505 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfFDV3f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Jun 2019 17:29:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so11074026lfo.6
        for <selinux@vger.kernel.org>; Tue, 04 Jun 2019 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOiMLynohErL9DuQjq02wNLaWvLsLdIBY6NOPPq3uYM=;
        b=BtD13m1GbNj6/1ewaCXYo1xToow5EiE1RySpDW4SgIXgWCDkwa6OI3XdquFfSnzx/G
         2RwM9ruLZuzLDSdhIdjk5DFHuRzsdLW6aJh9RAGewRDwvqE7k9AlsuZQ8TSOPfLjGs3g
         hIBX8F8J5FHwzb3lSIZYSpj3ssTtMaGE8XRZIQtECPfF78Wi+r/nuYgamgf4iDWCyxhT
         lTP8hPJYP6HOHdMkybI2GajVo7qsZqwLOCqL/z/9eRh3nQdqDs08NtPar3wPk+MVAU39
         j2URdXEu0eLHLNSwv0w+xLORYEO94SoEVLXjtZ0FlS2Q7JE4Kt0jFijTAWdu+WkGxofR
         C6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOiMLynohErL9DuQjq02wNLaWvLsLdIBY6NOPPq3uYM=;
        b=KeIIACv1WYT+1R3GB9d4et6SJwpvrVpEAnBWqTOxJbQau/fqExYNZmsBjuFvh7P8Se
         VrQgpwDqy9o1RcScIOJktnAaKzozotW/Yc/rpj92nIa2FogItYwLublZ46WtqItr+pGt
         w9Ag5ZPqKkWIbSEWI5kIUmcQ+I3/BvoibvmnySURboizWbE/Y/0XDmSL5wfUA+3nSFty
         LZUHXAcvHiEoZm9W2FZCPHt0KRvyF+yTJtj37FRp6jIAvLKvNBfFRflTrYhUObzUqftW
         U9bGzDDwX1YR5ks3Lb6OO4DROe4YVa/0frG3h3qOoJBBkrTtDOLblLQHJ7bGzY/QIGT1
         ZnaQ==
X-Gm-Message-State: APjAAAXIsr66B0/KVXomwEeR4/x1pPXXOL8NPRNuR5aqCDr2niFBacda
        PWDvrmVOBIcVAX703epUlJJzPVVAFBit3hL6XL8R
X-Google-Smtp-Source: APXvYqyTvNoZwy6I7llr+Y937a4uriEpPLKGi0/IaE97BSSQklf6YvCerxDVqlYqAMN82Oor1zIu/X4b+Kp2XFsrRHE=
X-Received: by 2002:ac2:446b:: with SMTP id y11mr13117962lfl.158.1559683773652;
 Tue, 04 Jun 2019 14:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190602104644.9569-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190602104644.9569-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Jun 2019 17:29:22 -0400
Message-ID: <CAHC9VhRPpWv6gGvfF-4-Lg6FzxPhD0-Lzgmkw8kjrpV1HxpFFA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Correct address count for asconf sctp test
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 3, 2019 at 6:13 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> The address count only checks the first two entries, correct to check
> others in list until two addresses are found, or not.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  tests/sctp/test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into master, thanks.

> diff --git a/tests/sctp/test b/tests/sctp/test
> index 472bd77..ae1b5e5 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -33,8 +33,8 @@ BEGIN {
>          for my $line ( split /\n/, $ipaddress_list ) {
>              if ( $line =~ /inet ([^ \/]+)/ && $count < 2 ) {
>                  $ipaddress[$count] = $1;
> +                $count++;
>              }
> -            $count++;
>          }
>
>          if ( $ipaddress[1] ne 0 ) {
> --
> 2.21.0
>


-- 
paul moore
www.paul-moore.com
