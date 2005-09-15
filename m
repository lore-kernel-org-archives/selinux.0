Message-ID: <4329235B.6030109@cornell.edu>
Date: Thu, 15 Sep 2005 03:31:39 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com>	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>	 <43284A6B.8080507@tresys.com>  <43287BDC.1090004@cornell.edu> <1126727413.12299.208.camel@moss-spartans.epoch.ncsc.mil> <432888C8.3090700@cornell.edu>
In-Reply-To: <432888C8.3090700@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>
>>> Next, what to do we do with all those printf calls that remain, and 
>>> the ones
>>> that are now DEBUG calls.... if they are in fact error-reporting 
>>> statements,
>>> then I understand you want them written in an error buffer. Where does
>>> the buffer come from, given the current API?
>>>   
>>
>>
>> What particular interfaces are an issue here?
>
> All of them? For example, the policydb.c code just changed to use 
> DEBUG...
> policydb_read()
> policydb_write()
> everything else...


Well... I guess those would be in the static library. In fact, the 
shared library doesn't provide a whole lot of functionality right now:

  global: sepol_genbools*; sepol_set_policydb_from_file; 
sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;

So, if you deprecate the shared sepol_gen*, you're left 
with...sepol_check_context (which makes use of sepol_context_to_sid, and 
sepol_ctx_*)... and also sepol_set_policydb_from_file (which I think 
should also be deprecated, along with the global policydb).

Why are we making this a static library again?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
