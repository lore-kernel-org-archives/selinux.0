Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2ALtFDo004325
	for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2005 16:55:15 -0500 (EST)
Message-ID: <4230C076.9000905@redhat.com>
Date: Thu, 10 Mar 2005 16:47:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: ***SPAM*** Re: Latest policy
References: <422E893D.1020802@redhat.com> <1110489782.662.15.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1110489782.662.15.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>Merged.
>
>I did notice that some of the changes to use read_sysctl() replaced
>statements like:
>allow foo_t sysctl_kernel_t:file r_file_perms;
>allow foo_t sysctl_kernel_t:dir r_dir_perms;
>instead of ones like:
>allow foo_t sysctl_kernel_t:dir search;
>allow foo_t sysctl_kernel_t:file read;
>This was the case for the following: fsadm.te, backup.te, clamav.te,
>gatekeeper.te, lvm.te, named.te, and clamav_macros.te.
>
>I didn't notice any problems though, so maybe they didn't need those
>permissions.
>
>  
>
Yes I have not heard any complaints about this yet.

>Do we need to add this?
>cy-1.21.15/file_contexts/program/nrpe.fc
>--- nsapolicy/file_contexts/program/nrpe.fc	2005-02-24 14:51:09.000000000 -0500
>+++ policy-1.21.15/file_contexts/program/nrpe.fc	2005-03-07 09:36:55.000000000 -0500
>@@ -1,3 +1,5 @@
> # nrpe
> /usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
> /etc/nagios/nrpe\.cfg	--	system_u:object_r:nrpe_etc_t
>+/usr/lib(64)?/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
>+/usr/lib(64)?/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
>
>  
>
This is probably me missing a removal, since I have done nothing with 
nrpe.   So eliminate this.

>These same statements are also in nagios.fc
>
>
>On Wed, 2005-03-09 at 00:27 -0500, Daniel J Walsh wrote:
>  
>
>>Lots of policy cleanup via Ivan's Patches
>>       Use read_sysctl
>>       Cleanup of homedir macros
>>      
>>Fixes to allow amanda to read file system
>>
>>Change apache stream sockets to use create_stream_socket_perms
>>
>>Eliminate cyrus_r
>>
>>Cleanup dhcpc.te so it can be used in targeted policy
>>
>>Add ftpd_anon_rw_t so that upload can be made to work with anonymous ftp 
>>sites.
>>
>>Additional rules to allow postfix to work correctly in targeted policy
>>
>>Allow snmpd to communicate with its own fifo_file
>>
>>    
>>
>
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
