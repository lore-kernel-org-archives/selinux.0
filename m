Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A59AC433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 09:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhKXJoU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 04:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhKXJoS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 04:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637746869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+4MRKsNDvPlTg3ygyN2IWzrs/GFmn3V7IZAVQ4Wq7g=;
        b=Q89gTqzJ5x7UeRBaAoBe7WEHxYrpPbWTPNsuDAvoX8NUjnvjbwPVnyxI1n5+6QnFPBKaam
        KjppG8691L9Sx0gmcNeuWLIH9QOL69fmexmodVk2a9Oz7c6GdOZH3G1Lxov1Vc/Ls15osq
        HbxAnNTcs6paD/ZCI83sBb661IByoKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-maUaUEe5PLa2urbqQKD_QA-1; Wed, 24 Nov 2021 04:41:06 -0500
X-MC-Unique: maUaUEe5PLa2urbqQKD_QA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8723F81CCC2;
        Wed, 24 Nov 2021 09:41:05 +0000 (UTC)
Received: from localhost (unknown [10.40.193.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2007F5D6CF;
        Wed, 24 Nov 2021 09:41:04 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Jacob M Cutright <cutrightjm@stl.sh>, selinux@vger.kernel.org
Subject: Re: [PATCH] Modified Russian and English man pages to fix typo;
 REQUIREUSERS -> REQUIRESEUSERS
In-Reply-To: <20211124024029.11520-1-cutrightjm@stl.sh>
References: <20211124024029.11520-1-cutrightjm@stl.sh>
Date:   Wed, 24 Nov 2021 10:41:03 +0100
Message-ID: <87a6htlwls.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jacob M Cutright <cutrightjm@stl.sh> writes:

> From: Cutright Jacob <cutrightjm@stl.sh>
>
> Signed-off-by: Jacob M Cutright <cutrightjm@stl.sh>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
>  policycoreutils/man/man5/selinux_config.5    | 2 +-
>  policycoreutils/man/ru/man5/selinux_config.5 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/=
man/man5/selinux_config.5
> index 58b42a0e..f391befb 100644
> --- a/policycoreutils/man/man5/selinux_config.5
> +++ b/policycoreutils/man/man5/selinux_config.5
> @@ -32,7 +32,7 @@ The \fIconfig\fR file supports the following parameters:
>  .br
>  \fBSELINUXTYPE =3D \fIpolicy_name\fR
>  .br
> -\fBREQUIREUSERS =3D \fI0\fR | \fI1\fR
> +\fBREQUIRESEUSERS =3D \fI0\fR | \fI1\fR
>  .br
>  \fBAUTORELABEL =3D \fI0\fR | \fI1\fR
>  .RE
> diff --git a/policycoreutils/man/ru/man5/selinux_config.5 b/policycoreuti=
ls/man/ru/man5/selinux_config.5
> index 40039e57..8c0db9ae 100644
> --- a/policycoreutils/man/ru/man5/selinux_config.5
> +++ b/policycoreutils/man/ru/man5/selinux_config.5
> @@ -34,7 +34,7 @@ config \- =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BF=D0=BE=D0=B4=
=D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D1=8B SELinux.
>  .br
>  \fBSELINUXTYPE =3D \fIpolicy_name\fR
>  .br
> -\fBREQUIREUSERS =3D \fI0\fR | \fI1\fR
> +\fBREQUIRESEUSERS =3D \fI0\fR | \fI1\fR
>  .br
>  \fBAUTORELABEL =3D \fI0\fR | \fI1\fR
>  .RE
> --=20
> 2.27.0

