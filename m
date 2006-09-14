Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EDtRTD003589
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 09:55:27 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8EDsZg7006888
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 13:54:35 GMT
Message-ID: <45095F4A.7080607@tresys.com>
Date: Thu, 14 Sep 2006 09:55:22 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
References: <45095092.6080603@redhat.com> <45095E10.2020205@tresys.com>
In-Reply-To: <45095E10.2020205@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> =======================================================
>>
>> If someone was to pass a law and make me the King of SELinux, The way 
>> this would happen is that iptables would be extended to add a -t 
>> SecurityContext flag, which I then could simple SELinux rules to set 
>> this up in a lanquage that most Sysadmins of Linux boxes could 
>> readily understand.
> umm, -j SECMARK --selctx?
>
Actually I see what you are saying now, you want to match based on 
context, not label packets. This is not in the spirit of SELinux because 
it spreads the policy out into 2 places and makes it much harder to 
audit. We want labeling spread out but policy centralized.

It would make management of the policy even harder than it is now.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
