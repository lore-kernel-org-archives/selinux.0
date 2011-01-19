Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0JJUKQ2008274
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 14:30:20 -0500
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0JJUJgc029849
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 19:30:19 GMT
Received: by pxi2 with SMTP id 2so243543pxi.12
        for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 11:30:18 -0800 (PST)
Message-ID: <4D373BC5.9080609@gmail.com>
Date: Wed, 19 Jan 2011 11:30:13 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] WARNING: at kernel/printk.c:430 do_syslog+0x40d/0x441()
References: <4D372829.5090509@gmail.com> <4D373A36.3050504@tresys.com>
In-Reply-To: <4D373A36.3050504@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/19/11 11:23, Christopher J. PeBenito wrote:
> On 01/19/11 13:06, Justin P. Mattock wrote:
>> this is showing up with the latest kernel in enforcing mode..
>> (I have not update the policy and/or selinux userspace)
>>
>> [   12.803882] type=1400 audit(1295457694.801:3): avc:  denied  { syslog
>> } for  pid=1540 comm="rsyslogd" capability=34
>> scontext=system_u:system_r:init_t:s0
>> tcontext=system_u:system_r:init_t:s0 tclass=capability2
> [cut]
>> when using audit2allow I get:
>>
>> allow init_t self:capability2 syslog;
>>
>> which gives an error when trying to install the module, due to the
>> policy not knowing what capability2 is
>>
>> system is ubuntu maverick, if this is already in(refpolicy) then I'll
>> pull the latest when I get a chance..
>
> Support for this capability is upstream in refpolicy.
>

all right... then I shall pull the latest, and load her up!!

Thanks..

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
