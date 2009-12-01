Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB158ONQ021386
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 00:08:24 -0500
Received: from tyo200.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nB157Hbu003521
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 05:07:18 GMT
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id nB116htk014711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 10:06:43 +0900 (JST)
Message-ID: <4B146B17.50706@ak.jp.nec.com>
Date: Tue, 01 Dec 2009 10:02:15 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Jacques Thomas <jthomas@cs.purdue.edu>
CC: SE Linux <selinux@tycho.nsa.gov>, method@manicmethod.com
Subject: Re: Type boundaries: questions on the semantics / is the enforcement
 correct ?
References: <4AF71B05.8030707@cs.purdue.edu> <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu> <4B1411B5.5050406@cs.purdue.edu>
In-Reply-To: <4B1411B5.5050406@cs.purdue.edu>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> I also think we have one other a rough option.
>>> It simply applies type boundaries on only sources to restrict its privileges,
>>> and it does not apply any restrictions on target types.
>>>   
>>>     
>> Unless there is a clear use for bounds on targets, I would favor this
>> option. (The "rough" one :-) )
>> I see mostly room for confusion with the bounds on target types, because
>> of the contravariance issue.
>>   
> 
> I can write and submit a patch along these lines. The patch is
> straightforward: I just have to remove the "dead" code.

Note that libsepol has an option which test type-boundary violations
in usermode just before policy load.
Also check check_avtab_hierarchy_callback() in libsepol/src/hierarchy.c.
(It is called when )

Historically, this code delivered from hierarchy namespace support by
Joshua Brindle. I'd like to ask him what about this change.

  MEMO: The hierarchy namespace support implicitly set up type-boundary
        on a couple of types. For example, if we defined httpd_t.cgi type,
        it is implicitly bounded by httpd_t type without TYPEBOUNDS.

I also have not seen any case example which restrict target types by
the hierarchy namespace support. So, it seems to me we have no matter
to remove the "dead" code.

Joshua, what's your opinion?


> However, could someone please indicate me how I am supposed to test the
> patch ? In other words, is there a standardized testing procedure that I
> am unaware of ?

http://ltp.sourceforge.net/

It also contains SELinux testcases including type boundary, but it also
does not contains a case of type boundary on target types.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
