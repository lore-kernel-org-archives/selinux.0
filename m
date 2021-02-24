Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01EC433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 11:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984DD60C41
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBXLAC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233841AbhBXK77 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 05:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614164313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UEKf8UrzfmAeMgxdrnYOBxByYrUc/AZTQGg7sndKVC8=;
        b=aauzGA9G2nesHvfClcgV2iiRnTHjbQxI+uXmY2AiW1zJ3IxFOpEReBU0XdxVgRo2wRNfPL
        UPdsZX57qER5w8IsWn2YLqUmHEgm+Kabk7RiDKX1Myy1iMh1S3a4IpHNWYr2RvYn7ek9Qw
        pHZ8flvLLRnxDm7ynwe3HI/WfEJfm6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-FpHfUFPZOzSiOhiN-glZzg-1; Wed, 24 Feb 2021 05:58:31 -0500
X-MC-Unique: FpHfUFPZOzSiOhiN-glZzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D60BE107ACE8;
        Wed, 24 Feb 2021 10:58:30 +0000 (UTC)
Received: from localhost (unknown [10.40.193.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BF562462;
        Wed, 24 Feb 2021 10:58:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/2] libselinux: fix segfault in add_xattr_entry()
In-Reply-To: <CAJfZ7=nDggfdRVxZT=aWJbr8gKS6r2ZctGHdbsd_P7y3u9KmpA@mail.gmail.com>
References: <20210216141446.171306-1-plautrba@redhat.com>
 <CAJfZ7=nDggfdRVxZT=aWJbr8gKS6r2ZctGHdbsd_P7y3u9KmpA@mail.gmail.com>
Date:   Wed, 24 Feb 2021 11:58:28 +0100
Message-ID: <877dmx3f6z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Tue, Feb 16, 2021 at 3:16 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> When selabel_get_digests_all_partial_matches(), resp
>> get_digests_all_partial_matches() doesn't find a match,
>> calculated_digest is not initialized and followup memcmp() could
>> segfault. Given that calculated_digest and xattr_digest are already
>> compared in get_digests_all_partial_matches() and the function returns
>> true or false based on this comparison, it's not neccessary to compare
>
> (minor typo: necessary with only one C)
>
>> these values again.
>>
>> Fixes:
>>     # restorecon_xattr -d -v tmp
>>     specfiles SHA1 digest: afc752f47d489f3e82ac1da8fd247a2e1a6af5f8
>>     calculated using the following specfile(s):
>>     /etc/selinux/targeted/contexts/files/file_contexts.subs_dist
>>     /etc/selinux/targeted/contexts/files/file_contexts.subs
>>     /etc/selinux/targeted/contexts/files/file_contexts.bin
>>     /etc/selinux/targeted/contexts/files/file_contexts.homedirs.bin
>>     /etc/selinux/targeted/contexts/files/file_contexts.local.bin
>>
>>     Segmentation fault (core dumped)
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks! I wanted to reproduce the issue on an Arch Linux test VM and
> it was slightly more complex. Here is what I did:
>
> cd /root
> mkdir tmp
> restorecon -D -Rv tmp  # create security.sehash attribute
> restorecon_xattr -d -v tmp # this segfaults in the memcmp()
>
> Both your patches look good. Nevertheless there is some
> inconsistencies in the "coding style" used in your patches:
>
>> ---
>>  libselinux/src/selinux_restorecon.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
>> index 6993be6fda17..4bca29b9de78 100644
>> --- a/libselinux/src/selinux_restorecon.c
>> +++ b/libselinux/src/selinux_restorecon.c
>> @@ -297,6 +297,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>>         char *sha1_buf = NULL;
>>         size_t i, digest_len = 0;
>>         int rc, digest_result;
>> +       bool match;
>>         struct dir_xattr *new_entry;
>>         uint8_t *xattr_digest = NULL;
>>         uint8_t *calculated_digest = NULL;
>> @@ -306,7 +307,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>>                 return -1;
>>         }
>>
>> -       selabel_get_digests_all_partial_matches(fc_sehandle, directory,
>> +       match = selabel_get_digests_all_partial_matches(fc_sehandle, directory,
>>                                                 &calculated_digest,
>>                                                 &xattr_digest, &digest_len);
>
> Here: the parameters need to be indented with the new indentation.
>
>>
>> @@ -326,11 +327,10 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>>         for (i = 0; i < digest_len; i++)
>>                 sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
>>
>> -       rc = memcmp(calculated_digest, xattr_digest, digest_len);
>> -       digest_result = rc ? NOMATCH : MATCH;
>> +       digest_result = match ? MATCH : NOMATCH;
>>
>> -       if ((delete_nonmatch && rc != 0) || delete_all) {
>> -               digest_result = rc ? DELETED_NOMATCH : DELETED_MATCH;
>> +       if ((delete_nonmatch && ! match) || delete_all) {
>
> Here: the space between "!" and "match" is unexpected.
>
>> +               digest_result = match ? DELETED_MATCH : DELETED_NOMATCH;
>>                 rc = removexattr(directory, RESTORECON_PARTIAL_MATCH_DIGEST);
>>                 if (rc) {
>>                         selinux_log(SELINUX_ERROR,
>> --
>> 2.30.1
>
> ... and in the second patch, the indentation of the parameters of the
> new fprintf(stderr,...) does not match the one used in other places of
> the file.
>
> Anyway these are minor issues, and ignoring them, for both patches:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged with suggested improvements. Thanks!

