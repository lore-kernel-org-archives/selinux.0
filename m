Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75IjSOb002917
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 14:45:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75IbOrI022579
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 18:37:24 GMT
Message-ID: <42F3B235.3080701@redhat.com>
Date: Fri, 05 Aug 2005 14:38:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: Red Hat's passwd
References: <42F3904F.5080401@tresys.com> <1123261941.20237.9.camel@nexus.verbum.private> <42F3ACF2.9050905@tresys.com>
In-Reply-To: <42F3ACF2.9050905@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

> Colin Walters wrote:
>
>> On Fri, 2005-08-05 at 12:14 -0400, Joshua Brindle wrote:
>>  
>>
>>> The attached patch removes the selinux code from Red Hat's passwd.c 
>>> and uses the libselinux function checkPasswdAccess.   
>>
>>
>> This reminds me...there was some griping from people maintaining modules
>> which use libselinux about the name "checkPasswdAccess" in a shared
>> library targeted for wide use; could we get some namespacing here?  This
>> is a good thing for preventing symbol collisions and also for aesthetic
>> and consistency reasons.  Perhaps avc_check_passwd_permission or
>> security_check_passwd_permission or something?
>>
>>  
>>
> yea, thats a bad name, and it has caps!@
>
>> Renaming the function would be an API/ABI break, but it doesn't seem
>> like a function that could be applicable for more than a few programs at
>> most.
>>  
>>
> yea, the problem is really upstreaming the change in whatever packages 
> use it (shadow, and hopefully RH passwd)
> and some of Red Hats patches for things like vixie cron will also need 
> to be fixed.
>
> Personally I'd rather not deal with a major version change needed for 
> an api change. Granted it shouldn't be named that but it isn't crucial 
> to fix it. We probably need to be more careful about what functions 
> are exported in the future.
>
> Also, util-linux needs to be patched to use checkPasswdAccess (or 
> whatever) rather than internally (which looks surprisingly similar to 
> checkPasswdAccess) and there are probably more apps I'm missing.
>
Lets add Colins' name and then just leave checkPasswdAccess to call it.  
Then remove any reference to the function.

>
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
