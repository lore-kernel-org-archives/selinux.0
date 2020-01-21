Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C549CC2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EFD217F4
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 19:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZmn6d/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgAUT0P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:26:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727383AbgAUT0O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 14:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579634773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rotFZVGb5xfrKuO7IMI8L8URP6xwWQ6trgOgjPeQwvk=;
        b=GZmn6d/pWcdDYb70iJV3HNDHu8upvk1sxmfamtHubjI0IzYLIFkBnOxRPsjIGmaEHQ5xc2
        LJfhCcTjYkHnFUZRk6/FwwuQ/Dq7rLEOq/WJ7j1zLhYsgXx+KB5RGFsfVmEaFDnol/JqUk
        GqXmiUaN995TZQr53i8G7qJw7j2n8jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-qd-rM6U8PG6YXkRH8hmCAw-1; Tue, 21 Jan 2020 14:26:09 -0500
X-MC-Unique: qd-rM6U8PG6YXkRH8hmCAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B99F5107ACC9;
        Tue, 21 Jan 2020 19:26:08 +0000 (UTC)
Received: from localhost (ovpn-204-171.brq.redhat.com [10.40.204.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54D2F10013A7;
        Tue, 21 Jan 2020 19:26:08 +0000 (UTC)
References: <20200115155523.69438-1-sds@tycho.nsa.gov> <pjdh80vqivt.fsf@redhat.com> <pjdd0biq95r.fsf@redhat.com> <5d7eb243-1dbe-9c54-9cf6-b3e7cdfba7c7@tycho.nsa.gov> <3bf86683-05fd-e7fe-8808-5336b49b5932@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: remove flask.h and av_permissions.h
In-reply-to: <3bf86683-05fd-e7fe-8808-5336b49b5932@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 20:26:06 +0100
Message-ID: <pjd7e1kr4q9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 1/17/20 1:24 PM, Stephen Smalley wrote:
>> On 1/17/20 12:34 PM, Petr Lautrbach wrote:
>>>
>>> Petr Lautrbach <plautrba@redhat.com> writes:
>>>
>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>
>>>>> The flask.h and av_permissions.h header files were deprecated and
>>>>> all selinux userspace references to them were removed in
>>>>> commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h.")
>>>>> back in 2014 and included in the 20150202 / 2.4 release.
>>>>> All userspace object managers should have been updated
>>>>> to use the dynamic class/perm mapping support since that time.
>>>>> Remove these headers finally to ensure that no users remain and
>>>>> that no future uses are ever introduced.
>>>>
>>>> I've patched libselinux and I'm building all packages which requires
>>>> libselinux-devel [1] in Fedora. I'm in the middle of package list and so far
>>>> there
>>>> are only 3 packages which fails to build without flask.h or
>>>> av_permission.h - libuser (the particular file wasn't updated since
>>>> 2012), ipsec-tools and mesa. When it's finished I'll investigate all
>>>> results, but I don't think there will be some blocker.
>>>>
>>>> [1]
>>>> https://copr.fedorainfracloud.org/coprs/plautrba/libselinux-without-flask.h/builds/ 
>>>>
>>>>
>>>
>>> So the complete list of Fedora packages dependent on selinux/flask.h is:
>>>
>>> xinetd
>>> usermode
>>> sed
>>> pam
>>> oddjob
>>> libuser
>>> ipsec-tools
>>>
>>> Problems are usually in tests or in Fedora specific patches. I'll start
>>> to work on fixes with affected maintainers.
>>
>> Great, thank you.  Hopefully the other patch for libsepol,checkpolicy to prune
>> its copy of flask.h of all SECCLASS_* definitions and take it private to
>> libsepol won't break anything.  With those two changes, we should be free of
>> any lingering uses of hardcoded class and permission definitions.  Then all we
>> need is for dbus-daemon to either set up a POLICYLOAD callback and re-fresh
>> its mapping at that time or switch over to looking up the class and
>> permissions each time as per the guidance in the updated libselinux man pages
>> (per my third patch) and userspace should be safe for class or permission
>> changes.
>
> Just wanted to check: you acked my patch so I assume it is ok to merge now even
> before the above packages are all updated but wanted to confirm.

It's ok to merge it. It's better as a reference when it's merged, and pushed.

I just wasn't sure if it's nor related to your other patches, but I
haven't time to check them yet..

-- 
()  ascii ribbon campaign - against html e-mail 
/\  www.asciiribbon.org   - against proprietary attachments

