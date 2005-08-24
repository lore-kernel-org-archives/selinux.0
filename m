Message-ID: <430CD868.2070900@redhat.com>
Date: Wed, 24 Aug 2005 16:28:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: "'Stephen Smalley '" <sds@tycho.nsa.gov>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   "''SE Linux ' '" <selinux@tycho.nsa.gov>
Subject: Re: Ok I plead ignorance to the way MLS works.
References: <36282A1733C57546BE392885C06185920572F7@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C06185920572F7@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
>>>So you'd prefer transitioning to system low upon executing /sbin/init?
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
>>>And we still have to transition login to a range so that users can login
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
