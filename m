Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B295EC433B4
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B48C611C9
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELIJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 04:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhELIJS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 04:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620806890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXwn7uORAQmFTZ0Tdh10CZ+lzZb73UyXLKPbd90x7fM=;
        b=cc0WHZCyObE16VCxOSipmzZE1i0K3AYhQwaoSkl5GqLcmYgV3a+NP5ijmZP0IzGHthu/DX
        IIFrMNuoOpII1uGzvQvKSK4MZjfACMHnH/lPli8FYWpcM1gMyfcbMKPJRlvZ9kgWcbCdq7
        cdKXBjPVUg80xvOqxW0KBd72aNsom50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-frP8tBNIOYioQplgxLroXw-1; Wed, 12 May 2021 04:08:08 -0400
X-MC-Unique: frP8tBNIOYioQplgxLroXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D17FD6D24A
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 08:08:07 +0000 (UTC)
Received: from localhost (unknown [10.40.194.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ACED2CE01;
        Wed, 12 May 2021 08:08:06 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Zdenek Pytela <zpytela@redhat.com>
Subject: Re: [PATCH userspace] fixfiles: do not exclude /dev and /run in -C
 mode
In-Reply-To: <87bl9mhgzn.fsf@redhat.com>
References: <20210301171922.321907-1-omosnace@redhat.com>
 <87bl9mhgzn.fsf@redhat.com>
Date:   Wed, 12 May 2021 10:08:04 +0200
Message-ID: <871racidcr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
>> I can't think of a good reason why they should be excluded. On the
>> contrary, excluding them can cause trouble very easily if some labeling
>> rules for these directories change. For example, we changed the label
>> for /dev/nvme* from nvme_device_t to fixed_disk_device_t in Fedora
>> (updating the allow rules accordingly) and after policy update they
>> ended up with an invalid context, causing denials.
>>
>> Thus, remove /dev and /run from the excludes. While there, also add
>> /root to the basic excludes to match the regex that excludes fc rules
>> (that should be effectively no functional change).
>>
>> I did a sanity check on my system by running `restorecon -nv /dev /run`
>> and it didn't report any label differences.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

Merged


>
>> ---
>>  policycoreutils/scripts/fixfiles | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
>> index 30dadb4f..6fb12e04 100755
>> --- a/policycoreutils/scripts/fixfiles
>> +++ b/policycoreutils/scripts/fixfiles
>> @@ -162,7 +162,7 @@ newer() {
>>  #
>>  diff_filecontext() {
>>  EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
>> -for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC /home /tmp /dev; do
>> +for i in /sys /proc /mnt /var/tmp /var/lib/BackupPC /home /root /tmp; do
>>      [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
>>  done
>>  LogExcluded
>> @@ -175,7 +175,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>>  	sed -r -e 's,:s0, ,g' $FC | sort -u | \
>>  	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
>>  	    grep '^[<>]'|cut -c3-| grep ^/ | \
>> -	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
>> +	    egrep -v '(^/home|^/root|^/tmp)' |\
>>  	sed -r -e 's,[[:blank:]].*,,g' \
>>  	       -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
>>  	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
>> -- 
>> 2.29.2

