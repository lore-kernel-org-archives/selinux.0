Message-ID: <432EF286.7030101@cornell.edu>
Date: Mon, 19 Sep 2005 13:16:54 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com>	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>	 <432CDC23.4010907@cornell.edu>  <432CE470.1020400@cornell.edu>	 <1127134177.29404.31.camel@moss-spartans.epoch.ncsc.mil>	 <432EC5BD.2090203@cornell.edu>	 <1127141128.29404.73.camel@moss-spartans.epoch.ncsc.mil>	 <432EE64C.60408@cornell.edu> <1127148559.29404.140.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127148559.29404.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>Yes, I wouldn't expect the callback to have the logic to do that - 
>>that's just a question of policy on how you use the debug system in your 
>>code, and at which point you issue error messages.
>>    
>>
>
>Yes, but if the messages are generated in such a form that you need them
>all (or at least pieces of several of them) to make sense of the overall
>error, then it becomes difficult to implement a sensible callback that
>does anything other than output/log/buffer them all (optionally without
>the function information).  They can certainly differentiate between
>LOG_INFO, LOG_DEBUG, and LOG_ERR, but I think all current DEBUG calls
>would be LOG_ERR.
>  
>
Well, perhaps I should make an effort to generate errors in a different 
pattern, so the end result is more user friendly (possibly pass down 
more information to the leaf, so it can generate a single error report). 
In any case, I am concerned about semanage code here, specifically, 
semanage code that hasn't been merged yet that uses polymorphism. I'm 
not sure how much of a problem the current sepol code is...

>>Which part, specifically, seems like overkill?
>>    
>>
>
>If the policy management daemon was going to just discard all messages
>except for the leaf node error handling ones, then add ng a state object
>to the interfaces and pushing it down to all DEBUG calls seemed
>pointless; the result would never be used for most of them.  OTOH, you
>would still need the state object for all interfaces used by the policy
>management daemon, and you would need to push it down to all leaf node
>error handlers (whether they would call DEBUG or a separate write_error
>interface), so I suppose it might not make a large difference.
>  
>
Yes, you would still need the state object at the leaf node. 
Alternatively you could make use of more informative error codes in the 
leaf node, and print errors higher up. You need the state object at the 
point where the error is printed.

I think if we should wrap policydb into this so-called "state object" 
for the added benefit of eliminating the global policydb.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
