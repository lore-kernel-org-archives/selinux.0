Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FJt1L9010799
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 14:55:02 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FJpZw0014884
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 19:51:35 GMT
Date: Tue, 15 Feb 2005 20:03:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050215200355.GB26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 15, 2005 at 02:22:22PM -0500, Stephen Smalley wrote:

> >   what the _heck_ is that sshd doing still running as root, or
> >   more specifically, what's it doing still running under sshd_t?
> 
> Isn't this the normal privilege separation support in sshd, with the
> parent being the privileged monitor and the child as the user
> unprivileged process?  See
> http://www.citi.umich.edu/u/provos/ssh/privsep.html
 
 yes - it would look like it is.  thanks for the reference.

> >  unfortunately, then, as things stand, it's not possible to
> >  associate a security context with the "initial" fork - the
> >  one that holds the TCP connection.
> > 
> >  ... and what you are saying is that now that dynamic transitions
> >  are possible, it might be doable?
> 
> As previously discussed, SELinux used to only support exec-based context
> transitions, as that is the point where we can control inheritance of
> state and initialization of the process in the new context.  It has
> never supported context transitions upon fork.  Recently (again, as
> discussed on the list), support for dynamic context transitions via the
> new setcon(3) libselinux function was added, which would allow sshd to
> explicitly transition domains for the different processes without
> performing an exec.  But it would be better to restructure it instead to
> use exec-based transitions for better security...
 
 okay.

 leaving the restructuring issue aside for one moment, in order to
 minimise the amount of work involved, would it be reasonable to
 track the privilege-separated sshd (which is supposed to run in
 an unused user account) with an intermediate security context, using
 a dynamic context transition, if necessary, to get to it?

 e.g. sshd_privsep_$1_t so that in the macros sshd_privsep_user_t
 gets created, and in my case sshd_privset_restricted_user_t.

 and then granting only the necessary networking permissions to that
 intermediate domain, and granting _that_ domain the right to
 transition on an execve() / execution of a shell, rather than
 granting sshd_t the right to transition?

 in this way, i could then add networking contexts to
 sshd_privset_restricted_user_t that only allow the restricted user
 the rights to ssh in to the box from a specific IP address.

 reckon?

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
