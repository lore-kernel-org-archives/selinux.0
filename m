Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1BKRYP7015363
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2011 15:27:34 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p1BKRWf3027875
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2011 20:27:32 GMT
Message-ID: <4D559BA6.8020506@tresys.com>
Date: Fri, 11 Feb 2011 15:27:18 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: SELinux-NSA <selinux@tycho.nsa.gov>, Kohei KaiGai <kaigai@kaigai.gr.jp>
Subject: Re: libselinux: add selinux_status_* interfaces for /selinux/status
References: <AANLkTi=WqUp8FFkqo7eooUUP7qLju=WQQyf6qWsd1+4E@mail.gmail.com> <4D40C42A.2080903@ak.jp.nec.com>
In-Reply-To: <4D40C42A.2080903@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/26/2011 08:02 PM, KaiGai Kohei wrote:
> I updated my patch to reference /selinux/status entry.
> 
> The interface of selinux_status_open() and selinux_status_updated() was
> revised to eliminate an argument of 'last_seqlock' that holds a sequence
> value when we call this function last time.
> At first, I tried to give this storage externally for thread-safing, but
> fallback routine was not thread-safe anyway, so it became nonsense.
> 
> The attached status.c is an example program to call these APIs.
> 
> Any comments please. Thanks,
> 
> (2011/01/22 22:42), Kohei KaiGai wrote:
>> The attached patch adds several interfaces to reference /selinux/status
>> according to sequential-lock logic.
>>
>> selinux_status_open() open the kernel status page and mmap it with
>> read-only mode, or open netlink socket as a fallback in older kernels.
>>
>> Then, we can obtain status information from the mmap'ed page using
>> selinux_status_updated(), selinux_status_getenfoce(),
>> selinux_status_policyload() or selinux_status_deny_unknown().
>>
>> It enables to help to implement userspace avc with heavy access control
>> decision; that we cannot ignore the cost to communicate with kernel for
>> validation of userspace caches.
>>
>> Thanks,

The patch looks okay to me, but I'm seeing unexpected behavior with the
selinux_status_policyload(). For example, when running your sample
status.c code, I get the following (I'm just calling load_policy after
each line is printed):

   # ./status
   -- selinux kernel status page --
   policyload = 0, enforcing = 1, deny_unknown = 0
   policyload = 2, enforcing = 1, deny_unknown = 0
   policyload = 3, enforcing = 1, deny_unknown = 0
   policyload = 4, enforcing = 1, deny_unknown = 0

policyload jumps from 0 to 2 when reloading policy the first time, but
all other policy loads after that are incremented by 1, as expected. And
it doesn't matter if it's using mmap or falls back to netlink. Same
behavior in both cases.

It doesn't look like the problem is in this patch, so I'm guessing this
is a problem in the kernel? Or am I missing something and this is the
correct behavior?

- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
