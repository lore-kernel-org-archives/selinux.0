Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RAlisJ005539
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 06:47:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8RAlgCI011648
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 10:47:43 GMT
Date: Sat, 27 Sep 2003 11:47:35 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030927104735.GA22582@vnl.com>
References: <20030923150926.GG21997@vnl.com> <20030925104456.GD10234@vnl.com> <20030925121733.GF10234@vnl.com> <200309252221.09162.russell@coker.com.au> <1064494538.5099.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1064494538.5099.7.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm still at work on the sshd problem. Just as a summary:

	kernel: 2.6.0-test5
	using devpts
	Russell Coker policy
	Colin's selinux experimental branch debian packages

Via the artifice of 
	/root/newrules.pl > /etc/selinux/domain/tmp.te
	make load

I've been able to get a copy of Colin's ssh source running with
my own added debugging printout. I've (thus far) not been able
to get sshd running under gdb with enforcing on so I can't get
much of a look at the ephemeral /dev/pts.

I've captured the point of failure though, and am not sure why
it should be so since it happens only with enforcing turned on:

#				TEST 1 ENFORCE=1
#
# ssh refuses rhost authentication
Sep 27 11:10:30 cvs ssh(pam_unix)[515]: authentication failure; logname= uid=0 euid=0 tty=NODEVssh ruser= rhost=scout.islandone.org  
user=root

# ssh accepts password as valid
Sep 27 11:10:37 cvs sshd[515]: Accepted password for root from 10.0.0.25 port 2968 ssh2

# ssh sets security context
Sep 27 11:10:37 cvs sshd[515]: default security context is root:staff_r:staff_t

# ssh has a pty now
Sep 27 11:10:37 cvs sshd[515]: setting tty /dev/pts/0 context to root:object_r:staff_devpts_t

# But it fails a test in sshpty.c where it does a stat on the file and compares the
# results of the stat. The failure is caused by st.gid = 0 instead of the expected 5.
# (DMA is a token on my debug statements)
Sep 27 11:10:37 cvs sshd[515]: fatal: DMA pty=/dev/pts/0 pwuid=0 stuid=0 gid=5 stgid=0 

# We see further failures as it tries to release the pty
Sep 27 11:10:37 cvs sshd[515]: error: chown /dev/pts/0 0 0 failed: Permission denied
Sep 27 11:10:37 cvs sshd[515]: error: chmod /dev/pts/0 0666 failed: Permission denied


#				TEST 1 ENFORCE=0
#
# First part is the same
Sep 27 11:32:45 cvs ssh(pam_unix)[559]: authentication failure; logname= uid=0 euid=0 tty=NODEVssh ruser= rhost=scout.islandone.org  
user=root
Sep 27 11:32:50 cvs sshd[559]: Accepted password for root from 10.0.0.25 port 2982 ssh2
Sep 27 11:32:50 cvs sshd[559]: default security context is root:staff_r:staff_t
Sep 27 11:32:50 cvs sshd[559]: setting tty /dev/pts/0 context to root:object_r:staff_devpts_t

# But it succeeds and the session is good and the connection works.
Sep 27 11:32:50 cvs ssh(pam_unix)[559]: session opened for user root by (uid=0)
Sep 27 11:32:50 cvs sshd[561]: setting security context to root:staff_r:staff_t

Has anyone a suggestion as to what is happening? There are no avc's at this point so
this looks like something deeper.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
