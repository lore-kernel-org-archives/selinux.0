Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GD8YL9015181
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:08:35 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050215200355.GB26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net>
Content-Type: text/plain
Message-Id: <1108558817.19756.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:00:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 15:03, Luke Kenneth Casson Leighton wrote:
>  leaving the restructuring issue aside for one moment, in order to
>  minimise the amount of work involved, would it be reasonable to
>  track the privilege-separated sshd (which is supposed to run in
>  an unused user account) with an intermediate security context, using
>  a dynamic context transition, if necessary, to get to it?

Note that there are several processes involved (based on the diagram):
- the listening sshd
- the parent monitor process
- the unprivileged child for network processing
- the user privileged child for user request processing

Further, note the relationships among these processes (again, based on
the diagram):
- listening sshd forks parent monitor
- parent monitor forks the unprivileged child
- unprivileged child exports state back to the parent monitor and dies
- parent monitor forks and exec's the user privileged child

Hence, dynamic context transitions to two different domains would be
suitable for the parent monitor (e.g. sshd_monitor_t) and for the
unprivileged child (e.g. sshd_unpriv_t).  The user privileged child will
already run in its own domain (user_t or staff_t) due to the existing
logic for setting the user security context upon the execve.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
