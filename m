Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74DJxrT028090
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 09:19:59 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i74DJvap017315
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 13:19:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i74DJwe1020211
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 09:19:58 -0400
Message-ID: <4110E27D.4080900@redhat.com>
Date: Wed, 04 Aug 2004 09:19:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@redhat.com>
CC: rcoker@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [patch] fix /var/run/console bits
References: <1091584911.8312.7.camel@nexus.verbum.private>	 <200408042007.03512.rcoker@redhat.com> <1091624615.9005.6.camel@nexus.verbum.private>
In-Reply-To: <1091624615.9005.6.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Wed, 2004-08-04 at 20:07 +1000, Russell Coker wrote:
>  
>
>>On Wed, 4 Aug 2004 12:01, Colin Walters <walters@redhat.com> wrote:
>>    
>>
>>>Currently /var/run/console is labeled as xdm_var_run_t, which is totally
>>>wrong, since it's actually owned by pam_console.  I noticed this while I
>>>was trying to work on the D-BUS policy, which recently gained console
>>>user authentication.
>>>
>>>Attached is a patch which creates a new type for it, grants the
>>>requisite permissions to login and xdm.  I still think we need a nicer
>>>way of mapping the PAM permissions in policy.  The only reason that
>>>login and xdm are granted these permissions is because they happen to
>>>ship with pam_console in their PAM stack on Fedora, presumably.  (IIRC
>>>Debian doesn't use pam_console).
>>>      
>>>
>>I think that perhaps the following would be good for the fc entry to keep the 
>>convention:
>>/var/run/console/(.*)?                     system_u:object_r:pam_var_console_t
>>    
>>
>
>Sounds good.
>
>  
>
>>This is not what we want.  Ideally we will never have any files of type 
>>var_run_t.
>>rw_dir_create_file(xdm_t, var_run_t)
>>rw_dir_create_file($1_login_t, var_run_t)
>>    
>>
>
>I agree, but unfortunately pam_console creates a lockfile
>named /var/run/console.lock.  We should probably fix that.
>
>  
>
>>I guess that the following code is to allow the xdm to check which login 
>>processes are active when searching for an unused virtual console.  
>>    
>>
>
>Ok.  I just thought it was weird at first glance, and worthy of a
>comment :)
>
>  
>
Ok I will change pam_console to put the lock file in /var/run/console 
directory.  Then you should be able to change the rules to create files
pam_var_console_t

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
