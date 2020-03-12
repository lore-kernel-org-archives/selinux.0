Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2473C1975A
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 06:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CC220578
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 06:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6WUhivT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgCLGxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:53:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387831AbgCLGxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 02:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583996001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aobFzibg4Y9N/YXhPfZjWq3KzFn+rSBYcgDicC445F0=;
        b=F6WUhivTE4CSvpkGuJPkI6fQeOMGbYADRh4YgjOw5Cjz9cr+4nopdTX/ZMODpTsKoj38DP
        jIobg+JGYtdSnMXCrEoJB0HYhomRcHBhljb89KN1flQVHUX0C9odsukrKaMGed70PIynxQ
        IxJD8PTehnBRB+8AZursygIXXx6xTAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-f8Rr4hZUOcqdOZM2PE2LXg-1; Thu, 12 Mar 2020 02:53:17 -0400
X-MC-Unique: f8Rr4hZUOcqdOZM2PE2LXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E310189D6C0;
        Thu, 12 Mar 2020 06:53:16 +0000 (UTC)
Received: from localhost (ovpn-204-216.brq.redhat.com [10.40.204.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D78125D9E5;
        Thu, 12 Mar 2020 06:53:15 +0000 (UTC)
References: <20200121184017.18084-1-sds@tycho.nsa.gov>
 <pjdeevmzdqq.fsf@redhat.com>
 <0acce760-fce8-3744-cea7-b6d4249ea754@tycho.nsa.gov>
 <pjda766zaox.fsf@redhat.com>
 <431cc5f6-e666-e875-a4fd-4d98b414d82f@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 27.0.90
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        "Christopher J. PeBenito" <pebenito@ieee.org>,
        stephen.smalley.work@gmail.com
Subject: Re: [PATCH v4] libsepol, checkpolicy: remove use of hardcoded
 security class values
In-reply-to: <431cc5f6-e666-e875-a4fd-4d98b414d82f@tycho.nsa.gov>
Date:   Thu, 12 Mar 2020 07:53:14 +0100
Message-ID: <pjdimjaawth.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 1/29/20 7:52 AM, Petr Lautrbach wrote:
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>> 
>>> On 1/26/20 5:57 AM, Petr Lautrbach wrote:
>>>>
>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>
>>>>> libsepol carried its own (outdated) copy of flask.h with the generated
>>>>> security class and initial SID values for use by the policy
>>>>> compiler and the forked copy of the security server code
>>>>> leveraged by tools such as audit2why.  Convert libsepol and
>>>>> checkpolicy entirely to looking up class values from the policy,
>>>>> remove the SECCLASS_* definitions from its flask.h header, and move
>>>>> the header with its remaining initial SID definitions private to
>>>>> libsepol.  While we are here, fix the sepol_compute_sid() logic to
>>>>> properly support features long since added to the policy and kernel,
>>>>> although there are no users of it other than checkpolicy -d (debug)
>>>>> and it is not exported to users of the shared library.  There
>>>>> are still some residual differences between the kernel logic and
>>>>> libsepol.
>>>>>
>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>
>>>>
>>>> The only problem I found running tests on this is related to SETools
>>>> https://github.com/SELinuxProject/selinux/pull/200#issuecomment-577745225
>>>>
>>>> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>>>
>>> Thanks.  I guess the question is whether we should wait to merge it until
>>> setools has a corresponding fix ready or go ahead.
>> https://github.com/SELinuxProject/setools/issues/39
>> Lets wait until there's a response from Christopher.
>
> setools issue has been resolved, so this should now be mergeable.

Applied, thanks.

