Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9L0qaWt023753
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:52:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9L0qYmR006667
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 00:52:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9L0qXjp006660 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 00:52:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: init patch for loading policy
Date: Tue, 21 Oct 2003 10:52:28 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310200148.15852.russell@coker.com.au> <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310211052.28494.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2003 04:02, Stephen Smalley wrote:
> > I've attached a patch for /sbin/init to load the policy and set enforcing
> > mode.
>
> Would it be cleaner to just do this via a script run from
> /etc/rc.d/rc.sysinit?  It seems a bit ugly to patch this directly into
> /sbin/init.  The script could perform a 'telinit u' after loading the
> policy to trigger the domain transition for the init process, and would
> simply return immediately upon the second invocation when it detected
> that selinuxfs was already mounted.

Firstly we would need to test that init will actually respond correctly to 
"telinit u" while it's in that stage.  This is something I am concerned 
about, particularly regarding race conditions regarding the completion of 
rc.sysinit (although I guess it's unlikely that rc.sysinit will complete 
before init restarts).

Then there's the issue that rc.sysinit has to get the correct context, so we 
probably need domain_auto_trans(kernel_t, initrc_exec_t, initrc_t).

> > 4)  Check /proc/filesystems for selinuxfs entry, if it's not there then
> > we aren't running an SE Linux kernel so go to FINISH.  If it's there then
> > we have a serious error condition so go to ERR (I forgot to close a file
> > handle, not that it matters much - I'll fix it later).
>
> This should be indicated by the return code / error message when you try
> to mount selinuxfs.
>
> > 6)  Set enforcing mode, if error then go to ERR.
>
> This will always fail on a kernel that was built with
> CONFIG_SECURITY_SELINUX_DEVELOP=n, as /selinux/enforce will not define a
> write operation in that case.  Also, it would require booting with an
> alternate init program in order to boot permissive.  There doesn't seem
> to be any reason to do this, as you can specify enforcing=1 on the
> kernel command line or enable it via rc.sysinit if desired.

OK.  I'll write a new version of the patch to address these issues.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
