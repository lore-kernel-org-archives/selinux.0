Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE2C61DA4
	for <selinux@archiver.kernel.org>; Thu, 16 Feb 2023 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBPRsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPRsz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Feb 2023 12:48:55 -0500
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 09:48:53 PST
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D44C3F8;
        Thu, 16 Feb 2023 09:48:53 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:45302)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pSgqj-00EmG5-FB; Thu, 16 Feb 2023 09:11:09 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41456 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pSgqi-003fCi-F5; Thu, 16 Feb 2023 09:11:09 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230215131807.293556-1-omosnace@redhat.com>
        <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
Date:   Thu, 16 Feb 2023 10:07:53 -0600
In-Reply-To: <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
        (Andrew Morton's message of "Wed, 15 Feb 2023 12:47:47 -0800")
Message-ID: <87a61d7fvq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pSgqi-003fCi-F5;;;mid=<87a61d7fvq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18qIEApqQSqpUxdzdLE40wBYa/0PtjN14E=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in
 __sys_setres[ug]id()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
>> 1. First determine if CAP_SET[UG]ID is required and only then call
>>    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
>
> Can we please have more details on the selinux failures?  Under what
> circumstances?  What is the end-user impact?

It is puzzling the structure with having the capability check first
dates to 2.1.104 (when a hand coded test for root was replaced
with capable(CAP_SETID).  Which means the basic structure and logic
of the code is even older than that.

Eric
