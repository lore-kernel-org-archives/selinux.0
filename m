Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29EN7xl021445
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 09:23:07 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l29EN4to004274
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 14:23:05 GMT
Message-ID: <45F16DA6.40908@redhat.com>
Date: Fri, 09 Mar 2007 09:22:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: modutils needs to talk to terminal
References: <200703081438.l28EcJTr008890@localhost.localdomain> <1173445831.23674.10.camel@sgc.columbia.tresys.com>
In-Reply-To: <1173445831.23674.10.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-03-08 at 09:38 -0500, dwalsh@redhat.com wrote:
>   
>> --- nsaserefpolicy/policy/modules/system/modutils.te	2007-02-19 11:32:53.000000000 -0500
>> +++ serefpolicy-2.5.8/policy/modules/system/modutils.te	2007-03-08 09:34:35.000000000 -0500
>> @@ -118,7 +118,8 @@
>>  }
>>  
>>  ifdef(`targeted_policy',`
>> +	term_use_unallocated_ttys(insmod_t)
>>  	unconfined_domain(insmod_t)
>>  ')
>>     
>
> With the recent fixes to the terminal module, making ttys and ptys
> device nodes, this shouldn't be needed.
>
>   
So are you saying all term_use_unallocated_ttys can go away?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
