Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4Q0Iqek023802
	for <selinux@tycho.nsa.gov>; Mon, 25 May 2009 20:18:52 -0400
Received: from mail-fx0-f212.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4Q0Ilgn004459
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 00:18:47 GMT
Received: by fxm8 with SMTP id 8so4089196fxm.18
        for <selinux@tycho.nsa.gov>; Mon, 25 May 2009 17:18:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1A96BD.5050500@btconnect.com>
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com>
	 <4A1A96BD.5050500@btconnect.com>
Date: Mon, 25 May 2009 20:18:50 -0400
Message-ID: <9f066ee90905251718j1b4f9942ndc7ef7058886017@mail.gmail.com>
Subject: Re: selinux and sctp
From: Mark Webb <elihusmails@gmail.com>
To: Nigel Rumens <wooky@btconnect.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You are not an idiot at all.  I would like to see the policy posted
here and others can work to refine it.  You might get a more relaxed
policy using audit2allow than you would like, but its certainly a good
start.

I would suggest using SLIDE from Tresys and develop a policy from
scratch to better learn policy development.

...just my 2 cents
Mark


On Mon, May 25, 2009 at 9:01 AM, Nigel Rumens <wooky@btconnect.com> wrote:
> Thanks. I will do just that.
>
> In the meantime though would it be possible to create a local policy module
> to allow this access? (with audit2allow?) Maybe even limiting it to just a
> particular set of processes by creating a new label and labeling the
> relevant executables?
>
> Feel free to call me an idiot if you think I am being one. I am pretty new
> to selinux.
>
> On 05/25/2009 12:16 PM, Daniel J Walsh wrote:
>>
>> On 05/24/2009 06:00 AM, Nigel Rumens wrote:
>>>
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
>>
>> Well it treats it as a rawip, I am not that familiar with the sctp
>> protocol, if you believe we should do more to handle it you probably need to
>> discuss with the SELinux developers on the SELinux developers mail list
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
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
