Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AMW7L9015225
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 17:32:07 -0500 (EST)
Message-ID: <420BDFCC.1060609@redhat.com>
Date: Thu, 10 Feb 2005 17:27:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: TTY question
References: <1107915334.6602.1.camel@cobra.ivg2.net>	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>	 <1108000939.5241.10.camel@cobra.ivg2.net>	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>	 <1108043320.326.1.camel@cobra.ivg2.net>	 <1108058666.3808.2.camel@cobra.ivg2.net>	 <1108062931.4443.3.camel@cobra.ivg2.net>	 <1108063884.22172.231.camel@moss-spartans.epoch.ncsc.mil>	 <1108067400.5249.10.camel@cobra.ivg2.net>	 <1108067486.22172.251.camel@moss-spartans.epoch.ncsc.mil>	 <1108069944.3689.9.camel@cobra.ivg2.net>	 <1108070175.22172.262.camel@moss-spartans.epoch.ncsc.mil> <1108071217.3689.14.camel@cobra.ivg2.net>
In-Reply-To: <1108071217.3689.14.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>>P.S. The java policy had dontaudit tty rules and not allow.
>>>I changed them by accident. Should they be changed back, or 
>>>do you think allow is correct?
>>>      
>>>
>>I don't have that policy in our tree.  Is it for the java plugin run
>>    
>>
>>from mozilla or for java run by a user domain?  If the former, likely
>  
>
>>want dontaudit.  If the latter, likely want/need allow.
>>    
>>
>
>Well, it's the one Daniel Walsh has been writing, and he said it's for
>a java plugin, so I guess I'll revert to dontaudit for now.
>
>
>Thank you for the input - will send patches against FC.
>  
>
Java policy is just for running from mozilla.  IE Plugin, A full java 
policy as I stated before does not
make much sense.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
