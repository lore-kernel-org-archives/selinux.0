Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n36HrcKH028444
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 13:53:38 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n36HrbBS016891
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 17:53:37 GMT
Message-ID: <49DA419E.8030705@redhat.com>
Date: Mon, 06 Apr 2009 13:53:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: m <maximilianbianco@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: request for review of httpd-related Boolean definitions
References: <20090331151638.770627cb@redhat.com> <1238495418.3465.69.camel@notebook2.grift.internal> <49D22BEA.8020403@gmail.com>
In-Reply-To: <49D22BEA.8020403@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>

>>> o httpd_execmem
>>
>> tunable_policy(`httpd_execmem',`
>> allow httpd_t self:process { execmem execstack };
>> allow httpd_sys_script_t self:process { execmem execstack };
>> allow httpd_suexec_t self:process { execmem execstack };
>> ')
>> Note that is also allows execstack.
>> Note that it allows it also for httpd_sys_script_t
>> Note that it *does not* allow it for httpd_user_script_t ( or any other
>> templated httpd script)
>
> I think here he is looking to understand what exactly execmem allows. My
> understanding is that it allows memory to be both writeable and
> executable which is a no no but often required because of some
> questionable programming practices. Please correct me if I am wrong but
> if the above is correct then this allows the webserver to make memory
> both writeable and executable, something that should be avoided.
>
Yes correct.  Turning on this boolean will allow apache to execute 
programs that require writable/executable memory.  Java/Mono type apps 
could require this, but it should seldom be set.   Turning this on 
eliminates some level of buffer overflow protection.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
