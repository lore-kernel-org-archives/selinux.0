Subject: Re: UNCLASSIFIED - Realtime Scheduling...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "HAWKER, Dan 2 (external)" <Dan.HAWKER@uk4.astrium.eads.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7F6B06837A5DBD49AC6E1650EFF5490601C64C1A@auk52177.ukr.astrium.corp>
References: 
	 <7F6B06837A5DBD49AC6E1650EFF5490601C64C1A@auk52177.ukr.astrium.corp>
Content-Type: text/plain
Date: Thu, 31 Jan 2008 13:28:10 -0500
Message-Id: <1201804090.4568.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-31 at 18:14 +0000, HAWKER, Dan 2 (external) wrote:
> 
> Hi All,
> 
> Am not 100% sure if this is completely an SELinux question, but am
> hoping the pool of knowledge will be able to help me out :)
> 
> I have an daemon that a developer has created, that I am creating an
> SELinux policy for. Works well and is easy enough, however it needs to
> run as non-root. Again this is not a problem, however it does two things
> that makes this a problem.
> 1) it changes the system time...
> 2) it generates threads that have edited SCHED_FIFO so as to gain
> realtime scheduling...
> 
> Presently (non-SELinux) both are implemented using standard internal
> calls to appropriate libraries (rather than external system calls or
> apps) and hence require root access.
> 
> Was wondering if there was an elegant solution (can think of inelegant
> ones) to this problem, by where I can use SELinux to grant the
> appropriate privileges to the un-modified (or slightly modified)
> daemon???
> 
> Obviously we could re-architect the daemon and get it to call another
> root enabled but heavily constrained (with SELinux) app to change the
> time, however by my understanding (but I am a sysadmin not a programmer
> type), that method isn't viable for the realtime scheduling problem.
> 
> So, is there a way with roles (or another way) that I can give the
> daemon the required privilege to set realtime scheduling with SELinux???
> 
> TIA

At present, SELinux acts as an orthogonal mechanism to Linux
discretionary controls, and thus you must be authorized by both Linux
DAC and by SELinux MAC checks to perform any operation.  So to invoke a
call that requires privilege (in Linux, "capability"), your program has
to at least start with uid 0 in addition to running in a SELinux domain
that is allowed the capability by policy.  The program can shed uid 0
upon startup while retaining certain capabilities; you can see an
example of that in newrole.  If your kernel supports file capabilities,
you could try using that instead of setuid 0.

We have previously proposed a patch to selinux that would allow it to
authoritatively grant a capability to a non-uid-0 process based on
policy (see mailing list archives), and we may proceed with that patch
to support that kind of need, but it isn't in any distro kernels today.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
