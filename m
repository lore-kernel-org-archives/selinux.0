Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F238C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6759520716
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 12:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BULTX6Pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgA2MxB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:53:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726068AbgA2MxB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 07:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580302379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7H5oPqabIlg83H9m3oBX4nHIvzjtFS1/wQhyYm+gfcI=;
        b=BULTX6PdWREd3r0hbjTcPVSxrpBlfM4wQHnnBBn49FbQ0tToQyAX+rMu7OMdLGFAz8thbp
        LzJ6a4ZXRxNEZbKNxW2EdHbww9yTzmYAGQ1WAQ8ryP143ISVWht8XQ32jTMQq+9V75bHpg
        GId5V7RNXluTAiNHGK5C0hOx3ogkLC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-AKMcBEAQNpOyC9EIPLCSJA-1; Wed, 29 Jan 2020 07:52:52 -0500
X-MC-Unique: AKMcBEAQNpOyC9EIPLCSJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D277F8010D9;
        Wed, 29 Jan 2020 12:52:50 +0000 (UTC)
Received: from localhost (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A1385C1B5;
        Wed, 29 Jan 2020 12:52:49 +0000 (UTC)
References: <20200121184017.18084-1-sds@tycho.nsa.gov> <pjdeevmzdqq.fsf@redhat.com> <0acce760-fce8-3744-cea7-b6d4249ea754@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: Re: [PATCH v4] libsepol, checkpolicy: remove use of hardcoded security class values
In-reply-to: <0acce760-fce8-3744-cea7-b6d4249ea754@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 13:52:46 +0100
Message-ID: <pjda766zaox.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 1/26/20 5:57 AM, Petr Lautrbach wrote:
>>
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>
>>> libsepol carried its own (outdated) copy of flask.h with the generated
>>> security class and initial SID values for use by the policy
>>> compiler and the forked copy of the security server code
>>> leveraged by tools such as audit2why.  Convert libsepol and
>>> checkpolicy entirely to looking up class values from the policy,
>>> remove the SECCLASS_* definitions from its flask.h header, and move
>>> the header with its remaining initial SID definitions private to
>>> libsepol.  While we are here, fix the sepol_compute_sid() logic to
>>> properly support features long since added to the policy and kernel,
>>> although there are no users of it other than checkpolicy -d (debug)
>>> and it is not exported to users of the shared library.  There
>>> are still some residual differences between the kernel logic and
>>> libsepol.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>>
>> The only problem I found running tests on this is related to SETools
>> https://github.com/SELinuxProject/selinux/pull/200#issuecomment-577745225
>>
>> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks.  I guess the question is whether we should wait to merge it until
> setools has a corresponding fix ready or go ahead.

https://github.com/SELinuxProject/setools/issues/39

Lets wait until there's a response from Christopher.

-- 
()  ascii ribbon campaign - against html e-mail 
/\  www.asciiribbon.org   - against proprietary attachments

