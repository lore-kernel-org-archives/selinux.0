Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6L0x6rT024620
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 20:59:06 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6L0x3YW021293
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2004 00:59:04 GMT
Message-ID: <40FDBFDD.10500@gentoo.org>
Date: Tue, 20 Jul 2004 20:59:09 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
References: <40FADE92.7060307@gentoo.org> <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil> <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil> <40FD814B.2060503@gentoo.org> <20040720232237.GA13117@lkcl.net>
In-Reply-To: <20040720232237.GA13117@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>On Tue, Jul 20, 2004 at 04:32:11PM -0400, Joshua Brindle wrote:
>  
>
>>James Carter wrote:
>>
>>    
>>
>>>Sorry, I guess I wasn't very clear.
>>>
>>>I was trying to say that you are trying to manually do something that
>>>the kernel can do automatically.  
>>>
>>>You don't need to do the security_create_compute() and setexeccon()
>>>before the exec, because, on the exec, the kernel will do the same
>>>thing.  In both cases, you would have had to use the domain_auto_trans
>>>macro, so you don't gain anything by doing it manually.
>>>
>>>Without an exec, setexecon() won't help you.  
>>>>From selinux.h:
>>>/* Set exec security context for the next execve. 
>>> Call with NULL if you want to reset to the default. */
>>>extern int setexeccon(security_context_t con);
>>>
>>>I am not an expert on Apache and php, but I am pretty sure that when you
>>>execute the php interpreter an exec is occurring somewhere.
>>>
>>>
>>>
>>>      
>>>
>>Right, an exec is happening from httpd_t to php_exec_t currently, and 
>>this will give back php_exec_t. Thats the standard way php is done in 
>>SELinux at the moment and exactly what I'm trying to make better.
>>
>>Now, the new idea is to have fastcgi wrapper which already does setuid() 
>>and setgid() based on the ownership of the target php script (this is a 
>>script! it is not executed by execve()) and then executes php (which is 
>>php_exec_t) resulting in php_t again. What I want it to do is also read 
>>the context of the target script and calculate the autotrans that would 
>>happen if php was going to execute the script directly and then do 
>>setexeccon() to do it manually.
>>
>>You are exactly right in that I'm trying to do something manually but 
>>afaik the kernel can't do this automatically because it's just the php 
>>binary reading in a script and interpreting it, no execve() happens 
>>after the php interpreter is loaded and therefore no per-user php 
>>domains can currently happen.
>>    
>>
> 
> so, you want to emulate [activate] the effect of domain_auto_trans without
> _actually_ doing an execve.
>
>  
>
right

> but also because you are not actually doing an execve, you also wish
> to RETURN to the context from which the domain_auto_trans was made.
>
> in other words, if i am interpreting this correctly [please someone
> make sure i have this right] you wish to do what a seteuid does,
> namely to temporarily go to an alternative-privileged context and
> then return to the previous context.
>
> and as we know, seteuid was discussed and then explicitly stomped on
> from a great height (tm).
>
>  
>
not the same thing. Doing seteuid() _during_ some application and being 
able to change the context at that point is unsafe and therefore should 
never be implemented. That is _not_ what I'm trying to do.

> the recommended approach to get round this was, sadly-in-this-case
> (given the name fastcgi), to do the execve and be done with it.
>
>  
>
not getting around it, using fastcgi to augment the process (running a 
straight php cgi with lots of users is a huge drag on resources anyway) 
and this can also be of benefit to any kind of interpreted scripts where 
the interpreter runs as a cgi in apache.

> ... alternatively, might we see the rebirth of that cgi "helper" daemon
> that i am aware cropped up at one point in apache?
>
>  
>
It might work the same way but I'm happy with the was fastcgi is 
working, since it will spawn a php process for each person the end 
result should be somehting like several php's running in different 
contexts, like
fred_php_t
method_php_t
sys_php_t
and so on

> like i said, my experience with SE/Linux being limited to a few months,
> if i have the wrong end of the stick, here, please some correct me.
>
> l.
>  
>
Again, I think we may be having some misunderstanding, caused by my 
unawareness of security_compute_create giving the info I need. To 
illustrate this I want the following (and think I almost have it now 
that I know about security_compute_create().

apache running in httpd_t
fastcgi is an apache module therefore it's also in httpd_t

apache gets a  request for ~method/foo.php
fastcgi spawns the wrapper (running in fcgi_wrapper_t) which looks for 
the file in question

fastcgi wrapper sees /home/method/public_html/foo.php is owned by 
method:method and context is method_php_script_t
fastcgi wrapper seteuid/setegid to method:method and computes the 
transition from fastcgi_wrapper_t to method_php_script_t (which can 
never happen!)
fastcgi wrapper gets the answer back, method_php_t
fastcgi wrapper does setexeccon(method_php_t) and runs php

now there is a persistant php running in method_php_t ready to 'run' 
~method/foo.php

in this way we have completely isolated user domains for any interpreted 
scripts running from apache! :D

Joshua Brindle
Hardened Gentoo

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
