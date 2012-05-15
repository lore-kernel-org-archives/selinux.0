Message-ID: <4FB27A53.4050903@tresys.com>
Date: Tue, 15 May 2012 11:46:27 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List
	<selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
References: <4FA95098.1050201@tresys.com> <1423269.qphO9nrW5K@sifl> <4FB26C7D.4020100@tresys.com> <4183776.qZOazSxGrL@sifl>
In-Reply-To: <4183776.qZOazSxGrL@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/15/12 11:04, Paul Moore wrote:
> On Tuesday, May 15, 2012 10:47:25 AM Christopher J. PeBenito wrote:
>> On 05/15/12 10:13, Paul Moore wrote:
>>> On Tuesday, May 15, 2012 09:24:20 AM Christopher J. PeBenito wrote:
>>>> On 05/14/12 17:15, Paul Moore wrote:
>>>>> On Monday, May 14, 2012 01:17:30 PM Stephen Smalley wrote:
>>>>>> I'm not adverse to making it optional/configurable, but I think a
>>>>>> policy
>>>>>> capability is how you should do it.  That is what they are for, and
>>>>>> they
>>>>>> are supposed to provide a more explicit mechanism than either the
>>>>>> handle_unknown logic or the old compat_net logic ...
>>>>>
>>>>> *If* we decide to go this route, I agree, policy capabilities seem to be
>>>>> the best fit.
>>>>>
>>>>> However, as I said earlier in my emails to Chris, I'm still not certain
>>>>> this actually accomplishes anything useful.
>>>>
>>>> I don't understand how you can say this doesn't accomplish anything
>>>> useful.
>>>
>>> See my earlier comments in this thread about being able to verify the
>>> correctness of the secmark labels.  This has always been my core concern
>>> with your argument: you are concerned about the ability for policy to
>>> control network traffic labeled via secmark, but you seem to ignore the
>>> issue that there is no mechanism to verify the correctness of the secmark
>>> labels.  Making strong guarantees about the ability to enforce a given
>>> policy without any assurance that the labels are correct seems a bit
>>> silly to me.
>>
>> Believe me, as a policy person, I'd never ignore labeling correctness.  I
>> don't think SECMARK rule correctness has anything to do with this
>> discussion, as this is about the mechanism/enforcement itself.
> 
> Perhaps I'm reading the two sentences above wrong, perhaps I'm thinking about 
> it wrong, or perhaps you didn't write them as intended; but the two sentences 
> above seem to contradict each other in my mind.  I just don't see how you can 
> have enforcement via labels without correct application of the labels 
> themselves.

Of course for a system to work right you need correct enforcement, correct policy, and correct labeling.  My whole argument is about the enforcement.  If you have correct labeling and correct policy but wrong enforcement, its still incorrect.  I'm only trying to argue on the enforcement; label correctness is important, just not for this discussion.

I can see if you're saying that a system a SECMARK ruleset that fails to load would have incorrect labels for packets.  I agree with that.  But this is a similar situation to /dev labeling being initialized by udev.  The enforcement on files in /dev starts as soon as the filesystem is mounted, rather than when the labeling is initialized by udev.  If udev fails, then the enforcement still goes on with the initial labels, which is why we have restrictive initial labels, rather than disabled.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
