Message-ID: <4A3BD7DB.9030106@redhat.com>
Date: Fri, 19 Jun 2009 14:24:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: This patch add seusers support to SELinux
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com> <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com> <4A3AA03E.4010208@manicmethod.com> <4A3B6110.8010308@redhat.com> <4A3BA9DC.2060406@manicmethod.com> <4A3BACE9.6000403@redhat.com> <4A3BD53A.5050908@manicmethod.com>
In-Reply-To: <4A3BD53A.5050908@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/19/2009 02:13 PM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> On 06/19/2009 11:08 AM, Joshua Brindle wrote:
>>> Daniel J Walsh wrote:
>>>> On 06/18/2009 04:14 PM, Joshua Brindle wrote:
>>>>> Daniel J Walsh wrote:
>>>>>> On 06/18/2009 09:48 AM, Joshua Brindle wrote:
>>>>>>> Joshua Brindle wrote:
>>>>>>>> Daniel J Walsh wrote:
>>>>>>>>> The idea here is to break the seusers file up into lots of little
>>>>>>>>> seusers file that can be user specific, also adds the service
>>>>>>>>> field to
>>>>>>>>> be used by tools like pam_selinux to choose which is the correct
>>>>>>>>> context
>>>>>>>>> to log a user in as.
>>>>>>>>>
>>>>>>>>> Patch was added to facilitate IPA handing out SELinux content for
>>>>>>>>> selection of roles at login.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This patch does not affect the behavior of getseuserbyname(),
>>>>>>>> how is
>>>>>>>> this expected to work with existing applications?
>>>>>>>>
>>>>>> I think it only affects pam_selinux.
>>>>>
>>>>> The function name is very confusing if its only used for pam_selinux,
>>>>> I'd like it renamed but seeing that pam_selinux is already deployed
>>>>> with
>>>>> it I suppose that isn't an option.
>>>>>
>>>>> Signed-off-by: Joshua Brindle <method@manicmethod.com>
>>>>>
>>>>>>>
>>>>>>> Also, what is the format of this file? What should service be to
>>>>>>> test
>>>>>>> this on F11?
>>>>>>>
>>>> It is not only for pam_selinux, but that is currently the only user.
>>>>
>>>> Really all this function does is add a second variable when selecting a
>>>> users default context. service is just a string that the caller can
>>>> specify. It just allows you to change the default context you would get
>>>> on entry to the system. So I guess you could get use similar calls to
>>>> get different context depending on whether or not you are on the
>>>> console. Imagine a dbus service which would run with one context if you
>>>> we logged onto the console versus a different context if you were
>>>> logged
>>>> in via ssh.
>>>>
>>>
>>> On looking at this further, I don't like the format of the file either,
>>> why did you choose to make it use colons and not tolerate spaces? First
>>> when I tried root: staff_u: s0 it logged me in as system_u and then when
>>> I tried root:staff_u:s0 I got logged in correctly. This is a little
>>> fragile to expect editing by users and getting unexpectedly logged in as
>>> system_u.
>>>
>>> --
>> The : separated list matches seusers and /etc/passwd so I think it makes
>> sense. THe file should require all three fields, that is a bug.
>>
>
> Ok, This is also yet-another-way to map users in SELinux, and its
> different from everything else. We use contexts to map other services to
> users ala contexts/default_contexts and contexts/users/*. Why should
> this be any different? If there are multiple sshd's running, eg., on a
> high nic and low nic then they'd need to map contexts via context rather
> than "service" name.
>
> I still haven't figured out what this is solving.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


I want to say that on these 50 machines dwalsh logs in via ssh as 
guest_t:SystemLow

If he logs in via the console he logs in as staff_t:SystemLow-SystemHigh

Now distribute this out to hundreds of thousands of machines.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
