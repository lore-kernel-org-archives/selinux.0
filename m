Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82I0lrT001586
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 14:00:47 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82I0ev2019149
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 18:00:46 GMT
Message-ID: <41375FBF.30008@redhat.com>
Date: Thu, 02 Sep 2004 14:00:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: jwcart2@epoch.ncsc.mil, russell@coker.com.au,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest Patches
References: <200408241818.40064.russell@coker.com.au>	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>	 <200408282346.05926.russell@coker.com.au> <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil> <41371628.2020408@redhat.com> <41374AB7.70206@tresys.com>
In-Reply-To: <41374AB7.70206@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

> Daniel J Walsh wrote:
>
>> Include some stuff from Russell,
>> Critical patch for tmpfs to get udev on tmpfs working
>>
>> You sent me a note saying some patches conflict with other changes, 
>> please point those out so I can remove them.
>>
>> Dan
>>
>
> Why are you submitting a patch to the list that turns on all these 
> tunables? These should definately not be turned on in the sample policy!
>
> Joshua Brindle
>
I am just submitting the patch that is currently being applied to the 
Fedora package.  The tunables were always ignored in the past.
I suppose I could edit them but up to now they have not been a problem 
to ignore them.

Dan

>> diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun 
>> policy-1.17.9/tunables/tunable.tun
>> --- nsapolicy/tunables/tunable.tun    2004-08-27 14:44:11.000000000 
>> -0400
>> +++ policy-1.17.9/tunables/tunable.tun    2004-09-02 
>> 08:15:02.755586567 -0400
>> @@ -5,50 +5,47 @@
>>  dnl define(`user_net_control')
>>  
>>  # Allow users to execute the mount command
>> -dnl define(`user_can_mount')
>> +define(`user_can_mount')
>>  
>>  # Allow rpm to run unconfined.
>> -dnl define(`unlimitedRPM')
>> +define(`unlimitedRPM')
>>  
>>  # Allow privileged utilities like hotplug and insmod to run unconfined.
>> -dnl define(`unlimitedUtils')
>> +define(`unlimitedUtils')
>>  
>>  # Support NFS home directories
>> -dnl define(`nfs_home_dirs')
>> +define(`nfs_home_dirs')
>>  
>>  # Allow users to run games
>> -dnl define(`use_games')
>> +define(`use_games')
>>  
>>  # Allow ypbind to run with NIS
>> -dnl define(`allow_ypbind')
>> +define(`allow_ypbind')
>>  
>>  # Allow rc scripts to run unconfined, including any daemon
>>  # started by an rc script that does not have a domain transition
>>  # explicitly defined.
>> -dnl define(`unlimitedRC')
>> +define(`unlimitedRC')
>>  
>>  # Allow sysadm_t to directly start daemons
>>  define(`direct_sysadm_daemon')
>>  
>>  # Do not audit things that we know to be broken but which
>>  # are not security risks
>> -dnl define(`hide_broken_symptoms')
>> +define(`hide_broken_symptoms')
>>  
>>  # Allow sysadm_t to do almost everything
>>  dnl define(`unrestricted_admin')
>>  
>>  # Allow the read/write/create on any NFS file system
>> -dnl define(`nfs_export_all_rw')
>> -
>> -# Allow users to unrestricted access
>> -dnl define(`unlimitedUsers')
>> +define(`nfs_export_all_rw')
>>  
>>  # Allow the reading on any NFS file system
>>  dnl define(`nfs_export_all_ro')
>>  
>>  # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
>>  # Otherwise, only staff_r can do so.
>> -dnl define(`user_canbe_sysadm')
>> +define(`user_canbe_sysadm')
>>  
>>  # Allow xinetd to run unconfined, including any services it starts
>>  # that do not have a domain transition explicitly defined.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
