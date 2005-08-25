Subject: RE: Ok I plead ignorance to the way MLS works.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "'Daniel J Walsh '" <dwalsh@redhat.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   "'''SE Linux ' ' '" <selinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C06185920572F8@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185920572F8@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 08:53:11 -0400
Message-Id: <1124974391.3873.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 17:45 -0400, Chad Hanson wrote: 
> This would be case. They would have an effective label of system low, which
> is used for labeling and access purposes, and a clearance of system high.
> The only processes not at system low would be those spawned by the kernel
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
