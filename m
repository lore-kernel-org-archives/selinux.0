Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE96C04EB8
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79732084E
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 09:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79732084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeLLJiz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:38:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeLLJiz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Dec 2018 04:38:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11E7FC052504;
        Wed, 12 Dec 2018 09:38:55 +0000 (UTC)
Received: from workstation (unknown [10.43.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5873E194AB;
        Wed, 12 Dec 2018 09:38:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] python/chcat: fix removing categories on users with Fedora default setup
References: <20181209142323.21149-1-nicolas.iooss@m4x.org>
        <20181209142323.21149-2-nicolas.iooss@m4x.org> <pjd8t0we697.fsf@redhat.com>
Date:   Wed, 12 Dec 2018 10:38:52 +0100
In-Reply-To: <pjd8t0we697.fsf@redhat.com> (Petr Lautrbach's message of "Tue,
        11 Dec 2018 10:56:36 +0100")
Message-ID: <pjdy38vccer.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 12 Dec 2018 09:38:55 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
>> Using Vagrant with fedora/28-cloud-base image, SELinux logins are
>> configured this way:
>>
>>     # semanage login -l
>>     Login Name           SELinux User         MLS/MCS Range        Service
>>
>>     __default__          unconfined_u         s0-s0:c0.c1023       *
>>     root                 unconfined_u         s0-s0:c0.c1023       *
>>     vagrant              unconfined_u         s0-s0:c0.c1023       *
>>
>> Using "chcat -l +c42 vagrant" successfully adds the category to user
>> vagrant, but "chcat -l -- -c42 vagrant" fails to remove it.
>> semanage login -l returns:
>>
>>     vagrant              unconfined_u         s0-s0:c0.c1023,c42   *
>>
>> This issue is caused by expandCats(), which refuses to return a list of
>> more than 25 categories. This causes chcat_user_remove() to work with
>> cats=['c0.c1023,c42'] instead of cats=['c0.c102','c42'], which leads to
>> it not been able to remove 'c42' from the list.
>>
>> Fix this issue by splitting the list of categories before calling
>> expandCats().
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

All 3 chcat patches merged. Thanks!


>
>> ---
>>  python/chcat/chcat | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/python/chcat/chcat b/python/chcat/chcat
>> index 73f757258807..5bef0073b7a4 100755
>> --- a/python/chcat/chcat
>> +++ b/python/chcat/chcat
>> @@ -82,8 +82,7 @@ def chcat_user_add(newcat, users):
>>          if len(serange) > 1:
>>              top = serange[1].split(":")
>>              if len(top) > 1:
>> -                cats.append(top[1])
>> -                cats = expandCats(cats)
>> +                cats = expandCats(top[1].split(','))
>>  
>>          for i in newcat[1:]:
>>              if i not in cats:
>> @@ -163,8 +162,7 @@ def chcat_user_remove(newcat, users):
>>          if len(serange) > 1:
>>              top = serange[1].split(":")
>>              if len(top) > 1:
>> -                cats.append(top[1])
>> -                cats = expandCats(cats)
>> +                cats = expandCats(top[1].split(','))
>>  
>>          for i in newcat[1:]:
>>              if i in cats:
