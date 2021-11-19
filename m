Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DBC433F5
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 23:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhKTACu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 19:02:50 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:43370
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231958AbhKTACu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 19:02:50 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 30F023FFE1;
        Fri, 19 Nov 2021 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637366383;
        bh=v0xhfNNI1TXNCOgDubAg2K+hFSI60OHMAMx8z34+9Vw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ne9FT2+K9NnJUyBwoGLrgUJaamwOSLnWM9m8+751tnXkg/ZBpfW3D5U49x9W3w5Jn
         wizDRb7S4RZJ1zUxUJTvvM15XCO2lMBd7OFhSjR41mBmkaKMSEUUahi9oPG5v2BZba
         LpDDnfWa/RMLrpZj+7BfFZIejSFXpN+kfYYcL02hcC+9E1gbXX9f5+L3/RUqt5vTDG
         yZZ9sRtAuwMnfuG1cLv7/sHr+b1pJizgf7c2paoujA0S1R36aTGj97oLnv5T5Tqspf
         S23A5E2NfsBIx5N+BgfrNDCk3luVoOvbQcZZx0rlRmPA62YehEOuIM9n6n7tUFv3o4
         0lDnWf9OR7lAg==
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() ->
 security_current_getsecid_subj()
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
 <20211119232305.GA32613@mail.hallyn.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <aeb3a040-b1b2-f6dc-6744-4e9d1979e351@canonical.com>
Date:   Fri, 19 Nov 2021 15:59:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119232305.GA32613@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/19/21 3:23 PM, Serge E. Hallyn wrote:
> On Fri, Nov 19, 2021 at 05:52:33PM -0500, Paul Moore wrote:
>> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
>>>
>>> The security_task_getsecid_subj() LSM hook invites misuse by allowing
>>> callers to specify a task even though the hook is only safe when the
>>> current task is referenced.  Fix this by removing the task_struct
>>> argument to the hook, requiring LSM implementations to use the
>>> current task.  While we are changing the hook declaration we also
>>> rename the function to security_current_getsecid_subj() in an effort
>>> to reinforce that the hook captures the subjective credentials of the
>>> current task and not an arbitrary task on the system.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> Makes perfect sense given the motivation of 4ebd7651b  :)
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> Oh, actually, one question below (cc:ing John explicitly)
> 

<< snip >>

>>> -static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
>>> +static void apparmor_current_getsecid_subj(u32 *secid)
>>> +{
>>> +       struct aa_label *label = aa_get_task_label(current);
> 
> Should you use aa_get_current_label() here instead?
> 

yes, that would be better


