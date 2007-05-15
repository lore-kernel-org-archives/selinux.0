Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4FBMuOh015331
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 07:22:56 -0400
Received: from extu-mxob-2.symantec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4FBMtxl006154
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 11:22:55 GMT
Message-ID: <46499808.9030001@symantec.com>
Date: Tue, 15 May 2007 12:22:48 +0100
From: Keith Holder <keith_holder@symantec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux@tycho.nsa.gov
Subject: Re: non-standard filesystem support in SELinux
References: <Line.LNX.4.64.0705111811230.25709@d.namei> <1178924793.11405.30.camel@localhost.localdomain> <46497E5B.7060103@symantec.com> <464995FE.1070807@manicmethod.com>
In-Reply-To: <464995FE.1070807@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Keith Holder wrote:
>>
>> A quick question on loadable policy modules.
>>
>> Are there any plans to allow 3rd party filesystem support,
>> without having to edit/recompile the base policy module?
>>
>>     keith
> 
> I don't think we've ever thought about it, it seems like something that 
> is very uncommon. I suppose its something we could do when we rewrite 
> the compiler to use the new representation but it won't be high on the 
> list of priorities. To be clear, what kind of support are you looking 
> for? fs_use_* support or genfs support?

Mostly fs_use_* so that the filesystem, mount points and
underlying files don't end up with the unlabeled_t type as
the default.


	keith

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
