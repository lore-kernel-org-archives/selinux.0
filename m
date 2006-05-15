Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4FKsLY9031878
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 16:54:21 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4FKsKro026487
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 20:54:20 GMT
Message-ID: <4468EA7C.5050708@redhat.com>
Date: Mon, 15 May 2006 16:54:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs in policy
References: <4468A509.50207@redhat.com> <1147719382.31984.11.camel@sgc>
In-Reply-To: <1147719382.31984.11.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Questions inline:
>
> On Mon, 2006-05-15 at 11:58 -0400, Daniel J Walsh wrote:
>   
>> Add boolean to allow mount to mount any file/filesystem.  (Bind Mounts).
>>
>> More fixes for auditadm role.  Any chance of getting this into ref 
>> policy or should I separate out the patch?
>>     
>
> Is this required for LSPP?
>
>   
Yes
>> Fixes for traceroute
>>
>> prelink wants to read sbin symlinks
>>
>> Mono needs to chat with unconfined_t (acquire_svc).
>>
>> Fix label on scsi_id to stop matchpathcon error message
>>
>> Lots of new network ports for hplib and http.
>>
>> Traceroute port range defined.
>>
>> Add setrans domain
>>
>> Want to associate all files with tmpfs so the user can mv /etc/FILE /tmp 
>> and not blow up.
>>
>> Add clamscan policy
>>
>> Allow bluetooth to communicate with xdm pipes.
>>     
>
> Fixed the XML docs for the interfaces and moved them up with the other
> xdm_t interfaces.
>
>   
>> Allow sysadm to run cvs and rdisk
>>
>> Dovecod wants quota support
>>
>> ftpd needs dac override when logging in to users homedirs
>>
>> Hal wants to search all directories in case they are mount points
>>
>> Fixes to inn.if for executing inn and allowin domtrans
>>
>> ypbind needs to be able to bind to rpc ports
>>
>> postgresql wants to look at the routing table.
>>
>> pyzor domain for strict/mls policy
>>
>> rpc wants to red /dev/random
>> nfsd needs dac privs
>>
>> Added some corecmd_executable_file for prelink to work correctly
>>
>> sshd wants to read routing table
>>
>> Only want dhcp to transition to hostname everyone else should just 
>> execute it.
>>     
>
> How can this work without giving initrc_t sys_admin capability (e.g.,
> static IP config)?
>
>   
I will have to try.  Hostname is a pain in the ass....

>> More fixes for textrel_shlib_t. will they ever end
>>
>> Separation of the auditadm from secadm and sysadm changes for auditd files.
>>     
>
> Filesystem association is missing.  This also brings along more problems
> like labeling.  There isn't much real separation between auditadm from
> the other admin roles, so this doesn't seem to have real benefits.
>   
Required for LSPP.  auditadm is not allowed to do anything but manage 
audit subsystem.
secadmin can only manage selinux stuff.  sysadmin can only do everything 
not done by auditadm
and secadm.
>   
>> semanage is now translated.
>>
>> semodule needs to be able to read home dir and /tmp dir since this is 
>> where people are creating modules.
>>
>> ifconfig wants to read urand for ipsec setup
>>
>> unconfined domtrans to prelink and inn
>>     
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
