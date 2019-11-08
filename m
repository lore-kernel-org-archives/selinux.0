Return-Path: <SRS0=6fGn=ZA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14040C5DF60
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E4E21D7E
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 08:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQrxAhXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKHIIR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:08:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40530 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbfKHIIR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Nov 2019 03:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573200496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l620f+4GOQzuB32nLR8km31rHvcU+qYRjwwCLUx0mqQ=;
        b=hQrxAhXxqdxBBmQLqts6s4RzyNw5CKFXWo0zqrFk09lmd2boK/y16rHEMSDIXyYs0JnyE3
        2ceUNtYvG0hC82zz07gbMHfTX3/lXnS/Tcxw2Ug8C4cpdSIozahOhtCSHxh3l5clPqHfcG
        vFGN2OkyejYCyYTl6OeQHxnvGGznQu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-Yt9zxkU8M3WogaL90g7nLQ-1; Fri, 08 Nov 2019 03:08:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1BF5800A1A;
        Fri,  8 Nov 2019 08:08:11 +0000 (UTC)
Received: from localhost (ovpn-204-203.brq.redhat.com [10.40.204.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D741B5DA7C;
        Fri,  8 Nov 2019 08:08:10 +0000 (UTC)
References: <20191106163043.1081424-1-plautrba@redhat.com> <b88fa654-dd3d-e9be-201c-718c31a74254@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Aleksei Nikiforov <darktemplar@basealt.ru>,
        Olesya Gerasimenko <gammaray@basealt.ru>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] Replace www.nsa.gov references by github.com/SELinuxProject
In-reply-to: <b88fa654-dd3d-e9be-201c-718c31a74254@tycho.nsa.gov>
Date:   Fri, 08 Nov 2019 09:08:09 +0100
Message-ID: <pjdsgmyeqom.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Yt9zxkU8M3WogaL90g7nLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 11/6/19 11:30 AM, Petr Lautrbach wrote:
>> The original page doesn't exist anymore.
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/170
>
> No objections although I can't verify the ru files myself aside from the =
URL
> matching.

Aleksei, Olesya, could you please review changes in ru file in this patch?=
=20
https://patchwork.kernel.org/patch/11230695/


> I suppose someone might object on the grounds that SELinux can be
> used with policies other than refpolicy, but the only other potential ref=
erences
> I can think of would be the SELinux Notebook or SELinux by Example.  Or w=
e could
> just drop the text and URLs altogether and only list other man pages unde=
r the
> SEE ALSO sections.


The most distributions use policies based on the reference policy and
those who use their own policy probably started with refpolicy as well.


>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   checkpolicy/checkmodule.8        | 3 +--
>>   checkpolicy/checkpolicy.8        | 3 +--
>>   checkpolicy/ru/checkmodule.8     | 3 +--
>>   checkpolicy/ru/checkpolicy.8     | 4 +---
>>   libselinux/man/man8/selinux.8    | 2 +-
>>   libselinux/man/ru/man8/selinux.8 | 2 +-
>>   python/sepolgen/HACKING          | 2 --
>>   7 files changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
>> index e55582f3..e597d9d4 100644
>> --- a/checkpolicy/checkmodule.8
>> +++ b/checkpolicy/checkmodule.8
>> @@ -59,8 +59,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
>>     .SH "SEE ALSO"
>>   .B semodule(8), semodule_package(8)
>> -SELinux documentation at http://www.nsa.gov/research/selinux,
>> -especially "Configuring the SELinux Policy".
>> +SELinux Reference Policy documentation at https://github.com/SELinuxPro=
ject/refpolicy/wiki
>>       .SH AUTHOR
>> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
>> index bdfd6acd..97e10ca7 100644
>> --- a/checkpolicy/checkpolicy.8
>> +++ b/checkpolicy/checkpolicy.8
>> @@ -60,8 +60,7 @@ Show version information.
>>   Show usage information.
>>     .SH "SEE ALSO"
>> -SELinux documentation at http://www.nsa.gov/research/selinux,
>> -especially "Configuring the SELinux Policy".
>> +SELinux Reference Policy documentation at https://github.com/SELinuxPro=
ject/refpolicy/wiki
>>       .SH AUTHOR
>> diff --git a/checkpolicy/ru/checkmodule.8 b/checkpolicy/ru/checkmodule.8
>> index 93e68e70..a1d687e3 100644
>> --- a/checkpolicy/ru/checkmodule.8
>> +++ b/checkpolicy/ru/checkmodule.8
>> @@ -46,8 +46,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
>>     .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95"
>>   .B semodule(8), semodule_package(8)
>> -=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=
=8F SELinux =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 http://www.ns=
a.gov/research/selinux,
>> -=D0=B2 =D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=BE=D1=81=D1=82=D0=B8 - "=D0=9D=
=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=
=D1=82=D0=B8=D0=BA=D0=B8 SELinux".
>> +=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=
=8F SELinux Reference Policy =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=
=83 https://github.com/SELinuxProject/refpolicy/wiki
>>       .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
>> diff --git a/checkpolicy/ru/checkpolicy.8 b/checkpolicy/ru/checkpolicy.8
>> index 2ad39b8e..25b0e555 100644
>> --- a/checkpolicy/ru/checkpolicy.8
>> +++ b/checkpolicy/ru/checkpolicy.8
>> @@ -51,9 +51,7 @@ checkpolicy \- =D0=BA=D0=BE=D0=BC=D0=BF=D0=B8=D0=BB=D1=
=8F=D1=82=D0=BE=D1=80 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELi=
nux
>>   =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=81=D0=B2=D0=B5=D0=
=B4=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D0=B1 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B8.
>>     .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95"
>> -=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=
=8F SELinux =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 http://www.ns=
a.gov/research/selinux,
>> -=D0=B2 =D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=BE=D1=81=D1=82=D0=B8 - "=D0=9D=
=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=
=D1=82=D0=B8=D0=BA=D0=B8 SELinux".
>> -
>> +=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=
=8F SELinux Reference Policy =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=
=83 https://github.com/SELinuxProject/refpolicy/wiki
>>     .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
>>   =D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Arpad M=
agosanyi <mag@bunuel.tii.matav.hu>,
>> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux=
.8
>> index e37aee68..31364271 100644
>> --- a/libselinux/man/man8/selinux.8
>> +++ b/libselinux/man/man8/selinux.8
>> @@ -10,7 +10,7 @@ enforcement of many kinds of mandatory access control =
policies,
>>   including those based on the concepts of Type Enforcement=C2=AE, Role-
>>   Based Access Control, and Multi-Level Security.  Background
>>   information and technical documentation about SELinux can be found at
>> -http://www.nsa.gov/research/selinux.
>> +https://github.com/SELinuxProject.
>>     The
>>   .I /etc/selinux/config
>> diff --git a/libselinux/man/ru/man8/selinux.8 b/libselinux/man/ru/man8/s=
elinux.8
>> index 5cc48df8..271809de 100644
>> --- a/libselinux/man/ru/man8/selinux.8
>> +++ b/libselinux/man/ru/man8/selinux.8
>> @@ -9,7 +9,7 @@ Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=
=D0=BD=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=
=D1=81=D1=82=D1=8C=D1=8E =D0=BE=D1=82 NSA - =D1=8D=D1=82=D0=BE =D1=80=D0=B5
>>   =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B0=D1=8F =D0=BE=D1=81=D0=BD=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=86=D0=
=B5=D0=BF=D1=86=D0=B8=D1=8F=D1=85 Type Enforcement=C2=AE (=D0=BF=D1=80=D0=
=B8=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=
=BF=D1=80=D0=B8=D1=81=D0=B2=D0=BE=D0=B5=D0=BD=D0=B8=D0=B5 =D1=82=D0=B8=D0=
=BF=D0=BE=D0=B2),
>>   Role-Based Access Control (=D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=
=D0=BD=D0=B8=D0=B5 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BE=D0=BC =D0=BD=
=D0=B0 =D0=BE=D1=81=D0=BD=D0=BE=D0=B2=D0=B5 =D1=80=D0=BE=D0=BB=D0=B5=D0=B9)=
 =D0=B8 Multi-Level Security
>>   (=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=D1=83=D1=80=D0=BE=D0=B2=D0=BD=D0=B5=D0=
=B2=D0=B0=D1=8F =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=
=81=D1=82=D1=8C). =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=86=D0=B8=D1=8F =D0=B8 =D1=82=D0=B5=D1=85=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D0=
=BA=D0=B0=D1=8F =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BF=D0=BE
>> -SELinux =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D0=B0 =D0=BF=D0=BE =
=D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 http://www.nsa.gov/research/selinux.
>> +SELinux =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D0=B0 =D0=BF=D0=BE =
=D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 https://github.com/SELinuxProject.
>>     =D0=A4=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=
=D1=80=D0=B0=D1=86=D0=B8=D0=B8
>>   .I /etc/selinux/config
>> diff --git a/python/sepolgen/HACKING b/python/sepolgen/HACKING
>> index e624a1b4..f7d07774 100644
>> --- a/python/sepolgen/HACKING
>> +++ b/python/sepolgen/HACKING
>> @@ -75,5 +75,3 @@ Information about the SELinux object classes. This is =
semantic
>>   information about the object classes - including information flow. It
>>   is separated to keep the core from being concerned about the details
>>   of the object classes.
>> -
>> -[selist]: http://www.nsa.gov/research/selinux/info/list.cfm
>>


--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

