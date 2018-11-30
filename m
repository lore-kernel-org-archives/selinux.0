Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00683C65BAE
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C059C2146F
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C059C2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLAFKh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:10:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbeLAFKh (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 1 Dec 2018 00:10:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B45373099FD4;
        Fri, 30 Nov 2018 18:00:32 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18032600CC;
        Fri, 30 Nov 2018 18:00:30 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-api@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Security modules and sending signals within the same process
References: <87lg5asilo.fsf@oldenburg.str.redhat.com>
        <2c3e813c-f56a-3354-1299-30b0646f40e1@schaufler-ca.com>
Date:   Fri, 30 Nov 2018 19:00:21 +0100
In-Reply-To: <2c3e813c-f56a-3354-1299-30b0646f40e1@schaufler-ca.com> (Casey
        Schaufler's message of "Fri, 30 Nov 2018 09:54:44 -0800")
Message-ID: <87k1kuqwcq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 30 Nov 2018 18:00:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Casey Schaufler:

> On 11/30/2018 7:14 AM, Florian Weimer wrote:
>> Is it guaranteed that tasks in the same thread group can always send
>> signals to each other, irrespective of their respective credentials
>> structs?
>
> No. An LSM may chose to disallow this based on just about any
> criteria it desires.

Hmm.

>> It's not clear to me whether this is always possible based on the
>> security_task_kill implementations I've examined.
>
> SELinux, Smack and AppArmor make their decisions based on
> the task_struct credential, so if it's possible to change
> the LSM attributes at the task granularity, it's possible
> to have a process that can't always talk to itself.

Yes, we already have this today for LSM attributes.  We only paper over
this for the UIDs/GIDs, using a really awkward mechanism.  Maybe we will
get rid of that one day, when the kernel supports a proper per-process
attribute, but I don't count on it.

>> I want to support per-thread setresuid/setresgid,
>
> That's pretty dangerous in its own right. Effectively
> the process containing the threads has multiple UIDs.
> That complicates the DAC model significantly.

Sure.  But I think it's better to do this explicitly in glibc, rather
than file server authors calling the system calls directly.  And it only
exposes what the kernel does anyway.

Thanks,
Florian
