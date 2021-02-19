Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEBCC433DB
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C974C64D9C
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 15:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBSPRQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhBSPRP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 10:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613747748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AL5G/jalNAJuBgGRBpcnmYM5whbzXGLBiBDAyXaJLKU=;
        b=WgWHxf37/8Z1xqQP42jSwxVnzKtAfBuhbOlQ7CmOsShu3XexoZy73GnciOrTfUzkEBVlcl
        cF16BiLHm805sBsquB1y3N5ogb2D3ujsrXqW/TNSi8kAv3QQN+6rdCtxgtOlJw5et7/tvP
        zwaMNDAck+hdXoNdyzFESSUsnf1J5rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-SENNOk6gOJ-9r7mYlWpI9g-1; Fri, 19 Feb 2021 10:15:46 -0500
X-MC-Unique: SENNOk6gOJ-9r7mYlWpI9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67AE880198C;
        Fri, 19 Feb 2021 15:15:45 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0F2E60BE5;
        Fri, 19 Feb 2021 15:15:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] policycoreutils/fixfiles.8: add missing file
 systems and merge check and verify
In-Reply-To: <87wnv6fwf2.fsf@redhat.com>
References: <20210203171654.37002-1-cgzones@googlemail.com>
 <20210203171654.37002-2-cgzones@googlemail.com>
 <87wnv6fwf2.fsf@redhat.com>
Date:   Fri, 19 Feb 2021 16:15:43 +0100
Message-ID: <87lfbkozq8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> Mention the supported file systems ext4, gfs2 and btrfs.
>>
>> The options check and verify are interchangeable, merge their
>> description.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged, thanks!


>> ---
>>  policycoreutils/scripts/fixfiles.8 | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/script=
s/fixfiles.8
>> index 12342530..c4e894e5 100644
>> --- a/policycoreutils/scripts/fixfiles.8
>> +++ b/policycoreutils/scripts/fixfiles.8
>> @@ -35,8 +35,8 @@ database (extended attributes) on filesystems.
>>  .P
>>  It can also be run at any time to relabel when adding support for
>>  new policy, or  just check whether the file contexts are all
>> -as you expect.  By default it will relabel all mounted ext2, ext3, xfs =
and=20
>> -jfs file systems as long as they do not have a security context mount=20
>> +as you expect.  By default it will relabel all mounted ext2, ext3, ext4=
, gfs2, xfs,
>> +jfs and btrfs file systems as long as they do not have a security conte=
xt mount
>>  option.  You can use the \-R flag to use rpmpackages as an alternative.
>>  The file /etc/selinux/fixfiles_exclude_dirs can contain a list of direc=
tories
>>  excluded from relabeling.
>> @@ -79,7 +79,7 @@ Modify verbosity from progress to verbose. (Run restor=
econ with \-v instead of \
>>  .SH "ARGUMENTS"
>>  One of:
>>  .TP=20
>> -.B check
>> +.B check | verify
>>  print any incorrect file context labels, showing old and new context, b=
ut do not change them.
>>  .TP=20
>>  .B restore
>> @@ -88,9 +88,6 @@ change any incorrect file context labels.
>>  .B relabel
>>  Prompt for removal of contents of /tmp directory and then change any in=
correct file context labels to match the install file_contexts file.
>>  .TP=20
>> -.B verify
>> -List out files with incorrect file context labels, but do not change th=
em.
>> -.TP=20
>>  .B [[dir/file] ... ]=20
>>  List of files or directories trees that you wish to check file context =
on.
>>=20=20
>> --=20
>> 2.30.0

