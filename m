Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4RGRMGN020181
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 12:27:22 -0400
Received: from smtp1.bt.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4RGRYwO028226
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 16:27:34 GMT
Message-ID: <4A1D6968.5060005@btconnect.com>
Date: Wed, 27 May 2009 17:25:12 +0100
From: Nigel Rumens <wooky@btconnect.com>
MIME-Version: 1.0
To: Mark Webb <elihusmails@gmail.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and sctp
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com>	 <4A1A96BD.5050500@btconnect.com> <9f066ee90905251718j1b4f9942ndc7ef7058886017@mail.gmail.com>
In-Reply-To: <9f066ee90905251718j1b4f9942ndc7ef7058886017@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First let me apologise for my tardiness in replying but I am ill at the 
moment. But it was really nice to get see all the helpful replies in my 
mailbox when I finally got around to looking at it. Thanks everyone.

As soon as I manage to create something I will certianly post it.

On 05/26/2009 01:18 AM, Mark Webb wrote:
> You are not an idiot at all.  I would like to see the policy posted
> here and others can work to refine it.  You might get a more relaxed
> policy using audit2allow than you would like, but its certainly a good
> start.
>
> I would suggest using SLIDE from Tresys and develop a policy from
> scratch to better learn policy development.
>
> ...just my 2 cents
> Mark
>
>
> On Mon, May 25, 2009 at 9:01 AM, Nigel Rumens<wooky@btconnect.com>  wrote:
>    
>> Thanks. I will do just that.
>>
>> In the meantime though would it be possible to create a local policy module
>> to allow this access? (with audit2allow?) Maybe even limiting it to just a
>> particular set of processes by creating a new label and labeling the
>> relevant executables?
>>
>> Feel free to call me an idiot if you think I am being one. I am pretty new
>> to selinux.
>>
>> On 05/25/2009 12:16 PM, Daniel J Walsh wrote:
>>      
>>> On 05/24/2009 06:00 AM, Nigel Rumens wrote:
>>>        
>>>> Hi,
>>>>
>>>> Does selinux understand sctp?
>>>>
>>>> When I run (for example)
>>>>
>>>> sctp_darn -H 0 -P 9876 -l
>>>>
>>>> It results in an avc denial message which tells me the target object is
>>>> of type None[rawip_socket]
>>>>
>>>> Also semanage port -l shows only udp and tcp
>>>>
>>>> Machine tested on was F11 (fully updated) - I also tried it F10 with the
>>>> same results
>>>>
>>>> Thanks
>>>> wooky
>>>>
>>>> --
>>>> fedora-selinux-list mailing list
>>>> fedora-selinux-list@redhat.com
>>>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>>>>          
>>> Well it treats it as a rawip, I am not that familiar with the sctp
>>> protocol, if you believe we should do more to handle it you probably need to
>>> discuss with the SELinux developers on the SELinux developers mail list
>>>
>>> selinux@tycho.nsa.gov
>>>
>>> http://www.nsa.gov/research/selinux/subscribe.shtml
>>>        
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>>      


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
