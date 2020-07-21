Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE1BC433E2
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3328E20717
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFYlQ1pP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGUNFd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:05:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41116 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbgGUNFd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 09:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595336732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h2xwMq8lIQO51t17aA55QnPNYCz/6Bnra5geZHDKXYA=;
        b=iFYlQ1pP0jp5J70td7f5tNiqgScPcEVm5rYqL2vImDegmPgMXfi+SCDsizKWVwgatn6vQS
        IlyeftoXrNIH5AVn/muplKSjZ9IbpUoi8Va9OdjB65rQmjPvIPK0cz7Gk/qv0mW6UJl6qS
        OMfw9A+NLwr6Bxd1Bb6Lwrk+slO26qU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-sRPTHceDP5ywpnG51ZsxTQ-1; Tue, 21 Jul 2020 09:05:21 -0400
X-MC-Unique: sRPTHceDP5ywpnG51ZsxTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65F33107ACCA;
        Tue, 21 Jul 2020 13:05:20 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-90.ams2.redhat.com [10.36.112.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB812756A1;
        Tue, 21 Jul 2020 13:05:14 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Arjun Shankar <arjun.is@lostca.se>,
        SElinux list <selinux@vger.kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: [RFC] Porting glibc away from deprecated libselinux APIs
References: <20200721115734.GA43979@aloka.lostca.se>
        <CAEjxPJ5wZ6HE0hA7+RAPfJkzL_W3LTLop9gNb8GxkHxMkLEAcA@mail.gmail.com>
Date:   Tue, 21 Jul 2020 15:05:12 +0200
In-Reply-To: <CAEjxPJ5wZ6HE0hA7+RAPfJkzL_W3LTLop9gNb8GxkHxMkLEAcA@mail.gmail.com>
        (Stephen Smalley's message of "Tue, 21 Jul 2020 08:59:18 -0400")
Message-ID: <87365lqarb.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Stephen Smalley:

> On Tue, Jul 21, 2020 at 8:07 AM Arjun Shankar <arjun.is@lostca.se> wrote:
>>
>> Hi,
>>
>> glibc currently uses several recently deprecated libselinux APIs:
>>
>> 1. makedb uses matchpathcon:
>>
>> https://sourceware.org/git/?p=glibc.git;a=blob;f=nss/makedb.c;h=8e389a1683747cf1047f4de8fe603f2b5ccc5f3f;hb=HEAD
>
> Should migrate to selabel_open/lookup/close.
>
>> 2. nscd uses avc_init and multiple old style callbacks:
>>
>> https://sourceware.org/git/?p=glibc.git;a=blob;f=nscd/selinux.c;h=a4ea8008e201b9397aa4274bb558de471b0573af;hb=HEAD
>
> Wondering if nscd can migrate to using the higher level
> selinux_check_access() interface instead of direct usage of the
> avc_*() interfaces.

Somewhat related:

I do not know the reason *why* we have SELinux-specific code in glibc,
and in this places in particular.  What makes nscd and makedb special?
ldconfig also writes a file used across trust boundaries
(/etc/ld.so.cache), and yet we don't label it explicitly.

(nscd is a daemon that runs under its own user and loads NSS service
modules.  makedb is similar to ldconfig.)

Do you have an idea why we need this code in glibc in the first place?
Could it be that it is simply there to work around an incomplete system
policy?

Thanks,
Florian

