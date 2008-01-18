Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0I9IoCZ027149
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 04:18:50 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0I9InaY005704
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 09:18:49 GMT
Date: Fri, 18 Jan 2008 20:17:00 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Valdis.Kletnieks@vt.edu
cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com,
        Paul Moore <paul.moore@hp.com>
Subject: Re: 2.6.24-rc8-mm1 and SELinux MLS - not playing nice....
In-Reply-To: <15439.1200642661@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.64.0801182015180.21631@us.intercode.com.au>
References: <15439.1200642661@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 18 Jan 2008, Valdis.Kletnieks@vt.edu wrote:

> Posting to both lists because I'm not sure who's at fault here....
> 
> System is a Dell Latitude D820, x86_64 kernel, userspace is basically
> Fedora Rawhide as of earlier today, in particular selinux-policy-mls-3.2.5-12.fc9
> 
> Trying to boot a 2.6.24-rc8-mm1 kernel gets me these msgs:
> 
> security:  5 users, 8 roles, 2043 types, 102 bools, 16 sens, 1024 cats
> security:  67 classes, 164754 rules
> security:  class peer not defined in policy
> security:  permission recvfrom in class node not defined in policy
> security:  permission sendto in class node not defined in policy
> security:  permission ingress in class netif not defined in policy
> security:  permission egress in class netif not defined in policy
> security:  permission forward_in in class packet not found in policy, bad policy
> security:  the definition of a class is incorrect

This looks the same as what akpm hit.  Paul Moore has updated his labeled 
networking patches (see Subject: [RFC PATCH v12 00/18] Labeled networking 
changes for 2.6.25), and you could try dropping those into the broken out 
-mm in place of the existing git patch, or just wait for a new -mm.

> 
> 2.6.24-rc6-mm1 said this instead:
> 
> security:  class peer not defined in policy
> security:  permission recvfrom in class node not defined in policy
> security:  permission sendto in class node not defined in policy
> security:  permission ingress in class netif not defined in policy
> security:  permission egress in class netif not defined in policy
> SELinux: policy loaded with handle_unknown=deny
> 
> and then proceeded to work OK.
> 
> (I suspect this may be the same thing Andrew Morton hit, but I can't be sure).
> 
> Anybody got hints on how to move forward?  Or is a fixed policy already in the
> Rawhide pipe?
> 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
