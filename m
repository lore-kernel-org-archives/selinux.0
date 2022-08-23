Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A145DC32772
	for <selinux@archiver.kernel.org>; Tue, 23 Aug 2022 17:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiHWRtX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHWRst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Aug 2022 13:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CAB07DB
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661269557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZ1s6mifbHXJr3TVfkFCvYRYYbAM8uBMUbkpX2wdhH8=;
        b=NFp4qB7aHynF25i3lmxTXVm2YXAuftszvR4FnUltfCl1SA0/gsNSxnQeH+85U98ohrBdQ7
        nEyInfU8xYfHLUoQip5fb+4BjRU7E8VqJ6YRu8aWpHAe4OAdVlmo8j3lUpRAFy1ZW0QtWq
        hycR6jRW9BjnNjomT4mq6hueKzH/D0k=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-UgpSKy83O9OP5-ezfdyQRg-1; Tue, 23 Aug 2022 11:45:56 -0400
X-MC-Unique: UgpSKy83O9OP5-ezfdyQRg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-3359a55dcb6so248462917b3.21
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 08:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iZ1s6mifbHXJr3TVfkFCvYRYYbAM8uBMUbkpX2wdhH8=;
        b=At/JPAEuyVpBOhA4OWnyIKEKxceRBZd25k0YyvHHjegwy3k7avCkccyonQvT9PP4rh
         J3KN887cKpK2wjlHwZnpWirenklJQ47OlUGfLM8OCiXu2/0MvdmeHfOqX8/VMnoAk4tL
         bxb8VUlVk964OyR6fi8weojbUs09rg8OB9NJmUxnlSEX5u0TifdYYIuKosaAy2TG9hdB
         f52mCQWqzH3X9wKLNxCKbvQoTGd4DOwayujOWitBm4ONGNmms0qqjxdx6lUBKTMVaGJj
         GQm39lgwBtHn8NT78SNoOO3Nv18kV3UyfaeVQgVrx3YyCcaXw+vf6nZy/bMV5E1xED+k
         O+cA==
X-Gm-Message-State: ACgBeo0RFWn6ejf/ocfE18bKPRgHuwV8yD6/8MQvHIAfye8VxlcJ0ek+
        55zRcu7iUg13tISC0LcayxJYu0LJc79yx8Uo49TRZcuj+SHcH3U0pguKnTpsc+FZUmVG7NcRvUf
        KtRUi01wJ0NWWc3Fff+qB8ucf1rCkM5Bzgg==
X-Received: by 2002:a0d:c745:0:b0:324:8800:f63d with SMTP id j66-20020a0dc745000000b003248800f63dmr26300196ywd.106.1661269555182;
        Tue, 23 Aug 2022 08:45:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5QD4+g0/53IfGp2vOGu2G7aO4FtUVz8aTDSOVrxEupjcI+pjMFy7ke84gZSTFa4ItbRdu+wKBkQSMic6eFIm4=
X-Received: by 2002:a0d:c745:0:b0:324:8800:f63d with SMTP id
 j66-20020a0dc745000000b003248800f63dmr26300179ywd.106.1661269554881; Tue, 23
 Aug 2022 08:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <166008319941.447963.8509896484646848800.stgit@olly>
In-Reply-To: <166008319941.447963.8509896484646848800.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Aug 2022 17:45:43 +0200
Message-ID: <CAFqZXNsdUtSXEsuPcGShw3deuZW8mWF8GFGX9gJ8d9Wtfd5vXQ@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: allow both ENOSPC and EINPROGRESS for CIPSO
 tag space errors
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 10, 2022 at 12:14 AM Paul Moore <paul@paul-moore.com> wrote:
> If the NetLabel subsystem in the kernel is configured to apply CIPSO
> packet labels directly to the packets instead of the sockets, the
> kernel will return EINPROGRESS on a failed connect(2) instead of
> ENOSPC.  This is due to differences in how the CIPSO labels are
> applied to network traffic in the two cases and how the error
> conditions are able to be propagated back to userspace.
>
> This patch allows both error codes to the relevant SCTP test cases.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/sctp/test |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/sctp/test b/tests/sctp/test
> index 69dcbef..5626ab8 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -508,7 +508,7 @@ $pid = server_start( "-t test_sctp_server_t -l s0:c20.c300",
>  # TAG 1 allows categories 0 to 239 to be sent
>  $result = system
>  "runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
> -ok( $result >> 8 eq 7 );
> +ok( ( $result >> 8 eq 7 ) || ( $result >> 8 eq 6 ) );
>
>  if ($test_clpeeloff) {
>
> @@ -675,7 +675,7 @@ $pid = server_start( "-t test_sctp_server_t -l s0:c20.c335",
>  # TAG 2 allows a maximum of 15 categories in exchange
>  $result = system
>  "runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
> -ok( $result >> 8 eq 7 );
> +ok( ( $result >> 8 eq 7 ) || ( $result >> 8 eq 6 ) );
>
>  if ($test_clpeeloff) {
>
> @@ -842,7 +842,7 @@ $pid = server_start( "-t test_sctp_server_t -l s0:c20.c50",
>  # TAG 2 allows a maximum of 7 ranges in exchange
>  $result = system
>  "runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
> -ok( $result >> 8 eq 7 );
> +ok( ( $result >> 8 eq 7 ) || ( $result >> 8 eq 6 ) );
>
>  if ($test_clpeeloff) {

This patch makes sense regardless of the pending kernel fixes, so I
applied it now:
https://github.com/SELinuxProject/selinux-testsuite/commit/c04b5bb4bdcf894a6de6afa0e7e24911dee8dcbf

Thanks!

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

