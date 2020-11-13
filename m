Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3CBC4742C
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7B22225B
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVH7ayAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKMMP3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgKMMPZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Nov 2020 07:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605269724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SOpAukV2xVESRDTUCQ9lz8W1PqC6TTPNFLzM9aDtpVo=;
        b=bVH7ayAE44McHvw31i0i9J3hv/Ox2FWEUWDHh4hSHb9FlLcrFpW6rZw3mn0nQ2YYIKOxgN
        sQ2KnYpBO7jVlrTfEWGYOQSK3F3kPGftOxjjB4uo8ThfUiAATdQMjiC3x2QULw0Lf8XjPU
        WsYB2pY6ZJIuwzhab2odM5TRN9xPmuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-EDtHSX6IOySA-WXEhOo0mw-1; Fri, 13 Nov 2020 07:15:20 -0500
X-MC-Unique: EDtHSX6IOySA-WXEhOo0mw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15E91803F6A;
        Fri, 13 Nov 2020 12:15:19 +0000 (UTC)
Received: from localhost (unknown [10.40.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D22456EF50;
        Fri, 13 Nov 2020 12:15:18 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Subject: Re: [PATCH] python/sepolicy: allow to override manpage date
In-Reply-To: <20201030215309.23606-1-bwiedemann@suse.de>
References: <20201030215309.23606-1-bwiedemann@suse.de>
Date:   Fri, 13 Nov 2020 13:15:17 +0100
Message-ID: <878sb5pi5m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"Bernhard M. Wiedemann" <bwiedemann@suse.de> writes:

> in order to make builds reproducible.
> See https://reproducible-builds.org/ for why this is good
> and https://reproducible-builds.org/specs/source-date-epoch/
> for the definition of this variable.
>
> This patch was done while working on reproducible builds for openSUSE.
>
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

And merged. Thank you!



> ---
>  python/sepolicy/sepolicy/manpage.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> index 3e8a3be9..2f847abb 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -39,6 +39,8 @@ typealias_types = {
>  equiv_dict = {"smbd": ["samba"], "httpd": ["apache"], "virtd": ["virt", "libvirt"], "named": ["bind"], "fsdaemon": ["smartmon"], "mdadm": ["raid"]}
>  
>  equiv_dirs = ["/var"]
> +man_date = time.strftime("%y-%m-%d", time.gmtime(
> +        int(os.environ.get('SOURCE_DATE_EPOCH', time.time()))))
>  modules_dict = None
>  
>  
> @@ -569,7 +571,7 @@ class ManPage:
>  
>      def _typealias(self,typealias):
>          self.fd.write('.TH  "%(typealias)s_selinux"  "8"  "%(date)s" "%(typealias)s" "SELinux Policy %(typealias)s"'
> -                 % {'typealias':typealias, 'date': time.strftime("%y-%m-%d")})
> +                 % {'typealias':typealias, 'date': man_date})
>          self.fd.write(r"""
>  .SH "NAME"
>  %(typealias)s_selinux \- Security Enhanced Linux Policy for the %(typealias)s processes
> @@ -588,7 +590,7 @@ man page for more details.
>  
>      def _header(self):
>          self.fd.write('.TH  "%(domainname)s_selinux"  "8"  "%(date)s" "%(domainname)s" "SELinux Policy %(domainname)s"'
> -                      % {'domainname': self.domainname, 'date': time.strftime("%y-%m-%d")})
> +                      % {'domainname': self.domainname, 'date': man_date})
>          self.fd.write(r"""
>  .SH "NAME"
>  %(domainname)s_selinux \- Security Enhanced Linux Policy for the %(domainname)s processes
> -- 
> 2.26.2

