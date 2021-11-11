Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F3C433EF
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 14:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9891D610CB
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 14:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhKKOGe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232033AbhKKOGe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Nov 2021 09:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636639425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ea0nZf7d7gaRioOEzcKYgvTkBCwXGRf/M8c41jaWbJM=;
        b=eVmGqYXUoZuD6HfUob9oiBnv508h9hTQ9jH+V40x6tdFe5pzs1fx/6jUO9i6nk5PB64Y/W
        4EF44FhYFqNHcTuUnCOog3TwWnTRUCt1xtpdmrC0GwyScwVwX25wCS3c74wJrmkp0X+3WB
        H3DLr9P1G5Hft2vMZfvYvUvHzDtpF2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-W4SoAoyTMpalrnQ1EJnaNA-1; Thu, 11 Nov 2021 09:03:41 -0500
X-MC-Unique: W4SoAoyTMpalrnQ1EJnaNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BF487D543;
        Thu, 11 Nov 2021 14:03:38 +0000 (UTC)
Received: from localhost (unknown [10.40.192.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43E7019D9D;
        Thu, 11 Nov 2021 14:03:37 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     markus.linnala@gmail.com, selinux@vger.kernel.org
Cc:     Markus Linnala <Markus.Linnala@knowit.fi>
Subject: Re: [PATCH] Use IANA-managed domain example.com in examples
In-Reply-To: <20211109153956.472188-1-markus.linnala@gmail.com>
References: <20211109153956.472188-1-markus.linnala@gmail.com>
Date:   Thu, 11 Nov 2021 15:03:36 +0100
Message-ID: <87lf1ux007.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

markus.linnala@gmail.com writes:

> From: Markus Linnala <Markus.Linnala@knowit.fi>
>
> See: RFC 2606
>
> foo.com seems to be privately owned.
>
> Signed-off-by: Markus Linnala <Markus.Linnala@knowit.fi>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libsemanage/man/man5/semanage.conf.5    | 2 +-
>  libsemanage/man/ru/man5/semanage.conf.5 | 2 +-
>  libsemanage/src/semanage.conf           | 5 +++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/=
semanage.conf.5
> index 7d6f2fef..380b58be 100644
> --- a/libsemanage/man/man5/semanage.conf.5
> +++ b/libsemanage/man/man5/semanage.conf.5
> @@ -23,7 +23,7 @@ Management library writes to the SELinux policy module =
store directly (this is t
>  Otherwise a socket path or a server name can be used for the argument.
>  If the argument begins with "/" (as in "/foo/bar"), it represents the pa=
th to a named socket that should be used to connect the policy management
>  server.
> -If the argument does not begin with a "/" (as in "foo.com:4242"), it sho=
uld be interpreted as the name of a remote policy management server
> +If the argument does not begin with a "/" (as in "example.com:4242"), it=
 should be interpreted as the name of a remote policy management server
>  to be used through a TCP connection (default port is 4242 unless a diffe=
rent one is specified after the server name using the colon to separate
>  the two fields).
>=20=20
> diff --git a/libsemanage/man/ru/man5/semanage.conf.5 b/libsemanage/man/ru=
/man5/semanage.conf.5
> index cf65b3e6..548aa58d 100644
> --- a/libsemanage/man/ru/man5/semanage.conf.5
> +++ b/libsemanage/man/ru/man5/semanage.conf.5
> @@ -19,7 +19,7 @@ semanage.conf \- =D0=B3=D0=BB=D0=BE=D0=B1=D0=B0=D0=BB=
=D1=8C=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=84=
=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=B4=D0=BB=D1=8F=20
>  =D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C, =D0=BA=D0=B0=D0=BA =D0=B1=D0=
=B8=D0=B1=D0=BB=D0=B8=D0=BE=D1=82=D0=B5=D0=BA=D0=B0 =D1=83=D0=BF=D1=80=D0=
=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F SELinux =D0=B4=D0=BE=D0=BB=D0=B6=D0=
=BD=D0=B0 =D0=B2=D0=B7=D0=B0=D0=B8=D0=BC=D0=BE=D0=B4=D0=B5=D0=B9=D1=81=D1=
=82=D0=B2=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 =D1=85=D1=80=D0=B0=D0=BD=D0=
=B8=D0=BB=D0=B8=D1=89=D0=B5=D0=BC =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=
=BA=D0=B8 SELinux. =D0=95=D1=81=D0=BB=D0=B8 =D1=83=D1=81=D1=82=D0=B0=D0=BD=
=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE "direct", =D0=B1=D0=B8=D0=B1=D0=BB=D0=
=B8=D0=BE=D1=82=D0=B5=D0=BA=D0=B0 =D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D1=8F SELinux =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D0=
=B5=D1=82 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D1=8C =D0=BD=D0=B0=D0=BF=D1=80=D1=
=8F=D0=BC=D1=83=D1=8E =D0=B2 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=
=89=D0=B5 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=
=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux (=D1=8D=D1=82=D0=BE =D0=B7=D0=BD=D0=B0=
=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=
=D0=B0=D0=BD=D0=B8=D1=8E).
>  =D0=92 =D0=B8=D0=BD=D0=BE=D0=BC =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5 =D0=
=B2 =D0=BA=D0=B0=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=B5 =D0=B0=D1=80=D0=B3=D1=
=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B8=D1=
=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=D1=81=D1=8F=
 =D0=BF=D1=83=D1=82=D1=8C =D0=BA =D1=81=D0=BE=D0=BA=D0=B5=D1=82=D1=83 =D0=
=B8=D0=BB=D0=B8 =D0=B8=D0=BC=D1=8F =D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=D0=
=B0.
>  =D0=95=D1=81=D0=BB=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=
=82 =D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D0=B5=D1=82=D1=81=D1=8F =D1=81 "/"=
 (=D0=BA=D0=B0=D0=BA =D0=B2 "/foo/bar"), =D0=BE=D0=BD =D0=BF=D1=80=D0=B5=D0=
=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D1=8F=D0=B5=D1=82 =D1=81=D0=BE=D0=B1=D0=
=BE=D0=B9 =D0=BF=D1=83=D1=82=D1=8C =D0=BA =D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D0=BA=D0=B5=D1=82=D1=
=83, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=
=83=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C =D0=B4=D0=BB=D1=8F =D0=BF=D0=BE=D0=B4=D0=BA=D0=BB=D1=8E=D1=
=87=D0=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=D0=B0 =D1=
=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=BE=D0=B9.
> -=D0=95=D1=81=D0=BB=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=
=82 =D0=BD=D0=B5 =D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F =D1=81 "/" (=D0=BA=D0=B0=D0=BA =D0=B2 "foo.com:4242"), =D0=BE=D0=BD =D0=
=B4=D0=BE=D0=BB=D0=B6=D0=B5=D0=BD =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BF=D1=
=80=D0=B5=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=D1=81=D1=8F =D0=
=BA=D0=B0=D0=BA =D0=B8=D0=BC=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D1=91=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=D0=B0 =D1=83=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=BE=D0=BB=D0=
=B8=D1=82=D0=B8=D0=BA=D0=BE=D0=B9, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=
=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=D0=
=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=87=D0=B5=D1=80=D0=B5=D0=
=B7 TCP-=D0=BF=D0=BE=D0=B4=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =
(=D0=BF=D0=BE=D1=80=D1=82 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=
=D0=BD=D0=B8=D1=8E 4242, =D0=B5=D1=81=D0=BB=D0=B8 =D1=82=D0=BE=D0=BB=D1=8C=
=D0=BA=D0=BE =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D0=B8=D0=BC=D0=B5=D0=BD=D0=B8 =
=D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=D0=B0 =D1=87=D0=B5=D1=80=D0=B5=D0=B7 =
=D0=B4=D0=B2=D0=BE=D0=B5=D1=82=D0=BE=D1=87=D0=B8=D0=B5, =D1=80=D0=B0=D0=B7=
=D0=B4=D0=B5=D0=BB=D1=8F=D1=8E=D1=89=D0=B5=D0=B5 =D0=B4=D0=B2=D0=B0 =D0=BF=
=D0=BE=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D0=
=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D0=BE=D1=80=D1=82).
> +=D0=95=D1=81=D0=BB=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=
=82 =D0=BD=D0=B5 =D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F =D1=81 "/" (=D0=BA=D0=B0=D0=BA =D0=B2 "example.com:4242"), =D0=BE=D0=BD=
 =D0=B4=D0=BE=D0=BB=D0=B6=D0=B5=D0=BD =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BF=
=D1=80=D0=B5=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=D1=81=D1=8F =
=D0=BA=D0=B0=D0=BA =D0=B8=D0=BC=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D1=91=D0=BD=
=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=D0=B0 =D1=83=
=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=BE=D0=BB=
=D0=B8=D1=82=D0=B8=D0=BA=D0=BE=D0=B9, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=
=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=
=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=87=D0=B5=D1=80=D0=B5=
=D0=B7 TCP-=D0=BF=D0=BE=D0=B4=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8=D0=
=B5 (=D0=BF=D0=BE=D1=80=D1=82 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=
=D0=B0=D0=BD=D0=B8=D1=8E 4242, =D0=B5=D1=81=D0=BB=D0=B8 =D1=82=D0=BE=D0=BB=
=D1=8C=D0=BA=D0=BE =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D0=B8=D0=BC=D0=B5=D0=BD=
=D0=B8 =D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=D0=B0 =D1=87=D0=B5=D1=80=D0=B5=
=D0=B7 =D0=B4=D0=B2=D0=BE=D0=B5=D1=82=D0=BE=D1=87=D0=B8=D0=B5, =D1=80=D0=B0=
=D0=B7=D0=B4=D0=B5=D0=BB=D1=8F=D1=8E=D1=89=D0=B5=D0=B5 =D0=B4=D0=B2=D0=B0 =
=D0=BF=D0=BE=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=
 =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D0=BE=D1=80=D1=82).
>=20=20
>  .TP
>  .B root
> diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.conf
> index dc8d46b8..98d769b5 100644
> --- a/libsemanage/src/semanage.conf
> +++ b/libsemanage/src/semanage.conf
> @@ -24,8 +24,9 @@
>  #  /foo/bar     - Write by way of a policy management server, whose
>  #                 named socket is at /foo/bar.  The path must begin
>  #                 with a '/'.
> -#  foo.com:4242 - Establish a TCP connection to a remote policy
> -#                 management server at foo.com.  If there is a colon
> +#  example.com:4242
> +#               - Establish a TCP connection to a remote policy
> +#                 management server at example.com.  If there is a colon
>  #                 then the remainder is interpreted as a port number;
>  #                 otherwise default to port 4242.
>  module-store =3D direct
> --=20
> 2.33.1

