Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94HbXrT020016
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 13:37:33 -0400 (EDT)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94HbXs6020123
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 17:37:33 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: SELinux  Doesn't Complete Initialization
Date: Mon, 4 Oct 2004 13:40:50 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B130E4@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for the advice. However, due to the system requirements of my
course, I need to have it working on a FC2 system. What packages would
be required then? Here is the list of packages from the development tree
that I figured would be required:

SysVinit-2.85-33
checkpolicy-1.17.5-1
coreutils-5.2.1-26
initscripts-7.86-1
kernel-<latest>
libselinux-1.17.13-3
libsepol-1.1.1-2
mkinitrd-4.1.14-1
openssh-3.9p1-7
openssh-clients-3.9p1-7
openssh-server-3.9p1-7
pam-0.77-60
passwd-0.68-10
procps-3.2.3-5
psacct-6.3.2-31
selinux-policy-strict-1.17.26-1
selinux-policy-strict-source-1.17.26-1
setools-1.4-2
shadow-utils-4.0.3-30
star-1.5a25-6
system-config-securitylevel-1.4.7-1
util-linux-2.12a-10
vixie-cron-4.1-17

Any corrections/deletions from this list would be appreciated.  Thanks!

Alex Ackerman
http://www.darkhonor.com

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil] 
Sent: Monday, October 04, 2004 11:19 AM
To: Alex Ackerman
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux Doesn't Complete Initialization

On Wed, 2004-09-22 at 14:27, Alex Ackerman wrote:
> I'm working on a master's thesis on SELinux and I'm trying to get it
> up and running on my home server.  I am able to compile, install, and
> load the policy via "make load" in the policy source directory,
> however I'm unable to get it to come all the way up on a boot.  On my
> last go, I set the contexts for the filesystems using the "make
> relabel" function call.  There is never an "SELinux: Initialization
> Complete" message and the system defaults to SELinux disabled.  Any
> help would be greatly appreciated.  Here are the details.

This implies that /sbin/init is never loading policy.  From your
message, you seem to be running a blend of FC2 with selective rawhide
updates related to SELinux - note that you also need an updated SysVinit
(and related components, e.g. libsepol).  Might be easier to just
install FC3T2.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
