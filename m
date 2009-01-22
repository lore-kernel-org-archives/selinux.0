Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0MMTuuv024091
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2009 17:29:57 -0500
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0MMQuNb008151
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2009 22:26:59 GMT
Message-ID: <4978F35A.7060506@kaigai.gr.jp>
Date: Fri, 23 Jan 2009 07:29:46 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, refpolicy@oss.tresys.com,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] [PATCH] Add a new permission to db_procedure
References: <4973468F.1010706@kaigai.gr.jp> <49758904.2070303@ak.jp.nec.com> <1232461874.10460.1.camel@gorn> <4975E9A3.8060003@kaigai.gr.jp> <4977A1A7.60304@kaigai.gr.jp> <4978CFFF.1030200@manicmethod.com>
In-Reply-To: <4978CFFF.1030200@manicmethod.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> Folks,
>>
>> Do you have any opinion, question, approval or opposition for the new
>> permission to db_procedure class?
>>
>> KaiGai Kohei wrote:
>>>> Changes to object classes need to be discussed on the SELinux list.
>>> OK, I send the patch again for folks in selinux-list only.
>>>
>>>>>> The attached patch add a new permission named as "install" to db_procedure.
>>>>>>
>>>>>> The purpose of this permission is to prevent malicious functions are invoked
>>>>>> as a part of server's internal tasks.
>>>>>>
>>>>>> PostgreSQL allows user-defined functions to use its internal tasks.
>>>>>> For example, it can be used to implement an output/input handler of new data
>>>>>> types, an index access method, implementation of operator classes and so on.
>>>>>>
>>>>>> When we defines a new type, it requires to specify its output/input handler
>>>>>> at least. No need to say, these functions should not be malicious ones,
>>>>>> because user implicitly invokes these function when he uses the type.
>>>>>> This permission is checked when we defines a new system catalog entry which
>>>>>> has a possibility to invoke user defined functions.
>>> A supplement:
>>> PostgreSQL allows user to define his own data type, like "struct xxx" in C
>>> language, and he can also define its input/output handler. The input/output
>>> handler is invoked when user send a text representation, to translate it
>>> into internal data structure, implicitly. For example, a function similar
>>> to atoi() is configured for INTEGER type in default.
>>>
>>> I'm worrying about a malicious one secretly installs a malicious function
>>> which leaks given information to somewhere as a implementation of type
>>> input/output handler, in typical scenario.
>>>
>>> In addition, it allows to install user-defined functions to implement
>>> database index access methods, multibyte encoding conversions, operator
>>> classes and so on.
>>>
>>>>>> In the attached patch, only sepgsql_proc_t is allowed to { install }, because
>>>>>> any other user defined functions are not checked by DBA, so it is not safe to
>>>>>> use it as a part of internal/common processes.
>>>>>> If DBA want to apply user defined functions as a part of internal task, he has
>>>>>> to confirm its safeness and relabel to sepgsql_proc_t at first.
>>>>>>
>>>>>> Please apply it, if no matter.
>>> Thanks,
> 
> Chris asked me to look at this and it seems reasonable to me, no
> objections here.

Chris,
If we have no specific objections here, I want the new permission
to be included.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
