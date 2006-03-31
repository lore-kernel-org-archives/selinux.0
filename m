Message-ID: <442D4448.2090700@redhat.com>
Date: Fri, 31 Mar 2006 10:01:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We need a way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com> <442D436A.1010805@tresys.com>
In-Reply-To: <442D436A.1010805@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> /usr(/.*)?/lib(64)?(/.*)?            
>> gen_context(system_u:object_r:lib_t,s0)
>> /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*    --    
>> gen_context(system_u:object_r:shlib_t,s0)
>>
>> The following has to follow the one above.
>>
>> /usr/lib(64)?/libglide3\.so.*         --    
>> gen_context(system_u:object_r:textrel_shlib_t,s0)
>>
>>
>> It did in FC4, now it does not.  This is the second bug I have seen 
>> caused by the sort algoritm.  We need a way to secify a primary File 
>> Context file that will not be sorted but will always be at the top.  
>> Then the rest can be sorted.
>>
>> Maybe we do not sort files within a particular fc file.  I do not 
>> know. but this is broken.
>>
>
> We are preparing to send up a patch that adds file context ordering to 
> libsemanage ala the algorithm in fc_sort.c in refpolicy/support. The 
> sort algorithm should put the 3rd entry below the top two because the 
> stem length is greater. Are you seeing this with strict (and hightly 
> modular policy?) the large base.pp from targeted will already have its 
> file context entries sorted by fc_sort.c and should handle this case.
I am only looking at targeted and MLS right now.   As soon as we get 
this fix we need to get it out.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
