Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0088C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 00:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIHATj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiIHATh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 20:19:37 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F213F86;
        Wed,  7 Sep 2022 17:19:33 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D564E41614;
        Thu,  8 Sep 2022 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662596371;
        bh=ZY9oqUOVK7k6aK++sEuvpaK/9V3mh4oAgwVSTOc+lqg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UaTEMe/g+awYQ3sawUwavuDv8ltUcwhHH6DPCd+UDbCKOboZlYOSwa6wX0BrE70Nd
         oFDE8lFTRHbLip5/Liw9n48tY8972aWyP7fYVQHcge/Hb+mH0lK8TZOjHMaev5jxbZ
         LzLbzQdG9vqPzEJTnaD6gG3IwiD9jFv2lUQXLDX8AqFmXiY44rVTPbH2h95qpvNWCI
         GNLfqUVrpQJT38hRFDfl+rIFt98hWjfiX8J+8kDMPOy7EsittdYua19ruXVrYi2uC1
         w9n4MIO0nKoohR7dhBzP2lwJass9R/i+c9sEl+jKFLlrUZUuSQ5Afw27uMcHRfMHxl
         jTgOkzaoIaGSQ==
Message-ID: <8a013c40-83af-9347-c395-6a95a3c091ed@canonical.com>
Date:   Wed, 7 Sep 2022 17:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/22 16:53, Casey Schaufler wrote:
> On 9/7/2022 4:27 PM, Paul Moore wrote:
>> On Wed, Sep 7, 2022 at 12:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/7/2022 7:41 AM, Paul Moore wrote:
>>>> On Tue, Sep 6, 2022 at 8:10 PM John Johansen
>>>> <john.johansen@canonical.com> wrote:
>>>>> On 9/6/22 16:24, Paul Moore wrote:
>>>>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>>>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> ..
>>>>
>>>>>> If you are running AppArmor on the host system and SELinux in a
>>>>>> container you are likely going to have some *very* bizarre behavior as
>>>>>> the SELinux policy you load in the container will apply to the entire
>>>>>> system, including processes which started *before* the SELinux policy
>>>>>> was loaded.  While I understand the point you are trying to make, I
>>>>>> don't believe the example you chose is going to work without a lot of
>>>>>> other changes.
>>>>> correct but the reverse does work ...
>>>> Sure, that doesn't surprise me, but that isn't the example Casey brought up.
>>> I said that I'm not sure how they go about doing Android on Ubuntu.
>>> I brought it up because I've seen it.
>> Addressed in the other portion of this thread, but the quick response
>> here is: No, you were mistaken, that was not proper Android, SELinux
>> was disabled.
>>
>>>> I'm sympathetic that this
>>>> work has been going on for some time, but that is no reason to push
>>>> through a bad design; look at the ACKs/reviews on the combined-label
>>>> patches vs the others in the series, that's a pretty good indication
>>>> that no one is really excited about that design.
>>> The kernel developers aren't the consumers of these APIs. There
>>> has been considerable feedback from system application developers
>>> on the interfaces. This included dbus and systemd. Kernel developers
>>> aren't interested in these APIs because they don't care one way or
>>> the other. That, and as you are painfully aware, some of them are
>>> really busy on their own projects.
>> Yes, everyone is busy yet they found time to ACK/review the other
>> patches in the patchset.  I'm not buying the "busy" argument here.
>>
>> Yes, you are also correct in that the kernel devs are not likely to be
>> the main consumers of any kernel/userspace API, but we do have to
>> support these APIs and find ways to handle the inevitable misuse and
>> abuse of these APIs.  Further, while I do believe that you've talked
>> to some application developers about the current proposed API, I'm
>> reasonably confident that it isn't the only API they would be happy
>> supporting in their applications.
>>
>> As far as kernel developers not being interested in these APIs, I
>> think the recent conversation in this thread proves the exact opposite
>> ;)
>>
>>> Am I really happy with the "hideous" format? Yeah, because it makes
>>> the end user happy. Am I happy with interface_lsm? Other than the
>>> name, which was the result of feedback, yes, because it in the
>>> simplest way to accomplish the goal.
>>>
>>> I am curious about what you think is "bad" about the current design.
>>> The interfaces aren't exciting. They don't need to be.
>> I don't even know what an exciting interface would look like ... ?
> 
> io_uring? :)
> 
>>    I
>> just want an interface that is clearly defined, has reasonable
>> capacity to be extended in the future as needed, and is easy(ish) to
>> use and support over extended periods of time (both from a kernel and
>> userspace perspective).
>>
>> The "smack_label\0apparmor_label\0selinux_label\0future_lsm_label\0"
>> string interface is none of these things.
> 
> In this we disagree ....
> 
>>    It is not clearly defined
>> as it requires other interfaces to associate the labels with the
>> correct LSMs.
> 
> The label follows the lsm name directly. What other association is required?
> 
its a serialized message format, with all the data in the message
instead of pointer to external memory. If you want nicer to handle
you wrap a lib around it, this is pretty common. That is why I don't
see it as that different from the syscall.

>>    It has no provision for extension beyond adding a new
>> LSM.
> 
> I grant that. But the purpose of the format is to present LSM/context
> pairs. What other information would make sense? We could add an "aux"
> field, but that seems somewhat arbitrary.
> 
or you know a header that gives potential future, also potentially a
count, ...

>>    The ease-of-use quality is a bit subjective, but it does need
>> another interface to use properly and it requires string parsing which
>> history has shown to be an issue time and time again (although it is
>> relatively simple here).
> 
> There was a lot of discussion regarding that. My proposed
> apparmor="unconfined",smack="User" format was panned for those same reasons.
> The nil byte format has been used elsewhere and suggested for that reason.
> 

At this level the lib provides the ease of use, but I think that is
what we are going to need with a syscall too, as marshalling variable
number/length data is always somewhat ugly.

>>
>> Once again, the syscall example I tossed out was a quick strawman, but
>> it had clearly separated and defined labels conveyed in data
>> structures that didn't require string parsing to find the label
>> associated with an LSM.
> 
> True, but it uses pointers internally and you can't do that in memory
> you're sending up from the system. What comes from the syscall has to

Well you can, see the mess that is ioctl. The point being those internal
pointers are going to have to be mapped/copied and doing that is a mess
as well. Either way you want a common set of code to handle it. The
advantage of the syscall, from a userspace perspective, is that all the
code to handle the mapping is in the kernel.

The problem from kernel perspective is that multiple copies to/from
userspace have races. You have to make sure you have marshalled/setup
all the data before you can do anything with it.

> look something like the nil byte format. The strawman would have to do
> the same sort of parsing in userspace that you are objecting to.
> 
Not necessarily the nil byte format, but yeah it all has to be setup
nicely in advance.

>>    It was also self-contained in that no other
>> interface was needed to interpret the results of the syscall (well,
>> beyond the header file definitions I guess).  Finally, it made use of
>> flags and "reserved for future use" token values to allow for
>> additional data to be conveyed in the future.
> 
> Can you describe potential flags or additional data? Planning for the future
> is a good idea, but throwing fields on "just in case" seems contrary to
> what I'm used to hearing from you.
> 

Well a few potential ones I can think of
version - providing future flexibility
count - for how many lsm entries to expect
size - I don't think its really necessary here but in a message format it is
        usually good to have a size of message value.
kind - some flags indicating the type of data. Eg. LSM name, LSM context pair
table - not necessary unless we want to get rid of the \0 separator so
         that \0 could be allowed as value within the data, an index into
         the message for each LSMs
         data.

At this point I don't really care if its a syscall or a serialized message.
I see them as roughly equivalent, its just a matter of where you are going to
put the ugly.
