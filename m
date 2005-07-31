Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6VEiFgA011680
	for <selinux@tycho.nsa.gov>; Sun, 31 Jul 2005 10:44:17 -0400 (EDT)
Received: from host.we-code.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6VEbvXP013971
	for <selinux@tycho.nsa.gov>; Sun, 31 Jul 2005 14:37:57 GMT
In-Reply-To: <D3543036-7457-4441-AF34-85B0756322C8@tobyjoe.com>
References: <D3543036-7457-4441-AF34-85B0756322C8@tobyjoe.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DD7A8E82-4804-4477-9527-AF057B449598@tobyjoe.com>
Cc: selinux@tycho.nsa.gov
From: Toby Boudreaux <selinux@tobyjoe.com>
Subject: Re: FastCGI and SELinux
Date: Sun, 31 Jul 2005 10:37:54 -0400
To: Toby Boudreaux <selinux@tobyjoe.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.
I think I may have sent this to the wrong list earlier this week.
Is there an SELinux list that focuses on usage versus core development?

I'm really eager to keep SELinux enabled on my Web servers, but  
mod_fastcgi is an important requirement. Without "avc" messages to  
give me a clue, I'm unable to figure this problem out.

Thanks for any info,
Toby Boudreaux


On Jul 28, 2005, at 12:06 PM, Toby Boudreaux wrote:

> Hello, everyone. This is my first post to the list.
>
> I'm running a CentOS 4 server with SELinux and have been having  
> problems getting Apache2 and mod_fastcgi to play nicely when  
> SELinux is enabled.
>
> I've run all "avc" messages through audit2allow and have modified  
> my local.te file and I've gotten the avc messages to disappear.
>
> Unfortunately, mod_fastcgi is still not working when SELinux is  
> enabled.
>
> I'm getting no messages, but when I turn off enforcing, mod_fastcgi  
> works perfectly.
>
> I've purchased the O'Reilly book and have read much of it, but I'm  
> still uncertain as to what the problem is and how to investigate/ 
> address it.
>
> The core problem seems to be that any FastCGI process doesn't write  
> data back to the IPC socket Apache is reading. Instead, it dumps  
> the entire response into STDERR.
>
> I gather by the lack of "avc" messages that there are no normal  
> domain/user conflicts.
>
> I've searched high and low and can't find mention of a way to get  
> this to work, aside from disabling SELinux. I chose this OS in part  
> *because* of SELinux, so I don't want to disable it :)
>
> Has anyone experienced something similar, and might you be able to  
> point a newbie in the right direction?
>
> Thanks,
> toby boudreaux
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to  
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
