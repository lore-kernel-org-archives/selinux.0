Message-ID: <4A01ACED.3090107@redhat.com>
Date: Wed, 06 May 2009 11:29:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: policy as configuration data
References: <06A6610D4F464D4EBEAFBF2C5F86911E010D6962@exchange2.columbia.tresys.com> <1241620337.27629.10.camel@localhost.localdomain> <4A01A7A7.2010602@manicmethod.com>
In-Reply-To: <4A01A7A7.2010602@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/06/2009 11:07 AM, Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Tue, 2009-05-05 at 17:03 -0400, Caleb Case wrote:
>>> We've been looking into a couple of improvements to the SELinux
>>> infrastructure. One of the options we are looking at is treating policy
>>> as configuration data. We've found a couple of sticking points though.
>>>
>>> First, removing a set of trusted tools (running in domains only able to
>>> access files of appropriate types) from the policy modification process
>>> makes it more difficult to control the flow of low integrity data into
>>> the policy.
>>
>> Policy as configuration data does not imply that you have to let users
>> directly modify the config files without using a tool (which is useful
>> for general integrity and transactional behavior, not just security).
>> passwd data is config data, yet you are supposed to edit it via vipw and
>> tools like useradd.
>>
>
> How do you define config data? Is the current module store considered
> config data? I can't think of a definition that doesn't either include
> every file on the system or exclude things like passwd, shadow, etc.
>
> I think from a users perspective config data means they can drop a file
> somewhere, restart a service and the additional config is active (apply
> the same to modifying a file).
>
>
>>> Also, how can we also support policy access control? For example, how do
>>> we determine who changed the policy if multiple people can edit the
>>> policy files? How do we handle simultaneous edits? What about
>>> transactions?
>>
>> Again, policy as config data doesn't seem to preclude having a tool
>> mediate the changes.
>>
>
> If a tool is required then how is it better than what we have now?
>
Well at least humans could read the policy.
>>> It's unclear if this is important since part of the goal here is to
>>> simplify and improve the SELinux experience.
>>>
>>> Using a trusted set to tools has its advantages and doesn't necessarily
>>> preclude the use of a text based policy. A tool that could give the user
>>> a text module back for modification and accept a text module as input
>>> may be sufficient but doesn't exactly fit into how configuration data
>>> typically works.
>>>
>>> We are looking for input on whether having an uncontrolled conf.d style
>>> policy directory that is admin-modifiable without the need for tools is
>>> a high priority for people or if the disadvantages outweigh the desire
>>> to edit files directly.
>>>
>>> Questions/comments/rants/flames welcome.
>>>
>>> Caleb
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to
>>> majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
