Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17485
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2001 14:20:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA15992
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2001 18:19:08 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id SAA15988
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2001 18:19:08 GMT
Date: Wed, 8 Aug 2001 14:19:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Forrest Whitcher <fw@fwsystems.com>
cc: SE Linux list <selinux@tycho.nsa.gov>
Subject: Re: selinux and AFS
In-Reply-To: <3B717D48.C76441D5@fwsystems.com>
Message-ID: <Pine.SOL.3.95.1010808140126.5634P-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 8 Aug 2001, Forrest Whitcher wrote:

> >From the kernel:
> --security_compute_av:  unrecognized SID 0
> --psid_release:  uninitialized super block
> 
> First in super.c lines 973, 981 - psid_release when afs attempts 
> the mount.

Ok, so this suggests that the AVC_HAS_PERM call on line 971 
of super.c passed a 0 for sb->s_sid.  So how was the super_block
structure allocated?  If it was allocated by get_empty_super
in fs/super.c, then it should have the unlabeled SID
(SECINITSID_UNLABELED), which is not 0.  So I don't know
why this would be 0.

> I then modified the former to never return an error code, thus 
> allowing the mount to proceed. At this point, every attempt to
> touch an object at or below the /afs root results in a repetition
> of the last diagnostic
> 
> --security_compute_av:  unrecognized SID 0

So, how are the inode structures allocated for AFS?  If they
use get_empty_inode or get_new_inode, then clean_inode 
initializes the inode to the unlabeled SID. Again, this
shouldn't be zero.

> in the mount attempt it is the ssid lookup - services.c l 272)

That's surprising.  The 'ssid' for the mount check would be
current->sid - the SID of the current process.  That is
set for the initial task, inherited by fork, and potentially
changed on execve in accordance with the policy.  So I don't
know how you are ending up with a 0 SID here.

> AFS identifies the inode of the 'AFS' type filesystem (mounted
> on /afs) as '0'. Is it likely that your routines are seeing the
> '0' inode number and giving up / returning the errors to the
> callers?

Shouldn't matter.  The filesystem and inodes should show up
with the unlabeled SID, and hence system_u:object_r:unlabeled_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
