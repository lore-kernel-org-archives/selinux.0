Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFFC11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164EB246A1
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMh1412+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgB0Qcq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:32:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33412 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730194AbgB0Qcq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 11:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582821165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulx9bAO0xhsrKifgB/UkBF/yfYT00HqFuhNZy/CknwM=;
        b=IMh1412+MYVjkt7h7fjd1YbJRrN27+EacorLt5gEqM8Ma7j99M7oq7jGdxI8oFDZl4YyET
        waC76fOWO7DO9yWdRHqlpVsrIhSxtzSuGNedLod/yO02BQiu/wKF2PMfOsX1wKHVWgp9jd
        M1QsadgRgkPyMTjvmC4mpJlVOGjPYfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-7fuvGqd2P5GRnvsaooEZUA-1; Thu, 27 Feb 2020 11:32:39 -0500
X-MC-Unique: 7fuvGqd2P5GRnvsaooEZUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 379F91007284;
        Thu, 27 Feb 2020 16:32:38 +0000 (UTC)
Received: from localhost (ovpn-205-3.brq.redhat.com [10.40.205.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0F3160BE2;
        Thu, 27 Feb 2020 16:32:37 +0000 (UTC)
References: <20200221083819.1124890-1-plautrba@redhat.com>
 <CAB9W1A2_hSh4j7_KP2Bbi57942yEJO9xy65XxPJxoFdckZRocg@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: deprecate security_compute_user(), update
 man pages
In-reply-to: <CAB9W1A2_hSh4j7_KP2Bbi57942yEJO9xy65XxPJxoFdckZRocg@mail.gmail.com>
Date:   Thu, 27 Feb 2020 17:32:36 +0100
Message-ID: <pjdlfoo6lej.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <stephen.smalley@gmail.com> writes:

> On Fri, Feb 21, 2020 at 3:40 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>>
>> commit 1f89c4e7879fcf6da5d8d1b025dcc03371f30fc9 ("libselinux: Eliminate
>> use of security_compute_user()") eliminated the use of
>> security_compute_user() by get_ordered_context_list().  Deprecate
>> all use of security_compute_user() by updating the headers and man
>> pages and logging a warning message on any calls to it.  Remove
>> the example utility that called the interface. While here, also
>> fix the documentation of correct usage of the user argument to these
>> interfaces.
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/70
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>
>> It looks like the original email didn't get to the mailing list. Therefore
>> I'm resending it for a broader audience.
>
> Can this be merged?

I'm sorry I mis-read
https://lore.kernel.org/selinux/CAFftDdqKkRc5S236+OjXJkfJaHVw8F-1XicHUb2aaxYqZK1QSQ@mail.gmail.com/
and I though that there would be a re-spin, but the mail says that it will
be follow up.

It's merged now. Thanks!


Petr

