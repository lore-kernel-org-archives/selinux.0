Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4HGpvQe008719
	for <selinux@tycho.nsa.gov>; Thu, 17 May 2012 12:51:57 -0400
Received: by ggnv5 with SMTP id v5so2165698ggn.12
        for <selinux@tycho.nsa.gov>; Thu, 17 May 2012 09:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FB519B7.5010502@tresys.com>
References: <4FA95098.1050201@tresys.com>
	<4183776.qZOazSxGrL@sifl>
	<4FB27A53.4050903@tresys.com>
	<1885958.szbG2AyNTS@sifl>
	<4FB505DC.4080700@tresys.com>
	<CAHC9VhTeBZX116mXvn+wA64Oo+5BgNwg1Zp+h_vAcDHDKva+7w@mail.gmail.com>
	<4FB519B7.5010502@tresys.com>
Date: Thu, 17 May 2012 12:51:58 -0400
Message-ID: <CAHC9VhQHvpMo+1H_js_GSpq1EXyZaCtV0GBBeLxjpjNjeuso3A@mail.gmail.com>
Subject: Re: RFC: packet checks always on option
From: Paul Moore <paul@paul-moore.com>
To: david caplan <dac@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 17, 2012 at 11:31 AM, david caplan <dac@tresys.com> wrote:
> On 5/17/2012 10:42 AM, Paul Moore wrote:
>> On Thu, May 17, 2012 at 10:06 AM, david caplan <dac@tresys.com> wrote:
>>> On 5/15/2012 2:45 PM, Paul Moore wrote:
>>>> On Tuesday, May 15, 2012 11:46:27 AM Christopher J. PeBenito wrote:
>>>>> On 05/15/12 11:04, Paul Moore wrote:
>>>>>> On Tuesday, May 15, 2012 10:47:25 AM Christopher J. PeBenito wrote:
>>>>>>> On 05/15/12 10:13, Paul Moore wrote:
>>>>>>>> See my earlier comments in this thread about being able to verify the
>>>>>>>> correctness of the secmark labels.  This has always been my core concern
>>>>>>>> with your argument: you are concerned about the ability for policy to
>>>>>>>> control network traffic labeled via secmark, but you seem to ignore the
>>>>>>>> issue that there is no mechanism to verify the correctness of the
>>>>>>>> secmark labels.  Making strong guarantees about the ability to enforce a
>>>>>>>> given policy without any assurance that the labels are correct seems a
>>>>>>>> bit silly to me.
>>>>>>>
>>>>>>> Believe me, as a policy person, I'd never ignore labeling correctness.  I
>>>>>>> don't think SECMARK rule correctness has anything to do with this
>>>>>>> discussion, as this is about the mechanism/enforcement itself.
>>>>>>
>>>>>> Perhaps I'm reading the two sentences above wrong, perhaps I'm thinking
>>>>>> about it wrong, or perhaps you didn't write them as intended; but the two
>>>>>> sentences above seem to contradict each other in my mind.  I just don't
>>>>>> see how you can have enforcement via labels without correct application
>>>>>> of the labels themselves.
>>>>>
>>>>> Of course for a system to work right you need correct enforcement, correct
>>>>> policy, and correct labeling.  My whole argument is about the enforcement.
>>>>> If you have correct labeling and correct policy but wrong enforcement, its
>>>>> still incorrect. I'm only trying to argue on the enforcement; label
>>>>> correctness is important, just not for this discussion.
>>>>
>>>> My argument is that worrying about enforcement without demonstrating you've
>>>> solved the labeling issue is pointless.  It is my opinion that the labels have
>>>> to be correct before you can perform any worthwhile enforcement.
>>>
>>> I agree that worthwhile enforcement requires correct labels but I'm not
>>> following how that relates to having a complete non-bypassable
>>> mechanism.
>>
>> Either way the security policy isn't enforced correctly.
>
> No, if there is no enforcement mechanism then the policy is 100% not
> enforced. If there is an enforcement mechanism then there is some chance
> that it is enforced correctly.

Either way you have no guarantee that the policy is enforced correctly.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
