Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75JDxOb003246
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 15:13:59 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75J5srI027850
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 19:05:54 GMT
Message-ID: <42F3B900.1090700@tresys.com>
Date: Fri, 05 Aug 2005 15:07:44 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: Red Hat's passwd
References: <42F3904F.5080401@tresys.com> <1123261941.20237.9.camel@nexus.verbum.private> <42F3ACF2.9050905@tresys.com> <42F3B235.3080701@redhat.com>
In-Reply-To: <42F3B235.3080701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

> Joshua Brindle wrote:
>
>> Colin Walters wrote:
>>
>>> On Fri, 2005-08-05 at 12:14 -0400, Joshua Brindle wrote:
>>>  
>>>
>>>> The attached patch removes the selinux code from Red Hat's passwd.c 
>>>> and uses the libselinux function checkPasswdAccess.   
>>>
>>>
>>>
>>> This reminds me...there was some griping from people maintaining 
>>> modules
>>> which use libselinux about the name "checkPasswdAccess" in a shared
>>> library targeted for wide use; could we get some namespacing here?  
>>> This
>>> is a good thing for preventing symbol collisions and also for aesthetic
>>> and consistency reasons.  Perhaps avc_check_passwd_permission or
>>> security_check_passwd_permission or something?
>>>
>>>  
>>>
>> yea, thats a bad name, and it has caps!@
>>
>>> Renaming the function would be an API/ABI break, but it doesn't seem
>>> like a function that could be applicable for more than a few 
>>> programs at
>>> most.
>>>  
>>>
>> yea, the problem is really upstreaming the change in whatever 
>> packages use it (shadow, and hopefully RH passwd)
>> and some of Red Hats patches for things like vixie cron will also 
>> need to be fixed.
>>
>> Personally I'd rather not deal with a major version change needed for 
>> an api change. Granted it shouldn't be named that but it isn't 
>> crucial to fix it. We probably need to be more careful about what 
>> functions are exported in the future.
>>
>> Also, util-linux needs to be patched to use checkPasswdAccess (or 
>> whatever) rather than internally (which looks surprisingly similar to 
>> checkPasswdAccess) and there are probably more apps I'm missing.
>>
> Lets add Colins' name and then just leave checkPasswdAccess to call 
> it.  Then remove any reference to the function.
>
Sounds good to me, trivial patch to do this.. Also, I assume you will 
change the previous patch for passwd.c to the new function.

Index: checkAccess.c
===================================================================
--- checkAccess.c       (revision 920)
+++ checkAccess.c       (working copy)
@@ -6,7 +6,7 @@
 #include <selinux/flask.h>
 #include <selinux/av_permissions.h>

-int checkPasswdAccess(access_vector_t requested) {
+int selinux_check_passwd_access(access_vector_t requested) {
         int status=-1;
         security_context_t user_context;
         if (is_selinux_enabled() == 0)
@@ -31,3 +31,7 @@

         return status;
 }
+
+int checkPasswdAccess(access_vector_t requested) {
+       return selinux_check_passwd_access(requested);
+}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
