Message-ID: <4A53830A.7000602@manicmethod.com>
Date: Tue, 07 Jul 2009 13:16:58 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: This patch add seusers support to SELinux
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com> <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com> <4A3AA03E.4010208@manicmethod.com> <4A3B6110.8010308@redhat.com> <4A3BA9DC.2060406@manicmethod.com> <4A3BACE9.6000403@redhat.com> <4A4A2CE1.5060204@manicmethod.com> <4A4B5A27.9000704@redhat.com> <4A536ECD.3050103@manicmethod.com> <4A53725A.5050209@manicmethod.com> <4A537790.8030209@redhat.com>
In-Reply-To: <4A537790.8030209@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 07/07/2009 12:05 PM, Joshua Brindle wrote:
>> Joshua Brindle wrote:
>>> Daniel J Walsh wrote:
>>>> The interface is looking for something that looks like:
>>>>
>>>> *:staff_u:s0
>>>> or
>>>> sshd:guest_u:s0
>>>> login:staff_u:so-s0:c0-c1023
>>>> xdm:user_u:so
>>>>
>>>> I don not currently intend this to be edited by a human, the goal
>>>> was to
>>>> allow tools like IPA or other scripting tools to populate these files.
>>>> The library should return the content as it does, but libselinux or
>>>> pam_selinux should deny login if the machine is in enforcing mode. The
>>>> fact that it is giving you a bogus login is a bug in current SELinux.
>>>>>>>
>>>>>> The : separated list matches seusers and /etc/passwd so I think it
>>>>>> makes
>>>>>> sense. THe file should require all three fields, that is a bug.
>>>>>>
>>>>>
>>>
>>> Patch merged in libselinux 2.0.84.
>>>
>>
>> Even though I merged this I'm a little concerned about how fragile it
>> is. For example, I added:
>>
>> sshd:staff_u:SystemLow
>>
>> to /etc/selinux/targeted/logins/root
>>
>> and when I rebooted and logged in I was unconfined_u. The problem was
>> that mcstrans hadn't been started. The fact that I can essentially get
>> unconfined access by bringing mcstrans down somehow is _very_
>> concerning. Granted this only happens if you are using translated levels
>> but I think that will be very common in practice (so that the IPA
>> infrastructure doesn't need to know the label encodings of every system).
>>
>> This is badness waiting to happen :\
> But the bug here is returning an invalid context. We should return an
> error and not let you login.

Are you going to do this or do you need me to?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
