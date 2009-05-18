Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IFUaut003898
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 11:30:36 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IFUWnR011255
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 15:30:32 GMT
Message-ID: <4A117F1A.6050605@manicmethod.com>
Date: Mon, 18 May 2009 11:30:34 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Hiroshi Shinji <hiroshi.shinji@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Memory leak in libselinux/src/label_file.c
References: <C628ACBB.A6FA6%csellers@tresys.com>
In-Reply-To: <C628ACBB.A6FA6%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 4/3/09 12:58 AM, "Hiroshi Shinji" <hiroshi.shinji@gmail.com> wrote:
> 
>> Hi,
>>
>> I found memory leak in libselinux/src/label_file.c.
>> Please fix it.
>>
>> Regards,
> 
> This looks good to me.
> 
> Acked-by: Chad Sellers <csellers@tresys.com>
> 

Merged in libselinux-2.0.81


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
