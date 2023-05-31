Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036CAC77B73
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 14:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjEaO5q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjEaO5p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 10:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF074123
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685545017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUmJD5uwlK73inggAZNbeHWrVeBtFs/iD7UwUUQnuB0=;
        b=LihN9dt9Rz8Yf1DiMHSB5+pqdo/AbrddOLj8xFjeSdul2kRcOCcJ9E/wY3M7s9WG8cY1Oo
        0zL/rRk32j5mW7gyaUD3/nCB/RtHoMH8E3b8mu9DT0k+Seo7sLt+Qa2b6YK84UyNq5QWie
        rvOdMi851DbQROHKaWEKwGp0nmf3DxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-4QJAKRq9MRi0mRodb8_OJQ-1; Wed, 31 May 2023 10:56:56 -0400
X-MC-Unique: 4QJAKRq9MRi0mRodb8_OJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7D18032F5
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 14:56:56 +0000 (UTC)
Received: from localhost (unknown [10.45.226.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3F82202696C;
        Wed, 31 May 2023 14:56:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 5/5] libselinux: Add examples to man pages
In-Reply-To: <20230524111535.1743163-5-vmojzis@redhat.com>
References: <20230524111535.1743163-1-vmojzis@redhat.com>
 <20230524111535.1743163-5-vmojzis@redhat.com>
Date:   Wed, 31 May 2023 16:56:54 +0200
Message-ID: <87ttvsk0qx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> Also fix some typos and remove trailing whitespaces.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libselinux/man/man8/getsebool.8    | 18 +++++++++++-------
>  libselinux/man/man8/matchpathcon.8 | 19 +++++++++++++------
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/libselinux/man/man8/getsebool.8 b/libselinux/man/man8/getsebool.8
> index d70bf1e4..9e36f04f 100644
> --- a/libselinux/man/man8/getsebool.8
> +++ b/libselinux/man/man8/getsebool.8
> @@ -1,6 +1,6 @@
>  .TH "getsebool" "8" "11 Aug 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
>  .SH "NAME"
> -getsebool \- get SELinux boolean value(s) 
> +getsebool \- get SELinux boolean value(s)
>  .
>  .SH "SYNOPSIS"
>  .B getsebool
> @@ -8,17 +8,16 @@ getsebool \- get SELinux boolean value(s)
>  .RI [ boolean ]
>  .
>  .SH "DESCRIPTION"
> -.B getsebool 
> -reports where a particular SELinux boolean or
> -all SELinux booleans are on or off
> -In certain situations a boolean can be in one state with a pending 
> -change to the other state.  getsebool will report this as a pending change.
> +.B getsebool
> +reports whether a particular SELinux boolean, or all SELinux booleans, are on or off.
> +In certain situations a boolean can be in one state with a pending
> +change to the other state. getsebool will report this as a pending change.
>  The pending value indicates
>  the value that will be applied upon the next boolean commit.
>  
>  The setting of boolean values occurs in two stages; first the pending
>  value is changed, then the booleans are committed, causing their
> -active values to become their pending values.  This allows a group of
> +active values to become their pending values. This allows a group of
>  booleans to be changed in a single transaction, by setting all of
>  their pending values as desired and then committing once.
>  .
> @@ -27,6 +26,11 @@ their pending values as desired and then committing once.
>  .B \-a
>  Show all SELinux booleans.
>  .
> +.SH EXAMPLE
> +.nf
> +Show current state of httpd_can_connect_ftp
> +# getsebool httpd_can_connect_ftp
> +.
>  .SH AUTHOR
>  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
>  The program was written by Tresys Technology.
> diff --git a/libselinux/man/man8/matchpathcon.8 b/libselinux/man/man8/matchpathcon.8
> index 50c0d392..6d848f43 100644
> --- a/libselinux/man/man8/matchpathcon.8
> +++ b/libselinux/man/man8/matchpathcon.8
> @@ -25,8 +25,8 @@ queries the system policy and outputs the default security context associated wi
>  Identical paths can have different security contexts, depending on the file
>  type (regular file, directory, link file, char file ...).
>  
> -.B matchpathcon 
> -will also take the file type into consideration in determining the default security context if the file exists.  If the file does not exist, no file type matching will occur.
> +.B matchpathcon
> +will also take the file type into consideration in determining the default security context if the file exists. If the file does not exist, no file type matching will occur.
>  .
>  .SH OPTIONS
>  .TP
> @@ -34,19 +34,19 @@ will also take the file type into consideration in determining the default secur
>  Force file type for the lookup.
>  Valid types are
>  .BR file ", " dir ", "pipe ", " chr_file ", " blk_file ", "
> -.BR lnk_file ", " sock_file .
> +.BR lnk_file ", " sock_file
>  .TP
>  .B \-n
> -Do not display path.
> +Do not display path
>  .TP
>  .B \-N
> -Do not use translations.
> +Do not use translations
>  .TP
>  .BI \-f " file_context_file"
>  Use alternate file_context file
>  .TP
>  .BI \-p " prefix"
> -Use prefix to speed translations
> +Use prefix to speed up translations
>  .TP
>  .BI \-P " policy_root_path"
>  Use alternate policy root path
> @@ -54,6 +54,13 @@ Use alternate policy root path
>  .B \-V
>  Verify file context on disk matches defaults
>  .
> +.SH EXAMPLE
> +.nf
> +Show the default label of sock_file cups.sock
> +# matchpathcon -m sock_file /var/run/cups/cups.sock
> +Verify that /var/www/html directory is labeled correctly (the content of the folder is not checked)
> +# matchpathcon -V /var/www/html
> +.
>  .SH AUTHOR
>  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
>  .
> -- 
> 2.40.0

