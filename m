Return-Path: <SRS0=ZupP=PP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBC7C43387
	for <selinux@archiver.kernel.org>; Mon,  7 Jan 2019 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DE22070C
	for <selinux@archiver.kernel.org>; Mon,  7 Jan 2019 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfAGL5I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:57:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGL5I (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 7 Jan 2019 06:57:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B517A6E00;
        Mon,  7 Jan 2019 11:57:08 +0000 (UTC)
Received: from workstation (unknown [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54AD058821;
        Mon,  7 Jan 2019 11:57:07 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 4/4] python/audit2allow: allow using audit2why as non-root user
References: <20181221204333.27445-1-nicolas.iooss@m4x.org>
        <20181221204333.27445-4-nicolas.iooss@m4x.org>
Date:   Mon, 07 Jan 2019 12:57:05 +0100
In-Reply-To: <20181221204333.27445-4-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Fri, 21 Dec 2018 21:43:33 +0100")
Message-ID: <pjdy37wof3i.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 07 Jan 2019 11:57:08 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Importing sepolicy as non-root on a system with SELinux causes the
> following exception to be raised:
>
>     ValueError: No SELinux Policy installed
>
> Ignore this when using audit2why, which allows using it with option
> --policy as a non-root user.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

All 4 merged. Thanks!

> ---
>  python/audit2allow/audit2allow | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
> index 195f151c6ca1..18fe0a531d02 100644
> --- a/python/audit2allow/audit2allow
> +++ b/python/audit2allow/audit2allow
> @@ -242,7 +242,10 @@ class AuditToPolicy:
>  
>      def __output_audit2why(self):
>          import selinux
> -        import sepolicy
> +        try:
> +            import sepolicy
> +        except (ImportError, ValueError):
> +            sepolicy = None
>          for i in self.__parser.avc_msgs:
>              rc = i.type
>              data = i.data
> @@ -262,11 +265,13 @@ class AuditToPolicy:
>                  if len(data) > 1:
>                      print("\tOne of the following booleans was set incorrectly.")
>                      for b in data:
> -                        print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(b[0]))
> +                        if sepolicy is not None:
> +                            print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(b[0]))
>                          print("\tAllow access by executing:\n\t# setsebool -P %s %d" % (b[0], b[1]))
>                  else:
>                      print("\tThe boolean %s was set incorrectly. " % (data[0][0]))
> -                    print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(data[0][0]))
> +                    if sepolicy is not None:
> +                        print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(data[0][0]))
>                      print("\tAllow access by executing:\n\t# setsebool -P %s %d" % (data[0][0], data[0][1]))
>                  continue
