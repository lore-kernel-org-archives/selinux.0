Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446C0C433FE
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233D561BE6
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhKOJ6h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:58:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230405AbhKOJ6L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 04:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636970116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1I9GgUzetQQheAnUhXE/nnpCn3z7bSeZFRmUEJlZQM=;
        b=Ut6twjdva73CkzHJx92iIm5hZfp/c3zAjtz9rPgsrAj3ccMkc2ZYPYgqoYleV+0XYdCCk3
        96J8xVa0KNNWhV8xDZxfUjRMjf8AJFEZGcYHqlKX2o2qrWqBmXfxWH21q9p+Qj0zgjoaxl
        oNxmZIHS6od7B8rlDZIND+GZGWGHZDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-6IQKUluXMca7iFT6vhQmCw-1; Mon, 15 Nov 2021 04:55:12 -0500
X-MC-Unique: 6IQKUluXMca7iFT6vhQmCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D37711023F5C;
        Mon, 15 Nov 2021 09:55:11 +0000 (UTC)
Received: from localhost (unknown [10.40.193.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6783960657;
        Mon, 15 Nov 2021 09:55:11 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     markus.linnala@gmail.com, selinux@vger.kernel.org
Subject: Re: [PATCH] Use IANA-managed domain example.com in examples
In-Reply-To: <87lf1ux007.fsf@redhat.com>
References: <20211109153956.472188-1-markus.linnala@gmail.com>
 <87lf1ux007.fsf@redhat.com>
Date:   Mon, 15 Nov 2021 10:55:10 +0100
Message-ID: <87czn1lp4x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> markus.linnala@gmail.com writes:
>
>> From: Markus Linnala <Markus.Linnala@knowit.fi>
>>
>> See: RFC 2606
>>
>> foo.com seems to be privately owned.
>>
>> Signed-off-by: Markus Linnala <Markus.Linnala@knowit.fi>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

This is merged now. Thanks!



>> ---
>>  libsemanage/man/man5/semanage.conf.5    | 2 +-
>>  libsemanage/man/ru/man5/semanage.conf.5 | 2 +-
>>  libsemanage/src/semanage.conf           | 5 +++--
>>  3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5=
/semanage.conf.5
>> index 7d6f2fef..380b58be 100644
>> --- a/libsemanage/man/man5/semanage.conf.5
>> +++ b/libsemanage/man/man5/semanage.conf.5
>> @@ -23,7 +23,7 @@ Management library writes to the SELinux policy module=
 store directly (this is t
>>  Otherwise a socket path or a server name can be used for the argument.
>>  If the argument begins with "/" (as in "/foo/bar"), it represents the p=
ath to a named socket that should be used to connect the policy management
>>  server.
>> -If the argument does not begin with a "/" (as in "foo.com:4242"), it sh=
ould be interpreted as the name of a remote policy management server
>> +If the argument does not begin with a "/" (as in "example.com:4242"), i=
t should be interpreted as the name of a remote policy management server
>>  to be used through a TCP connection (default port is 4242 unless a diff=
erent one is specified after the server name using the colon to separate
>>  the two fields).
>>=20=20
>> diff --git a/libsemanage/man/ru/man5/semanage.conf.5 b/libsemanage/man/r=
u/man5/semanage.conf.5
>> index cf65b3e6..548aa58d 100644
>> --- a/libsemanage/man/ru/man5/semanage.conf.5
>> +++ b/libsemanage/man/ru/man5/semanage.conf.5
>> @@ -19,7 +19,7 @@ semanage.conf \- =D0=B3=D0=BB=D0=BE=D0=B1=D0=B0=D0=BB=
=D1=8C=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=84=
=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=B4=D0=BB=D1=8F=20
>>  =D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C, =D0=BA=D0=B0=D0=BA =D0=B1=
=D0=B8=D0=B1=D0=BB=D0=B8=D0=BE=D1=82=D0=B5=D0=BA=D0=B0 =D1=83=D0=BF=D1=80=
=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F SELinux =D0=B4=D0=BE=D0=BB=D0=B6=
=D0=BD=D0=B0 =D0=B2=D0=B7=D0=B0=D0=B8=D0=BC=D0=BE=D0=B4=D0=B5=D0=B9=D1=81=
=D1=82=D0=B2=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 =D1=85=D1=80=D0=B0=D0=BD=
=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D0=BC =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=
=D0=BA=D0=B8 SELinux. =D0=95=D1=81=D0=BB=D0=B8 =D1=83=D1=81=D1=82=D0=B0=D0=
=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE "direct", =D0=B1=D0=B8=D0=B1=D0=BB=
=D0=B8=D0=BE=D1=82=D0=B5=D0=BA=D0=B0 =D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=
=D0=B5=D0=BD=D0=B8=D1=8F SELinux =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=
=D0=B5=D1=82 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D1=8C =D0=BD=D0=B0=D0=BF=D1=80=
=D1=8F=D0=BC=D1=83=D1=8E =D0=B2 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=
=D1=89=D0=B5 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=
=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux (=D1=8D=D1=82=D0=BE =D0=B7=D0=BD=D0=
=B0=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=
=87=D0=B0=D0=BD=D0=B8=D1=8E).
>>  =D0=92 =D0=B8=D0=BD=D0=BE=D0=BC =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5 =
=D0=B2 =D0=BA=D0=B0=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=B5 =D0=B0=D1=80=D0=B3=
=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B8=
=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=D1=81=D1=
=8F =D0=BF=D1=83=D1=82=D1=8C =D0=BA =D1=81=D0=BE=D0=BA=D0=B5=D1=82=D1=83 =
=D0=B8=D0=BB=D0=B8 =D0=B8=D0=BC=D1=8F =D1=81=D0=B5=D1=80=D0=B2=D0=B5=D1=80=
=D0=B0.
>>  =D0=95=D1=81=D0=BB=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=
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
>> -=D0=95=D1=81=D0=BB=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=
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
>> +=D0=95=D1=81=D0=BB=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=
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
>>=20=20
>>  .TP
>>  .B root
>> diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.co=
nf
>> index dc8d46b8..98d769b5 100644
>> --- a/libsemanage/src/semanage.conf
>> +++ b/libsemanage/src/semanage.conf
>> @@ -24,8 +24,9 @@
>>  #  /foo/bar     - Write by way of a policy management server, whose
>>  #                 named socket is at /foo/bar.  The path must begin
>>  #                 with a '/'.
>> -#  foo.com:4242 - Establish a TCP connection to a remote policy
>> -#                 management server at foo.com.  If there is a colon
>> +#  example.com:4242
>> +#               - Establish a TCP connection to a remote policy
>> +#                 management server at example.com.  If there is a colon
>>  #                 then the remainder is interpreted as a port number;
>>  #                 otherwise default to port 4242.
>>  module-store =3D direct
>> --=20
>> 2.33.1

