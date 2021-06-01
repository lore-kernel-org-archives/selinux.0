Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B5C4708F
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3B613AD
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhFANy7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233584AbhFANy7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Jun 2021 09:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622555598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/amc4Ec+veiTweb6FhhAgAhSJqr8SR26cddTka+oTA=;
        b=URk+0hFBQscxhqGmD6yO22pP2vJKE2nDZJF/czzFD33XFl0uRarR4XxiBM1sX0igBNM6mU
        xN/dnnrK6b5zSNPeUkFiq3IBozWFxrqQYtOFJfn0B5YSgTaV1vEvjMlZf+wdHSZfoxtqLE
        46z1BXhtgqdBN7LQJkqChuejfXkexns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-uVuY0TzKOnOKxCnKfylSoQ-1; Tue, 01 Jun 2021 09:53:16 -0400
X-MC-Unique: uVuY0TzKOnOKxCnKfylSoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2998E101C8B8;
        Tue,  1 Jun 2021 13:53:14 +0000 (UTC)
Received: from localhost (unknown [10.40.192.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E51B76208;
        Tue,  1 Jun 2021 13:53:12 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] libselinux: avc_destroy(3) closes status page
In-Reply-To: <20210510105648.14635-2-cgzones@googlemail.com>
References: <20210510105648.14635-1-cgzones@googlemail.com>
 <20210510105648.14635-2-cgzones@googlemail.com>
Date:   Tue, 01 Jun 2021 15:53:11 +0200
Message-ID: <878s3td73s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Mention in the manpage of avc_destroy(3) that it does close the SELinux
> status page, which might have been opened manually by the client
> application.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libselinux/man/man3/avc_open.3 | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_ope=
n.3
> index 3090dd50..55683bb6 100644
> --- a/libselinux/man/man3/avc_open.3
> +++ b/libselinux/man/man3/avc_open.3
> @@ -26,6 +26,9 @@ initializes the userspace AVC and must be called before=
 any other AVC operation
>  destroys the userspace AVC, freeing all internal memory structures.  Aft=
er this call has been made,=20
>  .BR avc_open ()
>  must be called again before any AVC operations can be performed.
> +.BR avc_destroy ()
> +also closes the SELinux status page, which might have been opened manual=
ly by
> +.BR selinux_status_open (3).
>=20=20
>  .BR avc_reset ()
>  flushes the userspace AVC, causing it to forget any cached access decisi=
ons.  The userspace AVC normally calls this function automatically when nee=
ded, see
> --=20
> 2.31.1

