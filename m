Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054BFA372B
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09702082C
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403846AbfJQHMK convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:12:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390955AbfJQHMK (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 17 Oct 2019 03:12:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FB414084FE6;
        Thu, 17 Oct 2019 07:12:09 +0000 (UTC)
Received: from localhost (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 873DF100727A;
        Thu, 17 Oct 2019 07:12:08 +0000 (UTC)
Date:   Thu, 17 Oct 2019 16:12:07 +0900 (JST)
Message-Id: <20191017.161207.933364885524667574.yamato@redhat.com>
To:     sds@tycho.nsa.gov
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 0/5] dispol: add batch execution mode
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <795edc71-bcd9-99b8-30e4-b108b00b0b34@tycho.nsa.gov>
References: <20191008064500.8651-1-yamato@redhat.com>
        <6065d682-8226-ebd3-ede2-3a8ddab3ba4f@tycho.nsa.gov>
        <795edc71-bcd9-99b8-30e4-b108b00b0b34@tycho.nsa.gov>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 17 Oct 2019 07:12:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 17 Oct 2019 07:12:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 8 Oct 2019 10:31:37 -0400, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/8/19 8:48 AM, Stephen Smalley wrote:
>> On 10/8/19 2:44 AM, Masatake YAMATO wrote:
>>> dispol command requires interaction, and is not suitable for using
>>> in a script. This patch set introduces -b that is for running
>>> dispol in non-interactively.
>>>
>>> An example:
>>>
>>>      $ ./dispol -b 1 /sys/fs/selinux/policy
>>>      allow deltacloudd_log_t tmp_t : filesystem { associate };
>>>      allow kern_unconfined sysctl_type : lnk_file { ioctl read ...
>> What is your intended use case for this support, i.e. how do you
>> envision using dispol in scripts?
>> If you just want to decompile policy, I'd recommend using checkpolicy
>> -F/--conf or checkpolicy -c/--cil, ala:
>> checkpolicy -M -b /sys/fs/selinux/policy -F -o policy.conf
>> or
>> checkpolicy -M -b /sys/fs/selinux/policy -C -o policy.cil
> 
> Or you could just use sesearch -A if you wanted to just dump all allow
> rules, for example, or seinfo -b for all booleans, ...
> 
> dispol/dismod have always just been test/debug/developer utilities and
> predated the ability to decompile policies with checkpolicy, so I'm
> not sure if they are even still useful to keep around.  Is anyone
> still using them?

Thank you for the comment.

I didn't know that checkpolicy can be used for decompiling policies.  I
read checkpolicy.8, and I found what I want is the way to write
decompiled policies to standard output. So I can read the result with
less command, or filter with grep. I frequently do the similar with
objdump. I would like to withdraw the patches about dispol.

Instead, I proposed '-o -' for writing decompiled policies to standard
output in another mail-thread. Could you review the proposal?

Masatake YAMATO

>> 
>>>      ...
>>>
>>> Masatake YAMATO (5):
>>>    dispol: extend usage() to take exit status
>>>    dispol: add an option for printing the command usage
>>>    dispol: introduce a local variable representing the input file
>>>    dispol: introduce -b option to run commands in batch
>>>    dispol: add the list of commands for batch mode to help message
>>>
>>>   checkpolicy/test/dispol.c | 96
>>> ++++++++++++++++++++++++++++-----------
>>>   1 file changed, 69 insertions(+), 27 deletions(-)
>>>
>> 
> 
