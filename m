Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94FLVrT018477
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 11:21:31 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94FLUs6014985
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 15:21:31 GMT
Subject: Re: SELinux  Doesn't Complete Initialization
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B1DADF@maat.darkhonor.net>
References: <A52BEA1D8EE8634B9196A136333637B1DADF@maat.darkhonor.net>
Content-Type: text/plain
Message-Id: <1096903127.32008.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 11:18:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
