Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225AC433E9
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 01:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5450A2074A
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 01:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbhANBwg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729752AbhANAF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 19:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610582641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4rqK8ZfUfdIUk8J2UerL98B4qfMUtp3Qj54Zkzugqw=;
        b=Sr7C/MDldQ04HJ1cRC9/hnwRsL9vkxHETFImigk5cnUQCvJz09VLUTXRl62dxUBWeJy3ig
        NdSOM4f2PPv2Z6m97b6Z57qxvZMc54TxG4QUDz746kmslQrZF1508+SoNb9FQUQ4lyrZRl
        003kSW+RaW1Q3BPLY8unxU/iqGHXD60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-jONvzRE1MDu9GVYun0mMPw-1; Wed, 13 Jan 2021 17:50:16 -0500
X-MC-Unique: jONvzRE1MDu9GVYun0mMPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3585806661;
        Wed, 13 Jan 2021 22:50:15 +0000 (UTC)
Received: from localhost (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 780B35D71F;
        Wed, 13 Jan 2021 22:50:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] python/semanage: Sort imports in alphabetical order
In-Reply-To: <20210106090007.176771-1-vmojzis@redhat.com>
References: <CAJfZ7==efgpSLs-U81UEp-0ven0mr3WZMLpP1+1XC8a-ww0uSg@mail.gmail.com>
 <20210106090007.176771-1-vmojzis@redhat.com>
Date:   Wed, 13 Jan 2021 23:50:14 +0100
Message-ID: <87mtxca1uh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Both merged, thanks!


> ---
>  python/semanage/semanage | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index ce15983b..125271df 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -23,11 +23,13 @@
>  #
>  #
>  
> -import traceback
>  import argparse
> +import os
> +import re
>  import seobject
>  import sys
> -import os
> +import traceback
> +
>  PROGNAME = "policycoreutils"
>  try:
>      import gettext
> @@ -798,8 +800,6 @@ def setupExportParser(subparsers):
>      exportParser.add_argument('-f', '--output_file', dest='output_file', action=SetExportFile, help=_('Output file'))
>      exportParser.set_defaults(func=handleExport)
>  
> -import re
> -
>  
>  def mkargv(line):
>      dquote = "\""
> -- 
> 2.29.2

