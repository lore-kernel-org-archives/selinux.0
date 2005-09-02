Message-ID: <43185553.3010903@tresys.com>
Date: Fri, 02 Sep 2005 09:36:20 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jason Tang <jtang@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] show correct error message when a policy has duplicate
 declarations
References: <1125510199.5306.59.camel@localhost.localdomain>	 <1125511782.18888.347.camel@moss-spartans.epoch.ncsc.mil> <1125512582.18888.349.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1125512582.18888.349.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-08-31 at 14:09 -0400, Stephen Smalley wrote:
>  
>
>>On Wed, 2005-08-31 at 13:43 -0400, Jason Tang wrote:
>>    
>>
>>>Although checkpolicy/checkmodule catch duplicate declarations, the
>>>compiler prints the wrong message.  This patch alters the program so that it
>>>shows the correct message.
>>>      
>>>
>>Hmm...interesting.  Adding a duplicate type declaration for device_t, I
>>see the following behaviors before and after this patch:
>>
>>Before:
>>checkpolicy: module_compiler.c:318: declare_type: Assertion `0' failed.
>>
>>After:
>>types/device.te:16:ERROR 'Out of memory!' at token ';' on line 3855:
>>
>>type device_t;
>>checkpolicy:  error(s) encountered while parsing configuration
>>
>>Somewhat improved, but still not what we want.
>>    
>>
>
>Looks like the real bug is in libsepol, i.e.
>
>Index: libsepol/src/util.c
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/util.c,v
>retrieving revision 1.4
>diff -u -p -r1.4 util.c
>--- libsepol/src/util.c	25 Aug 2005 17:00:49 -0000	1.4
>+++ libsepol/src/util.c	31 Aug 2005 18:11:01 -0000
>@@ -175,7 +175,7 @@ int symtab_insert(policydb_t *pol, uint3
>                 }
>                 else {
>                         /* duplicate declarations not allowed for all else */
>-                        return rc;
>+                        return -2;
>                 }
>         }
>         else {
>
>Not clear whether your patch is needed or not at that point.
>  
>
Probably not but it would be a good idea to audit all the error handling 
so that this sort of thing doesn't happen in the future.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
