Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDgOL9015543
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:42:25 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GDf7fs007570
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:41:07 GMT
Date: Wed, 16 Feb 2005 13:51:08 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216135108.GN31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215205728.GC26294@lkcl.net> <1108558973.19756.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108558973.19756.45.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:02:53AM -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 15:57, Luke Kenneth Casson Leighton wrote:
> >  and, sorry for asking a second question in this fashion, but
> >  if so, how would i derive the context which to dynamically
> >  transition to?
> > 
> >  i couldn't use get_default_context() ... or could i?
> > 
> >  it'd involve calling the new lovely setcon(), i know that.
> 
> At present, you can't use get_default_context() because it only returns
> contexts for which 'transition' permission has been allowed, not
> 'dyntransition'.  Whether or not we should change the internal logic
> (which ultimately goes down to the kernel's /selinux/user interface) to
> also return contexts for dynamic transitions or instead introduce a
> separate interface for this purpose is not clear.
 
 ah.

> Further, get_default_context() is only suitable when getting a default
> context for a user session.  

 yes.

 that's what i would like to do: create an ssh-specific user context
 from being already in sshd_priv_t and from user_t.


> In this case, you want domains for the
> monitor process and the unprivileged child process, neither of which are
> associated with a user.  

 ah, but because the unprivileged child process in this instance manages
 the networking, and because i wish to restrict users on a per-IP basis
 from being able to log in, i _do_ want to associate a user-specific
 domain with the unprivileged child process.

 even if it's for a few microseconds and it immediately transitions to
 something with even less privileges (again, using setcon).

	 sshd_priv_pre_auth_t -> sshd_priv_user_t -> sshd_priv_t

> Hence, I'd just pull them out of a config file.
 
 yuk :)

 
-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
