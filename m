Message-ID: <46CC2999.2070800@redhat.com>
Date: Wed, 22 Aug 2007 08:18:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: jwcart2@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Question concerning building policy modules
References: <1187203804.26375.69.camel@moss-lions.epoch.ncsc.mil>	 <46CB51E8.5020603@redhat.com> <1187781201.1451.221.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1187781201.1451.221.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-08-21 at 16:58 -0400, Daniel J Walsh wrote:
>   
>> James Carter wrote:
>>     
>>> Why isn't the Makefile and other information needed to build a module
>>> separately in the appropriate /usr/share/selinux/<policy name>
>>> directory?  This seems like the logical place for that information.  The
>>> (not very well documented) "install-headers" make target in the
>>> refpolicy Makefile does this.
>>>
>>> Instead, the information to build a module for Fedora is in
>>> the /usr/share/selinux/devel directory.  This directory would seem to be
>>> independent of the policy type, even though it is only for building
>>> Fedora policies.  This seems confusing.  The devel directory should have
>>> stuff that all policies need or could use.
>>>
>>> Wouldn't it make sense that if I wanted to build a module for the
>>> current policy, I would use the Makefile in devel which would look
>>> at /etc/selinux/config and include the Makefile for the current policy,
>>> but if I wanted to compile for a particular policy, I would just use the
>>> Makefile in its /usr/share directory?
>>>
>>>   
>>>       
>> This is an old argument, between strict and targeted policy.   I did not 
>> like the idea of building
>> policy modules different for each type of policy,  Since almost everyone 
>> is exactly the same or would not work on different policies.  This seems 
>> to be proven to be correct as we move to strict/targeted policy merge. 
>>
>> So you add a level of complexity with very little value.  Just imagine a 
>> third party shipping multiple policies for the
>> same package depending on an infinite number of policy packages.
>>
>> targeted, strict, mls, olpc, CDS-ABC.
>>
>> And almost guaranteed the same policy package would work for all or the 
>> package will only really work on one (MLS).  So I went with the least 
>> common denominator and only ship one devel package.  All interfaces for 
>> all packages ship. 
>>     
>
> But does this allow people using a policy other than targeted to build
> loadable modules using the /usr/share/selinux/devel/Makefile?  Or do
> they have to separately install refpolicy to do that?  That's the
> problem, IIUC.
>
>   
If they can not it is a bug.  I have build policy modules on mls boxes 
in the
past.  The only thing the Makefile does is attempt to discover the 
policy on the system, and
set the flags correctly.  Then it calls into the generic refpolicy 
Makefile.  I have not tested
with specific MLS  calls.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
