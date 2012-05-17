Message-ID: <4FB519B7.5010502@tresys.com>
Date: Thu, 17 May 2012 11:31:03 -0400
From: david caplan <dac@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
References: <4FA95098.1050201@tresys.com> <4183776.qZOazSxGrL@sifl> <4FB27A53.4050903@tresys.com> <1885958.szbG2AyNTS@sifl> <4FB505DC.4080700@tresys.com> <CAHC9VhTeBZX116mXvn+wA64Oo+5BgNwg1Zp+h_vAcDHDKva+7w@mail.gmail.com>
In-Reply-To: <CAHC9VhTeBZX116mXvn+wA64Oo+5BgNwg1Zp+h_vAcDHDKva+7w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/17/2012 10:42 AM, Paul Moore wrote:
> On Thu, May 17, 2012 at 10:06 AM, david caplan <dac@tresys.com> wrote:
>> On 5/15/2012 2:45 PM, Paul Moore wrote:
>>> On Tuesday, May 15, 2012 11:46:27 AM Christopher J. PeBenito wrote:
>>>> On 05/15/12 11:04, Paul Moore wrote:
>>>>> On Tuesday, May 15, 2012 10:47:25 AM Christopher J. PeBenito wrote:
>>>>>> On 05/15/12 10:13, Paul Moore wrote:
>>>>>>> See my earlier comments in this thread about being able to verify the
>>>>>>> correctness of the secmark labels.  This has always been my core concern
>>>>>>> with your argument: you are concerned about the ability for policy to
>>>>>>> control network traffic labeled via secmark, but you seem to ignore the
>>>>>>> issue that there is no mechanism to verify the correctness of the
>>>>>>> secmark labels.  Making strong guarantees about the ability to enforce a
>>>>>>> given policy without any assurance that the labels are correct seems a
>>>>>>> bit silly to me.
>>>>>>
>>>>>> Believe me, as a policy person, I'd never ignore labeling correctness.  I
>>>>>> don't think SECMARK rule correctness has anything to do with this
>>>>>> discussion, as this is about the mechanism/enforcement itself.
>>>>>
>>>>> Perhaps I'm reading the two sentences above wrong, perhaps I'm thinking
>>>>> about it wrong, or perhaps you didn't write them as intended; but the two
>>>>> sentences above seem to contradict each other in my mind.  I just don't
>>>>> see how you can have enforcement via labels without correct application
>>>>> of the labels themselves.
>>>>
>>>> Of course for a system to work right you need correct enforcement, correct
>>>> policy, and correct labeling.  My whole argument is about the enforcement.
>>>> If you have correct labeling and correct policy but wrong enforcement, its
>>>> still incorrect. I'm only trying to argue on the enforcement; label
>>>> correctness is important, just not for this discussion.
>>>
>>> My argument is that worrying about enforcement without demonstrating you've
>>> solved the labeling issue is pointless.  It is my opinion that the labels have
>>> to be correct before you can perform any worthwhile enforcement.
>>
>> I agree that worthwhile enforcement requires correct labels but I'm not
>> following how that relates to having a complete non-bypassable
>> mechanism.
> 
> Either way the security policy isn't enforced correctly.
> 

No, if there is no enforcement mechanism then the policy is 100% not
enforced. If there is an enforcement mechanism then there is some chance
that it is enforced correctly.

If you're running an SELinux system you have some faith that your
policy, including labeling, is correct and you (should) have an
expectation that access to any object defined in that policy is mediated.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
