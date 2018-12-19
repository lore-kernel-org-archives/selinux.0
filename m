Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33955C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 11:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EB721850
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 11:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLSLI3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:08:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeLSLI3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 19 Dec 2018 06:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B50AC88E54;
        Wed, 19 Dec 2018 11:08:28 +0000 (UTC)
Received: from workstation (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B68171F3;
        Wed, 19 Dec 2018 11:08:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] mcstrans: fix Python linter warnings on test scripts
References: <20181215181455.31643-1-nicolas.iooss@m4x.org>
        <20181215181455.31643-2-nicolas.iooss@m4x.org>
Date:   Wed, 19 Dec 2018 12:08:26 +0100
In-Reply-To: <20181215181455.31643-2-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Sat, 15 Dec 2018 19:14:55 +0100")
Message-ID: <pjdy38lu639.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 11:08:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Both merged. Thanks!

> ---
>  mcstrans/share/util/mlscolor-test |  9 +++++----
>  mcstrans/share/util/mlstrans-test | 12 +++++++-----
>  2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/mcstrans/share/util/mlscolor-test b/mcstrans/share/util/mlscolor-test
> index 447389704beb..03fc4be40375 100644
> --- a/mcstrans/share/util/mlscolor-test
> +++ b/mcstrans/share/util/mlscolor-test
> @@ -1,7 +1,8 @@
>  #!/usr/bin/python -E
>  import sys
> -import re
> -from selinux import *
> +import selinux
> +
> +
>  verbose = 0
>  errors = 0
>  
> @@ -18,12 +19,12 @@ for arg in sys.argv[1:]:
>          line = line.rstrip('\n')
>  #       print line
>          context, expected = line.split("=")
> -        rc, raw = selinux_trans_to_raw_context(context)
> +        rc, raw = selinux.selinux_trans_to_raw_context(context)
>          if rc < 0:
>              print("Unable to get raw context of '%s'" % (context))
>              errors += 1
>              continue
> -        rc, colors = selinux_raw_context_to_color(raw)
> +        rc, colors = selinux.selinux_raw_context_to_color(raw)
>          if rc < 0:
>              print("Unable to get colors for '%s'" % (context))
>              errors += 1
> diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
> index 3ff4444ab000..c026d00ef9c7 100644
> --- a/mcstrans/share/util/mlstrans-test
> +++ b/mcstrans/share/util/mlstrans-test
> @@ -1,14 +1,15 @@
>  #!/usr/bin/python -E
>  import sys
> -import re
> -from selinux import *
> +import selinux
> +
> +
>  verbose = 0
>  errors = 0
>  
>  
>  def untrans(trans, val):
>      global errors, verbose
> -    (rc, raw) = selinux_trans_to_raw_context(trans)
> +    (rc, raw) = selinux.selinux_trans_to_raw_context(trans)
>      if raw != val:
>          print("untrans: '%s' -> '%s' != '%s' FAILED" % (trans, raw, val))
>          errors += 1
> @@ -19,7 +20,7 @@ def untrans(trans, val):
>  
>  def trans(raw, val):
>      global errors, verbose
> -    (rc, trans) = selinux_raw_to_trans_context(raw)
> +    (rc, trans) = selinux.selinux_raw_to_trans_context(raw)
>      if trans != val:
>          print("trans: '%s' -> '%s' != '%s' FAILED" % (raw, trans, val))
>          errors += 1
> @@ -27,6 +28,7 @@ def trans(raw, val):
>          if verbose:
>              print("trans: %s -> %s != %s SUCCESS" % (raw, trans, val))
>  
> +
>  if len(sys.argv) > 1 and sys.argv[1] == "-v":
>      verbose = 1
>  
> @@ -38,7 +40,7 @@ for arg in sys.argv[1:]:
>          if not line.strip():
>              continue
>          line = line.rstrip('\n')
> -        if (line.find("==") != -1):
> +        if line.find("==") != -1:
>              t, r = line.split("==")
>              untrans("a:b:c:" + t, "a:b:c:" + r)
>              trans("a:b:c:" + r, "a:b:c:" + t)
