Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BHIbrB028838
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 13:18:37 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5BHIa0d022276
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 17:18:36 GMT
Message-ID: <466D83E9.2030801@redhat.com>
Date: Mon, 11 Jun 2007 13:18:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: fsdaemon writes files/disks at different levels, Needs write
 down.
References: <200705301422.l4UEMhjS007772@localhost.localdomain>	 <1181575535.16029.34.camel@sgc.columbia.tresys.com>	 <466D7D67.5010900@redhat.com> <1181581857.16029.40.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181581857.16029.40.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2007-06-11 at 12:50 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Wed, 2007-05-30 at 10:22 -0400, dwalsh@redhat.com wrote:
>>>   
>>>       
>>>> --- nsaserefpolicy/policy/modules/services/smartmon.te	2007-05-29 14:10:57.000000000 -0400
>>>> +++ serefpolicy-3.0.1/policy/modules/services/smartmon.te	2007-05-30 09:08:15.000000000 -0400
>>>> @@ -60,6 +60,7 @@
>>>>  fs_search_auto_mountpoints(fsdaemon_t)
>>>>  
>>>>  mls_file_read_up(fsdaemon_t)
>>>> +mls_file_write_down(fsdaemon_t)
>>>>  
>>>>  storage_raw_read_fixed_disk(fsdaemon_t)
>>>>  storage_raw_write_fixed_disk(fsdaemon_t)
>>>>     
>>>>         
>>> Looks to me that all of the devices smartmon should care about
>>> (fixed_disk_device_t) are all system high, so I'm not sure why this is
>>> needed.
>>>
>>>   
>>>       
>> Writing its pid file?
>>     
>
> Perhaps the pid file should be systemhigh too.  It might be only the pid
> number in the file, but do we want to trust it write down when it has
> raw disk access?
>
>   
This is why I hate MLS :^(

The only files in /var/run that are SystemHigh right now are.

/var/run/setrans(/.*)?       
gen_context(system_u:object_r:setrans_var_run_t,mls_systemhigh)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
