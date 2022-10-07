Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B76EC433F5
	for <selinux@archiver.kernel.org>; Fri,  7 Oct 2022 13:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJGNx3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGNx1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Oct 2022 09:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A01B7B8
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665150805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mD7YnT+d1+SDxFjg4yod5q/DRULnPnRXfa0Svd5Npo=;
        b=Hv/1YR/wSWFrcc6iDZfbyrPI072yx+izD2OIHg8AvftxJjUhC/FddtesV6bpbgX1NGLET3
        Vxsz3puQEGUYcHYIHO+dGRHqMcSuH1KheC+bzBJvQDTywri2tjrt73QLr6htc9wi5asf09
        9FJyfAChl7cWrMALQprtjraNVIlBoDA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-7zUUQD9RPhis6YBfg1IjqA-1; Fri, 07 Oct 2022 09:53:24 -0400
X-MC-Unique: 7zUUQD9RPhis6YBfg1IjqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F75F29AA381;
        Fri,  7 Oct 2022 13:53:23 +0000 (UTC)
Received: from localhost (unknown [10.40.194.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE66DC15BA4;
        Fri,  7 Oct 2022 13:53:22 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: Re: unnecessary log output in selinux_status_updated
In-Reply-To: <CAEjxPJ6hQ3-_6_O2LxQPLD14Xzrcs6NfmqLRpe9arbEppU711g@mail.gmail.com>
References: <87ilkwxbde.fsf@redhat.com>
 <CAEjxPJ6hQ3-_6_O2LxQPLD14Xzrcs6NfmqLRpe9arbEppU711g@mail.gmail.com>
Date:   Fri, 07 Oct 2022 15:53:22 +0200
Message-ID: <87fsfzyc31.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Fri, Oct 7, 2022 at 4:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Hi,
>>
>>
>> Commit 05bdc03130d74 ("libselinux: use kernel status page by default") changed
>> selinux_status_updated() so that it calls avc_process_policyload() and
>> avc_process_setenforce() and both functions call avc_log() and avc_log() logs to
>> stderr by default. So when a process like `rpm` checks whether there was a
>> change, it gets output on stderr which previously wasn't there.
>>
>>
>> Before this change:
>> >>> from selinux import *
>> >>> selinux_status_open(0);
>> 0
>> >>>
>> >>> selinux_status_updated();
>> 0
>> >>> selinux_mkload_policy(0);
>> 0
>> >>> selinux_status_updated();
>> 1
>>
>> Current version:
>> >>> from selinux import *
>> elinux_status_updated();
>> selinux_mkload_policy(0);
>> selinux_status_updated();
>> >>> selinux_status_open(0);
>> 0
>> >>> selinux_status_updated();
>> 0
>> >>> selinux_mkload_policy(0);
>> 0
>> >>> selinux_status_updated();
>> uavc:  op=load_policy lsm=selinux seqno=2 res=11
>>
>>
>> The calling process could set its callback but it seems unnecessarily
>> complicated just for selinux_status_updated() which is supposed to check whether
>> something has changed or not. Also processing events in this function seems to
>> be unnecessary.
>>
>> It looks like the reason for the new code added to selinux_status_updated() is
>> that there were several avc_netlink_check_nb() calls replaced by
>> selinux_status_updated(). Given the problem described above, I don't think it's
>> correct and I would like to change selinux_status_updated() back and use another
>> mechanism that would help with the replacement.
>>
>>
>> So what do you think about it?
>
> The goal was to switch the AVC and all of its users (e.g.
> selinux_check_access) over to using the much more efficient SELinux
> kernel status page mechanism for setenforce and policy load
> notifications on newer kernels instead of the SELinux netlink
> mechanism (which imposed extra syscall overhead on the critical path).
>
> Understand your concern but unsure as to whether we can just change
> selinux_status_updated() back now.
> Would require an audit of all users of selinux_status_updated(), both
> direct and indirect, to ensure that none of them are relying on this
> behavior. We can obviously fix the callers within libselinux but
> addressing external callers is more problematic and is arguably an ABI
> change. Would need to look at all users of the AVC,
> selinux_check_access(), etc.
> This change happened 2 years ago so I have to wonder why it is only
> coming up now?

Nobody has noticed it.

 83         avc_log(SELINUX_POLICYLOAD,
 84                 "%s:  op=load_policy lsm=selinux seqno=%u res=1",
 85                 avc_prefix, seqno);

There's missing '\n' and so this message is sooner or later overwritten by
something else, see
https://bugzilla.redhat.com/show_bug.cgi?id=2123637 and
https://bugzilla.redhat.com/show_bug.cgi?id=2123719




