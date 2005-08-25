Message-ID: <36282A1733C57546BE392885C06185920572FD@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "'Stephen Smalley '" <sds@tycho.nsa.gov>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Cc: "''Daniel J Walsh ' '" <dwalsh@redhat.com>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
   "''''SE Linux ' ' ' '" <selinux@tycho.nsa.gov>
Subject: RE: Ok I plead ignorance to the way MLS works.
Date: Thu, 25 Aug 2005 17:04:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Ok, I'll plead MCS ignorance :) I understand the clearance will be used for
read/write access. Should all system services have access to all files? If
not a runcon or range transition would need to occur before the service
starts. For a particular desktop/user session pam should reduce the
clearance to the desired value/range. How far off am I here?

-Chad  

-----Original Message-----
From: Stephen Smalley
To: Chad Hanson
Cc: 'Daniel J Walsh '; Darrel Goeddel; '''SE Linux ' ' '
Sent: 8/25/2005 8:53 AM
Subject: RE: Ok I plead ignorance to the way MLS works.

On Wed, 2005-08-24 at 17:45 -0400, Chad Hanson wrote: 
> This would be case. They would have an effective label of system low,
which
> is used for labeling and access purposes, and a clearance of system
high.
> The only processes not at system low would be those spawned by the
kernel
> itself instead of init. 

Understood for the real MLS policy, but under MCS, processes are allowed
to act based on their clearance, not their current level.  So Dan is
correct.

-- 
Stephen Smalley
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
