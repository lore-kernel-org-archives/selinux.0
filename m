Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FDDC3F2CD
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD5220848
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 12:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdCuEYi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCEMmb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:42:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbgCEMma (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 07:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583412149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EmJb8TryH12sLcOOdwXo//tV3sNerqDl/eDvmEdAExI=;
        b=FdCuEYi23sDqM3cKoXQDBjHor5YVWKy3i3zv9sYsFPTONVNmfrOJD3+54mxzeFXJ6jfEjZ
        fsAFbfNuabkN2x/WaVdazJOB8WQ6IET/0B/lcXnykxw0JJB8C7/CsmP1zYwDYk3FafubQa
        Ln0YISZKe+hod+54aDArOdtyj8TIQzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-RtdkF8cxNmu1-ujQcJZcQg-1; Thu, 05 Mar 2020 07:42:26 -0500
X-MC-Unique: RtdkF8cxNmu1-ujQcJZcQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E61119057A0;
        Thu,  5 Mar 2020 12:42:25 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8839D48;
        Thu,  5 Mar 2020 12:42:24 +0000 (UTC)
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com>
 <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [V4] libselinux: drop dso.h
In-reply-to: <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
Date:   Thu, 05 Mar 2020 13:42:23 +0100
Message-ID: <pjdd09r6ki8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
>>
>> Version 4:
>>   - Fix linker option warnings.
>>   - Move map file to begining of options.
>>
>> Version 3:
>>   - Add more symbols that should be dropped from the dso:
>>     - map_class;
>>     - map_decision;
>>     - map_perm;
>>
>> Version 2:
>>   - adds a version to the linker script LIBSELINUX_1.0
>>   - Adds a patch to drop some additional symbols from the dso:
>>     - dir_xattr_list
>>     - myprintf_compat
>>     - unmap_class
>>     - unmap_perm
>>
>> This four part patch series drops the dso.h and hidden_*
>> macros.
>>
>> The old dso.h functionality provided libselinux with both control over
>> external exported symbols as well as ensuring internal callers call into
>> libselinux and not a symbol with the same name loaded by the linker
>> earlier in the library list.
>>
>> The functionality is replaced by a linker script that requires public
>> API to explicitly be opt-in. The old method required that internal API
>> be explicitly annotated, and everything else is public. This should help
>> make it easier to control libselinux DSO hygene going forward.
>>
>> The second functionality is replaced by compiler option
>> -fno-semantic-interposition
>>
>> Note that clang has this enabled by default, and thus doesn't need it.
>>
>> See:
>>   - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition
>>
>> [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
>> [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
>> [PATCH v4 3/4] Makefile: add linker script to minimize exports
>> [PATCH v4 4/4] libselinux: drop symbols from map
>
> This looks fine to me but I'd like at least one of the distro
> maintainers to ack it (especially the last one).

Acked-by: Petr Lautrbach <plautrba@redhat.com>

