Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JCWiI4002874
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 08:32:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JCWMQj026310
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 12:32:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4JCWMxS026307
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 12:32:22 GMT
Subject: Re: rw_sem_perms() etc
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200305192132.12745.russell@coker.com.au>
References: <200305192132.12745.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1053347556.4729.965.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 May 2003 08:32:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-05-19 at 07:32, Russell Coker wrote:
> Would it make sense to change the rw_sem_perms() and rw_shm_perms() macros to 
> not permit create and destroy access, and then add some new macros 
> create_sem_perms() and create_shm_perms()?
> 
> Doing so would make the semaphore and shared memory macros have the same style 
> as the macros for file and directory permissions which will potentially save 
> confusion.

Yes, and likewise for the msgq macros as well.  You might also want to
remove setattr permission from the rw_*_perms macros, as was already
done for the file macros, granting this separately when appropriate.

A few unrelated possible refinements to the global macros include:  
- removing lock and ioctl from the file macros and granting them more
selectively.
- replacing can_network with a macro that takes explicit parameters
indicating the network interface type(s), network message type(s), and
node type(s), and removing the mount_t rule from that macro.
- adding a third parameter to can_unix_connect and can_unix_send
indicating the type of the socket file (vs. the type of the socket
itself, two independent things), and add an allow rule granting
permission to the socket file to this macro rather than needing to
separately specify an allow rule whenever this macro is used.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
