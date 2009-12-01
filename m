Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB14MCd7018400
	for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2009 23:22:12 -0500
Received: from mailhub248.itcs.purdue.edu (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nB14L5FU015819
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 04:21:05 GMT
Message-ID: <4B14934F.9050401@cs.purdue.edu>
Date: Mon, 30 Nov 2009 22:53:51 -0500
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: SE Linux <selinux@tycho.nsa.gov>, method@manicmethod.com
Subject: Re: Type boundaries: questions on the semantics / is the enforcement
 correct ?
References: <4AF71B05.8030707@cs.purdue.edu> <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu> <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>
In-Reply-To: <4B146B17.50706@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
>>>> I also think we have one other a rough option.
>>>> It simply applies type boundaries on only sources to restrict its privileges,
>>>> and it does not apply any restrictions on target types.
>>>>   
>>>>     
>>>>         
>>> Unless there is a clear use for bounds on targets, I would favor this
>>> option. (The "rough" one :-) )
>>> I see mostly room for confusion with the bounds on target types, because
>>> of the contravariance issue.
>>>   
>>>       
>> I can write and submit a patch along these lines. The patch is
>> straightforward: I just have to remove the "dead" code.
>>     
>
> Note that libsepol has an option which test type-boundary violations
> in usermode just before policy load.
> Also check check_avtab_hierarchy_callback() in libsepol/src/hierarchy.c.
> (It is called when )
>
> Historically, this code delivered from hierarchy namespace support by
> Joshua Brindle. I'd like to ask him what about this change.
>
>   MEMO: The hierarchy namespace support implicitly set up type-boundary
>         on a couple of types. For example, if we defined httpd_t.cgi type,
>         it is implicitly bounded by httpd_t type without TYPEBOUNDS.
>
> I also have not seen any case example which restrict target types by
> the hierarchy namespace support. So, it seems to me we have no matter
> to remove the "dead" code.
>
> Joshua, what's your opinion?
>
>
>   
>> However, could someone please indicate me how I am supposed to test the
>> patch ? In other words, is there a standardized testing procedure that I
>> am unaware of ?
>>     
>
> http://ltp.sourceforge.net/
>
> It also contains SELinux testcases including type boundary, but it also
> does not contains a case of type boundary on target types.
>   

Kaigai, thank you for you detailed answer.

Joshua, I am waiting for your opinion.

Thank you both,
Jacques



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
