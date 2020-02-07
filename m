Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7909C04EB5
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9204C20720
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 15:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0+vkF2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBGPjb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:39:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbgBGPjb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 10:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581089970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQ97YR2us9VZzSi4hlrHwMRd/i0jd96cOurmjqGFoBU=;
        b=O0+vkF2oKD6JVgeZ4XVJsR+3HQL19tRBNgEuSnNm4fIWDZPT/3NpMWmvfINJu10NifMBte
        2GKtwRjkkTLzlJvwXEFSg4K9tr14A9rFGLspRrZJus7jwAWWvZvVmsu0xz75QvR6ryQ776
        HSAqIlJoz2FBCPmMpoCnN/lY57OadtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Qdb5XTJgNMiXGS5ZR4VknA-1; Fri, 07 Feb 2020 10:39:25 -0500
X-MC-Unique: Qdb5XTJgNMiXGS5ZR4VknA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5F0D8018A1;
        Fri,  7 Feb 2020 15:39:24 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27EF45DA7E;
        Fri,  7 Feb 2020 15:39:23 +0000 (UTC)
References: <20200207143744.9944-1-cgzones@googlemail.com>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: drop error return from is_selinux_enabled.3
In-reply-to: <20200207143744.9944-1-cgzones@googlemail.com>
Date:   Fri, 07 Feb 2020 16:39:22 +0100
Message-ID: <pjd36bm4dat.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> is_selinux_enabled() does never return -1, do not say so in the manpage.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/man/man3/is_selinux_enabled.3 | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/ma=
n3/is_selinux_enabled.3
> index df62c225..a887b48c 100644
> --- a/libselinux/man/man3/is_selinux_enabled.3
> +++ b/libselinux/man/man3/is_selinux_enabled.3
> @@ -15,7 +15,6 @@ is_selinux_mls_enabled \- check whether SELinux is enab=
led for (Multi Level Secu
>  .SH "DESCRIPTION"
>  .BR is_selinux_enabled ()
>  returns 1 if SELinux is running or 0 if it is not.=20
> -On error, \-1 is returned.
>=20=20
>  .BR is_selinux_mls_enabled ()
>  returns 1 if SELinux is capable of running in MLS mode or 0 if it is not=
. To


There's also

libselinux/include/selinux/selinux.h:

/* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we =
get an error. */
extern int is_selinux_enabled(void);


Would you mind to update this as well?

Thanks,

Petr

