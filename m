Message-ID: <43BA8B98.5020502@cornell.edu>
Date: Tue, 03 Jan 2006 09:35:04 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
   dwalsh@redhat.com
Subject: Re: [SEMANAGE][SEPOL] Enable ports
References: <43ACADB3.7070509@cornell.edu> <43B97823.3080201@tresys.com> <43B9761A.3070504@cornell.edu> <43BA267D.2010905@cornell.edu> <43BAA615.9000605@tresys.com>
In-Reply-To: <43BAA615.9000605@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> Actually.... not true. It's difficult to add at the key level, but 
>> error checks and warnings and things like that will easily go into a 
>> verify run on commit (or possibly in sepol). So, now I think I'll 
>> focus on:
>>
> Must do it within semanage since sepol won't know where they came from 
> and if they are allowed to shadow entries.
Hmm, yes that is true, I'll think about this some more...
It seems like a verify run of some kind on commit is best.

>> - also, did you know that if you originally put a file with duplicate 
>> records in semanage, it would stay that way, and semanage wouldn't 
>> complain (it does no duplicate checking when reading in the file - 
>> not sure if that's a problem).
>>
> Any local should shadow/override something in the policy without a 
> warning, that is the whole point to local settings, particularly with 
> ports and interfaces. Any service port (1-1024) will be 'shadowed' by 
> something in the policy but should be able to be overridden by 
> ports.local.
Yes, I was referring to having multiple entries for the same thing in 
the .local file. In addition to not checking for shadowing of ports, 
semanage won't check for duplicates every time - it will only check for 
duplicates when you add things with API. If the initial file was 
corrupted somehow (i.e. contained two identical keys), it won't complain 
about it. Not sure if that's a problem.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
