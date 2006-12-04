Message-ID: <45748D8D.8040500@mentalrootkit.com>
Date: Mon, 04 Dec 2006 16:05:17 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC] Ability to allow unknown class and permissions
References: <6FE441CD9F0C0C479F2D88F959B015885C82D7@exchange.columbia.tresys.com>	 <1165263959.2923.148.camel@moss-spartans.epoch.ncsc.mil>	 <45748652.4050100@mentalrootkit.com> <1165265045.2923.168.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1165265045.2923.168.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-12-04 at 15:34 -0500, Karl MacMillan wrote:
>> Stephen Smalley wrote:
>>> On Mon, 2006-12-04 at 15:28 -0500, Joshua Brindle wrote:
>>>>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>>>>
>>>>> Joshua Brindle wrote:
>>>>>>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
>>>>> <snip>
>>>>>
>>>>>>>> It doesn't give the interface I don't think, but it does let us 
>>>>>>>> redefine user object classes without worrying about the
>>>>>>> kernel rejecting it.
>>>>>>> Not certain I understand this comment either.
>>>>>>>
>>>>>> Perhaps I misunderstood your points, I didn't see how they 
>>>>> applied to 
>>>>>> this exactly either. How is adding an option to the policy 
>>>>> config to 
>>>>>> ignore unknown permissions resulting in an interface to help with 
>>>>>> dynamic object classes?
>>>>> My understanding of the current suggestion is:
>>>>>
>>>>> 1) A policy flag indicating that unknown object classes and 
>>>>> permissions should be ignored.
>>>>> 2) load_policy / libsemanage changed to optionally generate 
>>>>> avtab entries for unknown object classes or permissions based on 1.
>>>>>
>>>>> In order to accomplish 2, load_policy / libsemanage will have 
>>>>> to be able to compare the object classes and permissions that 
>>>>> the kernel currently knows about to the ones referenced in 
>>>>> the policy. Hence a kernel interface exporting information 
>>>>> about the object classes and permissions of which the kernel is aware.
>>>>>
>>>> Why do you need #2 if you have #1? Or Why would you need #1 if you have
>>>> #2? I thought the config flag was for the kernel..
>>> Point of clarification:  I have been discussing a kernel mechanism for
>>> the padding/filling of the avtab entries, not something in
>>> libsepol/libsemanage.  Just putting the bulk of the work at policy load
>>> time (but still in kernel) rather than permission check time.
>>>
>> As I mentioned in the other emails, it seems simpler to implement 
>> userspace and we want the needed information exported from the kernel 
>> anyway.
> 
> In the approach I described, security_load_policy would:
> - continue to check for undefined kernel classes and permissions as it
> currently does,
> - handle policy rejection if that is the behavior selected by the flag,
> - pad any access vectors loaded into the avtab to grant undefined
> permissions if the flag says to do so,
> - generate a table indexed by class with a default access vector per
> kernel class that contains only the undefined permissions if the flag
> says to allow.
> 

Why not generate avtab entries for the unknown classes? I don't see any 
problem with an "invalid" object classes being stored in the avtab. If 
we make a fake attribute applied to all types it should be one avtab 
entry per object class.

> security_compute_av would:
> - handle undefined classes based on the flag (silently return an access
> vector with all ones if it says to allow, otherwise return error),
> - if a matching avtab entry is found, just use it - it is already
> padded.
> - otherwise, use the default per-class access vector that only contains
> the undefined permissions.
> 
> I'm not sure how one would do that in userspace (e.g. the default
> per-class table for holes in the avtab wouldn't have a very compact
> representation in userspace), and you'd still need the checking at least
> in the kernel.
> 

See above.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
