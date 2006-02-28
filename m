Message-ID: <44048927.6090506@cornell.edu>
Date: Tue, 28 Feb 2006 12:32:23 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Deprecate freecon and freeconary
References: <44037A30.2040406@cornell.edu> <1141131654.22297.150.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141131654.22297.150.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> This patch marks freecon and freeconary as deprecated.
>> All uses of freecon() are changed to free().
>> Uses of freeconary() remain within the library, since this is a useful 
>> function.
>>     
>
> Given that freeconary() is a useful helper, should we retain it in the
> non-deprecated API but just convert its argument to char** going
> forward?
>   
It's not in the selinux_* namespace, and it's trivial to rewrite...
I'm not sure we should expose a function which frees an array of strings.
This isn't related to selinux, it's a string utility function.

>> stdlib.h has been included where appropriate.
>> stddef.h has been included where size_t was needed
>> Manpages and comments have been edited appropriately.
>>
>> The next logical patch is to remove security_context_t, and replace it 
>> with char*, although I'm not sure whether that should be done throughout 
>> the library, or just in the API.
>>     
>
> We'll likely need to retain the type definition in the API for
> compatibility with externally maintained code (e.g. SELinux userland
> patches that have migrated into other distributions and in some cases
> into the upstream packages). 
Right, I didn't mean to remove the typedef statement. I was wondering 
whether we should re-write the function prototypes and manpages not to 
mention it.

>> 1. Freecon and freeconary are not in a proper namespace. All such 
>> functions should be deprecated and replaced in general.
>>     
>
> Not sure if this is truly justified for all such functions, e.g.
> getfilecon, setfilecon, setexeccon, etc are basic primitives that could
> easily have been implemented as system calls (and were originally) if
> that had been an option.  The core API (wrappers of kernel APIs) can
> likely be left alone aside from security_context_t -> char* conversion.
>   
...if they're not syscalls anymore, then I don't see why they shouldn't 
follow the naming rules as all other functions. Anyway, I won't send any 
patches to rename things right now - there were reasons other than the 
naming to look at deprecating freecon* and context_*.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
