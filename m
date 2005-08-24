Message-ID: <36282A1733C57546BE392885C06185920572F8@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "'Daniel J Walsh '" <dwalsh@redhat.com>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Cc: "''Stephen Smalley ' '" <sds@tycho.nsa.gov>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
   "'''SE Linux ' ' '" <selinux@tycho.nsa.gov>
Subject: RE: Ok I plead ignorance to the way MLS works.
Date: Wed, 24 Aug 2005 17:45:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 

This would be case. They would have an effective label of system low, which
is used for labeling and access purposes, and a clearance of system high.
The only processes not at system low would be those spawned by the kernel
itself instead of init. 

-Chad

-----Original Message-----
From: Daniel J Walsh
To: Chad Hanson
Cc: 'Stephen Smalley '; Darrel Goeddel; ''SE Linux ' '
Sent: 8/24/2005 4:28 PM
Subject: Re: Ok I plead ignorance to the way MLS works.

Chad Hanson wrote:

> 
>
>  
>
>>>System high or ranged from system low to system high?  It still needs
>>>MLS privileges to act at any level, right?
>>>      
>>>
>
>System High would be preferred.  kernel_t does need MLS attributes to
>override the MLS policy.
>
>
>  
>
>>>So you'd prefer transitioning to system low upon executing
/sbin/init?
>>>init will still need MLS privileges so that it can kill and reap all
>>>processes.
>>>      
>>>
>
>I'd prefer the transition to run init at system low with a clearance of
>system high.
>
>
>  
>
>>>And we still have to transition login to a range so that users can
login
>>>with their clearance set to their highest authorized level.
>>>      
>>>
>
>With init at system low to system high, login would handle setting the
>labels.
>
>-Chad
>  
>
Except I don't want all the other apps started by init at anything 
higher the system low for MCS.

Dan

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
