Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D92C3F2D2
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ACB2072D
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 17:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCjKT2YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEReK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:34:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33465 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgCEReK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 12:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583429648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RziXo/NGPJ/ypWg1/TRphwAjHBl8xfNwlKfrz6IDBPg=;
        b=WCjKT2YB5mMxelMKHkpbZ1tqfc6kRpzcvDoJwoxeaUmbTmeiahhi2FyuwM5yeJzzSmE0nZ
        37FF7qURmYkZdz2AYK+/YHmA4R+K7odvR9IRhNuH9wvggN3Iv8DYtQ3azwQTT6m0oCeTeo
        ALeCIDhKUHVpNt3PJw9Alz0pplPZ4Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-_eMoPVE4Mm2tSHonDGSfOA-1; Thu, 05 Mar 2020 12:34:01 -0500
X-MC-Unique: _eMoPVE4Mm2tSHonDGSfOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E96C3802B7A;
        Thu,  5 Mar 2020 17:33:59 +0000 (UTC)
Received: from localhost (ovpn-204-50.brq.redhat.com [10.40.204.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C1115D9CD;
        Thu,  5 Mar 2020 17:33:58 +0000 (UTC)
References: <20200304072940.GA1026144@brutus.lan>
 <20200304074251.GA1032355@brutus.lan>
 <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
 <20200304143650.GB1032355@brutus.lan>
 <CAEjxPJ4OPGWnc1uPDmqSuFnbFhzGYxenSyZ7WmxtnJ3Y2BdAzQ@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: strange pam selinux issue
In-reply-to: <CAEjxPJ4OPGWnc1uPDmqSuFnbFhzGYxenSyZ7WmxtnJ3Y2BdAzQ@mail.gmail.com>
Date:   Thu, 05 Mar 2020 18:33:55 +0100
Message-ID: <pjdblpa7lks.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Mar 4, 2020 at 9:36 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
>> > Are you using libselinux with or without the commit to stop using
>> > security_compute_user()?
>> > If still using security_compute_user(), what does compute_user
>> > sys.id:sys.role:sys.isid:s0 wheel.id display?
>> > If you don't have compute_user (it is in libselinux/utils but not sure
>> > Fedora packages it), you can also just
>> > strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
>> > and see what it read back from /sys/fs/selinux/user.
>>
>> Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/contexts/users/wheel.id...
>> I am not if my libselinux has or has not security_compute_user():
>>
>> # rpm -qa libselinux
>> libselinux-3.0-3.fc32.x86_64
>>
>> openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) = 3
>> write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) = -1 ERANGE (Numerical result out of range)
>
> This shows that your libselinux is still calling
> security_compute_user() from get_ordered_context_list().
> In this case, because the source context is allowed to transition to
> many other contexts, the result returned via
> /sys/fs/selinux/user would exceed the maximum size supported by the
> kernel interface (one page of contexts),
> and therefore it fails.  Then get_ordered_context_list() falls back to
> the failsafe_context.
>
> If you update to libselinux git, you will stop using
> security_compute_user() and hence /sys/fs/selinux/user entirely.

FYI I've just built libselinux-3.0-4.fc32 [1] and libselinux-3.0-4.fc33
[2] with the security_compute_user() patch applied.

[1] https://koji.fedoraproject.org/koji/buildinfo?buildID=1474378
[2] https://koji.fedoraproject.org/koji/buildinfo?buildID=1474377

-- 
()  ascii ribbon campaign - against html e-mail 
/\  www.asciiribbon.org   - against proprietary attachments

