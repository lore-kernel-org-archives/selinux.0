Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDC3C433F5
	for <selinux@archiver.kernel.org>; Mon, 29 Nov 2021 17:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhK2R6G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344823AbhK2R4G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Nov 2021 12:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638208367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iztcpvplnrDaBKLEZIqQcyO/MCL6+ZJJGWylw1rVRDs=;
        b=e30CBy+m6vx3i6HfbL2Toe2augxZynp7or4VUO6EOZUT7TaC9r7dlfqrshTM2cb7kotgto
        JvAgsZNE92uafam9s5RzO0alknPgUivESnyBxQkphb29Fur857gcwy8EiRx3ILtHjFI802
        WdJmZcnSMIRpsR7rZiCobZhyWzkI9Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-RWgzevxmPQy95MnBqOiJYQ-1; Mon, 29 Nov 2021 12:52:43 -0500
X-MC-Unique: RWgzevxmPQy95MnBqOiJYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDBC64098;
        Mon, 29 Nov 2021 17:52:42 +0000 (UTC)
Received: from localhost (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 790432B178;
        Mon, 29 Nov 2021 17:52:42 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Jacob M Cutright <cutrightjm@stl.sh>, selinux@vger.kernel.org
Subject: Re: [PATCH] Modified Russian and English man pages to fix typo;
 REQUIREUSERS -> REQUIRESEUSERS
In-Reply-To: <87a6htlwls.fsf@redhat.com>
References: <20211124024029.11520-1-cutrightjm@stl.sh>
 <87a6htlwls.fsf@redhat.com>
Date:   Mon, 29 Nov 2021 18:52:41 +0100
Message-ID: <875ysa3l3q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Jacob M Cutright <cutrightjm@stl.sh> writes:
>
>> From: Cutright Jacob <cutrightjm@stl.sh>
>>
>> Signed-off-by: Jacob M Cutright <cutrightjm@stl.sh>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks!

Merged.

>
>> ---
>>  policycoreutils/man/man5/selinux_config.5    | 2 +-
>>  policycoreutils/man/ru/man5/selinux_config.5 | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils=
/man/man5/selinux_config.5
>> index 58b42a0e..f391befb 100644
>> --- a/policycoreutils/man/man5/selinux_config.5
>> +++ b/policycoreutils/man/man5/selinux_config.5
>> @@ -32,7 +32,7 @@ The \fIconfig\fR file supports the following parameter=
s:
>>  .br
>>  \fBSELINUXTYPE =3D \fIpolicy_name\fR
>>  .br
>> -\fBREQUIREUSERS =3D \fI0\fR | \fI1\fR
>> +\fBREQUIRESEUSERS =3D \fI0\fR | \fI1\fR
>>  .br
>>  \fBAUTORELABEL =3D \fI0\fR | \fI1\fR
>>  .RE
>> diff --git a/policycoreutils/man/ru/man5/selinux_config.5 b/policycoreut=
ils/man/ru/man5/selinux_config.5
>> index 40039e57..8c0db9ae 100644
>> --- a/policycoreutils/man/ru/man5/selinux_config.5
>> +++ b/policycoreutils/man/ru/man5/selinux_config.5
>> @@ -34,7 +34,7 @@ config \- =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BF=D0=BE=D0=B4=
=D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D1=8B SELinux.
>>  .br
>>  \fBSELINUXTYPE =3D \fIpolicy_name\fR
>>  .br
>> -\fBREQUIREUSERS =3D \fI0\fR | \fI1\fR
>> +\fBREQUIRESEUSERS =3D \fI0\fR | \fI1\fR
>>  .br
>>  \fBAUTORELABEL =3D \fI0\fR | \fI1\fR
>>  .RE
>> --=20
>> 2.27.0

