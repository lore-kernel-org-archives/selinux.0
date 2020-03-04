Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC7CC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 13:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F12166E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsKVlK1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgCDNP6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:15:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387992AbgCDNP6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 08:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583327756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIK1CNv//tl+1DaJepbrSG/rCrFcGXfF4hkPQwpRdmo=;
        b=JsKVlK1chYv1hyPar77E67DSe+yzuSI9iviJSc3RTjKDYgXD+S7WTOyoultDEwTTHTW7gO
        +48y99259xZpw2YZS5tLK12SpS19wN9Bl9yn+gANM7dHZVMNzU4vo/hvxu7vnqXHN1fT0E
        m2KSjpdlQTRf78AIia6AXlgm0eyYz68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Rr29dTUFOTKwXYpfDgir8w-1; Wed, 04 Mar 2020 08:15:49 -0500
X-MC-Unique: Rr29dTUFOTKwXYpfDgir8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FAE418AB2C3;
        Wed,  4 Mar 2020 13:15:48 +0000 (UTC)
Received: from localhost (unknown [10.34.246.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D58F91D79;
        Wed,  4 Mar 2020 13:15:47 +0000 (UTC)
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
Date:   Wed, 04 Mar 2020 14:15:45 +0100
Message-ID: <pjdeeu86z26.fsf@redhat.com>
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

On it. I'll provide a feedback later today or tomorrow.

