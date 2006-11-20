Message-ID: <4561E1A3.8070306@mentalrootkit.com>
Date: Mon, 20 Nov 2006 12:10:59 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Multiple small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com> <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com>
In-Reply-To: <455DA4E8.5050600@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Karl MacMillan wrote:
>> Joshua Brindle wrote:
>>>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
>>>> Daniel J Walsh wrote:
>>>>> Joshua Brindle wrote:
>>>>>> Karl MacMillan wrote:
>>>> <snip>
>>>>
>>>>>>> What about a top-level USE_PIE makefile variable that directs all 
>>>>>>> sub-Makefiles to set PIE flags if appropriate for that module? By 
>>>>>>> default it would be off. This gets the behavior you want without 
>>>>>>> having to carry a patch and keeps the current behavior.
>>>>>>>
>>>>>> No patch necessary, like Chris said make CFLAGS="-fPIE -02 -Werror 
>>>>>> -Wall" LDFLAGS="-pie"
>>>>>>
>>>>>> done and done.
>>>>>>
>>>>> No, because then all compiled apps become -pie.  We only 
>>>> want this on
>>>>> the daemons.
>>>>>
>>>> What about this instead?
>>>
>>> Why doesn't make CFLAGS="-fPIE -02 -Werror -Wall" LDFLAGS="-pie" 
>>> work? Why does itmatter if everything is built pie?
>>>
>>
>> There are performance costs associated with pie, particularly at 
>> startup. Talking to Dan though, he doesn't think it is enough to not 
>> just build everything as pie.
>>
>> Resend below that I will apply unless there are other objections.
>>

Committed as policycoreutils 1.33.2.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
