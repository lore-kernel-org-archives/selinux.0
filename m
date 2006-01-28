Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0SLHQXf019613
	for <selinux@tycho.nsa.gov>; Sat, 28 Jan 2006 16:17:26 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0SLHOaG006268
	for <selinux@tycho.nsa.gov>; Sat, 28 Jan 2006 21:17:24 GMT
Message-ID: <43DBDF72.5050109@redhat.com>
Date: Sat, 28 Jan 2006 16:17:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diff
References: <43D9BF9F.2010601@redhat.com> <1138392470.9344.150.camel@sgc>
In-Reply-To: <1138392470.9344.150.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2006-01-27 at 01:37 -0500, Daniel J Walsh wrote:
>   
>> Want to drop sensitivity level on rpm and lvm when run by kernel or 
>> sysadm_t at SystemHigh.
>>     
>
> This seems to contradict what you have in the patch:
>   
What I meant is that when lvm is started by the kernel it is running at 
SystemHigh and there for some files that get
created are SystemHigh.  Specifically a lnk_file in /dev/  Which 
processes try to read and now they get AVC messages.
Turns out that restorecon was broken when restoring symlinks on /dev.  
So fixing restorecon has removed the need for this
range_transition.  Although lvm running at SystemHigh, is probably not 
really needed. 

The other range_transition is to solve an Administrator from running RPM 
from sysadm_t:SystemHigh.  I did this by accident and ended up with some 
files like /etc/ld.so.cache labeled as SystemHigh.  Needless to say this 
caused problems with applications.



>   
>> @@ -86,7 +86,8 @@
>>  ')
>>  
>>  ifdef(`enable_mls',`
>> -# run init with maximum MLS range
>>  range_transition kernel_t init_exec_t s0 - s15:c0.c255;
>> +range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
>>  range_transition initrc_t auditd_exec_t s15:c0.c255;
>> +range_transition sysadm_t rpm_exec_t s0 - s15:c0.c255;
>>  ')
>>     
>
> Also, why are these needed instead of just using the MLS interfaces?
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
