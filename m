Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDo0L9015661
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:50:00 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GDmcfs007881
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:48:42 GMT
Date: Wed, 16 Feb 2005 13:58:29 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216135829.GO31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <1108558817.19756.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108558817.19756.41.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:00:17AM -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 15:03, Luke Kenneth Casson Leighton wrote:
> >  leaving the restructuring issue aside for one moment, in order to
> >  minimise the amount of work involved, would it be reasonable to
> >  track the privilege-separated sshd (which is supposed to run in
> >  an unused user account) with an intermediate security context, using
> >  a dynamic context transition, if necessary, to get to it?
> 
> Note that there are several processes involved (based on the diagram):
> - the listening sshd
> - the parent monitor process
> - the unprivileged child for network processing

 i believe this is the one that i want to transition
 to sshd_priv_<rolename>_t with setcon().


> - the user privileged child for user request processing

 this is the one that has absolutely no networking access, therefore
 i cannot do any checks on the incoming IP address in this domain
 (<rolename>_t e.g. user_t) to restrict user access on a per-IP-address
 basis.


> Further, note the relationships among these processes (again, based on
> the diagram):
> - listening sshd forks parent monitor
> - parent monitor forks the unprivileged child
> - unprivileged child exports state back to the parent monitor and dies

 if the unprivileged child cannot communicate down the remote
 connection (because sshd_priv_<rolename>_t has banned access
 for that role to access anything but one specific IP address)
 then the job is done.

 ... hm, if the unprivileged child exports state back to the parent
 monitor, then in fact it's the parent monitor that i would need
 to have in sshd_monitor_<rolename>_t.

 hmmm...

> - parent monitor forks and exec's the user privileged child

 i don't intend to make any modifications to this part because
 it serves no purpose for the requirements [restricting remote user
 access on a per-IP address].

> Hence, dynamic context transitions to two different domains would be
> suitable for the parent monitor (e.g. sshd_monitor_t) and for the
> unprivileged child (e.g. sshd_unpriv_t).  The user privileged child will
> already run in its own domain (user_t or staff_t) due to the existing
> logic for setting the user security context upon the execve.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
