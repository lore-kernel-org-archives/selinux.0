Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16LA9Rb025287
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 16:10:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16L8kQk014203
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 21:08:47 GMT
Received: from mailhost.unt.edu (mailhost.unt.edu [129.120.209.40])
	by jazzswing.ncsc.mil  with ESMTP id i16L8kYo014200
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 21:08:46 GMT
Received: from iatro (localhost.localdomain [127.0.0.1])
	by mail2 (Postfix) with SMTP id C96F86065F
	for <selinux@tycho.nsa.gov>; Fri,  6 Feb 2004 15:10:06 -0600 (CST)
Received: from eaglemail.unt.edu (imp1.private.acs.unt.edu [192.168.221.71])
	by mailhost.unt.edu (Postfix) with ESMTP id 3ED066065F
	for <selinux@tycho.nsa.gov>; Fri,  6 Feb 2004 15:10:06 -0600 (CST)
Message-ID: <1076101806.402402aece754@eaglemail.unt.edu>
Date: Fri,  6 Feb 2004 15:10:06 -0600
From: Ignacio Tripodi <ignaciot@unt.edu>
To: selinux@tycho.nsa.gov
Subject: Re: Issues relabeling filesystems
References: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu> <1076080186.16170.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1076080186.16170.13.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks! I downloaded the latest policy source and utilities from the cvs and now
seems to be fine. Now I have a policy question:

After I edit the policy files and succesfully compile it, I can't seem to be
able to load the new policy binary:

# load_policy policy.16
security:  policydb version 16 does not match my version 15
load_policy:  security_load_policy failed

I looked into the policy source files to see where it defines the version but
couldn't find anything. How could I tell policydb which is the current version?

Ignacio
CoPS Lab
University of North Texas


> If you want to use the setfiles from Fedora Core development, then you
> need to upgrade your glibc.  You could just build our setfiles,
> preferably from the sourceforge CVS tree.
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
