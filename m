Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LCjSWt026116
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 08:45:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LCjFIS017509
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:45:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9LCjEDc017506
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:45:14 GMT
Subject: Re: old SE Linux patch for procps 3.1.12
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Colin Walters <walters@verbum.org>
In-Reply-To: <200310211106.01376.russell@coker.com.au>
References: <200310191452.43127.russell@coker.com.au>
	 <1066655423.22196.18.camel@moss-spartans.epoch.ncsc.mil>
	 <200310211106.01376.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066740323.27065.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 08:45:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 21:06, Russell Coker wrote:
> Yes.  However I don't think that Albert was planning to write it himself...

You might want to check with him, as that was my impression.  He seemed
to favor the idea of directly implementing support for /proc/pid/attr
and avoiding any SELinux-specific patch or any dependency on
libselinux.  In any event, it doesn't matter to us, as that isn't the
upstream procps for RH last I checked.

> procps currently has support upstream for the old SE Linux, and I don't expect 
> things to change until/unless we submit appropriate patches.

procps 3.x ChangeLog says that support for SELinux has been dropped due
to the new kernel interface.

> In my tree I have implemented quite a bit of the new SE Linux API for old SE 
> Linux.  For example I have the runcon and chcon programs from the new SE 
> Linux running on the old SE Linux.  It won't be much extra work to get it to 
> the stage of having a procps patch for the new SE Linux which compiles for 
> old SE Linux too.

This isn't a priority to us; supporting old SELinux is not our concern.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
