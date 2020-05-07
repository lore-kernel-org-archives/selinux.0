Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A6C38A24
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 08:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1D2078C
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 08:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuJL7Ubs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGI0R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 04:26:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbgEGI0Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 04:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588839974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmuqE5bQR3wuxjxZ0d/jv9QQS37wbUP3ZO3aykma5Ts=;
        b=EuJL7UbsmA0JEZkY10K8/dQujyDFUXxs3gBuahCEcCeUYqqs0jMdAHjDH8OLrBd2vmSCJS
        ZmUjdC11/hjsTgxgjEssFFqcM4acBSGVHvLKPvUTz4RM2PmHGdqcfdmiXKUP0hgTlDfc2Y
        2Rt6Xb8pfCcPbAJB3xahqVhmvbv02G0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-pRdZPwzzNWCNT1ZURaDiJQ-1; Thu, 07 May 2020 04:26:09 -0400
X-MC-Unique: pRdZPwzzNWCNT1ZURaDiJQ-1
Received: by mail-ot1-f72.google.com with SMTP id k11so2564480otc.8
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 01:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmuqE5bQR3wuxjxZ0d/jv9QQS37wbUP3ZO3aykma5Ts=;
        b=l1FBMqJ9RyKGnzvsL5gkOOFxFcvqlAwCtvkFuFNyX9Dk/eGx7YyxL+9Sv49ngpJ2cf
         QOTIH2CIFVFhjIhgwE4Kvae53d7uRjUlfRZiDnfTzIv0zYo2N9K+3ZQdZdvKsIvZfEKe
         Dk1pDC1veZxIUxh3OQoih9wbNNOOzR+BwzM+aIuV/swGqu9Z+uZ18puS0Aq9NfK+oTLE
         WVfMIKvW/Ko8ay5WuoHbcttXxn4/pY0biWqgsqie7guxJukkUrizAqBuEHtDHS7DD+sA
         nubYvdjnNUIzVA2qm02/7vkFJUBDKDhEe0drU+U3GRaTaWUpVW1hkTauk/i3KB6WkMJa
         /C3A==
X-Gm-Message-State: AGi0PuZuIDt3guQ46HGJDVQsO5yTDFFOjeljX9qHwnLckedjJvMGftKW
        EOCooxTiSQc6BmJsor1ixv/BYRy6u1xDOeRfNkw+n+k+fOkzkYOjMw2XesbPU6uEx9G9G6BkkC4
        u4Sruyh5+o9W+cbuikxuvS8I8zxuWqj+n5g==
X-Received: by 2002:aca:ed44:: with SMTP id l65mr5716445oih.127.1588839968910;
        Thu, 07 May 2020 01:26:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLmPqBxcIkN1DCi0ckREc753/6YBmbcJRzKmizP6vW+qV016UssKOO7DrrAhQjBpHJFV4h7A50tJROQa4RPF0U=
X-Received: by 2002:aca:ed44:: with SMTP id l65mr5716432oih.127.1588839968701;
 Thu, 07 May 2020 01:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200506211435.30296-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200506211435.30296-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 May 2020 10:25:57 +0200
Message-ID: <CAFqZXNsDv3pmeW-5Knc1bpcN5U3yzFE61JKnNYRU+w2N0W+PzQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 11:14 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
[...]
> ---
> v2 improves the patch description and README.md and tries to provide
> greater compatibility with older systems. NB One must set SUPPORTS_CIL
> to n to disable loading the CIL modules; the alternative would be
> some kind of package version test but doing so in a distro-agnostic
> and backward-compatible manner looks painful.

Thanks! As I said in another reply, I agree that CIL support detection
wouldn't be worth it here.

>
>  README.md                            | 66 +++++++++++++++++++++++++++-
>  policy/Makefile                      | 13 +++++-
>  policy/test_capable_net.te           |  2 -
>  policy/test_execute_no_trans.te      |  3 +-
>  policy/test_filesystem.te            |  1 +
>  policy/test_global.te                |  1 +
>  policy/test_ibendport.te             |  9 ++--
>  policy/test_inet_socket.te           | 22 +++++-----
>  policy/test_mlsconstrain.cil         |  2 +
>  policy/test_overlay_defaultrange.cil |  7 +++
>  policy/test_overlayfs.te             |  1 +
>  policy/test_policy.if                |  4 +-
>  policy/test_sctp.te                  |  1 +
>  tests/cap_userns/test                |  8 ++++
>  tests/filesystem/test                |  2 +-
>  tests/fs_filesystem/test             |  2 +-
>  tests/mmap/test                      | 49 ++++++++++++++-------
>  17 files changed, 149 insertions(+), 44 deletions(-)
>  create mode 100644 policy/test_mlsconstrain.cil
>  create mode 100644 policy/test_overlay_defaultrange.cil
[...]
> diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
> index 79ba868..2c0346a 100644
> --- a/policy/test_execute_no_trans.te
> +++ b/policy/test_execute_no_trans.te
> @@ -24,4 +24,5 @@ userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
>
>  #Allow test_execute_notrans permissions to the allowed type
>  can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
> -allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
> +allow_map(test_execute_notrans_t, test_execute_notrans_denied_t, file)
> +allow test_execute_notrans_t test_execute_notrans_denied_t:file { getattr open read };

An alternative solution could be to use "mmap_file_perms" unless it is
not defined, in which case we can assume a non-legacy policy and use
the proper "mmap_exec_file_perms". But I'm fine with your approach as
well if you don't want to change it.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

