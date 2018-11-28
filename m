Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41778C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 17:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D192081B
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 17:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D192081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeK2ElS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:41:18 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40007 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2ElS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 23:41:18 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gS3nY-0003Fz-C2; Wed, 28 Nov 2018 10:38:52 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gS3nX-0007H3-Ba; Wed, 28 Nov 2018 10:38:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <20181116131202.26513-1-omosnace@redhat.com>
        <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
        <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com>
        <CAFqZXNvSdKYr998v3hEhZu4pRwuQs8Q7qRWPhOAtLAc9__Bs6w@mail.gmail.com>
        <CAHC9VhTvuPvnkfgQhT4+AM3iEz4_p85QgShM_oXmpVtLKuq10Q@mail.gmail.com>
        <87r2f5fbw7.fsf@xmission.com>
        <CAFqZXNsxH2TMU-ZxxfzvqPcwQ9FzUj1N3iS-7AVQ3JZvj2KEYA@mail.gmail.com>
Date:   Wed, 28 Nov 2018 11:38:39 -0600
In-Reply-To: <CAFqZXNsxH2TMU-ZxxfzvqPcwQ9FzUj1N3iS-7AVQ3JZvj2KEYA@mail.gmail.com>
        (Ondrej Mosnacek's message of "Wed, 28 Nov 2018 17:12:00 +0100")
Message-ID: <87efb5f6g0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gS3nX-0007H3-Ba;;;mid=<87efb5f6g0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Bj03VftjblCfaU7YfZTkSpSuX87Da6V4=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] selinux: always allow mounting submounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Wed, Nov 28, 2018 at 4:42 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> A few late comments on this.
>>
>> The change mentioned in fixes did not remove a SB_KERNMOUNT so I don't
>> see how it is a fix for that.  That change just added SB_SUBMOUNT so you
>> can test for and detect this situation.  Are you seeing something that I
>> am not in that change?
>
> No, you're right that this patch doesn't "fix" that commit in the
> usual sense (the bug has pretty much always been there). However, that
> commit is the one that introduces the SB_KERNMOUNT flag and thus this
> patch can be only applied on trees that have that commit. That's what
> I tried to communicate with the "Fixes:" tag. Maybe I abused it a
> little, but it is often used to guide backporting so I figured it
> would make sense like this.

That makes sense.  In cases like that I use Ref: instead of Fixes:
That makes the connection clear, without implying the other patch was
wrong.

That and I would say something like.  It is now possible to fix this
as submounts are not detectable.  Or something like that.

Eric
