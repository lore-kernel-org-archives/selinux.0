Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PAj6sJ023163
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 06:45:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PAhLZt008933
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 10:43:21 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8PAhLM3008930
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 10:43:21 GMT
Date: Thu, 25 Sep 2003 11:44:57 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925104456.GD10234@vnl.com>
References: <20030923150926.GG21997@vnl.com> <200309242334.55203.russell@coker.com.au> <20030924203129.GQ21997@vnl.com> <200309251332.53496.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309251332.53496.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 25, 2003 at 01:32:53PM +1000, Russell Coker wrote:
> On Thu, 25 Sep 2003 06:31, Dale Amon wrote:
> > avc:  denied  { search } for  pid=654 exe=/usr/sbin/sshd dev=sda2
> > ino=903169 scontext=system_u:system_r:sshd_t
> > tcontext=system_u:object_r:var_lib_t tclass=dir
> 
> What is in /etc/passwd for the sshd account?
> 
> > The only thing I see that looks even vaguely like a possible
> > target there is /var/lib/urandom.
> 
> That's not something that sshd should be accessing.
> 
> Does sshd work well without the access?  If so then a dontaudit rule is in 
> order.
> 
> > Okay, now I've still one more, and this one is really
> > confusing because ino=48726022 seems not to exist:
> >
> > 	48726022        <inode not found>
> >
> > I half wonder if I've got a bad link somewhere. It would
> > be easy enough to add an allow for this, but I'd like
> > to figure out why rather than blindly add things.
> >
> > avc:  denied  { read } for  pid=743 exe=/usr/sbin/sshd dev= ino=48726022
> > scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t
> > tclass=lnk_file
> 
> When you see that a domain is listed as the target (sshd_t is the tcontext) 
> for a file/dir/link_file access then it's an access to /proc/pid .  In this 
> case it's probably access to /proc/self/cwd or something.  In my latest 
> policy I have the following:
> dontaudit sshd_t proc_t:dir search;

I'll try adding that. However something is still very wrong here. From
log/auth on the selinux host when in enforcing mode (yes it works when not):

 Sep 25 11:40:26 cvs ssh(pam_unix)[394]: authentication failure; logname= uid=0 euid=0 tty=NODEVssh ruser= rhost=10.0.0.25  user=root
 Sep 25 11:40:32 cvs sshd[394]: Accepted password for root from 10.0.0.25 port 1160 ssh2
 Sep 25 11:40:32 cvs sshd[394]: default security context is root:staff_r:staff_t
 Sep 25 11:40:32 cvs sshd[394]: setting tty /dev/pts/2 context to root:object_r:staff_devpts_t
 Sep 25 11:40:32 cvs sshd[394]: fatal: chown(/dev/pts/2, 0, 5) failed: Permission denied
 Sep 25 11:40:32 cvs sshd[394]: error: chown /dev/pts/2 0 0 failed: Permission denied
 Sep 25 11:40:32 cvs sshd[394]: error: chmod /dev/pts/2 0666 failed: Permission denied

and these are the corresponding avcs:

 avc:  denied  { read } for  pid=394 exe=/usr/sbin/sshd dev= ino=25853959 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=lnk_file

I'm starting to wonder if this has anything to do with the
2.6.0 devpts filesystem?

	rootfs / rootfs rw 0 0
	/dev2/root2 / ext3 rw 0 0
	none /selinux selinuxfs rw 0 0
	proc /proc proc rw 0 0
	devpts /dev/pts devpts rw 0 0
	/dev/sdb1 /home/cvs reiserfs rw 0 0
	/dev/sdc1 /disk2 reiserfs rw 0 0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
