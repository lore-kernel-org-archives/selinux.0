Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99DCA9EC0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FAB21734
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 13:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsOUXrrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfJ1NDv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:03:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726816AbfJ1NDv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 09:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572267830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=990xDwqvdf3u653C5xk7+zroHZpL9C6y1rgNe8Q6iS8=;
        b=fsOUXrrd1l5nyL+uAT+ko3ia/wi4Jah2lLXzd2/M9Cxx/7Kaqabu7Q5gSNmrzo+UXFQS1O
        FAfpEBf/D+1tIDYWZ2Pmbk652Z6CnsS9k/4o2q41vbP2LDqCWcig5iomXH+0ANZw02we5K
        T7NxhpBoAW9zOwOtOxqZL8chchHKA2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-0ZXAfhiWMLeAc1RMQtHn6g-1; Mon, 28 Oct 2019 09:03:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B2CA80066A;
        Mon, 28 Oct 2019 13:03:46 +0000 (UTC)
Received: from localhost (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A96A253D4;
        Mon, 28 Oct 2019 13:03:45 +0000 (UTC)
Date:   Mon, 28 Oct 2019 22:03:44 +0900 (JST)
Message-Id: <20191028.220344.653044146740544293.yamato@redhat.com>
To:     sds@tycho.nsa.gov
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: sysctl: update description for inode-state
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <871cd7f6-5866-7e8d-1fc3-664828d031a6@tycho.nsa.gov>
References: <20191028124353.25276-1-yamato@redhat.com>
        <871cd7f6-5866-7e8d-1fc3-664828d031a6@tycho.nsa.gov>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-MC-Unique: 0ZXAfhiWMLeAc1RMQtHn6g-1
X-Mimecast-Spam-Score: 0
Content-Type: Text/Plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm sorry. Plesae, ignore my two mails.

Masatake YAMATO

> On 10/28/19 8:43 AM, Masatake YAMATO wrote:
>> The third field of inode-state is dummy (=3D=3D 0).
>> Update the description about the actual fields and
>> dummies.
>=20
> These are not patches for SELinux and hence should not go to the
> selinux mailing list. Use scripts/get_maintainer.pl for some
> suggestions on the right set of maintainers and lists.
>=20
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>> ---
>>   Documentation/admin-guide/sysctl/fs.rst | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>> diff --git a/Documentation/admin-guide/sysctl/fs.rst
>> b/Documentation/admin-guide/sysctl/fs.rst
>> index 2a45119e3331..596f84a1748d 100644
>> --- a/Documentation/admin-guide/sysctl/fs.rst
>> +++ b/Documentation/admin-guide/sysctl/fs.rst
>> @@ -151,18 +151,15 @@ out of inodes, you need to increase this value.
>>   The file inode-nr contains the first two items from
>>   inode-state, so we'll skip to that file...
>>   -Inode-state contains three actual numbers and four dummies.
>> -The actual numbers are, in order of appearance, nr_inodes,
>> -nr_free_inodes and preshrink.
>> +Inode-state contains two actual numbers and five dummies.
>> +The actual numbers are, in order of appearance, nr_inodes
>> +and nr_free_inodes.
>>     Nr_inodes stands for the number of inodes the system has
>>   allocated, this can be slightly more than inode-max because
>>   Linux allocates them one pageful at a time.
>>   -Nr_free_inodes represents the number of free inodes (?) and
>> -preshrink is nonzero when the nr_inodes > inode-max and the
>> -system needs to prune the inode list instead of allocating
>> -more.
>> +Nr_free_inodes represents the number of free inodes.
>>       overflowgid & overflowuid
>>=20
>=20

