Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1EFxPL9000971
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2005 10:59:25 -0500 (EST)
Subject: Re: shm denials
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108395654.11637.3.camel@cobra.ivg2.net>
References: <1108222744.23018.5.camel@cobra.ivg2.net>
	 <1108393789.15437.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1108395654.11637.3.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108396290.15437.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 14 Feb 2005 10:51:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-14 at 10:40, Ivan Gyurdiev wrote:
> True, this seems to cut OpenGL performance in half. 
> 
> Enforcing mode:
> 
> 8071 frames in 5.0 seconds = 1614.200 FPS
> 9480 frames in 5.0 seconds = 1896.000 FPS
> 9480 frames in 5.0 seconds = 1896.000 FPS
> 
> Permissive mode / Enforcing mode with this allowed:
> 
> 13682 frames in 5.0 seconds = 2736.400 FPS
> 14729 frames in 5.0 seconds = 2945.800 FPS
> 14694 frames in 5.0 seconds = 2938.800 FPS
> 14718 frames in 5.0 seconds = 2943.600 FPS
> 14640 frames in 5.0 seconds = 2928.000 FPS
> 
> audit(1108395306.088:0): avc:  denied  { write } for  pid=11720
> comm=glxgears path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
> scontext=user_u:user_r:user_t
> tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

Yes, no surprise there.  Again, someone would need to assess the risk
posed by allowing it (e.g. does X create any shared memory objects that
should not be directly writable by the user domains, what safeguards
does X apply in handling the potentially malicious data from the shared
memory object, etc).  Possibly a candidate for a boolean.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
