Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4QBd8wL011156
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 07:39:08 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4QBd2JO028375
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 11:39:03 GMT
Message-ID: <4A1BD4A9.9010608@redhat.com>
Date: Tue, 26 May 2009 07:38:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Nigel Rumens <wooky@btconnect.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and sctp
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com> <4A1A96BD.5050500@btconnect.com>
In-Reply-To: <4A1A96BD.5050500@btconnect.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/25/2009 09:01 AM, Nigel Rumens wrote:
> Thanks. I will do just that.
>
> In the meantime though would it be possible to create a local policy
> module to allow this access? (with audit2allow?) Maybe even limiting it
> to just a particular set of processes by creating a new label and
> labeling the relevant executables?
>
> Feel free to call me an idiot if you think I am being one. I am pretty
> new to selinux.
>
> On 05/25/2009 12:16 PM, Daniel J Walsh wrote:
>> On 05/24/2009 06:00 AM, Nigel Rumens wrote:
>>> Hi,
>>>
>>> Does selinux understand sctp?
>>>
>>> When I run (for example)
>>>
>>> sctp_darn -H 0 -P 9876 -l
>>>
>>> It results in an avc denial message which tells me the target object is
>>> of type None[rawip_socket]
>>>
>>> Also semanage port -l shows only udp and tcp
>>>
>>> Machine tested on was F11 (fully updated) - I also tried it F10 with the
>>> same results
>>>
>>> Thanks
>>> wooky
>>>
>>> --
>>> fedora-selinux-list mailing list
>>> fedora-selinux-list@redhat.com
>>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>> Well it treats it as a rawip, I am not that familiar with the sctp
>> protocol, if you believe we should do more to handle it you probably
>> need to discuss with the SELinux developers on the SELinux developers
>> mail list
>>
>> selinux@tycho.nsa.gov
>>
>> http://www.nsa.gov/research/selinux/subscribe.shtml
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Yes you can develop a policy for this tool using rawip sockets.  You use 
either slide or system-config-selinux/polgengui to build a policy for 
it.  With SELinux you can write policy for just about any process on the 
system.  The real problem is whether or not you can define your security 
goals, and whether or not the security goals make your system more 
secure.   Writing policy for emacs and saying it has to be able to 
read/write every file on the system, does not make sense to me.  Since 
the security goal is too broad.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
