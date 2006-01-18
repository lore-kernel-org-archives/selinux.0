Message-ID: <43CDBB35.6020209@tresys.com>
Date: Tue, 17 Jan 2006 22:51:17 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com> <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com> <43CDBA95.8020308@redhat.com>
In-Reply-To: <43CDBA95.8020308@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Joshua Brindle wrote:
> 
>> Daniel J Walsh wrote:
>>
>>> Joshua Brindle wrote:
>>>
>>>> Daniel J Walsh wrote:
>>>>
>>>>> Includes Ivan and Russells changes
>>>>>
>>>>> Now checks to make sure run as root.
>>>>
>>>>
>>>>
>>>> while it's probably true that most 'direct' libsemanage sessions 
>>>> need root that is not necessarily true for policy server so I don't 
>>>> think there should be a hard coded root check in semanage (aren't we 
>>>> trying to rely on MAC here anyway?)
>>>
>>>
>>> The checks are for genhomedircon and semanage both of which will be 
>>> prevented from running because of DAC control.
>>>
>>
>> why not correctly handle the permission failure instead of hardcoding 
>> a root check? semanage going through the policy server will not be 
>> affected by DAC(uid) aside from the permissions on the sock file.
>>
> So we have nasty failures until the policy server shows up?

sounds like the direct_api in libsemanage needs to return an error if it 
doesn't think it'll be able to write to the policy store (at transaction 
start time, or maybe on request) , and semanage can handle it 
gracefully. That way only direct connections are affected and semanage 
won't show users any nasty failures.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
