Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i19EqCRb004022
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 09:52:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i19EojQk012741
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 14:50:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i19EoiYo012738
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 14:50:44 GMT
Subject: Re: Issues relabeling filesystems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ignacio Tripodi <ignaciot@unt.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1076101806.402402aece754@eaglemail.unt.edu>
References: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu>
	 <1076080186.16170.13.camel@moss-spartans.epoch.ncsc.mil>
	 <1076101806.402402aece754@eaglemail.unt.edu>
Content-Type: text/plain
Message-Id: <1076338326.3523.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 09:52:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-06 at 16:10, Ignacio Tripodi wrote:
> Thanks! I downloaded the latest policy source and utilities from the cvs and now
> seems to be fine. Now I have a policy question:
> 
> After I edit the policy files and succesfully compile it, I can't seem to be
> able to load the new policy binary:
> 
> # load_policy policy.16
> security:  policydb version 16 does not match my version 15
> load_policy:  security_load_policy failed
> 
> I looked into the policy source files to see where it defines the version but
> couldn't find anything. How could I tell policydb which is the current version?

You either need to uncomment the POLICYCOMPAT definition in the policy
Makefile, or update to a kernel that includes the conditional policy
extension patch from Tresys.  I've now pushed the updated kernel to the
sourceforge CVS tree, although it will take a little bit to reach the
read-only mirrors.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
