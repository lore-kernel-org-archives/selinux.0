Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i525LTrT001590
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 01:21:29 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i535LDeD019596
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 01:21:14 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 10:34:48 -0000
Date: Tue, 1 Jun 2004 10:32:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Darren Tucker <dtucker@zip.com.au>
Cc: openssh-unix-dev@mindrot.org, pam-list@redhat.com,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
Message-ID: <20040601103214.GZ8312@lkcl.net>
References: <20040601090345.GM8312@lkcl.net> <40BC51DD.8090609@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40BC51DD.8090609@zip.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 07:52:29PM +1000, Darren Tucker wrote:
> Luke Kenneth Casson Leighton wrote:
> >but i cannot log in as an ordinary user, and i had to grant
> >special permission to the _user_ process (NOT sshd or pam
> >before a setuid and exec is carried out) to access
> >/dev/pts/0.
> 
> By "user process" do you mean sshd running as the user logging in?  If 
> so, that's probably because of Privilege Separation[1].  Try retesting 
> with "UsePrivilegeSeparation no" in sshd_config.
 
 ah ha!

 let's see.... YEP!  that does it.

 great!

 okay, so now in order to avoid one auditing experience or
 should i say something which requires special permissions to
 be allowed, i have to switch off something that is there for
 security reasons, ho hum.


> When privsep is on, sshd starts running as the user quite early, leaving 
> behind another process (the "monitor") running as root, while the 
> unprivileged sshd does most of the work (network comms, protocol 
> processing, compression and so on).  When the user requests a pty, one 
> is allocated by the monitor (pty allocation is a privileged operation on 
> some platforms) and a descriptor is passed to the unprivileged child 
> (the "slave"), which then forks, makes the pty its controlling tty runs 
> the shell.  This is probably what you're seeing.

 *glurk*...  i actually understood that.

 okay.

 the "expected" behaviour shall we say of the SE/linux auditing rules
 that russell has created is that only the sshd domain (where a
 domain correlates to a process, in this case the "monitor") has
 been given permission to do ioctl and read and write to the
 tty (/dev/pts/NN).

 and the "user" domain, i.e. after a fork() and set(e?)uid() / gid(),
 is most definitely NOT granted permission to read/write to ssh-specific
 ptys because only the sshd domain is allowed that.

 ... russell, et al, is there some way to reflect the above
 into SE/Linux auditing rules?

 l.


> >in other words, if i understand this correctly, there is a
> >bug somewhere in either sshd or pam where control of the
> >tty is given at the wrong point, or is not given at all.
> 
> It's not a bug, it's a Feature.
> 
> [1] http://www.citi.umich.edu/u/provos/ssh/privsep.html

 :)

 ta.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
