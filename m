Message-ID: <4FB30E6C.4070503@redhat.com>
Date: Tue, 15 May 2012 22:18:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
References: <4FA95098.1050201@tresys.com> <12617452.LZMSpbtozB@sifl> <4FB25904.5020401@tresys.com> <1423269.qphO9nrW5K@sifl> <4FB26C7D.4020100@tresys.com>
In-Reply-To: <4FB26C7D.4020100@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/15/2012 10:47 AM, Christopher J. PeBenito wrote:
> On 05/15/12 10:13, Paul Moore wrote:
>> On Tuesday, May 15, 2012 09:24:20 AM Christopher J. PeBenito wrote:
>>> On 05/14/12 17:15, Paul Moore wrote:
>>>> On Monday, May 14, 2012 01:17:30 PM Stephen Smalley wrote:
>>>>> Didn't the old behavior lead to the undesirable result that
>>>>> refpolicy allows every domain (or at least every domain that does
>>>>> networking) to send/recv unlabeled packets, such that you cannot
>>>>> effectively employ SECMARK unless you first modify and rebuild your
>>>>> entire policy to take away the unlabeled packet access?  Whereas
>>>>> with the new behavior one could drop those rules and then when
>>>>> someone does enable SECMARK, they get to fully define the allowable
>>>>> network traffic?
>>>> 
>>>> Yep.
>>> 
>>> Not any worse than with the old networking checks.
>> 
>> I believe that was Stephen's point.
> 
> I'm still standing by my point which you deleted: the people who would
> care, who would likely modify their base policy anyway.  Plus, you would
> have to modify your base policy anyway to turn on the policy capability
> which would toggle this behavior (I'm assuming no distro would have this
> policycap on by default).  So I acknowledge the point as valid for the old
> behaviors, but I think the circumstances of this change make it
> non-applicable.
> 
>>>>> I'm not adverse to making it optional/configurable, but I think a
>>>>> policy capability is how you should do it.  That is what they are
>>>>> for, and they are supposed to provide a more explicit mechanism
>>>>> than either the handle_unknown logic or the old compat_net logic
>>>>> ...
>>>> 
>>>> *If* we decide to go this route, I agree, policy capabilities seem to
>>>> be the best fit.
>>>> 
>>>> However, as I said earlier in my emails to Chris, I'm still not
>>>> certain this actually accomplishes anything useful.
>>> 
>>> I don't understand how you can say this doesn't accomplish anything
>>> useful.
>> 
>> See my earlier comments in this thread about being able to verify the 
>> correctness of the secmark labels.  This has always been my core concern
>> with your argument: you are concerned about the ability for policy to
>> control network traffic labeled via secmark, but you seem to ignore the
>> issue that there is no mechanism to verify the correctness of the secmark
>> labels.  Making strong guarantees about the ability to enforce a given
>> policy without any assurance that the labels are correct seems a bit
>> silly to me.
> 
> Believe me, as a policy person, I'd never ignore labeling correctness. I 
> don't
think SECMARK rule correctness has anything to do with this discussion, as this
is about the mechanism/enforcement itself.
> 
> What do you want to do with correctness? The filesystem labeling can be
checked contexts can be checked against file_contexts, but mismatches don't
necessarily mean that the labeling is wrong. In my opinion, file_contexts should
only be used to initialize the labeling, and thats it. Afterwards, the labeling
is ruled by the relabeling rules. As long as the policy is correct and *being*
*enforced* at all times, the labels should not get into an inconsistent state.
That seems slightly optimistic...
And if you really want to be pedantic, an security admin/officer should be
verifying the labeling of objects after the system is installed, but before it
goes into production. The same applies to SECMARK rules.
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+zDmwACgkQrlYvE4MpobMM5wCeO+2XlPJJjvSMhuPWa280W+7K
vWoAoJQt6fe88sJZCRJ9Zz7fChOjsdze
=H6Xd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
