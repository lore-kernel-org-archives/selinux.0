Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NILorT011600
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 14:21:51 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NILnUk027634
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 18:21:50 GMT
Message-ID: <4153143C.2090405@redhat.com>
Date: Thu, 23 Sep 2004 14:21:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "James R. Marcus" <jmarcus@mvalent.net>
CC: selinux@tycho.nsa.gov
Subject: Re: bash_profile: Permission denied
References: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local>
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James R. Marcus wrote:

>What is the right way to deal with this issue?  When root logs in should
>they automatically be in the sysadm_r role or should these files be
>labeled with staff_r?
>
>  
>
It is working the way it was designed.  In Fedora Core, we changed to  
use staff_* for the home directory, because
we thought it was too confusing for the users.  There is a security risk 
to having the root account owned by staff*
Basically if I can some how modify .bash_profile as a staff user, then 
get the sysadm to login as sysadm_r he will execute
my code as sysadm_r.

Dan

>Do I need to change this in /etc/security/selinux/file_contexts ?
>
>This is what I have in file_contexts:
>#
># User-specific file contexts
>#
>/root           -d      root:object_r:sysadm_home_dir_t
>/root/.+                        root:object_r:sysadm_home_t
>/root/\.ssh(/.*)?               root:object_r:sysadm_home_ssh_t
>/root/.default_contexts --      system_u:object_r:default_context_t
>/root/.ccache(/.*)?             system_u:object_r:sysadm_ccache_t
>
>
>Thanks,
>James
>-----Original Message-----
>From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
>Sent: Thursday, September 23, 2004 1:31 PM
>To: James R. Marcus
>Cc: selinux@tycho.nsa.gov
>Subject: Re: bash_profile: Permission denied
>
>James R. Marcus wrote:
>
>  
>
>>When I login in enforced mode I get this error as root:
>>-bash: /root/.bash_profile: Permission denied
>>ftp root # pwd       
>>/root
>>ftp root # ls -aZ
>>ls: .: Permission denied
>>ftp root #
>>
>>I thought it might be a labeling issue so I ran this command:
>>ftp domains # newrole -r sysadm_r
>>Authenticating root.
>>Password: 
>>ftp domains # cd /
>>ftp / # setfiles /etc/security/selinux/file_contexts /root/
>>setfiles:  read 575 specifications
>>setfiles:  labeling files under /root/
>>setfiles:  hash table stats: 5 elements, 5/65536 buckets used, longest
>>chain length 1
>>setfiles:  Done.
>>
>>I'm not getting any messages in /var/log/messages when I avc_toggle.
>>
>>
>>Am I on the right track?
>>
>>James
>> 
>>
>>    
>>
>The problem is probably that you are logging as staff_r and the 
>directory is sysadm_r.
>At login do an id -Z to see what context you have,
>then do the newrole -r sysadm_r and see if you have access to the
>directory.
>
>Dan
>
>  
>
>>
>>
>>--
>>This message was distributed to subscribers of the selinux mailing
>>    
>>
>list.
>  
>
>>If you no longer wish to subscribe, send mail to
>>    
>>
>majordomo@tycho.nsa.gov with
>  
>
>>the words "unsubscribe selinux" without quotes as the message.
>> 
>>
>>    
>>
>
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
