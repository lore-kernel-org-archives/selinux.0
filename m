Message-ID: <43790BA4.1030503@cornell.edu>
Date: Mon, 14 Nov 2005 17:11:48 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>, SELinux-dev@tresys.com
Subject: Re: Mls data structure, Seusers...
References: <43764DDE.1060503@cornell.edu> <1131976728.5415.49.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131976728.5415.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Anyway, to get to the point of this email... I originally chose to 
>> represent MLS data in user/seuser/context objects as a string, rather 
>> than a structure. That might have been a mistake, so I raise this issue 
>> again - is a string acceptable? It's important to clarify this, because 
>> it affects the interface, and also matters for future functions which I 
>> plan to write that allow libsemanage to validate seuser mls fields.
>>     
>
> I think using a string for the MLS data is fine.  I see no gain from
> further data hiding beyond that level.
>   
Allright - in that case I will write char* interfaces to manage mls 
levels/ranges in libsepol, and expose those. Those interfaces will need 
to be made abstract as well - can't rely on the policydb object.

It's kind of a strange situation - imagine sysadmin on machine A wants 
to modify policy (possibly originating from a remote machine B), and to 
do that libsemanage validates seuser data, which could be on LDAP server C.

>> introducing (shared) interfaces to deal with mls ranges/levels. An 
>> alternative approach is to make sepol learn about seusers (by moving the 
>> seuser record into sepol), and dealing with this higher-level object, 
>> rather than the mls range directly. However, there's no reason to move 
>> the seuser record into sepol, other than for validation - seusers are 
>> not loaded into policy.
>>     
>
> I don't think we want to move in that direction; seuser records should
> not be a sepol abstraction at all.
>   
Sure, I was just listing the possibilities. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
