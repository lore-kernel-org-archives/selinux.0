Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KKWCrT023404
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 16:32:12 -0400 (EDT)
Message-ID: <40FD814B.2060503@gentoo.org>
Date: Tue, 20 Jul 2004 16:32:11 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
References: <40FADE92.7060307@gentoo.org>	 <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil>	 <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>Sorry, I guess I wasn't very clear.
>
>I was trying to say that you are trying to manually do something that
>the kernel can do automatically.  
>
>You don't need to do the security_create_compute() and setexeccon()
>before the exec, because, on the exec, the kernel will do the same
>thing.  In both cases, you would have had to use the domain_auto_trans
>macro, so you don't gain anything by doing it manually.
>
>Without an exec, setexecon() won't help you.  
>>From selinux.h:
>/* Set exec security context for the next execve. 
>   Call with NULL if you want to reset to the default. */
>extern int setexeccon(security_context_t con);
>
>I am not an expert on Apache and php, but I am pretty sure that when you
>execute the php interpreter an exec is occurring somewhere.
>
>  
>
Right, an exec is happening from httpd_t to php_exec_t currently, and 
this will give back php_exec_t. Thats the standard way php is done in 
SELinux at the moment and exactly what I'm trying to make better.

Now, the new idea is to have fastcgi wrapper which already does setuid() 
and setgid() based on the ownership of the target php script (this is a 
script! it is not executed by execve()) and then executes php (which is 
php_exec_t) resulting in php_t again. What I want it to do is also read 
the context of the target script and calculate the autotrans that would 
happen if php was going to execute the script directly and then do 
setexeccon() to do it manually.

You are exactly right in that I'm trying to do something manually but 
afaik the kernel can't do this automatically because it's just the php 
binary reading in a script and interpreting it, no execve() happens 
after the php interpreter is loaded and therefore no per-user php 
domains can currently happen.

Joshua Brindle

>On Tue, 2004-07-20 at 14:14, Joshua Brindle wrote:
>  
>
>>James Carter wrote:
>>
>>    
>>
>>>Why can't the kernel do the auto transition?  Maybe I don't understand
>>>what you are using for your source and target contexts.
>>>
>>>If you call security_compute_create with fastcgi's context as the
>>>source, the script's context as the target, and using the
>>>SECCLASS_PROCESS class, then you will get the same result as the kernel
>>>when it looks for the default transition in selinux_bprm_security.  So
>>>if you take the new context returned by security_compute_create and call
>>>setexec with it, you will end up with the same result that you would
>>>have if you had just let the kernel do the auto transition.
>>>
>>> 
>>>
>>>      
>>>
>>Oh good, I was hoping I was just overlooking something obvious. I 
>>thought that security_compute_create() was just for automatic object 
>>type transitions but now that I think about it that doesn't make much 
>>sense to seperate those since they are the same thing in different classes.
>>
>>The kernel can't do the auto transition because there is no execve() 
>>happening when the php interpreter reads the .php file and interprets 
>>it. The idea is to have the fastcgi wrapper running in some domain, 
>>fcgi_wrapper_t and have it able to do a security_compute_create() 
>>between it's own context and method_php_script_t and decide that it 
>>should run in method_php_t and then setexeccon() to method_php_t and 
>>execute the php interpreter for the user method. That way my scripts can 
>>be entirely isolated from system and other users and I can't use php to 
>>read other peoples php scripts that could contain passwords and so on.
>>
>>
>>    
>>
>>>Again, why can't you use security_compute_create?
>>>
>>>>From selinux.h:
>>>/* Compute a labeling decision and set *newcon to refer to it.
>>>  Caller must free via freecon. */
>>>extern int security_compute_create(security_context_t scon,
>>>				   security_context_t tcon,
>>>				   security_class_t tclass,
>>>				   security_context_t *newcon);
>>>
>>> 
>>>
>>>      
>>>
>>Yes, I looked at this and thought it was for file labeling decisions.. 
>>silly me ;)
>>
>>Joshua Brindle
>>
>>--
>>This message was distributed to subscribers of the selinux mailing list.
>>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>the words "unsubscribe selinux" without quotes as the message.
>>    
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
