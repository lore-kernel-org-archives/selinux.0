Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1P1ZMT9032294
	for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2012 20:35:22 -0500
Message-ID: <4F483AAA.4070708@windriver.com>
Date: Sat, 25 Feb 2012 09:34:34 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] role_fix_callback skips out-of-scope roles during
 expansion.
References: <1330067550-9744-1-git-send-email-qingtao.cao@windriver.com> <4F479C0A.6070102@tresys.com>
In-Reply-To: <4F479C0A.6070102@tresys.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 02/24/2012 10:17 PM, Christopher J. PeBenito wrote:
> On 02/24/12 02:12, Harry Ciao wrote:
>> If a role identifier is out of scope it would be skipped over during
>> expansion, accordingly, be it a role attribute, it should be skipped
>> over as well when role_fix_callback tries to propagate its capability
>> to all its sub-roles.
>>
>> BTW, it's worthwhile to note that the symtab and rules of an optional
>> block in a loadable module will be written to its pp. However, for the
>> base module the entire optional block will be omitted if its exterior
>> dependency cannot be properly satisfied.
> This doesn't sound correct.  If optionals don't exist in the base module, then that would be a significant problem for current policy.

Ok, even the second part of this patch header doesn't sound correct, the 
patch itself is a must-have so that during expansion role_fix_callback 
will skip the same out-of-scope roles as skipped by role_copy_callback. 
Otherwise the logic won't be consistent.

I will send a v1 patch without the second part of header, it's not 
directly related with the patch anyway.

However, from my testing with the simple x.te came up by Martin Orr in 
another recent thread, if an optional block contains an out-of-scope 
symbol, then that symbol won't be expanded from the base module to the 
out module during expansion, that's why the current assertion in 
role_fix_callback is failed and made me come up this patch to make 
role_fix_callback skip those out-of-scope roles as well.

 From the source code, is_id_enabled will be called by various 
xxx_copy_callback during expansion, which returns 0 if it fails to find 
at least one scope_datum_t with the type of SCOPE_DECL for the current 
symbol, which is right the out-of-scope symbol that has just been 
required but not declared yet.

Did I miss anything?

Thanks,
Harry




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
