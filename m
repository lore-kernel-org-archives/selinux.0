Subject: RE: Ok I plead ignorance to the way MLS works.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>,
   "'Daniel J Walsh '" <dwalsh@redhat.com>,
   "'SE Linux '" <selinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C06185920572F2@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185920572F2@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 15:29:30 -0400
Message-Id: <1124911770.11553.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 15:11 -0400, Chad Hanson wrote:
>  The kernel should be treated as a system high process and everything it does
> as system high. I think making the kernel system low is bad because the
> kernel shouldn't need overrides to access data and objects it has direct
> access to.

System high or ranged from system low to system high?  It still needs
MLS privileges to act at any level, right?

So you'd prefer transitioning to system low upon executing /sbin/init?
init will still need MLS privileges so that it can kill and reap all
processes.

And we still have to transition login to a range so that users can login
with their clearance set to their highest authorized level.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
