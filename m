Message-ID: <43BE76CF.6070804@cornell.edu>
Date: Fri, 06 Jan 2006 08:55:27 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [SEPOL] Const in APIs (part 1)
References: <43BD635A.7040709@cornell.edu> <1136559006.16811.26.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136559006.16811.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Makes a ton of things const for the purposes of enhanced error checking.
>>
>> I can't figure this out out:
>> context.c: In function ‘sepol_check_context’:
>> context.c:25: warning: passing argument 1 of ‘sepol_context_to_sid’ 
>> discards qualifiers from pointer target type
>>
>> Something's confusing it - either the hidden proto, or the fact that the 
>> typedef wraps the pointer - not sure why it won't go away.
>>     
>
> I added an explicit type cast to silence it.
>   
... but that's cheating! Why does it really occur?
The whole point of the const types is to reveal bugs, which you are 
hiding by casting..



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
