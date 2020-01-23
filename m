Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74809C33CAA
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 08:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1972467B
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdSFQn9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgAWIoq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:44:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23079 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgAWIoq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 03:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579769084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEObf4bVaRe1CqjpS5e7O0J8xQaq1gwvBFDbMBmft6o=;
        b=SdSFQn9eRMks6HaPGAJiTiH8h95UvNwoGooAuGs5gZdAXEE/dNy+/4eqvxHRLuQrSJZPW7
        ViwRfRwCMoltrDWHD9XOaEHrOWFlinTJq7/kKPtvLh7Gw4Q6popiUkwa0UkYRPXW0udi+o
        W4vxb/KEWkIQMTaVSziEdsir7VAlGKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-eoGTnOH_PJ2_U5dhcZJ5cA-1; Thu, 23 Jan 2020 03:44:42 -0500
X-MC-Unique: eoGTnOH_PJ2_U5dhcZJ5cA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C85A107ACC4;
        Thu, 23 Jan 2020 08:44:41 +0000 (UTC)
Received: from localhost (ovpn-204-109.brq.redhat.com [10.40.204.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FF27388;
        Thu, 23 Jan 2020 08:44:40 +0000 (UTC)
References: <20190509084204.26198-1-plautrba@redhat.com> <43a3624a-2217-f504-0195-13e4423c7b63@tycho.nsa.gov> <pjdsgtexwtm.fsf@redhat.com> <d533b6fe-9606-185d-caa6-8c71c09d7ee1@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: Re: [PATCH] libselinux: Eliminate use of security_compute_user()
In-reply-to: <d533b6fe-9606-185d-caa6-8c71c09d7ee1@tycho.nsa.gov>
Date:   Thu, 23 Jan 2020 09:44:39 +0100
Message-ID: <pjdmuaezhmw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 5/16/19 11:07 AM, Petr Lautrbach wrote:
>>
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>
>>> On 5/9/19 4:42 AM, Petr Lautrbach wrote:
>>>> get_ordered_context_list() code used to ask the kernel to compute the
>>>> complete
>>>> set of reachable contexts using /sys/fs/selinux/user aka
>>>> security_compute_user(). This set can be so huge so that it doesn't fit into
>>>> a
>>>> kernel page and security_compute_user() fails. Even if it doesn't fail,
>>>> get_ordered_context_list() throws away the vast majority of the returned
>>>> contexts because they don't match anything in
>>>> /etc/selinux/targeted/contexts/default_contexts or
>>>> /etc/selinux/targeted/contexts/users/
>>>>
>>>> get_ordered_context_list() is rewritten to compute set of contexts based on
>>>> /etc/selinux/targeted/contexts/users/ and
>>>> /etc/selinux/targeted/contexts/default_contexts files and to return only
>>>> valid
>>>> contexts, using security_check_context(), from this set.
>>>>
>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>>>>
>>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>>> ---
> <snip>
>>> I think the main potential stumbling block here is the MLS range component.
>>> The
>>> kernel policy defines the default level and allowed range for the (SELinux)
>>> user, and uses this information in the kernel function
>>> mls_setup_user_range(),
>>> https://elixir.bootlin.com/linux/latest/source/security/selinux/ss/mls.c#L402, 
>>>
>>> to determine the most suitable MLS range for the user session, based on both
>>> the
>>> from-context and the user default and range from the kernel policy.  Just
>>> using
>>> the level from the from-context could fail if the user isn't authorized to
>>> operate at that level, and even if the user is authorized to operate at that
>>> level, it could introduce a change in the default behavior if the user's
>>> default
>>> level differs. I think when we have discussed this in the past on the list,
>>> we
>>> were going to either export the user's default level and range information
>>> from
>>> the kernel via selinuxfs and replicate the mls_setup_user_ranges() logic in
>>> userspace, or have it automatically extracted from the kernel policy during
>>> policy build into a userspace configuration file that could be used directly
>>> by
>>> userspace.  Or something like that.  This gets a bit tricky though in that
>>> the
>>> logic involves comparing MLS levels, which is intrinsically policy-specific
>>> logic, and thus if we wanted to truly replicate it in userspace, we'd
>>> probably
>>> need to use libsepol.  Ugh. Maybe the kernel could just provide a simple
>>> selinuxfs interface for computing the result of mls_setup_user_range() and
>>> return that piece.
>>>
>>> That said, I don't know to what extent anyone is relying on this logic and to
>>> what extent it is obsoleted by the use of the level/range from seusers.  It
>>> looks like today we are replacing the level/range in the original
>>> from-context
>>> with the one from seusers before calling this code, in which case the
>>> fromlevel
>>> is in fact the one we ultimately want to use.  So perhaps this doesn't matter
>>> and we can just go with your approach.
>>
>> The problem is much complicated than I originally thought and this
>> patch changes the behavior of get_ordered_context_list what is probably
>> not acceptable.
>>
>> I'll do more tests and think about it the light of new (for me)
>> information.
>>
>> Thanks all for reviews and inputs.
>
> I would like to re-visit this patch again.  I did some looking at how
> get_ordered_context_list() and its variant interfaces are currently being used
> by callers, and at the internal logic of get_ordered_context_list() in userspace
> and mls_setup_user_ranges() in the kernel.  Since we are already substituting
> the range/level from seusers into the from-context before calling
> security_compute_user(), and since the only sensible configuration of seusers
> would be to use a range/level that falls within (or is identical to) the SELinux
> user's authorized range, I don't think your patch is likely to break anything.
> There are corner cases where it could yield a different result but I would be
> surprised if such corner cases are in real use and arguably they would be
> configuration errors.  Consequently, I think we should refresh your patch,
> address any comments made on it previously, and submit it for merging and try it
> out.  If we encounter any real world breakage from it, we can consider adding a
> new selinuxfs node that exports the kernel's mls_setup_user_ranges() logic and
> rework get_ordered_context_list() to use that to obtain the MLS portion of the
> context, but I don't think it is worth doing that without a real example where
> simply applying your patch breaks something.  Thoughts?


No objection at the moment. But it'll take me few days, we're kind of busy
when it's about https://www.devconf.info/cz/

