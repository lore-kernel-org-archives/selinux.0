Message-ID: <48BFFBD7.9070806@manicmethod.com>
Date: Thu, 04 Sep 2008 11:16:39 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg231@gmail.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com>	 <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil>	 <48B41D0E.6060509@redhat.com>  <48B4B348.2080801@gmail.com> <1219838648.5708.10.camel@moss-spartans.epoch.ncsc.mil> <48B5D8D4.8010502@tresys.com>
In-Reply-To: <48B5D8D4.8010502@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Tue, 2008-08-26 at 21:52 -0400, Ivan Gyurdiev wrote:
>>>>> I'm a little unclear on what this is doing - can you clarify?
>>>>>     
>>>> This is clearing the existing seusers.final file, otherwise delete was
>>>> not working.
>>>>   
>>> I think the previous code was doing more - it was merging the local file 
>>> with the shipped base package file, like this:
>>>
>>>     data = extract_file_from_policy_package( )
>>>     write_file ( "seusers.final", data )
>>>     if ( data != null ) {
>>>         seusers.clear_cache()  // thereby forcing reload from 
>>> seusers.final when cache() is called again (in merge_components)
>>>     } else {
>>>         seusers.clear()
>>>     }
>>>
>>> It's also doing this three times (once for fcontexts, once for seusers, 
>>> once for seusers_extra).
>>> The problem is that you're skipping the link_sandbox call, which builds 
>>> the base package, containing this information.
>> We're trying to avoid the overhead of re-linking the policy when we are
>> only modifying non-policy components like seusers and fcontexts.
>> fcontexts.local is split out to a separate file for precedence reasons
>> so it doesn't get merged anymore.  I don't think Dan actually uses
>> seusers in the base policy for anything at present, but others may be.
>>
> 
> Verified. The seusers coming from the policy are not merged into the seusers.final with this patchset. 
> 
> It appears that at present in sepol_link_packages() there is no merging of seusers from each module so we only support seusers in base presently. Therefore we don't have to worry about getting the seusers from all the modules but we do need to grab them out of the base module and combine them in.
> 

Ping on this, were you able to reproduce this Dan? I'd like to get this patch in before we do a toolchain release (which is soonish).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
