Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA17036
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 17:59:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA06076
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 21:58:14 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id VAA06072
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 21:58:11 GMT
Date: Thu, 26 Sep 2002 07:59:24 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: limiting types on a file system
Message-ID: <20020925215924.GI26806@snoopy.apana.org.au>
References: <200209251622.02323.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209251622.02323.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 25, 2002 at 04:22:02PM +0200, Russell Coker wrote:
> Maybe something like the following:
> type_transition user_mount_t removable_device_t:filesystem { user_home_dir_t 
> user_home_t };
> 
> Then any types other than those two would appear as unlabelled_t.  Of course 
> the problem with this is that if you use chsid to change the type of a file 
> (or create a file with Netscape) then it'll effectively disappear at the next 
> mount!  Unless the domain used to mount the file system is tracked right 
> through (which is ugly).

Would you want to allow the disk to be labelled based on information
stored on that disk?

I think this goes against the principles behind SE-Linux, where
it is the system adminstrator who is in control of the system,
not each user.

Also floppy disks are typically small, and you want to maximize
available space.

How about a fixed type depending on who is doing the mount command,
and what parameters they use?

(eg. so one user may want the floppy disk to save files downloaded
from netscape, but another user may want to prevent netscape having
any access)

Are there any implications here in case the user wants to back
up their private gpg key on floppy disk?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
