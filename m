Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB8JkFrY030997
	for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2009 14:46:15 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nB8JmW8q015669
	for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2009 19:48:32 GMT
Message-ID: <4B1EAD03.1040805@manicmethod.com>
Date: Tue, 08 Dec 2009 14:46:11 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Jacques Thomas <jthomas@cs.purdue.edu>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Type boundaries: questions on the semantics / is the enforcement
 correct ?
References: <4AF71B05.8030707@cs.purdue.edu> <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu> <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com> <4B14934F.9050401@cs.purdue.edu>
In-Reply-To: <4B14934F.9050401@cs.purdue.edu>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Jacques Thomas wrote:
> KaiGai Kohei wrote:
>>>>> I also think we have one other a rough option.
>>>>> It simply applies type boundaries on only sources to restrict its privileges,
>>>>> and it does not apply any restrictions on target types.
>>>>>
>>>>>
>>>>>
>>>> Unless there is a clear use for bounds on targets, I would favor this
>>>> option. (The "rough" one :-) )
>>>> I see mostly room for confusion with the bounds on target types, because
>>>> of the contravariance issue.
>>>>
>>>>
>>> I can write and submit a patch along these lines. The patch is
>>> straightforward: I just have to remove the "dead" code.
>>>
>> Note that libsepol has an option which test type-boundary violations
>> in usermode just before policy load.
>> Also check check_avtab_hierarchy_callback() in libsepol/src/hierarchy.c.
>> (It is called when )
>>
>> Historically, this code delivered from hierarchy namespace support by
>> Joshua Brindle. I'd like to ask him what about this change.
>>
>>    MEMO: The hierarchy namespace support implicitly set up type-boundary
>>          on a couple of types. For example, if we defined httpd_t.cgi type,
>>          it is implicitly bounded by httpd_t type without TYPEBOUNDS.
>>
>> I also have not seen any case example which restrict target types by
>> the hierarchy namespace support. So, it seems to me we have no matter
>> to remove the "dead" code.
>>
>> Joshua, what's your opinion?

I agree. The purpose of the type hierarchy was to confine children
domains to a subset of their parents (or a subset of the parent domain
-> parent target). For example, this is allowed:

allow subject object: file read;
allow subject.child object.child: file read;

This was so that the parent didn't specifically have to have access to
the child, but could allow children to access it based on the fact that
the targets parent was accessible by the subjects parent. This was
mostly for 'container' types where a subject isn't really used on the
system and is only used as a container.

We thought about adding a container keyword to remove those container
types from the policy before it was built but after the hierarchy checks
were done but that wouldn't work anymore due to the hierarchy checks in
the kernel.

>>
>>
>>
>>> However, could someone please indicate me how I am supposed to test the
>>> patch ? In other words, is there a standardized testing procedure that I
>>> am unaware of ?
>>>
>> http://ltp.sourceforge.net/
>>
>> It also contains SELinux testcases including type boundary, but it also
>> does not contains a case of type boundary on target types.
>>
> 
> Kaigai, thank you for you detailed answer.
> 
> Joshua, I am waiting for your opinion.
> 
> Thank you both,
> Jacques
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
