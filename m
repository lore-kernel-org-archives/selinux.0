Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDaJL9015459
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:36:19 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GDWiNj015330
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:32:45 GMT
Date: Wed, 16 Feb 2005 13:44:57 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, g@lkcl.net
Subject: Re: sshd transition points
Message-ID: <20050216134457.GL31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net> <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:10:25AM -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 19:04, Luke Kenneth Casson Leighton wrote:
> > ... isn't this a _lot_ simpler than pissing about creating hard-coded
> > security contexts, or fiddling around adding kludges into libselinux
> > to be able to create security contexts or read some pseudo-default?
> 
> Auto-magically changing the context passed in by the setcon(3) by the
> application considered harmful.  

 out of curiosity: why?

 if it's specified in the policy, and there are permissions
 required for it to occur, what is the harm?

 the only thing i can think of that is possibly harmful is
 that it's not linked to an executable.


> If the application wants such
> derivations, it calls security_compute_create() first, then calls
> setcon() on the result.
 
 ah _ha_ - so there is a programmatic way to do the same thing, without
 hard-coded messing about with modifying contexts.

 okay.
 
 _great_.

 so.

 what rules must be placed in the policy such that
 security_compute_create will produce the desired results, for example:

	/* Compute a labeling decision and set *newcon to refer to it.
	   Caller must free via freecon. */
	   extern int security_compute_create(security_context_t scon,
					security_context_t tcon,
					security_class_t tclass,
					security_context_t *newcon);

 if scon = "sshd_priv_t" and tcon = "user_t"
 [and tclass = SECCLASS_PROCESS?]

 and i want newcon to equal "sshd_priv_user_t" as a result of the call,

 what do i put in the policy to reflect this?

 should it be SECCLASS_PROCESS? 

 ta.

 l.
 
 


> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
