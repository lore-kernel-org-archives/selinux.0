Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA75C43461
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1820E65
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OshSHgjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgINPoi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:44:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51010 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgINPoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 11:44:24 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 60931209F313;
        Mon, 14 Sep 2020 08:44:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60931209F313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600098259;
        bh=9TRDw6jMv96lE08DLfg6UxAHsKefJ3mjRz2VnoaiiAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OshSHgjULDvLv2a+nDkSt+CmNMlJp2WNu71uUJsmUeY0axXh4NPvOEV7UDQQC9r5x
         RS5wM9Iej/uvtJyVlENimG+svhCXcNQMHUFMjsudLt8tNa+FePyBlLPREmuvGHAgHQ
         qVTTQ08c4vTPfSnn9dfMDe8vDF3vmbc3cz2KPWpg=
Subject: Re: [PATCH v3] selinux: Add helper functions to get and set
 checkreqprot
To:     Paul Moore <paul@paul-moore.com>
Cc:     Sasha Levin <sashal@kernel.org>, James Morris <jmorris@namei.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
References: <20200911164009.21926-1-nramas@linux.microsoft.com>
 <CAEjxPJ4JCRkiSnDq=HZjk2pLj0m2ayYTeEvQ2jevMd=yLMoXhg@mail.gmail.com>
 <CAHC9VhQDYe1TQCG7waTEUxUhSzLHrqJGTG-OAQrgvR6E-iwEgQ@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <cc8286f7-84cf-8a53-4b3d-f642de49dd1a@linux.microsoft.com>
Date:   Mon, 14 Sep 2020 08:44:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQDYe1TQCG7waTEUxUhSzLHrqJGTG-OAQrgvR6E-iwEgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/14/20 8:04 AM, Paul Moore wrote:
> On Mon, Sep 14, 2020 at 9:25 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Fri, Sep 11, 2020 at 12:40 PM Lakshmi Ramasubramanian
>> <nramas@linux.microsoft.com> wrote:
>>>
>>> checkreqprot data member in selinux_state struct is accessed directly by
>>> SELinux functions to get and set. This could cause unexpected read or
>>> write access to this data member due to compiler optimizations and/or
>>> compiler's reordering of access to this field.
>>>
>>> Add helper functions to get and set checkreqprot data member in
>>> selinux_state struct. These helper functions use READ_ONCE and
>>> WRITE_ONCE macros to ensure atomic read or write of memory for
>>> this data member.
>>>
>>> Rename enforcing_enabled() to enforcing_get() to be consistent
>>> with the corresponding set function name.
>>
>> I thought Paul said to only use the new names for checkreqprot_*() and
>> not to touch enforcing_*()?  I don't really care either way about the
>> names but usually we wouldn't mix renaming of something else with the
>> introduction of these new helpers in a single patch.
> 
> It's generally a good idea when someone has provided feedback on a
> patch to limit the changes in the next revision to just those changes
> which have been suggested.  It helps to keep the patch focused on the
> original issue, makes the follow-up reviews easier, and shortens the
> develop/reverge/merge cycle.  It generally isn't too bad of a problem
> in the SELinux code, but there are other subsystems where several
> large patch revisions have been wasted because the patch author lost
> focus and started making additional changes outside the scope of the
> comments.  If you want to submit the additional changes anyway, my
> recommendation would be to split them out into a second patch in a
> patch series (make sure the original patch is first!).

Sorry about that - I will resubmit the patch with the change to rename 
only checkreqprot helper function.

  -lakshmi

> 
> Of course the best solution is always to ask if you are unsure :)
> While I don't check my upstream email quite as often as some folks
> here, I promise to respond to any follow-up questions if no one
> answers first.
> 
> ... and please don't let our small nitpicks discourage you from
> submitting patches, we really do appreciate help and contributions :)
> 
>> FWIW, looking at the history, the enforcing functions were originally
>> named is_enforcing() and set_enforcing() in aa8e712cee93d520e96a2ca8
>> ("selinux: wrap global selinux state") .  Then Paul renamed them to
>> enforcing_enabled() and enforcing_set() in e5a5ca96a42ca7eee19cf869
>> ("selinux: rename the {is,set}_enforcing() functions").
> 

