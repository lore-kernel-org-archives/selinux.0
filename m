Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC06C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 08:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B16207FC
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 08:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fapeTAVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbfISIHs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:07:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730118AbfISIHs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 04:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568880466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXK0xe73j1n6H3/wveMhGFP/I8yOngXfeyg8qUdJE3w=;
        b=fapeTAVW1rwM6p0xivUjEVtugr0q28ka6LHT0AJPZJv1AYO5w0+skFWzIHGz7GNHLyICBU
        TSKsVhNam0BD/TqQc6e3d7XUt3FwP9lrMH/6uPiTckNIOeFu7w8CPOKWQrCMRVaBbH/uIi
        zJHQxUHtmMV5uvR2IJAqkH+bYsjSytY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-gyAlZ55wPl-jI2x5KkxYvg-1; Thu, 19 Sep 2019 04:07:45 -0400
Received: by mail-ot1-f69.google.com with SMTP id f6so1337481oti.9
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 01:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfssrvUgr0EqLnIFyYM7OK5GT5bzXecJb8pYajy5xOg=;
        b=cuWG0Ag/cZGgRfaQq+UO+5rWnokhXpeIWSE9/o0KE8sSsR9xiT3Ay8rIIwhyU/bF/O
         7MbQEWLZz6ZUnM6Db9H/g/Gk4SHHuKCKyQn0NwwKV2WVtDBS3jrP1IG9D24JA7M9yov1
         09SIwPU8lzqmahg4MsJItcOMr2PXQMHxdNM3m7huWkaC1DspEYCjMtdGOF1pNKpDw2Ld
         GT+JEaYU/nxgM53hOdDQunTB5+ClBgnDOAh8ucJ2RsKUykpAarkldUs+17G/ny7vkqBQ
         oopTD1dGDL+Q/bf/R6rHnf9MJUGrODxVrhXl9pGuJo49Qch+SwZRL/xGx0AplB82dGht
         3VoA==
X-Gm-Message-State: APjAAAVb3wiadcOnBw54q/c4hphodFJHJ4kqQYSjD38EOL1k3o00akYZ
        K5b3uTdCAUYn8Q4ADlqFfx9e6WDsrSVAoPEpQP1zuFP+e+zPmSMOTx9/rlL3myGcyB9BLIaPYmI
        oyCwUQkXGNTj+gt2x/6T3zS10eDWVxjL+aQ==
X-Received: by 2002:a54:4392:: with SMTP id u18mr1297677oiv.103.1568880463773;
        Thu, 19 Sep 2019 01:07:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGjg9rdGd/CFBJaByVlqZBwA74zim1bbqgb6FMBK5Co8RKLSqnT1gusIVn0Mvl4wgz4haSPWUfpPAyqhgZHvU=
X-Received: by 2002:a54:4392:: with SMTP id u18mr1297664oiv.103.1568880463505;
 Thu, 19 Sep 2019 01:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190918185825.8012-1-sds@tycho.nsa.gov>
In-Reply-To: <20190918185825.8012-1-sds@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 19 Sep 2019 10:07:32 +0200
Message-ID: <CAFqZXNt4gtvgLbTj18=DW65SnQieaGA=++nKd0QLhzkQ6fERAg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: drop use of userdom_read_inherited_user_tmp_files
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: gyAlZ55wPl-jI2x5KkxYvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 18, 2019 at 8:58 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The overlay test policy had two calls to the
> userdom_read_inherited_user_tmp_files() policy interface.
> This is a Fedora-specific interface that is not present in
> refpolicy and therefore prevents building the test policy on
> other distributions.  Further, there is no clear reason why
> the calls to this interface are needed for the overlay tests;
> the tests are not inheriting open /tmp files.  Remove the
> calls.
>
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/57
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

This patch doesn't break anything for me when run on Fedora Rawhide -
even when I run the testsuite under /tmp.

Tested-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  policy/test_overlayfs.te | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> index 3be53fce0f9c..6f1756e9a118 100644
> --- a/policy/test_overlayfs.te
> +++ b/policy/test_overlayfs.te
> @@ -50,7 +50,6 @@ fs_mount_xattr_fs(test_overlay_mounter_t)
>  corecmd_shell_entry_type(test_overlay_mounter_t)
>  corecmd_exec_bin(test_overlay_mounter_t)
>
> -userdom_read_inherited_user_tmp_files(test_overlay_mounter_t)
>  userdom_search_admin_dir(test_overlay_mounter_t)
>  userdom_search_user_home_content(test_overlay_mounter_t)
>
> @@ -123,7 +122,6 @@ corecmd_exec_bin(test_overlay_client_t)
>  kernel_read_system_state(test_overlay_client_t)
>  kernel_read_proc_symlinks(test_overlay_client_t)
>
> -userdom_read_inherited_user_tmp_files(test_overlay_client_t)
>  userdom_search_admin_dir(test_overlay_client_t)
>  userdom_search_user_home_content(test_overlay_client_t)
>
> --
> 2.21.0
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

