Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IFWqeB004444
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 11:32:52 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IFWxVb018870
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 15:32:59 GMT
Message-ID: <4A117FA2.1080904@manicmethod.com>
Date: Mon, 18 May 2009 11:32:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: We have moved matchpathcon to /sbin from /usr/sbin
References: <C628B75D.A6FB2%csellers@tresys.com>
In-Reply-To: <C628B75D.A6FB2%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 4/1/09 10:21 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> Some init scripts wanted to use matchpathcon before /usr is mounted.
> 
> Looks fine except for adding the now split out matchpathcon to the clean
> target. I'll fix that in the merge.
> 
> Acked-by: Chad Sellers <csellers@tresys.com>
> 

Merged in libselinux-2.0.81

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
