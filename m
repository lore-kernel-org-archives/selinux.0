Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1EFeQL9000804
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2005 10:40:27 -0500 (EST)
Subject: Re: shm denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108393789.15437.53.camel@moss-spartans.epoch.ncsc.mil>
References: <1108222744.23018.5.camel@cobra.ivg2.net>
	 <1108393789.15437.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 10:40:54 -0500
Message-Id: <1108395654.11637.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
>There are rules in the policy allowing read access for user domains and
>x client program domains to this type, to support shared memory
>communication with X as an optimization.  I would have expected the
>writes to occur to a shared memory object created by the user domain / x
>client domain (and thus labeled with user_tmpfs_t) that would then be
>read by X, but this seems to be a direct write to the shared memory
>object created by X.  I would expect the application to fall back to the
>slower IPC-based communication mechanism if this fails, so it shouldn't
>be fatal, but someone might want to assess the risk posed by allowing it
>(e.g. can a user domain / x client domain corrupt X by such direct
>writing to a shared memory object created by X).

True, this seems to cut OpenGL performance in half. 

Enforcing mode:

8071 frames in 5.0 seconds = 1614.200 FPS
9480 frames in 5.0 seconds = 1896.000 FPS
9480 frames in 5.0 seconds = 1896.000 FPS

Permissive mode / Enforcing mode with this allowed:

13682 frames in 5.0 seconds = 2736.400 FPS
14729 frames in 5.0 seconds = 2945.800 FPS
14694 frames in 5.0 seconds = 2938.800 FPS
14718 frames in 5.0 seconds = 2943.600 FPS
14640 frames in 5.0 seconds = 2928.000 FPS

audit(1108395306.088:0): avc:  denied  { write } for  pid=11720
comm=glxgears path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
scontext=user_u:user_r:user_t
tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
