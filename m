Return-Path: <SRS0=c9VK=PQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F606C43387
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 11:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1901D206B7
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 11:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfAHLEf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfAHLEf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Jan 2019 06:04:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5749AD4E56;
        Tue,  8 Jan 2019 11:04:35 +0000 (UTC)
Received: from workstation (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D2419744;
        Tue,  8 Jan 2019 11:04:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 5/5] python: run all the tests with "make test"
References: <20190105193759.3333-1-nicolas.iooss@m4x.org>
        <20190105193759.3333-6-nicolas.iooss@m4x.org>
Date:   Tue, 08 Jan 2019 12:04:33 +0100
In-Reply-To: <20190105193759.3333-6-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Sat, 5 Jan 2019 20:37:59 +0100")
Message-ID: <pjdk1jfo1fi.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 08 Jan 2019 11:04:35 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

All 5 merged. Thanks!

> ---
>  python/Makefile       | 4 +---
>  python/chcat/Makefile | 2 ++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/python/Makefile b/python/Makefile
> index 80bc124b6233..9b66d52fbd4d 100644
> --- a/python/Makefile
> +++ b/python/Makefile
> @@ -1,8 +1,6 @@
>  SUBDIRS = sepolicy audit2allow semanage sepolgen chcat
>  
> -all install relabel clean indent:
> +all install relabel clean indent test:
>  	@for subdir in $(SUBDIRS); do \
>  		(cd $$subdir && $(MAKE) $@) || exit 1; \
>  	done
> -
> -test:
> diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> index 290b9a6ec7dc..79620f60ca27 100644
> --- a/python/chcat/Makefile
> +++ b/python/chcat/Makefile
> @@ -17,3 +17,5 @@ clean:
>  indent:
>  
>  relabel:
> +
> +test:
