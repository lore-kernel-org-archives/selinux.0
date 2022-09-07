Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F09C6FA83
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 00:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIGALL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Sep 2022 20:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGALK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Sep 2022 20:11:10 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95E7C518;
        Tue,  6 Sep 2022 17:10:59 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9236341591;
        Wed,  7 Sep 2022 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662509458;
        bh=MoBWpN9pxmqpAgZALUWWNh2b6ZrdM6dPuk3KZQ9M+WY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SvP06AdfJlhsMTjtbb7/ycUvqF0bwMUFLOtHIwibfsqHvfilhUyqeKv/47b6HBvAG
         G3Lb64l8uwSqRIM/EQQXM3hLO7z7SIyxe+Qhy+h1nZZV7vxwi6VEdQKrwG8Fi+vFYm
         M+kAn0P5kknd67RofA/rFiMFLj7y47rtAhjGgd56cNaduGibxZIPzTMOmaZsUXvUIG
         49DzoGGUyhTUvCyOpxWIH0f7BZB2UgnjZ3BSeFFiF8SiI1QxEMKxr2iUnNDI6/ksoa
         dmXb44GrMuckt4UPr3OXSXZEqwdSNTkHNGJv4kh4UmZ5OrsBjuW5ZEvLbV1r/gqIwb
         W5+kvS6VmwSqQ==
Message-ID: <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
Date:   Tue, 6 Sep 2022 17:10:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sorry I am wayyyy behind on this, so starting from here

On 9/6/22 16:24, Paul Moore wrote:
> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/2/2022 2:30 PM, Paul Moore wrote:
>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>>>>> patch set in the LSM next branch for 6.1. The audit changes have polished
>>>>> up nicely and I believe that all comments on the integrity code have been
>>>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>>>>> There are serious binder changes, but I think they address issues beyond
>>>>> the needs of stacking. Changes outside these areas are pretty well limited
>>>>> to LSM interface improvements.
>>>>
>>>> The LSM stacking patches are near the very top of my list to review
>>>> once the merge window clears, the io_uring fixes are in (bug fix), and
>>>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
>>>> and SCTP stuff can be finished up in the next week or two.
>>>>
>>>> Since I'm the designated first stuckee now for the stacking stuff I
>>>> want to go back through everything with fresh eyes, which probably
>>>> isn't a bad idea since it has been a while since I looked at the full
>>>> patchset from bottom to top.  I can tell you that I've never been
>>>> really excited about the /proc changes, and believe it or not I've
>>>> been thinking about those a fair amount since James asked me to start
>>>> maintaining the LSM.  I don't want to get into any detail until I've
>>>> had a chance to look over everything again, but just a heads-up that
>>>> I'm not too excited about those bits.
>>>
>>> As I mentioned above, I don't really like the stuff that one has to do
>>> to support LSM stacking on the existing /proc interfaces, the
>>> "label1\0label2\labelN\0" hack is probably the best (only?) option we
>>> have for retrofitting multiple LSMs into those interfaces and I think
>>> we can all agree it's not a great API.  Considering that applications
>>> that wish to become simultaneous multi-LSM aware are going to need
>>> modification anyway, let's take a step back and see if we can do this
>>> with a more sensible API.
>>
>> This is a compound problem. Some applications, including systemd and dbus,
>> will require modification to completely support multiple concurrent LSMs
>> in the long term. This will certainly be the case should someone be wild
>> and crazy enough to use Smack and SELinux together. Even with the (Smack or
>> SELinux) and AppArmor case the ps(1) command should be educated about the
>> possibility of multiple "current" values. However, in a container world,
>> where an Android container can run on an Ubuntu system, the presence of
>> AppArmor on the base system is completely uninteresting to the SELinux
>> aware applications in the container. This is a real use case.
> 
> If you are running AppArmor on the host system and SELinux in a
> container you are likely going to have some *very* bizarre behavior as
> the SELinux policy you load in the container will apply to the entire
> system, including processes which started *before* the SELinux policy
> was loaded.  While I understand the point you are trying to make, I
> don't believe the example you chose is going to work without a lot of
> other changes.
>
correct but the reverse does work. Where SELinux is running on the host
and AppArmor in the container. Obviously that is the simplified version
AppArmor is running on the host too but unconfined, has setup a policy
namespace for the container and is self stacking (bounding).

> Regardless of the above example, I want to be clear that I'm not
> suggesting changes to the /proc interfaces.  Existing LSM aware
> applications that use procfs for information would continue to work as
> expected, it would just be the simul-multi-LSM aware applications that
> would need to transition to the new syscall API to get all of the LSM
> labels.
> 

I can live with that. AppArmor and Smack have already landed private
interfaces and prefer them over the shared interface if they are
available.

>>> I think it's time to think about a proper set of LSM syscalls.
>>
>> At the very least we need a liblsm that preforms a number of useful
>> functions, like identifying what security modules are available,
>> validating "contexts", fetching "contexts" from files and processes
>> and that sort of thing. Whether it is built on syscalls or /proc and
>> getxattr() is a matter of debate and taste.
> 
> Why is it a forgone conclusion that a library would be necessary for
> basic operations?  If the kernel/userspace API is sane to begin with
> we could probably either significantly reduce or eliminate the need
> for additional libraries.  I really want us to attempt to come up with
> a decent kernel/userspace API to begin with as opposed to using the
> excuse of a userspace library to hide API sins that never should have
> been committed.
> 
I don't think its a foregone conclusion, its just that it has been
discussed several times, and all the interfaces have been nasty and
prebaked userspace code would be really nice to have.

There are other reasons to use a lib as well. Libs can help apps
pickup fixes/changes automatically.

> The LSM stacking work presents us with a unique opportunity to
> modify/update/whatever the LSM kernel/userspace API, I don't want to
> see us squander this chance on a hack.
> 

I do wish we had a better API from the beginning. I just hope it isn't
going to take another 10 years to get the API portion done.

>>> While I realize syscalls are not the only kernel/userspace API option,
>>> but given the popularity of namespaces I believe a syscall based
>>> kernel/userspace LSM API has a number of advantages over the other
>>> options, e.g. procfs/sysfs, netlink, etc.
>>
>> You can't script syscalls.
> 
> True.  However I don't see that as a blocker, trivial helper
> applications can be written for those who wish to incorporate the new
> syscall-based API into their scripts.  We would not be the first (or
> the last) in this regard.
> 
>> A syscall interface is fine if you can also
>> update the entire system service application base for your distribution.
>> I don't see that as an option.
> 
> Once again, I'm not talking about removing the existing procfs
> interface; existing applications would continue to work.  Only
> applications which wanted to be simul-multi-LSM aware would need to be
> modified, and those applications would need to be modified regardless
> of if the procfs or syscall-based API was used.
> 
>>> Further, I think we can add the new syscall API separately from the
>>> LSM stacking changes as they do have standalone value.
>>
>> I agree, but unless the new system calls take stacking into account
>> from their inception they're just going to be another interface that
>> makes stacking harder to accomplish.
> 
> They obviously would Casey, not only is that the context of the
> discussion but my dummy example clearly had support for multiple LSMs.
> 
>>>    This would
>>> help reduce the size and complexity of the stacking patchset, which I
>>> believe would be a very good thing.
>>
>> The /proc interfaces interface_lsm and context are really pretty simple.
> 
> They are now, they are also a bit of a mess with legacy constraints
> and they only get more complicated and messy with the LSM stacking
> patches.  It is my opinion that a syscall-based API is cleaner and
> easier for applications to use.
> 

potentially if we can get one

>> The addition of multiple subject labels to audit would be the same regardless
>> of /proc or syscall interfaces.
> 
> Yes, that's why I didn't bring up audit as it doesn't weigh on this
> decision.  If you really want to include audit for some reason, I'll
> simply remind you that I pushed back hard on overloading the existing
> subj/obj fields with a multiplexed label format, asking for individual
> subj/obj fields for each LSM.
> 

how can I forget, what a pita :)

>> We'd still need multiple LSM data in most
>> security blobs. The conversion of LSM hook interfaces from secids to lsmblobs
>> would still be required. As would the conversion from string+len pairs to
>> lsmcontext structures.
> 
> I'm not talking about kernel internal data structures Casey, I'm
> talking about the kernel/userspace API.
> 
>>> Introducing the syscall API
>>> sooner would also allow any applications wanting to make use of the
>>> crazy new stacked-LSM world a head start as they could be modified
>>> while the kernel patches were making their way through the
>>> review/update/merge/release process.
>>
>> A liblsm based on the /proc interfaces would address that as well.
> 
> Perhaps a liblsm library would be useful for other reasons beyond this
> discussion, but I don't want to use a userspace library as an excuse
> to support an awful kernel/userspace API.
> 
>>> Thoughts?
>>
>> I wish you'd suggested this three years ago, when I could have done
>> something with it. If stacking has to go on a two year redesign because
>> of this it is dead.
> 
> I've never liked the combined label interfaces, see the mention of
> audit in this email above.  I'm sure if you wanted to dig through all
> of the mail archives I'm sure I've probably mentioned my dislike of
> the combined label interface in procfs too; if not on the mailing list
> then surely in-person at some point.  However, regardless of all that,
> the key difference is that prior to a few months ago I didn't have to
> worry about it quite as much as I do now.  Now I'm responsible for
> standing up for the code that goes into the LSM tree and that means
> both defending it as "good" and maintaining it long term; prior to a
> few months ago that was, politely, "not my problem" :)
> 
> I can't currently in good conscience defend the kernel/userspace
> combined label interfaces as "good", especially when we have a very
> rare opportunity to do better.
> 

so I am going to grab and hold onto
>>> Further, I think we can add the new syscall API separately from the
>>> LSM stacking changes as they do have standalone value.
>>

what I think Paul is saying is we can move the LSM stacking patches
forward by removing the combined label interface. They won't be as
useful but it would be a huge step forward, and the next step could
be the syscall API.
