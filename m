Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B60DC47095
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 09:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAB161042
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 09:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhFIJ5O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238369AbhFIJ5N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 05:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623232519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLhUpYzpZoEymqjCzthHrHRnYIO08Bxa1TaINLNXoqg=;
        b=VcYmFzfGXDKWDv50xY6rmTxel/qYrsZqfewi3IeFldhqAE5gqLO3YiE0tM1u1ir9gYRCUo
        eCPo98PyV6W1DCSbTlukRXcCKiRskXUUTGehefQ5mc4nxQK1jXATYC7Oz3S0/vzoVKj7Y+
        gfRt8H8jlUuu3+xiGknAjUZLuKXPQYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-4xSGkjV-MBOv5G8np2rTbw-1; Wed, 09 Jun 2021 05:33:44 -0400
X-MC-Unique: 4xSGkjV-MBOv5G8np2rTbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42BBDA40C3;
        Wed,  9 Jun 2021 09:33:43 +0000 (UTC)
Received: from localhost (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAA185D9C6;
        Wed,  9 Jun 2021 09:33:42 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: improve getcon(3) man page
In-Reply-To: <87o8cnp3mr.fsf@redhat.com>
References: <20210601153509.12594-1-cgzones@googlemail.com>
 <87o8cnp3mr.fsf@redhat.com>
Date:   Wed, 09 Jun 2021 11:33:41 +0200
Message-ID: <87zgvzo00a.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> Improve formatting of section DESCRIPTION by adding list points.
>
> I checked several man pages and it doesn't look like a common construct
> multi function man pages. But I haven't found any specific guideline
> related to this and it looks better.
>
>
>> Mention errno is set on failure.
>> Mention the returned context might be NULL if SELinux is not enabled.
>> Align setcon/_raw parameter by adding const.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged.


> Thanks!
>
>
>> ---
>>  libselinux/man/man3/getcon.3 | 41 +++++++++++++++++++++++++-----------
>>  1 file changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
>> index 67872a4d..e7e394f3 100644
>> --- a/libselinux/man/man3/getcon.3
>> +++ b/libselinux/man/man3/getcon.3
>> @@ -7,7 +7,7 @@ freecon, freeconary \- free memory associated with SELin=
ux security contexts
>>  getpeercon \- get security context of a peer socket
>>=20=20
>>  setcon \- set current security context of a process
>> -.
>> +
>>  .SH "SYNOPSIS"
>>  .B #include <selinux/selinux.h>
>>  .sp
>> @@ -31,30 +31,39 @@ setcon \- set current security context of a process
>>  .sp
>>  .BI "void freeconary(char **" con );
>>  .sp
>> -.BI "int setcon(char *" context );
>> +.BI "int setcon(const char *" context );
>>  .sp
>> -.BI "int setcon_raw(char *" context );
>> -.
>> +.BI "int setcon_raw(const char *" context );
>> +
>>  .SH "DESCRIPTION"
>> +.TP
>>  .BR getcon ()
>>  retrieves the context of the current process, which must be free'd with
>> -freecon.
>> +.BR freecon ().
>>=20=20
>> +.TP
>>  .BR getprevcon ()
>>  same as getcon but gets the context before the last exec.
>>=20=20
>> +.TP
>>  .BR getpidcon ()
>> -returns the process context for the specified PID.
>> +returns the process context for the specified PID, which must be free'd=
 with
>> +.BR freecon ().
>>=20=20
>> +.TP
>>  .BR getpeercon ()
>> -retrieves context of peer socket, and set
>> -.BI * context
>> -to refer to it, which must be free'd with
>> +retrieves the context of the peer socket, which must be free'd with
>>  .BR freecon ().
>>=20=20
>> +.TP
>>  .BR freecon ()
>>  frees the memory allocated for a security context.
>>=20=20
>> +If
>> +.I con
>> +is NULL, no operation is performed.
>> +
>> +.TP
>>  .BR freeconary ()
>>  frees the memory allocated for a context array.
>>=20=20
>> @@ -62,6 +71,7 @@ If
>>  .I con
>>  is NULL, no operation is performed.
>>=20=20
>> +.TP
>>  .BR setcon ()
>>  sets the current security context of the process to a new value.  Note
>>  that use of this function requires that the entire application be
>> @@ -110,6 +120,8 @@ context and the
>>  .BR setcon ()
>>  will fail if it is not allowed by policy.
>>=20=20
>> +.TP
>> +.BR *_raw()
>>  .BR getcon_raw (),
>>  .BR getprevcon_raw (),
>>  .BR getpidcon_raw (),
>> @@ -118,9 +130,14 @@ and
>>  .BR setcon_raw ()
>>  behave identically to their non-raw counterparts but do not perform con=
text
>>  translation.
>> -.
>> +
>>  .SH "RETURN VALUE"
>> -On error \-1 is returned.  On success 0 is returned.
>> -.
>> +On error \-1 is returned with errno set.  On success 0 is returned.
>> +
>> +.SH "NOTES"
>> +The retrieval functions might return success and set
>> +.I *context
>> +to NULL if and only if SELinux is not enabled.
>> +
>>  .SH "SEE ALSO"
>>  .BR selinux "(8), " setexeccon "(3)"
>> --=20
>> 2.32.0.rc2

