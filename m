Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KI2PWt021717
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 14:02:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KI2D0p021417
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 18:02:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9KI2Dr7021414
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 18:02:13 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310200148.15852.russell@coker.com.au>
References: <200310200148.15852.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 14:02:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-10-19 at 11:48, Russell Coker wrote:
> I've attached a patch for /sbin/init to load the policy and set enforcing 
> mode.  

Would it be cleaner to just do this via a script run from
/etc/rc.d/rc.sysinit?  It seems a bit ugly to patch this directly into
/sbin/init.  The script could perform a 'telinit u' after loading the
policy to trigger the domain transition for the init process, and would
simply return immediately upon the second invocation when it detected
that selinuxfs was already mounted.

> 3)  Mount /proc, if error then go to FINISH (*).
> 4)  Check /proc/filesystems for selinuxfs entry, if it's not there then we 
> aren't running an SE Linux kernel so go to FINISH.  If it's there then we 
> have a serious error condition so go to ERR (I forgot to close a file handle, 
> not that it matters much - I'll fix it later).

This should be indicated by the return code / error message when you try
to mount selinuxfs.

> 6)  Set enforcing mode, if error then go to ERR.

This will always fail on a kernel that was built with
CONFIG_SECURITY_SELINUX_DEVELOP=n, as /selinux/enforce will not define a
write operation in that case.  Also, it would require booting with an
alternate init program in order to boot permissive.  There doesn't seem
to be any reason to do this, as you can specify enforcing=1 on the
kernel command line or enable it via rc.sysinit if desired.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
