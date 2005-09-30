Message-ID: <433D377E.6090700@cornell.edu>
Date: Fri, 30 Sep 2005 09:02:54 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage-functionality 4/17
References: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com>	 <43397960.5070905@cornell.edu>	 <1127851738.21671.147.camel@moss-spartans.epoch.ncsc.mil>	 <4339B036.5090900@cornell.edu> <1127854647.21671.194.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127854647.21671.194.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Yes, and I'm dubious that such elimination is practically useful; you
>still have to audit the code for correct usage and in any case where it
>affects an exposed interface, you have the whole stable API/ABI issue to
>deal with.
>  
>
Struct pointer typedefs eliminated in favor of consistency.  See patches.

>  
>
>>Then we'll have to type struct everywhere...
>>    
>>
>
>Yes, I see it as a benefit to be able to easily see from the code
>whether a function (and the code) is dealing with a pointer or a struct
>without needing to look up a separate type definition.  Think in terms
>of long term code maintainability / readability, particularly for
>patches.  Besides, typing "struct foobahblaz" isn't so much worse than
>typing "foobahblaz_t".  The kernel maintainers are right on the issue of
>typedefs...
>  
>
Todo. I am less excited about removing the _t types - I don't like 
typing struct... You can now see whether you are dealing with a pointer 
or struct...because there are no more pointer typedefs...so there's a 
star everywhere, meaning pointer. I'm not sure that was a good idea, but 
at least it's consistent, which is much better than being inconsistent 
(of course, we could have tried to go the other way instead too...).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
