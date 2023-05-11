Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4E8C77B7F
	for <selinux@archiver.kernel.org>; Thu, 11 May 2023 07:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjEKH0C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 May 2023 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjEKHZs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 May 2023 03:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA66A45
        for <selinux@vger.kernel.org>; Thu, 11 May 2023 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683789893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6wTSkmQ2vJAW+uYUcRsLgIHr2Ir0S34FVAogzJNz2o=;
        b=Mldx9aaQTGX7Ui0m39akQYEzP2r2ualdRyH31kRVRo9bWKzJUihiDowfywidgkgf9Hf1fI
        ZgeHciplI8I+4KDaneujdW2jUmCQvgCOcjGfR8x/YWE0qdxEfHmcEss/rgLuCHQMGewXmZ
        xv+xfebe2Cj6LQuBtLv3xcPLbd7dgic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-yXLWom2pPR-g04XAYsSMAA-1; Thu, 11 May 2023 03:24:49 -0400
X-MC-Unique: yXLWom2pPR-g04XAYsSMAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81A2810146EA;
        Thu, 11 May 2023 07:24:49 +0000 (UTC)
Received: from localhost (unknown [10.45.224.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD5440104E;
        Thu, 11 May 2023 07:24:49 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>,
        Vit Mojzis <vmojzis@redhat.com>
Subject: Re: [PATCH v2 1/4] python/chcat: Improve man pages
In-Reply-To: <CAP+JOzQR=8PSe8AXDvBWoA4LXHCbO_eHJJGuSduH4g-uPHqnRA@mail.gmail.com>
References: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
 <20230504120450.771407-1-vmojzis@redhat.com>
 <20230504120450.771407-2-vmojzis@redhat.com>
 <CAP+JOzQR=8PSe8AXDvBWoA4LXHCbO_eHJJGuSduH4g-uPHqnRA@mail.gmail.com>
Date:   Thu, 11 May 2023 09:24:48 +0200
Message-ID: <87fs8372kf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, May 4, 2023 at 8:06=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>>
>> - Explain applying range/list of categories
>> - "-d" removes all categories of given file/user
>> - Add examples
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> For all four of these patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!


>> ---
>>  python/chcat/chcat.8 | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/python/chcat/chcat.8 b/python/chcat/chcat.8
>> index d095a255..3e1f7ca2 100644
>> --- a/python/chcat/chcat.8
>> +++ b/python/chcat/chcat.8
>> @@ -1,6 +1,6 @@
>>  .TH CHCAT "8" "September 2005" "chcat" "User Commands"
>>  .SH NAME
>> -chcat \- change file SELinux security category
>> +chcat \- change SELinux security categories of files/users
>>  .SH SYNOPSIS
>>  .B chcat
>>  \fIcategory file\fR...
>> @@ -25,23 +25,33 @@ chcat \- change file SELinux security category
>>  .br
>>  .SH DESCRIPTION
>>  .PP
>> -Change/Remove the security \fIcategory\fR for each \fIfile\fR or \fIuse=
r\fR.
>> -.PP
>> -Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR.
>> +Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR (only =
a single category can be specified at a time). Or specify the desired list/=
range of categories to be applied (replacing the existing categories).
>>  .PP
>>  .B
>>  Note:
>> -When removing a category you must specify '\-\-' on the command line be=
fore using the \-Category syntax.  This tells the command that you have fin=
ished entering options and are now specifying a category name instead.
>> +When removing a category you must specify '\-\-' on the command line be=
fore using the \-Category syntax. This tells the command that you have fini=
shed entering options and are now specifying a category name instead.
>>
>>  .TP
>>  \fB\-d\fR
>> -delete the category from each FILE/USER.
>> +delete all categories from given FILE/USER.
>>  .TP
>>  \fB\-L\fR
>>  list available categories.
>>  .TP
>>  \fB\-l\fR
>>  Tells chcat to operate on users instead of files.
>> +
>> +.SH EXAMPLE
>> +.nf
>> +Replace categories of user "test" with c0.c6
>> +# chcat -l c0.c6 test
>> +Add category c1023 to user "test"
>> +# chcat -l +c1023 test
>> +Remove category c5 from file "file"
>> +# chcat -- -c5 file
>> +Remove all categories from file "file"
>> +# chcat -d file
>> +
>>  .SH "SEE ALSO"
>>  .TP
>>  chcon(1), selinux(8), semanage(8)
>> @@ -52,4 +62,3 @@ When operating on files this script wraps the chcon co=
mmand.
>>  /etc/selinux/{SELINUXTYPE}/setrans.conf
>>  .br
>>  /etc/selinux/{SELINUXTYPE}/seusers
>> -
>> --
>> 2.40.0
>>

