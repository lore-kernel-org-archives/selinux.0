Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA24535
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:10:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA28434
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 21:09:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA28430
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 21:09:44 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id QAA04449
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:09:25 -0500 (EST)
Date: Tue, 26 Dec 2000 16:09:24 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: questions
In-Reply-To: <20001226204517.A2967@bunuel.tii.matav.hu>
Message-ID: <Pine.SOL.3.95.1001226150034.29240R-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Tue, 26 Dec 2000, Magosanyi Arpad wrote:

> Some irrelevant little notes:
> - chmod a+x flask/mkaccess_vector.sh and chmod a+x flask/mkflask.sh was
> necessary, on 2.2.17. Maybe writing the makefile in such a way that they
> don't need execute permission would be a nice idea. I know that this is
> absolutely unnecessary cosmetics.

Good point.  Yes, we can certainly change the flask Makefile to
avoid the need for explicit execute permission on these two scripts.

> - On policy_parse.y yacc always choked on line 228. There were two consecutive
> lines containing a single ';'. I guess it is due to some syntax error in my
> /etc/security/*, or the m4 tricks.

I don't see two consecutive lines with a single ';' in policy_parse.y on
line 228.  Can you provide more information?  An error from yacc on
the policy language grammar wouldn't have anything to do with the
/etc/security files or the policy configuration itself.  Also,
what platform are you using to build the system?

> - Why redhat? I think that giving the patches relative to the upstream source
> would be a nicer solution. I am still wrestling with the userspace, maybe
> I do not have some tools or something. Having a Makefile instead a (horror!)
> csh script would greatly simplify the task. (Well, I have modified the script
> for bash, because I don't have csh on my system, and can use set -e)

The kernel patches are based on the kernel.org sources.  Perhaps we could
provide patches relative to the upstream sources for the other packages
in the future.  However, the kernel security enhancements and the policy
configuration are the priorities of the project.  The utility
modifications serve to demonstrate the kernel features, but are not
fundamental to the system.  The current scripts for building and
installing are likely to be replaced by RPM specfiles.

> I have studied the ext2 patches, and I am reasonably sure that I know
> what to do with reiserfs, but have a problem: in the reiser code there is no
> reserved or otherwise unused space in the disk inode structure. I could not find
> anything resembling to resource fork or space for acl either. Maybe having the
> inode<->psid mapping in the special directory for filesystems without direct 
> support would be a reasonable temporary solution.

In the Flask research prototype, this approach was used for the
inode-to-psid mapping, since the file system mandatory access controls
were implemented as a wrapper layer around the OSKit file system COM
interfaces and did not have access to the low-level inode structures.  
So you could certainly use this approach.

> For lvm, I don't have a clue as what to look for. I guess that standard 
> capability checks would be sufficient. I either don't know if these are 
> implemented in the lvm code. Anyone having more ideas than me?

I haven't used LVM.  

> I am also interested in the network code (but first I want to get to the
> stage where I can boot the thingie). I hope that Zorp's mandatory access
> control can be combined with this. Is the following is true?:
> In the current implementation flask can label hosts based on their
> claimed IP address, but cannot handle other multilevel hosts due to lack
> of ipsec integration?

Currently, Security-Enhanced Linux labels received messages based on
the receiving network interface.  Security contexts are associated
with hosts (nodes) and used in certain permission checks, but
the host identity is not currently used in determining the message
label since it is unreliable.  The plan is to integrate IPSEC support
with the network mandatory access controls as was done in the
Flask research prototype and the DTOS research prototype.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com










You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
