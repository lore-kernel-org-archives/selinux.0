Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GF2fL9016338
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 10:02:41 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GF1Mfs010713
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 15:01:23 GMT
Date: Wed, 16 Feb 2005 15:11:27 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216151127.GS31121@lkcl.net>
References: <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net> <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil> <20050216134457.GL31121@lkcl.net> <1108561176.19756.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108561176.19756.86.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:39:36AM -0500, Stephen Smalley wrote:
> On Wed, 2005-02-16 at 08:44, Luke Kenneth Casson Leighton wrote:
> >  out of curiosity: why?
> > 
> >  if it's specified in the policy, and there are permissions
> >  required for it to occur, what is the harm?
> 
> Because you have an application that has explicitly requested a context
> C1 but you are applying a different context C2 without its awareness. 

 i see what you mean: it's the fact that you are calling setcon()
 and it doesn't happen, something else happens

 it could be argued that the same thing happens with execve(), but
 i take the point that you're not actually calling something that
 says "set context NOW".

> Compare with file relabeling; we don't rewrite the context passed to
> setfilecon(3).  Or compare with setexeccon(3) - we don't rewrite the
> context passed to it.  That is different than applying a default context
> defined by policy when the application specified _no_ context for an
> execve or a file creation.
 
  okay, i get it.

> >  what rules must be placed in the policy such that
> >  security_compute_create will produce the desired results, for example:
> 
> It consults the type_transition rules in the policy.  It was named

 GREAT.

> >  if scon = "sshd_priv_t" and tcon = "user_t"
> >  [and tclass = SECCLASS_PROCESS?]
> > 
> >  and i want newcon to equal "sshd_priv_user_t" as a result of the call,
> > 
> >  what do i put in the policy to reflect this?
> 
> type_transition sshd_priv_t user_t:process sshd_priv_user_t;

 ah _ha_!

 thank you.


> But I'm still not clear on your usage, as these processes are not
> associated with a user.

 i believe one of my former messages (just 30mins ago) provides
 sufficient explanation.

 at the point at which do_authentication2() receives information
 about what username is to be used, i wish at THAT point to
 do a setcon() to sshd_priv_user_t, there and then.

 in order to stop any further unauthorised network traffic by
 that user.

 so i will put this:

	net_context 192.168.0.223 255.255.255.55 restricted_user_ip_t

 	allow restricted_user_1_ip_t:net_if sshd_priv_restricted_user_t 

 and consequently, if restricted_user isn't logging in from
 192.168.0.223, the sshd do_authentication2() function will be UNABLE
 to respond to any further authentication requests.

 i realise it's a bit dodgy, but it will do the job :)

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
