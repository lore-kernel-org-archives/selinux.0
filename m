Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TLv9k9030493
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 16:57:10 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0TLv9Sx011092
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 21:57:09 GMT
Message-ID: <479FA131.3050700@manicmethod.com>
Date: Tue, 29 Jan 2008 16:57:05 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: genhomedircon is broken in libsemanage
References: <479F4051.7030101@redhat.com> <6FE441CD9F0C0C479F2D88F959B01588016EF6CA@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588016EF6CA@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> Daniel J Walsh wrote:
>   
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Adding
>>
>> mythtv:x:1004:1004::/var/lib/mythtv:/bin/bash
>>
>> To /etc/passwd causes the labeling to get all screwed up.  This would
>> report an error when we used the python version of genhomedircon and
>> not foul up the labeling by checking if there was a label for /var/lib
>> already in the file_context file. (Boy do I love python.  :^))
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=430195
>>
>> Dan
>>     
>
> That shouldn't be hard to add to genhomedircon.c.  I'll take a look.
>   

So, Todd is about to send a patch to fix this but I want to point out 
that I'm adverse to this sort of thing. There is a minuid and a null 
shell for a reason, using something above minuid with a valid shell for 
a non-interactive user is a broken configuration and the fact that we 
have to work around it is pretty unfortunate.

That said the alternative of breaking the system labeling is pretty bad, 
its probably better to hack around the problem than leave clueless users 
with broken configurations stranded but I really wish we didn't have to 
do things like this.

*sigh*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
