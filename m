Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59693C47093
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 13:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB93613AD
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 13:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhFAN4A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233584AbhFAN4A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Jun 2021 09:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622555658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pjPCRT8fxhFBoUwVNeLdUgpy5rUlz68haTpphq5B18=;
        b=JKBC3CDANha/CrGWoYixg+EYj/4KUdpwllDi2nKs0nWmFNjFMlNkjIwMkZD9YyVUSDo+Ni
        VT3K3fpvW5GvRRCfHs8DFPG1RtnGVtU8le5t0lyk5TCfIjkKYPdV9ijvnqqViLuTBmEeOE
        a4Cu4QujUO1RWNriErCm1CYYAf8CkW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-FRo3oLrCNua3r2jHKul33A-1; Tue, 01 Jun 2021 09:54:17 -0400
X-MC-Unique: FRo3oLrCNua3r2jHKul33A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E29801107;
        Tue,  1 Jun 2021 13:53:47 +0000 (UTC)
Received: from localhost (unknown [10.40.192.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0A55C1BB;
        Tue,  1 Jun 2021 13:53:46 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] libselinux: make selinux_status_open(3) reentrant
In-Reply-To: <20210510105648.14635-3-cgzones@googlemail.com>
References: <20210510105648.14635-1-cgzones@googlemail.com>
 <20210510105648.14635-3-cgzones@googlemail.com>
Date:   Tue, 01 Jun 2021 15:53:45 +0200
Message-ID: <875yyxd72u.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Do not mmap the status page again if `selinux_status_open(3)` has already
> been called with success.
>
> `selinux_status_open(3)` might be called unintentionally multiple times,
> e.g. once to manually be able to call `selinux_status_getenforce(3)` and
> once indirectly through `selinux_check_access(3)`
> (since libselinux 3.2).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libselinux/src/sestatus.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 12b015e0..531a522c 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -282,6 +282,10 @@ int selinux_status_open(int fallback)
>  	long		pagesize;
>  	uint32_t	seqno;
>=20=20
> +	if (selinux_status !=3D NULL) {
> +		return 0;
> +	}
> +
>  	if (!selinux_mnt) {
>  		errno =3D ENOENT;
>  		return -1;
> --=20
> 2.31.1

