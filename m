Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9TG8Tdu015097
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 11:08:29 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9TG7g2R006273
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 16:07:42 GMT
Message-ID: <4544D1E8.5030608@tresys.com>
Date: Sun, 29 Oct 2006 11:08:08 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Michael Graffam <michael.graffam@gmail.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: New to SELinux -- any suggestions?
References: <1162086080.2566.16.camel@endless>	 <200610291432.01272.russell@coker.com.au>	 <1162096212.15530.22.camel@endless>	 <200610291601.19715.russell@coker.com.au> <1162101958.2580.10.camel@endless>
In-Reply-To: <1162101958.2580.10.camel@endless>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael Graffam wrote:
> On Sun, 2006-10-29 at 15:01 +1000, Russell Coker wrote:
>   
>> On Sunday 29 October 2006 15:30, Michael Graffam <michael.graffam@gmail.com> 
>> wrote:
>>     
>>> Thank you for the help. Can one AND/OR the contexts? Based on the above,
>>> it would seem to me that if an executable violated two points of policy
>>> it wouldn't be possible to 'bless' it -- since I'm sure this isn't the
>>> case, I'm wondering how I might apply multiple contexts. Or am I still
>>> out in left field here?
>>>       
>> I don't know what you mean by "bless" in this message.
>>     
>
> By "bless" I meant "Allow it to run regardless." Or "Give it the
> blessing to misbehave."
>
>   
you can always write a very permissive policy for it but chances are you 
won't need to. What is the app doing that unconfined_execstack_t doesn't 
allow?

If you do end up having to write a policy its quite easy in FC6, just 
yum install selinux-policy-devel, /usr/share/selinux/devel/policygentool 
mylistapp /usr/local/bin/lisp and follow the instructions that 
policygentool has. This will allow you to give permissions only to your 
lisp app without granting them to the rest of the system.. You probably 
won't have to do this though, if unconfined_execstack_t can't do 
something its either a very broken app or a policy bug..

>> If however a file could have multiple types then such analysis would be 
>> impossible unless you also had rules determining which pairs of contexts 
>> might be applied to one file (in which case every permitted pair of contexts 
>> could be mapped to a single context in the current SE Linux system for the 
>> same result).
>>     
>
> OK, that makes perfect sense. I had figured that multiple contexts would
> be allowed, to prevent the possible need of expanding the number of
> required 'base' contexts. But, I can certainly see your point about the
> difficulty of analyzing all possible combinations. 
>
>   
>>> Whooo.. new ls fields too! Man, I feel like a kid again! This is
>>> great! :) Having been using GNU/Linux for so long, I almost forgot how
>>> fun it is to learn new stuff about it!
>>>       
>> There is also "id -Z", "ps -Z" and "cp -Z".  There are also a few new 
>> commands, in addition to chcon there's runcon and newrole (which isn't being 
>> used so much nowadays) and there is semanage and getsebool/setsebool to 
>> manage it.
>>     
>
> Thanks again for your help. Would you happen to know if there is a
> document somewhere which gives a general overview of the structure of
> the SELinux mechanisms, maybe with some details on the common contexts
> and so forth?
>
>   
There is quite a bit of documentation around in various places, most of 
which are linked to from the sourceforge project page 
(http://selinux.sourceforge.net/resources.php3). There is also a quite 
comprehensive book that was recently published if you are interested in 
that (http://www.phptr.com/bookstore/product.asp?isbn=0131963694&rl=1)

Alot of the new infrastructure isn't well documented, the fedora faq 
(http://fedora.redhat.com/docs/selinux-faq-fc5/en_US/) has a bit about 
them but it appears to be down at the moment.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
