Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4FBYTBj015942
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 07:34:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4FBYSdK000691
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 11:34:29 GMT
Message-ID: <46499AB6.2070109@manicmethod.com>
Date: Tue, 15 May 2007 07:34:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Keith Holder <keith_holder@symantec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: non-standard filesystem support in SELinux
References: <Line.LNX.4.64.0705111811230.25709@d.namei> <1178924793.11405.30.camel@localhost.localdomain> <46497E5B.7060103@symantec.com> <464995FE.1070807@manicmethod.com> <46499808.9030001@symantec.com>
In-Reply-To: <46499808.9030001@symantec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Keith Holder wrote:
> Joshua Brindle wrote:
>> Keith Holder wrote:
>>>
>>> A quick question on loadable policy modules.
>>>
>>> Are there any plans to allow 3rd party filesystem support,
>>> without having to edit/recompile the base policy module?
>>>
>>>     keith
>>
>> I don't think we've ever thought about it, it seems like something 
>> that is very uncommon. I suppose its something we could do when we 
>> rewrite the compiler to use the new representation but it won't be 
>> high on the list of priorities. To be clear, what kind of support are 
>> you looking for? fs_use_* support or genfs support?
>
> Mostly fs_use_* so that the filesystem, mount points and
> underlying files don't end up with the unlabeled_t type as
> the default.
>
Is there a reason you can't use the context mount option to label the 
mountpoint and its underlying files?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
